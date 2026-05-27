# MULTILINGUAL — log

Append-only history sister of `MULTILINGUAL.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — N1 ⭐ NOVEL MAIN build = tokenizer efficiency (CODEX cycle-10 reorg · train/infer/serve stack)

- [x] N1 ⭐ NOVEL MAIN — tokenizer efficiency closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `bench/multilingual_n1_tokenizer_efficiency.hexa` · `verify/numerics_multilingual_n1_tokenizer_efficiency.hexa` · `verdicts/n1_tokenizer_efficiency_verdict.txt`.
- [x] identity: `efficiency_ratio_x100(lang) = bytes_per_token_x100[lang] × 100 / bytes_per_token_x100[english]` (영어 baseline=100). 반증자: `efficiency_ratio < 50` (영어 × 0.5 미만 = low-resource token 2배 이상 소모).
- [x] 6 언어 ledger (Gemma 4 / Qwen tokenizer placeholder): english 420 (=100 baseline) · spanish 380 (=90) · chinese 250 (=59) · korean 200 (=47) · hindi 150 (=35 fires) · burmese 90 (=21 fires).
- [x] bidirectional discrimination 정직 검증: hindi+burmese fire (< 50, check 4) · english/spanish/chinese silent (≥ 50, check 5). 부수: korean (47) 도 placeholder data 상 fires — 주어진 ledger 의 정직한 결과.
- [x] external anchors: Sennrich 2016 BPE (arXiv:1508.07909) · Kudo 2018 SentencePiece (arXiv:1808.06226) · tiktoken · Gemma 4 tokenizer (256k vocab) · Ahia 2023 tokenizer 비용 불평등 (arXiv:2305.13707) · Petrov 2023 tokenizer unfairness (arXiv:2305.15425).
- [x] 기존 N⭐ (cross-lingual transfer asymmetry) → N2 강등 — tokenizer-efficiency 가 ⭐ MAIN N1 slot 점유. substrate 표 + A1 trailing ref 동기화.
- **honest residual**: 실측 tokenizer fertility 측정 미수행 — placeholder integer ledger (bytes/tok × 100). 실측은 cycle-10+ T4 (Gemma 4 / Qwen tokenizer · FLORES-200 parallel corpus · per-tokenizer bytes/token). frontier OPEN ([[feedback_closure_is_physical_limit]]) — formula close ≠ measured close · 새 언어·script·tokenizer 등장 시 axis 재오픈.
- [ ] 축 N2 (transfer asymmetry) — measured-tier 필요.
- [ ] 축 B (language family × task class × scale ladder) — measured ladder.

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
