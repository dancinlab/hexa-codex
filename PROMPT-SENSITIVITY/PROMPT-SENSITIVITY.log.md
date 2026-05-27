# PROMPT-SENSITIVITY — log

Append-only history sister of `PROMPT-SENSITIVITY.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — A1 first probe build (CODEX cycle-9 round-4)

- [x] `bench/prompt_sensitivity_a1_5prompt_agreement.hexa` — 5-prompt agreement closed-form (pairs(5)=10 · pairwise binomial · 4 placeholder models · falsifier < 80%).
- [x] `verify/numerics_prompt_sensitivity_a1_5prompt_agreement.hexa` — 7-check verifier: (1) C(5,2)=10 invariant · (2) all-same → 100 · (3) all-different → 0 · (4) range [0,100] · (5) surface-prone fires · (6) consistent silent (FP 회피) · (7) determinism.
- [x] verifier run: 7/7 PASS → 🔵 STRUCTURAL (combinatorial identity) + 🟡 BY-CITATION (80% threshold = Sclar 2023 · Razavi 2022).
- [x] verdict written: `verdicts/a1_5prompt_agreement_verdict.txt`.
- [x] external anchors: Sclar 2023 quantifying prompt sensitivity (arXiv:2310.11324) · Razavi 2022 paraphrase robustness · Wei 2022 chain-of-thought (arXiv:2201.11903).
- [x] A1 checkbox flipped to `[x]` with CYCLE-9 round-4 wire note in snapshot.
- [ ] **honest residual** — real 5-prompt run deferred (cycle-10+ SANDBOX substrate · mac M3 / ubu-1 local · 5 paraphrase variants per factual question · cost-bearing 시 vast.ai). closed-form metric close ≠ measured close ([[feedback_closure_is_physical_limit]]); frontier remains open per perpetual-axis design.

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
