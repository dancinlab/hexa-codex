# MODEL-CLASS — log

Append-only history sister of `MODEL-CLASS.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — 신규 단독 도메인 scaffold + A1 architecture-family scaling (LLM 종류 분류학, cycle-10)

- [x] "LLM 종류" 측정 빈칸 감사 — 모델 종류 관련 축이 흩어져 있었음 (ENERGY/N1 dense-vs-MoE · ARCHITECTURE micro 구조 · MULTIMODAL modality · HALLUCINATION reasoning), 통합 "모델 분류학" 부재. 2026 frontier 비-transformer family (Mamba · Jamba · RWKV · diffusion-LM) 등장 → architecture family 측정 가치 → 신규 단독 도메인 MODEL-CLASS 승격.
- [x] ARCHITECTURE 와의 구분 명시 — ARCHITECTURE = micro 부품 (attention/norm/activation/positional · 해부학) · MODEL-CLASS = macro 품종 (architecture-family/specialization/scale-class · 분류학). 별 dimension · × 100 ledger 공유.
- [x] 3-axis 구조 scaffold (A · B · N⭐ MAIN NOVEL) — 신규 도메인 패턴 (A1 closed-form first + B second + N⭐ NOVEL MAIN) 따름 (ARCHITECTURE · LONG-CONTEXT · MULTIMODAL 참고).
- [x] A1 — architecture family scaling closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `bench/model_class_a1_arch_family.hexa` + `verify/numerics_model_class_a1_arch_family.hexa` · `verdicts/a1_arch_family_verdict.txt`.
- [x] identity: `family_ratio_x100 = quality[family] × 100 / quality[decoder_baseline]` (decoder-only transformer = 100% baseline · same param tier) · falsifier `family_ratio < 90` (< 90% of decoder baseline · architecture diversity 무의미 · 못 따라잡음).
- [x] worked example 5 family @ same 7B tier × {param_b, quality_x100}: decoder_transformer (7B·q100 · 100% baseline silent) · mamba_ssm (7B·q96 · 96% silent) · jamba_hybrid (7B·q98 · 98% silent) · rwkv (7B·q92 · 92% silent) · early_diffusion_lm (7B·q78 · 78% FIRES 아직 decoder 못 따라잡은 control). bidirectional discrimination 4 silent (경쟁력 있음) + 1 fires (아직 못 따라잡음).
- [x] 7-check verifier: (1) baseline self-consistency family_ratio(decoder)==100% (2) param_b>0 quality∈[0,100pp] same-tier (3) family_ratio identity 전 family (4) early_diffusion_lm fires (78%<90%) (5) mamba/jamba/rwkv silent (≥90%) (6) determinism (7) monotone sanity (same tier + higher quality ⇒ higher family_ratio).
- [x] external anchors: Vaswani 2017 decoder transformer (arXiv:1706.03762) · Gu 2023 Mamba SSM (arXiv:2312.00752) · Lieber 2024 Jamba hybrid (arXiv:2403.19887) · Peng 2023 RWKV (arXiv:2305.13048) · Li 2022 Diffusion-LM (arXiv:2205.14217).
- [x] sentinels: bench `__HEXA_CODEX_MODEL_CLASS_A1_ARCH_FAMILY__ DONE` · verify `__HEXA_CODEX_NUMERICS_MODEL_CLASS_A1__ DONE`.
- **honest residual**: 실측 same-tier downstream quality profiling 미수행 — cycle-11+ T4 deferred (mac M3 llama-server + vast.ai pod · cx_lab_sandbox). placeholder data 의 closed-form identity (🔵+🟡) — 실측 (🟢) 아님.
- [ ] 축 B (B1 specialization type task-fit · base/instruct/reasoning/code · code-specialized 가 일반 task 에서 base 대비 < 0.8× over-specialization 반증자) — 다음 라운드.
- [ ] 축 N⭐ NOVEL (N1 scale-class emergent 능력 · nano/small/medium/large/frontier · scale 10× 증가 시 능력 step-change < 2× smooth-scaling mirage 반증자 · Wei 2022 emergent abilities arXiv:2206.07682 · Schaeffer 2023 mirage arXiv:2304.15004) — ⭐ MAIN priority lane · measured-tier 필요.
