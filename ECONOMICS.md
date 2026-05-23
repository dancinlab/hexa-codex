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
candidate fit against external reference models (Chinchilla / GPT-3 /
Llama-2 / PaLM / Claude 4.7); `train_cost` and `infer_cost` additionally
preregister a falsifier (F-CODEX-1 / F-CODEX-2).

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
- φ(6)/σ(6) = 2/12 = 1/6 → the `quality_scale` loss-fit exponent
  `α = β = 1/6` (Chinchilla `loss = E + A·N^-α + B·D^-β`).

## State (v1.0.0 — RELEASED)

Spec-first: all 3 verbs ship a closed-form scaling candidate. **0 verbs
wired**, **0 eval pipelines** — production wiring is v1.2.0+ roadmap.

Verification surface (recipe §3 ladder — see `docs/closure_status.md`):

- `train_cost` (F-CODEX-1) / `infer_cost` (F-CODEX-2) — T1 algebraic +
  T2 numerical/solver + T3 published-ref parity all PASS; the closed-form
  arithmetic floor is self-proving via `verify/falsifier_check.hexa`.
  Empirical curve fits PENDING (F-CODEX-1 → v1.2.0, F-CODEX-2 → v1.3.0).
- `quality_scale` — reached recipe §3 closure on 2026-05-23, the first
  non-falsifier ECONOMICS verb to do so: T1 `calc_quality_scale.hexa`,
  T2 `numerics_quality_scale{,_solver}.hexa`, T3
  `numerics_quality_scale_parity.hexa` (8 + 10 + 10 + 10 checks).
- ECONOMICS 3-pillar cross-cutter
  `verify/numerics_economics_cross_pillar.hexa` (10 checks) ties the
  three verbs to one n=6 lattice: lattice closure σ·φ = n·τ = J₂,
  exponent recovery per verb (`N6_EXP·(J₂+1)=J₂` / `τ·n=J₂` /
  `α·σ=φ`), triad ordering 0 < α (1/6) < N6_EXP (24/25) < 1 < τ (4),
  3-pillar composite at the Chinchilla 70B / 1.4T / 8k anchor, and the
  quality↔infer orthogonality (quality_scale free of ctx, infer_cost
  free of (N,D)).
- ECONOMICS scaling-law sweep
  `verify/numerics_economics_scaling_laws.hexa` (10 checks) verifies
  the full closed-form ratio surface: q-side halving / 4× in N and D,
  train doubling in N and D, train ND quadrupling, infer ctx doubling
  and 4×, and the cost-vs-quality competition ratio
  `N6_EXP / α = 144/25 = 5.76` (per log doubling, training cost rises
  ~5.76× as fast as the quality reducible-loss term shrinks).

## Roadmap — v1.2.0 (2026-10, PLANNED · group focus = economics)

- 5 verbs wired cumulative · 2 eval pipelines.
- **F-CODEX-1 empirical landing** — `n = 6` training-cost scaling fit.
- DoD (`.roadmap.hexa_codex` §0): economics group training-cost /
  inference-cost `n = 6` scaling fit (GPT-4 vs Claude 4.7).

## Cross-refs

- `.roadmap.hexa_codex` §A.4 — falsifier preregister · §A.2 — release cadence
- `README.md` — Falsifier preregister · Release ladder
- `verify/falsifier_check.hexa` · `verify/lattice_check.hexa` · `docs/closure_status.md` — runnable verify surface
- Sister groups: [`SAFETY.md`](SAFETY.md) · [`OPS.md`](OPS.md) · [`SUBSTRATE.md`](SUBSTRATE.md)
