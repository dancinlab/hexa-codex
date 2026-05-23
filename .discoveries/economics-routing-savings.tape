@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "economics-routing-savings"
  source = "hexa kick (mk9, round 1, 651 total) + Pareto re-analysis of cycle-1/2 data"
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

# ── next-batch candidates (kick levers, not yet run) ──

@C d_confidence_gated := "confidence-gated routing — DLG conf < tau → opus, else cheap tier" :: candidate [target_tier=GREEN cost_est=$0.5]
  cmd = "new bench strategy: pick_tier = opus if dlg_confidence < tau else dlg_tier; sweep tau"
  hyp = "may let DLG beat length when it abstains correctly on hard prompts"

@C d_difficulty_predict := "per-task difficulty score → tier (length × keyword × output-len prior)" :: candidate [target_tier=GREEN cost_est=$0.5]
  cmd = "composite difficulty heuristic vs pure length; same 20-task manifest"
  hyp = "a 2-feature score may shave the 1 misroute length makes at scale"

@C d_cache_aware := "cache-aware dispatch — repeat-prefix prompts → cache-warm tier" :: candidate [target_tier=GREEN cost_est=$0.3]
  cmd = "measure cache_read_input_tokens effect; route warm-prefix batches to cheaper effective cost"
  hyp = "system-prompt-shared workloads have near-zero marginal input cost"

@C d_batch_amortized := "batch-API amortized cost — 50% discount on non-interactive batch dispatch" :: candidate [target_tier=GREEN cost_est=$0.3]
  cmd = "compare claude --bare -p sync vs batch endpoint $/task on same manifest"
  hyp = "batch tier halves $/task for the offline routing workload"

@C d_two_tier_ablation := "2-tier (sonnet/opus) vs 3-tier (haiku/sonnet/opus) ablation" :: candidate [target_tier=GREEN cost_est=$0.3]
  cmd = "drop haiku from router; does losing the cheapest tier cost much?"
  hyp = "haiku contributes little when most prompts route to sonnet anyway"

# ── summary ──
# this batch : 1 confirmed (Pareto) · 1 dead (token decomp) · 5 next-batch candidates
# strongest next : d_confidence_gated (only lever with a path to beat length)
