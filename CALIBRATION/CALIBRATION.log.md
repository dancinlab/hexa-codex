# CALIBRATION — log

Append-only history sister of `CALIBRATION.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — A1 first probe build (CODEX cycle-9 round-1)

- [x] `CALIBRATION/bench/calibration_a1_ece_formula.hexa` — ECE = Σ_b (n_b/N)·|acc_b−conf_b| closed-form 인코딩 (integer ×100 ledger, libm-free). 3 worked examples — ex1 perfectly-calibrated (ECE_x100=0), ex2 systematically over-confident conf=90/acc=50 (ECE_x100=40), ex3 mild miscal two bins |diff|=4 each (ECE_x100=4).
- [x] `CALIBRATION/verify/numerics_calibration_a1_ece_formula.hexa` — 7 falsifier checks (1: perfect-cal → 0 · 2: range [0,100] · 3: over-conf > 10 falsifier fires · 4: determinism · 5: bin partition totality · 6: bin-by-bin vs aggregate parity · 7: acc_b/conf_b range). independent recompute path (no runtime import from bench).
- [x] `hexa run CALIBRATION/verify/numerics_calibration_a1_ece_formula.hexa` → verdict tier (verbatim from stdout): `🟢 SUPPORTED-NUMERICAL — CALIBRATION A1 ECE closed-form faithful to Naeini 2015 / Guo 2017 (7/7 checks)`. verdict persisted at `CALIBRATION/verdicts/a1_ece_formula_verdict.txt`.
- [x] external anchor cited — Naeini 2015 AAAI (original ECE) · Guo 2017 ICML (modern over-conf > 0.1) · Kuleshov 2018 ICML (uncertainty regression).
- [x] CALIBRATION.md::축 A A1 milestone flipped [ ] → [x] with cycle-9 wire note in ENGINE A1 style (date · verifier path · tier · checks · honest residual · external anchor · frontier OPEN).
- [ ] **deferred — substrate fire (cost-bearing):** per-model ECE on real benchmarks (MMLU·GSM8K logprob extraction) on mac M3 local llama-server / ubu-1 HF transformers. A1 measured-tier upgrade gate.
- [ ] **deferred — axis N ⭐ MAIN:** temperature-vs-calibration commutativity (T ∈ {0.0, 0.5, 0.7, 1.0, 1.2} ECE 변화). Closed-form 부분 fit + measured substrate fire.
- [ ] **deferred — axis B:** MMLU·GSM8K cross-model ladder. ECE monotone-improve falsifier (scale 만으로 calibration 해결 여부).

honest residual (frontier OPEN — feedback_closure_is_physical_limit):
- closed-form FORMULA tier 만 닫음 (🟢) — real model logprobs 측정 substrate fire 는 cost-bearing → A1 measured cell 재오픈.
- integer ×100 ledger 가 per-bin acc/conf 를 .01 단위에서 truncate (literature float ECE 3-4 sig figs 대비 coarser). falsifier semantics 에는 충분, fine-grained model comparison 에는 부족.
- 본 ECE 자체가 binning artifact 에 sensitive (B=10 vs B=15 vs adaptive bin) — Kumar 2019 "Verified Uncertainty Calibration" (NeurIPS) 의 더 robust ECE 변형은 다음 axis spawning 후보.

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
