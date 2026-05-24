# INBOX — current state

@goal: cross-project handoff 수신함 — 다른 repo가 hexa-codex로 넘긴 gap·patch·note를 추적하고 해소

(현재 상태만 기록 — 열린 handoff는 `- [ ]` 로, 처리 이력은 `INBOX.log.md` 로)

- [ ] `pool-route` 가 mac-only 도구(`hexa`·`claude`·`llama-*`·`~/Models/gguf/*`·`pool`)를 ubu 호스트로 load-escalate → `command not found` 로 실패 — target sidecar/pool-route · mac-only-tool allowlist 추가 제안 · cycle-13 kick round 5 블록 · 상세 `INBOX.log.md` 2026-05-24
- [ ] `/paper lint` (sidecar/paper 0.5.3 `_paper.hexa`) `_path_exists(main.pdf)` 가 존재하는 PDF에 false 반환 → g51 pages 체크 false-negative ("main.pdf not found"). byte-identical 복제본은 동일 path·argv 로 true 반환 → 375줄 번들 스크립트 실행 시 hexa-runtime `exec_with_status("test -e …")` 가 false 를 주는 런타임 quirk. /tmp 복사본에서도 재현(워크트리 경로 무관). 우회 금지 → target sidecar/paper · 상세 `INBOX.log.md` 2026-05-25
