# INBOX — log

Append-only history sister of `INBOX.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-24 — pool-route mac-only tool escalation (target sidecar/pool-route)
- [ ] `pool-route` PreToolUse 훅이 mac load 가 높을 때 `hexa`(및 `claude`/`llama-*`) 문자열을 포함한 `Bash` 호출을 ubu-1/ubu-2 로 load-escalate 하지만, 해당 도구들은 mac-only 또는 mac mini 전용(`hexa.real` @ `~/.hx/packages/hexa/` · `~/Models/gguf/*.gguf` · Metal `llama-completion` · `pool` CLI 자체) → ubu 에서 `command not found` / `No such file or directory` 로 caller 가 작업 완료 불가.
- [ ] 제안 fix — escalate 전에 **mac-only-tool allowlist** 조회 (`hexa`/`hexa.real` · `llama-completion`/`llama-server`/`llama-cli` · `~/Models/gguf/` 하위 경로 · `pool`); 매칭 시 high load 에서도 escalation 억제. (옵션) `POOL_DISABLE=1` 을 훅 자체의 hard override 로 존중 — 현재 env var 는 subprocess 시작 전 훅이 소비.
- caller-side 회피 4종 모두 실패: `POOL_DISABLE=1` (훅이 strip) · `cd ... && hexa` (`cd` 도 escalate) · `pool on mini` (`pool` 도 ubu 부재) · 절대경로 `hexa.real` (키워드 매칭으로 여전히 escalate). 유일 탈출구는 키워드 미포함 trivial cmd(`echo`·`pwd`·`ls`).
- target: sidecar/pool-route · discovered_by hexa-codex cycle-13 (severity medium). cycle-13 kick round 5 를 잃음 (`.discoveries/sandbox.tape` 에 `d_kick_round_5 :: blocked [reason=kick-route-conflict-not-bug]` 로 정직 기록). hexa-lang kick 버그와 구분 — 엔진 자체는 정상, 버그는 pool-route 플러그인의 routing 결정. 메모리 룰 `feedback_kick_failure_inbox.md` (2026-05-24) 가 mandate 하는 upstream inbox patch.

## 2026-05-23 — hexa-lang runtime_core.c clang forward-decl (target hexa-lang)
- [x] ✅ VERIFIED-RESOLVED (upstream action 불필요) — hexa-lang `f8fcbe9e`(#469, `__hexa_call_non_fn_throw` 추가)가 `hexa_str`/`hexa_throw` 가 forward-decl 되기 전 호출해 modern clang `-Werror=implicit-function-declaration` 회귀를 macOS 에서 유발, downstream(hexa-codex pareto verifier 포함) `hexa.real run` 블록. 상류 `e705349f`(#482, PROBE r14-D)가 `self/runtime_core.c` 1158-1163 에 `extern HexaVal hexa_str(...)` + `extern void hexa_throw(...)` 2줄 forward-decl 을 1차 payload 와 함께 folding 하여 해소. 2026-05-23 재현 시도 — hexa-lang HEAD `2ebdcfa7` 에서 `verify/numerics_economics_pareto_floor.hexa` 10/10 PASS, clang diagnostic 무발생.
- target: hexa-lang · discovered_by hexa-codex cycle-2 pareto lower-bound agent (commit `5bbb9ad`) · 재현 host macOS (Darwin 25.5.0) clang default toolchain. follow-up 권고 — `__hexa_call_non_fn_throw` 이동/`runtime_core.c` 분할 시 두 `extern` 줄 보존 또는 private header 로 이관해 macOS clang gate green 유지.
