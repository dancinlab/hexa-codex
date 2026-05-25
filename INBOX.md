# INBOX — current state

@goal: cross-project handoff 수신함 — 다른 repo가 hexa-codex로 넘긴 gap·patch·note를 추적하고 해소

(현재 상태만 기록 — 열린 handoff는 `- [ ]` 로, 처리 이력은 `INBOX.log.md` 로)

- [ ] `pool-route` 가 mac-only 도구(`hexa`·`claude`·`llama-*`·`~/Models/gguf/*`·`pool`)를 ubu 호스트로 load-escalate → `command not found` 로 실패 — target sidecar/pool-route · mac-only-tool allowlist 추가 제안 · cycle-13 kick round 5 블록 · 상세 `INBOX.log.md` 2026-05-24
- [ ] `/paper lint` g51 pages 체크 false-negative ("main.pdf not found") — **근본원인 isolated (cycle-17)**: `hexa 0.1.0-dispatch` 런타임의 same-name `let` 전역충돌 버그. 서로 다른 두 fn 이 같은 이름 `let x` 를 선언하면 모든 참조가 **첫 정의 fn 의 값**으로 resolve (function-local 아님) → `_cmd_compile` 의 `let pdf="pdflatex…"` 가 `_cmd_lint` 의 `let pdf=dir+"/main.pdf"` 를 clobber, lint 가 `pdflatex…` 문자열을 `test -e` 함. (M5.OPS cycle-16b 이 "exec_with_status quirk" 로 1차 등록한 동일 증상의 진짜 원인.) target hexa-lang (런타임 fix) · 부차 sidecar/paper (변수명 rename 회피) · cycle-16b M5.OPS + cycle-17 SUBSTRATE g51 둘 다 블록 · 상세 `INBOX.log.md` 2026-05-25
- [ ] `llama-mtmd-cli` (stock brew llama.cpp) 가 `ggml-org/SmolVLM-Instruct-GGUF` (2.2B "v1") Q8_0 를 못 로드 — `init: invalid token[6] = -1` → `decode: failed to initialize batch` → `failed to eval prompt` (모델 로드는 됨, 첫 batch decode 에서 죽음). 같은 build·같은 protocol 로 `SmolVLM2-2.2B-Instruct-GGUF`·`SmolVLM-500M-Instruct-GGUF`·`Qwen2.5-VL-3B-Instruct-GGUF` 는 정상 → SmolVLM-Instruct(v1) GGUF 의 tokenizer/special-token 메타데이터 issue 로 추정. target upstream (llama.cpp mtmd / ggml-org GGUF re-export) · **no workaround applied** — M5.SUBSTRATE multimodal ladder 의 2.2B rung 은 clean 한 SmolVLM2-2.2B 변종으로 대체 (cycle-20, `bench/sandbox_multimodal_ladder.hexa`) · 상세 `INBOX.log.md` 2026-05-25
