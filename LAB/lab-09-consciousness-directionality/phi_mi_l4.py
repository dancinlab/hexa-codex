#!/usr/bin/env python3
# LAB-09 L4 TIER — residual-stream LM-objective finetune of REC vs FF adapters.
# Authored/owned by phi_llm_l4_harness.hexa which writes this file under /tmp and
# execs it. Committed artifact = the .hexa + result TSV/summary/verdict + a
# provenance copy of this .py. Pure-local, $0, frozen base (rollback-safe), seeded.
#
# Arms (all share Qwen2.5-1.5B frozen base, layer 14, K=6 Phi engine):
#   CAUSAL_frozen : no adapter, frozen base. Reference Phi + ppl.
#   REC_lm        : GRUCell adapter injected at layer-14 residual, LM-finetuned.
#   FF_lm         : param-matched feedforward adapter, same injection + LM finetune.
# Phi-proxy = I(S_t;S_{t+1}) - min_bipartition[I(A)+I(B)] over K median-split
#   channels (whole_EI minus min bipartition) — SAME family as smoke + stress.
import os, sys, math, json, time, itertools, random
import numpy as np

os.environ.setdefault("HF_HUB_OFFLINE", "1")
os.environ.setdefault("TRANSFORMERS_OFFLINE", "1")
os.environ.setdefault("TOKENIZERS_PARALLELISM", "false")

SEED = 42
random.seed(SEED); np.random.seed(SEED)
import torch
torch.manual_seed(SEED)
torch.use_deterministic_algorithms(False)

MODEL = os.environ.get("LAB09_MODEL", "Qwen/Qwen2.5-1.5B")
LAYER = int(os.environ.get("LAB09_LAYER", "14"))   # inject + capture layer (of 28)
K     = int(os.environ.get("LAB09_K", "6"))        # channels for Phi bipartition search
ADIM  = int(os.environ.get("LAB09_ADIM", "16"))    # adapter bottleneck width
STEPS = int(os.environ.get("LAB09_STEPS", "80"))   # LM-objective finetune steps
LR    = float(os.environ.get("LAB09_LR", "0.01"))
SEEDS = [int(x) for x in os.environ.get("LAB09_SEEDS", "42,43,44").split(",")]
OUT   = os.environ.get("LAB09_OUT", "/tmp/lab09_l4")
DEV   = "mps" if torch.backends.mps.is_available() else "cpu"

# Fixed corpus (provenance: hand-written neutral English prose, deterministic) —
# IDENTICAL to the stress tier for cross-tier comparability.
CORPUS = [
    "The river flows quietly past the old stone bridge at dawn.",
    "She opened the book and began to read the first chapter slowly.",
    "A small bird landed on the windowsill and looked inside the room.",
    "The engineers tested the new bridge before the morning traffic arrived.",
    "Light from the lamp fell softly across the wooden desk and papers.",
    "He remembered the summer when the whole family traveled to the coast.",
    "The machine learned to predict the next word from the previous ones.",
    "Children played in the park while their parents talked near the gate.",
]

# ---- Phi engine (verbatim from stress tier; deterministic plug-in MI) --------
def discretize(series):
    med = np.median(series, axis=0, keepdims=True)
    return (series > med).astype(np.int64)

def _mi_from_pairs(a, b):
    T = len(a)
    ua = {v: i for i, v in enumerate(sorted(set(a.tolist())))}
    ub = {v: i for i, v in enumerate(sorted(set(b.tolist())))}
    na, nb = len(ua), len(ub)
    j = np.zeros((na, nb), dtype=np.float64)
    for x, y in zip(a, b):
        j[ua[int(x)], ub[int(y)]] += 1.0
    j /= T
    pr = j.sum(1, keepdims=True); pc = j.sum(0, keepdims=True)
    nz = j > 0
    mi = np.sum(j[nz] * (np.log2(j[nz]) - np.log2((pr @ pc)[nz])))
    return float(mi)

def _codes(binseries, cols):
    sub = binseries[:, cols]
    w = (1 << np.arange(sub.shape[1]))
    return (sub * w).sum(1)

def phi_proxy(binseries):
    T = binseries.shape[0]
    St  = binseries[:-1]; Stp = binseries[1:]
    allc = list(range(K))
    whole = _mi_from_pairs(_codes(St, allc), _codes(Stp, allc))
    best = float("inf")
    for r in range(1, K):
        for A in itertools.combinations(range(1, K), r - 1):
            A = (0,) + A
            B = tuple(c for c in allc if c not in A)
            if not B:
                continue
            s = _mi_from_pairs(_codes(St, A), _codes(Stp, A)) + \
                _mi_from_pairs(_codes(St, B), _codes(Stp, B))
            if s < best:
                best = s
    return whole - best, whole, best, whole

def topk_channels(H, k):
    return np.argsort(-H.var(axis=0))[:k]

# ---- model -------------------------------------------------------------------
def load_model():
    from transformers import AutoModelForCausalLM, AutoTokenizer
    tok = AutoTokenizer.from_pretrained(MODEL)
    if tok.pad_token is None:
        tok.pad_token = tok.eos_token
    m = AutoModelForCausalLM.from_pretrained(MODEL, torch_dtype=torch.float32,
                                             output_hidden_states=True)
    m.eval()
    for p in m.parameters():
        p.requires_grad_(False)
    return tok, m.to(DEV)

# ---- adapter: REC(GRUCell) vs FF(3 linears), param-matched (stress scheme) ----
class Adapter(torch.nn.Module):
    def __init__(self, H, adim, recurrent):
        super().__init__()
        self.recurrent = recurrent
        self.proj_in = torch.nn.Linear(H, adim)
        self.proj_out = torch.nn.Linear(adim, H)
        if recurrent:
            self.core = torch.nn.GRUCell(adim, adim)
        else:
            self.core = torch.nn.ModuleList([torch.nn.Linear(adim, adim) for _ in range(3)])
        # LoRA-style: zero-init the up-projection so step-0 contribution == 0
        torch.nn.init.zeros_(self.proj_out.weight); torch.nn.init.zeros_(self.proj_out.bias)
    def forward(self, h):                      # h: (B,T,H)
        z = self.proj_in(h)                    # (B,T,adim)
        if self.recurrent:
            B, T, A = z.shape
            ht = torch.zeros(B, A, device=z.device, dtype=z.dtype)
            outs = []
            for t in range(T):
                ht = self.core(z[:, t, :], ht)        # feedback: h_t <- h_{t-1}
                outs.append(ht)
            s = torch.stack(outs, dim=1)              # (B,T,adim)
        else:
            a = torch.relu(self.core[0](z))
            a = torch.relu(self.core[1](a))
            s = self.core[2](a)                       # purely feedforward of z
        return self.proj_out(s)                       # (B,T,H) residual delta

def _layer_module(m):
    return m.model.layers[LAYER]

def make_hook(adapter, capture_list=None):
    # forward hook on a Qwen2DecoderLayer. Under transformers 5.x the layer output
    # is a plain Tensor (B,T,H); under 4.x it was a tuple. Handle both.
    def hook(mod, args, output):
        if isinstance(output, tuple):
            h = output[0]; new = h + adapter(h)
            if capture_list is not None:
                capture_list.append(new.detach().float().cpu().numpy()[0])
            return (new,) + tuple(output[1:])
        h = output; new = h + adapter(h)
        if capture_list is not None:
            capture_list.append(new.detach().float().cpu().numpy()[0])
        return new
    return hook

def batch_encode(tok):
    enc = tok(CORPUS, return_tensors="pt", padding=True)
    ids = enc["input_ids"].to(DEV); am = enc["attention_mask"].to(DEV)
    labels = ids.clone(); labels[am == 0] = -100
    return ids, am, labels

def train_adapter_lm(tok, m, recurrent, seed):
    # Inject adapter at layer-14 residual; train on LM CE (labels), base frozen.
    torch.manual_seed(seed); np.random.seed(seed)
    H = m.config.hidden_size
    ad = Adapter(H, ADIM, recurrent).to(DEV)
    npar = sum(p.numel() for p in ad.parameters())
    handle = _layer_module(m).register_forward_hook(make_hook(ad))
    ids, am, labels = batch_encode(tok)
    opt = torch.optim.Adam(ad.parameters(), lr=LR)
    last = float("nan")
    for s in range(STEPS):
        opt.zero_grad()
        out = m(input_ids=ids, attention_mask=am, labels=labels)
        out.loss.backward(); opt.step()
        last = float(out.loss.item())
    handle.remove()
    return ad, npar, last

def capture(tok, m, adapter):
    # per-sentence forward (batch=1, no padding) with adapter hook ACTIVE; capture
    # the adapter-modified layer-14 residual + next-token perplexity. adapter=None
    # => frozen reference (no hook).
    caps = [] if adapter is not None else None
    handle = _layer_module(m).register_forward_hook(make_hook(adapter, caps)) if adapter is not None else None
    hids = []; nll_sum = 0.0; ntok = 0
    for text in CORPUS:
        enc = tok(text, return_tensors="pt")
        ids = enc["input_ids"].to(DEV); Tn = ids.shape[1]
        with torch.no_grad():
            out = m(input_ids=ids, labels=ids)
            nll_sum += float(out.loss.item()) * (Tn - 1); ntok += (Tn - 1)
            if adapter is None:
                hids.append(out.hidden_states[LAYER][0].float().cpu().numpy())
    if adapter is not None:
        handle.remove(); hids = caps
    Hm = np.concatenate(hids, axis=0).astype(np.float32)
    ppl = math.exp(nll_sum / max(ntok, 1))
    return Hm, ppl

def phi_of(H):
    b = discretize(H[:, topk_channels(H, K)])
    phi, whole, parts, slf = phi_proxy(b)
    return phi, slf

def adapter_band(tok, m, recurrent):
    phis, selfs, ppls, losses, npar = [], [], [], [], None
    for sd in SEEDS:
        ad, npar, loss = train_adapter_lm(tok, m, recurrent, sd)
        Hm, ppl = capture(tok, m, ad)
        phi, slf = phi_of(Hm)
        phis.append(phi); selfs.append(slf); ppls.append(ppl); losses.append(loss)
    return dict(phi=float(np.mean(phis)), phi_sd=float(np.std(phis)),
                phi_min=float(np.min(phis)), phi_max=float(np.max(phis)),
                self_pred=float(np.mean(selfs)), ppl=float(np.mean(ppls)),
                fit_loss=float(np.mean(losses)), n_params=npar, seeds=SEEDS,
                phi_all=[float(x) for x in phis], ppl_all=[float(x) for x in ppls])

def main():
    t0 = time.time()
    tok, m = load_model()
    res = {}
    # 1) CAUSAL frozen reference (no adapter)
    Hc, ppl_c = capture(tok, m, None)
    phi_c, self_c = phi_of(Hc)
    res["CAUSAL_frozen"] = dict(phi=phi_c, self_pred=self_c, ppl=ppl_c, n=int(Hc.shape[0]))
    # 2) REC and FF, residual-injected + LM-finetuned, multi-seed band
    res["REC_lm"] = adapter_band(tok, m, True)
    res["FF_lm"]  = adapter_band(tok, m, False)
    meta = dict(model=MODEL, layer=LAYER, n_layers=m.config.num_hidden_layers,
                hidden=m.config.hidden_size, K=K, adim=ADIM, steps=STEPS, lr=LR,
                device=DEV, corpus_lines=len(CORPUS), seed=SEED, seeds=SEEDS,
                rec_params=res["REC_lm"]["n_params"], ff_params=res["FF_lm"]["n_params"],
                runtime_s=round(time.time() - t0, 2))
    out = dict(meta=meta, arms=res)
    with open(os.path.join(OUT, "phi_llm_l4.json"), "w") as f:
        json.dump(out, f, indent=2)
    print(json.dumps(out, indent=2))

if __name__ == "__main__":
    main()

