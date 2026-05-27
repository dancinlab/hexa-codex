# CARBON — log

Append-only history sister of `CARBON.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — cycle-9 round-7 · A1 closed-form wire (🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7)

- [x] `CARBON/bench/carbon_a1_region_saving.hexa` — closed-form `carbon_per_token = grid_intensity × (1/tokens_per_J)` + `saving = (baseline − carbon_r) × 100 / baseline`; 4 placeholder regions (gCO2/tok × 100): nuclear-fr=20 · solar-ca=80 · mixed-de=300 · coal-pl=800 (baseline). Falsifier: saving < 20% → routing 무의미. Pattern mirrors `MULTILINGUAL/bench/multilingual_a1_perplexity_gap.hexa` (ratio + integer ledger).
- [x] `CARBON/verify/numerics_carbon_a1_region_saving.hexa` — 7-check verifier: (1) saving identity (800,20)→97% · (2) range [0,100] all regions · (3) baseline self-saving = 0 → falsifier fires · (4) nuclear-fr 97% > 90 → silent · (5) marginal (800,700)→12% < 20 → falsifier fires · (6) ordering (mixed-de 62% > coal-pl 0%) · (7) determinism.
- [x] `hexa run CARBON/verify/numerics_carbon_a1_region_saving.hexa` → **7/7 PASS** · verdict tier 🔵 STRUCTURAL + 🟡 BY-CITATION · verdict file `CARBON/verdicts/a1_region_saving_verdict.txt`.
- [x] CARBON.md A1 [ ] → [x] · "CYCLE-9 round-7 wire" note · anchors Patterson 2022 (arXiv:2204.05149) · Luccioni 2022 BLOOM · Schwartz 2020 Green AI.
- [ ] **honest residual** (frontier perpetual · [[feedback_closure_is_physical_limit]]): 본 wire 는 closed-form identity + placeholder ledger 만 닫음; 실측 region × per-model gCO2/token 은 cycle-10+ T4 measured round (vast.ai pod · per-region grid_intensity API · per-model tokens/J 측정) 으로 DEFERRED. saving<20% falsifier 의 marginal-region 경계는 실측 grid mix 동질화 데이터로만 검증 가능.
- [ ] **honest residual** (외부 anchor 1개+ 충족 but expansion deferred): Patterson/Luccioni/Schwartz 3개 인용 = citation tier 🟡; 외부 published 주장 대비 측정 numeric reproduction (예: BLOOM training 25 tCO2 · GPT-3 552 tCO2) 은 cycle-10+ N1 lane (training-vs-inference) 와 함께 묶일 후보.

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
