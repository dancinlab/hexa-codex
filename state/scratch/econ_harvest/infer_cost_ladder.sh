#!/bin/bash
# infer_cost (#5) — params-axis inference benchmark over the Qwen2.5 size ladder.
# Per rung: boot llama-server (M3 Metal, -np 1 -cb), measure prefill tok/s,
# decode tok/s, TTFT(ms), server peak RSS(MB). $0 local. macOS-safe.
set -u
GGUF_DIR=/Users/mini/Models/gguf
OUT=/Users/mini/dancinlab/hexa-codex/state/scratch/econ_harvest/infer_cost_ladder.tsv
PORT=8093
GEN_TOK=128
NREP=3
PROMPT_FILE=/tmp/econ_prompt.txt
BODY_FILE=/tmp/econ_body.json
python3 -c "print('The quick brown fox jumps over the lazy dog. '*60)" > "$PROMPT_FILE"
python3 - "$PROMPT_FILE" "$GEN_TOK" "$BODY_FILE" <<'PY'
import json,sys
prompt=open(sys.argv[1]).read(); gen=int(sys.argv[2]); out=sys.argv[3]
json.dump({"prompt":prompt,"n_predict":gen,"temperature":0.0}, open(out,"w"))
PY

killport(){ lsof -ti tcp:$PORT 2>/dev/null | xargs kill 2>/dev/null; sleep 1; }

declare -a ROWS
ROWS+=("params_B\tgguf\tprompt_n\tprefill_tok_s\tdecode_tok_s\tttft_ms\tpeak_rss_mb\tload_ms")

bench_rung(){
  local pB="$1"; local model="$2"
  [ -f "$model" ] || { echo "MISSING $model — skip ${pB}B" >&2; return 1; }
  echo ">>> rung ${pB}B: $(basename $model)" >&2
  killport
  local t0=$(python3 -c "import time;print(int(time.time()*1000))")
  llama-server -m "$model" --host 127.0.0.1 --port $PORT -np 1 -cb -c 2048 \
      -ngl 999 --no-webui > /tmp/srv_${pB}.log 2>&1 &
  local SRV=$!
  for i in $(seq 1 120); do
    curl -s -m 2 http://127.0.0.1:$PORT/health 2>/dev/null | grep -q '"status":"ok"' && break; sleep 1; done
  local t1=$(python3 -c "import time;print(int(time.time()*1000))")
  local load_ms=$((t1-t0))
  if ! curl -s -m 2 http://127.0.0.1:$PORT/health 2>/dev/null | grep -q ok; then
    echo "rung ${pB}B FAILED to boot" >&2; kill $SRV 2>/dev/null; killport; return 1; fi
  curl -s -m 60 http://127.0.0.1:$PORT/completion -d '{"prompt":"hi","n_predict":8}' >/dev/null 2>&1
  : > /tmp/timings_${pB}.jsonl
  local prss=0
  for r in $(seq 1 $NREP); do
    curl -s -m 180 http://127.0.0.1:$PORT/completion --data-binary @"$BODY_FILE" \
      2>/dev/null | python3 -c "import json,sys;d=json.loads(sys.stdin.read(),strict=False);t=d.get('timings',{});print(json.dumps({k:t.get(k) for k in ('prompt_per_second','predicted_per_second','prompt_ms','prompt_n')}))" >> /tmp/timings_${pB}.jsonl 2>/dev/null
    local rss=$(ps -o rss= -p $SRV 2>/dev/null | tr -d ' '); [ -n "$rss" ] && [ "$rss" -gt "$prss" ] && prss=$rss
  done
  kill $SRV 2>/dev/null; killport
  read apf adec attft pn < <(python3 -c "
import json
rows=[json.loads(l) for l in open('/tmp/timings_${pB}.jsonl') if l.strip()]
rows=[r for r in rows if r.get('prompt_per_second')]
import statistics as s
print(round(s.mean([r['prompt_per_second'] for r in rows]),2),
      round(s.mean([r['predicted_per_second'] for r in rows]),2),
      round(s.mean([r['prompt_ms'] for r in rows]),2),
      int(rows[0]['prompt_n']))
")
  local rss_mb=$(python3 -c "print(round($prss/1024,1))")
  ROWS+=("${pB}\t$(basename $model)\t${pn}\t${apf}\t${adec}\t${attft}\t${rss_mb}\t${load_ms}")
  echo "  ${pB}B: prefill ${apf} tok/s decode ${adec} tok/s ttft ${attft}ms rss ${rss_mb}MB" >&2
}

bench_rung 0.5 "$GGUF_DIR/Qwen2.5-0.5B-Instruct-Q4_K_M.gguf"
bench_rung 1.5 "$GGUF_DIR/Qwen2.5-1.5B-Instruct-Q4_K_M.gguf"
bench_rung 3.0 "$GGUF_DIR/Qwen2.5-3B-Instruct-Q4_K_M.gguf"
bench_rung 7.0 "$GGUF_DIR/Qwen2.5-7B-Instruct-Q4_K_M.gguf"

printf '%b\n' "${ROWS[@]}" > "$OUT"
echo "=== wrote $OUT ===" >&2
cat "$OUT"
