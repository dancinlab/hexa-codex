# FINANCE — log

Append-only history sister of `FINANCE.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — VERTICAL/FINANCE 신규 도메인 scaffold + A1 수치 추론 정확도 (cycle-10)

- [x] VERTICAL 전문 모델 측정 도메인군 (VERTICAL/\*) 의 FINANCE 노드 신규 scaffold — 금융 전문 모델 측정. sibling = VERTICAL/CODE (코드) · VERTICAL/MATH (수학) · VERTICAL/BIO (바이오/의료).
- [x] **accuracy ≠ risk 분리 명시**: 금융의 핵심 특이점 — 평균 수치 정확도(numeric_acc) 와 의사결정 위험(tail loss · 환각 비대칭 손실) 은 분리 가능한 다른 능력. 1% 수치 오차도 금융에선 큰 손실, 잘못된 buy 추천(confident-wrong)의 손실이 놓친 기회(missed gain)의 손실을 압도 (Kelly criterion · downside risk).
- [x] **recipe ≠ measurement 구분 명시**: build recipe = RECIPE (만들기 · financial corpus SFT/RL · numeric-reasoning · program-of-thought) · VERTICAL/FINANCE = MEASUREMENT (얼마나 정밀하게 계산하나 · numeric accuracy · 환각 비대칭 손실) — 다른 layer. BloombergGPT 의 FinQA program-of-thought financial-numeric-reasoning 패러다임이 본 측정의 truth surface.
- [x] 3-axis 구조 scaffold (A closed-form 수치 추론 정확도 · B measured 시계열 추론 · N⭐ MAIN NOVEL 환각-위험 비대칭) — 신규 도메인 패턴 (A1 closed-form first probe + B measured ladder + N⭐ NOVEL MAIN) 따름 (CODE · MATH sibling 참고).
- [x] A1 — 수치 추론 정확도 closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `VERTICAL/FINANCE/bench/finance_a1_numeric_accuracy.hexa` + `VERTICAL/FINANCE/verify/numerics_finance_a1_numeric_accuracy.hexa` · `VERTICAL/FINANCE/verdicts/a1_numeric_accuracy_verdict.txt`.
- [x] identity: `numeric_acc_x100 = numeric_correct × 100 / numeric_questions` (counts → pct × 100 ledger · libm-free integer) · falsifier `numeric_acc < 9000` (90% 미만 · 금융은 정밀 critical — 1% 오차도 큰 손실) → 수치 계산 신뢰 불가.
- [x] worked example 5 model × {numeric_questions, numeric_correct}: bloomberg_gpt (100·95 → 95% silent · finance SOTA) · gpt5_finance (100·93 → 93% silent) · fin_claude (100·91 → 91% silent) · general_gpt5 (100·82 → 82% FIRES · general-purpose · 수치 오차) · weak_fin (100·70 → 70% FIRES · 신뢰 불가). bidirectional discrimination 3 silent (정밀 계산 · finance-specialist) + 2 fires (general/weak · 수치 계산 신뢰 불가) + sanity (numeric_correct ≤ numeric_questions all · finance ratio monotone bloomberg 95 ≥ gpt5_finance 93 ≥ fin_claude 91).
- [x] external anchors: Chen 2021 FinQA: A Dataset of Numerical Reasoning over Financial Data (arXiv:2109.00122) · Wu 2023 BloombergGPT: A Large Language Model for Finance (arXiv:2303.17564) · Islam 2023 FinanceBench: A New Benchmark for Financial Question Answering (arXiv:2311.11944).
- [x] sentinel: `__HEXA_CODEX_FINANCE_A1_NUMERIC_ACCURACY__ DONE` (bench) + `__HEXA_CODEX_NUMERICS_FINANCE_A1__ DONE` (verify).
- **honest residual**: 실측 FinQA / FinanceBench numeric eval + program-of-thought exec 미수행 — cycle-11+ T4 deferred (HF transformers infer + program-of-thought numeric exec + lm_foundry retrain + vast.ai pod · cx_lab_sandbox). placeholder data 의 closed-form identity (🔵+🟡) — 실측 (🟢) 아님.
- [ ] 축 B (B1 시계열 추론 · 시장 추세/예측 정합성 · 미래 예측이 random-walk baseline 못 이김 반증자 — 효율적 시장 가설에 굴복 · 시계열 forecast eval surface) — 다음 라운드 · measured tier 필요.
- [ ] 축 N⭐ NOVEL (N1 환각-위험 비대칭 · confident-wrong 금융 조언 손실가중 vs 정답 이득 · 손실가중 > 정답 이득 × 2 반증자 — 잘못된 buy ≫ 놓친 기회 · downside risk 가 upside gain 압도 · A1 numeric_acc 보다 근본 · Kelly criterion · downside risk 패러다임) — ⭐ MAIN priority lane · measured-tier 필요.
