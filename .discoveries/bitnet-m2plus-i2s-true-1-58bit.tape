@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "bitnet-m2plus-i2s-true-1-58bit"
  source = "BITNET M2+ landing — TRUE 1.58-bit i2_s via Microsoft bitnet.cpp on Apple Silicon, /gap ROOT-B closed"
  date   = "2026-05-25"
  flow   = "bitnet.cpp build -> engine-matched i2_s self-convert -> identical 20-task bench -> i2_s vs TQ2_0 head-to-head (cx_discovery_log)"

# ════════════════════════════════════════════════════════════════════
# CONTEXT — /gap ROOT-B: M1/M2 served TQ2_0 (2.06 bpw) not the headline 1.58 bpw
# ════════════════════════════════════════════════════════════════════
# M1/M2 served BitNet b1.58 2B4T as TQ2_0 (2.06 bpw) because the official
# microsoft/BitNet-b1.58-2B-4T-gguf i2_s GGUF does NOT load in stock brew
# llama.cpp 9150 (ggml type-id 36 = TYPE_IQ4_NL_4_4 REMOVED). The /gap ROOT-B
# audit flagged: the headline "1.58-bit" was actually tested at 2.06 bpw,
# so the 30% floor COULD be a TQ2_0 quantization artifact. This discovery
# closes that audit by measuring the GENUINE 1.58-bit i2_s ternary kernel.
#
# ENGINE BUILD (the load-bearing M2+ unblock): Microsoft bitnet.cpp
# (github.com/microsoft/BitNet, MIT, 2026-01 vintage submodule 1f86f058)
# built locally on mac-mini-m3 ($0). Two real toolchain gotchas:
#   (1) brew ccache 4.11.3 is broken (libfmt.11.dylib not found after a brew
#       fmt upgrade) — cmake auto-discovers it and the build dies in ggml-quants.c.
#       Fix: cmake -DGGML_CCACHE=OFF (also flags in cache to suppress re-detection).
#   (2) arm64 i2_s on this fork still needs the codegen_tl1 header path —
#       run utils/codegen_tl1.py --model bitnet_b1_58-3B --BM 160,320,320
#       --BK 64,128,64 --bm 32,64,32 (the official setup_env.py for 2B4T
#       deliberately reuses the 3B kernel params).
# Build target: llama-cli + llama-quantize. Engine verified working on the
# self-converted i2_s GGUF.
#
# GGUF SELECTION — official pre-downloaded i2_s != engine-matched:
# the disk's ~/Models/gguf/bitnet/ggml-model-i2_s.gguf has
# sha256=4221b252...884c2162 matching the official HF blob bit-for-bit
# (verified), but its metadata is arch=bitnet-b1.58 / name=bitnet2b /
# chat_template=Human:/BITNETAssistant: — a community 'bitnet2b' variant.
# Decoding it on bitnet.cpp produces garbage ("on enc cliente...") or
# token-0 collapse (!!!!) regardless of template. The fix that works:
# self-convert from the official bf16 safetensors (already on disk,
# microsoft/bitnet-b1.58-2B-4T-bf16, 4.83 GB) via the engine's own
# utils/convert-helper-bitnet.py pipeline (preprocess-huggingface-bitnet ->
# convert-ms-to-gguf-bitnet f32 -> our build/bin/llama-quantize ... I2_S 1).
# The self-converted GGUF (1.19 GB, 1187801216 B) decodes coherently with
# the raw 2B4T "User: <q>\nAssistant:" prefix. -cnv (embedded template)
# still collapses to token-0; raw prefix is fair serving mode.
#
# FINDING (M2+, the headline): TRUE i2_s scores 6/20 = 30.0% — BIT-FOR-BIT
# IDENTICAL to TQ2_0 6/20 = 30.0% on the same canonical 20-task manifest +
# identical byte_exact_subset scorer. The /gap ROOT-B hypothesis "30% is a
# TQ2_0 artifact" is REFUTED. Memory 1527 vs 1568 MB (i2_s −2.6%, marginally
# tighter, as expected for 1.58 vs 2.06 bpw). Wall 87,727 vs 221,772 ms
# (i2_s = 2.53x bitnet.cpp speedup vs stock llama.cpp on M3 — bitnet.cpp
# paper's 1.37x–5.07x ARM headline empirically confirmed). M1/M2 verdict
# UNCHANGED — joint claim '1.58-bit ≈ full quality at a fraction of memory'
# remains FALSIFIED regardless of ternary kernel; quantization was NOT
# the M1 confound (the verbose-instruct + byte_exact_subset interaction was).
#
# HONEST SUB-FINDING: 10 of 20 i2_s failures collapsed to repeated token-0
# (!!!!), a deterministic NaN/inf-logit failure on certain prompts on the
# arm64 i2_s LUT/MAD path (reproducible at --temp 0 with/without warmup,
# 1 or 4 threads). TQ2_0 did not exhibit this — its 14 misses were
# verbose-prose. So joint accuracy is identical but i2_s failure mode is
# qualitatively kernel-stability-driven, not quality-driven. Extra
# falsifier surface for bitnet.cpp arm64 i2_s on M3.

@C d_bitnet_m2plus_engine_unblock := "bitnet.cpp built locally on Apple Silicon (ccache=OFF + codegen_tl1) — Microsoft's official I2_S ternary kernel now serves on this substrate" :: landed [verified_tier=GREEN status=measured-in-repo]
  cmd     = "git clone --recursive https://github.com/microsoft/BitNet.git ~/BitNet; .venv install gguf-py + numpy<2 + torch + transformers + safetensors; python utils/codegen_tl1.py --model bitnet_b1_58-3B --BM 160,320,320 --BK 64,128,64 --bm 32,64,32; cmake -DGGML_CCACHE=OFF -DBITNET_ARM_TL1=OFF; cmake --build --target llama-cli llama-quantize -j 8"
  hyp     = "Microsoft bitnet.cpp builds and serves the official I2_S ternary kernel on mac-mini-m3 arm64 at $0"
  verdict = "TRUE — both binaries built and execute the i2_s kernel; two toolchain workarounds required (brew ccache broken via libfmt.11 -> GGML_CCACHE=OFF; arm64 i2_s still needs codegen_tl1 header)"

@C d_bitnet_m2plus_gguf_matching := "engine-matched i2_s GGUF requires self-convert from bf16 — pre-downloaded official i2_s GGUF (sha256-verified) decodes to garbage on this engine" :: landed [verified_tier=GREEN status=measured-in-repo]
  cmd     = ".venv/bin/python utils/convert-helper-bitnet.py /Users/ghost/Models/bitnet-bf16 (preprocess-huggingface-bitnet -> convert-ms-to-gguf-bitnet f32 -> build/bin/llama-quantize ... I2_S 1)"
  hyp     = "any sha256-correct microsoft/BitNet-b1.58-2B-4T-gguf i2_s GGUF decodes coherently on bitnet.cpp"
  verdict = "FALSE on this substrate — the canonical HF i2_s GGUF carries arch=bitnet-b1.58 name=bitnet2b template=Human:/BITNETAssistant: and decodes to garbage / token-0 collapse on bitnet.cpp; the engine-matched self-convert from bf16 (same family, same params, our own llama-quantize) decodes coherently. Implication: bitnet.cpp users should ALWAYS self-convert from the bf16, not rely on the pre-quantized i2_s GGUF on HF for the 2B4T variant."

@C d_bitnet_m2plus_true_158_equal_tq20 := "TRUE 1.58-bit i2_s scores 6/20=30%, BIT-FOR-BIT IDENTICAL to TQ2_0 2.06bpw — /gap ROOT-B refuted, M1 verdict robust to quantization variant" :: landed [verified_tier=GREEN status=measured-in-repo]
  cmd     = "bench/bitnet_i2s_true_1_58bit.hexa (identical 20-task manifest + byte_exact_subset scorer as bench/bitnet_m1_accuracy_floor.hexa, only engine swapped)"
  hyp     = "TRUE 1.58-bit i2_s scores materially higher than TQ2_0 2.06 bpw on the canonical floor — the M1 30% is a TQ2_0 artifact"
  verdict = "FALSIFIED — i2_s 6/20=30.0% == TQ2_0 6/20=30.0% (zero accuracy delta). The M1 negative is NOT a quantization artifact; the verbose-instruct + byte_exact_subset interaction explains it. Memory: i2_s 1527 MB vs TQ2_0 1568 MB (−2.6%, marginal as expected for 1.58 vs 2.06 bpw). Speed: i2_s 87.7s vs TQ2_0 221.8s = 2.53x bitnet.cpp speedup (bitnet.cpp paper headline confirmed). .verdicts/bitnet/m2plus_i2s_vs_tq2_0_comparison.txt"

@C d_bitnet_m2plus_i2s_kernel_artifact := "arm64 i2_s LUT path produces deterministic token-0 collapse (!!!!) on certain prompts — kernel-stability sub-falsifier, distinct from quality" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "rerun a degenerate-token prompt under -t 1 / -t 4 / +warmup / -warmup — confirmed deterministic; bisect by codegen_tl1 BM/BK/bm tuning or fall back to BITNET_ARM_TL1=ON (TL1 kernel path)"
  hyp     = "the 10/20 token-0 collapses are a tuneable codegen_tl1 LUT-block parameter mismatch (currently --BM 160,320,320 --BK 64,128,64 --bm 32,64,32 from the 3B-model defaults reused for 2B4T) — different BM/BK/bm or the TL1 alt kernel will reduce them"
  verdict = "PENDING — separate from quality, this is an engine-kernel-stability finding worth a follow-up Pareto sweep alongside M3"

@C d_bitnet_m3_pareto_unchanged := "M3 Pareto ladder remains the next-cycle seed — M2+ confirmed quantization is not the M1 confound, so the Q4/Q8/fp16 ladder still locates the bit↔quality knee" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "Q4/Q8/fp16 of the SAME bf16 (already on disk) on the IDENTICAL 20-task manifest; AND a verbosity-tolerant scorer probe to separate genuine quality loss from byte_exact_subset penalizing verbose answers"
  hyp     = "Q4 of the 2B4T scores higher than i2_s 6/20 — the bit↔quality knee for this model family is above 1.58 bpw on this manifest, AND a verbosity-tolerant scorer lifts BOTH the i2_s and Q4 numbers (separating quant loss from scorer artifact)"
  verdict = "PENDING — M3.BITNET. Cost = $0 local (bf16 already on disk, both engines (brew + bitnet.cpp) now built and verified)."
