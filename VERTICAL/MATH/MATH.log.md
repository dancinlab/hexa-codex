# MATH — log

Append-only history sister of `MATH.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — VERTICAL/MATH 신규 도메인 scaffold + A1 formal-proof 검증율 (cycle-10)

- [x] VERTICAL 전문 모델 측정 도메인군 (VERTICAL/\*) 의 MATH 노드 신규 scaffold — 수학 전문 모델 측정. sibling = VERTICAL/CODE (코드) · VERTICAL/BIO (바이오/의료).
- [x] **answer ≠ proof 분리 명시**: 수학의 핵심 특이점 — 답(informal_acc) 과 증명 검증(formal_verified) 은 분리 가능한 다른 능력. 답은 맞아도 증명은 틀릴 수 있음 (verify gap · reasoning faithfulness).
- [x] **recipe ≠ measurement 구분 명시**: build recipe = RECIPE (만들기 · formal-proof SFT/RL · autoformalization) · VERTICAL/MATH = MEASUREMENT (얼마나 잘 검증하나 · formal-proof 검증율 · answer-proof coherence) — 다른 layer. AlphaProof 의 Lean mathlib kernel-checked formal-verification 패러다임이 본 측정의 truth surface.
- [x] 3-axis 구조 scaffold (A closed-form formal-proof 검증율 · B measured multi-step arithmetic · N⭐ MAIN NOVEL answer-proof coherence) — 신규 도메인 패턴 (A1 closed-form first probe + B measured ladder + N⭐ NOVEL MAIN) 따름 (CODE · BIO sibling 참고).
- [x] A1 — formal-proof 검증율 closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `VERTICAL/MATH/bench/math_a1_formal_proof.hexa` + `VERTICAL/MATH/verify/numerics_math_a1_formal_proof.hexa` · `VERTICAL/MATH/verdicts/a1_formal_proof_verdict.txt`.
- [x] identity: `formal_ratio_pct = formal_verified × 100 / informal_acc` (acc × 100 ledger · 두 factor 의 × 100 이 ratio 에서 cancel → plain % · libm-free integer) · falsifier `formal_ratio < 50%` (형식 검증율 < 비형식 정답 × 0.5) → 답은 맞지만 증명 못함 (verify gap).
- [x] worked example 5 model × {informal_acc, formal_verified}: alphaproof (90/80 · ratio 88% silent · Lean formal SOTA) · gpt5_math (88/72 · 81% silent) · o1_reasoning (85/68 · 80% silent) · deepseek_prover (82/70 · 85% silent · formal-proof tune) · answer_only_model (85/30 · 35% FIRES · 답만 맞고 증명 못함 · verify gap). bidirectional discrimination 4 silent (증명이 답을 따라옴 · formal-prover) + 1 fires (answer-only · verify gap) + sanity (formal_verified ≤ informal_acc all · formal ⊆ informal · prover ratio monotone alphaproof 88 ≥ deepseek 85 ≥ gpt5 81 ≥ o1 80).
- [x] external anchors: Hendrycks 2021 Measuring Mathematical Problem Solving / MATH (arXiv:2103.03874) · DeepMind 2024 AlphaProof (Lean formal-proof IMO 2024 silver) · Trinh 2024 AlphaGeometry (Nature 625:476) · Lean mathlib kernel-checked formal-proof · AIME.
- [x] sentinel: `__HEXA_CODEX_MATH_A1_FORMAL_PROOF__ DONE` (bench) + `__HEXA_CODEX_NUMERICS_MATH_A1__ DONE` (verify). bench 의 `inf` reserved-value 충돌 → local var `informal` 로 rename 후 통과.
- **honest residual**: 실측 AIME informal-acc + Lean/Coq formal-verify 미수행 — cycle-11+ T4 deferred (HF transformers infer + Lean mathlib kernel check + lm_foundry retrain + vast.ai pod · cx_lab_sandbox). placeholder data 의 closed-form identity (🔵+🟡) — 실측 (🟢) 아님.
- [ ] 축 B (B1 multi-step arithmetic · single-step vs N-step 산술 정확도 ladder · 10-step < single-step × 0.3 반증자 — error 누적 chain 붕괴 · GSM8K eval surface) — 다음 라운드 · measured tier 필요.
- [ ] 축 N⭐ NOVEL (N1 answer-proof coherence · 정답 correct 중 증명 valid 비율 · valid < 70% 반증자 — 답만 맞고 과정 틀림 · reasoning faithfulness 붕괴 · A1 formal_ratio 보다 근본 · AlphaProof formal-verify 패러다임) — ⭐ MAIN priority lane · measured-tier 필요.
