# ECONOMICS.log.md — economics verb group history

> History sibling of [`ECONOMICS.md`](ECONOMICS.md). Per the dancinlab
> root `.md` spec/history split. Repo-wide cycle history shared across
> all 4 groups lives in `CHANGELOG.md` + `.roadmap.hexa_codex` §A.3.

---

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

_Next: v1.2.0 (2026-10, PLANNED) — wire the economics verbs, ship the
training/inference cost scaling fit, land F-CODEX-1 empirical. Append
round entries here as the group progresses._
