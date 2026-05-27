# USER-MODEL — 대화 흐름 기억

@title: 👤 USER-MODEL — "대화 흐름 기억"
@goal: **multi-turn persona·context drift·메모리 보존을 영구 측정·안정화하는 lane.** 새 conversation length·persona·memory 정책 가 등장할 때마다 측정 frontier 가 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Candidate sibling from [`AXIS.easy.md`](../AXIS.easy.md) (브레인스토밍 ⭐⭐). ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** 10-turn 후 persona drift > 20% on style/tone axes
>
> **Sibling parallel:** LONG-CONTEXT 는 '위치별 단일 turn 능력', USER-MODEL 은 'turn 간 연속성' — 별 dimension

## North-star

처음과 끝의 말투가 같은가. 긴 대화에서 persona·tone 일관성 유지.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> USER-MODEL 은 완료되지 않는다. 새 conversation length·persona·memory 정책 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — first probe (closed-form baseline)
- [x] A1 — 10-turn persona 일관성 · context recall rate. 반증자: 10-turn 후 persona drift > 20% on style/tone axes. **cycle-9 round-8 · 🔵 STRUCTURAL + 🟡 BY-CITATION 7/7** (bench: `bench/user_model_a1_persona_drift.hexa` · verify: `verify/numerics_user_model_a1_persona_drift.hexa` · verdict: `verdicts/a1_persona_drift_verdict.txt`). 4 models (consistent=4pp silent · slight=12pp silent · moderate=28pp fires · catastrophic=55pp fires) — bidirectional 2/2 above + 2/2 below threshold. 실측 (cycle-10+ T4) mac M3 multi-turn persona probe deferred.

### 축 B — second probe (measured ladder)
- [ ] B1 — 100-turn 의 drift × context-overflow × summary 효과 ladder. 반증자: summary 도입 후 drift 감소 < 30% → summary 정책 효과 marginal.

### 축 N — 🆕 NOVEL: persona-drift vs context-overflow 분리 (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — USER-MODEL 의 self-NOVEL axis. 긴 대화에서 persona drift 가 context window 초과 (overflow) 때문인가 본질적 drift 인가. 외부 anchor: Roller 2021 Blender · Park 2023 generative agents · Maharana 2024 long-conversation.
- [ ] N1 — context 안에서 vs context 밖으로 persona 정의가 밀려난 후의 drift 비교. 반증자: context 안에서도 drift > 20% → 본질적 (LONG-CONTEXT 와 무관).

## SANDBOX 활용 (measurement substrate)

USER-MODEL 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `.verdicts/USER-MODEL/a1_*` |
| B1 ladder | SANDBOX bench harness | `.verdicts/USER-MODEL/b1_*` |
| N1 ⭐ NOVEL | mac M3 / vast.ai pod | `.verdicts/USER-MODEL/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| persona pin + context summarization | conversation summarization trigger · 메모리 정책 · persona pin in system prompt | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **USER-MODEL 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../ECONOMICS.md`](../ECONOMICS.md) · [`../NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md)
- this domain: [`USER-MODEL.md`](USER-MODEL.md) (snapshot) · [`USER-MODEL.log.md`](USER-MODEL.log.md) (history)
