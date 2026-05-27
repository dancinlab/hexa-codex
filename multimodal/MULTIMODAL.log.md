# MULTIMODAL — log

Append-only history sister of `MULTIMODAL.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — 신규 단독 도메인 scaffold + A1 modality-balance (FRONTIER F2 흡수, cycle-10 reorg)

- [x] FRONTIER meta-domain 폐기 시 F2 MULTIMODAL 흡수처 도메인 없음 → 신규 단독 도메인 MULTIMODAL 으로 승격 (사용자 결정).
- [x] 3-axis 구조 scaffold (A · B · N⭐ MAIN NOVEL) — 22-candidate 도메인 패턴 (A1 closed-form first + B second + N⭐ NOVEL MAIN) 따름.
- [x] A1 — modality balance gap closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `bench/multimodal_a1_modality_balance.hexa` + `verify/numerics_multimodal_a1_modality_balance.hexa` · `verdicts/a1_modality_balance_verdict.txt` (FRONTIER/F2 이관 · 헤더 "absorbed from FRONTIER/F2").
- [x] identity: `gap_modality_x100 = acc_text − acc_modality` (× 100 ledger of pp) · falsifier `worst_modality_gap ≥ 30pp` (modality second-class citizen).
- [x] worked example 3 models × 4 modalities {text/image/audio/video}: gemma4_31B (85/82/80/78 pp · worst 7pp silent) · qwen3.6_72B (87/80/70/68 pp · worst 19pp silent) · legacy_vlm_4B (75/70/0/0 pp · worst 75pp fires audio/video unsupported 2-tower control). bidirectional discrimination 2 silent + 1 fires.
- [x] external anchors: Yang 2023 GPT-4V · Liu 2023 LLaVA (arXiv:2304.08485) · Driess 2023 PaLM-E (arXiv:2303.03378) · Chu 2024 Qwen-Audio (arXiv:2407.10759) · Google DeepMind 2026 Gemma 4 technical report.
- **honest residual**: 실측 MMMU/MMBench/AudioBench/Video-MME 미수행 — cycle-11+ T4 deferred (local Gemma 4 GGUF + vast.ai pod · cx_lab_sandbox). placeholder data 의 closed-form identity (🔵+🟡) — 실측 (🟢) 아님.
- [ ] 축 B (B1 cross-modal transfer · image→text 정보 transfer rate < within-text × 0.5 반증자) — 다음 라운드.
- [ ] 축 N⭐ NOVEL (N1 modality-reasoning coupling · cross-modal reasoning transfer < single-modal × 0.6 반증자) — ⭐ MAIN priority lane · measured-tier 필요.
