@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "sandbox-stage1plus"
  source = "hexa kick round 1 + SANDBOX.md Stage 1-4 expansion"
  date   = "2026-05-23"
  flow   = "discovery → next-batch CLAIMS.tape candidate → verify → .verdicts (cx_discovery continuous)"

# kick seed (round 1, mk9, smash+414 free+211 res+20, 645 total):
#   "SANDBOX just opened: self-hosted vLLM/llama.cpp measurement substrate to
#   bypass `claude --bare -p` 2.1.150 surface limits (cache_control, stop_seq,
#   max_tokens, batch BLOCKED) and reach Pareto floor + F-CODEX-1/2 empirical
#   landings. Stages 1-4 remain (tier persona, scale manifest N>=2000, revive
#   3 BLOCKED, empirical fit). What NEW orthogonal substrate-only economic
#   axes — logit calibration, prompt-distillation, retrieval-augmented
#   dispatch, model-level speculative decoding, continuous-batching cost
#   amortization, KV-prefix sharing, quantization-tier — does self-hosting
#   unlock that the API surface foreclosed?"
# raw: .discoveries/sandbox-kick1.raw

# ── SANDBOX.md ladder (Stage 0-4, inventoried) ──

@C d_stage0_poc := "PoC dispatch — OSS pretrained (Qwen2.5-0.5B) + llama.cpp on mac, accuracy floor on canonical 20-task manifest" :: confirmed [verified_tier=GREEN cost_actual=$0]
  cmd = "wire lm_foundry/tool/route_dispatch.hexa (claude + llama_cpp unified surface), run 20-task pass, measure accuracy + serving-cost telemetry"
  hyp = "OSS pretrained 0.5B-class model achieves >= 15/20 on the canonical manifest at $0 marginal vendor spend (electricity-only) — substrate viable as a Stage-1 base"
  verdict = ".verdicts/sandbox/stage0_accuracy_floor_summary.txt — 19/20 (95.0%), 26.13 s total wall, $0, usable_floor_reached=true; commit bfd2885"

@C d_stage1_persona := "tier-persona — single base + temperature/max-tok 3-tier (nano/mid/max mock haiku/sonnet/opus), seed-pinned determinism" :: dead-on-manifest [verified_tier=GREEN cost_actual=$0 status=manifest-degenerate]
  cmd = "instantiate 3 personas (nano: T=0 max_tok=32 / mid: T=0 max_tok=256 / max: T=0 max_tok=1024) over the Stage-0 base; rerun length-router 2-tier; compare $/task ratio vs the Anthropic 1:5:25 grid"
  hyp = "tier-ratio under self-hosting reproduces the cycle-1/2 length-router 81.79% saving rank-order within Spearman ρ >= 0.9 — substrate is a valid stand-in for the API surface"
  verdict = ".verdicts/sandbox/stage1_persona_summary.txt — nano 20/20, mid 20/20, max 20/20; tier_separation_observed=false; routing_simulation_viable=false; spread_tasks=0. Convention WORKS mechanically (dispatch + scorer parity), but is a NO-OP on this canonical 20-task manifest (saturated quality ceiling, even nano max_tok=32 + 'Answer in <=15 tokens.' produces correct short answers including the Stage 0 misses task 9/18). HONEST SIGNAL: Stage 2 (scaled stratified manifest, wc ∈ [5,200], N>=2000) is the BLOCKING dependency before any tier-routing simulation has signal. The persona convention is not falsified — it is unobservable on this manifest."

@C d_stage2_scale_manifest := "scale manifest — `.hexa` task generator emitting N >= 2000 stratified prompts, wc ∈ [5, 200]" :: confirmed [verified_tier=GREEN cost_actual=$0 verdict=.verdicts/sandbox/stage2_manifest_summary.txt]
  cmd = "write task_generator.hexa producing N=2000 prompts stratified across {arithmetic, code, recall, reasoning, summarization} × wc-bin {5-14, 15-30, 31-60, 61-120, 121-200}; serve via Stage-1 persona; capture per-task tier-routing + accuracy"
  hyp = "wc ∈ [15, 200] regime EXITS the cycle-2 d_threshold_sweep degeneracy (wc-saturated at 14) — at least one τ ∈ {30, 50, 80, 120} actually splits the manifest, exposing the τ-axis frontier"
  result = "CONFIRMED via bench/sandbox_stage2_manifest_gen.hexa (cycle-5, 2026-05-24). Pure-deterministic local generator (no RNG, no model) emits N=2000 prompts across 5 wc strata: wc_5_15 (n=400 wc_min=5 wc_max=11 mean=6.6), wc_16_30 (n=400 wc_min=18 wc_max=19 mean=18.5), wc_31_60 (n=400 wc_min=31 wc_max=57 mean=43.7), wc_61_100 (n=400 wc_min=63 wc_max=99 mean=78.8), wc_101_200 (n=400 wc_min=102 wc_max=194 mean=146.2). All 2000 prompts unique by parameter-grid construction. Viability gates: per_stratum_min_100=true, wc_ranges_non_overlap=true, stratification_viable=true. Template families: arithmetic (sum/product), 3-operand chain (a+b)*c, 4-operand chain (a+b)*c-d, with FILL clauses (12-entry pool) and SCAFFOLD preambles (6-entry pool) for length padding; overshoot-safe padder caps at stratum_max. Every prompt has a known-correct expected_kw substring; byte_exact_subset scorer-fragility on short kw (e.g. '12' substr-matches '120') is inherent to the existing scorer convention and documented in the cycle-5 log entry. Cost $0, wall <30s, deterministic re-runs. Stage 2 manifest-on-personas rerun (Stage 1 redo at scale) is a SEPARATE successor cycle; the generator is the prerequisite, not the measurement."
  successor = "d_stage1_persona_at_scale — re-run the 3-persona convention against the Stage 2 N=2000 manifest; if tier_separation_observed flips to true, length-router 2-tier reproduction recovers under SANDBOX (the cycle-1/2 81.79% saving claim becomes empirically replicable on the substrate)"

@C d_stage3_revive_blocked := "revive BLOCKED — cache_read · batch · stop_seq · max_tokens empirical under self-hosted surface" :: candidate [target_tier=GREEN cost_est=$0]
  cmd = "for each of {cache_read, batch, stop_seq, max_tokens}, run a controlled A/B on the Stage-2 scaled manifest with the lever ON vs OFF; reuse cycle-1/2 measurement harness (cost_usd column reconciles)"
  hyp = "at least 1 of the 4 cycle-2-BLOCKED levers crosses the actuality threshold (>= 5pp saving at 100% accuracy parity) on the Stage-2 manifest; the rest exit DEGENERATE rather than BLOCKED — surface-limit removed, the lever's true value-add is now measurable"

@C d_stage4_empirical_landing := "empirical landing — quality_scale · train_cost · infer_cost fit → F-CODEX-1/2" :: candidate [target_tier=BLUE cost_est=$50]
  cmd = "fit F-CODEX-1 (quality vs scale) on {Qwen2.5-0.5B, 1.5B, 3B, 7B} × Stage-2 manifest accuracy; fit F-CODEX-2 (cost vs scale) on serving-cost telemetry per scale; gate ECONOMICS v1.2.0/1.3.0 releases on the fit residuals"
  hyp = "F-CODEX-1 quality-scale exponent matches the dancinlab quality_scale ≈ 0.5 hypothesis within ε ≤ 0.1 across the 4 scale grid; F-CODEX-2 cost-scale is super-linear (exponent >= 1.1) — both empirical curves close the v1.2.0/1.3.0 verify gate"

# ── cycle-2 BLOCKED candidates revived by SANDBOX (re-inventoried with local cost_est) ──

@C d_cache_aware_local := "cache-aware dispatch — KV-cache reuse via vLLM/llama.cpp prefix cache (was BLOCKED on `claude --bare -p`)" :: candidate [target_tier=GREEN cost_est=$0]
  cmd = "Stage-2 manifest with vLLM `enable_prefix_caching=true` vs OFF; measure hit-rate on the shared --system-prompt prefix; compare $/task and tok/s"
  hyp = "self-hosted prefix-cache hits >= 80% on the shared system-prompt prefix at >= 2x tok/s versus cold — the cycle-1 d_cache_aware (BLOCKED on API surface, cache_creation/read = 0) recovers as an actual saving once surface limit is removed"

@C d_early_stop_local := "early-stop stop-token list — vLLM/llama.cpp `stop=` parameter (was BLOCKED on CLI)" :: confirmed [target_tier=GREEN cost_est=$0 verdict=.verdicts/sandbox/stage3_earlystop_local_summary.txt]
  cmd = "for the 20-task canonical manifest under Stage-1 persona, enable stop=['\\n\\n', 'Note:', 'Answer:'] on nano tier; compare output_tok and accuracy vs no-stop baseline"
  hyp = "nano-tier stop-token list cuts output_tok median by >= 30% at 0pp accuracy loss — d_response_budget_cap's pathological backfire (cycle-2: haiku quoting the cap into prose) disappears because stop= acts at the decoder level, not the prompt level"
  result = "CONFIRMED on Stage 3 PoC (bench/sandbox_stage3_earlystop_local.hexa). Best variant `stop_dot` (-r '.') cuts output_tok by 41.55% (14 → 8 avg, exceeds the ≥30% target) at 0pp accuracy loss (16/20 parity with `nostop`). Wall_ms reduced 30.64% on the warm-cache canonical run (50.0s → 34.7s). `stop_dblnl` (-r '\\n\\n') near-no-op because Qwen2.5-0.5B emits compact prose without paragraph breaks. `stop_eos_marker` (prompt prepends `Answer with \"FINAL: <answer>\".` + -r '\\n') is DEAD at 0/20 — `-r '\\n'` activates on the `assistant\\n` chat-template prefix itself, halting before any answer token is emitted; the lever is blocked at reverse-prompt-scope semantics, not at instruction-following. d_response_budget_cap-style backfire (cycle-2 haiku-quoting-cap pattern) NOT observed on Qwen — the prompt-prefix variant fails for a different reason (premature stop trigger), not for capability."

@C d_prompt_compress_local := "prompt-compression — LLMLingua local model on Stage-2 wc>=30 prompts (was DEGENERATE on wc<=14 manifest)" :: confirmed [target_tier=GREEN cost_est=$0 verdict=.verdicts/sandbox/stage3_maxtokens_cap_summary.txt scope=max_tokens_cap_only]
  cmd = "run LLMLingua-2 ratio=0.5 on the Stage-2 wc∈[31,200] strata; compare $/task and accuracy vs uncompressed; require the wc<=14 strata pass through uncompressed (degenerate floor)"
  hyp = "compression saves >= 15% input-token cost on wc>=30 strata at 0pp accuracy loss; cycle-2 d_prompt_compress (DEGENERATE) was a manifest-shape artifact, not a fundamental dead end — substrate change + manifest reshape jointly recover the axis"
  result = "CONFIRMED for the max_tokens-cap variant only (bench/sandbox_stage3_maxtokens_cap.hexa, cycle-4). NAMING MISMATCH disclosed: this slug was opened for LLMLingua-style input-side prompt compression; what's actually tested here is hard `-n N` max_tokens cap at the decoder layer — distinct lever (output-side truncation). The cycle-2 ancestor `d_response_budget_cap` was the prompt-prefix gimmick that backfired on haiku; -n is the structural replacement reachable only below the API surface. Stage 3 result on canonical 20-task manifest (Qwen2.5-0.5B): all 5 strategies (nocap=1024, cap256, cap128, cap64, cap32) score 16/20 — cap doesn't degrade accuracy at all on this manifest. Avg output_tok strictly decreasing 23→15→13→9→6 confirms decoder enforcement. cycle2_backfire_pathology_present=false (impossible at decoder layer — there's no prose channel for the model to quote the cap into). Wall_ms at cap32 vs nocap: 25662 vs 53018 = 51.59% reduction (single run, ~3x noise — informational only). HONEST: Stage 0's reported 19/20 ceiling was a scorer artifact — Stage 0 didn't strip llama.cpp's stderr `[end of text]+common_perf_print:` trailer, so substring scorer false-positive matched on perf-line digits (e.g. task 7 ans='6' kw='7' matched '7' from '/ 20 tokens'). Stage 3 strips that trailer; clean baseline = 16/20. Same 4 failures (idx 7,9,10,18) across all caps. LLMLingua input-side compression remains UNMEASURED — defer to a future Stage 2 cycle on the wc>=30 scaled manifest if pursued (true input-compression slug should be opened separately rather than reusing this one)."

# ── kick round 1 new orthogonal axes (substrate-unlocked, not in SANDBOX.md ladder) ──

@C d_logit_calibration := "logit calibration — first-token logprob margin (top1−top2) as confidence signal, substrate revival of cycle-2 d_confidence_gated" :: confirmed [verified_tier=GREEN cost_actual=$0 verdict=.verdicts/sandbox/stage3_logit_calibration_summary.txt]
  cmd = "expose llama-server /v1/chat/completions logprobs=true + top_logprobs=5 on Stage-0 base; per-task first-token margin = logprob[top1]−logprob[top2]; quartile-bin tasks by margin; compare top-q accuracy vs bottom-q accuracy on canonical 20-task manifest"
  hyp = "first-token logprob margin correlates with answer correctness — top-margin quartile accuracy exceeds bottom-margin quartile accuracy by >= 20% of overall accuracy (margin_corr_signal threshold). Cycle-2 d_confidence_gated (dead at 55.59% / 19/20) failed on UNCALIBRATED heuristic DLG-mk0 score, NOT model logits; raw model logits are the missing signal"
  result = "CONFIRMED on Stage 3 PoC (bench/sandbox_stage3_logit_calibration.hexa, cycle-5). llama_cpp_logprob_surface_exposed=true via HTTP server (CLI surface llama-cli/llama-completion does NOT expose top-N logprobs; only /v1/chat/completions with logprobs=true · top_logprobs=5 does — recorded in .discoveries/sandbox-logprob-flags.raw). top_quartile_accuracy=100.0% (5/5) · bottom_quartile_accuracy=60.0% (3/5) · overall_accuracy=75.0% (15/20, cleaner baseline than cycle-4's 16/20 — task 6 'smallest prime'→'1' now correctly fails where stage3_maxtokens_cap scored it correct via the kw='2' false-positive on '1, 2, 3' enumerations) · margin_corr_signal=53.33% · calibration_signal_present=true. Top-5 margins 7.17, 3.99, 3.96, 3.77, 3.75 — all correct; bottom-5 margins 0.19, 0.40, 0.57, 0.72, 0.96 — 3 correct, 2 wrong. Cycle-2 d_confidence_gated substrate revival CONFIRMED — the signal exists on model logits where the heuristic classifier missed it."
  verdict_ref = ".verdicts/sandbox/stage3_logit_calibration_summary.txt"
  vs_cycle2_d_confidence_gated = "cycle-2 BLOCKED at heuristic surface (commit 5d5b7d2): best confgate τ=0.9 saved 55.59% @ 19/20, strictly dominated by length-cutoff 70.10% @ 20/20 (.verdicts/economics-routing-savings/confgate_summary.txt). cycle-5 CONFIRMED at model-logit surface: margin_corr_signal=53.33%, signal_present=true. Substrate revival WORKS — calibration is real."
  honest_limit_1 = "N=20 with 5 wrong rows; quartile delta is power-limited. Direction + magnitude only, no p-value claim. Stage 2 manifest N>=2000 needed for proper signal test + Platt-scaling fit."
  honest_limit_2 = "Saving-% number is NOT reported — there is no stronger tier in SANDBOX yet (d_stage1_persona dead-on-manifest, all 3 personas score 20/20). d_logit_calibration confirms the SIGNAL exists; integrating with a routing policy (Qwen for high-margin, escalate for low-margin) requires Stage 1 multi-base (d_quantization_tier candidate) or Stage 4 multi-scale grid before $/task delta becomes measurable."

@C d_kv_prefix_share := "KV-prefix sharing — llama.cpp --prompt-cache / --prompt-cache-ro on shared 376-token prefix" :: dead [actual_tier=BLOCKED_AT_SCALE cost_actual=$0]
  cmd = "bench/sandbox_stage3_kvprefix.hexa — cold (no cache) vs warm (task[0] writes cache, task[1..19] read-only) on canonical 20-task manifest with shared 376-token prefix; .verdicts/sandbox/stage3_kvprefix.tsv + _summary.txt"
  hyp = "KV-prefix sharing reduces amortized prefill cost by >= (1 - 1/B) of the system-prompt token count on a batch size B — substrate-only lever orthogonal to per-prompt routing policy (combines additively with length-router); cycle-1 d_batch_amortized (50% batch-tier discount, never measured) is subsumed and superseded by this finer-grained surface"
  result = "llama.cpp build 9150 DOES expose --prompt-cache / --prompt-cache-all / --prompt-cache-ro (evidence: .discoveries/sandbox-llama-cache-flags.raw). Bench ran 2 strategies × 20 tasks. accuracy_cold = accuracy_warm = 19/20 (cache replay bit-identical at model level — no behavior drift). cache_file_size = 4,725,349 bytes (~4.7 MB) on disk for 376-token prefix. BUT warm_speedup_pct = -6.15% (warm 6576ms/task vs cold 6195ms/task, after first cache-write). Per-invocation model-load (~3-4s Metal init + GGUF mmap) DOMINATES the 530ms prefix-eval saving. Lever is real, accuracy-safe, and substrate-exposed — but degenerate at one-shot CLI dispatch on a 0.5B model. Would require either (a) a persistent server (llama-server with --cache-prompt) to amortize model-load across calls, or (b) a much longer prefix (>= few-thousand tokens) where prefix-eval dominates startup."
  verdict_ref = ".verdicts/sandbox/stage3_kvprefix_summary.txt"
  successor = "d_kv_prefix_share_persistent — llama-server long-lived process + shared prefix HTTP API (--cache-prompt enabled by default); defers per-call model-load, isolates the prefix-eval saving"
  vs_cycle2_d_cache_aware = "cycle-2 BLOCKED at claude --bare -p: warm_saving_pct = -24.10% (no cache_control flag exposed AT ALL). cycle-4 BLOCKED_AT_SCALE: warm_speedup_pct = -6.15% (flag IS exposed and works — cache written, prefix replayed bit-identical), but per-process model-load dwarfs the saving. Cycle-4 narrowed the blocker class: surface-limit -> scale-limit (one-shot CLI dispatch)."

@C d_speculative_decode_model := "model-level speculative decoding — small draft (0.5B) + verify on large target (7B), token-level (NOT cycle-2 tier-level)" :: candidate [target_tier=GREEN cost_est=$0]
  cmd = "wire llama.cpp `--draft-model` (Qwen2.5-0.5B drafts Qwen2.5-7B target) on Stage-2 wc>=30 strata; measure tok/s and $/task vs target-only"
  hyp = "model-level speculative decoding cuts wall-clock $/task by >= 30% on wc>=30 strata at bit-for-bit identical output (verify-exact) — cycle-2 d_speculative_draft was tier-level architecture (haiku draft + sonnet verify-or-rewrite, dominated $0.139@19/20); model-level speculation is an ENTIRELY different mechanism only reachable below the API"

@C d_quantization_tier := "quantization-tier — Q4_K_M vs Q8_0 vs FP16 as a 3rd routing axis (cost ∝ memory bandwidth, not tokens)" :: candidate [target_tier=GREEN cost_est=$0]
  cmd = "serve 3 quants of the Stage-1 base via llama.cpp, treat as nano/mid/max alternative; rerun length-router 2-tier with (Q4, FP16) cutoff vs the persona 2-tier; compare $/task + accuracy"
  hyp = "quantization-tier router (Q4 below cutoff / FP16 above) matches or beats persona-tier saving on the Stage-2 manifest at <= 1pp accuracy drop — an axis the API surface does not expose at all (vendor abstracts the quant) and a candidate for F-CODEX-2 cost-scale enrichment"

# ── kick round 2 — post-cycle-4 substrate-server axes (long-lived process unlocks) ──
# kick seed (round 2, mk9, smash+414 free+211 res+17, 642 total):
#   "SANDBOX cycle-4 narrowed: (1) manifest saturated at 20 tasks blocks Stage1
#   persona until Stage2 N>=2000 lands; (2) revivals work — stop_dot -30.64%
#   wall, max_tokens cap -51.59%; (3) one-shot CLI dispatch has ~3-4s
#   Metal-init+mmap floor that swamps fine-grained KV/cache (kv_prefix
#   BLOCKED_AT_SCALE); (4) scorer artifacts inflate accuracy. What axes does
#   long-lived llama-server unlock — continuous batching across N=2000,
#   persistent KV across multi-turn, --json-schema constrained decoding,
#   parallel dispatch on local Metal?"
# raw: .discoveries/sandbox-kick2.raw (engine output is symbolic atlas-atom
# expansion; the 4 substrate-server axes below are the curator distillation
# of the seed's enumerated hypothesis space, matching round-1 methodology).

@C d_kv_prefix_share_persistent := "KV-prefix sharing via long-lived llama-server — amortize Metal-init+mmap across the N=2000 manifest, isolate the prefix-eval saving" :: candidate [target_tier=GREEN cost_est=$0 source=cycle-4-successor]
  cmd = "spawn `llama-server -m Qwen2.5-0.5B.Q4_K_M.gguf -c 4096 --cache-prompt --parallel 1` once; dispatch 20-task canonical + Stage-2 manifest via HTTP `/completion` (shared 376-tok prefix in `system_prompt`); measure per-task wall_ms with cold-server vs warm-server vs warm-server-with-cache rows; reuse cycle-4 stage3_kvprefix scorer (trailer-strip)"
  hyp = "removing the ~3-4s per-call Metal-init+mmap floor recovers the 530ms prefix-eval saving cycle-4 measured but couldn't amortize — `warm_speedup_pct` flips from -6.15% (CLI one-shot) to >=+20% (server persistent) at accuracy_warm == accuracy_cold; failure mode if false = HTTP overhead or token-streaming SSE latency dominates the saving (different blocker class — wire-protocol limit, not surface or scale)"
  note = "cycle-4 successor surfaced by `d_kv_prefix_share` BLOCKED_AT_SCALE verdict, NOT generated by hexa kick — honest disclosure"

@C d_continuous_batching_server := "continuous batching — llama-server `--parallel N` slots evaluating B prompts concurrently on shared Metal context, amortize prefill across batch" :: candidate [target_tier=GREEN cost_est=$0]
  cmd = "spawn `llama-server -m Qwen2.5-0.5B.Q4_K_M.gguf -np 4 -c 16384 --cache-prompt`; fire B={1,2,4,8} concurrent HTTP `/completion` requests across Stage-2 N=2000 manifest; measure aggregate tok/s and per-task wall_ms at each B; require accuracy parity vs B=1 baseline"
  hyp = "tok/s scales sub-linearly with batch slots (>=1.5x at B=4, >=2.5x at B=8) on the local Metal substrate at accuracy bit-identical to B=1 — cycle-1 d_batch_amortized (50% batch-tier discount, BLOCKED at `claude --bare -p` because the CLI is single-shot) recovers as a measurable speedup once batching is below the API surface; failure mode if false = mac mini M3 Metal context is memory-bound on a 0.5B model, no headroom for true concurrency (Apple Silicon UMA contention)"

@C d_json_schema_constrained := "JSON-schema constrained decoding — llama-server `--json-schema` / grammar-based token filtering cuts wall_ms by skipping invalid-token sampling" :: candidate [target_tier=GREEN cost_est=$0]
  cmd = "on Stage-2 manifest's `code`+`arithmetic` strata where output is structured (e.g. `{\"answer\": <int>}`), invoke llama-server `/completion` with `json_schema={...}` vs nostop baseline; measure output_tok, wall_ms, accuracy (parse-then-byte_exact_subset on the `answer` field); compare to cycle-4 stop_dot baseline on the same strata"
  hyp = "constrained decoding cuts output_tok by >= 50% AND wall_ms by >= 20% on structured-output strata at >= 0pp accuracy improvement (constrained sampling cannot emit invalid tokens, so parseable-output failure mode disappears) — a lever the `claude --bare -p` API does not expose at all (only the SDK's `response_format`, untestable from CLI); orthogonal to stop_dot (decoder-level vs syntactic-mask level)"

@C d_parallel_dispatch_local := "parallel CLI dispatch — fan out N llama-completion processes via xargs -P or .hexa concurrent dispatch on Stage-2 manifest" :: candidate [target_tier=GREEN cost_est=$0]
  cmd = "revisit cycle-2 BLOCKED `d_parallel_dispatch` on local Metal: `xargs -P 4 -n 1 llama-completion ...` (or .hexa equivalent) across Stage-2 manifest; measure wall_ms with P={1,2,4,8} concurrency and per-process Metal-init+mmap overhead; compare to `d_continuous_batching_server` (same target speedup, different mechanism — N processes vs 1 process N slots)"
  hyp = "process-level parallelism saturates at P=2-4 on mac mini M3 (each process pays full ~3-4s init+mmap independently — total memory >= P × 379MB GGUF + Metal context) — useful as a control comparison for `d_continuous_batching_server`; if server-mode hits >=2.5x at B=8 but processes only hit 1.5x at P=4, the saving is attributable to context-sharing rather than mere concurrency; failure mode = thermal throttling or VRAM contention caps speedup at <1.3x (UMA-bound)"

# ── summary ──
# round 1+2+3 cumulative: 5 confirmed (d_stage0_poc · d_early_stop_local · d_prompt_compress_local[max_tokens_cap_only] · d_logit_calibration · d_stage2_scale_manifest) · 2 dead (d_stage1_persona dead-on-manifest · d_kv_prefix_share BLOCKED_AT_SCALE) · 9 candidates remaining
# round 3 (cycle-5, 2026-05-24): d_stage2_scale_manifest CONFIRMED via
# bench/sandbox_stage2_manifest_gen.hexa — pure-deterministic local generator
# (no RNG, no model) emits N=2000 prompts across 5 wc strata in [5, 200] at
# $0 cost; per_stratum_min_100=true, wc_ranges_non_overlap=true,
# stratification_viable=true; 2000 unique prompts (no dedup needed —
# parameter-grid construction). Verdict:
# .verdicts/sandbox/stage2_manifest_summary.txt. Manifest:
# .verdicts/sandbox/stage2_manifest.tsv. Unblocks the Stage 1
# dead-on-manifest finding's BLOCKING dependency: every downstream
# tier-routing simulation (d_stage1_persona_at_scale successor,
# d_cache_aware_local, d_logit_calibration $/task gate,
# d_kv_prefix_share_persistent, d_quantization_tier) can now exercise
# wc-bin separation that the canonical 20-task manifest saturates.
# Honest residual: byte_exact_subset scorer fragility on short kw
# inherent to existing scorer convention, NOT new to Stage 2.
# Also (cycle-5, 2026-05-24): d_logit_calibration CONFIRMED via llama-server
# /v1/chat/completions logprobs=true + top_logprobs=5 (CLI surface does NOT
# expose; HTTP server endpoint does). First-token margin (top1−top2) on
# canonical 20-task manifest: top_quartile_accuracy=100.0% (5/5), bottom_quartile_accuracy=60.0% (3/5),
# margin_corr_signal=53.33% (threshold 20.00%), signal_present=true. Cycle-2
# d_confidence_gated (heuristic DLG-mk0 surface, 55.59% saving @ 19/20 strictly
# dominated by length-cutoff 70.10% @ 20/20) SUBSTRATE REVIVAL CONFIRMED — the
# signal exists on model logits where the heuristic missed it. Saving-% NOT
# reported (no stronger tier in SANDBOX yet; integration requires Stage 1
# multi-base or Stage 4 multi-scale grid before $/task delta is measurable).
# Verdict: .verdicts/sandbox/stage3_logit_calibration_summary.txt. Bench:
# bench/sandbox_stage3_logit_calibration.hexa. CLI-flag probe persisted:
# .discoveries/sandbox-logprob-flags.raw.
#   5 SANDBOX.md ladder (d_stage0_poc ✓ confirmed · d_stage1_persona ✗ dead-on-manifest · d_stage2..4 candidate)
# + 3 cycle-2 BLOCKED revivals (d_cache_aware_local candidate · d_early_stop_local ✓ confirmed · d_prompt_compress_local ✓ confirmed[max_tokens_cap_only])
# + 4 kick round-1 orthogonal axes (d_logit_calibration, d_kv_prefix_share dead,
#     d_speculative_decode_model, d_quantization_tier)
# d_prompt_compress_local CONFIRMED 2026-05-23 (scope=max_tokens_cap_only,
# NOT LLMLingua input-compression — slug naming mismatch disclosed inline):
# hard `-n 32` cap holds 16/20 (full parity with nocap=1024) at avg
# output_tok 6 vs 23 (-73.9% output_tok); wall_ms 25662 vs 53018 = 51.59%
# reduction (single run, ~3x noise — informational only).
# cycle2_backfire_pathology_present=false (structurally impossible at decoder
# layer — no prose channel for the model to quote the cap into). Verdict:
# .verdicts/sandbox/stage3_maxtokens_cap_summary.txt. Bench:
# bench/sandbox_stage3_maxtokens_cap.hexa. HONEST: revealed that Stage 0's
# reported 19/20 baseline was a scorer artifact (stderr `[end of text]` +
# `common_perf_print:` trailer leaked into substring scorer; cleaned baseline
# = 16/20). True LLMLingua input-side compression remains UNMEASURED.
#
# d_early_stop_local CONFIRMED 2026-05-23: stop_dot (-r '.') -41.55% output_tok
# / -30.64% wall_ms @ 16/20 accuracy parity (cycle-4 d_early_stop_local task).
# Verdict: .verdicts/sandbox/stage3_earlystop_local_summary.txt. Bench:
# bench/sandbox_stage3_earlystop_local.hexa. The cycle-2 d_response_budget_cap
# haiku-quoting-cap backfire was NOT replicated on Qwen2.5-0.5B: the
# prompt-prefix variant (stop_eos_marker) failed 0/20 for an orthogonal reason
# (reverse-prompt scope: -r '\n' fires on the `assistant\n` chat-template
# prefix itself before any answer is emitted), not for capability.
# Stage 1 flipped to dead-on-manifest (NOT falsified): convention dispatch +
# scorer parity work; all 3 personas score 20/20 on the canonical 20-task
# manifest. tier_separation_observed=false, spread_tasks=0,
# routing_simulation_viable=false. Top ROI is now d_stage2_scale_manifest —
# without it, d_stage1_persona's value-add cannot be observed and every
# downstream tier-routing candidate (d_cache_aware_local, d_logit_calibration,
# d_kv_prefix_share, d_quantization_tier) inherits the same observability gap.
# 0 candidates duplicated from .discoveries/economics-routing-savings.tape;
# revivals use `_local` suffix to differentiate from the cycle-2 BLOCKED entries
# (which remain dead at the `claude --bare -p` surface).
# strongest-confirmed-so-far: none — SANDBOX is freshly opened, all entries are
# candidate-state pending Stage-0 PoC accuracy floor.
# top-2 ROI: d_stage0_poc (GREEN, $0, gates the whole substrate — unlocks
# everything downstream) + d_kv_prefix_share (GREEN, $0, finest-grained
# replacement for cycle-1 d_batch_amortized, combines additively with the
# already-confirmed length-router 2-tier policy).
# round 1 strategy: inventory-first. SANDBOX just opened; the 5-stage ladder
# defines what unlocks, the 3 BLOCKED revivals define what cycle-2 left on
# the table, and the 4 kick-1 axes (logit calibration, KV-prefix share,
# model-level speculation, quantization-tier) cover the substrate-unlocked
# orthogonals NOT in the original SANDBOX.md ladder. Six other seed axes
# (prompt-distillation, retrieval-augmented dispatch, continuous-batching
# cost amortization, etc.) deferred — distillation pinned by SANDBOX.md
# §"Honesty rules" (Anthropic ToS), retrieval/continuous-batching are
# manifest-scale levers redundant with d_stage2_scale_manifest + d_kv_prefix_share.
#
# round 2 strategy: post-cycle-4 narrowing. Cycle-4 revealed (a) manifest
# saturation blocks Stage 1, (b) revivals work (stop_dot, max_tokens cap),
# (c) one-shot CLI dispatch has a fixed ~3-4s Metal-init+mmap floor that
# swamps fine-grained KV/cache savings (kv_prefix BLOCKED_AT_SCALE), and
# (d) scorer artifacts inflate baselines. (c) opens an entirely new axis
# class — long-lived server-mode dispatch (llama-server). 4 new candidates
# inventoried: d_kv_prefix_share_persistent (cycle-4 direct successor, NOT
# kick-surfaced — honest disclosure), d_continuous_batching_server (revives
# cycle-1 d_batch_amortized via `-np N` slots), d_json_schema_constrained
# (substrate-only lever the CLI surface doesn't expose), and
# d_parallel_dispatch_local (control comparison for server-mode batching).
# round-2 deferred from the seed enumeration: continuous-batching cost
# amortization is folded into d_continuous_batching_server (same lever);
# prompt-distillation and retrieval-augmented dispatch remain blocked by
# Honesty rules + manifest-scale dependency. Round-1 candidates revisited
# but kept (no slug duplication): d_logit_calibration still pending Stage 2;
# d_speculative_decode_model and d_quantization_tier orthogonal to server-mode.
# Top-2 ROI (round 2): d_kv_prefix_share_persistent (GREEN, $0, directly
# rescues cycle-4 BLOCKED_AT_SCALE — only candidate with prior empirical
# narrowing of the blocker class) + d_continuous_batching_server (GREEN, $0,
# subsumes cycle-1 d_batch_amortized 50%-discount claim with a measurable
# substrate-level mechanism; requires Stage 2 manifest to fully exercise).
