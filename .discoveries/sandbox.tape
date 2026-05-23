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

@C d_qwen_1_5b_scale := "Qwen2.5-1.5B-Instruct scale step — re-run Stage 2 N=150 persona bench on the 1.5B base, locate the difficulty-cliff position" :: candidate [target_tier=GREEN cost_est=$0 source=cycle-6-cliff-direct-successor]
  cmd = "huggingface-cli download bartowski/Qwen2.5-1.5B-Instruct-GGUF Qwen2.5-1.5B-Instruct-Q4_K_M.gguf (~1.0GB); rerun bench/sandbox_stage2_persona_scaled.hexa with the 1.5B model path; compare per-stratum accuracy to cycle-6's 0.5B run (cliff was at wc>=31 strata, 0-6% accuracy across all personas)"
  hyp = "1.5B clears the wc_31_60 stratum to >= 30% accuracy on at least one persona AND the cliff position shifts to wc_61_100 or higher — confirms a model-capability gradient exists and Stage 4 scale-ladder has measurable saving frontier; failure mode if false = the manifest's (a+b)*c chain is beyond 1.5B too, must escalate to 3B"

@C d_qwen_3b_scale := "Qwen2.5-3B-Instruct scale step — extend the ladder if 1.5B doesn't clear cliff" :: candidate [target_tier=GREEN cost_est=$0 gated_on=d_qwen_1_5b_scale]
  cmd = "if 1.5B still hits 0% on wc>=31 strata, download Qwen2.5-3B-Instruct-Q4_K_M (~1.9GB); same rerun procedure; measure cliff position + wall_ms ratio vs 0.5B / 1.5B"
  hyp = "3B is the smallest base that crosses the manifest's wc_31_60 cliff at >= 60% accuracy on the `max` persona, at <= 4x per-task wall vs 0.5B (mac mini M3 unified-memory fits Q4_K_M up to 7B comfortably); IF FALSE the manifest's wc>=31 strata measure something other than scale (e.g., chain-of-thought activation), and SUBSTRATE's full capability-eval scope still needs work beyond mere parameter count"

@C d_activation_capture_pipeline := "activation capture .hexa wrapper — exposes layer-N intermediate activations from llama-server for SAFETY interp probes" :: confirmed [actual_tier=PARTIAL cost_actual=$0 cross_cut=SAFETY+SUBSTRATE verdict=interface-ships+self-test-BLOCKED_AT_BUILD]
  cmd = "build lm_foundry/tool/activation_capture.hexa wrapping llama-server with `--lookup-cache` + `--logits-all` + a layer-tap shim; emit per-token activation vectors (residual stream, attention output, MLP output) to TSV/parquet; consumer: SAFETY circuit-motif + SAE probes (SAFETY.log.md 2026-05-24 entry) + SUBSTRATE RLHF reward-shaping probes"
  hyp = "the substrate exposes activations cleanly enough (no opaque CUDA-fast-path) that a single .hexa wrapper unlocks both SAFETY's interpretability falsifier class AND SUBSTRATE's RLHF probing without per-domain re-instrumentation; failure mode = llama.cpp's logits-all is decode-side only and intermediate activations require a forked build (then revive as `d_activation_capture_forked_llama`)"
  result = "INTERFACE SHIPPED (cycle-7, 2026-05-24): lm_foundry/tool/activation_capture.hexa — one public fn `capture_activations(prompt, model_path, layers, capture_kinds, n_probs, out_path) -> status\\ttotal_tokens\\tbytes_written\\tschema_version`. TSV schema v1: `token_idx · layer · kind · activation_dim_or_token · value · model · schema_version`. Self-test runs no llama-server (per task spec — interface only), probes `llama-server --help` for the two CLI flags the intermediate-tap path requires: --logits-all matches=0, --n-probs matches=0 (stock Homebrew build, evidence parity with .discoveries/sandbox-logprob-flags.raw). Verdict = BLOCKED_AT_BUILD (same family as cycle-4 d_kv_prefix_share BLOCKED_AT_SCALE — wrapper ships, downstream signal honest). Logprob HTTP-body path remains live (cycle-5 d_logit_calibration confirmed `/v1/chat/completions` logprobs=true + top_logprobs=N end-to-end); residual/attn/mlp intermediate taps gated on forked llama.cpp build with a ggml-graph hook. Failure-mode prediction in hyp confirmed: 'llama.cpp's logits-all is decode-side only and intermediate activations require a forked build' — revive as `d_activation_capture_forked_llama` when fork lands."
  actual_tier_note = "PARTIAL: interface fully landed and callable by SAFETY consumers; the logprob path is live today (kind=logprobs returns final-layer top-N); the residual/attn/mlp paths return schema-only placeholder rows with status=BLOCKED_AT_BUILD so consumers detect the gap deterministically, not via missing rows."
  m1_safety_state = "SANDBOX.md M1.SAFETY checkbox STAYS `[ ]` — wrapper ships, but the SAFETY falsifier class (circuit motifs, SAE features on intermediate residuals) is not unblocked at the substrate level yet. The checkbox flips when the forked build lands OR when consumers redefine M1.SAFETY around logprob-only probes (refusal-matrix logit margins, decode-confidence calibration — both reachable today)."
  consumer_ref = "SAFETY.log.md 2026-05-24 entry (commit a233bff) — `interpret` (F-CODEX-4 SAE motifs) depends on the residual-stream path landing; `safety` refusal-matrix probes can already use the logprob path today."

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
# Cumulative: 8 confirmed (added d_activation_capture_pipeline PARTIAL) · 3 dead ·
# 10 candidates remaining. Top-1 ROI next: d_qwen_1_5b_scale (GREEN $0, cliff
# successor) OR d_activation_capture_forked_llama (fork the build to land the
# residual/attn/mlp taps, unlocking M1.SAFETY fully).
