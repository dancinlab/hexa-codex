# DATA-EFFICIENCY — 공부 순서 다이어트

@title: 🍽️ DATA-EFFICIENCY — "공부 순서 다이어트"
@goal: **curriculum·quality·sample-efficiency 효과를 영구 측정·최적화하는 lane.** 새 corpus·filter·curriculum 기법 가 등장할 때마다 측정 frontier 가 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Candidate sibling from [`AXIS.easy.md`](../AXIS.easy.md) (브레인스토밍 ⭐⭐). ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** curriculum 효과 < 5% vs 무작위 → curriculum 무의미
>
> **Sibling parallel:** ECONOMICS 는 '양 (D, N) scaling', DATA-EFFICIENCY 는 '질·순서' — 직각

## North-star

쉬운 문제부터 vs 어려운 문제부터, 어느 게 학습 빠른가. 데이터의 순서·품질·믹스.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> DATA-EFFICIENCY 은 완료되지 않는다. 새 corpus·filter·curriculum 기법 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — first probe (closed-form baseline)
- [ ] A1 — curriculum 순서 효과 (easy-first vs random) · sample-efficiency 곡선. 반증자: curriculum 효과 < 5% vs 무작위 → curriculum 무의미.

### 축 B — second probe (measured ladder)
- [ ] B1 — quality tier (raw·dedup·curated) × scale ladder. 반증자: quality tier 효과가 1B scale 이상에서 vanish → quality 는 small-scale 만 유효.

### 축 N — 🆕 NOVEL: quality-vs-quantity Pareto (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — DATA-EFFICIENCY 의 self-NOVEL axis. curated 1B token vs raw 10B token 의 equivalence ratio — 품질-양 trade-off. 외부 anchor: Lee 2022 dedup · Marion 2023 quality filter · Tirumala 2023 D4 selection.
- [ ] N1 — 다양 quality tier 의 sample-efficiency 곡선 fit. 반증자: curated 1B 가 raw 10B 와 utility ε < 5pp → 품질의 양 압도 효과 미입증.

## SANDBOX 활용 (measurement substrate)

DATA-EFFICIENCY 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `.verdicts/DATA-EFFICIENCY/a1_*` |
| B1 ladder | SANDBOX bench harness | `.verdicts/DATA-EFFICIENCY/b1_*` |
| N1 ⭐ NOVEL | mac M3 / vast.ai pod | `.verdicts/DATA-EFFICIENCY/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| data curation pipeline | pretrain 데이터 mix · curriculum 정렬 · 품질 필터링 · weighting | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **DATA-EFFICIENCY 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../ECONOMICS.md`](../ECONOMICS.md) · [`../NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md)
- this domain: [`DATA-EFFICIENCY.md`](DATA-EFFICIENCY.md) (snapshot) · [`DATA-EFFICIENCY.log.md`](DATA-EFFICIENCY.log.md) (history)
