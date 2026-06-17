# ROBOTICS — 체화 조종사

@title: 🦾 ROBOTICS — "체화 조종사"
@goal: **로보틱스/embodied 전문 모델의 능력 (sim→real transfer 신뢰도 · 다단계 long-horizon 조작 · 안전 정지 신뢰성) 을 영구 측정·확장하는 lane.** VLA(Vision-Language-Action) 모델이 시뮬에서 실세계 로봇 하드웨어로 넘어갈 때 무너지지 않는가 (reality gap), 다단계 조작을 끝까지 완수하는가, 그리고 위험 상황에서 확실히 멈추는가 (physical AI 안전 critical). 새 VLA model·benchmark·로봇 platform 이 등장할 때마다 측정 frontier 가 다시 열린다. **도착지 없음 · 종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> `VERTICAL/*` 그룹 폴더의 로보틱스 도메인 (cycle-10) — 2026 frontier 의 physical/embodied AI 측정. ROBOTICS = 체화 모델 (로봇 제어 VLA) 측정. ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** sim→real transfer ratio < 50% (real < sim × 0.5) → sim2real gap (시뮬엔 되는데 실제 안 됨 · reality gap). 또는 5-step long-horizon 조작 < single-step × 0.3 → 다단계 조작 못 함. 또는 위험 상황 false-negative (안 멈춤) > 1% → 물리적 위해 (안전 정지 부재).
>
> **Sibling parallel:** AGENT 는 '디지털 도구 사용 trajectory' (N1 multi-step tool-call step-decay), ROBOTICS 는 그 **physical 버전** — 디지털 오류는 재시도로 끝나지만 물리적 위해는 되돌릴 수 없다. SUBSTRATE 는 '능력 일반', VERTICAL/ROBOTICS 는 '체화/물리 제어라는 한 vertical 의 깊이'.

## North-star

시뮬레이션에서 잘 되는 모델(sim_success)이 실제 로봇 하드웨어에서도 그만큼 되는가(real_success) — reality gap 에 무너지지 않는가. 그리고 열기→집기→놓기 같은 다단계(long-horizon) 조작을 끝까지 완수하는가 (단일 동작만 잘하고 chain 은 무너지는가). 마지막으로, 위험 상황을 감지했을 때 확실히 멈추는가 (physical AI 안전의 last line of defense — 디지털 오류와 달리 물리적 위해).

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> ROBOTICS 는 완료되지 않는다. 새 VLA model·benchmark·로봇 platform·task class 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — A1 sim→real transfer 신뢰도 (closed-form baseline · embodied VLA 직결)
- [x] A1 — sim→real transfer 신뢰도 · 5 VLA model × {sim_success, real_success} (LIBERO/SimplerEnv class). 반증자: `transfer_ratio < 50%` (real < sim × 0.5) → sim2real gap (시뮬엔 되는데 실제 안 됨 · reality gap). **CYCLE-10 first probe (2026-05-28 · VERTICAL/ROBOTICS 신규 도메인):** `VERTICAL/ROBOTICS/bench/robotics_a1_sim2real.hexa` + `VERTICAL/ROBOTICS/verify/numerics_robotics_a1_sim2real.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL + 🟡 BY-CITATION. Identity: `transfer_ratio_pct = real_success × 100 / sim_success` (success × 100 ledger · × 100 factors cancel → ratio in plain %) · falsifier `ratio < 50%`. Worked example 5 VLA models × {sim_success, real_success}: **rt2 (85/65 · ratio 76% silent · RT-2)** · **openvla (82/58 · 70% silent · OpenVLA)** · **pi_zero (88/68 · 77% silent · π0 flow)** · **sim_overfit_model (90/30 · 33% FIRES · reality gap)** · **weak_vla (70/25 · 35% FIRES · reality gap)** — bidirectional 3 silent (sim2real 강건) + 2 fires (reality gap) + sim-overfit trap (sim 90 = ladder 최고점인 sim_overfit_model 이 real 30 으로 FIRES — 시뮬 점수만으론 신뢰 불가). Verdict `VERTICAL/ROBOTICS/verdicts/a1_sim2real_verdict.txt`. External anchors: Brohan 2023 RT-2 (arXiv:2307.15818) · Kim 2024 OpenVLA (arXiv:2406.09246) · Black 2024 π0 (arXiv:2410.24164) · Tobin 2017 domain randomization sim→real (arXiv:1703.06907). sentinel `__HEXA_CODEX_ROBOTICS_A1_SIM2REAL__ DONE` (bench) + `__HEXA_CODEX_NUMERICS_ROBOTICS_A1__ DONE` (verify). **실측 측정 DEFERRED** — cycle-11+ T4 (LIBERO/SimplerEnv sim eval + 실제 로봇 rollout transfer harness · vast.ai pod). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — identity close ≠ measured close. 축 N (safe-stop 신뢰성) 다음 ⭐ MAIN priority lane.

### 축 B — B1 long-horizon manipulation (measured ladder)
- [ ] B1 — 다단계 조작 (열기→집기→놓기) 성공률 · 단일 동작 vs 5-step chain 성공률 cross-product fit. 반증자: 5-step 조작 < single-step × 0.3 → 다단계 조작 못 함 (단일 동작만 잘하고 chain 은 step-decay 로 무너짐). AGENT/N1 trajectory step-decay 의 physical 버전 — 디지털 multi-step tool-call 대신 물리 multi-step manipulation.

### 축 N — 🆕 NOVEL: 안전 정지 (safe-stop) 신뢰성 (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — ROBOTICS self-NOVEL. physical AI 의 안전 정지 — 디지털 오류와 달리 물리적 위해. 도착지 없음.
- [ ] N1 — 위험 상황 감지 시 안전 정지 (safe-stop) 신뢰성. 위험 상황(사람 진입 · 충돌 임박 · 비정상 force) 감지 시 로봇이 확실히 멈추는가. 반증자: 위험 상황 false-negative (안 멈춤) > 1% → 물리적 위해 (안전 정지 부재). digital AI 의 잘못된 출력은 재시도로 끝나지만, physical AI 의 멈추지 못함은 사람을 다치게 한다 — last line of defense. measured-tier 필요.

## SANDBOX 활용 (measurement substrate)

ROBOTICS 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — VLA infer (mac M3 / ubu-1) / HF transformers infer / LIBERO·SimplerEnv 시뮬 / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `VERTICAL/ROBOTICS/verdicts/a1_*` |
| B1 ladder | SANDBOX bench harness (LIBERO/SimplerEnv) | `VERTICAL/ROBOTICS/verdicts/b1_*` |
| N1 ⭐ NOVEL (safe-stop) | VLA infer / 실제 로봇 rollout / vast.ai pod | `VERTICAL/ROBOTICS/verdicts/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 embodied/VLA routing wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| sim2real-gap gate · long-horizon decomposition router · safe-stop 강제 | reality-gap 모델 배포 차단 gate · 다단계 task chain decomposition 분기 · 위험 감지 시 hard-stop 강제 | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **ROBOTICS 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반. A1 은 현재 placeholder data 의 closed-form identity (🔵 STRUCTURAL + 🟡 BY-CITATION) — 실측 (🟢 SUPPORTED-NUMERICAL) 아님.
- **sim 점수 ≠ real 신뢰.** sim_overfit_model 의 sim 90 (ladder 최고점) 이 A1 falsifier 를 FIRE 시키는 핵심 — 시뮬 벤치 점수만으로 모델을 신뢰하면 reality gap 에 무너진다.
- **physical 위해는 비가역.** 축 N safe-stop 의 false-negative threshold (> 1%) 는 디지털 도메인 대비 극단적으로 tight — 한 번의 안 멈춤이 사람을 다치게 한다 ([[feedback_closure_is_physical_limit]] 의 physical 한계).
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: transfer_ratio < 50% → sim2real gap · 5-step 조작 < single-step × 0.3 → 다단계 못 함 · safe-stop false-negative > 1% → 물리적 위해
> **Anticipated ENGINE behavior wire**: sim2real-gap 배포 차단 gate · long-horizon task chain decomposition router · 위험 감지 시 hard-stop 강제
>
> ⏸ DEFERRED waiting on cycle-11+ T4 measured fire (LIBERO/SimplerEnv sim eval + 실제 로봇 rollout transfer harness · vast.ai pod).

## Cross-refs

- 후보 카탈로그: [`../../AXIS.easy.md`](../../ARCHITECTURE.json)
- ENGINE intake matrix (driving lane): [`../../ENGINE/ENGINE.md`](../../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../../SANDBOX.md`](../../ARCHITECTURE.json)
- 인접 sibling (디지털 trajectory ↔ physical manipulation): [`../../AGENT/AGENT.md`](../../AGENT/AGENT.md) (N1 agentic trajectory step-decay = B1 long-horizon manipulation 의 디지털 짝)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../CODE/CODE.md`](../CODE/CODE.md) · [`../MATH/MATH.md`](../MATH/MATH.md)
- this domain: [`ROBOTICS.md`](ROBOTICS.md) (snapshot) · [`ROBOTICS.log.md`](ROBOTICS.log.md) (history)
