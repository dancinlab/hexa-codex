@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "sandbox-cross-arch-frontier-paper"
  source = "M4.BITNET canonical-paper gate eval (cycle following #46) — BITNET-solo NOT-SHIP, paper-worthy finding lives one level up at SANDBOX"
  date   = "2026-05-25"
  flow   = "M4.BITNET gate-eval -> §formula 🟠 (constant) NOT-SHIP -> paper-worthy finding = cross-arch frontier (SANDBOX-owned, cx_paper_one_per_domain) -> off-active-domain (g58) -> SANDBOX-cycle seed (cx_discovery_log)"

# ════════════════════════════════════════════════════════════════════════════
# WHY THIS SEED EXISTS — M4.BITNET cannot clear its own gate
# ════════════════════════════════════════════════════════════════════════════
# M4.BITNET (the BITNET-solo canonical paper) was gate-evaluated and is NOT-SHIP:
#   §formula 🟠 — the M3 bit↔quality "law" is acc(bpw)=30.0%, a 1-parameter CONSTANT,
#                 not a paper-grade closed-form (SUBSTRATE M4 bar = 2-param logistic;
#                 OPS M4 bar = M/M/c Erlang-C). A flat constant is a NEGATIVE result,
#                 not a law. This cell BLOCKS cx_paper_gate + cx_paper_significance.
#   §method 🟢 · §benchmark 🟢 (3-axis robustness) but §benefit 🟠 (the only positive
#                 delta — memory 0.55x — is packaged with a FALSIFIED quality half).
#   Full per-section table: .verdicts/bitnet/m4_paper_gate_eval.txt.
# M4.BITNET stays [ ], annotated BLOCKED_NO_NONTRIVIAL_FORMULA in BITNET.md. No paper
# scaffolded (cx_paper_violation — ship-then-revoke is strictly worse).
#
# ════════════════════════════════════════════════════════════════════════════
# THE FINDING THAT IS PAPER-WORTHY (one level up — cross-architecture frontier)
# ════════════════════════════════════════════════════════════════════════════
# On the byte-identical 20-task canonical manifest, one byte_exact_subset scorer,
# three engines, all $0 local on mac-mini-m3:
#   BitNet b1.58 2B4T  (ternary)            6/20  = 30.0%   RSS 1527 MB (i2_s)
#   RWKV-7 Goose 2.9B  (attn-free RNN)     15/20  = 75.0%   RSS 2249 MB FLAT (no KV)
#   Qwen2.5-0.5B-Q4    (Transformer)       16/20  = 80.0%   KV-cache O(n) growth
# A quantified capability x memory x bits frontier across THREE architecture FAMILIES.
# Real §benchmark (each point already 🟢) + real §benefit (cross-family delta).
# BUT: this is a CROSS-DOMAIN paper (BITNET + RWKV + SANDBOX) — natural owner = SANDBOX
# (the substrate that measured all three) per cx_paper_one_per_domain; it is NOT a
# BITNET-solo paper. And it is OFF the active BITNET domain (g58) — scaffolding it is a
# SANDBOX-cycle decision, NOT done this round. Recorded as a seed only.
#
# Sources (all committed):
#   BitNet: .verdicts/bitnet/m1_accuracy_floor_summary.txt + m2plus_i2s_true_1_58bit.txt
#   RWKV:   .verdicts/rwkv/m1_accuracy_floor_summary.txt
#   Qwen:   SANDBOX stage-0 baseline (bench/sandbox_stage0_baseline.hexa)

@C d_sandbox_cross_arch_frontier := "cross-architecture capability x memory x bits frontier on the byte-identical 20-task manifest — BitNet 30% / RWKV-7 75% / Qwen-0.5B-Q4 80% across ternary / attn-free-RNN / Transformer families, $0 local" :: seed [verified_tier_target=NUMERICAL status=open]
  cmd     = "aggregate the 3 committed per-model floor summaries (BitNet i2_s 6/20, RWKV-7 2.9B 15/20, Qwen2.5-0.5B-Q4 16/20) + memory axis (BitNet 1527MB ternary, RWKV 2249MB flat no-KV, Transformer KV-growth) into one SANDBOX frontier table; identical manifest + byte_exact_subset scorer across all three"
  hyp     = "the three architecture families trace a closed-form capability/memory/bits frontier (a non-trivial law, NOT the BitNet constant) that clears the SANDBOX canonical-paper §formula bar"
  verdict = "OPEN — the three points are a 3-row TABLE today, not yet a fitted closed form. Paper-gradeable in principle (real bench + real cross-family benefit) but cx_paper_one_per_domain assigns it to SANDBOX, and g58 keeps it off the BITNET cycle. Seeded for a SANDBOX cycle; NOT scaffolded."

@C d_sandbox_cross_arch_formula_needed := "graduation requirement — the cross-arch frontier needs a closed-form §formula (>=2 fitted params, recompute-verifiable vs committed data) over the bits/architecture/capability frontier, NOT a 3-row table and NOT the BitNet acc(bpw)=30% constant" :: seed [verified_tier_target=FORMAL status=open]
  cmd     = "fit + commit a closed-form frontier law (e.g. capability-vs-active-param / vs-bits-per-weight, or a memory-per-correct-answer curve) with >=2 params recomputed by a verify/numerics_*.hexa against committed per-model data, matching the SUBSTRATE 2-param-logistic / OPS Erlang-C precedent; add >=1 more architecture point (Mamba/SSM or larger Transformer) for fit DOF"
  hyp     = "a >=2-param frontier law recomputed vs committed data converts the 3-row table into a paper-grade §formula -> SANDBOX canonical-paper gate 4/4"
  verdict = "OPEN — four graduation steps: (1) closed-form >=2-param frontier law, recompute-verifiable; (2) >=1 more arch point for DOF; (3) memory axis closed at matched context (the RWKV M2 ctx-length sweep — RWKV flat vs Transformer O(n) — is the natural §formula candidate); (4) SANDBOX-cycle ownership decision (confirm SANDBOX group vs ECONOMICS/OPS). Until then, NOT-SHIP, same honest-residual posture as M4.BITNET."
