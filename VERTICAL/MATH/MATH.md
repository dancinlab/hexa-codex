# MATH — 증명가

@title: 🔢 MATH — "증명가"
@goal: **수학 전문 모델이 문제의 답을 맞히는 것(비형식)과 그 답을 형식 증명(Lean/Coq)으로 실제 검증해내는 것(형식) 사이의 gap, 그리고 정답을 맞춰도 그 증명/추론 과정이 valid 한가를 영구 측정·확장하는 lane.** 새 math model·proof system·formal-verify 패러다임이 등장할 때마다 측정 frontier 가 다시 열린다. **도착지 없음 · 종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> **VERTICAL 전문 모델 측정 도메인군 (VERTICAL/\*)** 의 MATH 노드 — 수학 전문 모델 측정. sibling = VERTICAL/CODE (코드 전문 모델) · VERTICAL/BIO (바이오/의료 전문 모델). vertical specialization 이 "답 맞히기"를 넘어 "형식 검증·증명 valid" 까지 가는가를 closed-form 으로 측정한다.
>
> **Sibling parallel:** SUBSTRATE 는 '능력 일반', VERTICAL/CODE 는 '코드 vertical 깊이', VERTICAL/BIO 는 '바이오 vertical 깊이' — MATH 는 '수학 vertical 깊이'. lm_foundry "narrow-and-deep" thesis 의 또 하나 측정 surface. 수학의 특이점: **답(answer) 과 증명(proof) 이 분리 가능** — 답은 맞아도 증명은 틀릴 수 있다 (verify gap · reasoning faithfulness).
>
> **⚠ recipe ≠ measurement — 다른 layer:**
> - (build recipe) = **RECIPE** (어떻게 만드나 · formal-proof SFT/RL · autoformalization corpus · Lean tactic search). 수학 모델 build spec.
> - **VERTICAL/MATH 도메인 (이 문서)** = **MEASUREMENT** (얼마나 잘 검증하나 · formal-proof 검증율 · answer-proof coherence). AlphaProof 의 Lean mathlib kernel-checked formal-verification 패러다임이 본 측정의 truth surface.
>
> **Falsifier class:** formal_ratio < 50% (형식 검증율 < 비형식 정답 × 0.5) → 답은 맞지만 증명 못함 (verify gap). 또는 정답 correct 중 증명 valid 비율 < 70% → 답만 맞고 과정 틀림 (reasoning faithfulness 붕괴).

## North-star

같은 문제 surface 위에서, 수학 모델이 (a) AIME-style 비형식 답을 맞히는가, (b) 그 답을 Lean/Coq 형식 증명으로 kernel-check 통과시키는가, (c) 정답을 맞춰도 그 증명/추론 과정이 실제로 valid 한가 — 답 맞히기와 증명/검증 사이의 gap 을 측정한다 (AlphaProof 의 formal-verification 패러다임).

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> MATH 는 완료되지 않는다. 새 math model·proof system (Lean/Coq/Isabelle)·formal-verify 패러다임이 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — formal-proof 검증율 (closed-form baseline)
- [x] A1 — formal-proof 검증율 · 5 model × {informal_acc, formal_verified}. AIME 비형식 답 vs Lean/Coq 형식 증명 검증. 반증자: `formal_ratio < 50%` (형식 검증율 < 비형식 정답 × 0.5) → 답은 맞지만 증명 못함 (verify gap). **CYCLE-10 first probe (2026-05-28 · VERTICAL/MATH 신규 도메인):** `VERTICAL/MATH/bench/math_a1_formal_proof.hexa` + `VERTICAL/MATH/verify/numerics_math_a1_formal_proof.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL + 🟡 BY-CITATION. Identity: `formal_ratio_pct = formal_verified × 100 / informal_acc` (acc × 100 ledger · × 100 factors cancel → ratio in plain %) · falsifier `ratio < 50%`. Worked example 5 models × {informal_acc, formal_verified}: **alphaproof (90/80 · ratio 88% silent · Lean formal SOTA)** · **gpt5_math (88/72 · 81% silent)** · **o1_reasoning (85/68 · 80% silent)** · **deepseek_prover (82/70 · 85% silent · formal-proof tune)** · **answer_only_model (85/30 · 35% FIRES · 답만 맞고 증명 못함 · verify gap)** — bidirectional 4 silent (증명이 답을 따라옴 · formal-prover) + 1 fires (answer-only · verify gap) + sanity (formal_verified ≤ informal_acc all · formal ⊆ informal · prover ratio monotone alphaproof 88 ≥ deepseek 85 ≥ gpt5 81 ≥ o1 80). Verdict `VERTICAL/MATH/verdicts/a1_formal_proof_verdict.txt`. External anchors: Hendrycks 2021 MATH (arXiv:2103.03874) · DeepMind 2024 AlphaProof (Lean formal-proof IMO 2024 silver) · Trinh 2024 AlphaGeometry (Nature 625:476) · Lean mathlib kernel-check · AIME. sentinel `__HEXA_CODEX_MATH_A1_FORMAL_PROOF__ DONE` (bench) + `__HEXA_CODEX_NUMERICS_MATH_A1__ DONE` (verify). **실측 측정 DEFERRED** — cycle-11+ T4 (AIME informal-acc + Lean/Coq formal-verify harness on lm_foundry eval + HF transformers + vast.ai pod). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — identity close ≠ measured close.

### 축 B — multi-step arithmetic (measured ladder)
- [ ] B1 — multi-step arithmetic · 긴 계산 chain 정확도 측정. single-step vs N-step 산술 정확도 ladder. 반증자: 10-step 산술 < single-step × 0.3 → error 누적으로 긴 chain 붕괴 (step 별 error 가 곱셈적으로 전파). GSM8K / 산술 chain-of-thought eval surface. (measured tier 필요 — cycle-11+ T4.)

### 축 N — 🆕 NOVEL: 답-증명 일치 (answer-proof coherence ⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — MATH self-NOVEL. answer correctness ≠ proof validity. AlphaProof formal verification 패러다임. 도착지 없음. 외부 anchor: DeepMind 2024 AlphaProof (Lean kernel-checked) · Trinh 2024 AlphaGeometry (Nature) · Lean mathlib · reasoning-faithfulness literature.
- [ ] N1 — 정답을 맞춰도 그 증명 과정이 valid 한가 · 정답 correct 중 증명 valid 비율. 반증자: 정답 correct 중 증명 valid 비율 < 70% → "답만 맞고 과정 틀림" (reasoning faithfulness 붕괴 — 모델이 정답을 우연/암기로 맞히고 증명은 hand-wave). A1 의 formal_ratio 와 구분: A1 = "답 맞춘 문제 중 형식 증명까지 한 비율", N1 = "답 맞춘 문제 중 (형식 여부 무관) 증명/추론 과정이 valid 한 비율" — N1 이 더 근본 (faithfulness).

## SANDBOX 활용 (measurement substrate)

MATH 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — HF transformers infer (AIME/MATH/GSM8K) / Lean mathlib kernel formal-verify / lm_foundry retrain (mac M3 / ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local (closed-form) | `VERTICAL/MATH/verdicts/a1_formal_proof_verdict.txt` |
| B1 multi-step arithmetic ladder | SANDBOX bench harness (GSM8K / 산술 chain) | `VERTICAL/MATH/verdicts/b1_*` |
| N1 ⭐ NOVEL answer-proof coherence | lm_foundry eval / Lean kernel / vast.ai pod | `VERTICAL/MATH/verdicts/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM math-routing wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| formal-proof 검증율 estimator · multi-step arithmetic budget · answer-proof coherence gate | math task 시 formal-prover 라우팅 결정 · 긴 계산 chain step-budget · 정답 답변 proof-validity gate (답만 맞는 hand-wave 거부) | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **MATH 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반. A1 은 현재 placeholder data 의 closed-form identity (🔵 STRUCTURAL + 🟡 BY-CITATION) — 실측 (🟢 SUPPORTED-NUMERICAL) 아님.
- **answer ≠ proof.** 수학의 핵심 분리 — 답 맞히기(informal_acc) 와 증명 검증(formal_verified) 은 다른 능력. A1 의 verify gap (formal_ratio), N1 의 reasoning faithfulness (answer-proof coherence) 가 이 분리를 측정. 답 맞힘을 증명 valid 로 착각하지 않는다.
- **recipe ≠ measurement.** build recipe = 만들기 · MATH 도메인 = 측정. 둘을 섞지 않는다.
- **formal-verify = kernel truth.** 형식 검증의 truth oracle 은 Lean mathlib kernel (LLM 자기-판정 아님). N1 의 proof-valid 판정도 가능한 한 kernel-check 또는 외부 prover 기준 (`cx_claim_verify` self-judge 금지).
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: formal_ratio < 50% → 답은 맞지만 증명 못함 (verify gap) · 정답 correct 중 증명 valid < 70% → reasoning faithfulness 붕괴
> **Anticipated ENGINE behavior wire**: math-task formal-prover 라우팅 router · multi-step arithmetic step-budget · answer-proof coherence gate (hand-wave proof 거부)
>
> ⏸ DEFERRED waiting on cycle-11+ T4 measured fire (AIME informal-acc + Lean/Coq formal-verify + GSM8K multi-step + answer-proof coherence rate).

## Cross-refs

- 후보 카탈로그: [`../../AXIS.easy.md`](../../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../../ENGINE/ENGINE.md`](../../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../../SANDBOX.md`](../../SANDBOX.md)
- vertical sibling: [`../CODE/CODE.md`](../CODE/CODE.md) (코드 전문 모델 측정) · [`../BIO/BIO.md`](../BIO/BIO.md) (바이오/의료 전문 모델 측정)
- 뉴로 측정 sibling (해석성 lane): [`../../NEUROEXP/NEUROEXP.md`](../../NEUROEXP/NEUROEXP.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../../MULTIMODAL/MULTIMODAL.md`](../../MULTIMODAL/MULTIMODAL.md) · [`../../DATA-QUALITY/DATA-QUALITY.md`](../../DATA-QUALITY/DATA-QUALITY.md)
- this domain: [`MATH.md`](MATH.md) (snapshot) · [`MATH.log.md`](MATH.log.md) (history)
