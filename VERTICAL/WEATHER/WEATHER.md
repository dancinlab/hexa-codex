# WEATHER — 기상 예보관

@title: ⛅ WEATHER — "기상 예보관"
@goal: **기상/기후 foundation model (AI weather — GraphCast·Pangu·Aurora·GenCast 계열)이 (a) 전통 물리 수치예보(NWP) baseline 을 forecast skill 에서 실제로 능가하는가, (b) 허리케인·폭염 같은 tail-event(극단 기상)를 평균만이 아니라 극단까지 맞히는가, (c) 예보 기간(lead-time)이 길어질수록 skill 이 어떻게 감쇠하는가 (chaos predictability horizon) 를 영구 측정·확장하는 lane.** 새 AI weather model·기후 패러다임·benchmark 가 등장할 때마다 측정 frontier 가 다시 열린다. **도착지 없음 · 종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> **VERTICAL 전문 모델 측정 도메인군 (VERTICAL/\*)** 의 WEATHER 노드 — 기상/기후(AI weather foundation model) 측정. sibling = VERTICAL/SCIENCE (물리·화학·일반과학) · VERTICAL/MATH (수학) · VERTICAL/CODE (코드) · VERTICAL/BIO (바이오/의료) · VERTICAL/MEDICAL (임상). vertical specialization 이 "데이터-드리븐 모델이 물리 수치예보를 능가하는가 · 극단 기상까지 맞히는가 · 장기 예보의 물리적 한계는 어디인가"를 closed-form 으로 측정한다.
>
> **⚠ WEATHER ≠ SCIENCE ≠ MATH ≠ CODE — 다른 vertical · 다른 falsifier (반드시 구분):**
> - **VERTICAL/SCIENCE** (물리·화학·일반과학) — multi-step 유도 능력 (GPQA derive). falsifier = derive gap (사실 암기 ≠ 다단계 유도).
> - **VERTICAL/MATH** (수학) — formal-proof 검증율 (Lean/Coq kernel-check). falsifier = verify gap (답 ≠ 증명).
> - **VERTICAL/CODE** (코드) — compile/test pass · 실행 정확도. falsifier = 실행 실패 / 테스트 미통과.
> - **VERTICAL/WEATHER (이 문서)** — 기상/기후 예보 (10-day forecast ACC/RMSE skill score). falsifier = **AI forecast skill < 물리 NWP baseline (전통 수치예보 못 이김)** · 극단 기상 recall < 70% · lead-time skill 붕괴 (chaos horizon). SCIENCE 의 derive gap 도, MATH 의 formal-proof 도 아닌 **물리 vs 데이터-드리븐 예보 능력** layer.
>
> **⚠ recipe ≠ measurement — 다른 layer:**
> - (build recipe) = **RECIPE** (어떻게 만드나 · ERA5 reanalysis 학습 · GNN/transformer 구조 · diffusion ensemble). AI weather 모델 build spec.
> - **VERTICAL/WEATHER 도메인 (이 문서)** = **MEASUREMENT** (얼마나 잘 예보하나 · NWP 대비 forecast skill ratio · 극단 recall · lead-time decay). WeatherBench / ERA5 10-day ACC/RMSE skill score 가 본 측정의 truth surface.
>
> **Falsifier class:** skill_ratio < 100% (AI forecast skill < 물리 NWP baseline) → "AI weather 가 물리모델 능가" 주장 반증 (전통 수치예보 못 이김 · closed-negative · 외부 주장 반증). 또는 extreme event recall < 70% (평균은 맞아도 허리케인/폭염 같은 tail-event 놓침). 또는 14-day skill < 1-day skill × 0.3 → 장기 예보 무의미 (Lorenz chaos predictability horizon · 예측 가능 지평 초과).

## North-star

같은 forecast surface 위에서, AI weather foundation model 이 (a) 전통 물리 수치예보(NWP) baseline 을 forecast skill 에서 능가하는가, (b) 극단 기상(허리케인·폭염 tail-event)을 평균뿐 아니라 극단까지 맞히는가, (c) 예보 기간이 길어질수록 skill 이 chaos 한계에 어떻게 부딪히는가 (lead-time decay) — 데이터-드리븐 예보의 능력과 물리적 한계 사이의 gap 을 측정한다.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> WEATHER 는 완료되지 않는다. 새 AI weather model·기후 패러다임·benchmark (GraphCast·Pangu·Aurora·GenCast 이후)가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — forecast skill vs 물리 NWP baseline (closed-form baseline)
- [x] A1 — forecast skill vs 물리 NWP baseline · 5 model × {ai_forecast_skill_x100, nwp_baseline_skill_x100}. 10-day forecast ACC/RMSE skill score · AI weather vs 전통 수치예보. 반증자: `skill_ratio < 100%` (AI forecast skill < 물리 NWP baseline) → "AI weather 가 물리모델 능가" 주장 반증 (전통 수치예보 못 이김). **CYCLE-10 first probe (2026-05-28 · VERTICAL/WEATHER 신규 도메인):** `VERTICAL/WEATHER/bench/weather_a1_forecast_skill.hexa` + `VERTICAL/WEATHER/verify/numerics_weather_a1_forecast_skill.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL + 🟡 BY-CITATION. Identity: `skill_ratio_x100 = ai_skill × 100 / nwp_skill` (skill × 100 ledger · 두 factor 의 × 100 이 ratio 에서 cancel → plain %) · falsifier `ratio < 100%`. Worked example 5 models × {ai_forecast_skill, nwp_baseline_skill}: **graphcast (92/85 · ratio 108% silent · 능가)** · **pangu_weather (90/85 · 105% silent · 능가)** · **aurora (94/85 · 110% silent · 능가)** · **gencast (95/85 · 111% silent · 능가)** · **weak_nn_weather (70/85 · 82% FIRES · 물리 NWP 못 이김)** — bidirectional 4 silent (능가 · NWP-beater) + 1 fires (weak NN · 못 이김 · 외부 '능가' 주장 반증) + sanity (NWP-beaters ai > nwp strict · ratio monotone gencast 111 ≥ aurora 110 ≥ graphcast 108 ≥ pangu 105). 단위테스트 bidirectional: graphcast (ai 92·nwp 85 → 108% silent · int-div floor) vs weak_nn_weather (ai 70·nwp 85 → 82% fires). Verdict `VERTICAL/WEATHER/verdicts/a1_forecast_skill_verdict.txt`. External anchors: Lam 2023 GraphCast (Science 382:1416) · Bi 2023 Pangu-Weather (Nature 619:533) · Bodnar 2024 Aurora (arXiv:2405.13063) · Price 2024 GenCast (Nature). sentinel `__HEXA_CODEX_WEATHER_A1_FORECAST_SKILL__ DONE` (bench) + `__HEXA_CODEX_NUMERICS_WEATHER_A1__ DONE` (verify). **실측 측정 DEFERRED** — cycle-11+ T4 (ERA5 / WeatherBench 10-day ACC/RMSE skill score harness on lm_foundry eval + HF transformers + vast.ai pod). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — identity close ≠ measured close.

### 축 B — 극端 기상 예측 (measured ladder)
- [ ] B1 — 극端 기상 예측 · 허리케인/폭염 tail-event 정확도. AI weather model 이 평균(climatology)만 맞히는가, 아니면 극단(허리케인 강도·폭염 peak·집중호우 같은 distribution tail-event)까지 recall 하는가. 반증자: extreme event recall < 70% (평균만 맞고 극단 놓침) → tail-event 예측 붕괴 (평균 회귀로 극단 smooth-out · 재난 예보로서 무의미). WeatherBench extreme / tropical cyclone track·intensity 채점 surface. (measured tier 필요 — cycle-11+ T4.)

### 축 N — 🆕 NOVEL: lead-time decay (predictability horizon ⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — WEATHER self-NOVEL. Lorenz chaos · predictability horizon (장기 예보의 물리적 한계). 예보 기간(lead-time)이 길어질수록 forecast skill 이 어떻게 감쇠하는가 — 1-day vs 14-day skill decay. 대기는 chaotic system 이라 초기조건 민감성으로 예측 가능 지평(predictability horizon, ~2주)이 물리적으로 존재한다. AI weather 라도 이 한계를 넘을 수 없다 (능가가 아니라 한계 측정). 도착지 없음. 외부 anchor: Lorenz 1963 (Deterministic Nonperiodic Flow · J. Atmos. Sci. 20:130 · chaos 이론 · predictability horizon).
- [ ] N1 — 예보 기간 길수록 skill 감쇠율 (lead-time decay) · 1-day vs 14-day forecast skill. 반증자: 14-day skill < 1-day skill × 0.3 → 장기 예보 무의미 (chaos horizon · 예측 가능 지평 초과 · 14-day 예보가 climatology 수준으로 붕괴). A 의 "물리 NWP 능가 여부" 와 구분: A = "AI 가 물리모델을 이기는가", N = "AI든 물리든 lead-time 이 길어지면 chaos 한계에 부딪히는가" — N 이 더 근본 (예보 능력의 물리적 상한 자체 · Lorenz predictability horizon). ⭐ MAIN priority lane · measured-tier 필요.

## SANDBOX 활용 (measurement substrate)

WEATHER 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — HF transformers infer (ERA5 / WeatherBench) / lm_foundry retrain (mac M3 / ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local (closed-form) | `VERTICAL/WEATHER/verdicts/a1_forecast_skill_verdict.txt` |
| B1 극端 기상 예측 ladder | SANDBOX bench harness (WeatherBench extreme / TC track·intensity) | `VERTICAL/WEATHER/verdicts/b1_*` |
| N1 ⭐ NOVEL lead-time decay | lm_foundry eval / ERA5 multi-lead skill profile / vast.ai pod | `VERTICAL/WEATHER/verdicts/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM weather-routing wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| forecast skill estimator · 극端 기상 recall gate · lead-time predictability-horizon gate | weather task 시 AI-vs-NWP 라우팅 결정 · 극단 기상 예보 시 tail-event recall gate · 장기 예보 요청 시 chaos-horizon 경고 gate (predictability 한계 초과 거부) | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **WEATHER 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반. A1 은 현재 placeholder data 의 closed-form identity (🔵 STRUCTURAL + 🟡 BY-CITATION) — 실측 (🟢 SUPPORTED-NUMERICAL) 아님.
- **AI forecast ≠ 물리 NWP 능가 보장.** WEATHER 측정의 핵심 분리 — AI weather model 이 forecast skill 에서 전통 수치예보를 능가하는지는 task/lead-time 마다 다르다. "AI 가 물리모델을 이긴다"를 무조건 참으로 가정하지 않는다 (skill_ratio < 100% 행이 그 주장을 반증).
- **WEATHER ≠ SCIENCE ≠ MATH ≠ CODE.** 본 도메인은 기상/기후 예보 layer — 과학 추론(derive gap) · 수학(formal-proof) · 코드(compile/test) 와 다른 falsifier. 다른 vertical 의 finding 을 WEATHER 결과로 섞지 않는다.
- **recipe ≠ measurement.** build recipe = 만들기 · WEATHER 도메인 = 측정. 둘을 섞지 않는다.
- **predictability horizon = 물리 한계.** 축 N 의 truth oracle 은 Lorenz chaos 의 예측 가능 지평 (lead-time 이 길어지면 skill 이 물리적으로 붕괴) — LLM 자기-판정 아님 (`cx_claim_verify` self-judge 금지). 가능한 한 외부 ERA5/WeatherBench multi-lead skill profile / 독립 채점.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장 ("AI weather model 이 물리 NWP 를 능가한다" · Lam 2023 / Bi 2023 / Price 2024) 만 반증 — 자가생성 numerology 반증 금지 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: skill_ratio < 100% → AI forecast 가 물리 NWP baseline 못 이김 (능가 주장 반증) · extreme event recall < 70% → tail-event 예측 붕괴 · 14-day skill < 1-day × 0.3 → 장기 예보 무의미 (chaos horizon)
> **Anticipated ENGINE behavior wire**: weather-task AI-vs-NWP 라우팅 router · 극단 기상 tail-event recall gate · 장기 예보 predictability-horizon 경고 gate (chaos 한계 초과 거부)
>
> ⏸ DEFERRED waiting on cycle-11+ T4 measured fire (ERA5 10-day ACC/RMSE skill score + extreme event recall + lead-time decay profile).

## Cross-refs

- 후보 카탈로그: [`../../AXIS.easy.md`](../../ARCHITECTURE.json)
- ENGINE intake matrix (driving lane): [`../../ENGINE/ENGINE.md`](../../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../../SANDBOX.md`](../../ARCHITECTURE.json)
- vertical sibling (반드시 구분): [`../SCIENCE/SCIENCE.md`](../SCIENCE/SCIENCE.md) (물리·화학·일반과학 · derive gap) · [`../MATH/MATH.md`](../MATH/MATH.md) (수학 · formal-proof) · [`../CODE/CODE.md`](../CODE/CODE.md) (코드 · compile/test) · [`../BIO/BIO.md`](../BIO/BIO.md) (바이오/생명과학 · wet-lab) · [`../MEDICAL/MEDICAL.md`](../MEDICAL/MEDICAL.md) (임상)
- 뉴로 측정 sibling (해석성 lane): [`../../NEUROEXP/NEUROEXP.md`](../../NEUROEXP/NEUROEXP.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 음성논문 외부 주장 원칙: [[feedback_negative_paper_external_claim]]
- this domain: [`WEATHER.md`](WEATHER.md) (snapshot) · [`WEATHER.log.md`](WEATHER.log.md) (history)
