@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "bitnet-m1-ternary-floor"
  source = "BITNET M1+M2 landing — BitNet b1.58 2B4T TQ2_0 served on stock llama.cpp, 20-task SANDBOX manifest"
  date   = "2026-05-25"
  flow   = "engine-unblock -> empirical floor measured -> honest negative -> M3 Pareto + template-confound next-cycle seeds (cx_discovery_log)"

# ════════════════════════════════════════════════════════════════════
# CONTEXT — how the 1.58-bit 2B4T model was actually run, and what fell out
# ════════════════════════════════════════════════════════════════════
# Engine path (the load-bearing M1 unblock): the OFFICIAL microsoft i2_s GGUF
# does NOT load in stock brew llama.cpp 9150 (ggml type-id 36 collides with
# TYPE_IQ4_NL_4_4 REMOVED — it targets bitnet.cpp, which is not installed).
# llama.cpp's NATIVE ternary path is TQ1_0/TQ2_0. So the $0-local route was:
# download the bf16 safetensors (microsoft/bitnet-b1.58-2B-4T-bf16, 4.83 GB) and
# convert -> TQ2_0 (2.06 bpw) with brew convert_hf_to_gguf.py. Three honest gaps
# had to be bridged for the 2B4T variant (all local one-off patches, NOT committed):
#   (1) config arch "BitNetForCausalLM" -> "BitnetForCausalLM" (converter registry
#       key is case-sensitive lowercase-n);
#   (2) tensor_mapping: add self_attn.attn_sub_norm + mlp.ffn_sub_norm source names
#       (2B4T has subln layers the legacy bitnet_b1_58 converter never mapped);
#   (3) BitnetModel.set_vocab BPE fallback (2B4T ships tokenizer.json GPT-2/BPE,
#       not the SentencePiece tokenizer.model the old class assumed).
# Resulting GGUF (332 tensors, 210 tq2_0, file-type 37) LOADS + RUNS — but the
# brew Metal backend ASSERTS on type 35 (no TQ2_0 GPU kernel), so inference is
# CPU-only (-ngl 0, ~7.7 tok/s) + --jinja (the "User:/Assistant:" 2B4T chat
# template is not a llama.cpp built-in). Engine VERIFIED working = M1 unblocked.
#
# FINDING (M1, honest negative): BitNet-b1.58-2B-4T-TQ2_0 scored 6/20 = 30.0% on
# the SAME 20-task canonical manifest where Qwen2.5-0.5B-Q4 scored 16/20 = 80%
# (clean SANDBOX stage-0 floor). HONEST RELABEL: the served value is TQ2_0 (2.06
# bpw), NOT the marketed i2_s 1.58-bit (which does not load in stock llama.cpp).
# The served TQ2_0 2B model is FAR BELOW the usable
# floor (>=15/20) AND below the 4-bit 0.5B baseline. Dominant failure mode: the
# instruct model IGNORES "reply with X only" and emits verbose/repetitive prose
# (e.g. "The digit only is 4. The digit only is 4. ..."), so the byte_exact_subset
# scorer misses the keyword even when the fact is present. RAW completion (no chat
# template) returns EMPTY — the model REQUIRES its chat template, so -st --jinja is
# the fair serving mode; 30% is a genuine served-instruct measurement, not template
# starvation.
#
# FINDING (M2): BitNet peak RSS = 1568 MB (CPU). Qwen2.5-1.5B-Q4 = 1944 MB (Metal,
# as-served) / 2878 MB (CPU, same-backend control). Ratio 0.55x same-backend. The
# memory half of "1.58-bit ~= full quality at a fraction of memory" HOLDS (RSS is a
# real fraction below baseline); the QUALITY half FAILS -> joint claim FALSIFIED on
# this substrate (falsifier 'accuracy gap > eps' fired).

@C d_bitnet_m1_engine_unblock := "BitNet 2B4T served on stock llama.cpp via bf16->TQ2_0 convert (i2_s does not load) — engine VERIFIED, M1 unblocked" :: landed [verified_tier=GREEN status=measured-in-repo]
  cmd     = "hf download microsoft/bitnet-b1.58-2B-4T-bf16; patch (arch-case + subln tensor names + BPE vocab) convert_hf_to_gguf.py; convert --outtype tq2_0; llama-completion -ngl 0 --jinja -st"
  hyp     = "stock brew llama.cpp can run BitNet b1.58 2B4T ternary kernels at $0 local without bitnet.cpp"
  verdict = "TRUE for TQ2_0 on CPU — official i2_s GGUF FAILS to load (type-36 collision, bitnet.cpp-only) and TQ2_0 has NO Metal kernel (asserts type 35), but the CPU TQ2_0 path loads+runs (332 tensors, 210 tq2_0, ~7.7 tok/s). Engine working = M1 surface met. .verdicts/bitnet/m1_accuracy_floor_summary.txt"

@C d_bitnet_m1_floor_negative := "BitNet 2B4T TQ2_0 (2.06bpw) scores 6/20=30% — BELOW usable floor AND below the 4-bit 0.5B baseline (16/20) on the same manifest" :: landed [verified_tier=GREEN status=measured-in-repo]
  cmd     = "bench/bitnet_m1_accuracy_floor.hexa (20-task manifest VERBATIM from sandbox_stage0_baseline.hexa, byte_exact_subset scorer identical)"
  hyp     = "a 1.58-bit-class 2B model (here served as TQ2_0 2.06bpw — i2_s does not load) reaches the SANDBOX usable accuracy floor (>=15/20) at ternary precision"
  verdict = "FALSIFIED — 6/20=30.0% << 15/20 floor, and < Qwen-0.5B-Q4 16/20=80%. HONEST RELABEL: measured at TQ2_0 2.06bpw, not the marketed i2_s 1.58-bit. Failure mode = ternary quality loss (model emits factually WRONG answers, not verbose-but-correct). .verdicts/bitnet/m1_accuracy_floor.tsv"

@C d_bitnet_m1_scorer_artifact_ruled_out := "the /gap ROOT-A confound RESOLVED — re-scoring saved completions under 2 INSTRUCT-FAIR scorers moves 30% only to 35%/30%, so 30% is a TRUE TQ2_0 floor, NOT a scorer artifact" :: landed [verified_tier=GREEN status=measured-in-repo]
  cmd     = "bench/bitnet_m1_scorer_ablation.hexa — re-score the SAVED m1_accuracy_floor.tsv (col 7, NO re-serve) under byte_exact_subset | lenient_normalized (strip whitespace) | answer_extraction (first span); deterministic, no LLM-judge (g5/R6)"
  hyp     = "BitNet's 30% on byte_exact_subset is mostly a scorer artifact (verbose-but-correct answers the literal substring misses) — a fair scorer lifts it materially"
  verdict = "FALSIFIED (the artifact hypothesis) — byte_exact 6/20=30% reproduced exactly; lenient 7/20=35% (delta +1 = idx14 '1,2,3' vs gold '1, 2, 3' whitespace only); extraction 6/20=30% (delta +0). The verbose failures are factually WRONG ('not square of 7', 'ASCII is 1', '1101=11'), not buried-correct. Artifact component = 1/14 failures = +5pp; the rest is genuine ternary weakness. M1/M2 'quality FAIL' verdict STANDS. .verdicts/bitnet/m1_scorer_ablation.txt"

@C d_bitnet_m2_memory_holds_quality_fails := "M2: memory fraction HOLDS (0.55x same-backend) but quality FAILS — joint '1.58-bit ~= full quality at a fraction of memory' FALSIFIED" :: landed [verified_tier=GREEN status=measured-in-repo]
  cmd     = "/usr/bin/time -l RSS capture during the M1 serving session; BitNet 1568 MB vs Qwen2.5-1.5B-Q4 2878 MB (CPU) / 1944 MB (Metal)"
  hyp     = "1.58-bit serving uses a fraction of the Q4 baseline memory AND preserves near-full quality"
  verdict = "FALSIFIED (joint) — memory IS a real fraction (0.55x same-backend, 0.81x cross-backend) but accuracy gap is LARGE (30% vs 80%), so the 'near-full quality' conjunct fails. .verdicts/bitnet/m2_memory_profile_summary.txt"

@C d_bitnet_m3_template_confound_pareto := "next-cycle seed — SCORER half RESOLVED (30% is real, not artifact); only the M3 accuracy-per-bit Pareto ladder remains" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "M3 Pareto: re-run the 20-task manifest at Q4/Q8/fp16 of the SAME 2B4T (bf16 already on disk) to isolate the bit<->quality knee. (The scorer-confound probe is DONE — see d_bitnet_m1_scorer_artifact_ruled_out: fair re-scoring moved 30% only to 35%.)"
  hyp     = "a Q4/Q8/fp16 ladder of the same 2B4T will locate the true bit<->quality knee; the 30% TQ2_0 floor is now known to be genuine (not a scorer artifact)"
  verdict = "PARTIALLY RESOLVED — scorer-confound CLOSED (artifact = +5pp only). The bf16 model (~4.83 GB) is already local, so the Q8/Q4/fp16 rungs are $0-local converts; what remains is the bit<->quality knee, NOT the scorer question."
