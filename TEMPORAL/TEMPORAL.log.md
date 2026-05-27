# TEMPORAL — log

Append-only history sister of `TEMPORAL.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — cycle-9 round-7: 축 A 의 A1 (post-cutoff confident-wrong rate) wire

- [x] `TEMPORAL/bench/temporal_a1_post_cutoff_wrong.hexa` — closed-form `rate_x100 = N_confident_wrong · 100 / N_post_cutoff` 5-모델 (CA=15 silent · PA=25 silent · OC=40 fires · CL=60 fires · Z=0 perfect-IDK zero-control) · threshold = 30 · HALLUCINATION A1 pattern mirror (integer ×100 ledger · libm-free).
- [x] `TEMPORAL/verify/numerics_temporal_a1_post_cutoff_wrong.hexa` — 7-check verifier ((1) rate identity · (2) range [0,100] · (3) zero-control Z silent · (4) > 30 OC+CL fire · (5) ≤ 30 CA+PA silent · (6) determinism · (7) cutoff-aware ≤ over-confident sanity).
- [x] `hexa run` 결과 **7/7 checks** · 🔵 STRUCTURAL + 🟡 BY-CITATION · `verdict_class=SUPPORTED-NUMERICAL` · verdict 파일 `TEMPORAL/verdicts/a1_post_cutoff_wrong_verdict.txt` 작성.
- [x] external anchors 3개+: Dhingra 2022 TimeQA (arXiv:2108.06314) · Chen 2023 temporal reasoning · Zhao 2024 cutoff awareness.
- [x] `TEMPORAL.md::축 A 의 A1` [ ] → [x] · "CYCLE-9 round-7 wire" 노트 + bench·verifier·verdict 경로 추가.

### honest residual (frontier OPEN — `feedback_closure_is_physical_limit`)

- substrate fire DEFERRED (cycle-10+): TimeQA · post-cutoff date probe × abstention extractor + self-eval gating · mac M3 local llama-server / ubu-1 HF transformers · cost-bearing round 필요.
- integer ×100 ledger 는 .01 단위 truncation — 거친 falsifier semantics 용 OK 이지만 literature 의 float % (3-4 sig fig) 보다 coarse.
- "confident-wrong" 은 binary per query 로 closed-form 인코딩됨 — measured-tier 에서 Kadavath 2022 `P(True)` × cutoff-aware abstention extractor 로 narrow 될 예정.
- 다음 축: 축 B (relative vs absolute time accuracy) · 축 N ⭐ MAIN NOVEL (relative-vs-absolute reasoning gap) 미오픈.

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
