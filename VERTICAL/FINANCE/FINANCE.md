# FINANCE — 퀀트 분석가

@title: 💰 FINANCE — "퀀트 분석가"
@goal: **금융 전문 모델이 금융 수치 질문(FinQA · 재무제표 계산)을 정밀하게 풀어내는 것(수치 정확도)과, 그 답을 시장 시계열 추세에 정합적으로 투영하는 것, 그리고 금융 조언의 환각이 비대칭 손실(잘못된 buy ≫ 놓친 기회)을 만드는가를 영구 측정·확장하는 lane.** 새 금융 model·benchmark·risk metric 이 등장할 때마다 측정 frontier 가 다시 열린다. **도착지 없음 · 종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> **VERTICAL 전문 모델 측정 도메인군 (VERTICAL/\*)** 의 FINANCE 노드 — 금융 전문 모델 측정. sibling = VERTICAL/CODE (코드 전문 모델) · VERTICAL/MATH (수학 전문 모델) · VERTICAL/BIO (바이오/의료 전문 모델). vertical specialization 이 "답 맞히기"를 넘어 "정밀 수치 계산·환각 비대칭 손실" 까지 가는가를 closed-form 으로 측정한다.
>
> **Sibling parallel:** SUBSTRATE 는 '능력 일반', VERTICAL/CODE 는 '코드 vertical 깊이', VERTICAL/MATH 는 '수학 vertical 깊이' — FINANCE 는 '금융 vertical 깊이'. lm_foundry "narrow-and-deep" thesis 의 또 하나 측정 surface. 금융의 특이점: **오류의 손실이 비대칭** — 1% 수치 오차도 큰 손실, 잘못된 buy 추천(confident-wrong)의 손실이 놓친 기회(missed gain)의 손실을 압도 (Kelly criterion · downside risk).
>
> **⚠ recipe ≠ measurement — 다른 layer:**
> - (build recipe) = **RECIPE** (어떻게 만드나 · financial corpus SFT/RL · numeric-reasoning · program-of-thought). 금융 모델 build spec.
> - **VERTICAL/FINANCE 도메인 (이 문서)** = **MEASUREMENT** (얼마나 정밀하게 계산하나 · numeric accuracy · 환각 비대칭 손실). BloombergGPT 의 FinQA program-of-thought financial-numeric-reasoning 패러다임이 본 측정의 truth surface.
>
> **Falsifier class:** numeric_acc < 90% (금융 수치 정확도 90% 미만) → 수치 계산 신뢰 불가 (금융은 정밀 critical · 1% 오차도 큰 손실). 또는 confident-wrong 금융 조언의 손실가중 > 정답 이득의 2× → 환각 비대칭 손실 (잘못된 buy ≫ 놓친 기회).

## North-star

같은 금융 question surface 위에서, 금융 모델이 (a) FinQA-style 수치 질문을 정밀하게 계산하는가, (b) 그 답을 시장 시계열 추세/예측에 정합적으로 투영하는가, (c) 금융 조언의 환각이 비대칭 손실 (잘못된 buy 추천 ≫ 놓친 기회) 을 만드는가 — 수치 정확도와 환각-위험 비대칭 사이의 gap 을 측정한다 (BloombergGPT 의 financial-numeric-reasoning + Kelly criterion downside-risk 패러다임).

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> FINANCE 는 완료되지 않는다. 새 금융 model·benchmark (FinQA/FinanceBench/시계열)·risk metric 이 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — 수치 추론 정확도 (closed-form baseline)
- [x] A1 — 수치 추론 정확도 · 5 model × {numeric_questions, numeric_correct} (FinQA · 금융 수치 계산). 금융 수치 질문 중 정답 비율 측정. 반증자: `numeric_acc < 9000` (90% 미만 · 금융은 정밀 critical — 1% 오차도 큰 손실) → 수치 계산 신뢰 불가. **CYCLE-10 first probe (2026-05-28 · VERTICAL/FINANCE 신규 도메인):** `VERTICAL/FINANCE/bench/finance_a1_numeric_accuracy.hexa` + `VERTICAL/FINANCE/verify/numerics_finance_a1_numeric_accuracy.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL + 🟡 BY-CITATION. Identity: `numeric_acc_x100 = numeric_correct × 100 / numeric_questions` (counts → pct × 100 ledger) · falsifier `acc < 9000` (90% 미만). Worked example 5 models × {numeric_questions, numeric_correct}: **bloomberg_gpt (100·95 → 95% silent · finance SOTA)** · **gpt5_finance (100·93 → 93% silent)** · **fin_claude (100·91 → 91% silent)** · **general_gpt5 (100·82 → 82% FIRES · general-purpose · 수치 오차)** · **weak_fin (100·70 → 70% FIRES · 신뢰 불가)** — bidirectional 3 silent (정밀 계산 · finance-specialist) + 2 fires (general/weak · 수치 계산 신뢰 불가) + sanity (numeric_correct ≤ numeric_questions all · finance ratio monotone bloomberg 95 ≥ gpt5_finance 93 ≥ fin_claude 91). Verdict `VERTICAL/FINANCE/verdicts/a1_numeric_accuracy_verdict.txt`. External anchors: Chen 2021 FinQA (arXiv:2109.00122) · Wu 2023 BloombergGPT (arXiv:2303.17564) · Islam 2023 FinanceBench (arXiv:2311.11944). sentinel `__HEXA_CODEX_FINANCE_A1_NUMERIC_ACCURACY__ DONE` (bench) + `__HEXA_CODEX_NUMERICS_FINANCE_A1__ DONE` (verify). **실측 측정 DEFERRED** — cycle-11+ T4 (FinQA/FinanceBench numeric eval + program-of-thought exec on lm_foundry eval + HF transformers + vast.ai pod). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — identity close ≠ measured close.

### 축 B — 시계열 추론 (measured ladder)
- [ ] B1 — 시계열 추론 · 시장 추세/예측 정합성 측정. 금융 모델이 시장 시계열 추세를 정합적으로 예측·추론하는가. 반증자: 미래 예측이 random-walk baseline 못 이김 (시계열 예측 정확도 ≤ naive random-walk → 모델이 시장에서 신호를 추출 못함 · 효율적 시장 가설에 굴복). 시계열/추세 예측 eval surface. (measured tier 필요 — cycle-11+ T4.)

### 축 N — 🆕 NOVEL: 환각-위험 비대칭 (hallucination-risk asymmetry ⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — FINANCE self-NOVEL. 금융 오류의 비대칭 손실 (Kelly criterion · downside risk). 도착지 없음. 외부 anchor: Kelly 1956 (optimal bet sizing) · downside-risk / Sortino-ratio literature · FinanceBench hallucination · financial-advice safety.
- [ ] N1 — 금융 조언 hallucination 의 비대칭 손실 · confident-wrong 금융 조언의 손실가중 vs 정답 이득. 반증자: confident-wrong 금융 조언 손실가중 > 정답 이득의 2× → 환각 비대칭 손실 (잘못된 buy 추천 ≫ 놓친 기회 · downside risk 가 upside gain 을 압도). A1 의 numeric_acc 와 구분: A1 = "수치 계산이 얼마나 정확한가", N1 = "틀린 조언의 손실이 맞은 조언의 이득에 비해 얼마나 비대칭적으로 큰가" — N1 이 더 근본 (loss asymmetry · 금융 의사결정의 진짜 위험은 평균 정확도가 아니라 tail loss).

## SANDBOX 활용 (measurement substrate)

FINANCE 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — HF transformers infer (FinQA/FinanceBench) / program-of-thought numeric exec / 시계열 forecast harness / lm_foundry retrain (mac M3 / ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local (closed-form) | `VERTICAL/FINANCE/verdicts/a1_numeric_accuracy_verdict.txt` |
| B1 시계열 추론 ladder | SANDBOX bench harness (시계열 forecast vs random-walk) | `VERTICAL/FINANCE/verdicts/b1_*` |
| N1 ⭐ NOVEL 환각-위험 비대칭 | lm_foundry eval / loss-asymmetry harness / vast.ai pod | `VERTICAL/FINANCE/verdicts/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM finance-routing wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| 수치 정확도 estimator · 시계열 예측 budget · 환각-위험 비대칭 gate | finance task 시 finance-specialist 라우팅 결정 · 시계열 예측 신뢰 budget · confident-wrong 금융 조언 비대칭 손실 gate (downside risk 거부) | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **FINANCE 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반. A1 은 현재 placeholder data 의 closed-form identity (🔵 STRUCTURAL + 🟡 BY-CITATION) — 실측 (🟢 SUPPORTED-NUMERICAL) 아님.
- **accuracy ≠ risk.** 금융의 핵심 분리 — 평균 수치 정확도(numeric_acc) 와 의사결정 위험(tail loss · 환각 비대칭) 은 다른 능력. A1 의 numeric accuracy, N1 의 loss asymmetry (환각-위험 비대칭) 가 이 분리를 측정. 높은 평균 정확도를 낮은 위험으로 착각하지 않는다 (1% 오차도 금융에선 큰 손실).
- **recipe ≠ measurement.** build recipe = 만들기 · FINANCE 도메인 = 측정. 둘을 섞지 않는다.
- **numeric truth = program exec.** 금융 수치 정답의 truth oracle 은 program-of-thought 실행 (FinQA exec · LLM 자기-판정 아님). N1 의 손실 판정도 가능한 한 closed-form loss-weight 또는 외부 risk metric 기준 (`cx_claim_verify` self-judge 금지).
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: numeric_acc < 90% → 수치 계산 신뢰 불가 (금융 정밀 critical) · confident-wrong 금융 조언 손실가중 > 정답 이득 × 2 → 환각 비대칭 손실
> **Anticipated ENGINE behavior wire**: finance-task finance-specialist 라우팅 router · 시계열 예측 신뢰 budget · 환각-위험 비대칭 gate (downside-risk 큰 confident-wrong 조언 거부)
>
> ⏸ DEFERRED waiting on cycle-11+ T4 measured fire (FinQA/FinanceBench numeric-acc + program-of-thought exec + 시계열 forecast vs random-walk + 환각 loss-asymmetry rate).

## Cross-refs

- 후보 카탈로그: [`../../AXIS.easy.md`](../../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../../ENGINE/ENGINE.md`](../../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../../SANDBOX.md`](../../SANDBOX.md)
- vertical sibling: [`../CODE/CODE.md`](../CODE/CODE.md) (코드 전문 모델 측정) · [`../MATH/MATH.md`](../MATH/MATH.md) (수학 전문 모델 측정) · [`../BIO/BIO.md`](../BIO/BIO.md) (바이오/의료 전문 모델 측정)
- 뉴로 측정 sibling (해석성 lane): [`../../NEUROEXP/NEUROEXP.md`](../../NEUROEXP/NEUROEXP.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../../MULTIMODAL/MULTIMODAL.md`](../../MULTIMODAL/MULTIMODAL.md) · [`../../DATA-QUALITY/DATA-QUALITY.md`](../../DATA-QUALITY/DATA-QUALITY.md)
- this domain: [`FINANCE.md`](FINANCE.md) (snapshot) · [`FINANCE.log.md`](FINANCE.log.md) (history)
