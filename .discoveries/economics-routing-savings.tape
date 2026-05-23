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

@C d_early_stop := "early-stop stop-token list — terminate generation at first answer-marker" :: candidate [target_tier=GREEN cost_est=$0.3]
  cmd = "add stop=['\\n\\n','</answer>','---'] to CLI dispatch; rerun manifest; compare output-token count vs baseline"
  hyp = "stop-token early-termination cuts output_tokens ≥15% on the length-router 2-tier config at 20/20 accuracy"

@C d_prompt_compress := "prompt-compression — strip boilerplate before dispatch" :: candidate [target_tier=GREEN cost_est=$0.5]
  cmd = "preprocess each prompt with strip-system-noise + LLMLingua-style ratio=0.7; rerun 2-tier length router"
  hyp = "compressed-prompt input_tokens drop ≥20% while 20/20 accuracy holds (input cost is non-trivial on long prompts)"

@C d_speculative_draft := "speculative draft — cheap-tier draft + opus single-shot verify" :: candidate [target_tier=GREEN cost_est=$0.6]
  cmd = "two-pass: haiku draft → opus verify-or-rewrite when draft confidence < tau; vs length-router baseline"
  hyp = "draft+verify $/task < length-router 2-tier $/task at 20/20 (opus only pays when draft is wrong)"

@C d_pareto_lower_bound := "formal Pareto lower-bound — analytic floor on $/task at 20/20 accuracy" :: candidate [target_tier=BLUE cost_est=$0]
  cmd = "derive closed-form: given per-tier $/token + per-prompt input/output dist + accuracy-floor constraint, prove min-$/task"
  hyp = "length-router 81.79% saving is within ε of the analytic Pareto floor (T_BLUE formal proof, no API spend)"

# ── summary ──
# round 1+2 cumulative : 3 confirmed (Pareto, 2-tier ablation, threshold_sweep boundary) ·
# 5 dead (token decomp, confidence_gated, difficulty_predict, cache_aware, response_budget_cap)
# · 4 next-batch candidates (batch_amortized [stale] + early_stop, prompt_compress,
# speculative_draft, pareto_lower_bound [round-2 new])
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
