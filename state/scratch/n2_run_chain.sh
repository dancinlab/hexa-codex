#!/usr/bin/env bash
# Serialized n2 counting-eval runner. Tries GPU 4-bit; on CUDA OOM / failure falls
# back to CPU bf16. One model at a time so each fits the constrained shared GPU.
# Usage: bash n2_run_chain.sh <family> <params_b> <hf_id>   (one model per invocation)
set -u
cd ~
FAM="$1"; PB="$2"; MID="$3"
LOG=~/n2_counting/run_${FAM}_${PB}.log
OUT=~/n2_counting/out_${FAM}_${PB}.tsv

echo "=== [$FAM $PB] GPU 4-bit attempt $(date +%H:%M:%S) ===" >"$LOG"
python3 n2_eval_counting.py "$MID" "$FAM" "$PB" --4bit --device cuda >>"$LOG" 2>&1
if grep -q "JSON_SUMMARY" "$LOG"; then
  echo "[$FAM $PB] GPU OK"
  exit 0
fi
echo "=== [$FAM $PB] GPU failed; CPU bf16 fallback $(date +%H:%M:%S) ===" >>"$LOG"
python3 n2_eval_counting.py "$MID" "$FAM" "$PB" --cpu --dtype bfloat16 >>"$LOG" 2>&1
if grep -q "JSON_SUMMARY" "$LOG"; then
  echo "[$FAM $PB] CPU bf16 OK"
  exit 0
fi
echo "[$FAM $PB] BOTH FAILED — see $LOG"
exit 1
