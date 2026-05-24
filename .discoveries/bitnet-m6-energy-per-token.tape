@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "bitnet-m6-energy-per-token"
  source = "BITNET M6 Energy — energy-per-token (J/tok) measured via sudo powermetrics"
  date   = "2026-05-25"
  flow   = "BitNet's 3rd headline (ENERGY) was never measured -> powermetrics J/tok bench vs Qwen-Q4 baseline -> FALSIFIED on this substrate (1.6-1.8x MORE J/tok) -> CPU-only constraint erases the ternary advantage -> seed for ternary-accelerator probe (cx_discovery_log)"

# ════════════════════════════════════════════════════════════════════════════
# FINDING — BitNet b1.58 2B4T uses 1.6-1.8x MORE energy/token than Qwen-Q4 here
# ════════════════════════════════════════════════════════════════════════════
# BitNet markets THREE headlines: accuracy (M1 FALSIFIED 30%), memory (M2 HOLDS
# 0.55x), and ENERGY ("1.58-bit = energy-efficient inference") — the energy one
# had NEVER been measured on this substrate. M6 measures it with REAL hardware
# power sampling (sudo powermetrics, cpu_power+gpu_power, "Combined Power
# (CPU+GPU+ANE)" @ 200ms) wrapping the IDENTICAL 20-task manifest, output tokens
# EXACT from the perf trailer ("eval time = ... / N runs"):
#
#   model                    acc    mean_W   tok/s   J/tok(thru)
#   Qwen-0.5B-Q4 [Metal]     80%    5.087    13.22      0.385   <- baseline
#   BitNet-i2_s  [CPU]       30%    5.193     7.48      0.695   (1.81x baseline)
#   BitNet-TQ2_0 [CPU]       30%    4.353     6.96      0.625   (1.62x baseline)
#
# DECISIVE: SoC POWER is ~equal (~4.4-5.2 W) whether running BitNet's CPU path or
# Qwen's Metal path; the entire energy gap is THROUGHPUT (Qwen 13.2 tok/s Metal
# vs BitNet 7.0-7.5 tok/s CPU-only). BitNet's ternary kernel has NO Metal GPU
# implementation on this substrate -> CPU-only at ~half throughput -> ~1.7x the
# energy per token. The marketed energy advantage assumes a TERNARY-OPTIMIZED
# ACCELERATOR (MAC-free {-1,0,+1} arithmetic cutting ops AND power); this
# substrate lacks one, so the theoretical advantage is ERASED here.
#
# ════════════════════════════════════════════════════════════════════════════
# MEASUREMENT FIDELITY (honest)
# ════════════════════════════════════════════════════════════════════════════
# FULL fidelity — sudo -n powermetrics was available passwordless, so the whole-
# SoC wall energy (CPU+GPU+ANE) is on the HARDWARE meter, same scale for BitNet's
# CPU path AND Qwen's Metal-GPU path (no CPU-seconds proxy needed). Two readings:
# GROSS (idle-inclusive energy over the sampler window / tokens) and THRU
# (mean_W / throughput — load-independent, the headline). The IDLE-SUBTRACTED
# "net" is UNRELIABLE on a non-isolated desktop (idle ~5W is the same magnitude
# as a fast run's draw; clamps to ~0) and is reported only as a fenced lower
# bound. THRU decouples from idle entirely. Arithmetic identity verified EXACT
# (no LLM-judge): J/tok = mean_W/throughput == mean_W*wall_s/tok, bit-for-bit.
# Run-to-run gross variance (~18%, desktop OS load) << the 1.6-1.8x BitNet/Qwen
# gap, so the verdict is robust.

@C d_bitnet_m6_energy_falsified := "BitNet b1.58 2B4T consumes 1.6-1.8x MORE energy-per-token (0.625-0.695 J/tok) than the Qwen2.5-0.5B-Q4 Metal baseline (0.385 J/tok) on this substrate; the headline '1.58-bit = energy-efficient inference' is FALSIFIED here because the CPU-only constraint (no Metal ternary kernel) halves throughput at ~equal SoC power" :: confirmed [verified_tier=DEFERRED cost_actual=$0]
  cmd     = "bench/bitnet_m6_energy_per_token.hexa — sudo powermetrics (cpu_power+gpu_power) background sampler wrapping the 20-task manifest; energy E(J)=sum(combined_mW)/1000*0.2; tokens exact from perf-trailer 'eval time/N runs'; J/tok per model; run for Qwen-Q4 (Metal), BitNet-i2_s (bitnet.cpp CPU), BitNet-TQ2_0 (llama.cpp CPU)"
  hyp     = "BitNet's 1.58-bit ternary inference is more energy-efficient (lower J/tok) than a 4-bit baseline"
  verdict = "FALSE on this substrate — BitNet 0.625-0.695 J/tok > Qwen 0.385 J/tok (ratio 1.62-1.81x). Power is ~equal; throughput halves under CPU-only. Empirical T4 (🟠 DEFERRED, external hw dep, no --expr closed-form; bench is the recompute witness). .verdicts/bitnet/m6_energy_per_token.txt"

@C d_bitnet_m6_power_equal_throughput_bound := "the energy gap is NOT a power gap — mean SoC power is ~equal (~4.4-5.2 W) for BitNet-CPU and Qwen-Metal; the entire J/tok difference is throughput (13.2 vs 7.0-7.5 tok/s), so on this substrate BitNet's energy story is throughput-bound, not power-bound" :: confirmed [verified_tier=NUMERICAL cost_actual=$0]
  cmd     = "compare mean_combined_mW (Qwen 5087, i2_s 5193, TQ2_0 4353) vs tok/s (Qwen 13.22, i2_s 7.48, TQ2_0 6.96) from the three m6_energy_*_summary.txt; verify J/tok = mean_W/throughput identity exact"
  hyp     = "BitNet draws LESS instantaneous power (the ternary energy story is a power story)"
  verdict = "FALSE here — power is ~equal; the differentiator is throughput. J/tok=P/throughput identity recomputes EXACT (i2_s 0.6946, TQ20 0.6250, Qwen 0.3847). The ternary power advantage does not materialize without a ternary-optimized kernel/accelerator."

@C d_bitnet_m6_seed_ternary_accelerator := "next-cycle seed — to test whether BitNet's energy claim holds on its INTENDED hardware, measure J/tok on a substrate with a ternary-optimized kernel (e.g. bitnet.cpp's x86 AVX2/TL2 path, or a GPU/NPU ternary MAC-free kernel); this substrate (Apple Silicon, CPU-only ternary, no Metal kernel) is the WRONG substrate for the claim and falsifies it only locally" :: seed [verified_tier_target=NUMERICAL]
  cmd     = "rent/identify a host with a ternary-optimized inference path (x86 bitnet.cpp TL2, or a ternary GPU kernel); rerun bench/bitnet_m6_energy_per_token.hexa with powermetrics/RAPL; compare J/tok to a 4-bit baseline on the SAME host"
  hyp     = "on a ternary-optimized accelerator BitNet's J/tok DROPS below the 4-bit baseline (the claim holds where the hardware exists)"
  verdict = "PENDING — not measurable on this Apple Silicon substrate (CPU-only ternary, no Metal kernel); the M6 FALSIFIED verdict is explicitly substrate-scoped, and this seed is the genuine open question"
