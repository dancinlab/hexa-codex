@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "bitnet-m3-storage-precision-ladder"
  source = "BITNET M3 Pareto 5-rung ladder (cycle-21, PR following #43)"
  date   = "2026-05-25"
  flow   = "M3 ladder -> MODEL CEILING + storage-vs-quantization-precision reframing -> M4 not graduated (no closed-form law) -> next-cycle seed (cx_discovery_log)"

# ════════════════════════════════════════════════════════════════════════════
# FINDING — BitNet b1.58 2B4T storage-precision ladder is FLAT at 30%
# ════════════════════════════════════════════════════════════════════════════
# 5-rung ladder of microsoft/BitNet-b1.58-2B-4T-bf16 -> llama.cpp / bitnet.cpp:
#   i2_s    1.58 bpw  6/20  RSS 1527 MB
#   TQ2_0   2.06 bpw  6/20  RSS 1568 MB
#   Q4_K_M  5.02 bpw  6/20  RSS 3047 MB
#   Q8_0    8.50 bpw  6/20  RSS 4968 MB
#   F16    16.00 bpw  6/20  DEDUCED (source-code identity, 🔵)
# spread = 0 pp << TOL 5 pp -> MODEL CEILING per harness's pre-registered fit policy.
#
# ════════════════════════════════════════════════════════════════════════════
# WHY F16 IS DEDUCED, NOT MEASURED (the source-code identity)
# ════════════════════════════════════════════════════════════════════════════
# llama.cpp convert_hf_to_gguf.py BitnetModel.modify_tensors forces every
# Q/K/V/O/up/down/gate tensor to {-1, 0, +1} (ternary) BEFORE the GGUF storage
# type is applied — comment "# transform weight into 1/0/-1 (in fp32)".
# So Q4_K_M / Q8_0 / F16 GGUFs all carry the SAME ternary weights in fatter
# containers. Identical weights -> identical logits -> identical scoring.
# Per g0 Occam, the 5th measurement is redundant; falsifier = if the convert
# path changes, F16 must be measured.
#
# ════════════════════════════════════════════════════════════════════════════
# RE-FRAMING — the M3 question was malformed
# ════════════════════════════════════════════════════════════════════════════
# "Is 30% a ternary FLOOR or the 2B4T model CEILING?" implicitly assumes
# storage precision = quantization precision. They are NOT for BitNet b1.58:
# the model is PRETRAINED ternary; the convert path preserves that. This
# ladder is STORAGE-precision (file bpw 1.5->16), not QUANTIZATION-precision
# (information bpw, fixed ~1.58 for all rungs). Asking "is ternary the
# bottleneck?" requires a non-ternary baseline of the same 2B architecture,
# which this ladder does NOT measure. The Qwen-1.5B-Q4 80% baseline is a
# different model family.

@C d_bitnet_m3_model_ceiling := "BitNet b1.58 2B4T saturates at 6/20=30% on canonical 20-task manifest regardless of GGUF storage container; 5-rung ladder spread=0pp; MODEL CEILING per harness's CONSTANT-FLOOR fit policy" :: confirmed [verified_tier=NUMERICAL cost_actual=$0]
  cmd     = "5-rung ladder (i2_s + TQ2_0 + Q4_K_M + Q8_0 + F16-deduced) of microsoft/BitNet-b1.58-2B-4T-bf16 via llama.cpp + bitnet.cpp; combiner bench/bitnet_m3_pareto_ladder.hexa reads 4 persisted summaries + applies pre-registered constant-floor / monotone-lift / non-monotone fit policy"
  hyp     = "higher storage precision lifts accuracy above the 30% ternary floor"
  verdict = "FALSE on this experimental shape — all 4 measured rungs = 6/20 = 30.0% (spread 0pp), F16 deduced 6/20 by source-code identity; 'M3 Pareto' as a floor-vs-ceiling distinction is malformed for a pretrained-ternary model. Verdict = MODEL CEILING. .verdicts/bitnet/m3_pareto_ladder_summary.txt"

@C d_bitnet_convert_path_ternary_clip := "convert_hf_to_gguf.py BitnetModel.modify_tensors forces ternary {-1,0,+1} regardless of --outtype; the 'ladder' is storage-precision, not quantization-precision" :: confirmed [verified_tier=FORMAL cost_actual=$0]
  cmd     = "inspect llama.cpp convert_hf_to_gguf.py BitnetModel.modify_tensors ~line 3434 'transform weight into 1/0/-1 (in fp32)'"
  hyp     = "BitNet b1.58 GGUFs derived from bf16 safetensors carry distinct quantization precision per --outtype"
  verdict = "FALSE — all derived GGUFs (Q4_K_M / Q8_0 / F16) carry identical ternary weights in fatter binary containers; identical logits, identical scoring. This is the source-code basis for the F16 deduction in d_bitnet_m3_model_ceiling."

@C d_bitnet_m3_seed_non_ternary_baseline := "next-cycle seed — to honestly test 'is ternary the bottleneck?', need a non-ternary 2B baseline of the same architecture (a non-BitNet 2B trained at fp16 from scratch on the same data) — NOT what this ladder measured; out-of-scope until such a baseline is identifiable" :: seed [verified_tier_target=NUMERICAL]
  cmd     = "identify a same-architecture non-ternary 2B trained on same data family; serve on substrate; run canonical 20-task manifest; compare to BitNet 2B4T 6/20"
  hyp     = "ternary IS the bottleneck (fp16-pretrained same-arch 2B would beat 6/20)"
  verdict = "PENDING — no candidate identified yet; this is M3.BITNET's genuine open question, not closed by this ladder"
