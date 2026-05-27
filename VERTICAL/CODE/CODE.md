# CODE — 코드 장인

@title: 🖥️ CODE — "코드 장인"
@goal: **코드 생성 전문 모델의 능력 (one-shot 정확도 · 생성 코드 보안 · repo-level 일관성) 을 영구 측정·확장하는 lane.** hexa-codex 의 [`lm_foundry/`](../../lm_foundry/README.md) 가 실제 code-LLM (hexa-lang strict 94.29% Mk.I · Qwen2.5-Coder-7B + LoRA) — CODE 도메인은 그 측정 layer. 새 code model·benchmark·언어·repo 가 등장할 때마다 측정 frontier 가 다시 열린다. **도착지 없음 · 종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> `VERTICAL/*` 그룹 폴더의 첫 도메인 (cycle-10) — vertical 전문 모델 측정 도메인군. CODE = 코드 생성 전문 모델 측정. ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** one-shot pass@1 이 best-of-10 pass@10 의 30% 미만 → one-shot 약함 (sampling 의존). 또는 생성 코드 취약점률 > 30% → 보안 부재. 또는 multi-file edit 정합성 < single-file × 0.5 → repo context 못 다룸.
>
> **Sibling parallel:** SUBSTRATE 는 '능력 일반', VERTICAL/CODE 는 '코드라는 한 vertical 의 깊이' — vertical 전문화 dimension. lm_foundry "narrow-and-deep" thesis (7B code-only > 70B generalist on home turf) 의 측정 surface.

## North-star

한 번에 맞히는 코드(one-shot pass@1)와 10번 뽑아 best 고르는 코드(pass@10) 의 격차 — 모델이 한 방에 정답 코드를 쓰는가, 아니면 여러 번 시도해야만 맞히는가. 그리고 단일 함수가 아니라 repo 전체를 가로지르는 multi-file 편집에서도 일관성을 유지하는가 (SWE-bench 가 측정하는 실세계 능력).

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> CODE 는 완료되지 않는다. 새 code model·benchmark·언어·repo·취약점 class 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — A1 pass@k 코드 정확도 (closed-form baseline · lm_foundry Mk.I 직결)
- [x] A1 — pass@k 코드 정확도 · 5 code-model × {pass_at_1, pass_at_10} (HumanEval/MBPP). 반증자: `oneshot_ratio < 30%` (pass@1 < pass@10 × 0.3) → one-shot 약함 (sampling 의존). **CYCLE-10 first probe (2026-05-28 · VERTICAL/CODE 신규 도메인):** `VERTICAL/CODE/bench/code_a1_pass_at_k.hexa` + `VERTICAL/CODE/verify/numerics_code_a1_pass_at_k.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL + 🟡 BY-CITATION. Identity: `oneshot_ratio_pct = pass_at_1 × 100 / pass_at_10` (pass@k × 100 ledger · × 100 factors cancel → ratio in plain %) · falsifier `ratio < 30%`. Worked example 5 models × {pass@1, pass@10}: **gpt5_code (88/96 · ratio 91% silent)** · **claude_code (85/94 · 90% silent)** · **qwen_coder (82/93 · 88% silent · #1 SWE-bench)** · **hexa_mk1 (70/82 · 85% silent · lm_foundry Mk.I · hexa-lang strict 94.29% 별도 metric)** · **weak_base (20/80 · 25% FIRES · sampling 의존)** — bidirectional 4 silent (one-shot 강함) + 1 fires (sampling 의존) + sanity (pass@1 ≤ pass@10 all · pass@1 ladder monotone). Verdict `VERTICAL/CODE/verdicts/a1_pass_at_k_verdict.txt`. External anchors: Chen 2021 HumanEval (arXiv:2107.03374) · Austin 2021 MBPP (arXiv:2108.07732) · Jimenez 2023 SWE-bench (arXiv:2310.06770) · hexa-lang Mk.I 94.29% (lm_foundry `code` verb GA · 627/665). sentinel `__HEXA_CODEX_CODE_A1_PASS_AT_K__ DONE` (bench) + `__HEXA_CODEX_NUMERICS_CODE_A1__ DONE` (verify). **실측 측정 DEFERRED** — cycle-11+ T4 (HumanEval/MBPP/SWE-bench pass@k harness on lm_foundry eval + vast.ai pod). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — identity close ≠ measured close. 축 N (repo-level multi-file coherence) 다음 ⭐ MAIN priority lane.

### 축 B — B1 코드 보안 (measured ladder)
- [ ] B1 — 생성 코드 취약점률 (CWE) · 코드 모델별 생성 코드의 보안 결함 비율 측정. 반증자: 생성 코드 취약점 > 30% → 보안 부재 (Pearce 2022 — "Asleep at the Keyboard?" Copilot security, 40% 취약 코드 생성 관찰).

### 축 N — 🆕 NOVEL: repo-level multi-file coherence (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — CODE self-NOVEL axis. 단일 함수 정확도가 아니라 repo 전체를 가로지르는 multi-file 편집의 정합성. SWE-bench 가 측정하는 실세계 repo-level 능력. 도착지 없음. 외부 anchor: Jimenez 2023 SWE-bench (arXiv:2310.06770) · qwen_coder #1 SWE-bench.
- [ ] N1 — single-file edit 정확도 vs multi-file edit 정합성 cross-product fit. 반증자: multi-file edit 정합성 < single-file × 0.5 → repo context 못 다룸 (단일 함수만 잘하고 repo 전체 흐름은 놓침).

## SANDBOX 활용 (measurement substrate)

CODE 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — lm_foundry eval (mac M3 / ubu-1) / HF transformers infer / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `VERTICAL/CODE/verdicts/a1_*` |
| B1 ladder | SANDBOX bench harness | `VERTICAL/CODE/verdicts/b1_*` |
| N1 ⭐ NOVEL | lm_foundry eval / vast.ai pod (SWE-bench) | `VERTICAL/CODE/verdicts/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM code-gen routing wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| one-shot vs best-of-k 결정 · 보안 gate · repo-context router | code-gen sampling budget 결정 · CWE-aware 생성 gate · single vs repo-level task 분기 | ENGINE intake matrix 승격 시 axis letter 부여 |

## lm_foundry Mk.I 직결 (vertical specialist 측정 대상)

CODE 는 추상적 benchmark 가 아니라 hexa-codex 자신의 code-LLM 을 측정한다:

- **`hexa_mk1` = [`lm_foundry/`](../../lm_foundry/README.md) `code` verb** — Qwen2.5-Coder-7B + LoRA r=64, hexa-lang strict **94.29% Mk.I** (627/665 · r39 v3-t3patch adapter, GA 이후 unchanged).
- A1 의 hexa_mk1 HumanEval/MBPP pass@k (70/82) 는 **범용 Python code-gen** metric — hexa-lang strict 94.29% (hexa-lang 전용 strict eval) 와 **별도 metric**. 두 metric 을 혼동하지 않음.
- narrow-and-deep thesis: 7B code-only 모델이 home turf (hexa-lang) 에서 70B generalist 를 능가 — CODE 도메인은 그 thesis 의 측정 surface.

## Honesty invariants

- **CODE 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반. A1 은 현재 placeholder data 의 closed-form identity (🔵 STRUCTURAL + 🟡 BY-CITATION) — 실측 (🟢 SUPPORTED-NUMERICAL) 아님.
- **두 metric 분리.** hexa_mk1 의 HumanEval/MBPP pass@k 와 hexa-lang strict 94.29% 는 별개 — A1 placeholder pass@k 가 hexa-lang Mk.I 수치를 대체하지 않음.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: oneshot_ratio < 30% → sampling 의존 · 생성 코드 취약점 > 30% → 보안 부재 · multi-file 정합성 < single-file × 0.5 → repo context 못 다룸
> **Anticipated ENGINE behavior wire**: code-gen sampling-budget router · CWE-aware 생성 gate · single vs repo-level task 분기
>
> ⏸ DEFERRED waiting on cycle-11+ T4 measured fire (HumanEval/MBPP/SWE-bench pass@k harness on lm_foundry eval + vast.ai pod).

## Cross-refs

- 후보 카탈로그: [`../../AXIS.easy.md`](../../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../../ENGINE/ENGINE.md`](../../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../../SANDBOX.md`](../../SANDBOX.md)
- 측정 대상 code-LLM (vertical specialist): [`../../lm_foundry/README.md`](../../lm_foundry/README.md) (hexa-lang 94.29% Mk.I)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../../MULTIMODAL/MULTIMODAL.md`](../../MULTIMODAL/MULTIMODAL.md) · [`../../DATA-QUALITY/DATA-QUALITY.md`](../../DATA-QUALITY/DATA-QUALITY.md) · [`../../LONG-CONTEXT/LONG-CONTEXT.md`](../../LONG-CONTEXT/LONG-CONTEXT.md)
- this domain: [`CODE.md`](CODE.md) (snapshot) · [`CODE.log.md`](CODE.log.md) (history)
