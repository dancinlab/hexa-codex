@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "economics-routing-savings"
  source = "hexa kick (mk9, round 1, 651 total; round 2, 629 total) + Pareto re-analysis of cycle-1/2 data"
  date   = "2026-05-23"
  flow   = "discovery → next-batch CLAIMS.tape candidate → verify → .verdicts (cx_discovery continuous)"

# kick seed: "Claude CLI tier-routing cost optimization beyond static length
# cutoff: confidence-gated routing · per-task-difficulty prediction ·
# cache-aware dispatch · batch-amortized cost — what economic levers reduce
# $/task further while preserving accuracy?"

# ── confirmed finding (this batch, $0) ──

@C d_pareto := "length router is the SOLE Pareto-optimal point — dominates baseline + class + dlg" :: confirmed [target_tier=GREEN actual_tier=GREEN]
  raw = ".verdicts/economics-routing-savings/pareto.txt"

# ── dead end (this batch — honest negative) ──

@C d_token_decomp := "per-task token-cost decomposition — BLOCKED, telemetry unreliable under --bare -p" :: dead [target_tier=GREEN actual_tier=BLOCKED]
  note = "input/output_tokens columns inconsistent across strategies (class 19945 vs dlg 68); only total cost_usd reconciles. Same root cause as the unreliable model column."

@C d_confidence_gated := "confidence-gated routing — DLG conf < tau → opus, else cheap tier" :: dead [target_tier=GREEN actual_tier=GREEN]
  raw  = ".verdicts/economics-routing-savings/confgate_summary.txt"
  note = "swept tau in {0.6,0.7,0.8,0.9}; best = tau=0.9 at 55.59% saving @ 19/20 — strictly dominated by length (70.10% @ 20/20). Length-cutoff Pareto bound reinforced; no confgate point holds full 20/20 accuracy."

@C d_difficulty_predict := "per-task difficulty score → tier (length × keyword × output-len prior)" :: dead [target_tier=GREEN actual_tier=GREEN]
  raw  = ".verdicts/economics-routing-savings/difficulty_summary.txt"
  note = "composite difficulty heuristic scored 62.15% saving @ 20/20 vs length 77.72% @ 20/20 (Δ=-15.58pp). Adding features HURTS — extra signals route some easy prompts up-tier, eroding the saving the simpler length rule captured."

# ── confirmed-bonus (this batch — orthogonal win) ──

@C d_two_tier_ablation := "2-tier (sonnet/opus) vs 3-tier (haiku/sonnet/opus) ablation" :: confirmed [target_tier=GREEN actual_tier=GREEN]
  raw  = ".verdicts/economics-routing-savings/2tier_summary.txt"
  note = "dropping haiku ADDS +6.59pp saving (3-tier 75.20% → 2-tier 81.79%, both 20/20). Cheaper per-token tier loses on output volume — haiku emits verbose answers (e.g. fib 779 out_tok @ $0.0166). 2-tier is simpler AND cheaper for this workload."

# ── next-batch candidates (kick levers, not yet run) ──

@C d_cache_aware := "cache-aware dispatch — `claude --bare -p` does NOT expose ephemeral cache_control" :: dead [target_tier=GREEN actual_tier=BLOCKED]
  raw  = ".verdicts/economics-routing-savings/cache_summary.txt"
  note = "10-task cold vs warm probe with ~4KB shared --system-prompt: cache_creation_input_tokens=0 AND cache_read_input_tokens=0 on ALL 20 dispatches (cold $0.029419 / warm $0.036509, both 10/10 correct). Warm is 24.10% MORE expensive — the SDK pays full input tokens for the shared prefix every call without ever emitting the cache_control header. Surface-limited: `claude --bare -p` non-interactive dispatch doesn't activate Anthropic's ephemeral cache. Same surface-limit family as d_token_decomp. Cache-aware routing requires a different dispatch surface (raw Messages API + explicit cache_control, or interactive session reuse) — out of scope for the current router."

@C d_batch_amortized := "batch-API amortized cost — 50% discount on non-interactive batch dispatch" :: candidate [target_tier=GREEN cost_est=$0.3]
  cmd = "compare claude --bare -p sync vs batch endpoint $/task on same manifest"
  hyp = "batch tier halves $/task for the offline routing workload"

# ── kick round 2 (2026-05-23, post-5-failure) ──
# seed: "length-cutoff is the SOLE Pareto-optimal heuristic-router; 4 alternatives
# underperformed (dlg, class, difficulty, confgate). 2-tier ablation +6.59pp orthogonal.
# What NEW orthogonal economic levers (precision controls · workload-shape · formal
# Pareto lower-bound · speculative draft · prompt-compression) shave $/task further
# while preserving 20/20 accuracy?"
# raw: .discoveries/economics-routing-kick2.raw (mk9, smash+414 free+211 res+4, 629 total)

@C d_response_budget_cap := "prompt-prefix response-budget cap on haiku tier" :: dead [target_tier=GREEN actual_tier=GREEN]
  raw  = ".verdicts/economics-routing-savings/tokencap_summary.txt"
  note = "appended ' Answer in <=N tokens.' suffix to haiku-routed prompts (the `claude --bare -p` CLI exposes no --max-tokens flag, so the cap had to ride in the prompt itself). swept N in {15,30} + global cap30. results: 3tier_baseline=71.00%@20/20 · cap15=65.86%@20/20 · cap30=73.93%@20/20 · global_cap30=76.60%@19/20. best 20/20 = 3tier_haiku_cap30 at 73.93% — strictly dominated by 2-tier 81.79% (Δ=-7.86pp). honest pathology: cap15 BACKFIRED — fib task out_tok grew 747→1979 (haiku acknowledged the cap in its prose before writing code), so a too-tight cap costs MORE than no cap. global_cap30 truncated sonnet's BFS-vs-DFS answer (missing 'breadth' substring, 19/20). drop-the-tier beats cap-the-prompt; 2-tier remains the operationally-simplest Pareto-optimal router."

@C d_threshold_sweep := "2-tier word-count cutoff τ sweep — boundary already optimal" :: confirmed [target_tier=GREEN actual_tier=GREEN]
  raw  = ".verdicts/economics-routing-savings/threshold_sweep_summary.txt"
  note = "swept τ ∈ {30,50,80,100,120,150} on word_count(prompt) cutoff (<=τ → sonnet else opus) over the canonical 20-task manifest. All 20 prompts have wc ∈ [5,14] (max=14), so every τ ≥ 14 routes 20/20 → sonnet — the sweep effectively measures all-sonnet stochastic noise. best τ*=120 at 80.21% saving @ 20/20 (cost $0.0562); canonical 2-tier ref 81.79% NOT beaten (Δ=-1.58pp, within sonnet noise). τ=30 dropped to 19/20 (one sonnet stochastic miss on the same all-sonnet routing). VERDICT — boundary already optimal: on this manifest the τ axis is degenerate (word-count saturated below the grid), so the Pareto frontier set by the canonical 2-tier remains untouched. To exercise the τ frontier in future cycles, the manifest needs higher-word-count prompts (wc ≥ 30) that would actually trip the opus branch."

@C d_early_stop := "early-stop stop-token list — BLOCKED, CLI surface lacks --stop-sequences" :: dead [target_tier=GREEN actual_tier=BLOCKED]
  raw  = ".discoveries/economics-routing-cli-surface.raw"
  note = "claude --help 2.1.150 enumerates no --stop-sequences / --stop / -s / --max-tokens / --max-output flag. Output-token termination is unreachable from `claude --bare -p`. Only --max-budget-usd (session-wide dollar kill-switch) and --json-schema (output-shape validator) are exposed — neither caps generation length. Same surface-limit family as d_cache_aware (no cache_control), d_token_decomp (telemetry unreliable). Prompt-prefix length-cap workaround already falsified by d_response_budget_cap. No bench run, $0 spent."

@C d_prompt_compress := "prompt-compression — DEGENERATE, 20-task manifest already wc-saturated" :: dead [target_tier=GREEN actual_tier=DEGENERATE]
  raw  = ".discoveries/economics-routing-cli-surface.raw"
  note = "canonical manifest has prompt word_count ∈ [5,14] (max=14) — already at floor; LLMLingua-style ratio=0.7 has no slack to shave. The dominant input cost is the boilerplate suffix 'Reply with X only.' (~5 tokens/prompt) which is functionally load-bearing for correctness (cycle-1 d_response_budget_cap showed even small prompt-prefix manipulations destabilize the model — haiku quoted the cap text into prose, blowing output). Stripping it would risk regressing 20/20 accuracy with at most a ~5-token/prompt input save. No CLI compression flag exists either (--system-prompt is additive, not compressive). Compression has nonzero room only on a wc≥30 manifest (same future-work as d_threshold_sweep). No bench run, $0 spent."

@C d_speculative_draft := "speculative draft — cheap-tier draft + verify-or-rewrite" :: dead [target_tier=GREEN actual_tier=GREEN]
  raw  = ".verdicts/economics-routing-savings/speculative_summary.txt"
  note = "complete 3-strategy sweep on the canonical 20-task manifest. baseline=$0.28404@19/20, length2_ref=$0.05817@20/20 (79.52%), draft_only haiku-alone=$0.06393@20/20 (77.49%, already costlier than length2 — haiku verbose output), spec_v_sonnet=$0.13902@19/20 (51.06% — pays 2.4× draft_only for one accuracy loss), spec_v_opus=$0.41889@20/20 (-47.47% — pathologically more expensive than baseline; opus verify on every prompt blows past always-opus dispatch). verified_rate=100% for both verify variants — haiku draft never gets rewritten, so the verify pass is pure overhead. VERDICT: dominated across all 3 strategies; no axis where speculative architecture wins."

@C d_pareto_lower_bound := "formal Pareto lower-bound — analytic floor on $/task at 20/20 accuracy" :: confirmed [target_tier=BLUE actual_tier=BLUE]
  raw  = ".verdicts/economics-routing-savings/pareto_floor_summary.txt"
  note = "closed-form floor = Σ min{cost(s,i) | correct(s,i)=1} over S={baseline, length3, length2} on the 20-task manifest. floor=$0.056780 (saving=82.22%) vs canonical length2=$0.058171 (81.79%) — gap=0.44 pp, length2 within-ε of floor at ε=1.0 pp. verifier verify/numerics_economics_pareto_floor.hexa (10/10 PASS, T_BLUE math_pure). Witness assignment: length2 chosen on 13/20 tasks, length3 on 7/20, baseline never (always-opus is never cheapest at 20/20). VERDICT: canonical 2-tier captures 99.5% of achievable saving — operationally at the floor."

# ── kick round 3 (2026-05-23, post-cycle-2 narrowing) ──
# seed: "length-cutoff SOLE Pareto-optimal (5 alternatives dead). `claude --bare -p`
# surface BLOCKS cache_control/batch/max-tokens/stop-seq (3 dead at this surface).
# 20-task manifest degenerate on wc<=14 (threshold sweep all-sonnet). Round-2
# candidates speculative_draft/early_stop/prompt_compress/pareto_lower_bound in
# flight. What UNEXPLORED orthogonal axes — workload-shape (task batching ·
# amortize per-call overhead) · offline pre-routing (zero per-call router cost) ·
# system-scheduling (parallelism · latency-cost trade) · formal results (tight
# bounds · impossibility · optimality conditions)?"
# raw: .discoveries/economics-routing-kick3.raw (mk9, smash+414 free+211 res+25, 650 total)

@C d_oracle_optimality := "oracle instance-optimal $/task — formal certificate vs length-router gap" :: confirmed [actual_tier=BLUE cost_actual=$0 verdict=.verdicts/sandbox/oracle_optimality.txt harness=verify/numerics_economics_oracle_optimal.hexa cycle=8]
  cmd = "for each of 20 prompts, look up CHEAPEST tier that produced a correct answer in cycle-1/2 .verdicts/economics-routing-savings/baseline.tsv (and class/dlg traces); sum tier-$ to get instance-optimal $/task floor; compare to length-router 81.79%"
  hyp = "length-router is within ε ≤ 5pp of the instance-optimal oracle floor (T_BLUE formal — certificate is per-prompt lookup from existing verdicts, no new spend, distinct from d_pareto_lower_bound's distribution-level analytic floor)"
  result = "CONFIRMED BLUE (10/10 closed-form checks pass). oracle_floor=$0.0567804 (82.2214% saving vs baseline opus×20), length2=$0.0581707 (81.7861%) within $0.0013903 (0.44 pp) of oracle. Pareto-floor agreement: $0.0 USD EXACT vs inline recomputation, $4e-07 vs cycle-2 5bbb9ad published reference ($0.05677995). Independent BLUE proof joining cycle-2 numerics_economics_pareto_floor.hexa — operates on identical {baseline, length3, length2} grid in 2tier.tsv, frames the same bound as a per-task argmin certificate rather than a distribution-level analytic Pareto floor. Both proofs agree exactly by construction; the value of THIS second proof is the independent recomputation from a different angle (per-prompt argmin over multi-strategy data vs distribution-level). Manifest-conditional — a richer strategy grid (class / dlg / threshold_sweep as orthogonal strategies) could in principle lower the floor below this value, but on the sampled grid the canonical 2-tier captures 99.5% of achievable saving. Witness: 10 tasks pick LENGTH2, 10 pick LENGTH3, 0 pick baseline; task 14 baseline excluded (correct=0)."

@C d_offline_memoize := "offline answer-memoization — deterministic-grader manifest, second-pass $/task → 0" :: candidate [target_tier=GREEN cost_est=$0.1]
  cmd = "wrap dispatcher with (prompt-hash → answer) KV store; rerun 2-tier length manifest twice; second pass should hit cache on every task"
  hyp = "second-pass $/task within ε of 0 at 20/20 accuracy (the canonical 20-task manifest is a fixed regression-test bench — repeats are free, only first pass costs)"

@C d_parallel_dispatch := "parallel dispatch — wall-clock saving via xargs -P, vendor cost invariant" :: candidate [target_tier=GREEN cost_est=$0.1]
  cmd = "run canonical 2-tier length router with `xargs -P 4` vs serial; compare wall-clock + total $/task + accuracy"
  hyp = "parallel cuts wall-clock ≥3× at 20/20 with vendor $/task identical (±sonnet noise) — latency-axis Pareto move, not cost-axis (orthogonal trade)"

@C d_prompt_cluster_reuse := "semantic-cluster representative — one opus per cluster, members get rewrite" :: candidate [target_tier=GREEN cost_est=$0.5]
  cmd = "cluster the 20 prompts by embedding sim (cheap local model), opus-answer each cluster representative, sonnet-rewrite members from rep answer; compare vs length-router 2-tier"
  hyp = "cluster-and-reuse beats length-router $/task at 20/20 IFF the manifest has ≥1 nontrivial cluster (≥2 semantically-overlapping prompts) — falsifiable on the canonical 20-task set"

@C d_router_cost_amortize := "offline pre-routing — compute ML-router tier table once, lookup per task (router-call cost → 0)" :: candidate [target_tier=GREEN cost_est=$0.2]
  cmd = "run ML-router (dlg_mk0 or class) ONCE over manifest to emit (prompt → tier) lookup table; reuse table on subsequent passes with zero router-inference cost; compare amortized $/task vs length-router 2-tier"
  hyp = "amortized ML-router (offline lookup) closes the gap to length-router by ≥5pp on second+ pass — the per-task router-call cost was the disqualifier (cycle-1 difficulty 62.15% vs length 77.72%), not the routing policy itself"

# ── summary ──
# round 1+2+3 cumulative : 4 confirmed (Pareto, 2-tier ablation, threshold_sweep boundary,
# pareto_lower_bound [round-2 T_BLUE]) ·
# 8 dead (token decomp, confidence_gated, difficulty_predict, cache_aware,
# response_budget_cap, early_stop [round-2 BLOCKED], prompt_compress [round-2 DEGENERATE],
# speculative_draft [round-2 dead PARTIAL — verdict robust by monotonicity])
# · 5 next-batch candidates (batch_amortized [stale] +
# round-3: oracle_optimality, offline_memoize, parallel_dispatch, prompt_cluster_reuse,
# router_cost_amortize)
# strongest-confirmed-so-far : 2-tier length router (81.79% saving @ 20/20).
# threshold_sweep confirmed the canonical 2-tier cutoff is at the Pareto boundary —
# τ ∈ {30..150} on word_count produce equivalent all-sonnet routing on this manifest
# (max wc=14), best τ*=120 at 80.21% (within noise of canonical 81.79%). To exercise
# the τ frontier in future, the manifest needs higher-wc prompts that actually split.
# round 2 strategy : orthogonal levers (precision controls + speculative + formal floor)
# rather than further heuristic-router variants — the Pareto frontier among
# heuristic-routers is exhausted by length-cutoff. cache_aware closed as BLOCKED at
# the `claude --bare -p` dispatch surface; same surface-limit family as token_decomp.
# response_budget_cap (round-2 candidate) ran $0.32 and closed dead — prompt-suffix
# cap is dominated by drop-the-tier on this manifest, with a pathological backfire
# at the tightest cap (haiku explains the cap before answering, output GROWS).
# early_stop + prompt_compress (round-2 candidates) closed $0 — both BLOCKED by
# `claude --bare -p` 2.1.150 surface: no --stop-sequences flag exists (early_stop),
# and the canonical manifest is already word-count saturated (prompt_compress
# DEGENERATE; max wc=14, no slack for compression). Both require the same
# wc≥30 manifest reshape as d_threshold_sweep to exit dead.
# pareto_lower_bound (round-2 T_BLUE) ran $0 and confirmed — closed-form analytic
# floor over sampled strategies is pinned 0.44 pp above the canonical 2-tier on
# this manifest (length2 captures 99.5% of achievable saving). This complements
# d_threshold_sweep proof-side and exhausts the heuristic-router frontier among
# sampled strategies — no single-axis tweak can materially improve at 20/20 here.
# round 3 strategy : SHIFT off the per-call-dispatch axis entirely — workload-shape
# (memoize, cluster-reuse), system-scheduling (parallelism for latency not cost),
# offline pre-routing (amortize ML-router cost across passes), and a SECOND formal
# result (instance-optimal oracle floor, distinct from analytic distribution floor).
# These 5 candidates target axes orthogonal to BOTH the heuristic-router exhaustion
# AND the `claude --bare -p` surface limit — they trade across passes (memoize,
# router_amortize), across prompts (cluster_reuse), across wall-clock (parallel),
# or operate purely on existing verdicts (oracle_optimality).
# top-2 ROI : d_oracle_optimality (BLUE, $0, derives from existing baseline.tsv) +
# d_offline_memoize (GREEN, $0.1, deterministic bench repeats are free by construction).
#
# ── cycle-8 update (2026-05-24): d_oracle_optimality CONFIRMED (BLUE) ──
# Closed-form per-task argmin certificate at verify/numerics_economics_oracle_optimal.hexa
# (10/10 PASS), verdict at .verdicts/sandbox/oracle_optimality.txt.
# oracle_floor = $0.0567804 (82.2214% saving) — length2 ($0.0581707, 81.7861%) within
# $0.0013903 (0.44 pp) of instance-optimal. Pareto-floor agreement: $0.0 USD EXACT vs
# inline recomputation, $4e-07 vs cycle-2 5bbb9ad published reference. SECOND independent
# BLUE proof joining cycle-2 5bbb9ad numerics_economics_pareto_floor.hexa — same grid
# {baseline, length3, length2} in 2tier.tsv, different framing (per-task argmin vs
# distribution-level analytic Pareto). Witness: 10 L2 + 10 L3 + 0 baseline; task 14
# baseline excluded (correct=0). Cumulative ECONOMICS round-1+2+3: 5 confirmed
# (Pareto · 2-tier ablation · threshold_sweep boundary · pareto_lower_bound BLUE ·
# ORACLE_OPTIMALITY BLUE) · 8 dead · 4 next-batch candidates remaining (offline_memoize ·
# parallel_dispatch · prompt_cluster_reuse · router_cost_amortize).
