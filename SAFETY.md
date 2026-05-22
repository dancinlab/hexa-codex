# SAFETY — hexa-codex safety verb group (domain SSOT)

> Domain doc · dancinlab `domain-meta-domain` principle (per-topic roadmap
> as root `UPPERCASE.md`). One of the **4 orthogonal groups** of the
> hexa-codex 17-verb AI knowledge substrate. Current-state spec only;
> dated history → [`SAFETY.log.md`](SAFETY.log.md).
>
> **Falsifier class:** interpretability probes — circuit motifs, SAE
> features, alignment-axis aggregation, refusal matrices.

## North-star

The SAFETY group is the **6-verb safety surface** of the codex: can a
deployed model be shown — by a preregistered, falsifiable probe — to be
aligned, interpretable, refusal-correct, and welfare-audited? Every verb
is a closed-form candidate spec + falsifier preregister; the codex is
read, not run. Empirical landing is release-laddered (safety goes first,
v1.1.0).

## Verbs (6)

| Verb | Spec | Role |
|------|------|------|
| `alignment` | [`alignment/ai-alignment.md`](alignment/ai-alignment.md) | HELM-12-axis alignment-score aggregator — **owns F-CODEX-3** |
| `interpret` | [`interpret/ai-interpretability.md`](interpret/ai-interpretability.md) | SAE motif count = σ−φ = 10 — **owns F-CODEX-4** |
| `safety` | [`safety/ai-safety.md`](safety/ai-safety.md) | refusal-matrix + capability-gate spec |
| `welfare` | [`welfare/ai-welfare.md`](welfare/ai-welfare.md) | model-welfare probe protocol |
| `adversarial` | [`adversarial/ai-adversarial.md`](adversarial/ai-adversarial.md) | red-team failure-mode taxonomy |
| `consciousness` | [`consciousness/ai-consciousness.md`](consciousness/ai-consciousness.md) | IIT × GWT probe (BT-19 falsifier-in-action) |

## Falsifiers owned

- **F-CODEX-3** — `alignment_score = mean over 12 axes` (HELM-comparable).
  Arithmetic floor **PASS** at v1.0.0; empirical landing **v1.1.0**.
- **F-CODEX-4** — `interpret_motifs = σ(6) − φ(6) = 10` (Anthropic
  dictionary-learning comparable). Arithmetic floor **PASS**; empirical
  landing **v2.0.0**.

## n=6 projection

This group is one of the **τ(6) = 4** quadrants of the codex taxonomy.

- σ(6) = 12 → the 12 HELM capability axes `alignment` aggregates.
- φ(6) = 2 → the helpful / harmless verdict bit `safety` gates on.
- σ − φ = 10 → the interpretability circuit-motif count (`interpret`).

## State (v1.0.0 — RELEASED)

Spec-first: all 6 verbs ship a written candidate + falsifier preregister.
**0 verbs wired** (write-side sandbox), **0 eval pipelines**. F-CODEX-3 /
F-CODEX-4 **arithmetic floors PASS** (`verify/falsifier_check.py`);
empirical floors PENDING.

## Roadmap — v1.1.0 (2026-08, TARGET · group focus = safety)

- 2 verbs wired · 1 eval pipeline (alignment + interpretability).
- **F-CODEX-3 empirical landing** — HELM-Core composite parity.
- DoD (`.roadmap.hexa_codex` §0): safety group alignment +
  interpretability eval pipeline `.hexa`.

## Cross-refs

- `.roadmap.hexa_codex` §A.4 — falsifier preregister · §A.2 — release cadence
- `README.md` — Falsifier preregister · Release ladder
- `verify/falsifier_check.py` · `verify/n6_arithmetic.py`
- Sister groups: [`ECONOMICS.md`](ECONOMICS.md) · [`OPS.md`](OPS.md) · [`SUBSTRATE.md`](SUBSTRATE.md)
