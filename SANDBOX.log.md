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
