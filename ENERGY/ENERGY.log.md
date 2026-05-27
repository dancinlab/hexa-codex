# ENERGY — log

Append-only history sister of `ENERGY.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — A1 first probe build (CODEX cycle-9 round-1)

- [x] `ENERGY/bench/energy_a1_tokens_per_joule.hexa` — closed-form tokens/J formula emission. tokens/J = N_tokens / E_total[J]; E_total = ∫P(t)dt ≈ Σ P_k·Δt_k ≈ mean_W·T. Placeholder worked example: 200 W · 60 s · 480 tok → 12 000 J → 0.040 tok/J. Riemann ↔ mean-power identity verified bit-identical (|Δ|=0 mJ).
- [x] `ENERGY/verify/numerics_energy_a1_tokens_per_joule.hexa` — 7 falsifier checks (identity · positivity · numerator linearity · denominator inverse · SOTA floor · Riemann↔mean-power · determinism). ✅ 7/7 PASS · 🔵 STRUCTURAL (6/7) + 🟡 BY-CITATION SOTA floor (1/7).
- [x] `ENERGY/verdicts/a1_tokens_per_joule_verdict.txt` written.
- [x] ENERGY.md::축 A A1 flipped [ ] → [x] with cycle-9 note (mirror ENGINE A1 style); anchors Patterson 2021 / Strubell 2019 / Schwartz 2020.
- [ ] real RAPL (Linux msr) + NVIDIA-smi sampler measurement on ubu-1 (RTX 5070 + 13900K) with per-task fixture — **cost-bearing · DEFERRED to a separate cycle**. On macOS Mx reuse `bench/bitnet_m6_energy_per_token.hexa` powermetrics recipe.
- [ ] A1 frontier OPEN (feedback_closure_is_physical_limit): instrumentation close ≠ measurement close; new HW (CPU/GPU/NPU) reopens the axis. One closed verdict ≠ axis termination.

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
