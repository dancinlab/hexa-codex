@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "sandbox-p4-new-axes"
  source = "SANDBOX perpetual axis P4 — 'API 가 못 닿는 측정축' first sweep (cycle-21, post-v1.4.0 first-arc closure)"
  date   = "2026-05-26"
  flow   = "first-arc-closed -> perpetual-axes-opened -> P4 (new measurement axes the external API cannot expose) seed batch (cx_discovery_log)"

# ════════════════════════════════════════════════════════════════════
# CONTEXT — what P4 is and what it must cover
# ════════════════════════════════════════════════════════════════════
# SANDBOX.md §영구 축 P4 = "API 가 못 닿는 것 — 토큰당 에너지 · speculative
# decoding · 활성화 캡처 신규 backend(M1.SAFETY+ HF lane 확장) seed
# → .discoveries/sandbox.tape". This tape is the first concrete population
# of that lane after the M1–M5 first-arc release (v1.4.0, 2026-05-25).
#
# Selection rule (g0 Occam + cx_empirical_contact): each candidate must be
# (a) measurable ONLY on a self-hosted substrate (the metered API cannot
# expose the axis at all), (b) recompute-friendly under hexa-native
# verifiers (closed-form law candidate exists), and (c) cheap enough that
# a first-rung smoke fits a $0 local cycle (mac mini or ubu-1).
#
# Five candidate axes seeded below, stratified by surface (energy / decode
# strategy / activation backend / cache policy / quantization band). Each
# carries a falsifier candidate so the seed inherits cx_lab_falsifiable
# even before the harness lands.

@C d_p4_energy_per_token := "tokens-per-Joule curve via host power telemetry (NEW measurement axis)" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness bench/sandbox_p4_energy_per_token.hexa — sample mac powermetrics --samplers cpu_power,gpu_power (M3 Metal/UMA, 1 Hz) wrapping llama-server generate of a fixed manifest (Stage-2 N=200 subset at wc_5_30); compute J/tok = ∫P dt / total_decoded_tokens; ladder across 3 model sizes (Qwen2.5 0.5B/1.5B/3B Q4_K_M) and 2 batch settings (-np 1 vs -np 4); recompute by verify/numerics_substrate_energy_per_token.hexa"
  hyp     = "J/tok scales monotonically with model parameter count (rough proxy: FLOPs/tok × 1/(perf_ceiling); larger model → more J/tok) AND with -np (more parallel slots amortize fixed host idle power, so J/tok DECREASES with -np up to mem-bw saturation)"
  verdict = "PENDING — first energy probe on the substrate. Mac M3 powermetrics root-only (sudo), so ubu-1 nvidia-smi --query-gpu=power.draw --loop-ms=100 is the $0 alternative path. Falsifier: if J/tok stays flat across the 3-rung ladder, the cost model is dominated by host idle power, not compute — a substrate-architecture finding."

@C d_p4_speculative_decoding := "draft-model speculative decoding speedup vs acceptance-rate trade (NEW decode-strategy axis)" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness bench/sandbox_p4_speculative_decoding.hexa — llama-server -m Qwen2.5-3B-Instruct-Q4_K_M -md Qwen2.5-0.5B-Instruct-Q4_K_M --draft 4 (and 8, 16); measure wall_ms_per_token + acceptance_rate (server logs report accepted/proposed); ladder over 4 manifest classes (arith / definition / long-form / code); recompute by verify/numerics_substrate_speculative_speedup.hexa against the closed-form speedup law (Leviathan-Kalman 2023) s = (1 − α^(N+1))/((1 − α)·(c·N + 1)) where α=accept-rate, N=draft-tokens, c=draft-cost/target-cost ratio"
  hyp     = "speculative decoding gives ≥1.5× wall-clock speedup when draft model is ≥6× smaller AND acceptance rate ≥0.6 (Leviathan-Kalman optimum near N≈α/(1-α) draft tokens)"
  verdict = "PENDING — first speculative-decoding probe. The closed-form law is exact under the standard assumption (independent acceptance per token); the bench delivers measured α and measured s, and the verifier checks |s_measured − s_predicted| ≤ ε. Falsifier: if measured s undershoots predicted s by >25% with α matched, the substrate has serialization overhead the model doesn't capture (e.g. KV recompute on rollback) — a substrate-implementation finding."

@C d_p4_activation_backend_vllm := "vLLM as a second activation-capture backend alongside transformers+hooks (M1.SAFETY+ lane extension)" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness bench/sandbox_p4_activation_capture_vllm.hexa — vLLM 0.6+ output_hidden_states pathway (LLMEngine.add_request with sampling_params returning hidden_states); produce the SAME TSV schema_version='v1' as activation_capture_hf.hexa on the SAME 40-row matched-pair refusal set (PRIVATE dataset dancinlab/hexa-codex-sandbox-adversarial-evals-v1); cross-check by recomputing the M2.SAFETY refusal-direction AUROC and verifying |AUROC_vllm − AUROC_hf| ≤ 0.02 on the held-out LOO"
  hyp     = "vLLM batched activation capture produces the same refusal-direction motif (AUROC ≥0.96, within ±0.02 of the HF backend's 0.98) at ≥3× throughput (vLLM's continuous-batching scheduler vs HF synchronous .generate)"
  verdict = "PENDING — extends M1.SAFETY+ from one backend (HF transformers+hooks, cycle-12) to two (HF + vLLM). vLLM 0.6+ exposes output_hidden_states through the LLMEngine path though the high-level LLM class hides it; the harness needs the engine-level call. Falsifier: if AUROC diverges >0.05 between backends on the same data, one backend has a precision/quantization difference that breaks the motif — a backend-fidelity finding. Cheaper if ubu-1 already has vLLM 0.7.3 from the lm_foundry GRPO stack."

@C d_p4_kv_eviction_attention_sink := "StreamingLLM attention-sink + sliding-window KV eviction effect on long-context decode (NEW cache-policy axis)" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness bench/sandbox_p4_kv_eviction.hexa — llama-server --rope-scaling none --no-context-shift baseline vs --rope-scaling none + a fixed sliding window (e.g. context_size 2048 with sink_tokens=4 if exposed; otherwise prompt-side sink injection); 4 context rungs from M3.ECON (1k/2k/4k/8k) measuring (a) wall_ms_per_decoded_token, (b) byte-exact-subset accuracy on a long-context recall manifest (needle-in-haystack at depth ∈ {0.25,0.50,0.75,0.95}); recompute by verify/numerics_substrate_kv_eviction.hexa"
  hyp     = "sliding-window + 4 sink tokens preserves >90% needle-recall at depth ≤0.50 while reducing decode wall_ms by ≥30% at 8k context (the StreamingLLM trade — bounded KV, modest recall loss at shallow depth, sharp recall loss at deep depth)"
  verdict = "PENDING — first cache-policy probe. llama.cpp upstream sink-token surface is unstable (check 9150-tag for current CLI flags); if absent, the cheaper proxy is --context-shift (always-on KV roll) vs --no-context-shift on the same 8k manifest. Falsifier: if needle-recall holds flat (no sink-token benefit at deep depth) the substrate's attention-sink mechanism isn't load-bearing on Qwen2.5-1.5B at this scale — a substrate-architecture finding."

@C d_p4_quantization_band_ladder := "Q2/Q3/Q4/Q5/Q6/Q8 quant ladder accuracy-vs-speed Pareto (NEW quant-band axis)" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness bench/sandbox_p4_quant_ladder.hexa — Qwen2.5-1.5B-Instruct GGUF in 6 quant bands {Q2_K, Q3_K_M, Q4_K_M, Q5_K_M, Q6_K, Q8_0} on the SAME Stage-2 N=2000 manifest; measure (a) byte-exact-subset accuracy per band, (b) tok/s per band, (c) RSS per band; closed-form fit: accuracy(bits_per_weight) is conjectured to be a concave saturating curve (1/(1+exp(-k(b-b0))) again); recompute by verify/numerics_substrate_quant_pareto.hexa"
  hyp     = "accuracy saturates at Q4_K_M or above (Δ ≤2pp between Q4_K_M and Q8_0) but Q3_K_M shows >5pp drop and Q2_K shows >15pp drop — i.e. the Pareto knee sits at Q4 for Qwen2.5-1.5B"
  verdict = "PENDING — first quant-band ladder on the SUBSTRATE side (distinct from BitNet domain's true-1.58bit lane). 6 GGUFs ≈ 6×1.0GB local download (Qwen2.5-1.5B model card lists all 6). Falsifier: if accuracy degrades monotonically through Q4→Q8 without a knee, the substrate's calibration is anomalous — likely a manifest-leakage artifact, recheck the manifest. The CHEAPEST first-probe variant: 3 bands {Q3_K_M, Q4_K_M, Q8_0} on N=200, then full ladder if the knee is detectable."
