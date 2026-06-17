# MATERIALS — 신소재 탐험가

@title: 🧪 MATERIALS — "신소재 탐험가"
@goal: **신소재 발견 전문 모델이 in-silico (DFT / ML potential) 로 안정하다 예측한 신물질이 실제 합성·실험으로 확인되는가 (in-silico↔합성 gap), 그리고 그 예측 물질의 합성 경로가 실험실에서 실현 가능한가를 영구 측정·확장하는 lane.** 새 발견 모델·결정구조 생성 패러다임·합성 검증 benchmark (GNoME · MatterGen 이후)가 등장할 때마다 측정 frontier 가 다시 열린다. **도착지 없음 · 종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> **VERTICAL 전문 모델 측정 도메인군 (VERTICAL/\*)** 의 MATERIALS 노드 — 신소재 발견 전문 모델 측정 (GNoME 식 frontier). sibling = VERTICAL/SCIENCE (과학 추론) · VERTICAL/BIO (바이오/의료) · VERTICAL/CODE (코드) · VERTICAL/MATH (수학). vertical specialization 이 "결정구조 안정성 예측"을 넘어 "실제 합성·검증"까지 가는가를 closed-form 으로 측정한다.
>
> **⚠ MATERIALS ≠ SCIENCE ≠ BIO — 다른 vertical · 다른 falsifier (반드시 구분):**
> - **VERTICAL/SCIENCE** (물리·화학·일반과학) — multi-step 유도 추론 (GPQA · 단답 사실 → 다단계 유도). falsifier = **derive gap** (사실 암기 ≠ 다단계 유도 · shallow knowledge). 유도 추론 layer.
> - **VERTICAL/BIO** (바이오/생명과학) — bio-specialization gain · in-silico↔in-vitro · **wet-lab** 검증 (단백질 구조 · MedQA). falsifier = specialization 무의미 / 계산↔실험(wet-lab) correlation 붕괴.
> - **VERTICAL/MATERIALS (이 문서)** — 신소재 발견 (GNoME · 결정구조 예측 · **합성 가능성**). falsifier = **in-silico↔합성 gap** — 계산으로 안정하다 예측된 신물질이 실제 합성으로 확인 안 됨 (in-silico 환상). BIO 의 wet-lab 검증과 표면상 비슷해 보이나 **다른 layer** — BIO = 생물학적 truth (단백질·약물 활성) · MATERIALS = 무기 결정 합성 truth (ICSD/Materials Project 등록 · 합성 레시피). SCIENCE 의 유도-추론 깊이도 아닌 **신물질 발견 → 합성 실현** layer.
>
> **⚠ recipe ≠ measurement — 다른 layer:**
> - (build recipe) = **RECIPE** (어떻게 만드나 · materials discovery SFT/RL · 결정구조 생성 corpus · DFT-안정성 라벨). 신소재 모델 build spec.
> - **VERTICAL/MATERIALS 도메인 (이 문서)** = **MEASUREMENT** (얼마나 잘하나 · 합성률 · property 예측 MAE · 합성경로 실현가능성). GNoME 의 380k 안정 결정 예측 + ICSD/Materials Project 합성-검증 cross-ref 이 본 측정의 truth surface.
>
> **Falsifier class:** synthesis_rate < 50% (예측 신물질의 실제 합성 가능성 < 50% · in-silico 환상 → 계산 예측이 실험으로 확인 안 됨). 또는 property 예측 (bandgap/formation-energy) MAE > 10% (DFT 대비). 또는 제안 합성경로의 실험실 성공률 < 30% (the synthesis bottleneck).

## North-star

같은 신물질 후보 surface 위에서, 신소재 발견 모델이 (a) in-silico 로 안정하다 예측한 결정구조가 실제 합성·실험으로 확인되는가 (synthesis rate), (b) property (bandgap·formation-energy) 예측이 DFT 와 일치하는가, (c) 제안한 합성 경로가 실험실에서 실현 가능한가 — 계산 예측(in-silico)과 실제 합성·실험(experiment) 사이의 gap 을 측정한다. GNoME 의 380k 안정 결정 예측 중 실제로 합성 가능한 비율이 본 frontier 의 핵심 surface.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> MATERIALS 는 완료되지 않는다. 새 발견 모델·결정구조 생성 패러다임·합성 검증 benchmark (GNoME·MatterGen·M3GNet 이후)가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — in-silico↔합성 gap (closed-form baseline)
- [x] A1 — in-silico↔합성 gap · 5 model × {predicted_stable, synthesized_confirmed}. GNoME 식 신물질 예측 후 실제 합성 검증. 반증자: `synthesis_rate < 50%` (예측 신물질의 합성 가능성 < 50% · in-silico 환상) → 계산 예측이 실험으로 확인 안 됨. **CYCLE-10 first probe (2026-05-28 · VERTICAL/MATERIALS 신규 도메인):** `VERTICAL/MATERIALS/bench/materials_a1_synthesis_gap.hexa` + `VERTICAL/MATERIALS/verify/numerics_materials_a1_synthesis_gap.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL + 🟡 BY-CITATION. Identity: `synthesis_rate_x100 = synthesized_confirmed × 100 / predicted_stable` (정수 % · floor div) · falsifier `rate < 50%`. Worked example 5 models × {predicted_stable, synthesized_confirmed}: **gnome (1000/736 · rate 73% silent · GNoME SOTA)** · **mattergen (1000/680 · 68% silent)** · **m3gnet (1000/620 · 62% silent)** · **naive_gen (1000/200 · 20% FIRES · 계산 예측 ≠ 합성 truth)** · **random_struct (1000/50 · 5% FIRES · baseline floor)** — bidirectional 3 silent (예측이 실험으로 확인됨 · 강한 발견 모델) + 2 fires (naive/random · in-silico 환상) + sanity (confirmed ≤ predicted all · rate ≤ 100% · discovery monotone gnome 73 ≥ mattergen 68 ≥ m3gnet 62). 단위테스트 bidirectional: gnome (pred 1000·confirmed 736 → 73% silent) vs naive_gen (pred 1000·confirmed 200 → 20% fires). Verdict `VERTICAL/MATERIALS/verdicts/a1_synthesis_gap_verdict.txt`. External anchors: Merchant 2023 GNoME (Nature 624:80) · Zeni 2024 MatterGen (arXiv:2312.03687) · Chen 2022 M3GNet (Nature Comp Sci) · Materials Project. sentinel `__HEXA_CODEX_MATERIALS_A1_SYNTHESIS_GAP__ DONE` (bench) + `__HEXA_CODEX_NUMERICS_MATERIALS_A1__ DONE` (verify). **실측 측정 DEFERRED** — cycle-11+ T4 (GNoME-style 안정성 예측 + ICSD/Materials Project 합성-검증 cross-ref harness on lm_foundry eval + HF transformers + vast.ai pod). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — identity close ≠ measured close.

### 축 B — property 예측 정확도 (measured ladder)
- [ ] B1 — property 예측 정확도 · bandgap / formation-energy 예측 MAE (DFT ground-truth 대비). 모델이 결정구조의 물성을 얼마나 정확히 예측하는가 — 안정성 예측이 맞아도 물성이 틀리면 발견은 무의미. 반증자: DFT 대비 MAE > 10% → property 예측 신뢰 불가 (구조는 맞아도 물성 틀림 · 무용한 신물질). Materials Project / Matbench property 채점 surface. (measured tier 필요 — cycle-11+ T4.)

### 축 N — 🆕 NOVEL: 합성 경로 실현가능성 (synthesis route feasibility ⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — MATERIALS self-NOVEL. GNoME 380k 예측 중 실제 합성 가능한 비율 (the synthesis bottleneck). 결정구조가 안정하다 예측돼도 실험실에서 만들 합성 경로(precursor·온도·압력·반응 조건)가 실현 불가능하면 발견은 종이 위에만 존재. 도착지 없음. 외부 anchor: Merchant 2023 GNoME (Nature · 736 실험 합성 검증 · 380k 안정 예측 중 극소수만 합성) · Szymanski 2023 A-Lab (Nature 624:86 · 자율 합성 로봇 41/58 target) · Materials Project / ICSD 합성 레시피.
- [ ] N1 — 모델이 예측한 신물질의 실제 합성 경로가 실험실에서 실현 가능한가 · 제안 합성경로의 실험실 성공률. 반증자: 제안 합성경로의 실험실 성공률 < 30% → 합성 경로 실현 불가 (in-silico 안정성은 있으나 만들 길이 없음 · the synthesis bottleneck). A 의 in-silico↔합성 gap (합성됐는가 사후 확인) 와 구분: A = "예측된 게 어디선가 합성된 적 있는가 (existence)", N = "이 모델이 제안한 합성 레시피로 실제로 만들 수 있는가 (route feasibility)" — N 이 더 근본 (발견 → 제조 실현 자체). ⭐ MAIN priority lane · measured-tier 필요.

## SANDBOX 활용 (measurement substrate)

MATERIALS 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — HF transformers eval (결정구조 안정성 / property) / lm_foundry retrain (mac M3 / ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local (closed-form) | `verdicts/a1_synthesis_gap_verdict.txt` |
| B1 property 예측 정확도 ladder | SANDBOX bench harness (Materials Project / Matbench bandgap·formation-energy) | `verdicts/b1_*` |
| N1 ⭐ NOVEL 합성 경로 실현가능성 | lm_foundry / HF eval / A-Lab 식 synthesis-route rubric / vast.ai pod | `verdicts/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM materials-routing wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| in-silico↔합성 gap estimator · property 예측 MAE gate · 합성경로 실현가능성 router | materials task 시 발견 모델 라우팅 결정 · property 예측 confidence gate · 합성경로 제안 시 실현가능성 gate (in-silico 환상 거부) | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **MATERIALS 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반. A1 은 현재 placeholder data 의 closed-form identity (🔵 STRUCTURAL + 🟡 BY-CITATION) — 실측 (🟢 SUPPORTED-NUMERICAL) 아님.
- **in-silico ≠ 합성.** 신소재 발견의 핵심 분리 — 계산(DFT/ML)으로 안정하다 예측(predicted_stable) 과 실제 합성·검증(synthesized_confirmed) 은 다르다. 계산은 안정하다 해도 합성 못할 수 있다 (in-silico 환상 · the synthesis bottleneck). 계산 예측을 실험 확인으로 착각하지 않는다.
- **MATERIALS ≠ SCIENCE ≠ BIO.** 본 도메인은 신물질 발견 → 합성 실현 layer — 과학 추론(derive gap) · 바이오 wet-lab(생물학적 truth) 과 다른 falsifier. BIO 의 in-silico↔in-vitro 와 표면상 비슷하나 다른 truth surface (무기 결정 합성 vs 생물학적 활성). 다른 vertical 의 finding 을 MATERIALS 결과로 섞지 않는다.
- **recipe ≠ measurement.** build recipe = 만들기 · MATERIALS 도메인 = 측정. 둘을 섞지 않는다.
- **합성 truth = 실험 oracle.** 축 N 의 truth oracle 은 실제 합성 성공률 (ICSD/Materials Project 등록 · A-Lab 식 자율 합성) — LLM 자기-판정 아님 (`cx_claim_verify` self-judge 금지). 가능한 한 외부 실험 데이터베이스 / 독립 합성 검증.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: synthesis_rate < 50% → in-silico 환상 (예측 ≠ 합성) · property MAE > 10% → property 예측 신뢰 불가 · 합성경로 성공률 < 30% → 합성 경로 실현 불가 (synthesis bottleneck)
> **Anticipated ENGINE behavior wire**: materials-task 발견 모델 라우팅 router · property 예측 confidence gate · 합성경로 실현가능성 gate (in-silico 환상 거부)
>
> ⏸ DEFERRED waiting on cycle-11+ T4 measured fire (GNoME-style 안정성 예측 + ICSD/Materials Project 합성-검증 rate + property MAE + 합성경로 실험실 성공률).

## Cross-refs

- 후보 카탈로그: [`../../AXIS.easy.md`](../../ARCHITECTURE.json)
- ENGINE intake matrix (driving lane): [`../../ENGINE/ENGINE.md`](../../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../../SANDBOX.md`](../../ARCHITECTURE.json)
- vertical sibling (반드시 구분): [`../SCIENCE/SCIENCE.md`](../SCIENCE/SCIENCE.md) (물리·화학·일반과학 추론 · derive gap) · [`../BIO/BIO.md`](../BIO/BIO.md) (바이오/생명과학 · wet-lab · in-silico↔in-vitro) · [`../CODE/CODE.md`](../CODE/CODE.md) (코드) · [`../MATH/MATH.md`](../MATH/MATH.md) (수학 · formal-proof)
- 뉴로 측정 sibling (해석성 lane): [`../../NEUROEXP/NEUROEXP.md`](../../NEUROEXP/NEUROEXP.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- this domain: [`MATERIALS.md`](MATERIALS.md) (snapshot) · [`MATERIALS.log.md`](MATERIALS.log.md) (history)
