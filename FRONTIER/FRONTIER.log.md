# FRONTIER — log

Append-only history sister of `FRONTIER.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

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
