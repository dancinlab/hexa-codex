# POST-TRAINING — log

Append-only history sister of `POST-TRAINING.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — 신규 단독 도메인 scaffold + A1 alignment-tax (orchestra Post-Training 흡수, cycle-10 orchestra-research)

- [x] orchestra-research 20-skill 카탈로그의 "Post-Training" 항목이 hexa-codex 미흡수 → 흡수처 도메인 없음 → 신규 단독 도메인 POST-TRAINING 으로 승격 (cycle-10 누락 점검).
- [x] 3-axis 구조 scaffold (A · B · N⭐ MAIN NOVEL) — 신규 도메인 패턴 (A1 closed-form first + B second measured + N⭐ NOVEL MAIN) 따름 (MULTIMODAL/LONG-CONTEXT 참고).
- [x] A1 — alignment tax closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `bench/post_training_a1_alignment_tax.hexa` + `verify/numerics_post_training_a1_alignment_tax.hexa` · `verdicts/a1_alignment_tax_verdict.txt`.
- [x] identity: `alignment_tax_pct = base_capability − post_capability` (× 100 ledger of pp · capability drop) · falsifier `alignment_tax > 5pp` (helpfulness↑ 인데 능력 희생 → over-aligned).
- [x] worked example 5 post-train methods × {base/post capability, helpfulness_gain}: sft_base (80/79 · tax 1pp · +8pp silent) · good_dpo (80/78 · 2pp · +15pp silent) · rlhf_ppo (80/76 · 4pp · +20pp silent) · grpo (80/77 · 3pp · +18pp silent) · over_aligned (80/68 · 12pp · +25pp FIRES capability 희생). bidirectional discrimination 4 silent + 1 fires · retention-monotone sanity (높은 tax ⇒ 낮은 retention).
- [x] external anchors: Ouyang 2022 InstructGPT/RLHF (arXiv:2203.02155) · Rafailov 2023 DPO (arXiv:2305.18290) · Shao 2024 GRPO (arXiv:2402.03300) · Bai 2022 Constitutional AI (arXiv:2212.08073).
- [x] 7-check verifier: (1) tax identity (2) capability range [0,100pp] (3) zero-tax synthetic silent (4) over_aligned fires 12pp (5) good alignment 4-method silent (6) determinism (7) retention-monotone + helpfulness ≥ 0 sanity. `hexa run` → 7/7 checks passed. sentinel `__HEXA_CODEX_NUMERICS_POST_TRAINING_A1__ DONE` · bench sentinel `__HEXA_CODEX_POST_TRAINING_A1_ALIGNMENT_TAX__ DONE`.
- **honest residual**: 실측 base vs post capability bench (MMLU/GSM8K/HumanEval pre/post alignment) 미수행 — cycle-11+ T4 deferred (local SANDBOX stack · lm_foundry/ Mk.I SFT/GRPO 실험 재활용 · cx_lab_sandbox). placeholder data 의 closed-form identity (🔵+🟡) — 실측 (🟢) 아님.
- [ ] 축 B (B1 method 효율 비교 · DPO vs PPO vs GRPO sample-efficiency · GRPO sample-eff < DPO × 0.8 반증자) — 다음 라운드.
- [ ] 축 N⭐ NOVEL (N1 helpfulness-safety-capability 3-way trade · 한 축 ↑ 가 다른 두 축 평균 > 5pp 희생 시 3-way 동시 개선 불가 반증자) — ⭐ MAIN priority lane · measured-tier 필요.
