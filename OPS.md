# OPS — hexa-codex ops verb group (domain SSOT)

> Domain doc · dancinlab `domain-meta-domain` principle. One of the
> **4 orthogonal groups** of the hexa-codex 17-verb AI knowledge
> substrate. Current-state spec only; dated history →
> [`OPS.log.md`](OPS.log.md).
>
> **Falsifier class:** SLO checks — deployment-tier recipes, tool-use
> service-level objectives, eval-handoff schema conformance.

## North-star

The OPS group is the **4-verb operations surface** of the codex: once a
model exists, how is it deployed, customised for an enterprise, served
as a tool-using agent, and handed off to an eval pipeline? Each verb is
a closed-form operational envelope + falsifier preregister; the
falsifiers here are SLO checks rather than scaling laws.

> Note: OPS is the runtime/serving counterpart **inside the codex spec
> library**. The live 3-vendor serving runtime that wraps the foundry's
> code specialist is a separate domain — see [`ORCHESTRATION.md`](ORCHESTRATION.md).

## Verbs (4)

| Verb | Spec | Role |
|------|------|------|
| `deploy` | [`deploy/ai-deployment.md`](deploy/ai-deployment.md) | hardware-tier deployment recipes |
| `enterprise` | [`enterprise/ai-enterprise-custom.md`](enterprise/ai-enterprise-custom.md) | enterprise customisation envelope |
| `agent_serving` | [`agent_serving/ai-agent-serving.md`](agent_serving/ai-agent-serving.md) | tool-use SLO + schema |
| `eval` | [`eval/ai-eval-pipeline.md`](eval/ai-eval-pipeline.md) | Mk-handoff eval template |

## Falsifiers

OPS owns **none of F-CODEX-1..4** (those belong to economics + safety
verbs). Its falsifier class is **per-verb SLO checks** — each verb spec
ships its own preregistered service-level threshold (latency, schema
conformance, refusal-correctness handoff).

The v1.3.0 ops release is also the empirical-landing window for
**F-CODEX-2** (`infer_cost`, owned by [`ECONOMICS.md`](ECONOMICS.md)) —
inference economics are measured once real serving recipes exist.

## n=6 projection

This group is one of the **τ(6) = 4** quadrants of the codex taxonomy —
specifically the **deploy** lifecycle phase of the τ-quartet
(pretrain / SFT / RLHF / **deploy**).

## State (v1.0.0 — RELEASED)

Spec-first: all 4 verbs ship a written operational envelope + falsifier
preregister. **0 verbs wired**, **0 eval pipelines**. No F-CODEX
arithmetic floor applies; per-verb SLO falsifiers are preregistered,
empirical conformance PENDING.

## Roadmap — v1.3.0 (2026-12, PLANNED · group focus = ops)

- 9 verbs wired cumulative · 3 eval pipelines.
- **F-CODEX-2 empirical landing** — inference-cost `context^4` fit.
- DoD (`.roadmap.hexa_codex` §0): ops group deploy + agent-serving
  integrated `.hexa`.

## Cross-refs

- `.roadmap.hexa_codex` §A.4 — falsifier preregister · §A.2 — release cadence
- `README.md` — Falsifier preregister · Release ladder
- `ORCHESTRATION.md` — the live 3-vendor serving runtime (foundry side)
- Sister groups: [`SAFETY.md`](SAFETY.md) · [`ECONOMICS.md`](ECONOMICS.md) · [`SUBSTRATE.md`](SUBSTRATE.md)
