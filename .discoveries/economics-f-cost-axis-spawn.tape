@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "economics-f-cost-axis-spawn"
  source = "ECONOMICS NOVEL 축 F spawned from cycle-34 E1 publication-bias bottleneck (cycle-35)"
  date   = "2026-05-27"
  flow   = "cycle-34-E1-n=11-PARITY (publication-bias bottleneck @ MoE pool ≈ 11) -> orthogonal-axis spawn: F = inference-substrate efficiency scaling laws (cx_discovery_log · cx_discovery)"

# ════════════════════════════════════════════════════════════════════
# CONTEXT — why F spawns from E1's publication-bias wall
# ════════════════════════════════════════════════════════════════════
# E1 (MoE active-param vs dense Chinchilla scaling-law divergence, cycle-27→34)
# matured to n=11 PARITY with 4-batch sign preservation (POS, |z|=0.558,
# p≈0.58 INSUFFICIENT but directional). The frontier is OPEN
# ([[feedback_closure_is_physical_limit]]) but the cheapest-next-step
# (collect more MoE landings) hit a HARD oracle bottleneck:
#
#   D-disclosed MoE pool ≈ 11 — Mistral family (Mixtral 8x7B / 8x22B /
#   Large-2 / Pixtral) all D-undisclosed; Grok-1 + Hunyuan-A13B
#   HTTP 403/401. n≥20 for KS p<0.05 is publication-bias-blocked, not
#   compute-blocked.
#
# Rather than wait for vendors to disclose D, SPAWN a new perpetual axis
# (F) that is ORTHOGONAL to A-E (which are all training-time
# scaling-law / Chinchilla family). The F-family is **inference-substrate
# efficiency** — every seed is MEASURABLE on local hardware (SANDBOX
# llama-server / vLLM / nvidia-smi power telemetry), so the falsifier
# is gated on substrate experiments NOT on vendor D-disclosure.
#
# A-E recap (training-side):
#   A — F-CODEX-1 scale-cost residual (4-rung Stage-2)
#   B — measured 2-component cost model generalization (decode/prefill)
#   C — Pareto cost-quality envelope (per-landing fits)
#   D — 신규 비용 축 seed backlog (energy/$ · KV cache · spec-dec · vLLM · Sardana)
#   E — MoE active-param vs dense Chinchilla divergence (publication-bias bottlenecked)
#
# F-family (inference-side scaling laws):
#   F1 — Per-token energy (J/tok) scaling exponent vs N
#   F2 — KV-cache memory growth law vs (context, batch, heads)
#   F3 — Speculative-decoding speedup exponent vs (α, N_draft/N_target)
#   F5 — Quantization tax (quality-per-bit) scaling exponent
#
# Note on F4 (Sardana envelope) — already covered by D1 seed 5
# (d_econ_d1_inference_amortization_envelope) + E1 seed 3
# (d_econ_e1_moe_sardana_envelope). Not duplicated in F.
#
# Note on F6/F7/F8 (routing overhead / distillation / TFTT) — deferred.
# F6 (routing overhead) is a sub-axis of F2/E1 fusion (covered when E1
# inference probes fire). F7 (distillation envelope) lacks a strong
# independent external anchor (most distillation papers report
# point-pairs, not scaling laws). F8 (TFTT cold-warm) is a SUBSTRATE
# axis (P4/P5 family) — would mis-classify as ECONOMICS.
#
# Falsifier discipline (cx_lab_falsifiable + feedback_negative_paper_external_claim):
# every F seed names an INDEPENDENT external published claim (Patterson
# 2021 J/tok · Pope 2023 KV-bandwidth · Leviathan 2023 spec-dec · Dettmers
# 2023 4-bit Pareto · Liu 2024 LLM.int8 / GPTQ family) so the falsifier
# targets a PUBLISHED scaling-law claim, not a self-generated strawman.
#
# Distinct from D1: D1 seeds are POINT-measurement cost reframings
# (J/tok × $/kWh → $/tok at one substrate config). F seeds are
# SCALING-LAW exponent fits (J/tok ∝ N^k_energy across an N-ladder),
# i.e. F is to D1 what C (Pareto fit) is to single landings. F asks:
# does the inference-substrate cost surface obey a closed-form
# exponential law, and which published exponent claim does the
# substrate falsify?

# ════════════════════════════════════════════════════════════════════
# F1 — Per-token energy (J/tok) scaling law vs N
# ════════════════════════════════════════════════════════════════════

@C d_econ_f1_energy_per_token_scaling_law := "J/tok ∝ N^k_energy — does per-token decode energy follow a closed-form power law in active params, and what is k_energy on a fixed substrate?" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness verify/numerics_economics_f1_energy_per_token_scaling.hexa — cheapest first probe = closed-form WebFetch + recompute, NO substrate run, $0. Stage 1: collect ≥4 published J/tok measurements for the same family at different N — candidate sources: (a) Patterson et al. 2021 'Carbon Emissions and Large Neural Network Training' (https://arxiv.org/abs/2104.10350) Table 3 J/inference per model, (b) NVIDIA MLPerf Inference v4.0 results (https://mlcommons.org/benchmarks/inference-datacenter/) energy track for Llama2-7B/13B/70B + Llama3-8B/70B, (c) Wu et al. 2022 'Sustainable AI' (Meta) per-model J/query. Stage 2: log-log OLS slope k_energy on (N, J/tok) for same-architecture family at same hardware. Stage 3: if k_energy fits a closed-form (k_energy ≈ 1.0 = linear-in-N, the FLOP-floor prediction; k_energy < 1 = sub-linear, memory-bandwidth-wall regime; k_energy > 1 = super-linear, communication-overhead regime), emit verdict tier per recipe §3 ladder. Stage 4 (optional cycle-37+ T4): SANDBOX nvidia-smi --query-gpu=power.draw --loop-ms=100 on ubu-1 for Qwen2.5-{0.5B,1.5B,3B,7B}-Q4_K_M on the Stage-2 manifest (reuse SANDBOX P4 d_p4_energy_per_token harness) → measured-on-substrate vs published-MLPerf slope comparison."
  hyp     = "k_energy ≈ 1.0 (linear-in-N) for compute-bound decode regime BUT k_energy < 1.0 (sub-linear, ≈ 0.5–0.7) for memory-bandwidth-bound decode regime — i.e. the published MLPerf energy-per-inference numbers should show k_energy < 1 on modern HBM-bandwidth-bound hardware (H100/A100). Linear-in-N (k_energy = 1) would only emerge on compute-saturated configurations (huge batch + small context)."
  verdict = "PENDING — closed-form first probe ($0). External anchor: Patterson 2021 (Table 3 per-model J/inference) + MLPerf Inference v4.0 energy track. Falsifier: if k_energy = 1.0 within ε = 0.10 across published Llama2/Llama3 family on H100/A100, the memory-bandwidth-wall claim is FALSIFIED for the energy axis — decode energy IS linear in FLOPs at production scale and the substrate-side optimization should focus on FLOP reduction (quantization, sparsity) rather than bandwidth reduction (KV-cache compression, prefill caching). Conversely, if k_energy < 0.7, energy-per-FLOP is HARDWARE-DOMINATED not model-dominated, and the operational guideline 'energy scales with model size' is materially wrong — energy scales with hardware regime, and bigger models on the same hardware pay sub-linear energy cost. Distinct from D1's $/tok seed (D1 multiplies J/tok by a fixed $/kWh; F1 asks whether J/tok ITSELF follows a scaling law)."

# ════════════════════════════════════════════════════════════════════
# F2 — KV-cache memory growth law vs (context, batch, heads)
# ════════════════════════════════════════════════════════════════════

@C d_econ_f2_kv_cache_memory_law := "KV-cache bytes ∝ context^p_ctx · batch^p_batch · heads^p_heads — closed-form law for HBM occupancy on multi-tenant inference, and where does Grouped-Query Attention (GQA) / Multi-Query Attention (MQA) break the dense linear-in-heads law?" :: seed [verified_tier_target=BLUE status=open]
  cmd     = "harness verify/numerics_economics_f2_kv_cache_memory_law.hexa — Tier-BLUE closed-form recompute, NO substrate run, $0. Stage 1: derive the KV-cache footprint formula per Ainslie et al. 2023 'GQA: Training Generalized Multi-Query Transformer Models' (https://arxiv.org/abs/2305.13245): KV_bytes = 2 × batch × ctx × n_layers × n_kv_heads × d_head × bytes_per_element where (a) MHA: n_kv_heads = n_heads, (b) GQA: n_kv_heads = n_heads / G (G = group size), (c) MQA: n_kv_heads = 1. Stage 2: verify the closed-form on 5 reference configs: Llama2-70B (MHA, n_heads=64) · Llama3-70B (GQA, n_heads=64/G=8) · Llama3-8B (GQA, n_heads=32/G=4) · Mistral-7B (GQA, G=4) · Falcon-180B (MQA, n_kv_heads=1) at fixed ctx=8192/batch=1 → predicted vs published HBM-occupancy numbers. Stage 3: emit per-axis verdict for the 3 exponents (p_ctx, p_batch, p_heads-effective-after-GQA). Stage 4 (optional cycle-37+ T4): SANDBOX llama-server with --kv-cache-size flag or nvidia-smi --query-gpu=memory.used during prefill on Qwen2.5-1.5B-Q4_K_M (GQA G=4) at ctx ∈ {1k, 2k, 4k, 8k, 16k} to confirm the linear-in-ctx slope."
  hyp     = "All 3 exponents = 1.0 EXACTLY (KV-cache is bilinear in ctx and batch, linear in n_kv_heads); GQA/MQA bend the heads exponent ONLY through the n_kv_heads coefficient, not the exponent — i.e. the formula KV_bytes = 2 × b × ctx × L × n_kv × d_h × dtype_bytes is EXACT for all standard attention variants. The interesting closed-form question is the GQA EFFECTIVE-heads ratio: dense Llama2-70B (MHA, 64 heads) vs Llama3-70B (GQA G=8, n_kv=8) is an 8× memory reduction at iso-context."
  verdict = "PENDING — closed-form first probe ($0, recompute only). External anchor: Ainslie et al. 2023 (GQA, https://arxiv.org/abs/2305.13245) + Shazeer 2019 'Fast Transformer Decoding' (MQA, https://arxiv.org/abs/1911.02150) + Pope et al. 2023 'Efficiently Scaling Transformer Inference' (https://arxiv.org/abs/2211.05102, memory-bandwidth-bound decode characterization). Falsifier: if the closed-form predicts HBM-occupancy that mismatches published per-model numbers by ε > 5% on ANY of the 5 reference configs, then either (a) the formula is missing a term (e.g. attention-sink fixed overhead per Xiao 2024) or (b) the published numbers include non-KV overhead (activations, optimizer state for training-mode inference). Either outcome is a FALSIFICATION of the textbook KV-bytes closed-form and forces the ECONOMICS group to ship a corrected per-model surface. Distinct from D1's KV-cache amortization seed (D1 measures $/decoded-token regime change with prefix-cache reuse; F2 asks whether the underlying byte-count law is correct in closed form). Distinct from E1: F2 is dense + MoE agnostic (KV depends on attention shape, not on FFN routing)."

# ════════════════════════════════════════════════════════════════════
# F3 — Speculative-decoding speedup exponent vs (α, draft/target ratio)
# ════════════════════════════════════════════════════════════════════

@C d_econ_f3_speculative_decoding_speedup_law := "Leviathan-Kalman s(α, c, N) = (1−α^(N+1))/((1−α)(cN+1)) — does the closed-form speedup law hold on real substrates, and what is the empirical α distribution across prompt classes that determines the deployment-realistic speedup?" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness verify/numerics_economics_f3_spec_dec_speedup.hexa — cheapest first probe = closed-form recompute of Leviathan-Kalman 2023 speedup formula at 6 (α, c, N) operating points + WebFetch of published per-prompt-class α measurements, NO substrate run, $0. Stage 1: closed-form s(α, c, N) at (α, c, N) ∈ {(0.3, 0.1, 4), (0.5, 0.1, 4), (0.7, 0.1, 4), (0.7, 0.1, 8), (0.7, 0.1, 16), (0.9, 0.1, 8)} → 6-point reference table; verify against Leviathan-Kalman 2023 Table 2. Stage 2: collect published per-prompt-class α from (a) Leviathan & Kalman 2023 (https://arxiv.org/abs/2211.17192) Table 2 — English-to-German α=0.75, summarization α=0.85, (b) Chen et al. 2023 'Accelerating LLM Inference with Staged Speculative Decoding' (https://arxiv.org/abs/2308.04623), (c) Cai et al. 2024 'Medusa' (https://arxiv.org/abs/2401.10774) for staged-decode α distribution. Stage 3: fit α distribution to (prompt_class → α) and compute deployment-weighted-average s for a realistic prompt mix; verify against any published end-to-end serving speedup (e.g. NVIDIA TensorRT-LLM speculative-decoding benchmarks). Stage 4 (optional cycle-37+ T4): reuse SANDBOX P4 d_p4_speculative_decoding harness on ubu-1 with Qwen2.5-3B-Instruct-Q4_K_M target + Qwen2.5-0.5B-Instruct-Q4_K_M draft over the 4-class manifest (arith/definition/long-form/code) → measured α per class + measured s vs closed-form prediction."
  hyp     = "Closed-form Leviathan-Kalman s formula matches published Table 2 within ε = 1% at all 6 operating points (algebraic identity, this is a self-check). The empirically interesting claim: deployment-weighted-average α ≈ 0.5 in production prompt mixes (mixing code/long-form/dialogue) — NOT the headline α = 0.75–0.85 from translation/summarization benchmarks — which collapses the realistic speedup to s ≈ 1.5–2.0 rather than the headline s ≈ 2.5–3.0. The 'speculative decoding gives 2-3× speedup' published claim is OVERSTATED for general-purpose serving by a factor of ~1.5×."
  verdict = "PENDING — closed-form first probe ($0). External anchor: Leviathan & Kalman 2023 (https://arxiv.org/abs/2211.17192) ICML, Chen et al. 2023 staged speculative (https://arxiv.org/abs/2308.04623), Cai et al. 2024 Medusa (https://arxiv.org/abs/2401.10774). Falsifier: if the algebraic recompute mismatches Leviathan-Kalman Table 2 by ε > 1%, the formula transcription is wrong (computational error, low-stakes correction). The HIGH-STAKES falsifier: if deployment-weighted-average α in production mix is ≥ 0.7 (i.e. translation/summarization-class α generalizes to mixed-class serving), the 'realistic speedup ≈ 1.5×' claim is FALSIFIED and the published headline speedups DO transfer to production — speculative decoding is universally cost-effective. Conversely, if α ≤ 0.4 for any common prompt class (e.g. code), per-class routing of spec-dec-on/off is REQUIRED as deployment policy (sibling to D1 seed 2 d_econ_d1_speculative_decoding_dollar_saving)."

# ════════════════════════════════════════════════════════════════════
# F5 — Quantization tax (quality-per-bit) scaling exponent
# ════════════════════════════════════════════════════════════════════

@C d_econ_f5_quantization_tax_law := "Quality(b_bits) — does quality degradation as a function of weight-bit precision follow a closed-form law (Dettmers 2023 4-bit Pareto curve), and at what bit-width does the law break (quality cliff)?" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness verify/numerics_economics_f5_quantization_tax.hexa — cheapest first probe = closed-form WebFetch + recompute, NO substrate run, $0. Stage 1: collect published quality-vs-bits measurements for a family across {Q2, Q3, Q4, Q5, Q6, Q8, fp16} for at least 3 models — candidate sources: (a) Dettmers & Zettlemoyer 2023 'The case for 4-bit precision' (https://arxiv.org/abs/2212.09720) Table 1 zero-shot accuracy vs bits for LLaMA/OPT/BLOOM, (b) Frantar et al. 2023 'GPTQ' (https://arxiv.org/abs/2210.17323) perplexity vs bits, (c) Lin et al. 2023 'AWQ' (https://arxiv.org/abs/2306.00978) accuracy vs bits, (d) reuse SANDBOX P4 d_p4_quantization_band_ladder verdict (`.verdicts/sandbox/p4_quant_band_*`) for Qwen2.5-1.5B {Q3_K_M, Q4_K_M, Q8_0} measured on local substrate. Stage 2: fit closed-form quality(b) = q_max − k_quant × 2^(−b·γ) (exponential-decay-in-bits with rate γ) or quality(b) = q_max × (1 − exp(−(b − b_min)·γ)) (saturation-in-bits with knee b_min); compute γ per model family and per benchmark (zero-shot vs perplexity vs HumanEval+). Stage 3: identify the quality-cliff bit-width b_cliff where quality drops > 10% from q_max — predicted b_cliff = 3 bits per Dettmers 2023. Stage 4 (optional cycle-37+ T4): re-fit SANDBOX P4 measured points + extend to Q2/Q5/Q6 if available on the same model."
  hyp     = "Quality follows a saturation-in-bits curve quality(b) ≈ q_max × (1 − exp(−(b − 2)·γ)) with γ ≈ 0.5–0.7 per bit, knee b_min ≈ 3 bits, and approximate quality plateau at b ≥ 5 bits — i.e. Q4 is the cost-optimal point (close-to-plateau quality at half the bytes of Q8) and Q3 sits ON the cliff (steep quality loss). The published Dettmers 2023 'Q4 is the Pareto-optimal point' claim should hold within ε = 5% on modern (Llama3/Qwen2.5) families."
  verdict = "PENDING — closed-form first probe ($0). External anchor: Dettmers & Zettlemoyer 2023 (https://arxiv.org/abs/2212.09720) NeurIPS — independent published Pareto-optimal-bit claim, NOT self-generated. Falsifier: if the saturation-in-bits closed-form mismatches published or SANDBOX-measured points by ε > 10% at any bit-width ≥ 3, then quantization quality does NOT follow a single-parameter law and per-method (GPTQ vs AWQ vs k-quants) corrections are required — the operational guideline 'Q4 ≈ Q8 quality at 50% cost' becomes method-dependent rather than universal. Conversely, if b_cliff > 3 bits on modern families (i.e. Q3 still gives >95% quality), Dettmers' 4-bit Pareto-optimum claim is FALSIFIED in the opposite direction — Q3 is the new Pareto point and the cost surface should shift to 3-bit defaults. Distinct from SANDBOX P4 d_p4_quantization_band_ladder (P4 measures point accuracy per band; F5 fits the closed-form law across the band)."

# ════════════════════════════════════════════════════════════════════
# CROSS-CYCLE LINKAGE
# ════════════════════════════════════════════════════════════════════
# - cycle-34 E1: n=11 PARITY · 4-batch sign preservation · publication-bias
#   bottleneck (D-disclosed MoE pool ≈ 11)
# - cycle-35 F-spawn (this tape): orthogonal-axis spawn to bypass the
#   publication-bias wall — F seeds are SUBSTRATE-MEASURABLE, not vendor-
#   D-disclosure-gated
# - F1 first probe (cheapest): closed-form WebFetch + recompute on
#   Patterson 2021 + MLPerf Inference v4.0 ($0, no substrate run)
# - F2 first probe: closed-form recompute of GQA byte-count formula
#   against 5 reference configs ($0, BLUE tier)
# - F3 first probe: closed-form recompute of Leviathan-Kalman speedup at
#   6 operating points + WebFetch α distribution ($0)
# - F5 first probe: closed-form recompute of Dettmers saturation-in-bits
#   curve against published + SANDBOX P4 measured points ($0)
# - F2-F5 all reuse SANDBOX P4 verdicts (KV-cache · spec-dec · quant-band)
#   as substrate-side empirical inputs — F is the COST-SCALING-LAW
#   reframing of the same physical surface, sibling to D1's $-reframing
#
# Honest residual:
# - F is the inference-side counterpart to A-E (training-side). F seeds
#   are orthogonal axes; none gives a Chinchilla-class universal law
#   in a single batch. Each F probe needs ≥3 substrates / ≥3 families
#   to escalate from YELLOW citation-only → GREEN substrate-measured.
# - F1 publication risk: MLPerf Inference energy track may not have
#   per-bit-of-precision breakdown; if substrate-side fits diverge from
#   published MLPerf, the H100 vs A100 hardware-regime split may
#   dominate the scaling law and F1 must split into per-hardware sublanes.
# - F2 algebraic risk: the closed-form is a textbook identity; the
#   interesting falsification is in the GQA effective-heads accounting —
#   if any vendor publishes n_kv_heads that doesn't match HF config.json,
#   the law breaks at the disclosure boundary (not the physics boundary).
# - F3 α-distribution risk: production α is workload-dependent; the
#   "deployment-weighted-average α ≈ 0.5" hypothesis is anecdotal until
#   ≥3 production-mix datasets are measured. cycle-37+ T4 needed.
# - F5 method risk: Dettmers k-quants ≠ GPTQ ≠ AWQ at the same nominal
#   bit-width; the saturation-in-bits law may need per-method γ. If so,
#   F5 splits into F5a (k-quants), F5b (GPTQ), F5c (AWQ) sub-lanes.
# - F frontier is OPEN ([[feedback_closure_is_physical_limit]]) —
#   even if all 4 first probes close GREEN in cycle-36, the inference-
#   substrate efficiency surface keeps reopening on new hardware (B200,
#   MI300X, TPU v5p) and new attention variants (sliding window, MoE
#   routing overhead, latent attention). No 100% closure by design.
