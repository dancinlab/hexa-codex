# SANDBOX.log.md — measurement substrate history

> History sibling of [`SANDBOX.md`](SANDBOX.md). Per the dancinlab
> root `.md` spec/history split. Repo-wide cycle history shared
> across all groups lives in `CHANGELOG.md` + `.roadmap.hexa_codex`
> §A.3.

---

## 2026-05-23 — domain opened

`SANDBOX.md` / `SANDBOX.log.md` created. Triggered by the ECONOMICS
routing-savings cycle-1/2 surface exhaustion:

- 3 candidates BLOCKED at the `claude --bare -p` 2.1.150 dispatch
  surface (`d_cache_aware` no cache_control flag, `d_early_stop` no
  stop-sequences flag, `d_prompt_compress` no compression lever).
- 1 stale (`d_batch_amortized` likely-BLOCKED parallel to the others
  — same surface family).
- `verify/numerics_economics_pareto_floor.hexa` (commit `5bbb9ad`,
  10/10 PASS BLUE) proved the canonical 2-tier router is **within
  0.44 pp of the analytic Pareto floor** on the 20-task manifest at
  20/20 accuracy — heuristic-router and CLI-knob axes both exhausted.

Remaining slack must come from a substrate change: host the LLM
ourselves. The SANDBOX domain captures that decision — self-hosted
measurement substrate that returns logits, KV cache, stop sequences,
deterministic seeds, batch dispatch, and unmetered manifest scale,
unblocking both the cycle-2 BLOCKED candidates and the F-CODEX-1/2
empirical landings the ECONOMICS roadmap v1.2.0/1.3.0 gates on.

The 8-round brainstorm that produced the Stage 0-4 ladder ran to
depletion (Rounds 1-8: model choice, routing-bench dimensions, infra,
experiment design, verification, risks, integration, residual sweep).
The Occam-recommended path: Stage 0 PoC with an OSS pretrained pick
(no training cost) + a thin dispatch wrapper, before climbing the
ladder to Stage 4 empirical landings.

Next: Stage 0 PoC — pick Qwen2.5-0.5B (M2), wire
`lm_foundry/tool/route_dispatch.hexa` (I8), dispatch one canonical
20-task pass on mac mini llama.cpp to measure accuracy floor +
serving cost. No commit lands until accuracy floor and dispatch
parity vs `claude --bare -p` are both measured.

---

## 2026-05-23 — kick round 1 — 12 candidates inventoried

`hexa kick --seed "<SANDBOX substrate axes>" --rounds 1` (mk9,
smash+414 free+211 res+20, 645 total) → `.discoveries/sandbox.tape`
opened with 12 candidates: 5 SANDBOX.md ladder stages
(d_stage0_poc → d_stage4_empirical_landing), 3 cycle-2 BLOCKED
revivals (d_cache_aware_local, d_early_stop_local,
d_prompt_compress_local — `_local` suffix to differentiate from
the API-surface dead entries that remain `BLOCKED` in
`economics-routing-savings.tape`), and 4 kick-1 orthogonal axes
the substrate unlocks beyond the SANDBOX.md ladder
(d_logit_calibration, d_kv_prefix_share, d_speculative_decode_model,
d_quantization_tier). Raw: `.discoveries/sandbox-kick1.raw`. Top-2
ROI: `d_stage0_poc` (gates everything) + `d_kv_prefix_share`
(finest-grained replacement for cycle-1 `d_batch_amortized`,
combines additively with the confirmed length-router 2-tier
policy). Six other seed axes (prompt-distillation,
retrieval-augmented dispatch, continuous-batching) deferred —
distillation pinned by §"Honesty rules" (Anthropic ToS),
retrieval/continuous-batching redundant with d_stage2_scale_manifest
+ d_kv_prefix_share.

---

## 2026-05-23 — Stage 0 PoC — Qwen2.5-0.5B-Instruct baseline

`bench/sandbox_stage0_baseline.hexa` measured the self-hosted
accuracy floor on the canonical 20-task economics-routing manifest
(verbatim from `bench/economics_routing_2tier.hexa`). Threshold for
"usable floor" = `>= 15/20`.

| metric | value |
|---|---|
| model | Qwen2.5-0.5B-Instruct-Q4_K_M (GGUF, ~379 MB) |
| host / tool | mac mini M3 · `llama-completion` (brew llama.cpp + Metal) |
| accuracy | 19/20 (95.0%) |
| total wall-clock | 26.13 s (~1.3 s/task incl. model-load amortization) |
| cost | $0 USD (local serving; `wall_ms` is the proxy cost surface) |
| usable floor reached | **true** (19/20 >= 15/20) |

Stage 0 verdict: self-hosted small-OSS substrate clears the usable
floor on the canonical manifest at 95% — comparable to the baseline
opus 18-19/20 reference, at zero per-call cost. Stage 1 (3-tier
persona via temperature/max-tok on the same single base, mock
haiku/sonnet/opus) is unblocked.

Honest residuals (g5 compliance — no cherry-picking):

- Task 9 (ASCII for 'A') — answered "97" (lowercase 'a'); honest
  model-knowledge miss, single failure of the run.
- Task 18 (binary 1101 -> decimal) — answer text said "= 42 decimal"
  (arithmetically wrong; correct = 13), but `byte_exact_subset`
  scorer matched "13" embedded in the working "11 * 2^2 + 1 * 2^1"
  — same scorer-artifact class as the cycle-1/2 rambling-cover
  pattern; reported as-is.
- Output snippets contain llama-completion's `[end of text]
  common_perf_print:` trailer because stderr was merged into the
  capture stream; expected-keyword substring match is unaffected.

Persisted:
- `bench/sandbox_stage0_baseline.hexa` — bench source (hexa-only).
- `.verdicts/sandbox/stage0_accuracy_floor.tsv` — per-task rows.
- `.verdicts/sandbox/stage0_accuracy_floor_summary.txt` — aggregate.

## 2026-05-23 — Stage 1 PoC — tier-persona convention degenerate (manifest no-op)

Implemented `bench/sandbox_stage1_persona.hexa` — the SANDBOX.md
§"Tier persona convention (Stage 1)" — single base model
(Qwen2.5-0.5B-Instruct-Q4_K_M, same as Stage 0) + 3 personas
distinguished by system prompt + decoding params only:

| persona | system prompt                          | temp | max_tok | mock tier |
|:--------|:---------------------------------------|:----:|:-------:|:---------:|
| `nano`  | "Answer in <=15 tokens."               | 0.0  |   32    | haiku     |
| `mid`   | "Answer concisely."                    | 0.0  |   256   | sonnet    |
| `max`   | "Answer carefully and thoroughly."     | 0.0  |  1024   | opus      |

Dispatch via `llama-completion -sys ... -p ...` (chat-template aware),
same scorer (byte_exact_subset, case-insensitive), same canonical
20-task manifest verbatim from Stage 0.

Result: **all 3 personas score 20/20 — perfect ceiling saturation.**

- `nano_accuracy = 20/20`  · `nano_total_wall_ms = 123047`
- `mid_accuracy  = 20/20`  · `mid_total_wall_ms  = 104160`
- `max_accuracy  = 20/20`  · `max_total_wall_ms  = 141580`
- `tier_separation_observed = false` (acc_ladder=false ms_ladder=false)
- `routing_simulation_viable = false` (spread_tasks=0)

The persona convention is **NOT falsified** — dispatch, scorer parity,
and per-persona wall_ms accounting all work mechanically. It is
**dead-on-manifest**: the canonical 20-task set is too short / too
uniform / too saturated for any tier-routing simulation to have signal.
Notably, even `nano` (max_tok=32 + "Answer in <=15 tokens.") produces
correct short answers including the two tasks Stage 0 missed
(task 9 ASCII for 'A' → "65" instead of "97"; task 18 binary 1101
correct in `mid` working line). The system-prompt constraint
"answer in <=15 tokens" outperforms Stage 0 vanilla on these — the
sys_prompt is actively HELPING accuracy, not hurting it.

ms_ladder is also non-monotone (`mid` is the fastest at 104s vs
nano 123s vs max 142s) — short max_tok=32 + early-EOS doesn't beat
mid's looser max_tok=256 in practice because most outputs hit the
natural `[end of text]` token early in all three regimes.

**Honest signal** (g5 compliance): Stage 2 (scaled stratified
manifest, `wc ∈ [5, 200]`, N >= 2000, 5 task strata) is the BLOCKING
dependency before tier-routing has any observable signal. Every
downstream substrate-only candidate that consumes Stage 1
(`d_cache_aware_local`, `d_logit_calibration`, `d_kv_prefix_share`,
`d_quantization_tier`) inherits this observability gap on the
20-task canonical manifest. The cycle-1/2 length-router 81.79%
saving cannot be reproduced under SANDBOX until Stage 2 lands.

`.discoveries/sandbox.tape` flipped: `d_stage0_poc` → confirmed
(verdict ref attached), `d_stage1_persona` → dead-on-manifest
(verdict ref attached); top-ROI candidate is now
`d_stage2_scale_manifest`.

Persisted:
- `bench/sandbox_stage1_persona.hexa` — bench source (hexa-only).
- `.verdicts/sandbox/stage1_persona.tsv` — 60 rows (3 personas × 20).
- `.verdicts/sandbox/stage1_persona_summary.txt` — aggregate verdict.
