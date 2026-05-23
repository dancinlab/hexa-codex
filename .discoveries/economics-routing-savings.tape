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

@C d_confidence_gated := "confidence-gated routing — DLG conf < tau → opus, else cheap tier" :: dead [target_tier=GREEN actual_tier=GREEN]
  raw  = ".verdicts/economics-routing-savings/confgate_summary.txt"
  note = "swept tau in {0.6,0.7,0.8,0.9}; best = tau=0.9 at 55.59% saving @ 19/20 — strictly dominated by length (70.10% @ 20/20). Length-cutoff Pareto bound reinforced; no confgate point holds full 20/20 accuracy."

# ── next-batch candidates (kick levers, not yet run) ──

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
# this batch : 1 confirmed (Pareto) · 2 dead (token decomp, confidence_gated) · 4 next-batch candidates
# strongest-next has flipped — confidence-gated proved a dead end, no GREEN lever now
# has a known path to beat length. Remaining candidates (cache-aware, batch-amortized,
# 2-tier ablation, difficulty-predict) probe orthogonal axes, not the Pareto frontier.
