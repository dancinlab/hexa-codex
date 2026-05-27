# OBSERVABILITY — 관제탑

@title: 📡 OBSERVABILITY — "관제탑"
@goal: **production LLM serving/eval 의 drift·degradation·incident 를 얼마나 빨리·확실히 감지하는가 (관제탑) 를 영구 측정·확장하는 lane.** 새 drift detector·metric·alert policy·incident class 가 등장할 때마다 측정 frontier 가 다시 열린다. **도착지 없음 · 종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> orchestra-research 20-skill 누락 흡수 (cycle-10) — "Observability" 카테고리가 기존 hexa-codex 도메인에 흡수처가 없어 **신규 단독 도메인** 으로 승격. ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** detection_latency > 1 batch 인데 drift_magnitude > 10% → 관제탑이 큰 분포 변화를 즉시 못 잡고 silent degradation 을 놓침 (관제 실패). 또는 silent corruption 감지율 < loud failure 감지율 × 0.5 → 관제탑이 조용한 degradation 을 못 봄.
>
> **Sibling parallel:** [`RELIABILITY`](../RELIABILITY/RELIABILITY.md) 은 '오타 안 나는가 (정확도/형식 신뢰성)', OBSERVABILITY 는 '망가지는 걸 제때 보는가 (관제·감지)' — 신뢰성 lifecycle 의 눈. production 의 가장 위험한 건 crash 가 아니라 silent degradation.

## North-star

같은 serving stack 에서, distribution drift / 품질 degradation / incident 가 들어왔을 때 관제탑이 그것을 **몇 batch 만에**, **얼마나 확실히** 감지하는가 — 특히 crash 같은 loud failure 가 아니라 조용히 품질이 깎이는 silent corruption 을 볼 수 있는가.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> OBSERVABILITY 은 완료되지 않는다. 새 drift detector·metric·alert policy·incident class 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — drift detection latency (closed-form baseline · orchestra Observability 흡수)
- [x] A1 — drift detection latency · 5 monitoring 시나리오 × {drift_magnitude_pct, detection_latency_batches}. 반증자: detection_latency > 1 batch 인데 drift_magnitude > 10% → silent degradation 놓침 (관제 실패). **CYCLE-10 (2026-05-28) · orchestra Observability 흡수:** `OBSERVABILITY/bench/observability_a1_drift_detection.hexa` + `OBSERVABILITY/verify/numerics_observability_a1_drift_detection.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL + 🟡 BY-CITATION. Identity: drift 감지까지 걸린 batch 수 · falsifier `falsifier_fires = (drift_magnitude > 10%) AND (detection_latency > 1 batch)` — 큰 drift 인데 1 batch 안에 못 잡음. Worked example 5 scenarios × {drift_magnitude, detection_latency}: **good_fast (25% drift · 1 batch · silent · good-monitor 즉시 감지)** · **good_med (15% drift · 1 batch · silent · good-monitor 즉시)** · **low_drift (5% drift · 3 batch · silent · 작은 drift ≤ 10% 무해)** · **blind_big (30% drift · 4 batch · FIRES · silent degradation 놓침)** · **blind_med (18% drift · 2 batch · FIRES · latency > 1)** — bidirectional 2 fires (blind-monitor · 큰 drift 늦게 감지 · 관제 실패) + 3 silent (good-monitor 즉시 + 작은 drift 무해) + conjunction sanity (큰 drift 단독·느린 latency 단독 둘 다 silent — silent degradation = 큰 변화 AND 늦게 잡힘). Verdict `OBSERVABILITY/verdicts/a1_drift_detection_verdict.txt`. External anchors: Quinonero-Candela 2009 Dataset Shift (MIT Press) · Gama 2014 Concept Drift Adaptation survey (DOI:10.1145/2523813) · Breck 2017 ML Test Score (Google · production ML monitoring) · Klaise 2020 Monitoring models in production (arXiv:2007.06299). **실측 측정 DEFERRED** — cycle-11+ T4 (production monitoring trace + PSI/KL drift detector batch-level alert latency on streaming eval · lm_foundry + vast.ai pod). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — identity close ≠ measured close. 축 N (silent-corruption vs loud-failure 감지 비대칭) ⭐ MAIN priority lane.

### 축 B — metric coverage (measured ladder)
- [ ] B1 — metric coverage · TTFT·TPOT·tok/s·GPU-util 모니터 coverage. 반증자: production incident 의 < 50% 가 기존 메트릭으로 사전 감지 안 됨 (메트릭 dashboard 가 incident 의 절반도 못 미리 보면 coverage 부족 — 관제 사각지대).

### 축 N — 🆕 NOVEL: silent-corruption vs loud-failure 감지 비대칭 (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — OBSERVABILITY self-NOVEL. production 의 가장 위험한 건 crash 가 아니라 silent degradation. 도착지 없음. 외부 anchor: Breck 2017 ML Test Score · Klaise 2020 monitoring · Gama 2014 concept drift.
- [ ] N1 — loud failure (crash·exception·NaN) 는 쉽게 감지 · silent corruption (조용한 품질 저하 · 미세 distribution shift · 답변 품질 drift) 는 어렵다 — 둘의 감지율 비대칭 측정. 반증자: silent corruption 감지율 < loud failure 감지율 × 0.5 → 관제탑이 조용한 degradation 을 못 봄 (loud 만 보이는 반쪽 관제).

## SANDBOX 활용 (measurement substrate)

OBSERVABILITY 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — production monitoring trace replay / llama-server serving bench / HF transformers eval / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `OBSERVABILITY/verdicts/a1_*` |
| B1 ladder | SANDBOX serving bench harness (TTFT/TPOT/tok-s/GPU-util) | `OBSERVABILITY/verdicts/b1_*` |
| N1 ⭐ NOVEL | monitoring trace replay / streaming eval / vast.ai pod | `OBSERVABILITY/verdicts/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM serving-monitoring wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| drift-detection latency budget · metric coverage gate · silent-corruption detector | drift alert latency SLO · serving metric dashboard 설계 · silent-degradation 감지기 | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **OBSERVABILITY 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반. A1 은 현재 placeholder data 의 closed-form identity (🔵 STRUCTURAL + 🟡 BY-CITATION) — 실측 (🟢 SUPPORTED-NUMERICAL) 아님.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: detection_latency > 1 batch 인데 drift > 10% → silent degradation 놓침 (관제 실패) · silent corruption 감지율 < loud failure 감지율 × 0.5 → 반쪽 관제
> **Anticipated ENGINE behavior wire**: drift alert latency SLO router · serving metric coverage gate · silent-corruption 감지기
>
> ⏸ DEFERRED waiting on cycle-11+ T4 measured fire (production monitoring trace + PSI/KL drift detector batch-level alert latency + silent-corruption vs loud-failure 감지율 비대칭).

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 신뢰성 sibling (오타/정확도 신뢰성 ↔ 본 도메인 감지/관제): [`../RELIABILITY/RELIABILITY.md`](../RELIABILITY/RELIABILITY.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 흡수 출처 (cycle-10): orchestra-research 20-skill "Observability" 누락 흡수
- 기존 sibling 참고 (축 구조 패턴): [`../DATA-QUALITY/DATA-QUALITY.md`](../DATA-QUALITY/DATA-QUALITY.md) · [`../MULTIMODAL/MULTIMODAL.md`](../MULTIMODAL/MULTIMODAL.md) · [`../LONG-CONTEXT/LONG-CONTEXT.md`](../LONG-CONTEXT/LONG-CONTEXT.md)
- this domain: [`OBSERVABILITY.md`](OBSERVABILITY.md) (snapshot) · [`OBSERVABILITY.log.md`](OBSERVABILITY.log.md) (history)
