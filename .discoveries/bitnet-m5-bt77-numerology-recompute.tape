@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "bitnet-m5-bt77-numerology-recompute"
  source = "BITNET M5 Verdict — atlas BT-77 confirm-or-refute by recompute on our substrate"
  date   = "2026-05-25"
  flow   = "atlas lookup -> identify what 25/26 EXACT MEASURES (n=6 numerology, NOT served accuracy) -> closed-form recompute vs real config.json -> CONFIRMED 0 FAIL -> honest confound disclosed (cx_discovery_log)"

# ════════════════════════════════════════════════════════════════════
# CONTEXT — what BT-77's "25/26 EXACT" actually is, and how we recomputed it
# ════════════════════════════════════════════════════════════════════
# The load-bearing M5 finding is an IDENTIFICATION, not a measurement: atlas
# R:n6-atlas-...-**bt-77** [10*] ("BitNet Quantization n=6 — 2B4T 25/26 EXACT,
# 3 models x 2 teams, 40/41 total") is registered as a one-line citation. Its
# witness body lives in hexa-chip/AI-EFFICIENCY.md §bt77-bitnet-quantization-n6.md
# (3-star, p<1e-15). Reading the FULL witness (not the one-line raw) shows
# "25/26 EXACT" is NOT a served-accuracy / capability benchmark — it is an n=6
# NUMEROLOGY claim: the 26 config hyper-parameters of BitNet b1.58 2B4T each
# "EXACT-match" a closed-form expression over the n=6 divisor constants
# { n=6, sigma=12, phi=2, tau=4, sopfr=5, J2=24, mu=1 }. Examples:
#   d_model 2560   = 2^(sigma-tau)*(sigma-phi) = 256*10
#   n_layers 30    = sopfr*n
#   n_heads 20     = (sigma-phi)*phi
#   d_ffn 6912     = 2^(sigma-tau)*(n/phi)^(n/phi) = 256*27 = 2^8 * 3^3
#   vocab 128256   = 2^(sigma-sopfr)*10^(n/phi) + 2^(sigma-tau) = 128000+256
#   rope_theta 500K= sopfr*(sigma-phi)^sopfr
# The "26" denominator INCLUDES the lone non-EXACT row (the 71.4x 7nm energy
# ratio, graded CLOSE: within 0.8% of sigma*n=72) -> 25 EXACT + 1 CLOSE = 26.
# "40/41 total" folds in two sibling models from the 1bitLLM team
# (bitnet_b1_58-large 700M: 6/6 EXACT; bitnet_b1_58-3B: 6/6 EXACT).
#
# This is COMPLETELY ORTHOGONAL to the SANDBOX 20-task manifest used in M1/M2 —
# BT-77 says nothing about served accuracy. The earlier M1 instinct ("the bench
# IS the recompute surface, no --expr path") was wrong about WHICH bench: the
# correct recompute is deterministic config-arithmetic, not serving.
#
# RECOMPUTE (bench/bitnet_m5_bt77_recompute.hexa): for each claimed
# (param -> n=6 expr -> value) triple, (a) evaluate the n=6 expression in
# hexa-native integer/rational arithmetic and check == claimed value, and
# (b) for params present in config.json, cross-check the claimed value against
# the REAL local microsoft/bitnet-b1.58-2B-4T-bf16/config.json (on disk from M1).
# Cost = $0, no GPU, no serving. Base n=6 constants separately confirmed 🔵
# SUPPORTED-FORMAL via `hexa verify --expr {sigma,phi,tau,mu}(6)`.
#
# RESULT: 0 FAIL. Every n=6 expression evaluates to its claimed value; every
# config.json-present architecture parameter matches the real shipped config.
# 2B4T witness-aligned = 25/26 EXACT + 1 CLOSE -> reproduces the registered claim
# bit-for-bit. All 3 models raw = 38/40 EXACT (+1 CLOSE).
#
# HONEST CONFOUND (never hidden): the recompute confirms (i) the witness arithmetic
# is internally consistent and (ii) the architecture values match the real config.
# It does NOT adjudicate whether n=6-expressibility is CAUSAL vs an artifact of a
# flexible 7-constant basis (+,-,*,/,^, up to ~3 terms; the witness itself estimates
# ~5% random-hit rate per integer in [1,10000]). That significance question is
# separate and NOT recomputable. So the M5 verdict is "the registered arithmetic
# reproduces exactly on our substrate, 0 FAIL" — not "n=6 governs BitNet design".

@C d_bt77_is_n6_numerology_not_accuracy := "atlas BT-77 '2B4T 25/26 EXACT' is an n=6 CONFIG-ARITHMETIC claim, NOT a served-accuracy benchmark — orthogonal to the SANDBOX 20-task manifest" :: landed [verified_tier=GREEN status=measured-in-repo]
  cmd     = "hexa atlas lookup R 'n6-atlas-...-**bt-77**'; read full witness hexa-chip/AI-EFFICIENCY.md §bt77-bitnet-quantization-n6.md"
  hyp     = "BT-77's 25/26 measures something reproducible on our substrate"
  verdict = "TRUE + IDENTIFIED — it measures n=6-expressibility of 26 config hyper-params (25 EXACT + 1 CLOSE energy ratio). Deterministic closed-form, reproducible at $0. .verdicts/bitnet/m5_bt77_recompute.txt"

@C d_bt77_recompute_confirms := "BT-77 recompute CONFIRMS the registered claim — 2B4T 25/26 EXACT reproduced bit-for-bit, 0 FAIL, every config value matches real shipped config.json" :: landed [verified_tier=GREEN status=measured-in-repo]
  cmd     = "bench/bitnet_m5_bt77_recompute.hexa — eval 38 n=6 exprs hexa-native + cross-check arch params vs local microsoft/bitnet-b1.58-2B-4T-bf16/config.json"
  hyp     = "the registered '2B4T 25/26 EXACT, 40/41 total' arithmetic reproduces on our own substrate"
  verdict = "CONFIRMED 🟢 SUPPORTED-NUMERICAL — 2B4T witness-aligned 25/26 EXACT + 1 CLOSE (energy), all-3-models raw 38/40 EXACT, FAIL=0. Base n=6 consts 🔵 via hexa verify --expr. .verdicts/bitnet/m5_bt77_recompute.tsv"

@C d_bt77_significance_confound := "n=6-expressibility CONFIRMED-CONSISTENT but causality UNDECIDED — flexible 7-constant basis confound is not recomputable" :: landed [verified_tier=AMBER status=disclosed]
  cmd     = "confound analysis: 7 consts x {+,-,*,/,^} x ~3 terms ~= 5% random-hit per integer in [1,10000] (witness §9)"
  hyp     = "recompute can settle whether n=6 CAUSALLY governs BitNet's architecture"
  verdict = "CANNOT — recompute proves arithmetic consistency + real-config match (0 FAIL), but cannot separate causal n=6 structure from flexible-basis coincidence. The verdict is scoped to 'arithmetic reproduces', not 'n=6 is causal'. Honest residual, not a falsification."

@C d_bitnet_m6_seed_significance := "next-cycle seed — quantify the BT-77 basis-flexibility confound with a null model (random-architecture n=6-hit baseline)" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "build a null: sample N plausible LLM config integers (powers of 2, round dims), measure the fraction expressible in <=3 n=6 constants; compare BitNet's 25/26 hit-rate to the null hit-rate to put a real p-value on 'better than a flexible basis would give by chance'"
  hyp     = "BitNet's n=6 EXACT-rate is significantly above the null random-architecture rate -> the numerology is more than basis flexibility"
  verdict = "PENDING — M6.BITNET. This is the recomputable companion to the un-recomputable causality question: it does not need GPU/serving, only an enumeration of the n=6-expressible integers vs a random-config null. Closes the confound BT-77's witness §9 estimates by hand (~5%)."
