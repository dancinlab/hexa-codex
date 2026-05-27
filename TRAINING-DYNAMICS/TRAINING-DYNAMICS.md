# TRAINING-DYNAMICS — 학습 곡선 의사

@title: 📈 TRAINING-DYNAMICS — "학습 곡선 의사"
@goal: **학습 중 loss-spike·grokking·phase-transition 패턴을 영구 측정·예측하는 lane.** 새 모델·dataset·optimizer·scale 가 등장할 때마다 측정 frontier 가 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Candidate sibling from [`AXIS.easy.md`](../AXIS.easy.md) (브레인스토밍 ⭐⭐). ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** loss spike > 1/1k steps OR weight norm divergence
>
> **Sibling parallel:** ECONOMICS 는 'scaling law' (정적), TRAINING-DYNAMICS 는 '동적 진행' — 직각

## North-star

운동선수 기록 그래프의 slump·breakthrough 시점. 학습 중 loss spike·grokking 같은 dynamics 측정.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> TRAINING-DYNAMICS 은 완료되지 않는다. 새 모델·dataset·optimizer·scale 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — first probe (closed-form baseline)
- [ ] A1 — loss spike 빈도 · max gradient norm · weight norm 추이. 반증자: loss spike > 1/1k steps OR weight norm divergence.

### 축 B — second probe (measured ladder)
- [ ] B1 — grokking 임계 측정 (train acc vs test acc gap closure 시점). 반증자: grokking 미관찰 (gap 영구 유지) → train-test memorization 분리 신호.

### 축 N — 🆕 NOVEL: phase-transition predictor (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — TRAINING-DYNAMICS 의 self-NOVEL axis. loss spike·grokking 같은 phase transition 직전 측정 가능한 신호가 있는가. 외부 anchor: Nanda 2023 grokking · Wei 2022 emergent · Zhang 2024 spike analysis.
- [ ] N1 — spike 직전 N step 의 gradient norm · weight curvature · loss Hessian 측정. 반증자: spike 직전 신호의 predictive AUC < 0.7 → 예측 불가 (random).

## SANDBOX 활용 (measurement substrate)

TRAINING-DYNAMICS 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `.verdicts/TRAINING-DYNAMICS/a1_*` |
| B1 ladder | SANDBOX bench harness | `.verdicts/TRAINING-DYNAMICS/b1_*` |
| N1 ⭐ NOVEL | mac M3 / vast.ai pod | `.verdicts/TRAINING-DYNAMICS/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| lr scheduler + early-stop policy | lr scheduler · warmup · gradient clipping · checkpoint frequency 동적 조정 | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **TRAINING-DYNAMICS 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../ECONOMICS.md`](../ECONOMICS.md) · [`../NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md)
- this domain: [`TRAINING-DYNAMICS.md`](TRAINING-DYNAMICS.md) (snapshot) · [`TRAINING-DYNAMICS.log.md`](TRAINING-DYNAMICS.log.md) (history)
