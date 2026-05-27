# RELIABILITY — 오타 안 나는가

@title: 🔧 RELIABILITY — "오타 안 나는가"
@goal: **silent corruption·결정론 재현성·ECC bit-flip 을 영구 측정·보장하는 lane.** 새 HW·model·serving stack 가 등장할 때마다 측정 frontier 가 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Candidate sibling from [`AXIS.easy.md`](../AXIS.easy.md) (브레인스토밍 ⭐⭐). ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** 결정론 재현률 < 99.9% (같은 seed·model 다른 답)
>
> **Sibling parallel:** OPS 는 '서빙 latency', RELIABILITY 는 '출력 일관성' — 인접 sub-lane

## North-star

같은 텍스트 두 번 인쇄해서 다른 결과 나오면 프린터 고장. 같은 seed·model 인데 답이 다르면?

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> RELIABILITY 은 완료되지 않는다. 새 HW·model·serving stack 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — first probe (closed-form baseline)
- [ ] A1 — 결정론 재현률 (same seed·model → same output) · silent corruption 빈도. 반증자: 결정론 재현률 < 99.9% (같은 seed·model 다른 답).

### 축 B — second probe (measured ladder)
- [ ] B1 — long-running 학습/추론 의 silent error rate · ECC failure injection. 반증자: ECC injection 후 모델 응답 변동 > 10% → 학습 중 silent corruption 가능.

### 축 N — 🆕 NOVEL: silent-vs-loud failure ratio (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — RELIABILITY 의 self-NOVEL axis. 탐지된 오류 (loud) vs 미탐지 silent 오류의 비율 — observability 의 한계. 외부 anchor: Dixit 2021 silent data corruption · Hochschild 2021 fail-silent · NVIDIA bit-flip.
- [ ] N1 — checksum injection · canary output · post-hoc audit 으로 silent rate 추정. 반증자: silent failure rate > loud failure rate × 0.1 → 관찰 시스템 부족 (silent 가 main).

## SANDBOX 활용 (measurement substrate)

RELIABILITY 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `.verdicts/RELIABILITY/a1_*` |
| B1 ladder | SANDBOX bench harness | `.verdicts/RELIABILITY/b1_*` |
| N1 ⭐ NOVEL | mac M3 / vast.ai pod | `.verdicts/RELIABILITY/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| shadow validation + canary stream | checkpoint frequency · 결정론 seed pin · ECC enabled · shadow validation | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **RELIABILITY 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../ECONOMICS.md`](../ECONOMICS.md) · [`../NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md)
- this domain: [`RELIABILITY.md`](RELIABILITY.md) (snapshot) · [`RELIABILITY.log.md`](RELIABILITY.log.md) (history)
