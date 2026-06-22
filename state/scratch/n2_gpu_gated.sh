#!/usr/bin/env bash
# Wait for >=NEED MiB free GPU on summer (shared host: abfe holds ~4.5GB, edge jobs
# cycle 0-2.5GB), then fire one 4-bit GPU eval. Retries on CUDA OOM up to MAXTRY.
# Usage: n2_gpu_gated.sh <family> <params_b> <hf_id> <need_mib>
set -u
cd ~
FAM="$1"; PB="$2"; MID="$3"; NEED="${4:-6000}"
LOG=~/n2_counting/run_${FAM}_${PB}.log
MAXTRY=40
export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True

for try in $(seq 1 $MAXTRY); do
  # wait until enough GPU is free
  for w in $(seq 1 120); do
    FREE=$(nvidia-smi --query-gpu=memory.free --format=csv,noheader,nounits)
    [ "$FREE" -ge "$NEED" ] && break
    sleep 30
  done
  FREE=$(nvidia-smi --query-gpu=memory.free --format=csv,noheader,nounits)
  echo "=== [$FAM $PB] try $try: gpu_free=${FREE}MiB (need $NEED) $(date +%H:%M:%S) ===" >>"$LOG"
  python3 n2_eval_counting.py "$MID" "$FAM" "$PB" --4bit --device cuda >>"$LOG" 2>&1
  if grep -q "JSON_SUMMARY" "$LOG"; then
    echo "[$FAM $PB] GPU OK try $try"
    exit 0
  fi
  if grep -q "OutOfMemory" "$LOG"; then
    echo "[$FAM $PB] OOM on try $try (free was ${FREE}MiB); waiting for more headroom" >>"$LOG"
    sleep 60
    continue
  fi
  echo "[$FAM $PB] NON-OOM FAILURE try $try — aborting"; exit 1
done
echo "[$FAM $PB] EXHAUSTED $MAXTRY tries"; exit 1
