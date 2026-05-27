# CODE — log

Append-only history sister of `CODE.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — VERTICAL/CODE 신규 도메인 scaffold + A1 pass@k (lm_foundry Mk.I 직결, cycle-10)

- [x] `VERTICAL/*` 그룹 폴더 신설 — vertical 전문 모델 측정 도메인군. CODE = 코드 생성 전문 모델 측정의 첫 도메인. NAME=CODE · path=VERTICAL/CODE/.
- [x] 3-axis 구조 scaffold (A · B · N⭐ MAIN NOVEL) — 신규 도메인 패턴 (A1 closed-form first probe + B second measured ladder + N⭐ NOVEL MAIN) 따름 (MULTIMODAL · DATA-QUALITY · LONG-CONTEXT 참고).
- [x] A1 — pass@k 코드 정확도 closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `bench/code_a1_pass_at_k.hexa` + `verify/numerics_code_a1_pass_at_k.hexa` · `verdicts/a1_pass_at_k_verdict.txt`.
- [x] identity: `oneshot_ratio_pct = pass_at_1 × 100 / pass_at_10` (pass@k × 100 ledger · × 100 factors cancel → ratio in plain %) · falsifier `ratio < 30%` (pass@1 < pass@10 × 0.3) → one-shot 약함 (sampling 의존).
- [x] worked example 5 code models × {pass@1, pass@10}: gpt5_code (88/96 · ratio 91% silent) · claude_code (85/94 · 90% silent) · qwen_coder (82/93 · 88% silent · #1 SWE-bench) · hexa_mk1 (70/82 · 85% silent · lm_foundry Mk.I) · weak_base (20/80 · 25% FIRES · sampling 의존). bidirectional discrimination 4 silent (one-shot 강함) + 1 fires (sampling 의존) + sanity (pass@1 ≤ pass@10 all · pass@1 ladder monotone gpt5 ≥ claude ≥ qwen ≥ hexa_mk1 ≥ weak_base).
- [x] external anchors: Chen 2021 HumanEval (arXiv:2107.03374) · Austin 2021 MBPP (arXiv:2108.07732) · Jimenez 2023 SWE-bench (arXiv:2310.06770) · hexa-lang Mk.I 94.29% (lm_foundry `code` verb GA · 627/665).
- [x] sentinel: `__HEXA_CODEX_CODE_A1_PASS_AT_K__ DONE` (bench) + `__HEXA_CODEX_NUMERICS_CODE_A1__ DONE` (verify). `hexa run` 7/7 checks passed.
- [x] lm_foundry Mk.I 직결: hexa_mk1 = lm_foundry `code` verb (Qwen2.5-Coder-7B + LoRA r=64). A1 의 HumanEval/MBPP pass@k (범용 Python code-gen) 는 hexa-lang strict 94.29% Mk.I (hexa-lang 전용 strict eval) 와 별도 metric — 두 metric 혼동 안 함.
- **honest residual**: 실측 pass@k harness 미수행 — cycle-11+ T4 deferred (HumanEval/MBPP/SWE-bench pass@k on lm_foundry eval + vast.ai pod · cx_lab_sandbox). placeholder data 의 closed-form identity (🔵+🟡) — 실측 (🟢) 아님.
- [ ] 축 B (B1 코드 보안 · 생성 코드 취약점 > 30% 반증자 — Pearce 2022 Copilot security) — 다음 라운드.
- [ ] 축 N⭐ NOVEL (N1 repo-level multi-file coherence · multi-file 정합성 < single-file × 0.5 반증자 — SWE-bench repo-level 능력) — ⭐ MAIN priority lane · measured-tier 필요.
