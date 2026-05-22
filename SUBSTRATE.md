# SUBSTRATE — hexa-codex substrate verb group (domain SSOT)

> Domain doc · dancinlab `domain-meta-domain` principle. One of the
> **4 orthogonal groups** of the hexa-codex 17-verb AI knowledge
> substrate. Current-state spec only; dated history →
> [`SUBSTRATE.log.md`](SUBSTRATE.log.md).
>
> **Falsifier class:** capability evals — multimodal fusion, RLHF
> labelling, cognitive-architecture and causal-reasoning capability
> probes.

## North-star

The SUBSTRATE group is the **4-verb capability surface** of the codex:
the deeper model-substrate concerns — multimodal fusion, RLHF/DPO
labelling, cognitive architecture, and causal-chain reasoning — that
underpin what a model can *do*. Each verb is a closed-form capability
candidate + falsifier preregister. This group is the widest and lands
last on the release ladder (v2.0.0, aspirational).

## Verbs (4)

| Verb | Spec | Role |
|------|------|------|
| `multimodal` | [`multimodal/ai-multimodal.md`](multimodal/ai-multimodal.md) | multimodal fusion spec |
| `rlhf` | [`rlhf/youth-ai-labeling-rlhf-hub.md`](rlhf/youth-ai-labeling-rlhf-hub.md) | DPO / RLHF labelling hub |
| `cog_arch` | [`cog_arch/cognitive-architecture.md`](cog_arch/cognitive-architecture.md) | cognitive-architecture envelope |
| `causal` | [`causal/causal-chain.md`](causal/causal-chain.md) | causal-chain reasoning spec |

## Falsifiers

SUBSTRATE owns **none of F-CODEX-1..4** directly. Its falsifier class is
**per-verb capability evals** — each verb spec preregisters a capability
threshold rather than a scaling law or SLO.

The v2.0.0 substrate release is the empirical-landing window for
**F-CODEX-4** (`interpret_motifs = σ−φ = 10`, owned by
[`SAFETY.md`](SAFETY.md)) — interpretability of the full capability
substrate is the last falsifier to close.

## n=6 projection

This group is one of the **τ(6) = 4** quadrants of the codex taxonomy.
SUBSTRATE spans the **σ(6) = 12** capability-dimension surface — the
12-axis capability bin that `alignment` (SAFETY) later aggregates.

## State (v1.0.0 — RELEASED)

Spec-first: all 4 verbs ship a written capability candidate + falsifier
preregister. **0 verbs wired**, **0 eval pipelines**. No F-CODEX
arithmetic floor applies; per-verb capability falsifiers preregistered,
empirical evals PENDING.

## Roadmap — v2.0.0 (2027-Q2, ASPIRATIONAL · group focus = substrate)

- 17 verbs wired (full library) · 4 eval pipelines.
- **F-CODEX-4 empirical landing** — SAE motif-count parity (Anthropic
  dictionary-learning comparable).
- DoD (`.roadmap.hexa_codex` §0): substrate group multimodal + cog-arch
  + causal + RLHF integrated eval.

## Cross-refs

- `.roadmap.hexa_codex` §A.4 — falsifier preregister · §A.2 — release cadence
- `README.md` — Falsifier preregister · Release ladder
- `verify/falsifier_check.py` · `verify/n6_arithmetic.py`
- Sister groups: [`SAFETY.md`](SAFETY.md) · [`ECONOMICS.md`](ECONOMICS.md) · [`OPS.md`](OPS.md)
