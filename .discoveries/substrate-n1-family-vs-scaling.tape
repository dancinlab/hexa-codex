@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "substrate-n1-family-vs-scaling"
  source = "SUBSTRATE NOVEL 축 N1 spawned from cycle-23c P1 BREAKTHROUGH + cycle-24 multimodal_fit honest residual (cycle-28)"
  date   = "2026-05-27"
  flow   = "cycle-23c-P1-finding -> cycle-24-honest-residual -> cycle-26/27-family-confound-echo -> novel axis N1 seed (cx_discovery_log)"

# ════════════════════════════════════════════════════════════════════
# CONTEXT — why N1 spawns from cycle-23c P1 + cycle-24 honest residual
# ════════════════════════════════════════════════════════════════════
# cycle-23c P1 BREAKTHROUGH (.verdicts/sandbox/p1_multimodal_ladder_7b.tsv,
# 4-rung × 16-item VL ladder) found Qwen-VL-7B counting RECOVERS to 5/5
# from the Qwen-VL-3B 2/5 dip — non-monotone overall (0.81 → 0.94 → 0.81
# → 1.00). cycle-24 verifier (verify/numerics_substrate_multimodal_fit.hexa,
# extended 304→499 lines) recomputed the 4-rung curve closed-form and
# flagged an HONEST RESIDUAL:
#
#   "7B counting recovery cannot discriminate 'subitizing emerges at scale'
#    from 'Qwen2.5-VL-7B-specifically subitizes well' — needs a 5th rung
#    at a non-Qwen-7B."
#
# The same family-confound pattern echoes across the codex:
#   - cycle-26 C1 ECONOMICS: 12 dense overtrain (D/N ∈ [22, 1875]),
#     only MoE (DeepSeek-V3 active-37B) hits Chinchilla 20.0 exact
#     → family vs scaling-law confound for dense vs MoE
#   - cycle-27 ECONOMICS E1: NOVEL axis spawned to test
#     MoE-vs-dense divergence (n=1 MoE = anecdote, ≥3 MoE for KS-test)
#
# For SUBSTRATE specifically: every capability claim is currently
# CONFOUNDED by model-family. The cycle-23c 4-rung ladder is
# SmolVLM-family (rungs 0+1, 0.5B+2.2B) + Qwen-VL-family (rungs 2+3,
# 3.0B+7.0B). The dip-then-recover is ENTIRELY within the Qwen split.
# This is a 2-family × 2-rung-each anecdote, NOT a controlled
# cross-family fire — but it IS empirically detectable from the
# committed TSV with a closed-form per-family slope decomposition.
#
# This seed batch is the perpetual axis N1 first-probe + 2 follow-on
# probes for cycle-29+ (non-Qwen-7B VL DL + cross-family text cliff).
# ⭐ MAIN priority lane — gates every downstream capability claim.

@C d_substrate_n1_family_vs_scale_split := "cycle-23c 4-rung TSV per-family slope decomposition" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness verify/numerics_substrate_n1_family_vs_scaling.hexa — partition the cycle-23c 4-rung TSV (.verdicts/sandbox/p1_multimodal_ladder_7b.tsv) by model_name regex: SmolVLM-family rows (0.5B SmolVLM-500M + 2.2B SmolVLM2-2.2B) vs Qwen-VL-family rows (3.0B Qwen2.5-VL-3B + 7.0B Qwen2.5-VL-7B). Compute per-family counting accuracy slope (linear regression on log2(params)). If SmolVLM slope > 0 AND Qwen has dip (rung-2 < rung-3 boundary), family confound is empirically DETECTABLE at the data we already own ($0 closed-form recompute, no substrate fire)."
  hyp     = "per-family slope decomposition reveals SmolVLM-family monotone-rising counting + Qwen-VL-family dip-then-recover → family-confound signature visible in n=2 family pairs"
  verdict = "PENDING — cheapest first probe ($0 closed-form on committed TSV). External anchor: SmolVLM technical report (HuggingFaceTB/SmolVLM-Instruct model card, NeurIPS 2024 SmolLM-V paper), Qwen2.5-VL technical report (arXiv:2502.13923). Honest residual: n=2 family pairs is anecdote, not statistical evidence — true cross-family fire needs non-Qwen-7B at the matched scale rung (seed 2)."

@C d_substrate_n1_non_qwen_7b_vl_plan := "non-Qwen 7B VL rung DL + measure plan (InternVL-7B · LLaVA-NeXT-7B · Mistral-VL · Gemma-3-VL)" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness bench/sandbox_p1_multimodal_ladder_non_qwen_7b.hexa (NEW for cycle-29+) — DL one of {InternVL-7B-MPO, LLaVA-NeXT-7B, Pixtral-12B (close to 7B), Gemma-3-12B-it-vision} via ggml-org mirror or local convert (~5GB), re-run the cycle-23c 16-item harness with seed=42, byte-exact scoring. Compare 7B-non-Qwen vs 7B-Qwen on counting axis. Falsifier (BinomialSE-bound): if 7B-non-Qwen counting ∈ [3/5, 5/5] (≥3/5 = within Qwen's 5/5 BinomialSE at n=5), claim is family-universal (subitizing emerges at 7B scale). If 7B-non-Qwen counting ≤ 2/5 (same dip as 3B-Qwen or worse), claim is Qwen-specific (model anomaly)."
  hyp     = "non-Qwen-7B VL replicates Qwen-7B counting recovery (5/5 ± SE) → subitizing is scale-law universal, NOT Qwen-specific"
  verdict = "PENDING — cycle-29+ real fire (mac M3 local, ~5GB DL + 16-item harness ~10min wall, $0). External anchors: InternVL2.5 technical report (arXiv:2412.05271), LLaVA-NeXT blog (https://llava-vl.github.io/blog/2024-01-30-llava-next/), Mistral Pixtral technical report (arXiv:2410.07073), Gemma-3 technical report (Google DeepMind, 2026). Cheapest = InternVL-7B-MPO (ggml-org mirror exists) or LLaVA-NeXT-7B (community GGUF available)."

@C d_substrate_n1_text_cliff_cross_family := "wc_31_60 text cliff cross-family replication (Llama-3.1-8B · Mistral-7B-v0.3 · Gemma-3-9B vs Qwen2.5-7B)" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness bench/sandbox_stage2_persona_scaled_non_qwen_7b.hexa (NEW for cycle-29+) — Stage-2 persona-scaled manifest (cycle-6 N=2000, 5 wc strata) re-run on 7B non-Qwen base: Llama-3.1-8B-Instruct-Q4_K_M (bartowski GGUF) or Mistral-7B-Instruct-v0.3-Q4_K_M (bartowski GGUF). Compare wc_31_60 cliff accuracy at 7B non-Qwen vs 7B Qwen (cycle-12 measured wc_31_60=~50% at Qwen-7B). Falsifier: if non-Qwen-7B wc_31_60 ∈ [40%, 60%] (Qwen-7B ± 10pp absolute), cliff is scale-law universal. If non-Qwen-7B wc_31_60 << 40% or stays at 0.5B-floor (~6%), the cliff lift is Qwen-specific."
  hyp     = "Llama-3.1-8B + Mistral-7B-v0.3 wc_31_60 cliff lift matches Qwen-7B within ±10pp → text reasoning cliff is scale-law universal across modern 7B"
  verdict = "PENDING — cycle-29+ real fire (mac M3 local, ~4-5GB DL + Stage-2 N=2000 wall ~30min, $0). External anchors: Llama-3.1 technical report (arXiv:2407.21783, Meta AI 2024), Mistral-7B-v0.3 (HuggingFace model card mistralai/Mistral-7B-Instruct-v0.3), Gemma-3 technical report (Google DeepMind 2026), Qwen2.5 technical report (arXiv:2412.15115). Per-family 7B baselines fan out → triangulates whether 'wc_31_60 cliff lift at 7B' is a Qwen finding or a scale finding."

# ════════════════════════════════════════════════════════════════════
# CROSS-CYCLE LINKAGE
# ════════════════════════════════════════════════════════════════════
# - cycle-23c P1: 4-rung VL ladder NON-MONOTONE (0.81/0.94/0.81/1.00),
#   counting dip-recover ENTIRELY within Qwen split (3B→7B)
# - cycle-24: verifier honest residual flagged "needs non-Qwen-7B rung"
# - cycle-26 C1 ECONOMICS: 12 dense overtrain + 1 MoE Chinchilla-exact
#   → same family-confound pattern at cost-curve layer
# - cycle-27 ECONOMICS E1: NOVEL axis MoE-vs-dense divergence (mirror)
# - cycle-28 SUBSTRATE N1 (THIS SEED): MAIN priority lane for SUBSTRATE
#
# N1 first-probe (cheapest): seed 1 (per-family slope decomposition on
# committed TSV, $0, closed-form recompute, no substrate fire)
# N1 follow-on (cycle-29+): seed 2 (non-Qwen-7B VL DL ~5GB) + seed 3
# (non-Qwen-7B text DL ~4-5GB) — both mac M3 local, $0
#
# Honest residual (preregistered):
# - cycle-28 first-probe (seed 1) is n=2 family pairs (SmolVLM + Qwen) ×
#   2 rungs each = ANECDOTE, not statistical evidence.
# - True cross-family fire requires ≥1 non-Qwen-7B + ≥1 non-Qwen-text-7B
#   actual rung measurement (seeds 2+3, cycle-29+).
# - The data we own (cycle-23c TSV) is family-confounded by construction:
#   the rung scale grid and the family grid are CO-VARIED (smaller =
#   SmolVLM, larger = Qwen). Per-family slope can DETECT this; it cannot
#   ATTRIBUTE the dip to family-vs-scale at n=2 pairs alone.
# - The N1 axis is PERPETUAL — every future capability claim on SUBSTRATE
#   ladder must pass the family-vs-scale gate before scaling-law tier.
