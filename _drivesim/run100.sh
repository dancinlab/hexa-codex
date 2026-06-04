#!/usr/bin/env bash
# Full 100-scenario orchestrator for the DRIVE RAG test.
#   1. (re)boot llama-server on :8099 with 4 slots (-np 4) so 4 drives run parallel
#   2. fan out 4 shards (1-25 / 26-50 / 51-75 / 76-100) of run.sh
#   3. aggregate pass/fail; retry failures up to 2x (independent re-draws absorb
#      the local-model + boot-race flakiness)
# Usage: run100.sh
set -u
ROOT="/Users/mini/dancinlab/hexa-codex/_drivesim"
MODEL="$HOME/Models/gguf/supergemma4-e4b-abliterated-Q4_K_M.gguf"
cd "$ROOT"

echo "=== 1. reboot llama-server with -np 4 ==="
pkill -f 'llama-server.*8099' 2>/dev/null; sleep 2
nohup llama-server -m "$MODEL" --host 127.0.0.1 --port 8099 -np 4 -c 16384 \
  > /tmp/drive-llama-server.log 2>&1 &
for i in $(seq 1 60); do
  curl -s -m2 http://127.0.0.1:8099/health 2>/dev/null | grep -q '"status":"ok"' && { echo "  server READY (4 slots) after ${i}x2s"; break; }
  [ $i -eq 60 ] && { echo "  server FAILED to boot"; exit 1; }
  sleep 2
done

echo "=== 2. fan out 4 shards (parallel) ==="
for sh in "1 25" "26 50" "51 75" "76 100"; do
  set -- $sh
  nohup bash run.sh $1 $2 > "/tmp/shard_${1}.log" 2>&1 &
  echo "  shard [$1-$2] PID=$!"
done
wait
echo "=== 3. shards done — aggregate ==="
cat /tmp/shard_1.log /tmp/shard_26.log /tmp/shard_51.log /tmp/shard_76.log 2>/dev/null \
  | sed 's/\x1b\[[0-9;]*m//g' > /tmp/run100_all.log
P=$(grep -cE '  PASS ' /tmp/run100_all.log); F=$(grep -cE '  FAIL ' /tmp/run100_all.log)
echo "  PASS=$P FAIL=$F / 100"
grep -E '  FAIL ' /tmp/run100_all.log | awk '{print $1}' | tr '\n' ' ' > /tmp/run100_fails.txt
echo "  fails: $(cat /tmp/run100_fails.txt)"
echo "RUN100-COMPLETE PASS=$P FAIL=$F"
