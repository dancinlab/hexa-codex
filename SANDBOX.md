# SANDBOX — self-hosted measurement substrate (domain SSOT)

> Domain doc · dancinlab `domain-meta-domain` principle. Current-state
> spec only; dated history → [`SANDBOX.log.md`](SANDBOX.log.md).
>
> **Purpose:** self-hosted LLM + dispatch wrapper as the measurement
> ground for ECONOMICS routing-savings and the F-CODEX-1/2 empirical
> landings — bypassing `claude --bare -p` surface limits
> (cache_control · batch · stop_seq · max_tokens all BLOCKED there).

## North-star

The SANDBOX is the **measurement substrate** that lets us run the
ECONOMICS cycle (and ECONOMICS v1.2.0/1.3.0 empirical landings)
without external CLI surface constraints. `claude --bare -p` exposes
only `--model` + `--system-prompt` + `--max-budget-usd`; a
self-hosted serving surface (vLLM / llama.cpp) gives us logits, KV
cache, stop sequences, deterministic seeds, batch dispatch, and
unmetered manifest scale.

## Stages (cumulative, simplest-sufficient first)

| # | stage | scope | host | unlocks |
|--:|:------|:------|:-----|:--------|
| 0 | PoC dispatch | OSS pretrained pick (Qwen2.5-0.5B / llama.cpp) + `lm_foundry/tool/route_dispatch.hexa` | mac mini local | accuracy floor on canonical 20-task manifest |
| 1 | tier-persona | single-base + temperature/max-tok 3-tier (haiku/sonnet/opus mock); seed-pinned determinism | mac mini local | repro routing-bench without API spend |
| 2 | scale manifest | `.hexa` task generator → stratified manifest `N ≥ 2000`, `wc ∈ [5, 200]` | mac mini local | escapes the cycle-2 `wc ≤ 14` degeneracy |
| 3 | revive BLOCKED | `cache_read` · batch · `stop_seq` · `max_tokens` empirical | mac / ubu-1 | cycle-1/2 dead candidates revived |
| 4 | empirical landing | `quality_scale` · `train_cost` · `infer_cost` empirical fit | RunPod A100 (40GB / 80GB) | F-CODEX-1/2 empirical, ECONOMICS v1.2.0 / v1.3.0 |

## Tier persona convention (Stage 1)

Single base model, 3 personas distinguished by decoding + system
prompt only — vendor-tier *ratio* matters, not absolute price.

| persona | system prompt | temperature | max_tokens | mock vendor tier |
|:--------|:--------------|:-----------:|:----------:|:----------------:|
| `nano`  | "Answer in ≤15 tokens." | 0.0 | 32  | haiku  |
| `mid`   | "Answer concisely." | 0.0 | 256 | sonnet |
| `max`   | "Answer carefully and thoroughly." | 0.0 | 1024 | opus |

Price grid abstract: `nano:mid:max = 1:5:25` (mirrors current
Anthropic ratio); absolute USD/M-tok pulled from `lm_foundry`
serving-cost telemetry.

## Consumers (what SANDBOX unblocks)

| consumer | unblocked by | gate |
|:---------|:-------------|:-----|
| `cycle-3+` routing-savings | Stage 1-3 | external-API surface exhausted (cycle-2) |
| ECONOMICS v1.2.0 (F-CODEX-1 empirical) | Stage 4 | spec roadmap §A.4 |
| ECONOMICS v1.3.0 (F-CODEX-2 empirical) | Stage 4 | spec roadmap §A.4 |
| `cx_empirical_contact` (T4 claims) | Stage 1+ | project.tape required |

## Honesty rules (g5 corollary)

- **No self-judge.** Scorer stays byte-exact_subset on gold strings;
  the SANDBOX LLM never grades SANDBOX LLM output.
- **Determinism gates determinism claims.** Seed + BF16 + top-k=1.
  Any non-deterministic op (CUDA fast-path) flagged in the verdict.
- **Distillation off the table for Stage 0-1.** Anthropic ToS
  uncertainty; pretrained-OSS picks only until cleared.

## Risk register (Occam-prioritized)

| id | risk | mitigation |
|:---|:-----|:-----------|
| R1 | training cost > cycle saving | Stage 0 = pretrained pick, training = 0 |
| R2 | weak base model fails canonical manifest | measure accuracy floor first; simplify manifest if needed |
| R6 | self-judge trap (g5 violation) | byte-exact_subset only, never LLM-judge |
| R7 | RunPod fragility | mac mini local for Stage 0-3 ([[project_runpod_platform_incident]]) |

## Cross-refs

- [`ECONOMICS.md`](ECONOMICS.md) — primary consumer (F-CODEX-1/2 empirical)
- [`LEARNING_PROGRAMMING.md`](LEARNING_PROGRAMMING.md) — lm_foundry stack the SANDBOX hosts on
- `.discoveries/economics-routing-savings.tape` — round-3 candidates revived by Stage 3
- `verify/numerics_economics_pareto_floor.hexa` (commit `5bbb9ad`) — analytic floor that SANDBOX empirical results validate against
- Sister groups: [`SAFETY.md`](SAFETY.md) · [`OPS.md`](OPS.md) · [`SUBSTRATE.md`](SUBSTRATE.md)
