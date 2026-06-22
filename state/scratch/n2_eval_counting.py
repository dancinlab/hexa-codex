#!/usr/bin/env python3
"""n2 SUBSTRATE counting eval — run ONE HF VL model over the dot images.

Usage:
  python3 n2_eval_counting.py <hf_model_id> <family> <params_b> [--4bit] [--cpu] [--device cuda]

Greedy decode (do_sample=False), max_new_tokens=12. Byte-exact integer scorer:
extract the FIRST integer token from the model's reply, compare == n_expected.
NO LLM self-judge. Emits TSV rows to ~/n2_counting/out_<family>_<params>.tsv and
prints a per-range accuracy summary block (parsed by the aggregator).

Prompt: "How many dots are in this image? Answer with a single integer."

transformers 5.8 robustness: AutoProcessor can trip on a None video sub-processor
(InternVL3-hf) or an old preprocessor_config without image_processor_type
(SmolVLM-Instruct). We fall back to building image_processor + tokenizer and
constructing the model's declared processor class directly.
"""
import os, sys, csv, re, time, argparse, json

OUT = os.path.expanduser("~/n2_counting")
PROMPT = "How many dots are in this image? Answer with a single integer."


def parse_int(text):
    m = re.search(r"-?\d+", text)
    return int(m.group()) if m else None


def build_processor(model_id):
    """Robustly build a processor across transformers 5.8 family quirks."""
    from transformers import AutoProcessor
    try:
        return AutoProcessor.from_pretrained(model_id, trust_remote_code=True)
    except Exception as e1:
        print(f"[proc] AutoProcessor failed ({type(e1).__name__}: {str(e1)[:90]})",
              flush=True)
    try:
        return AutoProcessor.from_pretrained(model_id, trust_remote_code=True,
                                             use_fast=True)
    except Exception as e2:
        print(f"[proc] use_fast failed ({type(e2).__name__}: {str(e2)[:90]}); "
              f"constructing declared processor class directly", flush=True)
    # Last resort: build the declared processor class from image_processor + tokenizer
    # (+ video_processor when the class requires it — transformers 5.8 made
    # video_processor a REQUIRED arg for SmolVLM/InternVL, which is the exact None the
    # AutoProcessor video-lookup trips on).
    from transformers import (AutoImageProcessor, AutoTokenizer, AutoConfig,
                              AutoVideoProcessor)
    import transformers as T
    imgp = AutoImageProcessor.from_pretrained(model_id, trust_remote_code=True,
                                              use_fast=True)
    tok = AutoTokenizer.from_pretrained(model_id, trust_remote_code=True)
    vidp = None
    try:
        vidp = AutoVideoProcessor.from_pretrained(model_id, trust_remote_code=True)
    except Exception as ev:
        print(f"[proc] no video processor ({type(ev).__name__})", flush=True)
    # find the processor class name from processor_config / preprocessor_config
    proc_cls_name = None
    import json as _j
    for fn in ("processor_config.json", "preprocessor_config.json"):
        p = os.path.join(_resolve(model_id), fn)
        if os.path.exists(p):
            with open(p) as f:
                d = _j.load(f)
            proc_cls_name = d.get("processor_class") or proc_cls_name
    if proc_cls_name and hasattr(T, proc_cls_name):
        cls = getattr(T, proc_cls_name)
        for kwargs in ({"image_processor": imgp, "tokenizer": tok,
                        "video_processor": vidp},
                       {"image_processor": imgp, "tokenizer": tok}):
            try:
                return cls(**kwargs)
            except Exception as e3:
                last = e3
        print(f"[proc] {proc_cls_name} ctor failed ({type(last).__name__}: "
              f"{str(last)[:80]})", flush=True)
    raise RuntimeError(f"could not build a processor for {model_id}")


def _resolve(model_id):
    """Local snapshot dir for a hub id (already downloaded)."""
    from huggingface_hub import snapshot_download
    return snapshot_download(model_id, local_files_only=True)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("model_id")
    ap.add_argument("family")
    ap.add_argument("params_b")
    ap.add_argument("--4bit", dest="fourbit", action="store_true")
    ap.add_argument("--cpu", action="store_true")
    ap.add_argument("--device", default="cuda")
    ap.add_argument("--dtype", default="bfloat16")
    ap.add_argument("--limit", type=int, default=0)
    ap.add_argument("--automap", action="store_true",
                    help="4-bit device_map=auto with a GPU mem cap; spill to CPU RAM")
    ap.add_argument("--gpu-gib", default="3", help="max GPU GiB for --automap")
    ap.add_argument("--causal-lm", action="store_true",
                    help="load via AutoModelForCausalLM (Phi-3-V style custom arch)")
    ap.add_argument("--image-tag", default="",
                    help="prompt image placeholder, e.g. '<|image_1|>' for Phi-3-V")
    args = ap.parse_args()

    import torch
    if args.causal_lm:
        from transformers import AutoModelForCausalLM as _ModelCls
        # Phi-3-V remote code reads past_key_values.seen_tokens, removed in
        # transformers 5.8. Shim it onto DynamicCache so the KV-cache stays ENABLED
        # (use_cache=False is ~1000x slower with these models).
        try:
            from transformers.cache_utils import DynamicCache
            if not hasattr(DynamicCache, "seen_tokens"):
                DynamicCache.seen_tokens = property(
                    lambda self: self.get_seq_length())
            if not hasattr(DynamicCache, "get_max_length"):
                def _get_max_length(self):
                    fn = getattr(self, "get_max_cache_shape", None)
                    return fn() if fn else None
                DynamicCache.get_max_length = _get_max_length
            if not hasattr(DynamicCache, "get_usable_length"):
                def _get_usable_length(self, new_seq_length, layer_idx=0):
                    return self.get_seq_length(layer_idx)
                DynamicCache.get_usable_length = _get_usable_length
        except Exception as _e:
            print(f"[shim] DynamicCache shim skipped ({_e})", flush=True)
    else:
        from transformers import AutoModelForImageTextToText as _ModelCls
    from PIL import Image

    dtype = {"bfloat16": torch.bfloat16, "float16": torch.float16,
             "float32": torch.float32}[args.dtype]

    kw = dict()
    if args.automap:
        from transformers import BitsAndBytesConfig
        kw["quantization_config"] = BitsAndBytesConfig(
            load_in_4bit=True, bnb_4bit_compute_dtype=torch.bfloat16,
            bnb_4bit_quant_type="nf4", bnb_4bit_use_double_quant=True,
            llm_int8_enable_fp32_cpu_offload=True)
        kw["device_map"] = "auto"
        kw["max_memory"] = {0: f"{args.gpu_gib}GiB", "cpu": "20GiB"}
        kw["dtype"] = torch.bfloat16
    elif args.fourbit and not args.cpu:
        from transformers import BitsAndBytesConfig
        kw["quantization_config"] = BitsAndBytesConfig(
            load_in_4bit=True, bnb_4bit_compute_dtype=torch.bfloat16,
            bnb_4bit_quant_type="nf4", bnb_4bit_use_double_quant=True)
        kw["device_map"] = {"": 0}
        kw["dtype"] = torch.bfloat16
    elif args.cpu:
        # default fp32 on CPU; --dtype bfloat16 halves RAM for 7-8B rungs (slower matmul)
        kw["dtype"] = dtype if args.dtype != "float32" else torch.float32
    else:
        kw["device_map"] = {"": 0}
        kw["dtype"] = dtype

    t0 = time.time()
    print(f"[load] {args.model_id} dtype={args.dtype} 4bit={args.fourbit} cpu={args.cpu}",
          flush=True)
    proc = build_processor(args.model_id)
    if args.causal_lm:
        kw.setdefault("_attn_implementation", "eager")
    model = _ModelCls.from_pretrained(
        args.model_id, trust_remote_code=True, **kw)
    model.eval()
    if args.cpu:
        model = model.to("cpu")
    print(f"[load] done in {time.time()-t0:.1f}s device={model.device}", flush=True)

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
        inputs = None
        if args.image_tag:
            # Phi-3-V style: image placeholder is a literal text tag; build chat with
            # the model's tokenizer template, then call processor(text, images).
            msgs = [{"role": "user", "content": args.image_tag + "\n" + PROMPT}]
            try:
                chat = proc.tokenizer.apply_chat_template(
                    msgs, tokenize=False, add_generation_prompt=True)
            except Exception:
                chat = args.image_tag + "\n" + PROMPT
            inputs = proc(text=chat, images=[img], return_tensors="pt")
        else:
            messages = [{"role": "user", "content": [
                {"type": "image"},
                {"type": "text", "text": PROMPT}]}]
            # Prefer apply_chat_template(..., tokenize=True); fall back to text+images.
            try:
                inputs = proc.apply_chat_template(
                    messages, add_generation_prompt=True, tokenize=True,
                    return_dict=True, return_tensors="pt", images=[img])
            except Exception:
                try:
                    chat = proc.apply_chat_template(messages, add_generation_prompt=True)
                except Exception:
                    chat = PROMPT
                inputs = proc(text=chat, images=[img], return_tensors="pt")
        in_dev = getattr(model, "_in_dev", None)
        if in_dev is None:
            try:
                in_dev = model.get_input_embeddings().weight.device
            except Exception:
                in_dev = model.device
            model._in_dev = in_dev
        inputs = {k: (v.to(in_dev) if hasattr(v, "to") else v)
                  for k, v in inputs.items()}
        ilen = inputs["input_ids"].shape[1]
        ts = time.time()
        gen_kw = dict(max_new_tokens=12, do_sample=False, num_beams=1)
        with torch.no_grad():
            out = model.generate(**inputs, **gen_kw)
        gen = out[0][ilen:]
        reply = proc.decode(gen, skip_special_tokens=True).strip() \
            if hasattr(proc, "decode") else \
            proc.tokenizer.decode(gen, skip_special_tokens=True).strip()
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

    from collections import defaultdict
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
