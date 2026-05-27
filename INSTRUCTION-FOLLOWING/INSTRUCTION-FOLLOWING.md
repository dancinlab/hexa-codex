# INSTRUCTION-FOLLOWING — 레시피 정확히 따르기

@title: 📋 INSTRUCTION-FOLLOWING — "레시피 정확히 따르기"
@goal: **형식 지시 (JSON·길이·형태) 준수율을 영구 측정·강화하는 lane.** 새 format spec·task·constraint type 가 등장할 때마다 측정 frontier 가 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Candidate sibling from [`AXIS.easy.md`](../AXIS.easy.md) (브레인스토밍 ⭐⭐⭐). ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** simple constraint (5단어 이하 · JSON · 마침표 없이) 준수 < 90%
>
> **Sibling parallel:** 기존 모두 '정답 맞히기', IF 는 '형식 지키기' — 새 dimension

## North-star

'5단어 이하로 · JSON 형식으로' 같은 지시를 정확히 지키는가. 요리 레시피 정확히 따르기.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> INSTRUCTION-FOLLOWING 은 완료되지 않는다. 새 format spec·task·constraint type 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — first probe (closed-form baseline)
- [ ] A1 — IFEval format compliance rate (binary checks). 반증자: simple constraint (5단어 이하 · JSON · 마침표 없이) 준수 < 90%.

### 축 B — second probe (measured ladder)
- [ ] B1 — constraint complexity ladder × task domain × model scale. 반증자: complex (3+ constraint stack) 준수 < simple 준수 × 0.3 → constraint compound 감쇠.

### 축 N — 🆕 NOVEL: format-vs-content Pareto (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — INSTRUCTION-FOLLOWING 의 self-NOVEL axis. 엄격한 format 강제가 content 정확도를 깎는가 — Pareto frontier 측정. 외부 anchor: Zhou 2023 IFEval · Tam 2024 strict format · Wadhwa 2024 instruction taxonomy.
- [ ] N1 — format-strict (regex enforced) vs format-loose 의 content accuracy 차이. 반증자: format 강제 시 content accuracy drop > 10pp → trade-off 실재 (Pareto 비non-trivial).

## SANDBOX 활용 (measurement substrate)

INSTRUCTION-FOLLOWING 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `.verdicts/INSTRUCTION-FOLLOWING/a1_*` |
| B1 ladder | SANDBOX bench harness | `.verdicts/INSTRUCTION-FOLLOWING/b1_*` |
| N1 ⭐ NOVEL | mac M3 / vast.ai pod | `.verdicts/INSTRUCTION-FOLLOWING/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| format constraint dial (strict ↔ loose) | response template 선택 · system prompt 강화 · format-constraint decoder | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **INSTRUCTION-FOLLOWING 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../ECONOMICS.md`](../ECONOMICS.md) · [`../NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md)
- this domain: [`INSTRUCTION-FOLLOWING.md`](INSTRUCTION-FOLLOWING.md) (snapshot) · [`INSTRUCTION-FOLLOWING.log.md`](INSTRUCTION-FOLLOWING.log.md) (history)
