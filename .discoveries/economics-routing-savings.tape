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

@C d_cache_aware := "cache-aware dispatch — repeat-prefix prompts → cache-warm tier" :: candidate [target_tier=GREEN cost_est=$0.3]
  cmd = "measure cache_read_input_tokens effect; route warm-prefix batches to cheaper effective cost"
  hyp = "system-prompt-shared workloads have near-zero marginal input cost"

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

@C d_response_cap := "response-length cap — max_tokens budget per tier shaves output cost" :: candidate [target_tier=GREEN cost_est=$0.4]
  cmd = "re-run 20-prompt manifest with max_tokens={64,128,256} per length-router tier; measure accuracy × $/task"
  hyp = "tightening max_tokens on the cheap-tier branch reduces $/task ≥10% without dropping 20/20 (verbose tail is wasted budget)"

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
# round 1+2 cumulative : 2 confirmed (Pareto, 2-tier ablation) · 3 dead (token decomp,
# confidence_gated, difficulty_predict) · 7 next-batch candidates (cache_aware,
# batch_amortized [stale, parallel agents] + response_cap, early_stop, prompt_compress,
# speculative_draft, pareto_lower_bound [round-2 new])
# strongest-confirmed-so-far : 2-tier length router (81.79% saving @ 20/20).
# round 2 strategy : orthogonal levers (precision controls + speculative + formal floor)
# rather than further heuristic-router variants — the Pareto frontier among
# heuristic-routers is exhausted by length-cutoff.
