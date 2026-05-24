# ECONOMICS.log.md — economics verb group history

> History sibling of [`ECONOMICS.md`](ECONOMICS.md). Per the dancinlab
> root `.md` spec/history split. Repo-wide cycle history shared across
> all 4 groups lives in `CHANGELOG.md` + `.roadmap.hexa_codex` §A.3.

---

## 2026-05-24 — SANDBOX substrate revives 3 routing-savings BLOCKED levers (cross-domain)

Cross-domain link recorded from the ECONOMICS side. Three cycle-1/2
routing-savings candidates that this log filed as **dead/BLOCKED at
the `claude --bare -p` 2.1.150 dispatch surface** turned out to have
real value-add once the measurement surface was reopened on a
self-hosted substrate. The SANDBOX domain (cycles 3-6,
Qwen2.5-0.5B-Instruct-Q4_K_M on mac-mini-m3 · llama.cpp + Metal, $0
per-call) was opened specifically to revive these dead-ends; the
substrate-side resolution is logged in full in `SANDBOX.log.md` and
`.discoveries/sandbox.tape`. This entry mirrors the causal link into
the ECONOMICS history so the domain shows how its blocked levers
were resolved.

| ECONOMICS cycle-1/2 verdict | SANDBOX resolution |
|:---|:---|
| `d_cache_aware` — **BLOCKED** (no `cache_control` on CLI; warm −24.10% vs cold) | flag exposed but **dead [BLOCKED_AT_SCALE]** — `--prompt-cache` works, `warm_speedup_pct=13.30%` < 20% viable threshold; surface-limit narrowed to scale-limit (one-shot CLI ~3-4s Metal-init+mmap dominates the prefix-eval saving) |
| `d_early_stop` — **BLOCKED** (no `--stop-sequences` flag) | **CONFIRMED** via `llama-completion -r/--reverse-prompt` — `best_strategy=stop_dot`, `output_tok_reduction_pct=47.10`, `wall_ms_reduction_pct=86.40`, `accuracy_preserved=true` |
| `d_response_budget_cap` — **dead** (prompt-prefix gimmick backfired; haiku quoted the cap, output grew 747→1979 tok) | **CONFIRMED** via hard `-n` decoder-level cap — tightest floor-holding cap32, `wall_ms_reduction_vs_nocap_pct=51.59`, `cycle2_backfire_pathology_present=false` (avg_out_tok monotone 23→15→13→9→6, no prose channel for the cap to leak into) |
| `d_confidence_gated` — **dead** (DLG-mk0 heuristic surface; best τ=0.9 saved 55.59% @ 19/20, dominated by length 70.10% @ 20/20) | **SIGNAL_PRESENT** on real model logits — first-token logprob margin (top1−top2) via `llama-server` `/v1/chat/completions` `logprobs`; `margin_corr_signal=53.33`, `calibration_signal_present=true` (top-quartile 100% acc vs bottom-quartile 60%) |

A fourth substrate lever was probed and filed honestly as a
dead-at-threshold: `d_json_schema_constrained` (cycle-6) — the
`claude --bare -p` surface exposes no constrained-decoding option at
all, but `llama-server` enforces a strict JSON grammar. Best
(`json_strict`) hit `json_strict_output_tok_reduction_pct=18.8` /
`json_strict_wall_ms_reduction_pct=19.38`, short of the 30%
`reduction_target_pct` and with `accuracy_preserved=false` (lost 1
task). It survives as `REVIVAL_CANDIDATE_AT_STAGE_2` for a
verbose-output workload.

**Framing.** The external `claude --bare -p` surface foreclosed
these precision levers (no `cache_control`, no `--stop-sequences`, no
hard `--max-tokens`, no logits), making them look like fundamental
dead-ends. Self-hosting reopened the measurement surface, and **3 of
4 turned out to have real value-add the API surface had hidden** —
two CONFIRMED savings levers (early-stop, max_tokens cap) plus one
confirmed calibration signal (logit margin), with cache-aware
narrowed from unfixable-at-the-vendor-surface to
fixable-by-changing-dispatch-shape. This is the empirical
justification for the SANDBOX domain's existence, recorded here from
the ECONOMICS side.

**Corrections vs. the recollection at log time.** (a) `d_early_stop`
revival was recollected as "~30% wall_ms reduction"; the verdict file
(`stage3_earlystop_local_summary.txt`) reports `wall_ms_reduction_pct
=86.40` for `stop_dot` (the SANDBOX narrative's −30.64% figure is from
an earlier, differently-warmed run — file figure quoted here per the
trust-the-file rule; output_tok reduction is the deterministic signal
at 47.10%). (b) `d_cache_aware` was recollected as a clean "surface→
scale narrowing"; honestly it is **still dead** post-revival
(`kv_prefix_share_viable=false` at `warm_speedup_pct=13.30%`) — the
narrowing is to the *blocker class* (surface-limit → scale-limit), not
to a positive saving. The saving figures for early-stop and
max_tokens cap are quoted verbatim from the summary files; numbers are
not paraphrased.

## 2026-05-23 — speculative-draft hybrid — dominated across all strategies

Resolved the `d_speculative_draft` candidate (cycle-2). Architecture:
two-pass dispatch where haiku writes a draft and a verifier tier
(sonnet or opus) emits either `VERIFIED` or a rewrite.
`bench/economics_routing_speculative.hexa` ran 3 strategies on the
canonical 20-task manifest (full 20 × 3 sweep now complete):

| strategy             | cost (USD) | correct | saving      |
|:---------------------|-----------:|:-------:|------------:|
| baseline (opus)      | 0.28404    | 19/20   |  0.00%      |
| 2-tier (length2 ref) | 0.05817    | 20/20   |  **79.52%** |
| `draft_only` (haiku) | 0.06393    | 20/20   |  77.49%     |
| `spec_v_sonnet`      | 0.13902    | 19/20   |  51.06%     |
| `spec_v_opus`        | 0.41889    | 20/20   | **−47.47%** |

**Verdict: dead — dominated on every strategy.** `draft_only` (haiku
alone) already costs **more** than the 2-tier canonical because
haiku is verbose on this manifest (cycle-1 `d_two_tier_ablation`
established this — `fib` task 779 out_tok @ haiku vs sonnet's
concise output). `spec_v_sonnet` adds a second call on top of the
draft → 2.4× `draft_only` at 19/20 (the verify pass also failed to
catch one draft miss). `spec_v_opus` achieves 20/20 but at $0.41889
— **more expensive than the always-opus baseline** (saving =
−47.47%): running opus on every prompt as a verifier is strictly
worse than running opus once directly. `verified_rate` was 100% for
both verify variants — haiku draft was always accepted, so the
verify pass is pure overhead with no rewrite-driven accuracy
recovery. No axis where speculative architecture wins. Discovery
tape: `d_speculative_draft` candidate → dead; summary footer reads
`4 confirmed · 8 dead · 5 next-batch candidates`.

## 2026-05-23 — Pareto $/task lower bound — closed-form floor at 82.22%, canonical 2-tier within 0.44pp

Resolved the `d_pareto_lower_bound` candidate from
`.discoveries/economics-routing-savings.tape` — the round-2 T_BLUE
gap-closing question: how far above the analytic floor does the
canonical length2 (sonnet/opus) router sit on the 20-task manifest at
20/20 accuracy? Constructed the closed-form floor

> floor = Σ<sub>i=1..20</sub> min { cost(s, i) | s ∈ S and correct(s, i) = 1 }

over the three actually-sampled strategies S = {baseline (opus×20),
length3 (3-tier), length2 (2-tier)} using the per-(strategy, task)
measurements in `.verdicts/economics-routing-savings/2tier.tsv`. The
witness assignment (cheapest correct strategy per task) is encoded
inline in `verify/numerics_economics_pareto_floor.hexa` as the
`FLOOR_TIER_IDX` table, so the floor is TIGHT in the proof-of-construction
sense — not an unreachable infimum.

| strategy                  | cost (USD)   | correct | saving  |
|:--------------------------|-------------:|:-------:|--------:|
| baseline (opus×20)        |   0.319375   |  19/20  |  ref    |
| length3 (haiku/son/opus)  |   0.079218   |  20/20  | 75.20%  |
| **length2 (sonnet/opus)** | **0.058171** | **20/20** | **81.79%** |
| **floor (argmin-witness)**| **0.056780** | **20/20** | **82.22%** |

**Verdict: canonical 2-tier within-ε of the floor at ε = 1.0 pp.**
Absolute gap is $0.00139 over 20 tasks (length2 pays ~2.4% more than
the achievable floor); saving gap is 0.44 pp (length2 captures 99.5%
of achievable saving among sampled strategies). The witness assignment
chose `length2` on 13/20 tasks, `length3` on 7/20, and `baseline`
never — always-opus is never cheapest at 20/20 on this manifest. The
seven `length3`-wins are sub-stochastic-noise gains ($0.000005 to
$0.000765 per task) — same-tier stochastic call variance, not a
systematic improvement opportunity. Closed-form proof verified at
math_pure precision: all 10 invariants in
`verify/numerics_economics_pareto_floor.hexa` PASS (baseline column
reconciles to summary header at drift 2.5e-7; length2 saving reproduces
to 1.2e-5 pp; per-task elementwise lower-bound holds for all 20 tasks;
floor witness preserves 20/20 accuracy; baseline 19/20 lone miss
anchors to task 14 by direct row lookup).

**Honest limitations.** (a) Manifest-conditional: holds for THIS
20-task workload and the 3 strategies actually run; a cheaper
strategy never sampled cannot lower the bound. (b) Strategy-level,
not tier-level: per-task `model` column is unreliable under
`claude --bare -p` (cache-prefix accounting artifact), so we treat
each `(strategy, task)` pair as the proof atom rather than
`(tier, task)`. Operationally this is correct — a router dispatches
strategies, not tiers in isolation. (c) Accuracy-monotone floor:
only `correct(s, i) = 1` entries count, so baseline's task-14 miss
("{1,2,3}" not "1, 2, 3") is excluded by construction.

The round-2 T_BLUE result closes the heuristic-router frontier
proof-side and complements `d_threshold_sweep` (τ axis degenerate,
boundary already optimal). Discovery tape updated:
`d_pareto_lower_bound` flips candidate → confirmed [BLUE]; summary
footer now reads `4 confirmed · 7 dead · 6 next-batch candidates`.

## 2026-05-23 — 2-tier τ sweep — boundary already optimal

Resolved the open question on the canonical 2-tier router's cutoff —
does τ\* sit at the boundary of the swept range or in the interior?
`bench/economics_routing_threshold_sweep.hexa` sweeps
`τ ∈ {30, 50, 80, 100, 120, 150}` on `word_count(prompt)` against the
canonical 20-task manifest (`<=τ → sonnet`, else `opus`), reusing the
cached baseline (`baseline.tsv`) for the saving denominator:

| strategy        | cost (USD) | correct | saving      |
|:----------------|-----------:|:-------:|------------:|
| baseline (opus) | 0.28404    | 19/20   |  0.00%      |
| tau=30          | 0.08741    | 19/20   |  69.22%     |
| tau=50          | 0.08398    | 20/20   |  70.43%     |
| tau=80          | 0.07708    | 20/20   |  72.86%     |
| tau=100         | 0.06045    | 20/20   |  78.72%     |
| **tau=120**     | **0.05623**| **20/20**| **80.21%** |
| tau=150         | 0.08907    | 20/20   |  68.64%     |

**Verdict: boundary already optimal.** All 20 manifest prompts have
`word_count ∈ [5, 14]` (max = 14), so every τ ≥ 14 in the swept grid
routes 20/20 → sonnet — the six τ runs effectively measure
sonnet-call stochastic-cost variance on identical routing. Best
τ\*=120 at 80.21% @ 20/20 does **not** beat the canonical 2-tier
reference of 81.79% (Δ = -1.58pp, within noise); the τ=30 single-miss
is a sonnet stochastic event on the same all-sonnet routing as the
other τs. The canonical 2-tier cutoff is already at the Pareto bound
on this manifest — to exercise the τ frontier in future cycles the
manifest needs prompts with `word_count ≥ 30` that would actually
trip the opus branch. Discovery tape updated: new `d_threshold_sweep`
confirmed entry; summary footer now reads `3 confirmed · 5 dead · 4
next-batch candidates`.

## 2026-05-23 — response-budget cap on haiku — dominated by drop-the-tier

Resolved the `d_response_budget_cap` candidate from
`.discoveries/economics-routing-savings.tape` — whether appending a
per-tier response-budget hint ("Answer in &lt;=N tokens.") to haiku-routed
prompts shaves the verbosity that made haiku LOSE the 3-tier vs 2-tier
ablation (the fib task on the 3-tier router emitted 779 output tokens
through haiku, more than sonnet would have used). The `claude --bare
-p` CLI exposes no `--max-tokens` flag, so the cap had to ride in the
prompt itself.  `bench/economics_routing_tokencap.hexa` sweeps four
strategies against the canonical 20-task manifest, reusing the cached
`baseline.tsv` denominator and the 2-tier reference from
`2tier_summary.txt`:

| strategy             | cost (USD) | correct | saving      |
|:---------------------|-----------:|:-------:|------------:|
| baseline (opus)      | 0.28404    | 19/20   |  0.00%      |
| 2-tier (sonnet/opus) | 0.05817    | 20/20   | **81.79%**  |
| 3tier_baseline       | 0.08236    | 20/20   |  71.00%     |
| 3tier_haiku_cap15    | 0.09697    | 20/20   |  65.86%     |
| 3tier_haiku_cap30    | 0.07406    | 20/20   |  73.93%     |
| 3tier_global_cap30   | 0.06646    | 19/20   |  76.60%     |

**Verdict: NO** — no cap strategy beats 2-tier's 81.79% at 20/20. The
best 20/20 cap (haiku_cap30 at 73.93%) is strictly dominated by 2-tier
(Δ=-7.86pp). Two honest pathologies surfaced. First, the **tightest
cap backfired**: `cap15` saved LESS than the uncapped 3-tier — the
fib task's haiku output grew from 747 → 1979 tokens because haiku
acknowledged the cap in prose before writing the code (cost
`$0.0188` → `$0.0446`). A prompt-prefix cap is not a hard cap; the
model can ignore or paraphrase it. Second, **global_cap30 truncated
sonnet's BFS-vs-DFS answer**, dropping accuracy to 19/20 (the cap fits
the haiku tier but not all sonnet-tier prompts). Drop-the-tier beats
cap-the-prompt on this manifest; 2-tier remains the operationally-
simplest Pareto-optimal router. Discovery tape updated:
`d_response_budget_cap` (round-2 candidate, originally `d_response_cap`)
closed dead, summary footer now reads `2 confirmed · 5 dead · 4
next-batch candidates`.

## 2026-05-23 — cache-aware dispatch — BLOCKED at the `claude --bare -p` surface

Resolved the `d_cache_aware` candidate from
`.discoveries/economics-routing-savings.tape` — whether sharing a
long system prefix across many short tasks lets Anthropic
prompt-caching dominate input cost (`cache_read_input_tokens >>
input_tokens`) and drop effective `$/task`.
`bench/economics_routing_cache.hexa` runs a 10-task suffix manifest
under two strategies on the same haiku tier:

| strategy | cost (USD) | input_tok | cache_create | cache_read | output_tok | correct |
|:---------|-----------:|----------:|-------------:|-----------:|-----------:|:-------:|
| cold     | 0.029419   | 20187     | 0            | 0          | 913        | 10/10   |
| warm     | 0.036509   | 26689     | 0            | 0          | 1039       | 10/10   |

`warm` passes the same ~4 KB / ~1 k-token shared prefix via
`--system-prompt`; `cold` omits it. **Both strategies report
`cache_creation_input_tokens=0` AND `cache_read_input_tokens=0` on
every one of the 20 dispatches** (verbatim from `.usage` in the
`--output-format json` payload). `warm` is **24.10 % MORE
expensive** than `cold` — the SDK pays full input cost for the
shared prefix on every call without ever emitting the
`cache_control` header.

**Verdict: BLOCKED** — `claude --bare -p` non-interactive dispatch
does not activate Anthropic's ephemeral prompt-cache, regardless
of `--system-prompt` length. Same surface-limit family as the
earlier `d_token_decomp` blocker. Cache-aware routing requires a
different dispatch surface (raw Messages API with explicit
`cache_control`, or interactive session reuse with sticky
context) — out of scope for the current router.

Discovery tape updated: `d_cache_aware` candidate → dead
`[actual_tier=BLOCKED]`, batch summary now reads `2 confirmed · 4
dead · 6 next-batch candidates`. Total bench spend `$0.066` (cold
+ warm), well under the `$0.4` cap.

## 2026-05-23 — kick round 2 — 5 new orthogonal routing-economics candidates

Continuous-discovery lane (per `cx_discovery`) — ran `hexa kick`
round 2 against the post-5-failure context for the ECONOMICS
routing-savings goal. Round-1 cumulative state: 2 confirmed
(`d_pareto`, `d_two_tier_ablation` 81.79% @ 20/20), 3 dead
(`d_token_decomp` BLOCKED, `d_confidence_gated` 55.59% @ 19/20,
`d_difficulty_predict` 62.15% @ 20/20 vs length 77.72%), 2 stale
candidates parallel-running in sibling agents (`d_cache_aware`,
`d_batch_amortized`).

Kick seed deliberately scoped to **orthogonal** axes (per-prompt
heuristic-routing exhausted by length-cutoff): precision controls,
workload-shape, formal Pareto lower-bound, speculative draft,
prompt-compression. Raw trace at
`.discoveries/economics-routing-kick2.raw` (mk9, 629 ideas).

| slug                   | tier  | $est | axis                  |
|:-----------------------|:-----:|-----:|:----------------------|
| `d_response_cap`       | GREEN | 0.4  | precision (max_tokens)|
| `d_early_stop`         | GREEN | 0.3  | precision (stop-tok)  |
| `d_prompt_compress`    | GREEN | 0.5  | input compression     |
| `d_speculative_draft`  | GREEN | 0.6  | draft+verify          |
| `d_pareto_lower_bound` | BLUE  | 0.0  | formal floor proof    |

Discovery tape updated:
`.discoveries/economics-routing-savings.tape` — round-1+2 cumulative
`2 confirmed · 3 dead · 7 next-batch candidates`. Round-2 strategy
note: no further heuristic-router variants (length is SOLE Pareto
point); levers probe orthogonal axes.

## 2026-05-23 — confidence-gated router ablation — Pareto bound reinforced

Resolved the `d_confidence_gated` candidate from
`.discoveries/economics-routing-savings.tape` — a confidence-gated
router that escalates to opus when the DLG-mk0 classifier's
confidence falls below `τ`. `bench/economics_routing_confgate.hexa`
sweeps `τ ∈ {0.6, 0.7, 0.8, 0.9}` on the canonical 20-task manifest,
reusing the cached baseline (always-opus) and length-router
cost/accuracy as references:

| strategy             | cost (USD) | correct | saving      |
|:---------------------|-----------:|:-------:|------------:|
| baseline (opus)      | 0.28078    | 18/20   |  0.00%      |
| length-router        | 0.08395    | 20/20   | **70.10%**  |
| confgate τ=0.6       | 0.27946    | 19/20   |  0.47%      |
| confgate τ=0.7       | 0.25934    | 19/20   |  7.64%      |
| confgate τ=0.8       | 0.29551    | 19/20   | -5.25%      |
| confgate τ=0.9       | 0.12471    | 19/20   |  55.59%     |

**Verdict: NO** — no τ holds the 20/20 floor, and the best confgate
point (τ=0.9 at 55.59%) is strictly dominated by length-cutoff
(70.10% @ 20/20). The Pareto bound established by the 4-strategy
sweep (length is the SOLE Pareto-optimal router) is reinforced: with
the kick-suggested confidence lever now closed as a dead end, no
GREEN-tier lever has a known path to beat plain length on this
manifest.

Operationally — `lm_foundry/tool/dlg_mk0_wrapper.py` gains
`--with-conf` (returns `tier\tconfidence`) to support the gate; the
20-task baseline was re-captured under the current `claude --bare -p`
dispatch, with the sum drifting from `$0.31747` to `$0.28078`
(per-task cost-column drift, no strategy change — see
`.verdicts/.../baseline.tsv`). The length-router cached cost is
unchanged, so the headline saving ratio drops from `73.56%` to
`70.10%` purely from the new baseline; the strategy ranking is
unchanged (length still SOLE Pareto-optimal). Discovery tape
updated: `d_confidence_gated` candidate → dead, batch summary now
reads `1 confirmed · 2 dead · 4 next-batch candidates`.

## 2026-05-23 — ECONOMICS Pareto envelope added

Third ECONOMICS-specific cross-cutter — closed-form (N, D) ↔
(loss, train_cost) trade-off geometry. `verify/numerics_economics_pareto.hexa`
(10 checks, all PASS):

| # | Check                                                                  |
|--:|:-----------------------------------------------------------------------|
| 1 | iso-loss contour monotone — D drops as N rises at fixed L*             |
| 2 | Lagrangian optimum — `(N/D)^α = A/B`, for n=6 collapses to N/D ≈ 0.94 |
| 3 | equal-reducible identity at optimum — `A·N^-α = B·D^-α`               |
| 4 | asymptotic E floor — `loss(N → 1e50, D → 1e50) → E_LOSS` (rel < 1e-5) |
| 5 | pole at `N → 0` — loss diverges (> 1e3 at N = 1e-6)                   |
| 6 | pole at `D → 0` — loss diverges (> 1e3 at D = 1e-6)                   |
| 7 | `∂L/∂N < 0` — loss strictly decreases in N                             |
| 8 | `∂L/∂D < 0` — loss strictly decreases in D                             |
| 9 | iso-cost hyperbola — fixed `train_cost` ratio ⇒ fixed `N·D`           |
|10 | n6-vs-Chinchilla allocation gap — `|D/N_n6 − D/N_chin| ≈ 18.9 > 15`   |

Check 10 is the headline n=6 prediction: with α = β = 1/6 the
optimal allocation is nearly symmetric (D/N ≈ 1.07), in contrast
to Chinchilla's published optimum D/N ≈ 20. The two scaling-law
fits live in different corners of the (N, D) plane.

Wired into `verify/run_all.hexa` (41 → 42 subjects),
`verify/lint_numerics.hexa` (green core 19 → 20),
`tests/test_all.hexa` (32 → 33 cases), and the X-ECON row of
`verify/report_economics_ladder.hexa` (2/2 → 3/3).

## 2026-05-23 — ECONOMICS group ladder report added

A sister of `verify/falsifier_check.hexa` (which only covers the four
F-CODEX falsifiers), now ECONOMICS-focused — surfaces the recipe §3
ladder across all three ECONOMICS verbs including non-falsifier
`quality_scale`. `verify/report_economics_ladder.hexa` (10 checks,
all PASS) verifies and emits the per-verb closure table:

| verb            | T1  | T2  | T2-solver | T3  | T4-stub | closure |
|:----------------|:---:|:---:|:---------:|:---:|:-------:|:-------:|
| train_cost      | ✓   | ✓   | ✓         | ✓   | ✓       | 100%    |
| infer_cost      | ✓   | ✓   | ✓         | ✓   | ✓       | 100%    |
| quality_scale   | ✓   | ✓   | ✓         | ✓   | ✓       | 100%    |

The 10 checks gate on: per-verb T1+T2+T3 closure (3 checks), X-ECON
cross-cutter row 2/2, T4-stub row 3/3, all-verbs-100% simultaneously,
inventory ≥ 17 files, group SSOT (ECONOMICS.md + log) present, verb
spec dirs present, and the rendered ladder table (always-pass render
check). Wired into `verify/run_all.hexa` (40 → 41 subjects) and
`tests/test_all.hexa` (31 → 32 cases). Not wired into lint_numerics
(it is a meta report, not a `numerics_*` script).

## 2026-05-23 — ECONOMICS scaling-laws sweep added

A companion of the 3-pillar cross-cutter, restricted to closed-form
ratio identities — `verify/numerics_economics_scaling_laws.hexa`
(10 checks, all PASS). Sweeps the full scaling-law surface of the
three ECONOMICS verbs and the cost-vs-quality competition ratio
emerging from their distinct n=6 exponents:

| # | Check                                                                |
|--:|:---------------------------------------------------------------------|
| 1 | q-side N halving — `red_term(A,2N,α)/red_term(A,N,α) = 2^-α`         |
| 2 | q-side D halving — `red_term(B,2D,α)/red_term(B,D,α) = 2^-α`         |
| 3 | q-side N 4× — `red_term(A,4N,α)/red_term(A,N,α) = 4^-α`              |
| 4 | q-side D 4× — `red_term(B,4D,α)/red_term(B,D,α) = 4^-α`              |
| 5 | train N doubling — `train(2N,D)/train(N,D) = 2^N6_EXP`                |
| 6 | train D doubling — `train(N,2D)/train(N,D) = 2^N6_EXP`                |
| 7 | train ND 4× — `train(2N,2D)/train(N,D) = 4^N6_EXP`                   |
| 8 | infer ctx doubling — `infer(2c)/infer(c) = 2^τ = 16`                 |
| 9 | infer ctx 4× — `infer(4c)/infer(c) = 4^τ = 256`                      |
|10 | cost/quality ratio — `N6_EXP / α = (24/25)/(1/6) = 144/25 = 5.76`    |

The check 10 ratio is the ECONOMICS surface's "diminishing returns"
signature: per log doubling the training cost rises ~5.76× as fast
as the quality reducible-loss term shrinks.

Wired into `verify/run_all.hexa` (39 → 40 subjects),
`verify/lint_numerics.hexa` (green core 18 → 19), and
`tests/test_all.hexa` (30 → 31 cases).

## 2026-05-23 — ECONOMICS 3-pillar cross-cutter added

A new `verify/numerics_economics_cross_pillar.hexa` (10 checks, all
PASS) ties the three ECONOMICS verbs to one n=6 lattice — sister of
the general `verify/numerics_cross_pillar.hexa` (which only covers the
four F-CODEX falsifiers). The 10 checks:

| # | Check                                                                  |
|--:|:-----------------------------------------------------------------------|
| 1 | lattice closure σ·φ = n·τ = J₂ = 24 (shared by all 3 verbs)            |
| 2 | train_cost exponent recovery — `N6_EXP·(J₂+1) = J₂` (24/25 · 25 = 24) |
| 3 | infer_cost exponent recovery — `τ·n = J₂` (4 · 6 = 24)                |
| 4 | quality_scale exponent recovery — `α·σ = φ = 2` AND `α = β`            |
| 5 | exponent triad ordering — 0 < α (1/6) < N6_EXP (24/25) < 1 < τ (4)     |
| 6 | 3-pillar composite at Chinchilla 70B / 1.4T / 8k — all 3 finite > 0    |
| 7 | quality⟂infer orthogonality — quality free of ctx, infer free of (N,D) |
| 8 | quality halving rule — `red_term(A,2N,α) / red_term(A,N,α) = 2^-α`    |
| 9 | train doubling rule — `train_cost(N,2D) / train_cost(N,D) = 2^N6_EXP` |
|10 | n6-vs-measured triple gap — quality·train·infer all distinct from emp. |

Wired into `verify/run_all.hexa` (38 → 39 subject scripts),
`verify/lint_numerics.hexa` (green core 17 → 18), and
`tests/test_all.hexa` (29 → 30 cases).

## 2026-05-23 — quality_scale §3 verify ladder closed

`quality_scale` gains its full recipe §3 verification ladder — the
first non-falsifier ECONOMICS verb to reach §3 closure:

- T1 — `verify/calc_quality_scale.hexa` (8 algebraic checks)
- T2 — `verify/numerics_quality_scale.hexa` + `_solver.hexa` (10 + 10)
- T3 — `verify/numerics_quality_scale_parity.hexa` (10 checks)

The ladder fits the Chinchilla loss surface `loss = E + A·N^-α + B·D^-β`
with the n=6 lattice exponent `α = β = φ(6)/σ(6) = 1/6`. T2 verifies
loss-surface shape only (monotone decreasing, floored at the
irreducible loss E) — the Chinchilla A/B coefficients pair with a
measured ≈0.34 exponent, not the n=6 1/6, so absolute loss is
intentionally not asserted. T3 ties the 1/6 exponent to the geometric
mean of the Kaplan-2020 and Hoffmann-2022 published loss-scaling
exponents. Commits `89e810d` (T1), `80136fe` (T2/T3), `46b0971`
(verify-surface restoration).

## 2026-05-23 — domain doc opened

`ECONOMICS.md` / `ECONOMICS.log.md` created in the per-domain root-SSOT
restructure (alongside `SAFETY` / `OPS` / `SUBSTRATE`). The economics
group itself is unchanged — 3 verbs, spec-first, since v1.0.0.

## 2026-05-06 — v1.0.0 seed (Cycle 0)

3 economics verbs extracted unchanged from
`canon@c0f1f570:domains/cognitive/`: `train_cost` · `infer_cost` ·
`quality_scale`. Part of the 17-verb / 4-group seed. Commit `63e8283`.

## v1.0.0 — F-CODEX-1 / F-CODEX-2 arithmetic floors PASS

`training_cost ∝ N^24` (F-CODEX-1) and `inference_cost ∝ context^4`
(F-CODEX-2) closed-form floors verified by `verify/falsifier_check.py` —
the algebraic identity `σ·φ = n·τ = J₂ = 24` is self-proving. Empirical
curve fits PENDING — F-CODEX-1 → v1.2.0, F-CODEX-2 → v1.3.0.

---

## 2026-05-23 — early-stop + prompt-compress probes — BOTH BLOCKED ($0)

Combined CLI-surface probe to verify whether the two outstanding
round-2 routing-savings candidates have any reachable lever in
`claude --bare -p` 2.1.150. Captured full `claude --help` to
`.discoveries/economics-routing-cli-surface.raw`; greping for stop /
max-token / compression / rewrite flags yielded only two hits:
`--json-schema` (output-shape validator) and `--max-budget-usd`
(session-wide dollar kill-switch). Neither caps output tokens nor
strips input.

| candidate          | flag needed                 | exposed? | verdict          |
|:-------------------|:----------------------------|:--------:|:-----------------|
| `d_early_stop`     | `--stop-sequences` / `--stop` |   no   | dead · BLOCKED   |
| `d_prompt_compress`| any compression/rewrite     |   no   | dead · DEGENERATE |

**Early-stop — BLOCKED.** The CLI surface enumerates no
`--stop-sequences`, `--stop`, `-s`, `--max-tokens`, or `--max-output`
flag. Output-token termination is unreachable from `claude --bare -p`.
Prompt-prefix length-cap was already falsified one cycle ago by
`d_response_budget_cap` (haiku quoted the cap into prose, blowing
output volume). Same surface-limit family as `d_cache_aware` (no
`cache_control`) and `d_token_decomp` (telemetry unreliable). No
bench run, $0 spent.

**Prompt-compress — DEGENERATE.** The 20-task manifest has
`word_count ∈ [5, 14]` (max = 14) — already at floor. LLMLingua-style
ratio=0.7 has no slack to shave. The dominant non-essential input is
the `"Reply with X only."` suffix (~5 tokens/prompt), but stripping
it risks regressing 20/20 (the suffix is load-bearing for the model's
output shape — same fragility class as the `d_response_budget_cap`
backfire). Compression has nonzero room only on a wc≥30 manifest
reshape — same future-work as `d_threshold_sweep`. No bench run, $0
spent.

Discovery tape updated: `d_early_stop` and `d_prompt_compress` flipped
from candidate → dead with `actual_tier=BLOCKED` / `actual_tier=DEGENERATE`
respectively, raw cite `.discoveries/economics-routing-cli-surface.raw`.
Summary footer now reads `3 confirmed · 7 dead · 2 next-batch
candidates` (speculative_draft + pareto_lower_bound remain;
batch_amortized stale). The round-2 lever exhaustion converges:
`claude --bare -p` exposes neither precision controls (stop / max-tok
/ cache_control) nor compression — the substrate gives us model
choice and prompt content only. The Pareto frontier on this surface
is set by the canonical 2-tier length router at 81.79% saving @
20/20; remaining slack must come from architectural changes
(speculative-draft, batch endpoint, raw Messages API) rather than
CLI knobs.

---

## 2026-05-23 — kick round 3 — 5 NEW orthogonal candidates ($0)

Ran `hexa kick --rounds 1 --engine mk9` with a refined seed capturing
the post-cycle-2 constraints: (1) length-cutoff is the SOLE
Pareto-optimal heuristic-router (5 alternatives dead), (2) `claude
--bare -p` 2.1.150 BLOCKS cache_control / batch / max-tokens /
stop-sequences at the dispatch surface (3 dead at this surface),
(3) the canonical 20-task manifest is degenerate on `wc ≤ 14`
(threshold sweep all-sonnet, prompt-compress no slack). Mk.IX 6-stage
chain produced 650 total atoms (smash+414 free+211 res+25, σ=0.10);
raw at `.discoveries/economics-routing-kick3.raw`. The seed explicitly
asked for axes ORTHOGONAL to both heuristic-router exhaustion AND the
CLI surface limit — workload-shape, offline pre-routing,
system-scheduling, formal results.

| slug                    | axis                | tier  | $est  | one-line hypothesis                                                                                                |
|:------------------------|:--------------------|:-----:|:-----:|:-------------------------------------------------------------------------------------------------------------------|
| `d_oracle_optimality`   | formal              | BLUE  | $0    | length-router within ε ≤ 5pp of instance-optimal floor (lookup cheapest correct tier per prompt from baseline.tsv) |
| `d_offline_memoize`     | workload-shape      | GREEN | $0.1  | second-pass $/task → 0 (canonical manifest is a fixed regression bench, repeats are free)                          |
| `d_router_cost_amortize`| offline pre-routing | GREEN | $0.2  | amortized ML-router (offline lookup table) closes ≥5pp gap to length-router on second+ pass                        |
| `d_parallel_dispatch`   | system-scheduling   | GREEN | $0.1  | parallel cuts wall-clock ≥3× at 20/20 with vendor $/task invariant (latency-axis, not cost-axis)                   |
| `d_prompt_cluster_reuse`| workload-shape      | GREEN | $0.5  | cluster-and-reuse beats length-router IFF the manifest has ≥1 nontrivial semantic cluster                          |

All five target axes the previous rounds DID NOT touch. The two
strongest by ROI: (a) `d_oracle_optimality` is BLUE at $0 — the
per-prompt cheapest-correct-tier lookup over the existing
`.verdicts/economics-routing-savings/baseline.tsv` directly derives
an instance-optimal floor with no new API spend, distinct from
`d_pareto_lower_bound`'s analytic distribution-level floor; (b)
`d_offline_memoize` is GREEN at $0.1 and tests a tautology the bench
already obeys (the 20-task manifest is a fixed regression set, so
the dispatcher SHOULD memoize by construction — anything else is
wasted spend on every rerun).

The remaining three round-3 candidates probe complementary axes:
`d_router_cost_amortize` revisits whether `dlg_mk0` / `class` /
`difficulty` losses in cycle-1 were policy failures or
per-call-cost failures — by moving the router call OFFLINE we
eliminate it from the per-task denominator, potentially reviving the
ML-routing family at GREEN tier. `d_parallel_dispatch` is honest
about its scope — it is a LATENCY-axis Pareto move, not a cost move;
vendor $/task should be invariant (±sonnet noise), and the test gate
is "wall-clock ≥3× at 20/20 with $/task unchanged".
`d_prompt_cluster_reuse` falsifies cleanly on the canonical 20
prompts (the manifest is intentionally diverse; if no cluster has
≥2 semantically-overlapping prompts the lever dies on that manifest
alone and needs a duplicates-rich workload to exit DEGENERATE).

Discovery tape updated: footer flipped to `3 confirmed · 7 dead ·
7 next-batch candidates` (speculative_draft, pareto_lower_bound,
batch_amortized [stale] + 5 round-3 new). The kick reveals that the
*per-call-dispatch* axis is exhausted; remaining slack lives ACROSS
passes (memoize, router_amortize), ACROSS prompts (cluster_reuse),
ACROSS wall-clock (parallel), or on the EXISTING verdict surface
(oracle_optimality, no spend).

---

_Next: v1.2.0 (2026-10, PLANNED) — wire the economics verbs, ship the
training/inference cost scaling fit, land F-CODEX-1 empirical. Append
round entries here as the group progresses._

---

## 2026-05-24 · ECONOMICS round-3 d_oracle_optimality CONFIRMED (BLUE) — second independent $/task floor proof

Cross-link to the SECOND independent BLUE-tier formal proof of the
$/task lower bound on the canonical 20-task economics-routing
manifest, joining the cycle-2 5bbb9ad
`verify/numerics_economics_pareto_floor.hexa` proof from a different
framing (per-task argmin certificate vs distribution-level analytic
Pareto floor).

**Closure surface**:
- Harness: `verify/numerics_economics_oracle_optimal.hexa` (NEW,
  10 closed-form checks, math_pure only, 10/10 PASS)
- Verdict: `.verdicts/sandbox/oracle_optimality.txt` (BLUE)
- Tape row: `.discoveries/economics-routing-savings.tape`
  `d_oracle_optimality` flipped `candidate → confirmed [actual_tier=BLUE]`
- SANDBOX cross-link: `SANDBOX.log.md` (2026-05-24 section)

**Result headline**:

| quantity                         | value         |
|----------------------------------|---------------|
| oracle_floor                     | $0.0567804    |
| oracle saving% vs baseline       | 82.2214%      |
| length2 saving% (canonical 2-tier)| 81.7861%     |
| length2 − oracle_floor           | $0.0013903    |
| oracle − pareto_floor (inline)   | $0.0 USD EXACT|
| oracle − pareto_floor (cycle-2 ref)| $4e-07      |

**Honesty fence**. The cycle-2 pareto_floor proof and this cycle-8
oracle_optimality proof operate on the IDENTICAL strategy grid
{baseline, length3, length2} from 2tier.tsv. They therefore agree
EXACTLY (gap $0.0 USD inline) — this is the strongest form of
cross-validation available without sampling new strategies, but it
does NOT constitute a tighter bound. The value of the second proof
is the independent recomputation from a different framing
(per-prompt argmin certificate vs distribution-level analytic
Pareto): two formal proofs from different angles agreeing on the
same data. A genuinely richer strategy grid (class / dlg_mk0 /
threshold_sweep / difficulty-router as orthogonal strategies) could
in principle lower the floor; on the sampled grid it does not, and
the canonical 2-tier length router captures 99.5% of achievable
saving among sampled strategies.

**Cumulative ECONOMICS round-1+2+3 ledger** (post cycle-8):
5 confirmed (Pareto frontier · 2-tier length-router 81.79% ablation ·
threshold_sweep boundary at τ\*=120 · `pareto_lower_bound` BLUE
[cycle-2 5bbb9ad] · `oracle_optimality` BLUE [cycle-8 THIS]) ·
8 dead (token decomp · confidence_gated · difficulty_predict ·
cache_aware · response_budget_cap · early_stop · prompt_compress ·
speculative_draft) · 4 next-batch candidates remaining
(`offline_memoize` · `parallel_dispatch` · `prompt_cluster_reuse` ·
`router_cost_amortize`). Heuristic-router frontier among sampled
strategies is exhausted — remaining slack lives across passes,
prompts, wall-clock, or on richer strategy grids not yet sampled.

**Atlas / paper gate**. SANDBOX.md M3.ECON checkbox STAYS `[ ]`.
oracle_optimality is per-task tier optimality (BLUE formal,
manifest-conditional). M3.ECON gate flips `[ ] → [x]` only when
F-CODEX-1/2 4-point scale-grid empirical fit lands (per-scale cost
exponent), a separate axis tracked by `d_stage4_empirical_landing`
(harness_ready, k_active=1, INSUFFICIENT until k_active=4 with both
residuals ≤ ε=0.10).

---

## 2026-05-24 — M5.ECON release gates formally written (v1.2.0 / v1.3.0)

Documentation-only entry. The M3.ECON harness
`verify/numerics_economics_empirical_landing.hexa` (commit 843b241,
cycle-9) already encodes the v1.2.0 + v1.3.0 release gate as a
10-check verifier; this commit publishes that gate in ECONOMICS.md
§Roadmap (new subsection §M5.ECON release-gate criteria — formal)
so v1.2.0 / v1.3.0 have a published release criterion, not just an
open milestone. SANDBOX.md M5.ECON checkbox is NOT flipped — this
commit DOCUMENTS the gate, it does not satisfy it.

The pass / defer / fail bands are read verbatim from the harness:
`EPS_RESIDUAL_THRESHOLD = 0.10` (L124), `PENDING_SENTINEL = -1.0`
(L129), `NAN_SLOPE = -999.0` (L130), 4-row scale grid `{0.5e9,
1.5e9, 3.0e9, 7.0e9}` (L138–143), 4-row context grid `{1024, 2048,
4096, 8192}` (L211–216, anchored to the `CTX_REF = 8192`
cross-verifier). Checks 8 + 9 are the F-CODEX-1 + F-CODEX-2 residual
gates; check 10 is the verdict-line truth-table composer.

Cross-ref table (verbatim, also in ECONOMICS.md §Roadmap):

| release | falsifier | harness | gate condition | currently |
|:---|:---|:---|:---|:---|
| v1.2.0 | F-CODEX-1 (`N^σφ`) | `verify/numerics_economics_empirical_landing.hexa` ch.8 | residual ≤ 0.10 across 4 scale rungs | 🟠 1/4 |
| v1.3.0 | F-CODEX-2 (`context^τ`) | `verify/numerics_economics_empirical_landing.hexa` ch.9 | residual ≤ 0.10 across 4 context rungs | 🟠 0/4 |

**Currently state.** v1.2.0 = 🟠 INSUFFICIENT, `k_active = 1` (0.5B
live from cycle-6 verdict; 1.5B in flight from cycle-9 sibling-agent
ada5; 3B + 7B PENDING). v1.3.0 = 🟠 INSUFFICIENT, 0 of 4 context
rungs have data (M3.OPS p50/p99 grid not yet built — candidate for
`.discoveries/sandbox.tape`).

**Honesty (g34).** F-CODEX-2 has no harness data at all yet
(v1.2.0 starts 1/4, v1.3.0 starts 0/4). Both gates remain
🟠 INSUFFICIENT per g5 rubric until `k_active == 4` AND both
residuals ≤ ε.
