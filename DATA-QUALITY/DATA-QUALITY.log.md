# DATA-QUALITY — log

Append-only history sister of `DATA-QUALITY.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — 신규 단독 도메인 scaffold + A1 dedup-gain (orchestra Data Processing 흡수, cycle-10)

- [x] orchestra-research 20-skill 누락 흡수 sweep 에서 "Data Processing" 카테고리가 기존 hexa-codex 도메인에 흡수처 없음 → 신규 단독 도메인 DATA-QUALITY 으로 승격.
- [x] 3-axis 구조 scaffold (A · B · N⭐ MAIN NOVEL) — 신규 도메인 패턴 (A1 closed-form first probe + B second measured ladder + N⭐ NOVEL MAIN) 따름 (MULTIMODAL · LONG-CONTEXT 참고).
- [x] A1 — dedup rate → downstream gain closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `bench/data_quality_a1_dedup_gain.hexa` + `verify/numerics_data_quality_a1_dedup_gain.hexa` · `verdicts/a1_dedup_gain_verdict.txt`.
- [x] identity: `gain_after_dedup_x100 = perf_dedup − perf_raw` (× 100 ledger of pp) · falsifier `gain < 2pp` (< 200 in × 100 ledger) → 중복 무해 (dedup 불필요).
- [x] worked example 5 corpora × {dup_rate, perf_raw, perf_dedup}: common_crawl (65% dup · 60.0→67.5 · gain 7.5pp silent) · oscar_web (50% dup · 62.0→68.0 · gain 6.0pp silent) · c4_raw (30% dup · 65.0→69.5 · gain 4.5pp silent) · fineweb_clean (8% dup · 71.0→72.5 · gain 1.5pp FIRES) · curated_books (3% dup · 73.0→73.8 · gain 0.8pp FIRES). bidirectional discrimination 3 silent (high-dup · dedup 유의미) + 2 fires (이미 clean · 중복 무해) + monotone sanity (dup_rate ↑ → gain ↑).
- [x] external anchors: Lee 2022 Deduplicating Training Data Makes Language Models Better (arXiv:2107.06499) · Penedo 2024 FineWeb (arXiv:2406.17557) · Li 2024 DataComp-LM / DCLM (arXiv:2406.11794).
- [x] sentinel: `__HEXA_CODEX_DATA_QUALITY_A1_DEDUP_GAIN__ DONE` (bench) + `__HEXA_CODEX_NUMERICS_DATA_QUALITY_A1__ DONE` (verify).
- **honest residual**: 실측 dedup 전/후 retrain + downstream eval 미수행 — cycle-11+ T4 deferred (MinHash dedup pipeline + lm_foundry retrain + vast.ai pod · cx_lab_sandbox). placeholder data 의 closed-form identity (🔵+🟡) — 실측 (🟢) 아님.
- [ ] 축 B (B1 label noise robustness · 10% 노이즈 주입 시 acc drop > 노이즈율 반증자 — noise amplification) — 다음 라운드.
- [ ] 축 N⭐ NOVEL (N1 quality-classifier 선택 효과 · FineWeb-Edu top-10% vs random-10% · downstream < 1.1× 반증자) — ⭐ MAIN priority lane · measured-tier 필요.
