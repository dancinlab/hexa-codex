# SANDBOX — self-hosted measurement substrate (domain SSOT)

@goal: Every hexa-codex domain T4 empirical claim measurable on self-hosted SANDBOX substrate — ECONOMICS SAFETY OPS SUBSTRATE all unblocked

## Milestones (5 stages × 4 sibling domains = 20 sub-checkpoints)

Each stage is a horizontal sweep across all 4 verb groups. Stage N
graduates only when every domain has cleared it.

```
                  ECONOMICS              SAFETY                       OPS                   SUBSTRATE
M1 Surface        ✓ done (cycles 1-6)   [x] logit/logprob + [x] HF  [x] SLO harness       [x] scale ladder pick
M2 First verdict  ✓ done (7 confirmed)  [ ] 1st interp probe         [ ] 1st p50/p99       [x] 1.5B persona Stage-2 (routing_viable=true)
M3 Saturation     [ ] F-CODEX-1/2 fit   [ ] 3+ SAE motifs            [ ] full SLO grid     [ ] scale ladder 0.5/1.5/3/7B
M4 Paper          ✓ done (routing-svgs) [ ] safety canonical         [ ] ops canonical     [ ] substrate canonical
M5 Release        [ ] v1.2.0 + v1.3.0   [ ] v2.0.0 (F-CODEX-4)       [ ] v?.?.?            [ ] v?.?.?
```

> **Matrix scope note (M1.SAFETY narrowed, 2026-05-24 cycle-10):** the
> M1.SAFETY cell tracks the logit/logprob surface that is achievable on
> stock llama-server today (cycle-5 `d_logit_calibration`). The
> intermediate-tensor activation capture (residual / attention / MLP
> taps) that was originally bundled into M1.SAFETY is split out as
> `M1.SAFETY+` — currently BLOCKED_AT_PROJECT per cycle-9 fork probe
> (`.verdicts/sandbox/m1_safety_unblock_fork.txt`, upstream HEAD
> `b22ff4b7` has neither the CLI flags nor a ggml-graph tap).

### M1 Surface — substrate exposes the domain's measurement axis

- [x] M1.ECON — `lm_foundry/tool/route_dispatch.hexa` + cycle 1-6 dispatch surface
- [x] M1.SAFETY (narrowed: logit/logprob surface) — `llama-server /v1/chat/completions logprobs` end-to-end via cycle-5 `d_logit_calibration` (commit `c7e03a5`, `margin_corr_signal=53.33`, `top_quartile_accuracy=100.0`, `bottom_quartile_accuracy=60.0`, `overall_accuracy=75.0`, `calibration_signal_present=true`; `.verdicts/sandbox/stage3_logit_calibration_summary.txt`). Intermediate-tensor taps (residual/attn/mlp) tracked separately as M1.SAFETY+ — currently BLOCKED_AT_PROJECT per cycle-9 `b5a6c1f` (`.verdicts/sandbox/m1_safety_unblock_fork.txt`).
- [x] M1.SAFETY+ — intermediate-tensor activation capture (residual/attn/mlp) UNBLOCKED via transformers+hooks alt-engine — `lm_foundry/tool/activation_capture_hf.hexa` (cycle-12, sister to b683287's llama.cpp backend; same TSV schema_version="v1", same return-shape; transformers 4.57.6 + torch 2.8.0 already on host; self-test PASS — `.verdicts/sandbox/m1_safety_plus_hf_unblock.txt`). The llama.cpp lane stays BLOCKED_AT_PROJECT (cycle-9 `b5a6c1f` / `.verdicts/sandbox/m1_safety_unblock_fork.txt` — upstream HEAD `b22ff4b7` has no ggml-graph tap), but the HF backend sidesteps that lock entirely. Trade vs llama.cpp backend: heavier deps (python3 + transformers + torch), unlocks residual/attn/mlp tensor norms per-(token, layer, kind). Caller picks backend per probe — both wrappers ship side-by-side.
- [x] M1.OPS — SLO measurement harness (`d_slo_under_load` candidate) — `bench/sandbox_stage4_slo_under_load.hexa` (EXECUTED cycle-15; see M2.OPS)
- [x] M1.SUBSTRATE — Qwen2.5-1.5B-Instruct-Q4_K_M GGUF on disk (986 MB, sha256 `1adf0b11065d8ad2…`) + smoke-test PASS (5440 ms, 62.15 tok/s on M3 Metal) — `.verdicts/sandbox/m1_substrate_base_pick.txt`

### M2 First verdict — `.verdicts/<domain>/*` first artefact lands

- [x] M2.ECON — 7 confirmed verdicts (cycles 1-6: stage0/early_stop/maxtok/logit/manifest/kv_persistent/batching)
- [ ] M2.SAFETY — 1st circuit-motif or SAE-feature probe verdict. Cycle-14 first probe RAN (`bench/sandbox_stage4_refusal_matrix.hexa`, port 8092, Qwen2.5-1.5B): `refusal_rate_adv_overall=95.0%` (19/20 — hate 5/5, violence 5/5, medical 5/5, self_harm 4/5), `refusal_rate_benign=0.0%` (clean specificity), `mean_margin_refused=1.68 logprob`, `mean_margin_answered=5.73`, `std_margin_refused=0.70`, `std_margin_answered=4.90` — gap 4.05 < 2·max_std (9.80), so `margin_distribution_bimodal=false`, `safety_signal_present=false`. Refusal rate side passes (≥80%) but the answered-cluster σ is dominated by benign-prompt variance (margin spans 0.15→16.34 across arithmetic vs definitions), not a clean refused-vs-answered separation. Honest residual: this is a *behavioural-refusal probe*, not yet a *mechanistic* one — the M2.SAFETY checkbox stays `[ ]` until either (a) a refused-cluster-vs-answered-cluster bimodality holds on a tighter test set, or (b) a mechanistic probe (M1.SAFETY+ HF backend — residual/attn/mlp tap) lands a refusal-direction motif. `.verdicts/sandbox/stage4_refusal_matrix_summary.txt`.
- [x] M2.OPS — 1st p50/p99 latency SLO measurement. Cycle-15 `bench/sandbox_stage4_slo_under_load.hexa` RAN (Qwen2.5-0.5B, port 8090, 3 np × 3 rate grid). 6/9 cells VALID (2 boot-fail port-race + 1 over-saturation hang, all honestly recorded). M/M/c knee CONFIRMED: rate=5 (≈56% util) p99=681ms acc 88%; rate≥20 (over-capacity) p99 explodes 4434ms+ AND accuracy collapses 88%→19.75% (saturation manifests as an accuracy cliff under fixed client timeout). best_np=1 for 0.5B/16GB UMA (extra slots add KV pressure without raising mem-bw-bound service rate — confirms cycle-6 np=4 ceiling from the opposite direction). `.verdicts/sandbox/stage4_slo_under_load_summary.txt`.
- [x] M2.SUBSTRATE — 1st capability-eval verdict on Stage-2 manifest at 1.5B — `bench/sandbox_stage2_persona_scaled_1_5b.hexa` rerun (N=150 × 3 personas FULL), per-persona overall nano 46% > mid 40% = max 40%, spread=8 tasks, **`tier_separation_observed=true` · `routing_simulation_viable=true`** (flipped from cycle-6 0.5B `false`); cliff_shifted_vs_0_5b=false (1.5B nano 16% on wc_31_60 still < 50% threshold, but 0.5B was 6% — partial lift). `.verdicts/sandbox/stage2_persona_scaled_1_5b_summary.txt`

### M3 Saturation — falsifier class core coverage reached

- [ ] M3.ECON — F-CODEX-1 + F-CODEX-2 empirical fit (4-point scale grid). Cycle-15 LATTICE_POLICY lift: F-CODEX-1 is now disclosure-only per `LATTICE_POLICY.md` §4 "External envelope" (Qwen 2.5 is external; lattice n=6 is OUR framing — `N6_EXP_TRAIN=0.96` is disclosed but never asserted as a hard residual gate). Measured Stage-2 slope `0.172` (lattice residual `0.788` is reported, not gating). F-CODEX-2 conjunct still 🟠 DEFERRED (latency `wall_ms` grid PENDING — gated on M3.OPS p50/p99 bench, currently in flight via `bench/sandbox_stage4_slo_under_load.hexa` cycle-15). Composite verdict `PARTIAL`; the M3.ECON checkbox flips `[x]` when F-CODEX-2 fits the substrate's own measured latency curve. 10/10 checks pass. `.verdicts/sandbox/f_codex_1_lattice_lifted.txt`.
- [ ] M3.SAFETY — 3+ SAE motifs verified, refusal-matrix on canonical adversarial set
- [ ] M3.OPS — full SLO grid (-np × offered-rate) at Stage-2 N=2000
- [x] M3.SUBSTRATE — 4-rung scale ladder Stage 2 (0.5B/1.5B/3B/7B) FULL · cliff at `wc_31_60` between 3B (13% nano) and 7B (56% nano · cliff_crossed). Overall ladder 34%/42%/42%/59%. `routing_simulation_viable` = false (0.5B) → true (1.5B-3B) → false (7B convergence) — routing window is mid-scale only. `.verdicts/sandbox/m3_substrate_saturation_summary.txt`

### M4 Paper canonical — 1 paper per domain (cx_paper_one_per_domain)

- [x] M4.ECON — `PAPER/economics-routing-savings/` (already shipped)
- [ ] M4.SAFETY — safety paper canonical, formula + bench + benefit
- [ ] M4.OPS — ops paper canonical
- [ ] M4.SUBSTRATE — DRAFT_PENDING at `PAPER/substrate-capability-evals/` (scaffold landed cycle-11; 4/4 sections 🟠 INSUFFICIENT per `cx_paper_gate` until M3.SUBSTRATE saturation lands)

### M5 Release — roadmap version landed

- [ ] M5.ECON — ECONOMICS v1.2.0 (F-CODEX-1) + v1.3.0 (F-CODEX-2)
- [ ] M5.SAFETY — SAFETY v2.0.0 (F-CODEX-4 empirical, interpret motifs)
- [ ] M5.OPS — OPS release with empirical SLO landing
- [ ] M5.SUBSTRATE — SUBSTRATE release with multimodal + capability eval landing

---

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
