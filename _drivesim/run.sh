#!/usr/bin/env bash
# Drive every manifest scenario through `drive` (natural language ONLY, file/branch
# never named beyond the NL ask) and verify the real effect.
#   code      -> the program now runs to exit 0 with the expected stdout substring
#   git_*     -> a sandboxed repo (LOCAL bare origin) received the commit/push/branch
# Usage: run.sh [START END]   (1-based inclusive subset; default = all)
set -u
ROOT="/Users/mini/dancinlab/hexa-codex/_drivesim"
MAN="$ROOT/manifest.json"
EXP="$ROOT/drive_one.exp"
PASS=0; FAIL=0; FAILED_IDS=()

n=$(jq length "$MAN")
START=${1:-1}; END=${2:-$n}

drive_it(){ expect -f "$EXP" "$1" "$2" >/dev/null 2>&1; return $?; }

setup_git(){  # <dir> <kind>
  local dir="$1" bare="$1.origin.git"
  rm -rf "$dir" "$bare"; mkdir -p "$dir"
  git init -q -b main "$dir"
  printf 'build/\n*.bin\n__pycache__/\n*.bak\n' > "$dir/.gitignore"   # keep drive's build/ out of commits
  printf 'x = 1\nprint("app", x)\n' > "$dir/app.py"
  git -C "$dir" add -A; git -C "$dir" -c user.name=t -c user.email=t@t commit -q -m "init"
  git init --bare -q "$bare"
  git -C "$dir" remote add origin "file://$bare"
  git -C "$dir" push -q -u origin main
  # simulate a user edit so there is something to commit
  printf 'y = 2\nprint("more", y)\n' >> "$dir/app.py"
}

printf "%-6s %-12s %-7s %s\n" "id" "kind" "result" "detail"
printf '%s\n' "------------------------------------------------------------------------"
for ((k=START-1; k<END; k++)); do
  kind=$(jq -r ".[$k].kind" "$MAN")
  dir=$(jq -r ".[$k].dir"  "$MAN")
  instr=$(jq -r ".[$k].instr" "$MAN")
  id=$(basename "$dir")

  if [ "$kind" = "code" ]; then
    prog=$(jq -r ".[$k].prog" "$MAN"); want=$(jq -r ".[$k].expect" "$MAN")
    if [ -f "$dir/$prog.orig" ]; then cp "$dir/$prog.orig" "$dir/$prog"; else cp "$dir/$prog" "$dir/$prog.orig"; fi
    rm -f "$dir/$prog.bak"
    drive_it "$dir" "$instr"; drc=$?
    out=$(cd "$dir" && python3 "$prog" 2>&1); prc=$?
    if [ $prc -eq 0 ] && printf '%s' "$out" | grep -qF -- "$want"; then
      PASS=$((PASS+1)); printf "%-6s %-12s %-7s %s\n" "$id" "$kind" "PASS" "got[$want]"
    else
      FAIL=$((FAIL+1)); FAILED_IDS+=("$id")
      printf "%-6s %-12s %-7s %s\n" "$id" "$kind" "FAIL" "rc=$prc drv=$drc want[$want] out=$(printf '%s' "$out"|tr '\n' ' '|cut -c1-50)"
    fi
  else
    bare="$dir.origin.git"
    setup_git "$dir" "$kind"
    drive_it "$dir" "$instr"; drc=$?
    ncommits=$(git -C "$dir" rev-list --count HEAD 2>/dev/null)
    clean=$(git -C "$dir" status --porcelain 2>/dev/null)
    ok=0; detail=""
    case "$kind" in
      git_commit)
        if [ "$ncommits" = "2" ] && [ -z "$clean" ]; then ok=1; detail="commit ok (n=2 clean)"; else detail="commits=$ncommits dirty='$clean'"; fi ;;
      git_push)
        lh=$(git -C "$dir" rev-parse HEAD 2>/dev/null); rh=$(git -C "$bare" rev-parse main 2>/dev/null)
        if [ "$ncommits" = "2" ] && [ -n "$rh" ] && [ "$lh" = "$rh" ]; then ok=1; detail="pushed main->origin"; else detail="commits=$ncommits local=$lh origin=$rh"; fi ;;
      git_branch)
        bn=$(jq -r ".[$k].branch" "$MAN")
        if git -C "$bare" show-ref --verify --quiet "refs/heads/$bn"; then ok=1; detail="origin has $bn"; else detail="no origin/$bn (refs: $(git -C "$bare" for-each-ref --format='%(refname:short)' | tr '\n' ',' ))"; fi ;;
    esac
    if [ $ok -eq 1 ]; then
      PASS=$((PASS+1)); printf "%-6s %-12s %-7s %s\n" "$id" "$kind" "PASS" "$detail"
    else
      FAIL=$((FAIL+1)); FAILED_IDS+=("$id")
      printf "%-6s %-12s %-7s %s\n" "$id" "$kind" "FAIL" "drv=$drc $detail"
    fi
  fi
done
printf '%s\n' "------------------------------------------------------------------------"
echo "TALLY: PASS=$PASS FAIL=$FAIL / $((END-START+1))"
[ $FAIL -gt 0 ] && echo "FAILED: ${FAILED_IDS[*]}"
exit 0
