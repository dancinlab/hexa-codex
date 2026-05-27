# FRONTIER — log

Append-only history sister of `FRONTIER.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — cycle-10 round-2: F1·F2 closed-form 동시 incubation (bg cap=3 · race-가드 검증)

`/cycle-bg` round-2 (sticky bg · cap=3 sweet spot). FRONTIER scaffold + F1 SPARSE-MOE + F2 MULTIMODAL 3 agent 동시 incubation. F1·F2 closed-form 7/7 PASS · race-가드 검증 — agent 들이 같은 도메인 디렉토리 안에서 path-prefix 분리 (`f1_*` vs `f2_*` vs scaffold) 로 충돌 없음.

| sub-axis | tier | checks | commit |
|---|---|---|---|
| F1 SPARSE-MOE | 🔵+🟡 | 7/7 | 87db005 (bench) + 755ac82 (verifier/verdict) |
| F2 MULTIMODAL | 🔵+🟡 | 7/7 | 742b789 (bench) + 22cf4a7 (verifier/verdict) |

### Closed-form 결과

- **F1 SPARSE-MOE active_premium** — Gemma 4 E4B (dense 4B · 675/1000) vs Gemma 4 26B/A4B (MoE active 3.8B · 663/1000) = **active_premium = 982/1000 (0.982)**. MoE 가 same-active-param dense 보다 1.8pp 낮음 → "MoE free lunch vs same-active dense" 신화 **🔴 FALSIFIED** in Gemma 4 family. 단 synthetic strong-MoE regime (800 vs 600 = 1333) 은 silent — task-class/family/scale dependent. 외부 source: arXiv:2604.07035 controlled benchmark + Fedus 2022 Switch · Lepikhin 2020 GShard · Du 2022 GLaM.
- **F2 MULTIMODAL balance** — gemma4_31B worst gap 7pp silent · qwen3.6_72B 19pp silent · legacy_vlm_4B (audio/video unsupported control) 75pp fires. 30pp threshold = mild-failure convention · Gemma 4 TR + Liu 2023 LLaVA + Driess 2023 PaLM-E + Chu 2024 Qwen-Audio + Yang 2023 GPT-4V.

### 🆕 학습 — same-domain race-prefix 분리 패턴

| race-pattern | 가드 |
|---|---|
| 다른 도메인 디렉토리 (cycle-9 r7/8) | `git add <files>` only |
| 같은 도메인 디렉토리 (cycle-10 r2 = FRONTIER 안 3 agent) | **path-prefix 분리** (`scaffold` vs `f1_*` vs `f2_*`) |

→ 같은 디렉토리 안 race 도 path-prefix 명시로 회피 가능. 단 race 1건 관찰 — scaffold agent 가 `git add` 시점에 F1 agent 가 untracked bench 파일 만들어둔 상태. scaffold commit (87db005) 에 F1 bench 가 의도치 않게 bundle. 다음 라운드: **scaffold commit 완료 후 F-agents 시작** 또는 `git add` 시 explicit 파일 list 만 (디렉토리 path 회피).

### Promotion-gate 진척 — F1·F2 가 gate 4-of-4 도달

| gate 조건 | F1 SPARSE-MOE | F2 MULTIMODAL |
|---|---|---|
| (1) closed-form 7/7 | ✅ 982 fires · synth silent | ✅ 3 models discrim |
| (2) 외부 anchor ≥ 3 | ✅ 4 (Fedus · Lepikhin · Du · arXiv:2604.07035) | ✅ 5 (Gemma 4 TR · Liu · Driess · Chu · Yang) |
| (3) measured-tier 경로 명시 | ✅ cycle-11+ mac M3 GGUF Gemma 4 | ✅ cycle-11+ MMMU/MMBench/AudioBench/Video-MME |
| (4) 사용자 sign-off | ⏸ 대기 | ⏸ 대기 |

→ 둘 다 **3-of-4 통과 · 사용자 sign-off 만 대기**. graduation 가능 상태.

### LSP false-positive 관찰

`DOMAINS.tape` 에 `@domain FRONTIER := …` row 추가 → tape-lsp 가 `@d` (소문자) unknown 으로 진단. **cycle-9 시작부터 일관된 형식** (sibling demiurge-localdev DOMAINS.tape 도 동일) — LSP 가 17-type alphabet 의 long-form lowercase identifier (`@domain` · `@paper`) 를 catch up 못한 LSP-side 버그. 코드 정상.

- [x] FRONTIER scaffold (commit 87db005)
- [x] F1 SPARSE-MOE closed-form 7/7 + 🔴 myth FALSIFIED (755ac82)
- [x] F2 MULTIMODAL closed-form 7/7 (22cf4a7)
- [ ] cycle-10 round-3 — F3 AGENTIC-TRAJECTORY · F4 REASONING-DEPTH · F5 COST-PERFORMANCE (cap=3 sweet spot)
- [ ] cycle-10 round-4 — F6 ALIGNMENT-FAKING + AXIS.easy.md 갱신
- [ ] graduation (gate 4-of-4 통과 후 단독 도메인 분리) — F1/F2 사용자 sign-off 대기

## 2026-05-28 — FRONTIER meta-domain scaffold (cycle-10 round-2 init)

- [x] FRONTIER/ scaffold 생성 — `FRONTIER.md` (snapshot · @title · @goal · North-star ASCII · 6 sub-axes · promotion-gate spec · 분리 절차 · CODEX 와 분담 표 · honesty invariants) + `FRONTIER.log.md` (this file) + `bench/` · `verify/` · `verdicts/` (.gitkeep).
- [x] sub-axes F1~F6 등재 (2026 frontier 동향 6 차원) — F1 SPARSE-MOE · F2 MULTIMODAL · F3 AGENTIC-TRAJECTORY · F4 REASONING-DEPTH · F5 COST-PERFORMANCE · F6 ALIGNMENT-FAKING. 각 row = 1-liner 설명 + 반증자.
- [x] promotion-gate 4 조건 spec — (1) closed-form 7/7 PASS · (2) 외부 anchor ≥ 3 · (3) measured-tier 경로 명시 · (4) 사용자 sign-off (또는 3-cycle timeout TBD).
- [x] 분리 절차 5 단계 명시 — NAME/ scaffold · F<N> `[graduated]` 마커 · CODEX 22-list 추가 · DOMAINS.tape row · ENGINE wire stub.
- [x] 분리 후 잔존 데이터 처리 — `git mv` 이관 · log entry "F<N> graduated YYYY-MM-DD → NAME/" · FRONTIER row `[graduated]` marker 영구 보존 (latency trail).
- [x] `DOMAINS.tape` 에 `@domain FRONTIER` row 추가 (meta-domain 섹션, CODEX 다음 라인).
- [x] CODEX 와 sibling 분담 표 — CODEX = 22 mature orchestrate · FRONTIER = 신규 등장 sub-axis 인큐베이션 + gate. discovery (`/kick`·`/gap`) 신규 frontier 발견 시 첫 docking 지점이 FRONTIER.
- [ ] **deferred — F1 SPARSE-MOE closed-form:** sibling agent (cycle-10 round-2 F1 SPARSE-MOE incubator) 가 `FRONTIER/bench/f1_*.hexa` + `FRONTIER/verify/numerics_f1_*.hexa` 작성. race-guard: 본 agent 는 `FRONTIER.md` · `FRONTIER.log.md` · `DOMAINS.tape` 만 touch.
- [ ] **deferred — F2 MULTIMODAL closed-form:** sibling agent (cycle-10 round-2 F2 MULTIMODAL incubator) 동일 패턴.
- [ ] **deferred — F3~F6 closed-form:** 후속 cycle 라운드에서 차례로 인큐베이션.
- [ ] **deferred — gate 통과 첫 사례:** F1 또는 F2 가 4 조건 ALL 통과 → 단독 도메인 분리 첫 dry-run · CODEX 22→23 확장 절차 검증.
- [ ] **deferred — 3-cycle timeout 정의:** gate 4 (사용자 sign-off) 의 timeout 대안 — 정확히 몇 라운드 incubation 정체 후 자동 분리 또는 archive 인지 TBD.

honest residual (frontier OPEN — feedback_closure_is_physical_limit):
- FRONTIER 자체는 인큐베이션 lane 일 뿐 — sub-axis 어느 것도 아직 closed-form 7/7 도달 안 함. scaffold 단계.
- 6 sub-axes 의 반증자 line 은 1차 brainstorm 수준 — 실제 closed-form 인코딩 시 falsifier formulation 다듬어질 수 있음.
- gate 4 (사용자 sign-off) 의 timeout 메커니즘 미정 — 3-cycle wait 의 "cycle" 단위가 /cycle-bg round 인지 calendar week 인지 명시 필요.
- promotion 시 ENGINE intake matrix 의 axis letter (G, H, ...) 부여 알고리즘 미정 — 현재 CODEX 의 graduation 과 동일 절차로 가정. 충돌 가능성 (예: CALIBRATION G 이미 점유) 시 letter 할당 정책 보강 필요.
