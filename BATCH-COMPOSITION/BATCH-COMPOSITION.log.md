# BATCH-COMPOSITION — log

Append-only history sister of `BATCH-COMPOSITION.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — N1 ⭐ NOVEL MAIN speculative-decoding accept × speedup closed-form (cycle-10 reorg Batch B · CODEX bg · 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7)

- [x] `BATCH-COMPOSITION/bench/batch_composition_n1_speculative_decoding.hexa` — 5 draft-target combos × {accept_x100, speedup_x100} on integer × 100 ledger (libm-free). closed-form relation `predicted_speedup_x100 = 100 + accept_x100×(k−1)/k` (k_draft=5 · first-order monotone). tiny_draft_good (80% · 250 = 2.5×) silent · medium_draft (70% · 210 = 2.1×) silent · self_spec_medusa (75% · 230 = 2.3×) silent · mismatched_draft (45% · 130 = 1.3×) FIRES · bad_draft (30% · 105 = 1.05×) FIRES. Falsifier: accept < 50% OR speedup < 1.2× → speculative 무의미.
- [x] `BATCH-COMPOSITION/verify/numerics_batch_composition_n1_speculative_decoding.hexa` — 7-check verifier (1) accept→speedup relation (helper == inline ∀ combo) (2) range accept ∈ [0,10000] · speedup ≥ 100 (3) zero-accept synthetic (α=0 → predicted 100 = 1×) (4) bad_draft fires (30% < 50%) + mismatched fires (5) good drafts silent + lower-bound speedup ≥ predicted (6) determinism (7) monotone sanity accept↑ ⇒ predicted non-decreasing. `hexa run` → `7/7 checks passed`.
- [x] verdict file `BATCH-COMPOSITION/verdicts/n1_speculative_decoding_verdict.txt` — env-driven `_root()` resolution; tier 🔵 STRUCTURAL + 🟡 BY-CITATION; verdict_class SUPPORTED-NUMERICAL.
- [x] A1 의 padding-waste (per-pass slot utilization) 와 orthogonal 한 token-parallelism throughput lever — A1 throughput 보완.
- [x] 기존 N⭐ (informed-pack vs naive-sort) → N2 강등; speculative-decoding 이 새 N1 ⭐ MAIN priority lane.
- [x] external anchors — Leviathan 2023 (arXiv:2211.17192 · ICML 2023) · Chen 2023 (arXiv:2302.01318 · DeepMind) · Cai 2024 Medusa (arXiv:2401.10774 · self-spec heads) · Stern 2018 blockwise (NeurIPS 2018).
- [ ] 실측 (cycle-10+ T4) — measured draft-target serving bench (vLLM/TGI speculative decode · Llama-3 8B target + 1B draft · ShareGPT · wall-clock tokens/s · vast.ai cost-bearing pod). Frontier OPEN ([[feedback_closure_is_physical_limit]]).
- [ ] N2 (informed-pack vs naive-sort) next.

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
