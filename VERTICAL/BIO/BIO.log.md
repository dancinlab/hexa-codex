# BIO — log

Append-only history sister of `BIO.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — VERTICAL/BIO 신규 도메인 scaffold + A1 specialization-gain (cycle-10)

- [x] VERTICAL 전문 모델 측정 도메인군 (VERTICAL/\*) 의 BIO 노드 신규 scaffold — 바이오/의료 전문 모델 측정. sibling = VERTICAL/CODE.
- [x] **recipe ≠ measurement 구분 명시**: `lm_foundry/docs/bio-llm.md` = RECIPE (어떻게 만드나 · `hexa-forge bio` build spec) · VERTICAL/BIO = MEASUREMENT (얼마나 잘하나 · specialization gain) — 다른 layer. 구 BIODATA (데이터셋 · retire 2026-05-27 · finding 은 bio-llm.md §FINDINGS 로 흡수) 와도 별개 ([[project_bio_reorg_neuroexp_biodata]]).
- [x] 3-axis 구조 scaffold (A closed-form · B 의료 안전성 · N⭐ MAIN NOVEL in-silico↔in-vitro) — 신규 도메인 패턴 (A1 closed-form first probe + B measured ladder + N⭐ NOVEL MAIN) 따름 (MULTIMODAL · DATA-QUALITY 참고).
- [x] A1 — bio-specialization advantage closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `bench/bio_a1_specialization_gain.hexa` + `verify/numerics_bio_a1_specialization_gain.hexa` · `verdicts/a1_specialization_gain_verdict.txt`.
- [x] identity: `specialization_gain_x100 = bio_specialized_acc − general_model_bio_acc` (× 100 ledger of pp) · falsifier `gain < 10pp` (< 1000 in × 100 ledger) → specialization 무의미 (general 로 충분).
- [x] worked example 5 model × {bio_task_acc, general_model_bio_acc}: med_palm2 (85/60 · gain 25.0pp silent) · bio_gpt (80/60 · gain 20.0pp silent) · esm_protein (78/55 · gain 23.0pp silent) · general_gpt5_on_bio (60/60 · gain 0.0pp FIRES · baseline) · shallow_bio_tune (62/60 · gain 2.0pp FIRES). bidirectional discrimination 3 silent (강한 bio model · specialization 유의미) + 2 fires (general baseline + 얕은 tune · 무의미) + monotone sanity (med_palm2 25 ≥ esm_protein 23 ≥ bio_gpt 20).
- [x] external anchors: Singhal 2023 Med-PaLM 2 Towards Expert-Level Medical QA (arXiv:2305.09617) · Lin 2023 ESM-2/ESMFold (Science 379:1123) · Jumper 2021 AlphaFold (Nature 596:583) · Luo 2022 BioGPT (arXiv:2210.10341).
- [x] sentinel: `__HEXA_CODEX_BIO_A1_SPECIALIZATION_GAIN__ DONE` (bench) + `__HEXA_CODEX_NUMERICS_BIO_A1__ DONE` (verify).
- **honest residual**: 실측 MedQA/PubMedQA/ProteinGym eval 미수행 — cycle-11+ T4 deferred (HF transformers eval + lm_foundry retrain + vast.ai pod · cx_lab_sandbox). placeholder data 의 closed-form identity (🔵+🟡) — 실측 (🟢) 아님.
- [ ] 축 B (B1 의료 조언 hallucination / harm rate · confident-wrong > 5% 반증자 · 안전 critical · 의료 set PRIVATE default `cx_hf_safety_private`) — 다음 라운드.
- [ ] 축 N⭐ NOVEL (N1 in-silico↔in-vitro gap · 모델 예측 vs wet-lab 검증 correlation · correlation < 0.5 반증자 — 계산 예측 신뢰 불가 · AlphaFold wet-lab 검증 패러다임) — ⭐ MAIN priority lane · measured-tier 필요.
