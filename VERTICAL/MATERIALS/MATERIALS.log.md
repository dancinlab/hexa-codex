# MATERIALS — log

Append-only history sister of `MATERIALS.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — VERTICAL/MATERIALS 신규 도메인 scaffold + A1 in-silico↔합성 gap (cycle-10)

- [x] VERTICAL 전문 모델 측정 도메인군 (VERTICAL/\*) 의 MATERIALS 노드 신규 scaffold — 신소재 발견 전문 모델 측정 (GNoME 식 frontier). sibling = VERTICAL/SCIENCE · VERTICAL/BIO · VERTICAL/CODE · VERTICAL/MATH.
- [x] **MATERIALS ≠ SCIENCE ≠ BIO 구분 명시**: SCIENCE = 물리·화학 multi-step 유도 추론 (derive gap) · BIO = 바이오/의료 in-silico↔in-vitro (wet-lab · 생물학적 truth · correlation 붕괴) · MATERIALS = 신소재 발견 (GNoME · 결정구조 예측 · 합성 가능성 · in-silico↔합성 gap). BIO 의 wet-lab 검증과 표면상 비슷하나 다른 truth surface (무기 결정 합성 vs 생물학적 활성) — 다른 vertical · 다른 falsifier.
- [x] **recipe ≠ measurement 구분 명시**: build recipe = RECIPE (어떻게 만드나 · materials discovery SFT/RL) · VERTICAL/MATERIALS = MEASUREMENT (얼마나 잘하나 · 합성률) — 다른 layer.
- [x] 3-axis 구조 scaffold (A closed-form in-silico↔합성 gap · B property 예측 정확도 · N⭐ MAIN NOVEL 합성 경로 실현가능성) — 신규 도메인 패턴 (A1 closed-form first probe + B measured ladder + N⭐ NOVEL MAIN) 따름 (SCIENCE · BIO 참고).
- [x] A1 — in-silico↔합성 gap closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `bench/materials_a1_synthesis_gap.hexa` + `verify/numerics_materials_a1_synthesis_gap.hexa` · `verdicts/a1_synthesis_gap_verdict.txt`.
- [x] identity: `synthesis_rate_x100 = synthesized_confirmed × 100 / predicted_stable` (정수 % · floor div) · falsifier `rate < 50%` → 예측 신물질의 합성 가능성 < 50% · in-silico 환상 (계산 예측이 실험으로 확인 안 됨).
- [x] worked example 5 model × {predicted_stable, synthesized_confirmed}: gnome (1000/736 · rate 73% silent · GNoME SOTA) · mattergen (1000/680 · 68% silent) · m3gnet (1000/620 · 62% silent) · naive_gen (1000/200 · 20% FIRES · 계산 ≠ 합성 truth) · random_struct (1000/50 · 5% FIRES · baseline floor). bidirectional discrimination 3 silent (예측이 실험으로 확인됨 · 강한 발견 모델) + 2 fires (naive/random · in-silico 환상) + sanity (confirmed ≤ predicted all · rate ≤ 100% · discovery monotone gnome 73 ≥ mattergen 68 ≥ m3gnet 62).
- [x] external anchors: Merchant 2023 GNoME Scaling deep learning for materials discovery (Nature 624:80) · Zeni 2024 MatterGen generative model for inorganic materials (arXiv:2312.03687) · Chen 2022 M3GNet universal interatomic potential (Nature Comp Sci) · Materials Project (open DFT database).
- [x] sentinel: `__HEXA_CODEX_MATERIALS_A1_SYNTHESIS_GAP__ DONE` (bench) + `__HEXA_CODEX_NUMERICS_MATERIALS_A1__ DONE` (verify).
- **honest residual**: 실측 합성-검증 harness 미수행 — cycle-11+ T4 deferred (GNoME-style 안정성 예측 + ICSD/Materials Project 합성-검증 cross-ref + HF transformers eval + lm_foundry retrain + vast.ai pod · cx_lab_sandbox). placeholder data 의 closed-form identity (🔵+🟡) — 실측 (🟢) 아님.
- [ ] 축 B (B1 property 예측 정확도 · bandgap/formation-energy 예측 MAE · DFT 대비 MAE > 10% 반증자 · Materials Project / Matbench surface) — 다음 라운드.
- [ ] 축 N⭐ NOVEL (N1 합성 경로 실현가능성 · 제안 합성경로의 실험실 성공률 · 성공률 < 30% 반증자 — 합성 경로 실현 불가 · the synthesis bottleneck · GNoME 380k 예측 중 실제 합성 가능 비율 · A-Lab 자율 합성 패러다임) — ⭐ MAIN priority lane · measured-tier 필요.
