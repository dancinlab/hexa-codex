# TEMPORAL — 시간 감각

@title: 🕰️ TEMPORAL — "시간 감각"
@goal: **시간·날짜·기간·순서 추론 정확도와 cutoff 인지를 영구 측정·교정하는 lane.** 새 cutoff·task 시제·시간 표현 양식 가 등장할 때마다 측정 frontier 가 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Candidate sibling from [`AXIS.easy.md`](../AXIS.easy.md) (브레인스토밍 ⭐⭐). ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** cutoff 이후 사실에 대해 confident-wrong 답 > 30% (cutoff 인지 미작동)
>
> **Sibling parallel:** HALLUCINATION 인접하지만 'temporal 도메인 특화' — sub-lane (or HALLUCINATION 자식)

## North-star

'어제가 며칠?' 물었을 때 정확히 답하는가. 모델이 cutoff 너머 사실을 안다고 우기는가.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> TEMPORAL 은 완료되지 않는다. 새 cutoff·task 시제·시간 표현 양식 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — first probe (closed-form baseline)
- [x] A1 — date·duration·ordering accuracy (closed-form benchmark). 반증자: cutoff 이후 사실에 대해 confident-wrong 답 > 30% (cutoff 인지 미작동). **CYCLE-9 round-7 wire** · 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7 checks · 5-model + zero-control (CA=15 silent · PA=25 silent · OC=40 fires · CL=60 fires · Z=0 perfect-IDK) · bench [`bench/temporal_a1_post_cutoff_wrong.hexa`](bench/temporal_a1_post_cutoff_wrong.hexa) · verifier [`verify/numerics_temporal_a1_post_cutoff_wrong.hexa`](verify/numerics_temporal_a1_post_cutoff_wrong.hexa) · verdict [`verdicts/a1_post_cutoff_wrong_verdict.txt`](verdicts/a1_post_cutoff_wrong_verdict.txt) · anchors: Dhingra 2022 TimeQA (arXiv:2108.06314) · Chen 2023 temporal reasoning · Zhao 2024 cutoff awareness · substrate fire DEFERRED to cycle-10+.

### 축 B — second probe (measured ladder)
- [ ] B1 — relative time (어제·내년) vs absolute time (2025-05-27) 표현 비교. 반증자: absolute 표현이 relative 보다 정확도 < 70% → 모델이 absolute 처리 약함 (tokenization 흐림).

### 축 N — 🆕 NOVEL: relative-vs-absolute time reasoning gap (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — TEMPORAL 의 self-NOVEL axis. '어제' (relative) vs '2025-05-27' (absolute) 표현에 모델이 다르게 답하는가 — 시제 변환 능력. 외부 anchor: Dhingra 2022 TimeQA · Chen 2023 temporal reasoning · Zhao 2024 cutoff awareness.
- [ ] N1 — 같은 사실을 relative vs absolute 시간 표현으로 query 한 답 정확도 비교. 반증자: absolute > 80% 인데 relative < 60% → relative time reasoning gap (시제 변환 미작동).

## SANDBOX 활용 (measurement substrate)

TEMPORAL 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `.verdicts/TEMPORAL/a1_*` |
| B1 ladder | SANDBOX bench harness | `.verdicts/TEMPORAL/b1_*` |
| N1 ⭐ NOVEL | mac M3 / vast.ai pod | `.verdicts/TEMPORAL/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| current-time context injection | 시간 컨텍스트 주입 정책 · cutoff 명시 · 시간-aware system prompt | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **TEMPORAL 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter (H, I, J, ...) 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: cutoff 이후 사실에 대해 confident-wrong 답 > 30% (cutoff 인지 미작동)
> **Anticipated ENGINE behavior wire**: cutoff-aware temporal grounding · post-cutoff abstention
> **Status path**: [`../CALIBRATION/CALIBRATION.md`](../CALIBRATION/CALIBRATION.md) ← reference 패턴 (cycle-10 round-1 promoted to ENGINE axis G).

> ⏸ DEFERRED waiting on cycle-10+ T4 measured fire.

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../ECONOMICS.md`](../ECONOMICS.md) · [`../NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md)
- this domain: [`TEMPORAL.md`](TEMPORAL.md) (snapshot) · [`TEMPORAL.log.md`](TEMPORAL.log.md) (history)
