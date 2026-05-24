@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "m4-safety-paper-gate-blocked"
  source = "M4.SAFETY canonical-paper gate eval (cycle-16, PR #29)"
  date   = "2026-05-25"
  flow   = "gate-eval -> honest NOT-SHIP -> unblock seed -> next-cycle CLAIMS candidate (cx_discovery_log)"

# ════════════════════════════════════════════════════════════════════
# CANDIDATE FINDING (just-unblocked M3.SAFETY result)
# ════════════════════════════════════════════════════════════════════
# Route(b) MECHANISTIC refusal direction — .verdicts/sandbox/m2_safety_mechanical_probe.txt:
#   per-layer activation-norm vector (84 feat = 28 layer x {residual,attn,mlp}) at the last
#   prompt token LINEARLY SEPARATES refused vs answered (Qwen2.5-1.5B, 20 adv + 20 benign):
#     difference-of-means projection AUROC = 0.98 (in-sample)
#     leave-one-out held-out linear acc = 0.825 (33/40) vs majority 0.50
#     permutation p = 0.005 (0/200 shuffles reached 0.825)
#   3 motifs (mid residual L17-19 up, MLP L17-22 up, late attn L22/23/26 down).
#   Route(a) first-token logprob margin = CONFIRMED NEGATIVE (m2_safety_bimodality_tighter.txt).
# Genuine + interesting, but NOT paper-canonical under strict governance — see gate below.
#
# PER-SECTION GATE (cx_paper_format · cx_paper_sections · cx_paper_gate):
#   §Formula   🟠 BLOCKS — score(a)=w·a>θ is a LEARNED difference-of-means direction (n=40),
#              NOT a closed-form recompute-verifiable LAW. SUBSTRATE §Formula cleared 🟢 only
#              because a 2-param logistic LAW was recomputed vs committed data (5/5 PASS).
#   §Method    🟠 — only the ⚪ probe verdict carries it; no green/blue method verdict.
#   §Benchmark 🟠 — n=40 underpowered; numbers live in a ⚪ T4 verdict, no committed recompute.
#   §Benefit   🟠 — real delta (mechanistic succeeds where route-a failed) but inherits the block.
# DECISION: DO NOT SHIP (cx_paper_violation — shipping then revoking is strictly worse).
#   M4.SAFETY stays [ ], annotated BLOCKED_PENDING_FORMULA_RECOMPUTE in SANDBOX.md.
# g51 publish-lint N/A (no paper scaffolded; belongs to M5.SAFETY release).

@C d_m4_safety_gate_blocked := "M4.SAFETY canonical paper BLOCKED at §Formula — mechanistic refusal direction is a learned direction not a closed-form law; all 4 sections ⚪" :: blocked [verified_tier=WHITE status=not-shipped]
  cmd     = "evaluate M3.SAFETY route(b) finding vs cx_paper_gate/significance/sections — map 4 sections to verdicts"
  hyp     = "the AUROC-0.98 refusal-direction finding clears the canonical SAFETY paper gate"
  verdict = "FALSE — §Formula 🟠 (learned direction, not closed-form); every section links only the ⚪ m2_safety_mechanical_probe.txt; cx_paper_gate requires 100% green/blue. M4.SAFETY stays [ ]."

@C d_m4_safety_unblock_seed := "unblock seed — commit per-row projection TSV + hexa-native recompute to convert ⚪ probe -> 🟢 (substrate-cliff pattern)" :: seed [verified_tier_target=GREEN]
  cmd     = "path_A: commit 40-row {84-feat projection score, label} TSV from ubu-1 motif_summary.json (adv snippets REDACTED per cx_hf_safety_private) + verify/numerics_safety_refusal_direction.hexa recomputing w, projections, AUROC, LOO, permutation p -> deterministic PASS"
  hyp     = "a committed recompute surface converts the ⚪ probe to 🟢 -> §Formula link-able -> M4.SAFETY gate opens"
  verdict = "PENDING — next-cycle SANDBOX claim (path_B alt: re-run probe at n>>40 for canonical-grade separation)"
