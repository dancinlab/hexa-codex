# HALLUCINATION — log

Append-only history sister of `HALLUCINATION.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — A1 first probe build (CODEX cycle-9 round-4)

- [x] kernel — `HALLUCINATION/bench/hallucination_a1_confident_wrong_rate.hexa` (closed-form rate_x100 = N_confident_wrong·100/N_total; 5 placeholder models A=18 silent · B=25 fires · C=12 silent · D=42 fires · Z=0 zero-hall control; threshold > 20).
- [x] oracle — `HALLUCINATION/verify/numerics_hallucination_a1_confident_wrong_rate.hexa` (7-check falsifier: rate identity · range bound · zero-hall · heavy-hall fires · borderline silent · determinism · weighted ≤ raw sanity).
- [x] measurement — `hexa run` → **7/7 PASS** · verdict tier verbatim: `🔵 STRUCTURAL (confident-wrong rate identity + threshold 7/7) + 🟡 BY-CITATION (20% threshold = TruthfulQA / Kadavath self-eval convention)` · verdict_class `SUPPORTED-NUMERICAL`.
- [x] verdict file — `HALLUCINATION/verdicts/a1_confident_wrong_rate_verdict.txt` (axis · formula · checks · placeholder counts · external anchors · honest residual · frontier=OPEN).
- [x] external anchors — Lin 2022 TruthfulQA (arXiv:2109.07958) · Kadavath 2022 self-eval (arXiv:2207.05221) · Yin 2023 do-LLMs-know (arXiv:2305.18153). ≥1 anchor requirement met (3 cited).
- [x] HALLUCINATION.md A1 — `[ ]` → `[x]` flip with cycle-9 round-4 wire note (mirror CALIBRATION A1 style).
- [ ] honest residual (frontier OPEN · `feedback_closure_is_physical_limit`) — TruthfulQA · SimpleQA 실측 deferred (mac M3 local llama-server / ubu-1 HF transformers · abstention extractor + Kadavath P(True) self-eval gating · cycle-10+ cost-bearing round). 'confidence' as per-sample weight here — real-fire narrows to logit margin / P(True) at measured-tier. integer ×100 ledger truncates rate at .01 — acceptable for falsifier semantics, not fine-grained model comparison.
- [ ] 축 N ⭐ MAIN NOVEL (knowledge-boundary IDK rate at cutoff) — next priority lane after A1 close.

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
