# RELIABILITY — log

Append-only history sister of `RELIABILITY.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — cycle-9 round-6: A1 determinism reproduction-rate (🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7)

- [x] A1 first-probe closed-form bench: `RELIABILITY/bench/reliability_a1_determinism.hexa` — `reproduction_rate = N_match / N_total × 1000` (× 1000 ledger for 99.9% precision · libm-free integer math) · 4 placeholder setups (det-seed=1000 · fp32-quirk=999 · bit-flip=995 · nondet-kernel=850) · falsifier threshold rate < 999.
- [x] A1 7-check verifier: `RELIABILITY/verify/numerics_reliability_a1_determinism.hexa` — (1) rate identity (2) range [0,1000] (3) perfect=1000 (4) rate<999 fires (5) rate≥999 silent (6) formula determinism (7) failure-complement sanity. 7/7 PASS.
- [x] `hexa run` → 🔵 STRUCTURAL + 🟡 BY-CITATION · verdict `RELIABILITY/verdicts/a1_determinism_verdict.txt`.
- [x] external anchors: Dixit 2021 silent data corruption (arXiv:2102.11245) · Hochschild 2021 fail-silent (HotOS) · NVIDIA bit-flip (ECC SBE/DBE).
- [x] RELIABILITY.md::축 A 의 A1 [ ] → [x] (CYCLE-9 round-6 wire note).
- [ ] honest residual: 실측 (T4 substrate fire) DEFERRED → cycle-10+ — llama-server (mac M3) · HF transformers (ubu-1) · vast.ai pod ECC injection. closed-form identity close ≠ measured close ([[feedback_closure_is_physical_limit]]). frontier perpetual — 새 HW·model·serving stack 마다 재오픈.

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
