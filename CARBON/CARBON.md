# CARBON — 탄소 발자국

@title: 🌳 CARBON — "탄소 발자국"
@goal: **토큰당 CO2 배출량 + region grid carbon 강도를 영구 측정·감축하는 lane.** 새 grid·region·model lifecycle 가 등장할 때마다 측정 frontier 가 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Candidate sibling from [`AXIS.easy.md`](../ARCHITECTURE.json) (브레인스토밍 ⭐⭐). ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** 친환경 region 으로 옮겨도 탄소 감소 < 20% → routing 무의미
>
> **Sibling parallel:** ENERGY 는 'watt', CARBON 은 'watt × grid mix' — 한 단계 위 (ENERGY 가 입력)

## North-star

친환경 시간대에 빨래 돌리기처럼, 학습/추론도 친환경 region/시간대로 routing 하면 탄소 ↓.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> CARBON 은 완료되지 않는다. 새 grid·region·model lifecycle 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — first probe (closed-form baseline)
- [x] A1 — gCO2/token (region별 grid carbon × tokens/J). 반증자: 친환경 region 으로 옮겨도 탄소 감소 < 20% → routing 무의미. _CYCLE-9 round-7 wire — closed-form 7/7 (🔵 STRUCTURAL + 🟡 BY-CITATION) · placeholder 4 regions (nuclear-fr 97% · solar-ca 90% · mixed-de 62% · coal-pl 0% baseline → falsifier fires) · anchors Patterson 2022 (arXiv:2204.05149) · Luccioni 2022 BLOOM · Schwartz 2020 Green AI · substrate fire DEFERRED ([[feedback_closure_is_physical_limit]] — formula close ≠ measured close)._

### 축 B — second probe (measured ladder)
- [ ] B1 — region × time-of-day × workload 의 carbon ladder. 반증자: 다양 region 간 carbon 격차 < 2× → grid mix 균질화 (routing 이득 작음).

### 축 N — 🆕 NOVEL: training-vs-inference carbon ratio (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — CARBON 의 self-NOVEL axis. LLM 생애주기 carbon 이 학습 vs 추론 어디 hotspot 인가 — 인기 모델은 inference dominant. 외부 anchor: Patterson 2022 lifecycle carbon · Luccioni 2022 BLOOM · Schwartz 2020 Green AI.
- [ ] N1 — model 별 train CO2 vs (lifetime inference CO2 추정) 비교. 반증자: popular 모델 (10M+ inference/day) 의 inference cumulative CO2 < train CO2 × 0.5 → hotspot 잘못 추정.

## SANDBOX 활용 (measurement substrate)

CARBON 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `.verdicts/CARBON/a1_*` |
| B1 ladder | SANDBOX bench harness | `.verdicts/CARBON/b1_*` |
| N1 ⭐ NOVEL | mac M3 / vast.ai pod | `.verdicts/CARBON/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| carbon-aware schedule | carbon-aware region/time routing · 친환경 시간대 학습 schedule · inference 효율 우선 | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **CARBON 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter (H, I, J, ...) 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: 친환경 region 으로 옮겨도 탄소 감소 < 20% → routing 무의미
> **Anticipated ENGINE behavior wire**: grid-aware region routing · per-token gCO2 budget allocator
> **Status path**: [`../CALIBRATION/CALIBRATION.md`](../CALIBRATION/CALIBRATION.md) ← reference 패턴 (cycle-10 round-1 promoted to ENGINE axis G).

> ⏸ DEFERRED waiting on cycle-10+ T4 measured fire.

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../ARCHITECTURE.json)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../ARCHITECTURE.json)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../ECONOMICS.md`](../ARCHITECTURE.json) · [`../NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md)
- this domain: [`CARBON.md`](CARBON.md) (snapshot) · [`CARBON.log.md`](CARBON.log.md) (history)
