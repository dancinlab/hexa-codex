# MULTILINGUAL — log

Append-only history sister of `MULTILINGUAL.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — A1 first probe build (CODEX cycle-9 round-2, /cycle-fg inline)

- [x] A1 — PPL gap closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `verify/numerics_multilingual_a1_perplexity_gap.hexa` · `verdicts/a1_perplexity_gap_verdict.txt`.
- [x] identity: `ppl_gap = PPL_lang / PPL_en` + `bytes_gap = bytes/tok_lang / bytes/tok_en` + compound `low_resource_flag = (ppl_gap > 2.0) AND (bytes_gap > 2.0)`.
- [x] bidirectional discrimination 정직 검증: sw 정확 발화 (5600/310) · ja 정확 silent (1400/121) · ko AND-trap (2133 위/189 아래 → False).
- [x] external anchors: Pires 2019 (arXiv:1906.01502) · Conneau 2020 XLM-R · Wu 2024 transfer asymmetry.
- **honest residual**: 실측 PPL/tokenizer 측정 미수행 — placeholder integer ledger (PPL × 1000 · bytes/tok × 100). 실측은 cycle-10+ T4 cost-bearing round (mac M3 llama-server / ubu-1 HF · MMLU multilingual · per-model fixture).
- [ ] 축 B (language family × task class × scale ladder) — 다음 라운드.
- [ ] 축 N⭐ NOVEL (cross-lingual transfer asymmetry L1→L2 vs L2→L1) — measured-tier 필요.
- [ ] ENGINE intake matrix 승격 검토 (axis G/H 후보).

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
