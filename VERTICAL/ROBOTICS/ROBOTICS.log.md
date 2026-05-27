# ROBOTICS — log

Append-only history sister of `ROBOTICS.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — VERTICAL/ROBOTICS 신규 도메인 scaffold + A1 sim→real transfer (embodied VLA, cycle-10)

- [x] `VERTICAL/ROBOTICS/` 신설 — 로보틱스/embodied 전문 모델 측정 도메인 (2026 physical AI frontier). NAME=ROBOTICS · path=VERTICAL/ROBOTICS/. AGENT (디지털 trajectory) 의 physical sibling.
- [x] 3-axis 구조 scaffold (A · B · N⭐ MAIN NOVEL) — 신규 도메인 패턴 (A1 closed-form first probe + B second measured ladder + N⭐ NOVEL MAIN) 따름 (VERTICAL/CODE · MATH 참고).
- [x] A1 — sim→real transfer 신뢰도 closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `bench/robotics_a1_sim2real.hexa` + `verify/numerics_robotics_a1_sim2real.hexa` · `verdicts/a1_sim2real_verdict.txt`.
- [x] identity: `transfer_ratio_pct = real_success × 100 / sim_success` (success × 100 ledger · × 100 factors cancel → ratio in plain %) · falsifier `ratio < 50%` (real < sim × 0.5) → sim2real gap (시뮬엔 되는데 실제 안 됨 · reality gap).
- [x] worked example 5 VLA models × {sim_success, real_success}: rt2 (85/65 · ratio 76% silent · RT-2) · openvla (82/58 · 70% silent · OpenVLA) · pi_zero (88/68 · 77% silent · π0 flow) · sim_overfit_model (90/30 · 33% FIRES · reality gap) · weak_vla (70/25 · 35% FIRES · reality gap). bidirectional discrimination 3 silent (sim2real 강건) + 2 fires (reality gap) + sim-overfit trap (sim 90 = ladder 최고점인 sim_overfit_model 이 real 30 으로 FIRES — 시뮬 점수만으론 신뢰 불가).
- [x] external anchors: Brohan 2023 RT-2 (arXiv:2307.15818) · Kim 2024 OpenVLA (arXiv:2406.09246) · Black 2024 π0 (arXiv:2410.24164) · Tobin 2017 domain randomization sim→real (arXiv:1703.06907).
- [x] sentinel: `__HEXA_CODEX_ROBOTICS_A1_SIM2REAL__ DONE` (bench) + `__HEXA_CODEX_NUMERICS_ROBOTICS_A1__ DONE` (verify). `hexa run` 7/7 checks passed.
- **honest residual**: 실측 sim→real transfer harness 미수행 — cycle-11+ T4 deferred (LIBERO/SimplerEnv sim eval + 실제 로봇 rollout · vast.ai pod · cx_lab_sandbox). placeholder data 의 closed-form identity (🔵+🟡) — 실측 (🟢) 아님.
- [ ] 축 B (B1 long-horizon manipulation · 5-step 조작 < single-step × 0.3 반증자 — AGENT/N1 trajectory step-decay 의 physical 버전) — 다음 라운드.
- [ ] 축 N⭐ NOVEL (N1 안전 정지 safe-stop 신뢰성 · 위험 false-negative > 1% 반증자 — physical 위해 비가역) — ⭐ MAIN priority lane · measured-tier 필요.
