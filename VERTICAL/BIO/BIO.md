# BIO — 생명 모델러

@title: 🧬 BIO — "생명 모델러"
@goal: **바이오/의료 전문 모델이 general 모델 대비 얼마나 더 강한가, 그리고 계산 예측(in-silico)이 실제 wet-lab(in-vitro)과 일치하는가를 영구 측정·확장하는 lane.** 새 bio model·bio task·wet-lab 검증 패러다임이 등장할 때마다 측정 frontier 가 다시 열린다. **도착지 없음 · 종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> **VERTICAL 전문 모델 측정 도메인군 (VERTICAL/\*)** 의 BIO 노드 — 바이오/의료 전문 모델 측정. sibling = VERTICAL/CODE (코드 전문 모델). vertical specialization 이 general FM 대비 실제 advantage 를 주는가를 closed-form 으로 측정한다.
>
> **⚠ recipe ≠ measurement — 다른 layer:**
> - [`lm_foundry/docs/bio-llm.md`](../../lm_foundry/docs/bio-llm.md) = **RECIPE** (어떻게 만드나 · §STRUCT dataset · §FLOW 학습 단계 · §EVOLVE eval harness). `hexa-forge bio` 의 build spec.
> - **VERTICAL/BIO 도메인 (이 문서)** = **MEASUREMENT** (얼마나 잘하나 · specialization gain · in-silico↔in-vitro). bio-llm.md §EVOLVE 의 eval harness (MedQA · PubMedQA · ProteinGym) 가 본 측정의 task surface.
> - 구 **BIODATA** (retire 2026-05-27 · 데이터셋 도메인) 와도 별개 — BIODATA finding 은 bio-llm.md §FINDINGS 로 흡수됨 ([[project_bio_reorg_neuroexp_biodata]]). 본 도메인은 데이터셋이 아니라 **모델 측정** layer.
>
> **Falsifier class:** bio-specialized 가 general-model 대비 bio task < 10pp 향상 → specialization 무의미 (general 로 충분). 또는 in-silico 예측이 in-vitro 검증과 correlation < 0.5 → 계산 예측 신뢰 불가.

## North-star

같은 task surface 위에서, 바이오 전문 모델이 general 모델 대비 얼마나 더 잘하는가 — vertical specialization 이 실제 capability 를 주는가, 아니면 general FM 으로 충분한가. 그리고 그 모델 예측이 실제 실험(wet-lab)에서 검증되는가 (AlphaFold 의 wet-lab 검증 패러다임).

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> BIO 는 완료되지 않는다. 새 bio model·bio task·wet-lab 검증 패러다임이 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — bio-specialization advantage (closed-form baseline)
- [x] A1 — bio-specialization advantage · 5 model × {bio_task_acc, general_model_bio_acc}. bio task = MedQA / PubMedQA / 단백질 property. 반증자: bio-specialized 가 general-model 대비 bio task < 10pp 향상 → specialization 무의미 (general 로 충분). **CYCLE-10 (2026-05-28):** `bench/bio_a1_specialization_gain.hexa` + `verify/numerics_bio_a1_specialization_gain.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL + 🟡 BY-CITATION. Identity: `specialization_gain_x100 = bio_specialized_acc − general_model_bio_acc` (× 100 ledger of pp) · falsifier `gain < 10pp` (< 1000 in × 100 ledger). Worked example 5 model × {bio_acc, general_acc}: **med_palm2 (85/60 · gain 25.0pp silent)** · **bio_gpt (80/60 · gain 20.0pp silent)** · **esm_protein (78/55 · gain 23.0pp silent)** · **general_gpt5_on_bio (60/60 · gain 0.0pp FIRES · baseline)** · **shallow_bio_tune (62/60 · gain 2.0pp FIRES)** — bidirectional 3 silent (강한 bio model · specialization 유의미) + 2 fires (general baseline + 얕은 tune · 무의미) + monotone sanity (specialization 깊이 ↔ gain 순서). Verdict `verdicts/a1_specialization_gain_verdict.txt`. External anchors: Singhal 2023 Med-PaLM 2 (arXiv:2305.09617) · Lin 2023 ESM-2 (Science 379:1123) · Jumper 2021 AlphaFold (Nature 596:583) · Luo 2022 BioGPT (arXiv:2210.10341). **실측 측정 DEFERRED** — cycle-11+ T4 (MedQA/PubMedQA/ProteinGym eval on lm_foundry + HF transformers + vast.ai pod). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — identity close ≠ measured close.

### 축 B — 의료 안전성 (measured ladder)
- [ ] B1 — 의료 조언 hallucination / harm rate · 의료 QA 에서 confident-wrong 비율 측정. 반증자: 의료 QA 에서 confident-wrong > 5% → 안전 critical (의료 배포 불가). bio-llm.md §FLOW Stage 4 alignment guard + §VERIFY refusal/clinical-disclaimer contract 와 직결. (`cx_hf_safety_private` — adversarial 의료 set default PRIVATE.)

### 축 N — 🆕 NOVEL: in-silico ↔ in-vitro gap (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — BIO self-NOVEL. 계산 모델의 실험 검증 가능성 (AlphaFold 의 wet-lab 검증 패러다임). 도착지 없음. 외부 anchor: Jumper 2021 AlphaFold (Nature) · Lin 2023 ESM-2/ESMFold (Science) · CASP wet-lab 검증.
- [ ] N1 — 모델 예측 (in-silico) 이 실제 wet-lab (in-vitro) 와 일치하는가 · 예측-검증 correlation. 반증자: in-silico 예측이 in-vitro 검증과 correlation < 0.5 → 계산 예측 신뢰 불가 (모델은 패턴 암기일 뿐 생물학적 truth 미포착).

## SANDBOX 활용 (measurement substrate)

BIO 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — HF transformers eval (MedQA/PubMedQA/ProteinGym) / lm_foundry retrain (mac M3 / ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local (closed-form) | `verdicts/a1_specialization_gain_verdict.txt` |
| B1 의료 안전성 ladder | SANDBOX bench harness (의료 set PRIVATE) | `verdicts/b1_*` |
| N1 ⭐ NOVEL in-silico↔in-vitro | lm_foundry / HF eval / vast.ai pod | `verdicts/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM bio-routing wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| bio-specialization advantage estimator · 의료 안전성 guard budget · in-silico 신뢰도 router | bio-task 시 specialist 라우팅 결정 · 의료 답변 refusal/disclaimer gate · 계산 예측 confidence gate | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **BIO 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반. A1 은 현재 placeholder data 의 closed-form identity (🔵 STRUCTURAL + 🟡 BY-CITATION) — 실측 (🟢 SUPPORTED-NUMERICAL) 아님.
- **recipe ≠ measurement.** bio-llm.md = 만들기 · BIO 도메인 = 측정. 둘을 섞지 않는다. 구 BIODATA (데이터셋) 와도 별개 layer.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **의료 안전 우선.** 의료/clinical 측정은 adversarial set PRIVATE default (`cx_hf_safety_private`) · 모든 clinical 답변 `not a medical diagnosis` boilerplate (bio-llm.md §VERIFY clinical-disclaimer contract).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: bio-specialized < general +10pp → specialization 무의미 · in-silico↔in-vitro correlation < 0.5 → 계산 예측 신뢰 불가
> **Anticipated ENGINE behavior wire**: bio-task specialist 라우팅 router · 의료 답변 safety gate · in-silico confidence gate
>
> ⏸ DEFERRED waiting on cycle-11+ T4 measured fire (MedQA/PubMedQA/ProteinGym eval + 의료 confident-wrong rate + in-silico↔in-vitro correlation).

## Cross-refs

- recipe (만들기 layer · 직결): [`../../lm_foundry/docs/bio-llm.md`](../../lm_foundry/docs/bio-llm.md) — `hexa-forge bio` build spec · §FINDINGS 에 구 BIODATA 흡수
- 후보 카탈로그: [`../../AXIS.easy.md`](../../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../../ENGINE/ENGINE.md`](../../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../../SANDBOX.md`](../../SANDBOX.md)
- 뉴로 측정 sibling (해석성 lane): [`../../NEUROEXP/NEUROEXP.md`](../../NEUROEXP/NEUROEXP.md)
- vertical sibling: VERTICAL/CODE (코드 전문 모델 측정)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- BIO reorg 출처: [[project_bio_reorg_neuroexp_biodata]] (BIODATA 폐기 → bio-llm.md 흡수 · 2026-05-27)
- 기존 sibling 참고 (축 구조 패턴): [`../../MULTIMODAL/MULTIMODAL.md`](../../MULTIMODAL/MULTIMODAL.md) · [`../../DATA-QUALITY/DATA-QUALITY.md`](../../DATA-QUALITY/DATA-QUALITY.md)
- this domain: [`BIO.md`](BIO.md) (snapshot) · [`BIO.log.md`](BIO.log.md) (history)
