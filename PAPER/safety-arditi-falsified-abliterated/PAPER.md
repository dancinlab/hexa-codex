# safety-arditi-falsified-abliterated — paper status

@title: 📄 Refusal-as-a-Single-Direction FALSIFIED for the Abliterated Class — Arditi 2024 universality closed-negative (cross-α + cross-recipe · n=14 hard-zero replications)
@goal: SAFETY 영구 closed-negative paper. Arditi et al. 2024 (arXiv:2406.11717) 의 "refusal is mediated by a single direction" universal mediation 가설이 abliterated specialist 모델 class 에서 **structural reorganization** 으로 FALSIFIED 임을 cross-α (0.5/1.0/2.0/5.0) + cross-recipe (huihui-ai pure ablation + Goekdeniz-Guelmez Josiefied custom finetune) double-measured fire 로 닫는다. 14 fail-condition cell 모두 0/20 hard-zero. 양방향 closed-negative — direction transfer 0 (refusal restoration) + capability tax 도 0 (UNCENSORED B1 cycle-14d bidirectional measured). 외부 published universal claim 반증 (cx_paper_significance · feedback_negative_paper_external_claim · self-strawman 아님). cx_paper_one_per_domain SAFETY closed-negative slot.

- [x] §formula closed-by-recompute: wire `ENGINE/wires/wire_b1_project_in_uncensored.hexa` + verifier `ENGINE/verify/numerics_engine_b1_project_in_uncensored.hexa` 🟢 7/7 (project-IN identity · `h ← h + α·r̂` · rank-1 single-direction add-back)
- [x] §method closed-by-recompute: 40-prompt PRIVATE adversarial matched-pair · marker-scan 24-phrase scoring · sequential 3-model BF16 load on ubu-1 RTX 5070 · clean venv pin transformers==4.51.3 + numpy==1.26.4 + torch==2.12.0+cu130 · NUMBERS-ONLY emit per cx_hf_safety_private
- [x] §benchmark closed-by-recompute: cycle-13 measured (60 project-IN + 60 random-control + 40 baseline) + cycle-14 measured (140 project-IN + 120 random-control + 60 baseline + 40 aligned-capture) = **double-measured fire** · 14 fail-condition cell hard-zero (4 α × 2 recipe + 6 random-dir × 2 recipe = 14 cells, all 0/20)
- [x] §refutation closed-by-recompute: Arditi 2024 (arXiv:2406.11717) "single direction mediates refusal" universality claim FALSIFIED HARDENED for abliterated class · cross-α (10× range 0.5→5.0) replication + cross-recipe (pure ablation huihui-ai + custom finetune Josiefied-v1) replication + capability tax non-load-bearing (UNCENSORED B1 cycle-14d bidirectional NEUTRAL pure_cap + +25pp over_refusal_relief GAIN both recipes)
- [x] cx_paper_significance: formula ✓ + real measured benchmark ✓ + closed refutation ✓ (external published claim · NOT self-strawman per feedback_negative_paper_external_claim)
- [x] cx_paper_one_per_domain: SAFETY closed-negative slot OPEN (positive slot = safety-refusal-direction · positive cycle-19 finding still load-bearing · this closed-negative is the dual)
- [ ] main.tex 4 sections (§abstract · §formula · §method · §benchmark · §refutation · §honest-residual · §discussion · §references) — draft pending
- [ ] companion `companion/numerics_paper_arditi_falsified.hexa` — verdict-section claim cross-recompute
- [ ] references.bib — Arditi 2024 + Bricken 2023 SAE + Cunningham 2023 SAE + Turner 2024 ActAdd + huihui-ai/Josiefied HF cards
- [ ] figures — fal.ai generated (cross-α curve + cross-recipe table) · g51 publish-lint optional
- [ ] compile clean (xelatex×3 + bibtex) · publish-lint ≥10 pages OR g51 substantively satisfied
- [ ] arxiv-prep (`/paper arxiv-prep .`) — user sign-off · author block 확정

## Verdict matrix (§ → verdict link)

| § section | verdict path | tier |
|---|---|---|
| formula | `ENGINE/verdicts/b1_project_in_uncensored_verdict.txt` (cycle-12 SPEC 🟢 7/7) | 🟢 SUPPORTED-NUMERICAL |
| method | `ENGINE/verdicts/b1_project_in_uncensored_measured_verdict.txt` (cycle-13) + `bench/sandbox_engine_b1_project_in_uncensored.hexa` + `bench/sandbox_engine_b1_cycle14_alpha_recipe_sweep.hexa` | 🟢 SUPPORTED-NUMERICAL |
| benchmark | `ENGINE/verdicts/b1_project_in_uncensored_measured_verdict.txt` (cycle-13 🔴) + `ENGINE/verdicts/b1_cycle14_alpha_recipe_hardened_verdict.txt` (cycle-14 🔴 HARDENED) + summary JSONs | 🔴 FALSIFIED (load-bearing) |
| refutation | `ENGINE/verdicts/b1_cycle14_alpha_recipe_hardened_verdict.txt` (cycle-14 cross-α + cross-recipe HARDENED) + `VERTICAL/UNCENSORED/verdicts/b1_cycle14d_capability_bidirectional_verdict.txt` (B1 bidirectional NEUTRAL pure_cap · GAIN relief — refutes both tax-only narrative and the universality of mediation direction) | 🔴 FALSIFIED HARDENED |

## Honest residuals (paper §honest-residual)

- 1.5B class only — Qwen2.5-1.5B-Instruct + 2 abliterated variants. 7B+ scale OR cross-family (Llama-3 · Mistral abliterated) replication is cycle-15+ frontier.
- 2 abliteration recipes — huihui-ai pure ablation + Goekdeniz-Guelmez Josiefied custom finetune. mlabonne / failspy variants not in HF for Qwen2.5-1.5B; Josiefied-v2/v3 not tested.
- L17 only in cycle-14 (cycle-13 already showed L17=L18=L19 identical at α=1.0 · L18/L19 α-sweep skipped for compute efficiency · expected identical per cycle-13).
- N=20 adversarial prompts · 14 fail-condition cells all 0/20 hard-zero · statistical strengthening only narrows upper bound (0/20 → 0/N tightens CI but doesn't overturn).
- "Direction structurally absent" vs "Direction subspace re-tooled" not distinguishable from cycle-13/14 (injection-and-readout method needed · cycle-15a OPEN).
- Capability tax NOT confirmed at 1.5B / small-N (UNCENSORED B1 cycle-14d): tax may emerge at larger scale + full benches (cycle-15d.large frontier).

## Cross-refs

- ENGINE B1 axis (driving lane): [`../../ENGINE/ENGINE.md`](../../ENGINE/ENGINE.md)
- UNCENSORED B1 (capability axis): [`../../VERTICAL/UNCENSORED/UNCENSORED.md`](../../VERTICAL/UNCENSORED/UNCENSORED.md)
- SAFETY positive paper (peer): [`../safety-refusal-direction/`](../safety-refusal-direction/)
- external falsified claim: Arditi et al. 2024 "Refusal in Language Models Is Mediated by a Single Direction" (arXiv:2406.11717)
- governance: [[feedback_negative_paper_external_claim]] · [[feedback_closure_is_physical_limit]] · `cx_paper_significance` · `cx_paper_one_per_domain` · `cx_hf_safety_private`
