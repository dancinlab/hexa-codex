@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "safety-n1-refusal-cross-family"
  source = "SAFETY NOVEL 축 N1 spawned from cycle-19/20 cross-cycle observation (cycle-28)"
  date   = "2026-05-27"
  flow   = "cycle-19-AUROC-0.98-on-Qwen-only + cycle-20-causal-95→0%-on-Qwen-only -> n=1 model anecdote -> novel axis N1 seed (cx_discovery_log, mirrors ECONOMICS cycle-27 E1 pattern)"

# ════════════════════════════════════════════════════════════════════
# CONTEXT — why N1 spawns from cycle-19/20 SAFETY findings
# ════════════════════════════════════════════════════════════════════
# cycle-17 (.verdicts/sandbox/m2_safety_refusal_norms.tsv, 40×84):
#   committed activation-norm matrix on Qwen2.5-1.5B-Instruct
#   28 layers × {residual, attn, mlp} = 84 features, balanced 20/20
#
# cycle-19 (.verdicts/sandbox/m4_safety_refusal_direction_recompute.txt):
#   linear refusal-direction classifier recompute - 5/5 PASS
#     full-vector projection AUROC = 0.98
#     LOO acc = 0.825 (33/40)  permutation p = 0.00498
#   route(b) mechanistic finding: linear separation w = mean(z_refused) - mean(z_answered)
#
# cycle-20 (.verdicts/sandbox/m5_safety_causal_ablation.txt):
#   INTERVENTIONAL upgrade per Arditi 2024 (arXiv:2406.11717)
#     baseline refusal rate on adv = 0.95 (19/20)
#     ablate L19 direction -> 0.00 (0/20)  delta = 0.95
#     random-direction control = 0.867 (3-seed mean) - structure NOT generic
#   load-bearing source layer = L19  dir_norm(L19) = 27.68
#
# ════════════════════════════════════════════════════════════════════
# THE ANECDOTE PROBLEM (n=1 model)
# ════════════════════════════════════════════════════════════════════
# All three findings (AUROC 0.98, causal delta 0.95, L19 localization)
# are on ONE model family: Qwen2.5-1.5B-Instruct.  This is the SAFETY
# analogue of the ECONOMICS cycle-26 C1 finding (DeepSeek-V3 active
# D/N=20 exact = n=1 MoE landing -> spawned cycle-27 E1 axis).
#
# Two readings are observationally indistinguishable at n=1:
#   (A) UNIVERSAL  - refusal in any instruction-tuned LLM is mediated
#                    by a single residual-stream direction at a
#                    similar relative depth (Arditi 2024 finds it on
#                    Llama-2 family; we observe it on Qwen).  cycle-19
#                    AUROC 0.98 generalizes.
#   (B) FAMILY-SPECIFIC - Qwen2.5 architecture + post-training
#                    co-evolution (RLHF/DPO recipe, refusal corpus
#                    composition) produces a Qwen-only direction.
#                    Llama/Mistral/Gemma/SmolLM2 may show AUROC near
#                    chance, or a direction at a different relative
#                    depth, or no single direction at all.
#
# Reading (A) requires ≥3 non-Qwen confirmations.  Reading (B) requires
# ≥2/4 non-Qwen falsifiers (AUROC < 0.70).  cycle-28 first-probe is
# closed-form SHAPE statistics on the Qwen TSV - if the direction's
# norm/sparsity/dim-concentration looks like a generic Gaussian-ish
# residual feature, transferability is plausible; if it shows Qwen-
# specific scale or dim concentration patterns, transferability is
# unlikely and cycle-29+ should prioritize Mistral/Gemma over Llama.

@C d_safety_n1_cross_family_auroc := "L19 refusal direction transfers to ≥3 of {Llama-3-8B, Mistral-7B, Gemma-2-2b, SmolLM2-1.7B} -Instruct at AUROC ≥ 0.90" :: seed [verified_tier_target=YELLOW status=open]
  cmd     = "harness lm_foundry/tool/activation_capture_hf.hexa per non-Qwen model (ubu-1 RTX 5070, HF transformers 4.51.3 clean venv, numpy<2 pin per [[reference_activation_capture_env]]) -> emit NUMBERS-ONLY TSV mirror of m2_safety_refusal_norms.tsv schema (row_idx, is_adv, label, L0..L{n_layers-1}.{residual,attn,mlp}) per model -> re-run verify/numerics_safety_refusal_direction.hexa with per-model DATA_PATH override -> 4 per-model AUROC/LOO/perm-p verdicts -> aggregate to .verdicts/safety/n1_cross_family_auroc.tsv (model, n_layers, load_bearing_layer, auroc, loo, perm_p)"
  hyp     = "≥3 of 4 non-Qwen instruction-tuned models reproduce AUROC ≥ 0.90 at SOME layer (universal reading A holds across 4 families); load-bearing layer index normalized to relative-depth (layer/n_layers) clusters within ±0.10 across families."
  verdict = "PENDING — cycle-29+ substrate fire (ubu-1 HF, ≥4 model activation captures, balanced 20 refused / 20 answered per model, cx_hf_safety_private NUMBERS-ONLY emit). cycle-28 cheapest probe is closed-form SHAPE statistics on the Qwen TSV alone (verify/numerics_safety_n1_cross_family_shape.hexa) - if Qwen direction looks structurally generic, hardens cycle-29 collection; if Qwen-specific, signals cycle-29 likely to falsify universality."

@C d_safety_n1_relative_depth_invariance := "load-bearing layer (Qwen L19 = 19/28 = 0.679 relative depth) is preserved across non-Qwen families" :: seed [verified_tier_target=YELLOW status=open]
  cmd     = "for each non-Qwen model, sweep candidate src layers (relative depth 0.5..0.85) under causal ablation (mirror bench/sandbox_m5_safety_causal_ablation.hexa logic - difference-of-means direction extraction + residual-stream subtraction at src + greedy 48-tok continue + marker-scan refusal scoring) -> per-model load_bearing_relative_depth = argmax over (baseline - ablated) refusal-rate delta -> aggregate to .verdicts/safety/n1_relative_depth.tsv (model, n_layers, src_relative_depth, delta_refusal_rate)"
  hyp     = "load-bearing relative depth clusters at 0.65 ± 0.10 across 4 non-Qwen families (Arditi 2024 reports similar relative-depth localization on Llama-2 family). If ≥3 cluster, universality reading hardens; if scatter > 0.20 or ≥2 show NO load-bearing single direction (max delta < 0.30), family-specific reading hardens."
  verdict = "PENDING — cycle-29+ causal ablation per model. Heavier than seed 1 (4× ablation sweep instead of 4× direction recompute). $0 if reusing ubu-1 GPU. External anchor: Arditi 2024 (arXiv:2406.11717) reports L14/L32 ≈ 0.44 on Llama-2-13B - direct comparison point at relative depth 0.44 vs Qwen 0.68 already raises a residual question (different relative depth, same mechanism?)."

@C d_safety_n1_shape_first_probe := "Qwen L19 refusal direction's distributional shape predicts cross-family transferability without firing on non-Qwen models" :: seed [verified_tier_target=YELLOW status=open]
  cmd     = "harness verify/numerics_safety_n1_cross_family_shape.hexa - read .verdicts/sandbox/m2_safety_refusal_norms.tsv (cycle-17 Qwen 40×84) -> extract L19 difference-of-means direction restricted to {residual, attn, mlp} per-kind 1-d projection (L19.residual is dim-3 of the 84-feature space at offset 60, L19.attn at 61, L19.mlp at 62) -> compute distributional statistics: per-kind direction magnitude (mean |w|), sparsity proxy (max |w| / mean |w|), kind-concentration (which of residual/attn/mlp dominates), refused-vs-answered margin -> emit 🟡 SUPPORTED-BY-CITATION verdict (Arditi 2024 frames refusal direction as residual-stream-dominant; check if Qwen matches that residual-dominant signature)"
  hyp     = "Qwen L19 direction is residual-stream-dominant (|w_residual| > 2× |w_attn|, |w_mlp|) - matches Arditi 2024 finding on Llama-2 - if so, transferability plausible; if attn/mlp dominate, Qwen-specific (atypical) and transferability unlikely."
  verdict = "PENDING - cycle-28 first probe (THIS file is the verifier). $0 closed-form recompute on committed TSV. 🟡 tier ceiling because cross-family universality is a STRUCTURAL PREDICTION not a measurement at n=1 model (Arditi 2024 = external anchor for the prediction direction, not for Qwen-specific number). Promotion to 🟢 requires ≥3 non-Qwen recomputes (seed 1, cycle-29+)."

# ════════════════════════════════════════════════════════════════════
# CROSS-CYCLE LINKAGE
# ════════════════════════════════════════════════════════════════════
# - cycle-17 M2.SAFETY: 40×84 Qwen activation-norm TSV committed
# - cycle-19 M4.SAFETY: linear classifier recompute - AUROC 0.98 (n=1 model)
# - cycle-20 M5.SAFETY: causal ablation - L19 delta 0.95 (n=1 model)
# - cycle-26 ECONOMICS C1: n=1 MoE outlier (DeepSeek-V3 active D/N=20)
# - cycle-27 ECONOMICS E1: NOVEL axis spawn from C1 n=1 anecdote -> KS-test ≥3 MoE
# - cycle-28 SAFETY N1: ANALOGOUS NOVEL axis spawn from cycle-19/20 n=1 anecdote
#                       -> cross-family AUROC test on ≥3 non-Qwen models
#                       -> first probe (THIS cycle) = closed-form SHAPE statistics
#                          on the Qwen TSV ($0, predicts transferability without firing)
#                       -> full fire = cycle-29+ (ubu-1 HF activation capture per model)
#
# Honest residuals:
# - n=1 model = anecdote, NOT cross-family evidence.  4-model recompute required.
# - Arditi 2024 is the universality external anchor; their finding is on Llama-2 (different
#   architecture, different post-training).  "Qwen-on-Llama-2-mechanism" is the hypothesis.
# - "Refusal" is defined via marker-scan on first 48 generated tokens (cycle-20 protocol).
#   Cross-family fire MUST keep the same marker set or comparability breaks.
# - cycle-28 first probe is 🟡 ceiling.  cx_paper_significance: 🟡 SUPPORTED-BY-CITATION
#   is NOT paper-eligible by itself; cycle-29+ recompute is the empirical-contact gate.
# - cx_hf_safety_private invariant: adversarial prompt TEXT stays private at every step;
#   per-model TSVs emit NUMBERS-ONLY (row_idx, is_adv, label, activation norms).
