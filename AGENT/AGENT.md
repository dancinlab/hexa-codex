# AGENT — 공구상자 골라쓰기

@title: 🛠️ AGENT — "공구상자 골라쓰기"
@goal: **tool 선택·multi-step plan·에러 복구 능력을 영구 측정·확장하는 lane.** 새 tool·plan depth·task domain 가 등장할 때마다 측정 frontier 가 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Candidate sibling from [`AXIS.easy.md`](../AXIS.easy.md) (브레인스토밍 ⭐⭐⭐). ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** 1-step tool call < 70% on basic tasks (calculator·search 등)
>
> **Sibling parallel:** 기존 sibling 모두 '1턴 응답' 측정, AGENT 는 '여러 턴 도구 사용' — 새 dimension

## North-star

여러 tool (검색·계산기·코드실행·API) 중 적절한 걸 골라 multi-step 으로 사용. 망치/드라이버 골라쓰기.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> AGENT 은 완료되지 않는다. 새 tool·plan depth·task domain 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — first probe (closed-form baseline)
- [x] A1 — single-tool call 정확도 · tool selection accuracy. 반증자: 1-step tool call < 70% on basic tasks (calculator·search 등). **CYCLE-9 round-5 first probe (2026-05-28):** `AGENT/bench/agent_a1_tool_call_rate.hexa` + `AGENT/verify/numerics_agent_a1_tool_call_rate.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL + 🟡 BY-CITATION (70% threshold = BFCL/ToolBench convention). Identity: `acc = N_correct / N_total × 100` · falsifier `acc < 70`. Worked example 4 models × N_total=100 (4 tools × 25 trials): excellent=92 silent · mid=78 silent · **weak=55 fires** · **broken=30 fires** — bidirectional. External anchors: Yao 2023 ReAct (arXiv:2210.03629) · Schick 2023 Toolformer (arXiv:2302.04761) · Shinn 2023 Reflexion · Patil 2023 Gorilla. **실측 tool call eval DEFERRED** (cycle-10+ · BFCL · ToolBench · API-Bank on ubu-1 HF). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — identity close ≠ measured close. 축 N (plan-vs-execute divergence) 다음 ⭐ MAIN priority lane.

### 축 B — second probe (measured ladder)
- [ ] B1 — multi-step plan depth × error recovery ladder · SWE-bench-style 측정. 반증자: depth-3 plan 성공률 < depth-1 성공률 × 0.5 → multi-step compound error.

### 축 N — 🆕 NOVEL: plan-vs-execute divergence (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — AGENT 의 self-NOVEL axis. 올바른 plan 을 세웠지만 execution 단계에서 빗나가는 빈도 — 계획과 실행의 gap. 외부 anchor: Yao 2023 ReAct · Shinn 2023 Reflexion · Wang 2024 voyager.
- [ ] N1 — explicit plan generation 후 step-by-step execution 정확도 비교. 반증자: plan 정확도 > 90% 인데 execution 정확도 < 70% → execution-bound (plan-execute decoupling 필요).

## SANDBOX 활용 (measurement substrate)

AGENT 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `.verdicts/AGENT/a1_*` |
| B1 ladder | SANDBOX bench harness | `.verdicts/AGENT/b1_*` |
| N1 ⭐ NOVEL | mac M3 / vast.ai pod | `.verdicts/AGENT/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| plan-execute decoupling architecture | tool routing · plan 깊이 한계 · 에러 복구 정책 · plan checkpoint | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **AGENT 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter (H, I, J, ...) 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: 1-step tool call < 70% on basic tasks (calculator·search 등)
> **Anticipated ENGINE behavior wire**: tool-routing aware plan-execute decoupling · plan checkpoint frequency
> **Status path**: [`../CALIBRATION/CALIBRATION.md`](../CALIBRATION/CALIBRATION.md) ← reference 패턴 (cycle-10 round-1 promoted to ENGINE axis G).

> ⏸ DEFERRED waiting on cycle-10+ T4 measured fire.

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../ECONOMICS.md`](../ECONOMICS.md) · [`../NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md)
- this domain: [`AGENT.md`](AGENT.md) (snapshot) · [`AGENT.log.md`](AGENT.log.md) (history)
