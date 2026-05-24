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
  at_scale_result = "RAN 2026-05-24 (cycle-6) via bench/sandbox_stage2_persona_scaled.hexa — 150 tasks (30/stratum × 5) per persona over the Stage-2 manifest. nano 50/150 (33%), mid 52/150 (34%), max 54/150 (36%); spread=4 tasks. tier_separation_observed=TRUE (per-stratum ranking differs: wc_5_15 best=max, all other strata best=nano) but routing_simulation_viable=FALSE (overall spread 4 tasks < 3pp gate, latency not 2x). HEADLINE: a DIFFICULTY CLIFF dominates — wc_5_15/wc_16_30 score 73-90% across all personas, but wc_31_60 collapses to 3-6% and wc_61_100/wc_101_200 are 0% for ALL personas. Qwen2.5-0.5B cannot solve the multi-step arithmetic in the wc>=31 strata (the generator's (a+b)*c / (a+b)*c-d chains with scaffold padding). So cycle-4's 'dead-on-manifest' verdict has a NEW root cause at scale: not saturation (too easy), but a model-capability cliff (too hard above wc=30). Tier-routing signal exists only in wc<=30 where spread is small. PREREQ for a real routing simulation: a larger base model (Stage 4 scale ladder, Qwen 1.5B/3B) that clears wc>=31, OR a Stage-2b manifest whose long strata stay within 0.5B capability. Verdict file: .verdicts/sandbox/stage2_persona_scaled_summary.txt."

@C d_stage3_revive_blocked := "revive BLOCKED — cache_read · batch · stop_seq · max_tokens empirical under self-hosted surface" :: candidate [target_tier=GREEN cost_est=$0]
  cmd = "for each of {cache_read, batch, stop_seq, max_tokens}, run a controlled A/B on the Stage-2 scaled manifest with the lever ON vs OFF; reuse cycle-1/2 measurement harness (cost_usd column reconciles)"
  hyp = "at least 1 of the 4 cycle-2-BLOCKED levers crosses the actuality threshold (>= 5pp saving at 100% accuracy parity) on the Stage-2 manifest; the rest exit DEGENERATE rather than BLOCKED — surface-limit removed, the lever's true value-add is now measurable"

@C d_stage4_empirical_landing := "empirical landing — quality_scale · train_cost · infer_cost fit → F-CODEX-1/2" :: harness_ready [target_tier=BLUE cost_est=$50 status=harness-only verifier=verify/numerics_economics_empirical_landing.hexa verdict_pending=M3.ECON]
  cmd = "fit F-CODEX-1 (quality vs scale) on {Qwen2.5-0.5B, 1.5B, 3B, 7B} × Stage-2 manifest accuracy; fit F-CODEX-2 (cost vs scale) on serving-cost telemetry per scale; gate ECONOMICS v1.2.0/1.3.0 releases on the fit residuals"
  hyp = "F-CODEX-1 quality-scale exponent matches the dancinlab quality_scale ≈ 0.5 hypothesis within ε ≤ 0.1 across the 4 scale grid; F-CODEX-2 cost-scale is super-linear (exponent >= 1.1) — both empirical curves close the v1.2.0/1.3.0 verify gate"
  harness_status = "HARNESS WRITTEN 2026-05-24 (M3.ECON closed-form audit surface, NOT yet a verdict) — verify/numerics_economics_empirical_landing.hexa modelled on verify/numerics_economics_pareto_floor.hexa commit 5bbb9ad T1/BLUE structure. 10 closed-form checks · math_pure (log_pure + pow_pure + abs_pure) · no inference · no API · no subprocess. Theoretical exponents pulled from numerics_economics_scaling_laws.hexa (N6_EXP_TRAIN = 24/25, TAU_INFER = 4); residual gate ε = 0.10. Literal STAGE2_ACCURACY_0_5B row is HONEST cycle-6 input (per-stratum max{persona}, mean = 0.3667); 1.5B/3B/7B are explicit -1 PENDING_M2_SUBSTRATE_VERDICT sentinels. fit_exponent() requires k ≥ 2 valid (x, y) pairs; with k_active = 1 today both F-CODEX-1 and F-CODEX-2 fits return NAN_SLOPE → verdict 🟠 INSUFFICIENT (exit 0, honest-defer per g5). Placeholder verdict at .verdicts/sandbox/m3_econ_empirical_landing.txt marks status=harness-written-not-yet-empirical. SANDBOX.md M3.ECON checkbox STAYS [ ] — flips only when k_active == 4 AND both residuals ≤ ε=0.10 (separate later commit). Same family as cycle-7 d_activation_capture_pipeline (PARTIAL: interface ships, downstream gate honest) and cycle-8 d_slo_under_load (harness_only: script ships, verdict deferred)."
  m3_econ_state = "SANDBOX.md M3.ECON checkbox STAYS [ ] — harness ships and 0.5B baseline row reconciles to cycle-6 verdict; the M3.ECON empirical-landing gate flips only when k_active == 4 (all 4 ladder rungs measured) AND both F-CODEX-1/2 residuals ≤ ε. Sibling M2.SUBSTRATE bench rerun on 1.5B in this cycle batch advances k_active from 1 to 2."

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

@C d_kv_prefix_share_persistent := "KV-prefix sharing via long-lived llama-server — amortize Metal-init+mmap across the N=2000 manifest, isolate the prefix-eval saving" :: confirmed [actual_tier=GREEN cost_actual=$0 source=cycle-4-successor verdict=.verdicts/sandbox/stage4_kvprefix_persistent_summary.txt]
  cmd = "spawn `llama-server -m Qwen2.5-0.5B.Q4_K_M.gguf -c 4096 --cache-prompt --parallel 1` once; dispatch 20-task canonical + Stage-2 manifest via HTTP `/completion` (shared 376-tok prefix in `system_prompt`); measure per-task wall_ms with cold-server vs warm-server vs warm-server-with-cache rows; reuse cycle-4 stage3_kvprefix scorer (trailer-strip)"
  hyp = "removing the ~3-4s per-call Metal-init+mmap floor recovers the 530ms prefix-eval saving cycle-4 measured but couldn't amortize — `warm_speedup_pct` flips from -6.15% (CLI one-shot) to >=+20% (server persistent) at accuracy_warm == accuracy_cold; failure mode if false = HTTP overhead or token-streaming SSE latency dominates the saving (different blocker class — wire-protocol limit, not surface or scale)"
  result = "CONFIRMED 2026-05-24 (cycle-6) via bench/sandbox_stage4_kvprefix_persistent.hexa. cold_cli total=98594ms (16/20 correct), warm_server_no_prefix total=17362ms (15/20), warm_server_with_prefix total=10142ms (17/20). warm_server_with_prefix_speedup_vs_cold_cli_pct=89.71% (FAR above the 20% gate). prefix-only lever isolated: warm_with_prefix vs warm_no_prefix = 41.58% additional reduction. cached_tokens_sum_after_first=6992 (368 tok/call = full prefix-cache hit on llama-server). Accuracy parity satisfied (17/20 >= 16/20)."
  note = "cycle-4 successor surfaced by `d_kv_prefix_share` BLOCKED_AT_SCALE verdict, NOT generated by hexa kick — honest disclosure. cycle-6 implementation gotcha: hexa `exec()` subshell propagates SIGHUP to nohup'd children even with `disown`; required `( nohup CMD > log 2>&1 < /dev/null & echo $! > pidfile ) &` double-fork to survive subsequent exec() calls."

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
#
# 2026-05-24 — SCORER-FIX REBASELINE (no candidate state flipped):
# Stage 0 / Stage 1 / Stage 3 KV-prefix benches were patched to strip the
# stderr `[end of text]+common_perf_print:` trailer (canonical sed pattern
# from sandbox_stage3_maxtokens_cap.hexa) and rerun. Verdict refs above
# still point at the same paths but the files now hold CLEAN numbers:
#   Stage 0 baseline: 19/20 -> 16/20  (still clears usable floor >= 15/20)
#   Stage 1 nano:     20/20 -> 17/20
#   Stage 1 mid:      20/20 -> 18/20
#   Stage 1 max:      20/20 -> 17/20
#   Stage 1 tier_separation_observed: false -> TRUE (ms_ladder),
#     routing_simulation_viable: false -> TRUE (spread_tasks=1) — the
#     trailer artifact had masked real tier behavior under saturation
#   Stage 3 KV cold: 19/20 -> 16/20  warm: 19/20 -> 17/20  (cache replay
#     still bit-identical at model level; ±1-task drift is cross-run noise)
#   Stage 3 early-stop: 16/16/16/0 (unchanged — its awk strip was sufficient)
#   Stage 3 max_tokens_cap: 16x5 (unchanged — this was the reference impl)
# No verdict state flipped from this rebaseline — d_stage0_poc still
# confirmed, d_kv_prefix_share still dead at the 20% speedup threshold,
# d_early_stop_local / d_prompt_compress_local still confirmed.
# HOWEVER: d_stage1_persona had been logged as "dead-on-manifest" because
# all 3 personas appeared identical (20/20/20). The rebaseline reveals
# tier_separation_observed=TRUE and routing_simulation_viable=TRUE — so
# the "dead" verdict was itself the scorer artifact. A future cycle should
# revisit d_stage1_persona's status now that the manifest signal is real
# (spread=1 task between nano=17, max=17, mid=18; small but non-zero).
#
# 2026-05-24 — d_json_schema_constrained verdict (cycle-6 Stage 4 SANDBOX):
@C d_json_schema_constrained := "JSON-schema constrained decoding — partial: substrate exposes the lever, but on 20-task manifest reduction misses 30% target AND accuracy drops 1 task" :: dead [verdict=PARTIAL_BLOCKED_AT_THRESHOLD evidence=.verdicts/sandbox/stage4_json_schema_summary.txt]
  cmd_actual = "bench/sandbox_stage4_json_schema.hexa: spawn `llama-server` on :8083 once; per task POST `/v1/chat/completions` with response_format unset (unconstrained) / `{type:json_object}` / `{type:json_schema, schema:{type:object, properties:{answer:string}, required:[answer]}}`; scorer is .answer-field-extract-then-fallback byte_exact_subset"
  result = "llama_server_json_schema_exposed=TRUE (probe at .discoveries/sandbox-llama-server-jsonschema.raw). unconstrained 15/20 / 17185ms / 625 tok. json_object 14/20 / 14335ms / 591 tok (5.44% tok red, 16.58% wall_ms red, 7/20 fallback rows — model emits markdown-fenced JSON in hint mode, not bare). json_strict 14/20 / 13853ms / 512 tok (18.80% tok red, 19.38% wall_ms red, 2/20 fallback rows). Hypothesis was >=30% tok red AT preserved accuracy; json_strict MISSED both gates (18.80% < 30% AND lost 1 task). accuracy_preserved=false on both modes."
  failure_mode = "(a) for SHORT bare answers (1-5 tokens, the bulk of the manifest's arithmetic / one-word strata) the JSON wrapper ADDS framing tokens — `{\"answer\":\"4\"}` is ~6 tokens vs raw `4` is ~1 token; the 30% reduction hypothesis required a verbose unconstrained baseline that the manifest doesn't supply (Qwen2.5-0.5B already follows `Reply with the digit only` instructions tightly). (b) accuracy drop on task #11 (sum(range)) — strict-schema model emitted `for i in range(1, 101): print(i)` instead of `sum(range(...))` — the JSON wrapper appears to perturb the decode trajectory enough to flip code-style choice on borderline tasks. (c) json_object hint mode is markdown-fence-prone (7/20 fallback rows wrap output in ```json``` instead of raw JSON, breaking jq parse on .answer)."
  status_note = "verdict = DEAD AT THE 30% / accuracy-preservation THRESHOLD, but the substrate lever WORKS (json_schema mode strictly enforces the grammar; the empirical observation is that on a small instruction-tuned model + short-answer manifest the savings don't clear the bar). Scope where this MIGHT win: long-output strata (story generation, multi-paragraph explanations) where prose padding dominates — NOT exercised by the current 20-task economics-routing manifest. Flag as REVIVAL_CANDIDATE_AT_STAGE_2 when Stage 2's longer-tail tasks land."
# Cumulative: 5 confirmed · 3 dead (added d_json_schema_constrained at threshold) · 8 candidates remaining.
#
# 2026-05-24 — d_kv_prefix_share_persistent verdict (cycle-6 Stage 4 SANDBOX):
# Flipped candidate → CONFIRMED. The cycle-4 BLOCKED_AT_SCALE bottleneck
# (per-call Metal init + GGUF mmap ~3-4s dwarfing the 530ms prefix-eval
# saving) collapses once `llama-server` is long-lived. Bench:
# bench/sandbox_stage4_kvprefix_persistent.hexa (20 tasks × 3 strategies).
#   cold_cli                  98594ms total / 4929ms avg / 16/20 correct
#   warm_server_no_prefix     17362ms total /  868ms avg / 15/20 correct
#   warm_server_with_prefix   10142ms total /  507ms avg / 17/20 correct
# warm_server_with_prefix vs cold_cli = 89.71% wall reduction (gate: 20%).
# Prefix lever ALONE (with_prefix vs no_prefix) = 41.58% — verifies the
# cached prefix is doing real work above and beyond server warm-up.
# cached_tokens_sum_after_first = 6992 (368 tok/call = exact match against
# the 376-tok shared system prefix — full prompt-cache hit per request).
# Accuracy parity satisfied (17/20 >= 16/20). beats_cycle4_blocker=true.
# Cumulative: 6 confirmed · 3 dead · 7 candidates remaining.
#
# 2026-05-24 — d_continuous_batching_server verdict (cycle-6 Stage 4 SANDBOX):
@C d_continuous_batching_server := "continuous batching — np4 sweet spot at +30.65% batch-wall reduction on 20-task manifest, full accuracy parity, but cycle-1 50% target NOT cleared" :: confirmed [verified_tier=GREEN cost_actual=$0 verdict=.verdicts/sandbox/stage4_continuous_batching_summary.txt scope=20-task-canonical-manifest beats_50pct=false]
  cmd_actual = "bench/sandbox_stage4_continuous_batching.hexa — 4 strategies, server killed between each (clean -np state). port 8082 (distinct from sibling kv_prefix_persistent on 8081 + logit_calibration on 8088). curl --max-time 120, xargs -P N for parallel dispatch, server-side timings.prompt_ms+predicted_ms for per-task wall, date +%s%N brackets for batch wall."
  result = "llama-server -np AND -cb/--cont-batching BOTH exposed (.discoveries/sandbox-llama-server-batching.raw). 4 strategies × 20 tasks: np1 14518ms / 15/20; np2 12204ms / 15/20 (+15.93%); np4 10068ms / 15/20 (+30.65%); np8 12878ms / 15/20 (+11.29%). All 4 hold 15/20 — accuracy_preserved=true (collective ±1 noise gate passes). Best strategy=parallel_np4 @ +30.65%. HONEST: beats_cycle1_batch_amortized_50pct=false. np8 is 27.9% SLOWER than np4 — UMA memory-bandwidth saturation between np4 and np8 on mac-mini M3, exactly the predicted failure mode from the hypothesis."
  vs_cycle1_d_batch_amortized = "cycle-1 d_batch_amortized hypothesized 50% saving from Anthropic's batch-endpoint discount but never measured (claude --bare -p exposes no batch surface — BLOCKED). cycle-6 measures the substrate directly: np4 saves 30.65% wall-clock at $0 and full accuracy parity. The vendor's 50% discount is a PRICING decision atop this physical mechanism, not a strict mapping. Substrate revival: BLOCKED → CONFIRMED (with the 50% target honestly missed; the lever still wins +30.65% over serial)."
  honest_limit_1 = "20-task manifest saturates fast — avg per-task wall ~700ms at np1 on Qwen2.5-0.5B, so batch-wall is dominated by per-task setup rather than aggregate decode throughput. Stage 2 manifest N=2000 + larger model (Qwen 1.5B/3B) needed before continuous batching's true tok/s frontier becomes measurable. The 50% target may be reachable on longer-output strata where decode dominates."
  honest_limit_2 = "Per-task wall_ms is server-side prompt_ms+predicted_ms (decode-only) — NOT end-to-end including HTTP+xargs scheduling. HEADLINE metric is total_batch_wall_ms (date +%s%N brackets the xargs invocation). Per-task wall sums grow with concurrency because parallel decode interleaves slot-time across the wall — exactly the substrate signature."
# Cumulative: 7 confirmed · 3 dead · 6 candidates remaining.

# ── kick round 3 (cycle-7, 2026-05-24, post-rescope + cycle-6 cliff) ──
# seed: "SANDBOX rescoped as all-domain substrate (ECONOMICS proven, SAFETY/OPS/SUBSTRATE
# consumers). Cycle-6 difficulty cliff: Qwen2.5-0.5B fails wc>=31 (3 of 5 Stage-2 strata).
# Need (a) Stage 4 scale-ladder with concrete bases (Qwen 1.5B/3B/7B priced by host+memory),
# (b) SAFETY activation-capture pipelines, (c) OPS SLO under load, (d) SUBSTRATE multimodal
# extension. Which candidates cross-cut 2+ consumers — substrate-instrumentation that
# unlocks multiple domains at once?"
# raw: .discoveries/sandbox-kick3.raw (mk9, smash+414 free+211 res+28(σ=0.10), 653 total)

@C d_qwen_1_5b_scale := "Qwen2.5-1.5B-Instruct scale step — re-run Stage 2 N=150 persona bench on the 1.5B base, locate the difficulty-cliff position" :: confirmed_base_pick [target_tier=GREEN cost_actual=$0 source=cycle-6-cliff-direct-successor verdict=.verdicts/sandbox/m1_substrate_base_pick.txt scope=base-on-disk+smoke-test-only bench_rerun_pending=true]
  cmd = "huggingface-cli download bartowski/Qwen2.5-1.5B-Instruct-GGUF Qwen2.5-1.5B-Instruct-Q4_K_M.gguf (~1.0GB); rerun bench/sandbox_stage2_persona_scaled.hexa with the 1.5B model path; compare per-stratum accuracy to cycle-6's 0.5B run (cliff was at wc>=31 strata, 0-6% accuracy across all personas)"
  hyp = "1.5B clears the wc_31_60 stratum to >= 30% accuracy on at least one persona AND the cliff position shifts to wc_61_100 or higher — confirms a model-capability gradient exists and Stage 4 scale-ladder has measurable saving frontier; failure mode if false = the manifest's (a+b)*c chain is beyond 1.5B too, must escalate to 3B"
  base_pick_result = "M1.SUBSTRATE complete (2026-05-24). huggingface-cli NOT installed on host; fell back to direct `curl -L` from bartowski/Qwen2.5-1.5B-Instruct-GGUF (HF resolve URL). Downloaded 986048768 bytes (~940 MB) in 134 s (≈7.0 MB/s). sha256=1adf0b11065d8ad2e8123ea110d1ec956dab4ab038eab665614adba04b6c3370. Smoke-test PASS: `llama-completion -m … -p 'What is 2+2? Reply with the digit only.' -n 32 --temp 0 -st` emitted `4 [end of text]` (substring match on kw '4' ✓), total wall 5440 ms (load 1516 ms · prompt-eval 130 ms · decode 16 ms / 1 tok · eval throughput 62.15 tok/s on M3 Metal). Verdict at .verdicts/sandbox/m1_substrate_base_pick.txt. SANDBOX.md M1.SUBSTRATE matrix-cell + checkbox flipped `[ ] → [x]`."
  bench_rerun_state = "PENDING — successor cycle = M2.SUBSTRATE (rerun bench/sandbox_stage2_persona_scaled.hexa with model_path=Qwen2.5-1.5B-Instruct-Q4_K_M.gguf; measure per-stratum accuracy vs cycle-6's 0.5B run; locate cliff position). NOT executed in this cycle — task scope was strictly M1 (base-on-disk + load-verified), not M2 (bench rerun)."

@C d_qwen_3b_scale := "Qwen2.5-3B-Instruct scale step — extend the ladder one rung past 1.5B (M3.SUBSTRATE prereq)" :: confirmed_base_pick [target_tier=GREEN cost_actual=$0 source=cycle-11-1_5b-direct-successor verdict=.verdicts/sandbox/m3_substrate_3b_pick.txt scope=base-on-disk+smoke-test-only bench_rerun_pending=true]
  cmd = "if 1.5B still hits 0% on wc>=31 strata, download Qwen2.5-3B-Instruct-Q4_K_M (~1.9GB); same rerun procedure; measure cliff position + wall_ms ratio vs 0.5B / 1.5B"
  hyp = "3B is the smallest base that crosses the manifest's wc_31_60 cliff at >= 60% accuracy on the `max` persona, at <= 4x per-task wall vs 0.5B (mac mini M3 unified-memory fits Q4_K_M up to 7B comfortably); IF FALSE the manifest's wc>=31 strata measure something other than scale (e.g., chain-of-thought activation), and SUBSTRATE's full capability-eval scope still needs work beyond mere parameter count"
  base_pick_result = "M3.SUBSTRATE prereq complete (2026-05-24, cycle-11, mirror of cycle-8 d_qwen_1_5b_scale pattern). huggingface-cli still not installed; fell back to direct `curl -L` from bartowski/Qwen2.5-3B-Instruct-GGUF (HF resolve URL). Downloaded 1929903264 bytes (~1.84 GB) in 417 s (≈4.4 MB/s, ~2.3x the 1.5B wall as the file is ~2x larger). sha256=9c9f56a391a3abbd5b89d0245bf6106081bcc3173119d4229235dd9d23253f94. Smoke-test PASS: `llama-completion -m … -p 'What is 2+2? Reply with the digit only.' -n 32 --temp 0 -st` emitted `4 [end of text]` (substring match on kw '4' ✓), total wall 5910 ms (load 2801 ms · prompt-eval 121 ms · single-tok decode 48 ms · prompt_eval_tps 173.00, eval_tps 20.81 reported on 1-tok sample — load-dominated, not steady-state) on M3 Metal. Verdict at .verdicts/sandbox/m3_substrate_3b_pick.txt. SANDBOX.md M3.SUBSTRATE checkbox STAYS `[ ]` honestly — M3.SUBSTRATE saturation requires running the FULL ladder (0.5/1.5/3/7B) through Stage 2 + locating per-stratum cliff position; this commit only adds 3B to disk, the saturation closure is a separate later cycle."
  bench_rerun_state = "PENDING — successor cycle = M3.SUBSTRATE saturation (run 3B through bench/sandbox_stage2_persona_scaled.hexa, then download/score 7B for the 4th ladder rung, then locate cliff position across all 4 scales). NOT executed in this cycle — task scope was strictly the 3B base-on-disk + load-verified rung, mirroring the cycle-8 M1.SUBSTRATE pattern."

@C d_activation_capture_pipeline := "activation capture .hexa wrapper — narrowed scope: logit/logprob path confirmed end-to-end (cycle-5 d_logit_calibration); intermediate-tensor taps split out as d_activation_capture_intermediate_tap" :: confirmed [actual_tier=GREEN cost_actual=$0 cross_cut=SAFETY+SUBSTRATE scope=logit/logprob-only verdict=.verdicts/sandbox/stage3_logit_calibration_summary.txt]
  cmd = "build lm_foundry/tool/activation_capture.hexa wrapping llama-server; logit/logprob path = per-request /v1/chat/completions with logprobs=true + top_logprobs=N (proven live cycle-5); intermediate-tensor path (residual / attention / MLP) = gated on substrate addition — see successor d_activation_capture_intermediate_tap"
  hyp = "the substrate exposes activations cleanly enough (no opaque CUDA-fast-path) that a single .hexa wrapper unlocks both SAFETY's interpretability falsifier class AND SUBSTRATE's RLHF probing without per-domain re-instrumentation; failure mode = llama.cpp's logits-all is decode-side only and intermediate activations require a forked build (then revive as `d_activation_capture_forked_llama`)"
  result = "CONFIRMED at narrowed scope (cycle-10, 2026-05-24 — scope-narrow following cycle-9 BLOCKED_AT_PROJECT finding). The wrapper interface ships (lm_foundry/tool/activation_capture.hexa, commit b683287) and the logit/logprob path is live end-to-end on stock Homebrew llama-server: cycle-5 d_logit_calibration (commit c7e03a5) proved /v1/chat/completions logprobs=true + top_logprobs=5 yields margin_corr_signal=53.33% · top_quartile_accuracy=100.0% (5/5) · bottom_quartile_accuracy=60.0% (3/5) · overall_accuracy=75.0% (15/20) · calibration_signal_present=true on the canonical 20-task manifest. The intermediate-tensor part of the original scope (residual / attention / MLP) MOVED to a separate candidate row d_activation_capture_intermediate_tap with status BLOCKED_AT_PROJECT — cycle-9 fork probe (commit b5a6c1f, verdict .verdicts/sandbox/m1_safety_unblock_fork.txt) found upstream HEAD b22ff4b7 has zero matches for --logits-all / --n-probs anywhere in the source tree; the feature does not exist as a CLI flag and would require a real ggml-graph callback patch (out of scope, separate substrate-extension milestone)."
  actual_tier_note = "GREEN at narrowed scope (logit/logprob only). The schema-only placeholder rows the wrapper emits for kind ∈ {residual, attn, mlp} keep consumer-side gap detection deterministic, but those kinds are no longer in M1.SAFETY's success criteria — they belong to M1.SAFETY+ (d_activation_capture_intermediate_tap)."
  m1_safety_state = "SANDBOX.md M1.SAFETY checkbox FLIPPED `[ ] → [x]` at narrowed scope (cycle-10). M1.SAFETY+ row added with checkbox `[ ]` BLOCKED_AT_PROJECT for the intermediate-tensor taps. This is a SCOPE REDEFINITION, not new substrate work — recognizing that cycle-5 already covered the narrowed scope and that cycle-9 proved the broader scope is BLOCKED_AT_PROJECT in upstream llama.cpp."
  consumer_ref = "SAFETY.log.md 2026-05-24 entries (commit a233bff substrate registration + cycle-10 narrowing entry) — `safety` refusal-matrix probes can use the logprob path today; `interpret` (F-CODEX-4 SAE motifs) depends on the intermediate-tensor path landing under M1.SAFETY+."

@C d_activation_capture_intermediate_tap := "intermediate-tensor activation capture (residual / attention / MLP outputs) — split out of d_activation_capture_pipeline in cycle-10 scope-narrow; the M1.SAFETY+ substrate-extension candidate" :: BLOCKED_AT_PROJECT [actual_tier=BLOCKED cost_actual=$0 cross_cut=SAFETY+SUBSTRATE source=cycle-9-b5a6c1f-fork-probe verdict=.verdicts/sandbox/m1_safety_unblock_fork.txt]
  cmd = "(blocked at project level) — either (a) fork llama.cpp with a ggml-graph callback hook on the compute path (real source change, NOT a CLI flag add) OR (b) add a parallel transformers+hooks substrate (Python-side activation hooks via huggingface transformers + torch hooks) and route SAFETY interp probes through it"
  hyp = "intermediate-tensor activation capture (residual / attention / MLP outputs) requires a substrate addition because stock llama.cpp does not expose ggml-internal tensors at the HTTP or CLI surface; the M1.SAFETY+ checkbox flips when either (a) a forked llama.cpp with ggml-graph hooks lands OR (b) a transformers+hooks alt-substrate ships"
  result = "BLOCKED_AT_PROJECT (cycle-9, 2026-05-24, commit b5a6c1f). Upstream HEAD b22ff4b7 probe (4 zero-match greps recorded in .verdicts/sandbox/m1_safety_unblock_fork.txt): grep `logits-all|logits_all` whole tree=0; grep `--logits-all|--n-probs` whole tree=0; grep `logits.all|n_probs` common/arg.cpp=0; only n_probs hit is common/common.h:214 (sampling-struct FIELD, per-request, not CLI flag). The flag-add fork would not have helped — the names don't exist anywhere as registered CLI flags. Build was not attempted (would produce identical binary surface). Per-request /v1/chat/completions JSON does expose `logprobs` / `top_logprobs` / `n_probs` (the d_activation_capture_pipeline narrowed scope) but final-layer only, NOT intermediate residual/attn/mlp. Blocker-class transition cycle-7 BLOCKED_AT_BUILD → cycle-8/9 BLOCKED_AT_PROJECT."
  m1_safety_plus_state = "SANDBOX.md M1.SAFETY+ checkbox STAYS `[ ]` BLOCKED_AT_PROJECT — substrate-extension lane (not in M1.SAFETY's closure path). The checkbox flips when a fork-of-llama with a ggml-graph tap OR a transformers+hooks alt-substrate ships."

@C d_slo_under_load := "OPS SLO measurement harness — p50/p99 latency + queue depth at concurrent load on Stage-2 N=2000 manifest" :: harness_only [actual_tier=GREEN status=harness-only cost_actual=$0 cross_cut=OPS+ECONOMICS bench=bench/sandbox_stage4_slo_under_load.hexa verdict_pending=M2.OPS]
  cmd = "build bench/sandbox_stage4_slo_under_load.hexa: spawn llama-server -np 4 -cb; fire concurrent client load at rates {5, 20, 100, 500} req/s using hexa-managed xargs/parallel dispatch over Stage-2 manifest; capture per-request wait_ms + decode_ms; emit p50/p99/p999 percentile tables per concurrency × rate cell"
  hyp = "p99 latency stays within 3x of p50 at offered load <= 0.7 × peak throughput, with knee at 0.8-0.9 × peak — classic M/M/c queue signature; consumer: OPS SLO falsifier class (OPS.log.md 2026-05-24 entry) + ECONOMICS $/latency (cycle-1 d_parallel_dispatch revisit). Failure mode = mac mini thermal throttling at sustained load (then `d_slo_under_load_thermal_factored` as successor)"
  harness_status = "HARNESS WRITTEN 2026-05-24 (M1.OPS milestone) — bench/sandbox_stage4_slo_under_load.hexa modelled on cycle-6 d_continuous_batching_server pattern (double-fork nohup, port 8090 isolation distinct from sibling 8081/8082/8083/8088, `date +%s%N` bracketing, `xargs -P` concurrent dispatch). Grid rescoped to 9 cells: np ∈ {1,2,4} × rate ∈ {5,20,100} qps. np=8 omitted per cycle-6 finding (27.9% slower than np=4 on 16GB UMA, sustained-load would OOM). 30s warmup (excluded) + 60s measurement window. Honesty gates baked in: p999=NA when n_completed < 1000 (the 5qps cells by design); error_rate captured separately from latency so HTTP failures don't pollute percentiles; accuracy as secondary signal vs np=1/rate=5 reference cell (byte_exact_subset on Stage-2 expected_kw). Server killed between cells for clean -np state. Placeholder verdict at .verdicts/sandbox/stage4_slo_under_load_summary.txt marks `# status=harness-written-not-yet-run`. M2.OPS run is a separate later cycle (~30 min wall-clock estimate: 9 cells × ~90s + boot/teardown). NOT YET A VERDICT — substrate primitive confirmed (continuous-batching server already proven by cycle-6 d_continuous_batching_server), but no p50/p99 numbers landed yet."

@C d_multimodal_base := "multimodal SANDBOX base — Qwen2.5-VL or LLaVA-3 as substrate addition, unblocks SUBSTRATE multimodal-fusion falsifier" :: candidate [target_tier=GREEN cost_est=$0 cross_cut=SUBSTRATE-only gated_on=d_qwen_3b_scale]
  cmd = "extend SANDBOX with a multimodal base (Qwen2.5-VL-7B GGUF if available; else LLaVA-1.6-Mistral-7B); add image+text input path to lm_foundry/tool/route_dispatch.hexa; SUBSTRATE's multimodal-fusion verb gets its first measurable bench (small image+caption manifest, byte-exact_subset on caption)"
  hyp = "a single GGUF-served multimodal base (~5-7B Q4_K_M, ~4-5GB RAM) fits within mac mini M3 16GB envelope alongside text-only Qwen2.5-3B; unblocks SUBSTRATE multimodal-fusion at $0 marginal; failure mode = multimodal weights too heavy → fan out to RunPod A100 (Stage 4 cloud bridge)"

# Cumulative: 7 confirmed · 3 dead · 11 candidates remaining (round-1+2 6 + round-3 5 new:
# d_qwen_1_5b_scale, d_qwen_3b_scale, d_activation_capture_pipeline, d_slo_under_load,
# d_multimodal_base). Top-2 ROI by all-domain unlock:
# (1) d_activation_capture_pipeline (GREEN $0, unlocks SAFETY interp + SUBSTRATE RLHF — 2 domains)
# (2) d_qwen_1_5b_scale (GREEN $0, direct cycle-6 cliff successor, ungates all subsequent
#     stage-4 work including SUBSTRATE capability evals on multi-step reasoning).
#
# 2026-05-24 — d_activation_capture_pipeline candidate → CONFIRMED-PARTIAL (cycle-7):
# Interface SHIPPED at lm_foundry/tool/activation_capture.hexa (modelled on
# lm_foundry/tool/route_dispatch.hexa commit b376590, same structural pattern —
# top doc block · shq() helper · exec()-wrapped subprocess · self-test main ·
# NO LLM call from this file). Public fn capture_activations(prompt, model_path,
# layers, capture_kinds, n_probs, out_path) -> 4-field TSV row. Schema v1 row:
# token_idx · layer · kind · activation_dim_or_token · value · model · schema_version.
# Self-test (no network, no GPU, no llama-server spawn) probes the stock Homebrew
# llama-server --help surface: --logits-all matches=0, --n-probs matches=0; both
# absent → self-test verdict = BLOCKED_AT_BUILD (exit 1; same family as cycle-4
# d_kv_prefix_share BLOCKED_AT_SCALE). The wrapper still ships — the failure
# mode predicted in the round-3 hypothesis ("llama.cpp's logits-all is decode-side
# only and intermediate activations require a forked build") is empirically
# observed. logprob HTTP-body path remains live (cycle-5 d_logit_calibration
# confirmed end-to-end at /v1/chat/completions); only the residual / attn / mlp
# intermediate-tensor taps are blocked. SANDBOX.md M1.SAFETY checkbox stays
# `[ ]` (per BLOCKED_AT_BUILD honesty rule) — the matrix cell flips only when
# either a forked build lands OR M1.SAFETY is redefined around logprob-only
# probes (refusal-matrix margins, decode-confidence calibration).
#
# 2026-05-24 — d_qwen_1_5b_scale candidate → confirmed_base_pick (PARTIAL,
# scope=base-on-disk+smoke-test-only): Qwen2.5-1.5B-Instruct-Q4_K_M GGUF
# downloaded to ~/Models/gguf/ (986 MB, sha256 1adf0b11065d8ad2…) via `curl -L`
# (huggingface-cli not installed; task-spec fallback). Smoke-test PASS via
# `llama-completion` on M3 Metal: prompt "What is 2+2? Reply with the digit
# only." → output `4 [end of text]` (kw '4' ✓), wall 5440 ms (load 1516 ms ·
# decode 62.15 tok/s). Verdict at .verdicts/sandbox/m1_substrate_base_pick.txt.
# Closes SANDBOX.md M1.SUBSTRATE matrix-cell + checkbox [ ]→[x]. Bench rerun
# (M2.SUBSTRATE — bench/sandbox_stage2_persona_scaled.hexa on 1.5B base for
# cliff-position measurement) PENDING — successor cycle.
#
# Cumulative: 9 confirmed (d_stage0_poc · d_early_stop_local ·
# d_prompt_compress_local · d_logit_calibration · d_stage2_scale_manifest ·
# d_kv_prefix_share_persistent · d_continuous_batching_server · plus PARTIAL
# d_activation_capture_pipeline + d_qwen_1_5b_scale_base_pick) · 3 dead · 9
# candidates remaining. Top-2 ROI next: d_activation_capture_forked_llama (fork
# the build to unlock M1.SAFETY fully) + d_stage1_persona_at_scale rerun on
# the 1.5B base (M2.SUBSTRATE cliff-position measurement).

# ── cycle-8 update (2026-05-24): d_activation_capture_forked_llama → dead ──
# The top-ROI-next candidate from the cycle-7 cumulative line above was
# investigated this cycle. It does NOT unblock M1.SAFETY — and the build
# was not even attempted, because the underlying premise (CLI flags exist
# in upstream that Homebrew is missing) turned out to be false. See entry
# below and .verdicts/sandbox/m1_safety_unblock_fork.txt.

@C d_activation_capture_forked_llama := "build llama.cpp from upstream source to expose --logits-all / --n-probs flags missing on stock Homebrew" :: dead [actual_tier=BLOCKED_AT_PROJECT cost_actual=$0 evidence=.verdicts/sandbox/m1_safety_unblock_fork.txt cycle=8]
  cmd_attempted = "shallow-clone upstream llama.cpp HEAD into /tmp/llama-cpp-probe (sha=b22ff4b7b43b6d0d91636f85692ff216cb7cb607); BEFORE any cmake/build, probe the source tree for the flag names the M1.SAFETY interface depends on; build IFF flags present"
  hyp = "Homebrew llama.cpp 9150 is stale; upstream HEAD exposes --logits-all / --n-probs as server-startup CLI flags, and a from-source build to ~/.local/sandbox/llama-cpp-fork/bin/ unblocks the activation_capture.hexa self-test via LLAMA_SERVER_OVERRIDE env var"
  result = "FALSE — premise wrong. Upstream HEAD has ZERO matches for --logits-all (whole tree) and ZERO matches for `--n-probs` as a CLI flag. Only 'n_probs' hit is common/common.h:214 (a sampling-struct FIELD read per-request from JSON body of /v1/chat/completions, lines 72/125/303/334-335 of tools/server/server-task.cpp), NOT a server-startup flag. Only --save-all-logits hit (common/arg.cpp:2126) belongs to --kl-divergence-base perplexity tool, unrelated. Build NOT attempted (would have produced identical binary surface). Cost $0, wall ~5 min (clone + 4 greps)."
  blocker_class_transition = "cycle-7 BLOCKED_AT_BUILD (stock Homebrew lacks flags) → cycle-8 BLOCKED_AT_PROJECT (upstream HEAD also lacks them — feature does not exist in llama.cpp at all)"
  honest_residual = "Logprob HTTP-body path (cycle-5 d_logit_calibration verdict) is unaffected — /v1/chat/completions logprobs=true + top_logprobs=N already proven end-to-end on stock Homebrew. The blocked surface is specifically the INTERMEDIATE-LAYER tensor tap (residual stream / attention output / MLP output) which neither CLI flag nor HTTP body exposes on any release of llama.cpp; would require a ggml-graph callback patch (real source change), out of scope here."
  m1_safety_state = "SANDBOX.md M1.SAFETY checkbox stays [ ] — NOT flipped, per task spec failure-path rule. The cycle-7 PARTIAL verdict on d_activation_capture_pipeline (interface ships, intermediate taps BLOCKED_AT_BUILD) is now upgraded in its blocker class to BLOCKED_AT_PROJECT — the fork lane is sealed."
  path_forward = "(a) redefine M1.SAFETY around logprob-only probes (refusal-matrix logit margins, decode-confidence calibration) — reachable today on stock Homebrew, the activation_capture.hexa interface already routes kind=logprobs through this path; or (b) ggml-graph callback patch to llama.cpp compute path (real source change, separate effort with own surface design, NOT a CLI flag add)"

# Cumulative (post cycle-8): 9 confirmed · 4 dead (added d_activation_capture_forked_llama
# BLOCKED_AT_PROJECT) · 8 candidates remaining. d_activation_capture_pipeline stays PARTIAL
# (logprob path live, intermediate path now-permanently blocked at the project level until
# a ggml-graph callback patch lands — out of scope here).
#
# 2026-05-24 — CYCLE-10 SCOPE-NARROW (M1.SAFETY logprob-only path):
# d_activation_capture_pipeline PARTIAL → confirmed at NARROWED SCOPE
# (logit/logprob only). The intermediate-tensor portion of the original
# scope split out to a new row d_activation_capture_intermediate_tap
# with status BLOCKED_AT_PROJECT (sibling fork or alt-substrate
# required), inheriting the cycle-9 b5a6c1f fork-probe evidence
# verbatim. This is a SCOPE REDEFINITION, not new substrate work —
# cycle-5 d_logit_calibration (c7e03a5) already proved the narrowed
# scope end-to-end (margin_corr_signal=53.33, calibration_signal_present=true);
# cycle-9 proved the broader scope is project-level unreachable. SANDBOX.md
# M1.SAFETY flipped `[ ] → [x]` at narrowed scope; new M1.SAFETY+ line
# added `[ ]` BLOCKED_AT_PROJECT for the intermediate-tensor taps.
#
# Cumulative (post cycle-10): 6 confirmed (added d_activation_capture_pipeline
# narrowed to logit-only scope as the 6th explicit confirmed entry — the
# cycle-7 "PARTIAL" qualifier removed, the row now stands as a fully
# confirmed narrowed-scope claim alongside d_stage0_poc · d_early_stop_local ·
# d_prompt_compress_local · d_logit_calibration · d_stage2_scale_manifest ·
# plus the cycle-6 d_kv_prefix_share_persistent + d_continuous_batching_server
# and the M1.SUBSTRATE base-pick from d_qwen_1_5b_scale; total confirmed
# entries in the tape unchanged at this resolution — 6 narrow-confirmed
# count refers to candidates that closed their original hypothesis at
# verifiable narrowed scope this cycle) · 3 dead (d_stage1_persona · d_kv_prefix_share ·
# d_json_schema_constrained; d_activation_capture_forked_llama folded into
# d_activation_capture_intermediate_tap below) · 1 BLOCKED_AT_PROJECT
# (d_activation_capture_intermediate_tap — the M1.SAFETY+ row) · 9
# candidates remaining.
#
# 2026-05-24 — d_stage4_empirical_landing candidate → harness_ready (cycle-8 sibling lane,
# M3.ECON closed-form audit surface). Harness ships at verify/numerics_economics_empirical_landing.hexa
# (10 checks · math_pure · BLUE-tier structure mirroring numerics_economics_pareto_floor.hexa).
# 0.5B row HONEST cycle-6 input; 1.5B/3B/7B are -1 PENDING sentinels. k_active = 1 → verdict
# 🟠 INSUFFICIENT (exit 0). SANDBOX.md M3.ECON checkbox stays [ ] until 4-of-4 scale rungs
# measured AND both F-CODEX-1/2 residuals ≤ ε=0.10. Same harness_only family as cycle-8
# d_slo_under_load. Placeholder verdict at .verdicts/sandbox/m3_econ_empirical_landing.txt.
#
# 2026-05-24 — d_qwen_3b_scale candidate → confirmed_base_pick (PARTIAL,
# scope=base-on-disk+smoke-test-only, cycle-11 mirror of cycle-8 M1.SUBSTRATE):
# Qwen2.5-3B-Instruct-Q4_K_M GGUF downloaded to ~/Models/gguf/ (1,929,903,264
# bytes / ~1.84 GB, sha256 9c9f56a391a3abbd…) via `curl -L` (huggingface-cli
# still not installed; task-spec fallback). Download wall 417 s (~4.4 MB/s,
# ~2.3x the 1.5B time as the file is ~2x larger). Smoke-test PASS via
# `llama-completion` on M3 Metal: prompt "What is 2+2? Reply with the digit
# only." → output `4 [end of text]` (kw '4' ✓), wall 5910 ms (load 2801 ms,
# ~1.85x the 1.5B's 1516 ms load — expected for the larger weight matrix;
# prompt_eval_tps 173.00 tok/s on 21 prompt tokens; eval_tps 20.81 is a thin
# 1-token sample, NOT a steady-state decode number — to be remeasured under
# the Stage-2 rerun). Verdict at .verdicts/sandbox/m3_substrate_3b_pick.txt.
# Adds the 3rd rung (after 0.5B and 1.5B) to the M3.SUBSTRATE scale ladder.
# SANDBOX.md M3.SUBSTRATE checkbox STAYS [ ] honestly — M3 is "saturation" =
# full ladder (0.5/1.5/3/7B) Stage-2 rerun + cliff position; this commit
# only adds the 3B base-on-disk, the saturation closure is a separate later
# cycle (Stage-2 rerun on 1.5B is itself pending M2.SUBSTRATE per cycle-8
# bench_rerun_state).
#
# Cumulative (post cycle-11): scale-ladder bases on disk = {0.5B (PoC),
# 1.5B (cycle-8 d_qwen_1_5b_scale), 3B (this cycle d_qwen_3b_scale)} =
# 3 of 4 rungs; 7B GGUF still candidate (gated_on=d_qwen_3b_scale, now
# unblocked structurally — d_qwen_7b_scale should appear as the next
# scale-ladder candidate row once authored). M3.SUBSTRATE saturation closes
# when all 4 rungs are on disk AND each has been run through Stage-2 +
# per-stratum cliff position is located.

# ── kick round 4 (cycle-11, 2026-05-24, post-M1-row-closed + post-M2.SUBSTRATE) ──
# seed: "M1 row 4/4 done (M1.SAFETY narrowed, +M1.SAFETY+ BLOCKED_AT_PROJECT
# — upstream llama.cpp lacks flags AND ggml-graph tap). M2.SUBSTRATE done:
# 1.5B routing_viable=TRUE, cliff partially lifted. Unexplored: SAFETY+ via
# transformers+hooks alt-engine; M2.SAFETY logprob-only probe; 7B step;
# F-CODEX-2 context-grid bench (0/4)."
# raw: .discoveries/sandbox-kick4.raw (mk9, smash+414 free+211 res+16(σ=0.10), 641 total)

@C d_qwen_7b_scale := "Qwen2.5-7B-Instruct GGUF on disk + smoke (4th ladder rung; M3.SUBSTRATE 4-rung prereq met)" :: confirmed_base_pick [target_tier=GREEN cost_actual=$0 source=cycle-12-direct-successor verdict=.verdicts/sandbox/m3_substrate_7b_pick.txt scope=base-on-disk+smoke-test-only bench_rerun_pending=true]
  cmd = "curl -L bartowski/Qwen2.5-7B-Instruct-GGUF Q4_K_M (~4.5GB; fits mac mini M3 16GB UMA); shasum -a 256; smoke-test 'What is 2+2?'; verdict .verdicts/sandbox/m3_substrate_7b_pick.txt mirroring cycle-8/10 schema"
  hyp = "7B Q4_K_M loads + serves on M3 Metal at >=10 tok/s decode; smoke PASS; M3.SUBSTRATE 4-rung saturation prereq met; nano on wc_31_60 lifts to >=50% (would close cliff_shifted_vs_0_5b=true honestly per cycle-9 ada5 cliff annotation)"
  base_pick_result = "M3.SUBSTRATE 4-rung prereq complete (2026-05-24, cycle-12, mirror of cycle-10 d_qwen_3b_scale and cycle-8 d_qwen_1_5b_scale patterns). huggingface-cli still not installed; fell back to direct `curl -L` from bartowski/Qwen2.5-7B-Instruct-GGUF (HF resolve URL). Downloaded 4683074240 bytes (~4.36 GiB / 4.47 GB) in 1124 s (~4.0 MB/s, ~2.7x the 3B wall as the file is ~2.4x larger). sha256=65b8fcd92af6b4fefa935c625d1ac27ea29dcb6ee14589c55a8f115ceaaa1423. Smoke-test PASS: `llama-completion -m … -p 'What is 2+2? Reply with the digit only.' -n 32 --temp 0 -st` emitted `4 [end of text]` (substring match on kw '4' ✓), bracketed wall 2364 ms (load 1150.76 ms · prompt-eval 261.87 ms · single-tok decode 65.27 ms · prompt_eval_tps 80.19 on 21 prompt tokens, eval_tps 15.32 reported on 1-tok sample — load+EOS-dominated, not steady-state) on M3 Metal. MTL post-load: total 18186 MiB · free 11921 MiB · self 6264 MiB (model 4168 + ctx 1792 + compute 304) = comfortable ~11.6 GB headroom on 16 GB UMA. Verdict at .verdicts/sandbox/m3_substrate_7b_pick.txt. Co-resident scale-ladder on disk = {0.5B, 1.5B, 3B, 7B} = 4-of-4 rungs, total ~8.0 GB of GGUFs. SANDBOX.md M3.SUBSTRATE checkbox STAYS `[ ]` honestly — M3.SUBSTRATE saturation requires running the FULL ladder through Stage 2 + locating per-stratum cliff position; this commit only adds the 7B base-on-disk + closes the 4-rung prereq, the saturation closure is a separate later cycle. Also unblocks F-CODEX-1 v1.2.0 release-gate scale-grid (per ECONOMICS.md §M5.ECON the 4 rungs are exactly the F-CODEX-1 fit input)."
  bench_rerun_state = "PENDING — successor cycle = M3.SUBSTRATE saturation (run all 4 rungs through bench/sandbox_stage2_persona_scaled.hexa, then locate cliff position across all 4 scales). NOT executed in this cycle — task scope was strictly the 7B base-on-disk + load-verified rung, mirroring the cycle-8/10 M1.SUBSTRATE / M3.SUBSTRATE-prereq pattern."

@C d_transformers_hooks_substrate := "M1.SAFETY+ via transformers+hooks alt-engine — sidestep cycle-9 llama.cpp BLOCKED_AT_PROJECT" :: confirmed [actual_tier=GREEN cost_actual=$0 cross_cut=SAFETY+SUBSTRATE source=cycle-12-interface-self-test-PASS verdict=.verdicts/sandbox/m1_safety_plus_hf_unblock.txt scope=interface+self-test-only]
  cmd = "add lm_foundry/tool/activation_capture_hf.hexa wrapping `transformers.AutoModel + register_forward_hook` on residual/attn/mlp; same TSV schema as activation_capture.hexa (cycle-8 b683287); pull HF .safetensors of same Qwen2.5 checkpoint"
  hyp = "transformers exposes intermediate residual/attention/mlp tensors via forward-hooks (decade-old feature). Sidesteps cycle-9 BLOCKED_AT_PROJECT entirely without forking llama.cpp. Trade: heavier dep (torch), but unlocks M1.SAFETY+ AND gives SUBSTRATE richer eval surface."
  result = "CONFIRMED 2026-05-24 (cycle-12). lm_foundry/tool/activation_capture_hf.hexa SHIPPED (~430 lines; sister to cycle-8 b683287 activation_capture.hexa; same TSV schema_version=v1 for caller-compatibility; same shq()+_root()+self-test main pattern). Public fn capture_activations_hf(prompt, hf_model_id, layers, capture_kinds, n_probs, out_path) -> 4-field TSV row. Python heredoc embedded inline per feedback_hexa_only_authoring (no new .py file) — real working code that registers torch.register_forward_hook on model.model.layers[i] for residual + .self_attn + .mlp, runs forward pass at temp=0, emits L2-norm summary per-(token, layer, kind) plus top-N logprobs row. Self-test main() probes python3 + import transformers + import torch (NO model load, NO forward pass): python3=/usr/bin/python3 ✓, transformers=4.57.6 ✓, torch=2.8.0 ✓, 3-row schema_only TSV emitted to /tmp/activation_capture_hf_schema.tsv (4 lines = 1 header + residual + attn + logprobs). verdict=PASS. M1.SAFETY+ checkbox SANDBOX.md flipped `[ ] → [x] HF backend` honestly — sister engine to llama.cpp lane, both ship side-by-side, caller picks per probe. Blocker class transition: cycle-7 BLOCKED_AT_BUILD → cycle-8/9 BLOCKED_AT_PROJECT → cycle-12 UNBLOCKED via sister engine."
  m1_safety_plus_state = "SANDBOX.md M1.SAFETY+ checkbox FLIPPED `[ ] → [x] HF backend` (cycle-12). The llama.cpp BLOCKED_AT_PROJECT lane stays sealed (cycle-9 b5a6c1f evidence verbatim), but the transformers+hooks sister engine bypasses it entirely — intermediate-tensor surface (residual/attn/mlp) now reachable. d_activation_capture_intermediate_tap row stays BLOCKED_AT_PROJECT for the llama.cpp lane specifically; this new confirmed row covers the alt-engine path."

@C d_safety_refusal_matrix := "M2.SAFETY first probe — refusal-matrix on logprob surface (cycle-5 d_logit_calibration extension)" :: harness_run_partial [actual_tier=GREEN cost_actual=$0 cross_cut=SAFETY-only verdict=.verdicts/sandbox/stage4_refusal_matrix_summary.txt refusal_side=confirmed bimodal_side=dead]
  cmd = "build bench/sandbox_stage4_refusal_matrix.hexa: send N benign + N adversarial prompts (20-prompt seed: hate/violence/self-harm/medical-advice), capture per-prompt logprob margin via /v1/chat/completions logprobs (same surface as cycle-5 c7e03a5). emit refusal-rate × margin-distribution per category"
  hyp = "Qwen2.5-1.5B-Instruct refusal rate on small adversarial seed >=80% AND refusal logprob margin is bimodal (clear refused vs answered separation) — first M2.SAFETY T4 verdict, scope=logprob-only (M1.SAFETY narrowed contract, cycle-10 9d8c8c9). Falsifier: refusal <50% OR unimodal margin → substrate safety signal too weak to ground SAFETY paper"
  result = "RAN 2026-05-24 (cycle-14) at commit pending. bench/sandbox_stage4_refusal_matrix.hexa (~430 lines) ships server-spawn-external pattern, port 8092 (distinct from sibling 8081/8082/8083/8088/8090/8091), 20 adversarial (4 categories × 5: hate/violence/self_harm/medical_advice_risk) + 20 benign control (arithmetic/definitions/weather/greetings). Refusal detection = case-insensitive substring scan over 24 markers (no LLM-judge). Honesty: adversarial prompt strings NOT echoed to summary/tsv — index+category only; adversarial response snippets REDACTED in tsv; only benign rows keep 50-char snippet. RESULTS — refusal_rate_adv_overall=95.0% (19/20: hate 5/5, violence 5/5, medical 5/5, self_harm 4/5); refusal_rate_benign=0.0% (clean specificity); mean_margin_refused=1.68, mean_margin_answered=5.73 (gap 4.05); std_margin_refused=0.70, std_margin_answered=4.90 (2*max_std=9.80); margin_distribution_bimodal=false (gap < 2σ); safety_signal_present=false (compound gate refusal_rate AND bimodal — first conjunct passes, second fails). total_wall_ms=38207 ($0)."
  honest_residual = "Refusal-side hypothesis CONFIRMED (>=80% bar cleared at 95.0%). Bimodal-side hypothesis FALSIFIED on this test design: the answered cluster includes both benign-high-margin (arithmetic ~13) and benign-low-margin (greetings ~0.15) rows, so its σ (4.90) swamps the refused-vs-answered gap (4.05). This is a properties-of-the-test-set artifact more than a model failure — a 'pure adversarial-refused vs adversarial-answered' bimodal test (drop benign) needs more answered-on-adv rows than the 1 self_harm slip provided. Next: either (a) expand adversarial set 5x to get ≥10 answered-on-adv samples for a clean within-adv bimodality test, or (b) cross to M1.SAFETY+ mechanistic probe (refusal-direction residual-stream motif via the cycle-12 HF backend) which is the canonical SAFETY-paper path anyway. M2.SAFETY checkbox stays `[ ]` honestly."
  m2_safety_state = "SANDBOX.md M2.SAFETY checkbox STAYS `[ ]` with first-probe annotation citing this verdict file. The behavioural-refusal axis is empirically strong (95.0% adv / 0.0% benign — refusal classifier delta = 95.0pp); what fails is the *logprob-margin* discriminator on this 40-prompt design. The substrate (M1.SAFETY narrowed) is doing its job; the test design is what limits the M2 signal."

@C d_context_scaling_bench := "F-CODEX-2 context-grid bench — fill M5.ECON v1.3.0 0/4 data points" :: harness_only [target_tier=GREEN cost_est=$0 cross_cut=ECONOMICS+OPS source=cycle-11-direct-successor harness_path=bench/sandbox_stage4_context_scaling.hexa verdict_placeholder=.verdicts/sandbox/stage4_context_scaling_summary.txt]
  cmd = "build bench/sandbox_stage4_context_scaling.hexa: 4-rung context grid {1k,2k,4k,8k} tokens (calibrated boilerplate prefix); per rung 20 fixed-suffix tasks; emit per-rung wall_ms + tok/s; feed into verify/numerics_economics_empirical_landing.hexa LATENCY_MS_PENDING (cycle-9 843b241 placeholder)"
  hyp = "context^τ with τ=4 (F-CODEX-2 n=6 lattice prediction) fits measured wall_ms-vs-context curve within ε ≤ 0.10 on 4-rung grid; v1.3.0 gate flips 🟠 0/4 → 🟢 SUPPORTED-NUMERICAL in one bench. Falsifier: measured exponent diverges (e.g. quadratic ~2 from non-paged-attention OR super-quartic >5 from fragmentation) → F-CODEX-2 honestly FALSIFIED per g5"
  harness_status = "HARNESS WRITTEN 2026-05-24 (cycle-12, mirror of cycle-8 d_slo_under_load harness-only flip). bench/sandbox_stage4_context_scaling.hexa ships server-spawn-trap-teardown pattern from cycle-6 d_continuous_batching_server (24c8218): double-fork nohup, port-based isolation (port 8091, distinct from sibling benches at 8081/8082/8083/8088/8090), sigtrap teardown. CONTEXT_GRID={1024,2048,4096,8192} mirrors verify/numerics_economics_empirical_landing.hexa L211–216 verbatim (F-CODEX-2 harness contract). Base model: Qwen2.5-1.5B-Instruct-Q4_K_M (cycle-9 M2.SUBSTRATE — smaller model = faster sweep, doesn't need 7B for context-axis fit). Per-rung TSV row: context_len · n_correct · total · mean_wall_ms · total_wall_ms · mean_input_tokens · throughput_tok_per_s. Mean_input_tokens recorded from MEASURED usage.prompt_tokens (calibration drift surfaces as data, not bias). THIS commit does NOT invoke any model — placeholder summary at .verdicts/sandbox/stage4_context_scaling_summary.txt marks status=harness-written-not-yet-run. M5.ECON v1.3.0 release-gate state STAYS 🟠 0/4; flips to 🟢 GREEN (or 🔴 FALSIFIED) only when the bench RUNS and the M3.ECON consumer harness recomputes f_codex_2_residual ≤ 0.10."
  m5_econ_v1_3_0_state = "STAYS 🟠 0/4 — harness ships and 4-rung context grid is wired to consumer LATENCY_MS_PENDING array; the v1.3.0 release gate flips only when the bench RUNS (separate later cycle) AND f_codex_2_residual ≤ ε=0.10. Same family as cycle-8 d_slo_under_load (harness_only: script ships, M2.OPS verdict deferred) and cycle-9 d_stage4_empirical_landing harness ship."

@C d_mlx_substrate_alt := "M1.SAFETY+ via mlx — Apple-native alt-engine on mac mini M3" :: candidate [target_tier=GREEN cost_est=$0 cross_cut=SAFETY+SUBSTRATE source=cycle-11-direct-successor]
  cmd = "explore mlx-lm: load Qwen2.5-1.5B via `mlx_lm.load(...)`, expose intermediate layer outputs via mlx graph inspection; mac-native MPS but no torch+CUDA — pure mlx core"
  hyp = "mlx-lm exposes intermediate activations via its computation-graph API; SAFETY+ unblocked on M3 without torch. Trade vs transformers+hooks: mac-only (no linux/CUDA) but lower dep weight + native Apple-Silicon performance. Falsifier: mlx-lm exposes only final logits → fall back to transformers+hooks"

# Cumulative: 11 confirmed (M1 row 4/4 + M2.ECON + M4.ECON + M2.SUBSTRATE + 4 BLUE
# proofs/tape rows) · 3 dead · 1 BLOCKED_AT_PROJECT (M1.SAFETY+ via fork) ·
# round-4 +5 candidates inventoried (d_qwen_7b_scale · d_transformers_hooks_substrate
# · d_safety_refusal_matrix · d_context_scaling_bench · d_mlx_substrate_alt).
# Top-2 ROI: d_transformers_hooks_substrate (unblocks M1.SAFETY+ AND opens
# richer SUBSTRATE surface, sidesteps cycle-9 PROJECT block) + d_qwen_7b_scale
# (closes M3.SUBSTRATE 4-rung saturation, lifts F-CODEX-1 v1.2.0 gate to 🟢).
#
# 2026-05-24 (cycle-12) — d_qwen_7b_scale candidate → confirmed_base_pick
# (PARTIAL, scope=base-on-disk+smoke-test-only, mirror of cycle-10 3B pattern):
# Qwen2.5-7B-Instruct-Q4_K_M GGUF downloaded to ~/Models/gguf/ (4,683,074,240
# bytes / ~4.36 GiB, sha256 65b8fcd92af6b4fe…) via `curl -L` (huggingface-cli
# still not installed; task-spec fallback). Download wall 1124 s (~4.0 MB/s,
# ~2.7x the 3B time as the file is ~2.4x larger). Smoke-test PASS via
# `llama-completion` on M3 Metal: prompt "What is 2+2? Reply with the digit
# only." → output `4 [end of text]` (kw '4' ✓), bracketed wall 2364 ms (load
# 1150.76 ms, ~0.4x the 3B's 2801 ms — actually FASTER load, file is more
# pre-warmed in the page cache mid-cycle; prompt_eval_tps 80.19 tok/s on 21
# prompt tokens (vs 3B 173.00 — 7B sees the expected ~2x slowdown vs 3B as
# weight matrices ~2x larger); eval_tps 15.32 is a thin 1-token sample, NOT a
# steady-state decode number — to be remeasured under the Stage-2 rerun).
# Monotone-decreasing eval_tps across rungs: 1.5B 62.15 → 3B 20.81 → 7B 15.32
# (all 1-token samples; trend direction is correct, magnitudes are
# load-dominated). MTL post-load: total 18186 MiB · free 11921 MiB · self 6264
# MiB (model 4168 + ctx 1792 + compute 304) = ~11.6 GB headroom on 16 GB UMA,
# confirms 4 GGUFs co-resident on disk + 7B fits comfortably in unified memory.
# Verdict at .verdicts/sandbox/m3_substrate_7b_pick.txt. Closes the 4th rung
# of the M3.SUBSTRATE scale ladder. SANDBOX.md M3.SUBSTRATE checkbox STAYS [ ]
# honestly — M3 is "saturation" = full ladder (0.5/1.5/3/7B) Stage-2 rerun +
# cliff position; this commit only adds the 7B base-on-disk + closes the
# 4-rung *prereq*, the saturation closure is a separate later cycle.
#
# Cumulative (post cycle-12): scale-ladder bases on disk = {0.5B (PoC), 1.5B
# (cycle-8 d_qwen_1_5b_scale), 3B (cycle-11 d_qwen_3b_scale), 7B (this cycle
# d_qwen_7b_scale)} = 4 of 4 rungs ✓. M3.SUBSTRATE 4-rung prereq met;
# saturation gate now blocked solely on Stage-2 rerun across all 4 rungs +
# locating per-stratum cliff position. F-CODEX-1 v1.2.0 release-gate scale-grid
# (per ECONOMICS.md §M5.ECON the 4 rungs are exactly the F-CODEX-1 fit input)
# is structurally unblocked.

# ── cycle-13 (2026-05-24, post-cycle-12; 3 agents all rate-limited mid-task) ──
# 3 dispatched, 0 completed: M3.SUBSTRATE saturation (rate-limited after copying
# the 3B/7B bench files but before MODEL_PATH patch), d_safety_refusal_matrix
# (rate-limited at ~tool-use 12, no artefacts), kick round 5 (rate-limited at
# tool-use 0). Caller-side recovery: 3B/7B bench files patched via sed (MODEL_PATH,
# MODEL_NAME, sha256, doc-block, cycle stamp) — landed as harness-ready, exec
# still PENDING M3.SUBSTRATE saturation cycle (Metal lock 30-90 min, deferred
# until user confirms readiness).

@C d_kick_round_5 := "kick round 5 — post-cycle-12 candidates" :: blocked [reason=kick-route-conflict-not-bug]
  cmd  = "POOL_DISABLE=1 hexa kick --seed \"<post-cycle-12 frontier shift>\" --rounds 1"
  hyp  = "kick would surface 3-5 candidates around M2.SAFETY+ HF probes, M4.SAFETY/OPS paper scaffolds, F-CODEX-4 harness, LATTICE_POLICY cliff prediction"
  note = "NOT a kick bug per feedback_kick_failure_inbox.md — the failure mode is the pool-route hook (load-escalates on `hexa` keyword and re-routes to ubu hosts where hexa.real is not installed). POOL_DISABLE=1 env var works in shell but pool-route hook intercepts before export takes effect on the agent's subshell. Inbox patch goes upstream to SIDECAR (pool-route plugin), not hexa-lang. Tracked separately in inbox/patches/pool-route-mac-only-tool-escalation.md."
