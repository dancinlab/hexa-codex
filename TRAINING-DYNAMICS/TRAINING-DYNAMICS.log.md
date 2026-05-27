# TRAINING-DYNAMICS — log

Append-only history sister of `TRAINING-DYNAMICS.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — A1 closed-form spike-rate verifier wired (cycle-9 round-7 · CODEX bg)

- [x] `TRAINING-DYNAMICS/bench/training_dynamics_a1_spike_rate.hexa` — closed-form `spike_rate_per_1k = N_spikes / N_steps × 1000` (× 1000 ledger of per-1k rate · libm-free integer arithmetic via × 10 N_spikes ledger). 4 placeholder runs: stable=0.5/1k (500) · warming=1.0/1k (1000) · spiky=2.5/1k (2500) · catastrophic=8.0/1k (8000).
- [x] `TRAINING-DYNAMICS/verify/numerics_training_dynamics_a1_spike_rate.hexa` — 7-check verifier: (1) rate identity (2) range bound raw rate ∈ [0, 1000] (3) zero-spike → 0 (4) > 1.0/1k fires (5) ≤ 1.0/1k silent (6) determinism (7) inverse sanity N_steps × rate / 1000 ≈ N_spikes. Bidirectional discrimination across stable/warming silent ↔ spiky/catastrophic fire.
- [x] `hexa run` verdict — 🔵 STRUCTURAL (rate identity + threshold semantics 7/7) + 🟡 BY-CITATION (1/1k spike threshold from Nanda 2023 grokking ICLR · Wei 2022 emergent abilities TMLR · Zhang 2024 spike analysis NeurIPS). Verdict persisted at `TRAINING-DYNAMICS/verdicts/a1_spike_rate_verdict.txt`.
- [x] Snapshot A1 milestone flipped `[ ]` → `[x]` with cycle-9 round-7 wire note + external anchors recorded.
- [ ] **Honest residual** — substrate fire DEFERRED. Identity-close ≠ measured-close ([[feedback_closure_is_physical_limit]]): cycle-10+ T4 measured contact via lm_foundry GRPO loss curve dump (mac M3 llama-server / ubu-1 HF Trainer / vast.ai pod telemetry) required to bind placeholder per-run spike counts to real training runs. Frontier perpetually open — 새 model · dataset · optimizer · scale 마다 A1 cell 재오픈 (per [[feedback_closure_is_physical_limit]]).
- [ ] **Honest residual** — A1 covers spike-count rate only. Sister metrics from the original axis spec (max gradient norm · weight norm divergence trajectory) remain unverified — candidate axes A2 (grad-norm trajectory) · A3 (weight-norm divergence) deferred to subsequent cycles.

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
