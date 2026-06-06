#!/usr/bin/env python3
"""AWQ 4-bit quantization of dancinlab/qwen2.5-32b-uncensored.

Source : prebaked fp16 on network volume fs32qct4iv (US-MD-1) — env SRC
Output : AWQ-GEMM 4bit / group_size 128 — env OUT (~18GB)

The abliterate(refusal-removed) x quantization interaction is unverified (handoff
840c8e90). This script only quantizes; smoke_uncensored.py is the gate that proves
the refusal-removal survived.
"""
import os
import time
import json

from awq import AutoAWQForCausalLM
from transformers import AutoTokenizer

SRC = os.environ.get("SRC", "/workspace/model")
OUT = os.environ.get("OUT", "/workspace/awq-out")

# w4 / group 128 / GEMM is the canonical AWQ config — best vLLM kernel coverage.
QUANT_CONFIG = {"zero_point": True, "q_group_size": 128, "w_bit": 4, "version": "GEMM"}

os.makedirs(OUT, exist_ok=True)
t0 = time.time()

print(f"[quant] loading tokenizer from {SRC}", flush=True)
tok = AutoTokenizer.from_pretrained(SRC, trust_remote_code=True)

print(f"[quant] loading fp16 model from {SRC}", flush=True)
model = AutoAWQForCausalLM.from_pretrained(
    SRC, safetensors=True, device_map="auto", trust_remote_code=True,
)

print(f"[quant] quantizing {QUANT_CONFIG}", flush=True)
# Default calibration = mit-han-lab/pile-val-backup (neutral). Abliteration lives
# in the weights, not the calibration distribution, so a neutral calib set is the
# standard choice; the smoke test verifies it did not re-introduce refusals.
model.quantize(tok, quant_config=QUANT_CONFIG)

print(f"[quant] saving quantized model to {OUT}", flush=True)
model.save_quantized(OUT)
tok.save_pretrained(OUT)

dt = time.time() - t0
size_gb = sum(
    os.path.getsize(os.path.join(OUT, f)) for f in os.listdir(OUT)
) / 1e9
summary = {
    "src": SRC,
    "out": OUT,
    "quant_config": QUANT_CONFIG,
    "out_size_gb": round(size_gb, 2),
    "elapsed_sec": round(dt, 1),
}
with open(os.path.join(OUT, "quant_summary.json"), "w") as fh:
    json.dump(summary, fh, indent=2)
print(f"[quant] DONE {json.dumps(summary)}", flush=True)
print("__QUANT_AWQ_DONE__", flush=True)
