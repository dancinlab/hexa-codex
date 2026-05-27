# ARCHITECTURE — log

Append-only history sister of `ARCHITECTURE.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — 신규 단독 도메인 scaffold + A1 attention quality-per-FLOP (orchestra Model Architecture 흡수, cycle-10)

- [x] orchestra-research 20-skill 카탈로그의 "Model Architecture" lane 이 hexa-codex 도메인 목록에 미등록이었음 (cycle-10 흡수 누락 감사) → 흡수처 sibling 없어 신규 단독 도메인 ARCHITECTURE 으로 승격.
- [x] 3-axis 구조 scaffold (A · B · N⭐ MAIN NOVEL) — 신규 도메인 패턴 (A1 closed-form first + B second + N⭐ NOVEL MAIN) 따름 (LONG-CONTEXT · MULTIMODAL 참고).
- [x] A1 — attention 효율 (quality-per-FLOP) closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `bench/architecture_a1_attention_efficiency.hexa` + `verify/numerics_architecture_a1_attention_efficiency.hexa` · `verdicts/a1_attention_efficiency_verdict.txt`.
- [x] identity: `efficiency_x100 = quality × 100 / flops` (baseline MHA 대비 · = `(quality_v × flops_mha × 100)/(quality_mha × flops_v)`) · falsifier `efficiency < 1.0` (< 100 in × 100 ledger · 설계 이득 없음).
- [x] worked example 5 attention 변형 × {quality_x100, flops_x100}: mha (q80/f100% · 1.00× baseline silent) · flash_attn (q80/f60% · 1.66× silent) · gqa (q79/f70% · 1.41× silent) · mla (q81/f55% · 1.84× silent) · naive_variant (q78/f130% · 0.75× FIRES FLOP 늘고 quality 안 오르는 control). bidirectional discrimination 4 silent (이득) + 1 fires (이득 없음).
- [x] 7-check verifier: (1) baseline self-consistency eff(MHA)==100 (2) quality∈[0,100pp] flops>0 (3) efficiency identity 전 변형 (4) naive_variant fires (5) flash/gqa/mla silent (6) determinism (7) monotone sanity (equal quality + fewer FLOP ⇒ higher efficiency).
- [x] external anchors: Vaswani 2017 attention (arXiv:1706.03762) · Dao 2022 FlashAttention (arXiv:2205.14135) · Ainslie 2023 GQA (arXiv:2305.13245) · DeepSeek 2024 MLA (arXiv:2405.04434).
- [x] sentinels: bench `__HEXA_CODEX_ARCHITECTURE_A1_ATTENTION_EFFICIENCY__ DONE` · verify `__HEXA_CODEX_NUMERICS_ARCHITECTURE_A1__ DONE`.
- **honest residual**: 실측 attention FLOP profiling + downstream quality 미수행 — cycle-11+ T4 deferred (mac M3 llama-server + vast.ai pod · cx_lab_sandbox). placeholder data 의 closed-form identity (🔵+🟡) — 실측 (🟢) 아님.
- [ ] 축 B (B1 normalization 선택 안정성 · no-norm 이 norm 대비 수렴 < 0.5× 반증자 · RMSNorm vs LayerNorm vs no-norm) — 다음 라운드.
- [ ] 축 N⭐ NOVEL (N1 activation/positional design coupling · activation SwiGLU/GELU × positional RoPE/ALiBi monovariate fit error > 10% 반증자) — ⭐ MAIN priority lane · measured-tier 필요.
