# RAG — 도서관 사서 정확도

@title: 🔍 RAG — "도서관 사서 정확도"
@goal: **외부 지식 검색 + 모델 활용 능력을 영구 측정·강화하는 lane.** 새 retriever·corpus·reranker·embedding model 가 등장할 때마다 측정 frontier 가 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Candidate sibling from [`AXIS.easy.md`](../AXIS.easy.md) (브레인스토밍 ⭐⭐⭐). ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** retriever recall@5 < 50% OR LLM 의 retrieved context 무시 (citation rate < 30%)
>
> **Sibling parallel:** SUBSTRATE 는 '모델 자체 능력', RAG 는 '모델 + 외부 메모리 결합 능력' — 별 시스템

## North-star

사서한테 'X 책 줘' 했을 때 (1) 진짜 X 책 가져오는가 (retrieve) (2) 모델이 그 책 읽고 답에 쓰는가 (use).

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> RAG 은 완료되지 않는다. 새 retriever·corpus·reranker·embedding model 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — first probe (closed-form baseline)
- [x] A1 — retriever recall@k · noise robustness · 인용 정확도 (closed-form). 반증자: retriever recall@5 < 50% OR LLM 의 retrieved context 무시 (citation rate < 30%). **CYCLE-9 round-3 first probe (2026-05-28):** `RAG/bench/rag_a1_recall_at_k.hexa` + `RAG/verify/numerics_rag_a1_recall_at_k.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL (set-cardinality recall + OR compound) + 🟡 BY-CITATION (50%/30% thresholds DPR/RAG convention). Identity: `recall@k = |retrieved_top_k ∩ relevant| / |relevant|` · compound OR `falsifier_fires = (recall@5 < 50%) OR (citation < 30%)` (vs MULTILINGUAL 의 AND). Worked example 4 retrievers (BM25 62/55 · DPR 78/72 · **ColBERT 85/80 silent** · **naive 35/18 DOUBLE FAIL**): false-positive 회피 (BM25 borderline silent) + 양쪽 임계 모두 위 ColBERT 도 silent + OR compound 정직 검증 (synthetic one-leg-low fires · both-high silent). External anchors: Karpukhin 2020 DPR (EMNLP 2020 · arXiv:2004.04906) · Shi 2023 retrieval distractor (arXiv:2302.00093) · Asai 2023 Self-RAG (arXiv:2310.11511) · Ram 2023 in-context retrieval. **실측 retriever eval DEFERRED** — cycle-10+ T4 (MS MARCO · NQ · TriviaQA × retriever family on ubu-1 HF + LLM citation eval). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — identity close ≠ measured close. 축 N (retrieve-then-ignore rate · gold-doc injection 후 hallucination drop) 다음 ⭐ MAIN priority lane.

### 축 B — second probe (measured ladder)
- [ ] B1 — reranker on/off × k 변화 × distractor 비율 ladder. 반증자: reranker 의 accuracy 이득 < 5pp → reranker 효과 marginal.

### 축 N — 🆕 NOVEL: retrieve-then-ignore rate (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — RAG 의 self-NOVEL axis. retriever 가 정답 doc 을 가져왔는데 LLM 이 무시하고 환각하는 비율 — RAG 의 hidden lower-bound. 외부 anchor: Shi 2023 retrieval distractor · Asai 2023 self-RAG · Ram 2023 in-context retrieval.
- [ ] N1 — gold-doc-injected prompt 에서 답이 doc 무시하는 비율 측정. 반증자: gold-doc injection 후 hallucination rate drop < 50% → LLM 이 retrieved context 활용 안 함.

## SANDBOX 활용 (measurement substrate)

RAG 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `.verdicts/RAG/a1_*` |
| B1 ladder | SANDBOX bench harness | `.verdicts/RAG/b1_*` |
| N1 ⭐ NOVEL | mac M3 / vast.ai pod | `.verdicts/RAG/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| RAG forcing system prompt + citation enforcement | retriever 모델 선택 · reranker on/off · k 결정 · context budget 분배 | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **RAG 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../ECONOMICS.md`](../ECONOMICS.md) · [`../NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md)
- this domain: [`RAG.md`](RAG.md) (snapshot) · [`RAG.log.md`](RAG.log.md) (history)
