#!/usr/bin/env bash
# CPU bf16 serialized chain for the remaining n2 counting rungs. Sidesteps the
# heavily-contended shared GPU (abfe ~8.5GB). One model at a time; bf16 halves RAM,
# 7-8B spill to swap. Each model ~20-40 min on CPU.
set -u
cd ~
run() {  # family params hf_id [extra flags...]
  local FAM="$1" PB="$2" MID="$3"; shift 3
  local LOG=~/n2_counting/run_${FAM}_${PB}.log
  echo "=== [$FAM $PB] CPU bf16 $(date +%H:%M:%S) ===" >"$LOG"
  python3 n2_eval_counting.py "$MID" "$FAM" "$PB" --cpu --dtype bfloat16 "$@" >>"$LOG" 2>&1
  if grep -q JSON_SUMMARY "$LOG"; then echo "[$FAM $PB] CPU OK"; else echo "[$FAM $PB] FAILED"; fi
}

run phi35v   4.2 microsoft/Phi-3.5-vision-instruct --causal-lm --image-tag '<|image_1|>'
run qwen25vl 7.0 Qwen/Qwen2.5-VL-7B-Instruct
run internvl3 8.0 OpenGVLab/InternVL3-8B-hf
run llavanext 7.0 llava-hf/llava-v1.6-mistral-7b-hf
echo ALL_N2_CPU_DONE
