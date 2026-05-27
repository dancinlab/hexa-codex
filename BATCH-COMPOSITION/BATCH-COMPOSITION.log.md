# BATCH-COMPOSITION — log

Append-only history sister of `BATCH-COMPOSITION.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — A1 padding-waste duality closed-form (cycle-9 round-8 · CODEX bg · 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7)

- [x] `BATCH-COMPOSITION/bench/batch_composition_a1_padding_waste.hexa` — 5 compositions × `padding_waste_x100 + tput_x100 == 100` duality on integer × 100 ledger (libm-free). LS baseline (util=3960/4000 · tput=99 · gap=0) silent · B4 (util=3800 · tput=95 · gap_x10=40) silent · NS (util=3880 · tput=97 · gap_x10=20) silent · RM (util=3000 · tput=75 · gap_x10=240) borderline silent (24pp < 30pp threshold) · WC (util=1560 · tput=39 · gap_x10=600) FIRES (60pp catastrophic 1-long+31-short pad).
- [x] `BATCH-COMPOSITION/verify/numerics_batch_composition_a1_padding_waste.hexa` — 7-check verifier (1) duality identity (∀ comp) (2) range [0,100] (3) zero-padding synthetic floor (4) WC fires (gap_x10=600 > 300) (5) LS self-gap=0 silent (structural floor) (6) determinism (7) sanity LS tput ≥ RM tput. `hexa run` → `7/7 checks passed`.
- [x] verdict file `BATCH-COMPOSITION/verdicts/a1_padding_waste_verdict.txt` — env-driven `_root()` resolution; tier 🔵 STRUCTURAL + 🟡 BY-CITATION; verdict_class SUPPORTED-NUMERICAL.
- [x] axis A1 flipped to `[x]` in `BATCH-COMPOSITION.md` snapshot.
- [x] external anchors recorded — Yu 2022 Orca (OSDI 2022 · continuous batching) · Kwon 2023 vLLM PagedAttention (SOSP 2023 · sec on length-mix) · NVIDIA Triton dynamic batcher docs · Sheng 2023 FlexGen (ICML 2023).
- [ ] 실측 (cycle-10+ T4) — vLLM serving bench on Llama-3 8B · ShareGPT length distribution · GPU-saturated regime (vast.ai cost-bearing pod). Frontier OPEN ([[feedback_closure_is_physical_limit]]).
- [ ] axis B1 (difficulty-mix × scale × packing ladder) next.
- [ ] axis N1 ⭐ MAIN NOVEL (informed-pack vs naive-sort) next.

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
