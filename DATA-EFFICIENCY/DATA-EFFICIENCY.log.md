# DATA-EFFICIENCY — log

Append-only history sister of `DATA-EFFICIENCY.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — A1 closed-form curriculum-delta verifier wired (cycle-9 round-8 · CODEX bg)

- [x] `DATA-EFFICIENCY/bench/data_efficiency_a1_curriculum_delta.hexa` — closed-form `curriculum_delta_pp = max(curriculum_acc) − random_acc` (× 100 ledger of final accuracy · libm-free integer arithmetic). 4 configs × 4 sample-size sweep (10k · 30k · 100k · 300k training tokens): random peak=6500 baseline · easy-to-hard peak=7200 Δ=+700 (+7.00pp) · hard-to-easy peak=6300 Δ=−200 (−2.00pp) · interleaved peak=6700 Δ=+200 (+2.00pp).
- [x] `DATA-EFFICIENCY/verify/numerics_data_efficiency_a1_curriculum_delta.hexa` — 7-check verifier: (1) delta identity (peak − peak_random) (2) accuracy ∈ [0, 100] range bound for all 16 (config, sample-size) cells (3) zero-delta synthetic (random-clone) → Δ = 0 (4) falsifier-fires example — hard-to-easy Δ=−200 + interleaved Δ=+200 both < 500 (5) silent example — easy-to-hard Δ=+700 ≥ 500 (6) determinism (7) sanity invariant — random baseline row ∈ [0, 100]. Bidirectional discrimination: easy-to-hard silent (curriculum helps) ↔ hard-to-easy + interleaved fire (null/negative effect).
- [x] `hexa run` verdict — 🔵 STRUCTURAL (delta identity + threshold semantics 7/7) + 🟡 BY-CITATION (5pp threshold from Bengio 2009 curriculum learning ICML · Hacohen 2019 power of curriculum ICML · Wu 2021 when do curricula work ICLR · Soviany 2022 survey IJCV). Verdict persisted at `DATA-EFFICIENCY/verdicts/a1_curriculum_delta_verdict.txt`.
- [x] Snapshot A1 milestone flipped `[ ]` → `[x]` with cycle-9 round-8 wire note + external anchors recorded.
- [ ] **Honest residual** — substrate fire DEFERRED. Identity-close ≠ measured-close ([[feedback_closure_is_physical_limit]]): cycle-10+ T4 measured contact via lm_foundry SFT curriculum-ordered run (vast.ai pod · A100 40GB · 4-config × 4-sample-size sweep · final-acc dump) required to bind placeholder per-config peak accuracy to real training runs. Frontier perpetually open — 새 corpus · filter · curriculum 기법 마다 A1 cell 재오픈 (per [[feedback_closure_is_physical_limit]]).
- [ ] **Honest residual** — A1 covers final-accuracy peak only. Sister metrics from the original axis spec (full sample-efficiency curve fit · per-step convergence rate · quality-mix interaction) remain unverified — candidate axes A2 (convergence-rate curve fit) · A3 (curriculum × quality interaction) deferred to subsequent cycles.

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
