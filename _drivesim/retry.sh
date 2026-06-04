#!/usr/bin/env bash
# Re-run specific scenarios by id (sNNN ...) up to N attempts each, until each
# passes. Usage: retry.sh <attempts> s001 s015 ...
set -u
ROOT="/Users/mini/dancinlab/hexa-codex/_drivesim"
ATTEMPTS=${1:-3}; shift
STILL=()
for id in "$@"; do
  idx=$((10#${id#s}))   # s001 -> 1
  ok=0
  for ((a=1; a<=ATTEMPTS; a++)); do
    out=$(bash "$ROOT/run.sh" "$idx" "$idx" 2>&1 | sed 's/\x1b\[[0-9;]*m//g')
    if printf '%s' "$out" | grep -q "PASS"; then
      echo "$id  PASS (attempt $a)"; ok=1; break
    else
      echo "$id  fail (attempt $a) :: $(printf '%s' "$out" | grep -E 'FAIL' | sed 's/.*FAIL//' | cut -c1-70)"
    fi
  done
  [ $ok -eq 0 ] && STILL+=("$id")
done
echo "------"
if [ ${#STILL[@]} -eq 0 ]; then echo "ALL RETRIED SCENARIOS PASS"; else echo "STILL FAILING: ${STILL[*]}"; fi
