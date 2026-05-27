# CONTAMINATION — log

Append-only history sister of `CONTAMINATION.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — A1 first probe build (CODEX cycle-9 round-1)

- [x] `CONTAMINATION/bench/contamination_a1_ngram_ratio.hexa` — closed-form n-gram contamination ratio formula encoding (`rate = |matched_n-grams| / |total_n-grams| ∈ [0,1]`). 6-row worked example w/ placeholder counts: edges {clean=0%, full=100%}, mid {low=5%, borderline=29%, tripped=42%, max_real=85%}.
- [x] `CONTAMINATION/verify/numerics_contamination_a1_ngram_ratio.hexa` — 6-check falsifier verifier: (1) closed-form recompute match · (2) range ∈ [0,1] · (3) zero-edge → 0 · (4) full-edge → 1 · (5) falsifier fires iff > 30% (Sainz 2023 threshold) · (6) determinism. ✅ **6/6 PASS** · 🔵 STRUCTURAL + 🟡 BY-CITATION. verdict written to `CONTAMINATION/verdicts/a1_ngram_ratio_verdict.txt`.
- [x] `CONTAMINATION/CONTAMINATION.md::축 A1` → `[x]` flip · CYCLE-9 round-1 wire note · ENGINE A1 style mirror · external anchors Dodge 2021 (arXiv:2104.08758) · Sainz 2023 (arXiv:2310.18018) · Magar & Schwartz 2022 (arXiv:2203.08242).
- [ ] **honest residual** — real pretrain corpus scan DEFERRED (cost-bearing, separate cycle-10+ T4 round on ubu-1): C4/Pile/RedPajama × MMLU/HellaSwag/GSM8K via Dodge-style 13-gram bloom-filter; output → `.verdicts/CONTAMINATION/a1_<eval>_<corpus>_real.txt`; eval set HF registration `dancinlab/hexa-codex-contamination-evals-v1` (cx_hf_eval_register).
- [ ] **frontier OPEN** (feedback_closure_is_physical_limit) — closed-form/citation close ≠ measured close; 새 eval set·corpus·검출 기법 (paraphrase-aware, embedding-similarity, semantic dedup) 등장 시 축 재개.

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
