# RAG — log

Append-only history sister of `RAG.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — A1 first probe build (CODEX cycle-9 round-3, /cycle-fg inline)

- [x] A1 — recall@k + citation compound OR closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `verify/numerics_rag_a1_recall_at_k.hexa` · `verdicts/a1_recall_at_k_verdict.txt`.
- [x] identity: `recall@k = |retrieved_top_k ∩ relevant| / |relevant|` + `falsifier_fires = (recall@5 < 50%) OR (citation < 30%)`.
- [x] worked example 4 retrievers (BM25 62/55 · DPR 78/72 · ColBERT 85/80 silent · naive 35/18 DOUBLE FAIL) + synthetic OR semantics 검증.
- [x] external anchors: Karpukhin 2020 DPR · Shi 2023 distractor · Asai 2023 Self-RAG · Ram 2023.
- **honest residual**: 실측 retriever eval 미수행 — placeholder integer ledger. 실측은 cycle-10+ T4 cost-bearing round (MS MARCO · NQ · TriviaQA × retriever family + LLM citation eval on ubu-1 HF).
- [ ] 축 B (reranker on/off × k × distractor 비율 ladder) — 다음 라운드.
- [ ] 축 N⭐ NOVEL (retrieve-then-ignore rate · gold-doc injection 후 hallucination drop < 50%) — measured-tier 필요.
- [ ] ENGINE intake matrix 승격 검토.

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
