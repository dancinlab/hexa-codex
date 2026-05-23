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

@C d_stage0_poc := "PoC dispatch — OSS pretrained (Qwen2.5-0.5B) + llama.cpp on mac, accuracy floor on canonical 20-task manifest" :: candidate [target_tier=GREEN cost_est=$0]
  cmd = "wire lm_foundry/tool/route_dispatch.hexa (claude + llama_cpp unified surface), run 20-task pass, measure accuracy + serving-cost telemetry"
  hyp = "OSS pretrained 0.5B-class model achieves >= 15/20 on the canonical manifest at $0 marginal vendor spend (electricity-only) — substrate viable as a Stage-1 base"

@C d_stage1_persona := "tier-persona — single base + temperature/max-tok 3-tier (nano/mid/max mock haiku/sonnet/opus), seed-pinned determinism" :: candidate [target_tier=GREEN cost_est=$0]
  cmd = "instantiate 3 personas (nano: T=0 max_tok=32 / mid: T=0 max_tok=256 / max: T=0 max_tok=1024) over the Stage-0 base; rerun length-router 2-tier; compare $/task ratio vs the Anthropic 1:5:25 grid"
  hyp = "tier-ratio under self-hosting reproduces the cycle-1/2 length-router 81.79% saving rank-order within Spearman ρ >= 0.9 — substrate is a valid stand-in for the API surface"

@C d_stage2_scale_manifest := "scale manifest — `.hexa` task generator emitting N >= 2000 stratified prompts, wc ∈ [5, 200]" :: candidate [target_tier=GREEN cost_est=$0]
  cmd = "write task_generator.hexa producing N=2000 prompts stratified across {arithmetic, code, recall, reasoning, summarization} × wc-bin {5-14, 15-30, 31-60, 61-120, 121-200}; serve via Stage-1 persona; capture per-task tier-routing + accuracy"
  hyp = "wc ∈ [15, 200] regime EXITS the cycle-2 d_threshold_sweep degeneracy (wc-saturated at 14) — at least one τ ∈ {30, 50, 80, 120} actually splits the manifest, exposing the τ-axis frontier"

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

@C d_early_stop_local := "early-stop stop-token list — vLLM/llama.cpp `stop=` parameter (was BLOCKED on CLI)" :: candidate [target_tier=GREEN cost_est=$0]
  cmd = "for the 20-task canonical manifest under Stage-1 persona, enable stop=['\\n\\n', 'Note:', 'Answer:'] on nano tier; compare output_tok and accuracy vs no-stop baseline"
  hyp = "nano-tier stop-token list cuts output_tok median by >= 30% at 0pp accuracy loss — d_response_budget_cap's pathological backfire (cycle-2: haiku quoting the cap into prose) disappears because stop= acts at the decoder level, not the prompt level"

@C d_prompt_compress_local := "prompt-compression — LLMLingua local model on Stage-2 wc>=30 prompts (was DEGENERATE on wc<=14 manifest)" :: candidate [target_tier=GREEN cost_est=$0]
  cmd = "run LLMLingua-2 ratio=0.5 on the Stage-2 wc∈[31,200] strata; compare $/task and accuracy vs uncompressed; require the wc<=14 strata pass through uncompressed (degenerate floor)"
  hyp = "compression saves >= 15% input-token cost on wc>=30 strata at 0pp accuracy loss; cycle-2 d_prompt_compress (DEGENERATE) was a manifest-shape artifact, not a fundamental dead end — substrate change + manifest reshape jointly recover the axis"

# ── kick round 1 new orthogonal axes (substrate-unlocked, not in SANDBOX.md ladder) ──

@C d_logit_calibration := "logit calibration — temperature-scaling / Platt fit on self-hosted logits → confidence-gated routing rescued" :: candidate [target_tier=GREEN cost_est=$0]
  cmd = "expose vLLM logprobs on Stage-1 nano-tier; fit temperature-scaling on Stage-2 dev split for calibration ECE; reuse cycle-1 d_confidence_gated policy (conf < τ → upgrade tier) with calibrated probabilities"
  hyp = "calibrated confidence-gated routing beats length-router by >= 3pp at 20/20 on canonical manifest — cycle-1 d_confidence_gated (dead at 55.59% / 19/20) failed on UNCALIBRATED Anthropic API token-logprobs proxy; substrate-level logits + ECE-minimising rescaling close the gap"

@C d_kv_prefix_share := "KV-prefix sharing — multi-prompt vLLM batch with shared system-prompt prefix amortizes prefill" :: candidate [target_tier=GREEN cost_est=$0]
  cmd = "issue Stage-2 batched requests to vLLM with shared --system-prompt; measure prefill-token re-cost (should be ~1× across the batch); compare amortized $/task vs serial dispatch"
  hyp = "KV-prefix sharing reduces amortized prefill cost by >= (1 - 1/B) of the system-prompt token count on a batch size B — substrate-only lever orthogonal to per-prompt routing policy (combines additively with length-router); cycle-1 d_batch_amortized (50% batch-tier discount, never measured) is subsumed and superseded by this finer-grained surface"

@C d_speculative_decode_model := "model-level speculative decoding — small draft (0.5B) + verify on large target (7B), token-level (NOT cycle-2 tier-level)" :: candidate [target_tier=GREEN cost_est=$0]
  cmd = "wire llama.cpp `--draft-model` (Qwen2.5-0.5B drafts Qwen2.5-7B target) on Stage-2 wc>=30 strata; measure tok/s and $/task vs target-only"
  hyp = "model-level speculative decoding cuts wall-clock $/task by >= 30% on wc>=30 strata at bit-for-bit identical output (verify-exact) — cycle-2 d_speculative_draft was tier-level architecture (haiku draft + sonnet verify-or-rewrite, dominated $0.139@19/20); model-level speculation is an ENTIRELY different mechanism only reachable below the API"

@C d_quantization_tier := "quantization-tier — Q4_K_M vs Q8_0 vs FP16 as a 3rd routing axis (cost ∝ memory bandwidth, not tokens)" :: candidate [target_tier=GREEN cost_est=$0]
  cmd = "serve 3 quants of the Stage-1 base via llama.cpp, treat as nano/mid/max alternative; rerun length-router 2-tier with (Q4, FP16) cutoff vs the persona 2-tier; compare $/task + accuracy"
  hyp = "quantization-tier router (Q4 below cutoff / FP16 above) matches or beats persona-tier saving on the Stage-2 manifest at <= 1pp accuracy drop — an axis the API surface does not expose at all (vendor abstracts the quant) and a candidate for F-CODEX-2 cost-scale enrichment"

# ── summary ──
# round 1 cumulative: 0 confirmed · 0 dead · 12 candidates inventoried
#   5 SANDBOX.md ladder (d_stage0_poc → d_stage4_empirical_landing)
# + 3 cycle-2 BLOCKED revivals (d_cache_aware_local, d_early_stop_local, d_prompt_compress_local)
# + 4 kick round-1 orthogonal axes (d_logit_calibration, d_kv_prefix_share,
#     d_speculative_decode_model, d_quantization_tier)
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
