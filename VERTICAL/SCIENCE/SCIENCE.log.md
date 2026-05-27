# SCIENCE — log

Append-only history sister of `SCIENCE.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — VERTICAL/SCIENCE 신규 도메인 scaffold + A1 multi-step 유도 능력 (cycle-10)

- [x] VERTICAL 전문 모델 측정 도메인군 (VERTICAL/\*) 의 SCIENCE 노드 신규 scaffold — 과학(물리·화학·일반과학) 전문 모델 측정. sibling = VERTICAL/MATH (수학) · VERTICAL/CODE (코드) · VERTICAL/BIO (바이오/의료) · VERTICAL/MEDICAL (임상).
- [x] **SCIENCE ≠ MATH ≠ BIO ≠ MEDICAL 구분 명시**: SCIENCE = 물리·화학·일반과학 추론 (GPQA · multi-step 유도) · derive gap (사실 암기 ≠ 다단계 유도) falsifier. MATH = formal-proof 검증율 (verify gap · 답 ≠ 증명) · BIO = bio-specialization gain (in-silico↔in-vitro · wet-lab) · MEDICAL = clinical safety. 다른 vertical · 다른 falsifier.
- [x] **fact ≠ derivation 분리 명시**: 과학 추론의 핵심 — 단답 사실 암기(single_fact) 와 다단계 유도(multistep_derive) 는 분리 가능한 다른 능력. 사실은 알아도 유도 못할 수 있음 (derive gap · shallow knowledge).
- [x] **recipe ≠ measurement 구분 명시**: build recipe = RECIPE (만들기 · science SFT/RL · multi-step CoT corpus) · VERTICAL/SCIENCE = MEASUREMENT (얼마나 잘 유도하나 · multistep derive 정확도 · 단위 일관성 · 가설 falsifiability) — 다른 layer. GPQA 의 graduate-level science reasoning 이 본 측정의 truth surface.
- [x] 3-axis 구조 scaffold (A closed-form multi-step 유도 능력 · B measured 단위/차원 일관성 · N⭐ MAIN NOVEL 반증가능 가설 생성) — 신규 도메인 패턴 (A1 closed-form first probe + B measured ladder + N⭐ NOVEL MAIN) 따름 (MATH · CODE · BIO sibling 참고).
- [x] A1 — multi-step 유도 능력 closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `VERTICAL/SCIENCE/bench/science_a1_multistep_derive.hexa` + `VERTICAL/SCIENCE/verify/numerics_science_a1_multistep_derive.hexa` · `VERTICAL/SCIENCE/verdicts/a1_multistep_derive_verdict.txt`.
- [x] identity: `derive_ratio_pct = multistep × 100 / single_fact` (acc × 100 ledger · 두 factor 의 × 100 이 ratio 에서 cancel → plain % · libm-free integer) · falsifier `derive_ratio < 40%` (다단계 유도 < 단답 사실 × 0.4) → 사실 암기는 되나 유도 못함 (shallow knowledge · derive gap).
- [x] worked example 5 model × {single_fact, multistep_derive}: gpt5_science (88/76 · ratio 86% silent) · o1_reasoning (85/74 · 87% silent) · gemini_science (86/72 · 83% silent) · lookup_model (85/25 · 29% FIRES · 사실만 암기 · derive gap) · weak_sci (70/20 · 28% FIRES · 얕은 지식). bidirectional discrimination 3 silent (유도가 사실을 따라옴 · reasoner) + 2 fires (lookup/weak · derive gap) + sanity (multistep ≤ single_fact all · multi ⊆ single · reasoner ratio monotone o1 87 ≥ gpt5 86 ≥ gemini 83).
- [x] 단위테스트 bidirectional: o1_science (single 88·multi 78 → ratio 88% silent · int-div floor of 88.6) vs lookup_model (single 85·multi 25 → 29% fires). check 3 으로 검증.
- [x] external anchors: Rein 2023 GPQA: A Graduate-Level Google-Proof Q&A Benchmark (arXiv:2311.12022) · Wang 2023 SciBench: Evaluating College-Level Scientific Problem-Solving (arXiv:2307.10635) · He 2024 OlympiadBench (arXiv:2402.14008).
- [x] sentinel: `__HEXA_CODEX_SCIENCE_A1_MULTISTEP_DERIVE__ DONE` (bench) + `__HEXA_CODEX_NUMERICS_SCIENCE_A1__ DONE` (verify). `hexa run` 7/7 checks passed.
- **honest residual**: 실측 GPQA single-fact + multi-step derive 미수행 — cycle-11+ T4 deferred (HF transformers infer + lm_foundry retrain + vast.ai pod · cx_lab_sandbox). placeholder data 의 closed-form identity (🔵+🟡) — 실측 (🟢) 아님.
- [ ] 축 B (B1 단위/차원 일관성 · 물리 계산 dimensional analysis · 단위 불일치 답 > 10% 반증자 — dimensional analysis 붕괴 · 물리 word-problem / SciBench dimensional 채점 surface) — 다음 라운드 · measured tier 필요.
- [ ] 축 N⭐ NOVEL (N1 반증가능 가설 생성 · 생성 가설 중 testable/falsifiable 비율 · falsifiable 비율 < 70% 반증자 — 사이비 과학 · non-Popperian · A 의 derive gap 보다 근본 (과학 방법론 자체) · Popper falsifiability 패러다임) — ⭐ MAIN priority lane · measured-tier 필요.
