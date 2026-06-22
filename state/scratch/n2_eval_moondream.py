#!/usr/bin/env python3
"""n2 SUBSTRATE counting eval — moondream2 (custom HfMoondream arch).

moondream2 does NOT expose the transformers chat-template / processor route used by
n2_eval_counting.py. It ships its own remote `HfMoondream` (auto_map ->
AutoModelForCausalLM) with `model.query(image=PIL, question=str)["answer"]`, a
deterministic (greedy) sampler. We reuse the SAME manifest, the SAME images, the SAME
byte-exact integer scorer, and the SAME TSV/summary output format so the aggregator
treats this rung identically to the other families. NO LLM self-judge.

Usage: python3 n2_eval_moondream.py <hf_model_id> <family> <params_b> [--cpu]
"""
import os, sys, csv, re, time, argparse, json
from collections import defaultdict

OUT = os.path.expanduser("~/n2_counting")
PROMPT = "How many dots are in this image? Answer with a single integer."


def parse_int(text):
    m = re.search(r"-?\d+", text)
    return int(m.group()) if m else None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("model_id")
    ap.add_argument("family")
    ap.add_argument("params_b")
    ap.add_argument("--cpu", action="store_true")
    ap.add_argument("--limit", type=int, default=0)
    args = ap.parse_args()

    import torch
    from transformers import AutoModelForCausalLM
    from PIL import Image

    # transformers 5.8 robustness: the remote HfMoondream (model_type moondream1)
    # predates `all_tied_weights_keys` (a dict that _finalize_model_loading does
    # `.keys()` on). Provide it as an empty dict on the base class only if absent, so
    # the meta->device move treats nothing as tied (moondream ties no weights here).
    # This only touches load bookkeeping, not the forward pass / sampler.
    try:
        from transformers import PreTrainedModel
        if not hasattr(PreTrainedModel, "all_tied_weights_keys"):
            PreTrainedModel.all_tied_weights_keys = {}
    except Exception as _e:
        print(f"[shim] tied-weights shim skipped ({_e})", flush=True)

    t0 = time.time()
    print(f"[load] {args.model_id} cpu={args.cpu}", flush=True)
    kw = dict(trust_remote_code=True)
    if not args.cpu and torch.cuda.is_available():
        kw["device_map"] = {"": 0}
        kw["dtype"] = torch.bfloat16
    else:
        kw["dtype"] = torch.float32
    model = AutoModelForCausalLM.from_pretrained(args.model_id, **kw)
    model.eval()
    if args.cpu:
        model = model.to("cpu")
    print(f"[load] done in {time.time()-t0:.1f}s device={getattr(model,'device','?')}",
          flush=True)

    manifest = []
    with open(os.path.join(OUT, "manifest.tsv")) as f:
        for row in csv.DictReader(f, delimiter="\t"):
            manifest.append(row)
    if args.limit:
        manifest = manifest[:args.limit]

    rows = []
    for item in manifest:
        name = item["img"]
        n_exp = int(item["n_expected"])
        rng = item["range"]
        img = Image.open(os.path.join(OUT, "imgs", name + ".png")).convert("RGB")
        ts = time.time()
        with torch.no_grad():
            # temperature=0 -> argmax (greedy, deterministic) inside moondream's
            # sampler; byte-exact replay, and dodges the broken multinomial path.
            res = model.query(image=img, question=PROMPT,
                              settings={"temperature": 0.0, "max_tokens": 12})
        reply = (res["answer"] if isinstance(res, dict) else str(res)).strip()
        wall = int((time.time() - ts) * 1000)
        pred = parse_int(reply)
        correct = 1 if pred == n_exp else 0
        rows.append((args.family, args.params_b, name, n_exp, rng, correct,
                     pred if pred is not None else "",
                     reply.replace("\n", " ")[:40], wall))
        print(f"  {name} exp={n_exp} pred={pred} {'OK' if correct else 'X'} "
              f"[{reply[:24]!r}] {wall}ms", flush=True)

    outtsv = os.path.join(OUT, f"out_{args.family}_{args.params_b}.tsv")
    with open(outtsv, "w", newline="") as f:
        w = csv.writer(f, delimiter="\t")
        w.writerow(["family", "params_b", "img", "n_expected", "range",
                    "correct", "pred", "reply", "wall_ms"])
        w.writerows(rows)

    agg = defaultdict(lambda: [0, 0])
    for r in rows:
        rng = r[4]; c = r[5]
        agg[rng][0] += c; agg[rng][1] += 1
        agg["ALL"][0] += c; agg["ALL"][1] += 1
    print("\n=== SUMMARY", args.family, args.params_b, "===")
    for rng in ["subitizing", "counting", "dense", "ALL"]:
        if rng in agg:
            ok, tot = agg[rng]
            print(f"  {rng:11s} {ok}/{tot} = {ok/tot:.4f}")
    summary = {"family": args.family, "params_b": args.params_b,
               "ranges": {k: agg[k] for k in agg}}
    print("JSON_SUMMARY " + json.dumps(summary), flush=True)
    print("wrote", outtsv, flush=True)


if __name__ == "__main__":
    main()
