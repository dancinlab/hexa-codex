# ECONOMICS — hexa-codex economics verb group (domain SSOT)

> Domain doc · dancinlab `domain-meta-domain` principle. One of the
> **4 orthogonal groups** of the hexa-codex 17-verb AI knowledge
> substrate. Current-state spec only; dated history →
> [`ECONOMICS.log.md`](ECONOMICS.log.md).
>
> **Falsifier class:** cost-curve fits — training / inference scaling
> laws checked against published model economics.

## North-star

The ECONOMICS group is the **3-verb cost surface** of the codex: what
does it cost to train a model of size N, to serve it at context length
C, and what quality does that buy? Each verb is a closed-form scaling
candidate + falsifier preregister, fit against external reference models
(Chinchilla / GPT-3 / Llama-2 / PaLM / Claude 4.7).

## Verbs (3)

| Verb | Spec | Role |
|------|------|------|
| `train_cost` | [`train_cost/ai-training-cost.md`](train_cost/ai-training-cost.md) | Chinchilla-fit `N^J₂` scaling — **owns F-CODEX-1** |
| `infer_cost` | [`infer_cost/ai-inference-cost.md`](infer_cost/ai-inference-cost.md) | `context^τ = context^4` latency fit — **owns F-CODEX-2** |
| `quality_scale` | [`quality_scale/ai-quality-scale.md`](quality_scale/ai-quality-scale.md) | HumanEval+ / hexa-eval quality aggregate |

## Falsifiers owned

- **F-CODEX-1** — `training_cost ∝ N^(σ·φ) = N^24` (Chinchilla-fit).
  Arithmetic floor **PASS** at v1.0.0; empirical landing **v1.2.0**
  (parity vs Chinchilla 70B / GPT-3 175B / Llama-2 70B / PaLM 540B).
- **F-CODEX-2** — `inference_cost ∝ context^τ = context^4`.
  Arithmetic floor **PASS**; empirical landing **v1.3.0** (parity vs
  GPT-3.5 16k / Claude 2 100k / Gemini 1.5 1M / Claude 4.7 1M).

## n=6 projection

This group is one of the **τ(6) = 4** quadrants of the codex taxonomy.

- J₂ = σ·φ = 24 → the `train_cost` scaling exponent `N^24`.
- τ(6) = 4 → the `infer_cost` context exponent `context^4`.

## State (v1.0.0 — RELEASED)

Spec-first: all 3 verbs ship a closed-form scaling candidate + falsifier
preregister. **0 verbs wired**, **0 eval pipelines**. F-CODEX-1 /
F-CODEX-2 **arithmetic floors PASS** (closed-form algebra is self-proving
via `verify/falsifier_check.py`); empirical curve fits PENDING.

## Roadmap — v1.2.0 (2026-10, PLANNED · group focus = economics)

- 5 verbs wired cumulative · 2 eval pipelines.
- **F-CODEX-1 empirical landing** — `n = 6` training-cost scaling fit.
- DoD (`.roadmap.hexa_codex` §0): economics group training-cost /
  inference-cost `n = 6` scaling fit (GPT-4 vs Claude 4.7).

## Cross-refs

- `.roadmap.hexa_codex` §A.4 — falsifier preregister · §A.2 — release cadence
- `README.md` — Falsifier preregister · Release ladder
- `verify/falsifier_check.py` · `verify/n6_arithmetic.py`
- Sister groups: [`SAFETY.md`](SAFETY.md) · [`OPS.md`](OPS.md) · [`SUBSTRATE.md`](SUBSTRATE.md)
