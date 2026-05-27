# LONG-CONTEXT — 두루마리 끝까지 읽기

@title: 📜 LONG-CONTEXT — "두루마리 끝까지 읽기"
@goal: **긴 컨텍스트 (수만~수십만 토큰) 안 정보 검출·활용 능력을 영구 측정·확장하는 lane.** 새 context window·attention impl·position encoding 가 등장할 때마다 측정 frontier 가 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Candidate sibling from [`AXIS.easy.md`](../AXIS.easy.md) (브레인스토밍 ⭐⭐⭐). ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** 64k 이상에서 정확도가 4k 대비 50% 미만 drop → 효과적 context 좁음
>
> **Sibling parallel:** SUBSTRATE 는 '능력 일반', LONG-CONTEXT 는 '위치별 능력 감쇠' — 별 dimension

## North-star

100쪽짜리 책 주고 '23쪽 7번째 문장 뭐?' 물었을 때 책 끝까지 안 읽어도 정확히 찾는가 (needle-in-haystack).

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> LONG-CONTEXT 은 완료되지 않는다. 새 context window·attention impl·position encoding 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — first probe (closed-form baseline)
- [ ] A1 — needle-in-haystack accuracy @ context-len curve · 위치 별 attention 감쇠. 반증자: 64k 이상에서 정확도가 4k 대비 50% 미만 drop → 효과적 context 좁음.

### 축 B — second probe (measured ladder)
- [ ] B1 — multi-needle (5+ needles) recall at varying depth · 거리별 attention 강도 fit. 반증자: multi-needle recall 이 single-needle recall × 0.5 미만 → multi-fact reasoning 미작동.

### 축 N — 🆕 NOVEL: position-vs-content coupling (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — LONG-CONTEXT 의 self-NOVEL axis. position effect (가운데 lost) 와 content effect (어려운 needle) 가 entangle 됐는지 분리 측정. 외부 anchor: Liu 2023 lost-in-the-middle · Press 2022 ALiBi · NIAH benchmark.
- [ ] N1 — needle 위치 × needle 난이도 cross-product matrix accuracy fit. 반증자: position 와 content 가 independent 라고 가정한 monovariate fit 의 error > 10%.

## SANDBOX 활용 (measurement substrate)

LONG-CONTEXT 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `.verdicts/LONG-CONTEXT/a1_*` |
| B1 ladder | SANDBOX bench harness | `.verdicts/LONG-CONTEXT/b1_*` |
| N1 ⭐ NOVEL | mac M3 / vast.ai pod | `.verdicts/LONG-CONTEXT/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| RoPE θ scaling · YaRN extension · 효과적 context window 결정 | position encoding 선택 · context budget allocation · position-aware retrieval | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **LONG-CONTEXT 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../ECONOMICS.md`](../ECONOMICS.md) · [`../NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md)
- this domain: [`LONG-CONTEXT.md`](LONG-CONTEXT.md) (snapshot) · [`LONG-CONTEXT.log.md`](LONG-CONTEXT.log.md) (history)
