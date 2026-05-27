# HW-VARIANCE — log

Append-only history sister of `HW-VARIANCE.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — A1 closed-form per-chip throughput spread verifier wired (cycle-9 round-8 · CODEX bg)

- [x] `HW-VARIANCE/bench/hw_variance_a1_per_chip_cov.hexa` — closed-form `spread_x1000 = (max − min) × 1000 / mean` (× 1000 ledger of per-chip throughput spread · libm-free integer arithmetic via tok/s × 100 ledger). 4 placeholder populations × 5 chips: tight (10000,10100,10000,9900,10000)=20 · nominal (10000,10500,9500,10300,9700)=100 · loose (10000,10900,9100,10500,9500)=180 · lottery (10000,11500,8500,11000,9000)=300. All populations sum to 50000 → mean=10000 (mean-controlled comparison · spread is sole free variable).
- [x] `HW-VARIANCE/verify/numerics_hw_variance_a1_per_chip_cov.hexa` — 7-check verifier: (1) spread identity (2) tok/s ≥ 0 across all 20 chip slots (3) zero-spread synthetic (all 5 chips equal) → 0 (4) loose + lottery fire (> 150/1000) (5) tight + nominal silent (≤ 150/1000) — false-positive 회피 (6) determinism (7) monotone invariant max ≥ mean ≥ min for each population. Bidirectional discrimination across tight/nominal silent ↔ loose/lottery fire.
- [x] **Proxy choice rationale** — spread `(max − min) × 1000 / mean` chosen over libm-free integer sample-std (Newton-sqrt approximation ≤ 20 iter) because spread is (a) cheaper, (b) libm-free by construction (no integer sqrt loop), (c) still bidirectional (catches both 'one good chip' and 'one bad chip' silicon-lottery tails). Sample-std deferred to a future axis where Newton-sqrt iteration earns its keep.
- [x] `hexa run` verdict — 🔵 STRUCTURAL (spread identity + bidirectional discrimination + monotone invariant 7/7) + 🟡 BY-CITATION (15% spread threshold from Sinha 2022 not-all-gpus-are-equal · Hennessy & Patterson CAaQA silicon-lottery section · vLLM 2024 throughput variance report · Open Compute Project per-chip telemetry). Verdict persisted at `HW-VARIANCE/verdicts/a1_per_chip_cov_verdict.txt`.
- [x] Snapshot A1 milestone flipped `[ ]` → `[x]` with cycle-9 round-8 wire note + external anchors recorded.
- [ ] **Honest residual** — substrate fire DEFERRED. Identity-close ≠ measured-close ([[feedback_closure_is_physical_limit]]): cycle-10+ T4 measured contact via `/pool on ubu-1` + `/pool on mini` per-host Llama-3 8B FP16 throughput sweep (mac M3 / ubu-1 HF transformers / vast.ai pod cross-chip telemetry) required to bind placeholder per-chip tok/s to real silicon-lottery cohorts. Frontier perpetually open — 새 chip · cooling regime · workload 마다 A1 cell 재오픈 (per [[feedback_closure_is_physical_limit]]).
- [ ] **Honest residual** — A1 uses max−min spread proxy only. Sample-std (Newton-sqrt integer approximation) variance metric, per-batch (vs per-chip) variance, and chip-level temporal drift remain unverified — candidate axes A2 (sample-std variance) · A3 (per-batch vs per-chip variance decomposition) · A4 (temporal drift across burn-in) deferred to subsequent cycles.

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
