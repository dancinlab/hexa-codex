@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "sandbox-byte-exact-blast-radius"
  source = "BITNET M1 scorer-ablation spillover — the byte_exact_subset confound is NOT BitNet-only; the SAME scorer grades 21 files across bench/ + .verdicts/sandbox/"
  date   = "2026-05-25"
  flow   = "bitnet-rescore-built -> same scorer found across 21 SANDBOX files -> CROSS-DOMAIN seed (g58: SANDBOX-domain work, do NOT execute here) -> SANDBOX-active cycle re-scores its own verdicts"

# ════════════════════════════════════════════════════════════════════
# CONTEXT — the BITNET M1 fix surfaced a SANDBOX-domain blast radius
# ════════════════════════════════════════════════════════════════════
# Resolving the BITNET M1 measurement confound (the /gap ROOT-A finding) produced
# an INSTRUCT-FAIR scorer family (bench/bitnet_m1_scorer_ablation.hexa): alongside
# byte_exact_subset, a whitespace-lenient scorer and an answer-extraction scorer.
# Re-scoring BitNet's SAVED completions showed 30% -> 35% (lenient) / 30% (extract)
# — i.e. for BitNet the artifact was only +5pp (1 of 14 failures). 30% is a real floor.
#
# BUT the SAME byte_exact_subset (case-fold + literal grep -qF substring, authored
# for the 0.5B BASE model in stage0) is used by 21 files in this repo:
#   bench/sandbox_stage0_baseline.hexa            (THE 16/20=80% Qwen-0.5B-Q4 floor)
#   bench/sandbox_stage1_persona.hexa
#   bench/sandbox_stage2_manifest_gen.hexa
#   bench/sandbox_stage2_persona_scaled.hexa
#   bench/sandbox_stage2_persona_scaled_1_5b.hexa
#   bench/sandbox_stage2_persona_scaled_3b.hexa
#   bench/sandbox_stage2_persona_scaled_7b.hexa
#   bench/sandbox_stage3_earlystop_local.hexa
#   bench/sandbox_stage4_context_scaling.hexa
#   bench/sandbox_stage4_json_schema.hexa
#   bench/bitnet_m1_accuracy_floor.hexa           (BITNET — already re-scored, see other tape)
#   + 10 persisted summaries under .verdicts/sandbox/*.txt
# (21 total via `grep -rl byte_exact_subset bench/ sandbox/ .verdicts/`.)
#
# The SANDBOX numbers (esp. the larger 1.5B/3B/7B persona-scaled rungs, which are
# INSTRUCT models more prone to the same verbosity failure mode as BitNet 2B4T)
# may carry the SAME scorer-artifact bias the BitNet ablation just quantified. The
# 0.5B stage-0 floor itself once flipped 19/20 -> 16/20 when a stderr-trailer leak
# was fixed (commit d79306e) — precedent that this scorer's verdicts are sensitive.
#
# BLAST RADIUS = up to 21 files; the load-bearing one is the canonical 16/20 stage-0
# floor that every SANDBOX comparison (incl. this BITNET domain) is benchmarked against.
#
# WHY A SEED, NOT AN ACTION (g58): re-scoring those verdicts is SANDBOX-DOMAIN work.
# This cycle is BITNET-active. Do NOT touch SANDBOX verdicts here — register the
# seed and let a SANDBOX-active cycle run it (the fair-scorer family already exists
# in bench/bitnet_m1_scorer_ablation.hexa and is trivially repointed at any saved TSV).

@C d_sandbox_byte_exact_blast_radius := "the byte_exact_subset scorer-artifact confound is repo-wide — 21 files incl. the canonical 16/20 stage-0 floor use it; re-score under the fair scorer family in a SANDBOX cycle" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "SANDBOX cycle: repoint bench/bitnet_m1_scorer_ablation.hexa's re-score loop at each .verdicts/sandbox/*.tsv (saved completions, NO re-serve) under byte_exact_subset | lenient_normalized | answer_extraction; report per-file delta. Start with stage0 (the 16/20 floor) and the 1.5B/3B/7B persona-scaled instruct rungs (most verbosity-prone)."
  hyp     = "the instruct SANDBOX rungs (1.5B/3B/7B persona-scaled) carry the same verbosity-driven byte_exact_subset penalty BitNet did; a fair scorer raises their numbers — though, per the BitNet result (+5pp only), the lift may be small for the well-behaved 0.5B base floor"
  verdict = "PENDING — SANDBOX-domain (g58: NOT executed in this BITNET cycle). The deterministic fair-scorer family already exists (bench/bitnet_m1_scorer_ablation.hexa); a SANDBOX-active cycle re-scores its own saved TSVs. Falsifier: if the fair-scorer delta on the 0.5B stage-0 floor is 0, the canonical floor is confound-free and only the larger instruct rungs need revisiting."
