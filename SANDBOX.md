# SANDBOX — self-hosted measurement substrate (domain SSOT)

> Domain doc · dancinlab `domain-meta-domain` principle. Current-state
> spec only; dated history → [`SANDBOX.log.md`](SANDBOX.log.md).
>
> **Purpose:** "build a tiny experiment model, run experiments on it."
> A self-hosted OSS LLM + dispatch wrapper that is the **shared
> empirical-contact substrate for ALL hexa-codex domains** — every
> verb group (ECONOMICS · SAFETY · OPS · SUBSTRATE) runs its
> measurable claims here, bypassing `claude --bare -p` surface limits
> (cache_control · batch · stop_seq · max_tokens · logits/activations
> all BLOCKED there). We do NOT train a model — we self-host a small
> open-weights pick (Qwen2.5-0.5B today) and *measure on it*.

## North-star

The SANDBOX is the **single self-hosted measurement substrate** the
whole codex runs its experiments on. The external `claude --bare -p`
surface exposes only `--model` + `--system-prompt` + `--max-budget-usd`;
a self-hosted serving surface (llama.cpp / vLLM) gives us logits,
activations, KV cache, stop sequences, deterministic seeds, batch
dispatch, and unmetered manifest scale. That difference is not an
ECONOMICS convenience — it is the **only way** several domains can be
measured at all: SAFETY interpretability needs activations the API
never returns; OPS SLO checks need a serving process we control; the
F-CODEX empirical landings need scale and determinism the metered API
forecloses. SANDBOX is therefore the codex's `cx_empirical_contact`
gate made physical — one substrate, every domain's T4 claims.

## Sibling domains — what each runs on SANDBOX

Every verb group is a **consumer** of this one substrate; SANDBOX is
the place their otherwise-unmeasurable (T4 empirical) claims execute.

| sibling domain | falsifier class | what it runs on SANDBOX | why the API surface can't | status |
|:---------------|:----------------|:------------------------|:--------------------------|:-------|
| [`ECONOMICS.md`](ECONOMICS.md) | cost-curve fits | routing $/latency/token, KV-prefix, batching, F-CODEX-1/2 scaling fits | no cache/stop/max-tok/batch knobs | **proven** (cycles 1-6: early-stop −86%, max-tok cap −51%, KV-prefix −89.71%, logit signal) |
| [`SAFETY.md`](SAFETY.md) | interpretability probes — circuits, SAE | activation capture, attention/logit inspection, circuit-motif + sparse-autoencoder probes | API returns no activations/attention at all | candidate — SANDBOX is the *only* viable surface |
| [`OPS.md`](OPS.md) | SLO checks — deployment-tier recipes, tool-use | throughput/latency/batch SLO, serving-tier recipes, tool-use loops on a process we own | API hides the serving process + per-request scheduling | candidate |
| [`SUBSTRATE.md`](SUBSTRATE.md) | capability evals — multimodal fusion, RLHF | capability eval harness, RLHF reward probing, deterministic re-runs | metered + non-deterministic + no seed control | candidate |

lm_foundry stack ([`LEARNING_PROGRAMMING.md`](LEARNING_PROGRAMMING.md) ·
[`LEARNING_BIO.md`](LEARNING_BIO.md)) is the host platform the SANDBOX
serves models from; its trained artefacts (e.g. the Mk.I 94.29% code
model) are *candidate base models* for future stages, distinct from
today's OSS pick.

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
| ECONOMICS `cycle-3+` routing-savings | Stage 1-3 | external-API surface exhausted (cycle-2) |
| ECONOMICS v1.2.0 / v1.3.0 (F-CODEX-1/2 empirical) | Stage 4 | spec roadmap §A.4 |
| SAFETY interpretability probes (circuits · SAE) | Stage 1+ (activation capture) | the *only* surface that exposes activations |
| OPS SLO checks (throughput · latency · batch) | Stage 3 (server-mode) | needs a serving process we control |
| SUBSTRATE capability evals (multimodal · RLHF) | Stage 4 (scale ladder) | needs determinism + scale |
| `cx_empirical_contact` (every domain's T4 claims) | Stage 1+ | project.tape required |

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

- **Sibling verb-group domains (all consumers of this substrate):**
  [`ECONOMICS.md`](ECONOMICS.md) (proven) · [`SAFETY.md`](SAFETY.md) ·
  [`OPS.md`](OPS.md) · [`SUBSTRATE.md`](SUBSTRATE.md)
- **Host platform:** [`LEARNING_PROGRAMMING.md`](LEARNING_PROGRAMMING.md) ·
  [`LEARNING_BIO.md`](LEARNING_BIO.md) — lm_foundry stack the SANDBOX serves models from
- `.discoveries/sandbox.tape` — SANDBOX candidate ladder (Stage 0-4 + revivals)
- `.discoveries/economics-routing-savings.tape` — the ECONOMICS candidates SANDBOX revived
- `verify/numerics_economics_pareto_floor.hexa` (commit `5bbb9ad`) — analytic floor SANDBOX empirical results validate against
- `lm_foundry/tool/route_dispatch.hexa` — unified claude/llama_cpp dispatch wrapper (the substrate's entry point)
