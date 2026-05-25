# hexa-codex v1.4.0 — Release Notes

**Release date**: 2026-05-25 _(proposed — confirm the version before `git tag`)_
**Scope**: SANDBOX domain **M5 consolidation** — all four verb groups
(ECONOMICS · SAFETY · OPS · SUBSTRATE) land their canonical measurement
paper + closed-form verdict on the self-hosted SANDBOX substrate.
**Prior tag**: v0.5.0
**License**: MIT

> Cut by the maintainer (release tag is user-gated). Draft notes below;
> the exact `git tag` / `gh release` commands are at the end.

---

## Highlights

Every SANDBOX domain group now has a recompute-verified canonical paper
and an empirical M5 deliverable, all measured at **$0 on the self-hosted
substrate** (mac-mini-m3 Metal/UMA for serving; ubu-1 RTX 5070 for the HF
activation path). Each numeric claim links a 🟢/🔴 verdict under
`.verdicts/sandbox/`, recomputed by a hexa-native verifier (no LLM
self-judge).

| Group | Canonical paper | M5 empirical deliverable |
|---|---|---|
| ECONOMICS | `economics-routing-savings` (6p) | measured 2-component latency cost model (🟢) |
| SAFETY | `safety-refusal-direction` (11p) | causal refusal-direction ablation (🟢) + SAE decomposition (🔴 honest-negative) |
| OPS | `ops-slo-mmc-surface` (10p) | M/M/c SLO surface, 18-cell grid (🟢) |
| SUBSTRATE | `substrate-capability-evals` (11p) | 3-rung multimodal capability fit (🟢, non-monotone) |

## Per-group deliverables

### ECONOMICS
- **Paper** `PAPER/economics-routing-savings/` — closed-form routing-cost savings.
- **Measured latency cost model** `verify/numerics_economics_measured_cost_model.hexa`
  (8/8 🟢): `wall_ms = 370.08 + 0.168306 · input_tokens` (R²=0.997) — a
  2-component law (fixed ~64-token decode floor + linear prefill), the
  substrate's real latency curve. Verdict `.verdicts/sandbox/m3_econ_measured_cost_model.txt`.
- **⚠ Honesty note**: the n=6 lattice exponents (τ=4, σφ≈0.96) are
  **descriptive framing, NOT substrate-empirical laws**. τ=4 does not fit
  (measured τ̂≈0.52; internal verdict `m3_econ_fcodex2_latency_fit.txt`). A
  paper that "falsified" τ=4 was **REVOKED** (cx_paper_violation): τ=4 was a
  self-generated pre-LATTICE_POLICY number, so refuting it is a strawman,
  not a result. Per `LATTICE_POLICY.md`, the lattice is a tool, not a constraint.

### SAFETY
- **Paper** `PAPER/safety-refusal-direction/` (11p, 1 fal.ai figure) — a
  mechanistic refusal direction in Qwen2.5-1.5B-Instruct.
- **Correlational**: difference-of-means linear direction — AUROC 0.98,
  leave-one-out held-out 0.825, permutation p=0.005.
- **Causal** (`m5_safety_causal_ablation.txt` 🟢): projecting the L19
  refusal direction out of the residual stream collapses adversarial
  refusal 0.95→0.00; an equal-norm random direction holds (0.87) —
  interventional single-direction mediation (Arditi et al 2024, 2406.11717).
- **SAE** (`m5_safety_sae_decomposition.txt` 🔴 honest-negative): the
  refusal mediator is a **dense** L19 direction, NOT monosemantic at this
  model/data/compute scale (best feature cos 0.085) — a closed negative.

### OPS
- **Paper** `PAPER/ops-slo-mmc-surface/` (10p, 1 fal.ai figure) — an
  **M/M/c (Erlang-C) SLO surface** for self-hosted LLM serving: the
  throughput ceiling `c·μ`, the knee-shift-right-with-`c` law, and the
  Erlang-C pole `W_q → ∞` as ρ→1. Backed by an 18-cell measured grid
  (`m3_ops_full_slo_grid`) + closed-form recompute (`numerics_ops_mmc_knee.hexa` 5/5).

### SUBSTRATE
- **Paper** `PAPER/substrate-capability-evals/` (11p, 1 fal.ai figure) —
  text capability-eval logistic fit in log2(params).
- **Multimodal** (`m5_substrate_multimodal_fit.txt` 🟢): 3 vision-language
  rungs served locally (SmolVLM-500M → SmolVLM2-2.2B → Qwen2.5-VL-3B). The
  capability curve is **NON-monotone** (81→94→81%) — a single logistic is
  the wrong family. It splits by axis: perception (OCR/spatial/shape) is
  monotone-saturating, while counting (5–9 dense objects) does not track
  params (a VLM subitizing limit). Stock `llama.cpp` serves vision via
  `--mmproj` / `llama-mtmd-cli`.

## Also in this release
- **Negative-results publishing** — the paper rules were widened to accept
  closed-negative (🔴 FALSIFIED) findings: `cx_paper_gate` /
  `cx_paper_significance` / `cx_paper_format` / `cx_paper_sections`, and
  `cx_paper_one_per_domain` → max 1 positive + 1 closed-negative per group.
  🟠 INSUFFICIENT/DEFERRED is still excluded. (The first closed-negative
  paper attempt was revoked as a self-strawman — see ECONOMICS note.)
- **LAB reorg** — the BITNET and RWKV evaluation domains are now housed
  under `LAB/lab-03-bitnet/` and `LAB/lab-04-rwkv/`; **LAB-01
  interrupt-no-loss** experiment landed (append-only log loss 0/12,
  sequential + concurrent O_APPEND; single-slot control 11/12).

## Honesty caveats
- Single host / single site; small-n where noted (SAFETY n=40, multimodal
  16-item manifest, ECONOMICS 4 context rungs).
- The M5 milestone checkboxes in `SANDBOX.md` remain `[ ]` until this tag
  is cut (the "release" step is user-gated by design).

---

## Cutting the release (maintainer, user-gated)

```sh
git tag -a v1.4.0 -m "SANDBOX M5 consolidation — 4-group canonical papers + verdicts"
git push origin v1.4.0
gh release create v1.4.0 \
  --title "hexa-codex v1.4.0 — SANDBOX M5" \
  --notes-file RELEASE_NOTES_v1.4.0.md
```

After tagging, flip the four `M5.*` checkboxes in `SANDBOX.md` to `[x]`
(SANDBOX → 21/21, domain complete).
