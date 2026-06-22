#!/bin/bash
# closed-loop solo mu: one serial worker, 1 in-flight, n_predict=16, seed=42, for DUR seconds
PORT=$1; DUR=${2:-15}
body='{"prompt":"Explain queueing theory in one sentence.","n_predict":16,"seed":42,"temperature":0.0,"cache_prompt":false}'
end=$(( $(date +%s) + DUR )); n=0
while [ $(date +%s) -lt $end ]; do
  code=$(curl -s -o /dev/null -w "%{http_code}" -m 30 -X POST "http://127.0.0.1:$PORT/completion" -H 'Content-Type: application/json' -d "$body")
  [ "$code" = "200" ] && n=$((n+1))
done
awk -v n=$n -v d=$DUR 'BEGIN{printf "port=%s done=%d dur=%d mu=%.3f req/s\n","'$PORT'",n,d,n/d}'
