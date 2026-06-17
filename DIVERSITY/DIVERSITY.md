# DIVERSITY — 같은 답만 하지 않는가

@title: 🎨 DIVERSITY — "같은 답만 하지 않는가"
@goal: **출력 다양성·반복률·분포 entropy 를 영구 측정·튜닝하는 lane.** 새 task·decoder·sampling 기법 가 등장할 때마다 측정 frontier 가 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Candidate sibling from [`AXIS.easy.md`](../ARCHITECTURE.json) (브레인스토밍 ⭐⭐). ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** self-BLEU > 0.8 OR repetition rate > 20%
>
> **Sibling parallel:** CALIBRATION 은 '정확도-신뢰도 일치', DIVERSITY 는 '출력 분포 spread' — 별 axis

## North-star

같은 농담만 반복하는 친구는 재미없죠. LLM 도 같은 답만 내면 활용도 ↓.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> DIVERSITY 은 완료되지 않는다. 새 task·decoder·sampling 기법 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — first probe (closed-form baseline)
- [x] A1 — self-BLEU · n-gram repetition · 분포 entropy. 반증자: self-BLEU > 0.8 OR repetition rate > 20%. **CYCLE-9 round-6 wire** · 🔵 STRUCTURAL + 🟡 BY-CITATION (7/7) · bench `DIVERSITY/bench/diversity_a1_self_bleu_repetition.hexa` · verify `DIVERSITY/verify/numerics_diversity_a1_self_bleu_repetition.hexa` · anchors Holtzman 2020 nucleus (arXiv:1904.09751) · Massarelli 2020 decoding · Zhu 2018 self-BLEU · substrate fire DEFERRED.

### 축 B — second probe (measured ladder)
- [ ] B1 — task 별 (factual vs creative) diversity 요구 ladder · decoder × T × top-p. 반증자: creative task 의 self-BLEU > factual task → decoder/T 가 task 차이를 못 봄.

### 축 N — 🆕 NOVEL: diversity-vs-quality Pareto (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — DIVERSITY 의 self-NOVEL axis. temperature 올리면 다양성↑ 품질↓ 의 trade-off 곡선 — Pareto frontier 측정. 외부 anchor: Holtzman 2020 nucleus · Massarelli 2020 decoding · Su 2022 contrastive search.
- [ ] N1 — T ∈ {0.0, 0.5, 0.7, 1.0, 1.2} 에서 self-BLEU vs task accuracy fit. 반증자: Pareto frontier 가 flat (T 무관 quality 동일) → temperature lever 미작동.

## SANDBOX 활용 (measurement substrate)

DIVERSITY 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `.verdicts/DIVERSITY/a1_*` |
| B1 ladder | SANDBOX bench harness | `.verdicts/DIVERSITY/b1_*` |
| N1 ⭐ NOVEL | mac M3 / vast.ai pod | `.verdicts/DIVERSITY/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| task-aware temperature | temperature / top-p / repetition penalty 자동 튜닝 (task 의존) | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **DIVERSITY 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter (H, I, J, ...) 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: self-BLEU > 0.8 OR repetition rate > 20%
> **Anticipated ENGINE behavior wire**: repetition-penalty / top-p auto-tune · diversity-floor sampling
> **Status path**: [`../CALIBRATION/CALIBRATION.md`](../CALIBRATION/CALIBRATION.md) ← reference 패턴 (cycle-10 round-1 promoted to ENGINE axis G).

> ⏸ DEFERRED waiting on cycle-10+ T4 measured fire.

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../ARCHITECTURE.json)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../ARCHITECTURE.json)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../ECONOMICS.md`](../ARCHITECTURE.json) · [`../NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md)
- this domain: [`DIVERSITY.md`](DIVERSITY.md) (snapshot) · [`DIVERSITY.log.md`](DIVERSITY.log.md) (history)
