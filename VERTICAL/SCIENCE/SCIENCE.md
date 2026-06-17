# SCIENCE — 실험과학자

@title: 🔬 SCIENCE — "실험과학자"
@goal: **과학(물리·화학·일반과학) 전문 모델이 단답 사실(single fact)을 맞히는 것과 그 사실들을 엮어 다단계 유도(multi-step derivation)까지 실제로 해내는 것 사이의 gap, 그리고 단위/차원 일관성·반증가능 가설 생성 같은 과학 방법론 능력을 영구 측정·확장하는 lane.** 새 science model·reasoning 패러다임·benchmark 가 등장할 때마다 측정 frontier 가 다시 열린다. **도착지 없음 · 종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> **VERTICAL 전문 모델 측정 도메인군 (VERTICAL/\*)** 의 SCIENCE 노드 — 과학(물리·화학·일반과학) 전문 모델 측정. sibling = VERTICAL/MATH (수학) · VERTICAL/CODE (코드) · VERTICAL/BIO (바이오/의료) · VERTICAL/MEDICAL (임상). vertical specialization 이 "사실 암기"를 넘어 "다단계 유도·과학 방법론"까지 가는가를 closed-form 으로 측정한다.
>
> **⚠ SCIENCE ≠ MATH ≠ BIO ≠ MEDICAL — 다른 vertical · 다른 falsifier (반드시 구분):**
> - **VERTICAL/MATH** (수학) — formal-proof 검증율 (Lean/Coq kernel-check) · answer-proof coherence. falsifier = verify gap (답 ≠ 증명).
> - **VERTICAL/BIO** (생명과학) — bio-specialization gain · in-silico↔in-vitro · wet-lab 검증. falsifier = specialization 무의미 / 계산↔실험 correlation 붕괴.
> - **VERTICAL/MEDICAL** (임상) — clinical safety · 진단/처방. falsifier = 임상 안전성 위반.
> - **VERTICAL/SCIENCE (이 문서)** — 물리·화학·일반과학 추론 (GPQA · multi-step 유도). falsifier = **derive gap (사실 암기 ≠ 다단계 유도 · shallow knowledge)** · 단위/차원 불일치 · 사이비 가설(비-falsifiable). MATH 의 formal-proof 도, BIO 의 wet-lab 도 아닌 **일반과학 추론 깊이** layer.
>
> **⚠ recipe ≠ measurement — 다른 layer:**
> - (build recipe) = **RECIPE** (어떻게 만드나 · science SFT/RL · multi-step CoT corpus · GPQA-style 유도 데이터). 과학 모델 build spec.
> - **VERTICAL/SCIENCE 도메인 (이 문서)** = **MEASUREMENT** (얼마나 잘 유도하나 · multistep derive 정확도 · 단위 일관성 · 가설 falsifiability). GPQA 의 graduate-level science reasoning 이 본 측정의 truth surface.
>
> **Falsifier class:** derive_ratio < 40% (다단계 유도 < 단답 사실 × 0.4) → 사실 암기는 되나 유도 못함 (shallow knowledge · derive gap). 또는 물리 계산 단위 불일치 답 > 10% (dimensional analysis 붕괴). 또는 생성 가설 중 testable/falsifiable 비율 < 70% → 사이비 과학 (non-Popperian).

## North-star

같은 문제 surface 위에서, 과학 모델이 (a) 단답 사실을 맞히는가, (b) 그 사실들을 엮어 다단계 유도(GPQA 물리/화학 derive)까지 해내는가, (c) 물리 계산의 단위/차원이 일관되는가, (d) 진짜 반증가능한(falsifiable) 과학적 가설을 생성하는가 — 사실 암기와 과학적 추론·방법론 사이의 gap 을 측정한다.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> SCIENCE 는 완료되지 않는다. 새 science model·reasoning 패러다임·benchmark (GPQA·SciBench·OlympiadBench 이후)가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — multi-step 유도 능력 (closed-form baseline)
- [x] A1 — multi-step 유도 능력 · 5 model × {single_fact_acc, multistep_derive_acc}. GPQA 물리/화학 다단계 유도 vs 단답 사실. 반증자: `derive_ratio < 40%` (다단계 유도 < 단답 사실 × 0.4) → 사실 암기는 되나 유도 못함 (shallow knowledge · derive gap). **CYCLE-10 first probe (2026-05-28 · VERTICAL/SCIENCE 신규 도메인):** `VERTICAL/SCIENCE/bench/science_a1_multistep_derive.hexa` + `VERTICAL/SCIENCE/verify/numerics_science_a1_multistep_derive.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL + 🟡 BY-CITATION. Identity: `derive_ratio_pct = multistep × 100 / single_fact` (acc × 100 ledger · × 100 factors cancel → ratio in plain %) · falsifier `ratio < 40%`. Worked example 5 models × {single_fact, multistep_derive}: **gpt5_science (88/76 · ratio 86% silent)** · **o1_reasoning (85/74 · 87% silent)** · **gemini_science (86/72 · 83% silent)** · **lookup_model (85/25 · 29% FIRES · 사실만 암기 · derive gap)** · **weak_sci (70/20 · 28% FIRES · 얕은 지식)** — bidirectional 3 silent (유도가 사실을 따라옴 · reasoner) + 2 fires (lookup/weak · derive gap) + sanity (multistep ≤ single_fact all · multi ⊆ single · reasoner ratio monotone o1 87 ≥ gpt5 86 ≥ gemini 83). 단위테스트 bidirectional: o1_science (single 88·multi 78 → 88% silent · int-div floor) vs lookup_model (single 85·multi 25 → 29% fires). Verdict `VERTICAL/SCIENCE/verdicts/a1_multistep_derive_verdict.txt`. External anchors: Rein 2023 GPQA (arXiv:2311.12022) · Wang 2023 SciBench (arXiv:2307.10635) · He 2024 OlympiadBench (arXiv:2402.14008). sentinel `__HEXA_CODEX_SCIENCE_A1_MULTISTEP_DERIVE__ DONE` (bench) + `__HEXA_CODEX_NUMERICS_SCIENCE_A1__ DONE` (verify). **실측 측정 DEFERRED** — cycle-11+ T4 (GPQA single-fact + multi-step derive harness on lm_foundry eval + HF transformers + vast.ai pod). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — identity close ≠ measured close.

### 축 B — 단위/차원 일관성 (measured ladder)
- [ ] B1 — 단위/차원 일관성 · 물리 계산의 dimensional analysis. 모델이 답을 낼 때 단위(SI dimension)가 일관되는가 — 차원이 안 맞는 답을 거르는가. 반증자: 단위 불일치 답 > 10% → dimensional analysis 붕괴 (수치는 맞아도 단위 틀림 · 물리적으로 무의미한 답). 물리 word-problem / SciBench dimensional 채점 surface. (measured tier 필요 — cycle-11+ T4.)

### 축 N — 🆕 NOVEL: 반증가능 가설 생성 (falsifiable hypothesis ⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — SCIENCE self-NOVEL. Popper falsifiability — 모델이 진짜 과학적 가설(실험으로 반증 가능한)을 생성하는가, 아니면 반증 불가능한 사이비-과학 진술을 내놓는가. 도착지 없음. 외부 anchor: Popper 1959 (Logic of Scientific Discovery · falsifiability 기준) · 과학 방법론 literature.
- [ ] N1 — 모델이 falsifiable hypothesis 를 생성하는가 (과학 방법론) · 생성 가설 중 testable/falsifiable 비율. 반증자: 생성 가설 중 testable/falsifiable 비율 < 70% → 사이비 과학 (non-Popperian · 반증 불가능한 진술을 가설로 위장). A 의 derive gap (사실→유도) 와 구분: A = "아는 사실을 엮어 유도하는가", N = "새 가설을 세울 때 그것이 과학적으로 반증가능한가" — N 이 더 근본 (과학 방법론 자체). ⭐ MAIN priority lane · measured-tier 필요.

## SANDBOX 활용 (measurement substrate)

SCIENCE 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — HF transformers infer (GPQA/SciBench/OlympiadBench) / lm_foundry retrain (mac M3 / ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local (closed-form) | `VERTICAL/SCIENCE/verdicts/a1_multistep_derive_verdict.txt` |
| B1 단위/차원 일관성 ladder | SANDBOX bench harness (물리 word-problem / SciBench dimensional) | `VERTICAL/SCIENCE/verdicts/b1_*` |
| N1 ⭐ NOVEL 반증가능 가설 생성 | lm_foundry eval / hypothesis-falsifiability rubric / vast.ai pod | `VERTICAL/SCIENCE/verdicts/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM science-routing wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| multi-step 유도 능력 estimator · 단위/차원 일관성 gate · 반증가능 가설 generator gate | science task 시 multi-step reasoner 라우팅 결정 · 물리 계산 dimensional-check gate · 가설 생성 시 falsifiability gate (사이비-과학 거부) | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **SCIENCE 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반. A1 은 현재 placeholder data 의 closed-form identity (🔵 STRUCTURAL + 🟡 BY-CITATION) — 실측 (🟢 SUPPORTED-NUMERICAL) 아님.
- **fact ≠ derivation.** 과학 추론의 핵심 분리 — 단답 사실 암기(single_fact) 와 다단계 유도(multistep_derive) 는 다른 능력. 사실은 알아도 유도 못할 수 있다 (derive gap · shallow knowledge). 사실 암기를 추론으로 착각하지 않는다.
- **SCIENCE ≠ MATH ≠ BIO ≠ MEDICAL.** 본 도메인은 물리·화학·일반과학 추론 layer — 수학(formal-proof) · 생명과학(wet-lab) · 임상(clinical) 과 다른 falsifier. 다른 vertical 의 finding 을 SCIENCE 결과로 섞지 않는다.
- **recipe ≠ measurement.** build recipe = 만들기 · SCIENCE 도메인 = 측정. 둘을 섞지 않는다.
- **falsifiability = Popper 기준.** 축 N 의 truth oracle 은 가설의 반증가능성(testable/falsifiable) — LLM 자기-판정 아님 (`cx_claim_verify` self-judge 금지). 가능한 한 외부 rubric / 독립 채점 기준.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: derive_ratio < 40% → 사실 암기는 되나 유도 못함 (derive gap) · 단위 불일치 > 10% → dimensional analysis 붕괴 · falsifiable 비율 < 70% → 사이비 과학
> **Anticipated ENGINE behavior wire**: science-task multi-step reasoner 라우팅 router · 물리 계산 dimensional-check gate · 가설 생성 falsifiability gate (non-Popperian 거부)
>
> ⏸ DEFERRED waiting on cycle-11+ T4 measured fire (GPQA single-fact + multi-step derive + dimensional consistency + hypothesis falsifiability rate).

## Cross-refs

- 후보 카탈로그: [`../../AXIS.easy.md`](../../ARCHITECTURE.json)
- ENGINE intake matrix (driving lane): [`../../ENGINE/ENGINE.md`](../../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../../SANDBOX.md`](../../ARCHITECTURE.json)
- vertical sibling (반드시 구분): [`../MATH/MATH.md`](../MATH/MATH.md) (수학 · formal-proof) · [`../CODE/CODE.md`](../CODE/CODE.md) (코드) · [`../BIO/BIO.md`](../BIO/BIO.md) (바이오/생명과학 · wet-lab) · [`../MEDICAL/MEDICAL.md`](../MEDICAL/MEDICAL.md) (임상)
- 뉴로 측정 sibling (해석성 lane): [`../../NEUROEXP/NEUROEXP.md`](../../NEUROEXP/NEUROEXP.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- this domain: [`SCIENCE.md`](SCIENCE.md) (snapshot) · [`SCIENCE.log.md`](SCIENCE.log.md) (history)
