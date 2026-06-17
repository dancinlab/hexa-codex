# PROMPT-SENSITIVITY — 말투 바꾸면 답 바뀌는가

@title: 🎭 PROMPT-SENSITIVITY — "말투 바꾸면 답 바뀌는가"
@goal: **동일 task 의 다른 prompt 변형에 대한 답 일관성을 영구 측정·완화하는 lane.** 새 prompt 양식·domain·task class 가 등장할 때마다 측정 frontier 가 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Candidate sibling from [`AXIS.easy.md`](../ARCHITECTURE.json) (브레인스토밍 ⭐⭐⭐). ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** factual prompt 일관성 < 80% → 표면 단서 의존 (진짜 앎 아님)
>
> **Sibling parallel:** SANDBOX 는 '같은 prompt 다른 manifest', PROMPT-SENS 는 '다른 prompt 같은 task' — 직각

## North-star

같은 질문 5가지 변형 (formal/casual/L1/L2/...) 으로 물었을 때 답이 일관적이면 진짜 앎, 변동하면 표면 단서 의존.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> PROMPT-SENSITIVITY 은 완료되지 않는다. 새 prompt 양식·domain·task class 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — first probe (closed-form baseline)
- [x] A1 — 5-prompt agreement rate · variance · invariance score (closed-form). 반증자: factual prompt 일관성 < 80% → 표면 단서 의존 (진짜 앎 아님). **CYCLE-9 round-4 wire** · 🔵 STRUCTURAL + 🟡 BY-CITATION (7/7 closed-form) · anchors Sclar 2023 (arXiv:2310.11324) · Razavi 2022 · Wei 2022 CoT (arXiv:2201.11903) · 실측 5-prompt run deferred (cycle-10+ SANDBOX).

### 축 B — second probe (measured ladder)
- [ ] B1 — prompt-family ladder (formality·언어·길이) × task class 의 cross-model 비교. 반증자: prompt-family variance > task-class variance → prompt 가 task 보다 더 큰 영향 (잘못된 의존).

### 축 N — 🆕 NOVEL: semantic-vs-syntactic invariance gap (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — PROMPT-SENSITIVITY 의 self-NOVEL axis. 말투/문법 (syntactic) 변경 vs 의미 (semantic) 변경에 모델이 같은 정도로 변동하는가 — 두 lever 분리. 외부 anchor: Sclar 2023 quantifying prompt sensitivity · Razavi 2022 paraphrase robustness.
- [ ] N1 — syntactic paraphrase (의미 동일) vs semantic paraphrase (의미 변경) 의 답 변동 ratio. 반증자: syntactic 변동 > semantic 변동 × 2 → surface-prone (의미 무시·표면 의존).

## SANDBOX 활용 (measurement substrate)

PROMPT-SENSITIVITY 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `.verdicts/PROMPT-SENSITIVITY/a1_*` |
| B1 ladder | SANDBOX bench harness | `.verdicts/PROMPT-SENSITIVITY/b1_*` |
| N1 ⭐ NOVEL | mac M3 / vast.ai pod | `.verdicts/PROMPT-SENSITIVITY/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| robust prompt template · system prompt 정규화 | prompt template auto-select · 5-prompt consistency gate · syntactic normalization | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **PROMPT-SENSITIVITY 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter (H, I, J, ...) 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: factual prompt 일관성 < 80% → 표면 단서 의존 (진짜 앎 아님)
> **Anticipated ENGINE behavior wire**: prompt-paraphrase ensemble voting · sensitivity-gated abstention
> **Status path**: [`../CALIBRATION/CALIBRATION.md`](../CALIBRATION/CALIBRATION.md) ← reference 패턴 (cycle-10 round-1 promoted to ENGINE axis G).

> ⏸ DEFERRED waiting on cycle-10+ T4 measured fire.

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../ARCHITECTURE.json)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../ARCHITECTURE.json)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../ECONOMICS.md`](../ARCHITECTURE.json) · [`../NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md)
- this domain: [`PROMPT-SENSITIVITY.md`](PROMPT-SENSITIVITY.md) (snapshot) · [`PROMPT-SENSITIVITY.log.md`](PROMPT-SENSITIVITY.log.md) (history)
