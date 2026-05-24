@V := "tape" :: spec [active]
  version = "1.2"

@note := "M4.SAFETY canonical-paper gate assessment — BLOCKED (honest residual, NO paper shipped)" :: workflow [active]
  cycle    = "16 (SANDBOX)"
  date     = "2026-05-25"
  decision = "DO NOT SHIP — cx_paper_gate + cx_paper_significance + cx_paper_sections fail at §Formula"
  outcome  = "M4.SAFETY stays [ ]; no PAPER/safety-* scaffolded; honest residual recorded (same outcome the M4.SUBSTRATE §Formula gate faced pre-cycle-15c)"

# ════════════════════════════════════════════════════════════════════════════
# CANDIDATE FINDING (the just-unblocked M3.SAFETY result)
# ════════════════════════════════════════════════════════════════════════════
# Route(b) MECHANISTIC refusal direction — `.verdicts/sandbox/m2_safety_mechanical_probe.txt`:
#   per-layer activation-norm vector (84 feat = 28 layer × {residual,attn,mlp}) at the
#   last prompt token LINEARLY SEPARATES refused vs answered on the matched-pair set
#   (Qwen2.5-1.5B-Instruct, 20 adv + 20 benign, 20 refused / 20 answered):
#     full-vector difference-of-means projection AUROC = 0.98 (in-sample)
#     leave-one-out held-out linear acc = 0.825 (33/40) vs majority 0.50
#     permutation p = 0.005 (0/200 shuffles reached 0.825)
#   3 distinct motifs (mid-layer residual L17-19 ↑, MLP L17-22 ↑, late attn L22/23/26 ↓).
#   Route(a) first-token logprob margin = CONFIRMED NEGATIVE
#     (`.verdicts/sandbox/m2_safety_bimodality_tighter.txt`, gap 5.9× below bimodality bar).
# This is a GENUINE, interesting mechanistic finding. It is NOT, however, paper-canonical
# under the strict hexa-codex governance — see the per-section gate below.

# ════════════════════════════════════════════════════════════════════════════
# PER-SECTION GATE (cx_paper_format · cx_paper_sections · cx_paper_gate)
# ════════════════════════════════════════════════════════════════════════════
@section_formula := "§Formula — linear refusal-direction classifier w·a > θ" :: gate [active]
  tier        = "🟠 INSUFFICIENT — BLOCKS the paper"
  candidate   = "score(a) = w·a > θ, w = 84-dim difference-of-means refusal direction"
  why_blocked = "
    (1) NOT a closed-form recompute-verifiable LAW. It is a LEARNED empirical direction
        (difference-of-means over n=40), not a closed form. The SUBSTRATE §Formula
        precedent (cycle-15c, m4_substrate_formula_fit.txt) cleared 🟢 only because a
        2-param logistic LAW was RECOMPUTED by verify/numerics_substrate_cliff_logistic.hexa
        from {k,x0,L_lo,L_hi} against 4 COMMITTED data points → deterministic 5/5 PASS.
    (2) NO committed recompute surface. To independently recompute AUROC=0.98 / LOO=0.825 /
        permutation p=0.005 a .hexa verifier needs the per-row 84-feature vectors + labels.
        Those exist ONLY in ~/sandbox_probe/motif_summary.json on ubu-1 (raw-bench-SoT,
        explicitly NOT repo-committed per project_bench_sot + the verdict's own raw_artifacts
        block). There is no in-repo data for a hexa-native recompute — unlike the substrate
        cliff whose /30 fractions are carried verbatim in the verifier.
    (3) The probe verdict returns ⚪ SPECULATION-FENCED on `hexa verify --fence`, not 🟢/🔵.
        cx_paper_gate requires 100% formal-blue OR numerical-green; cx_paper_sections requires
        each section link a formal-blue (substrate-precedent: green) verdict. A ⚪ section fails.
    (4) n=40 with 84 features — the verdict's OWN honest-residuals block flags in-sample
        overfit; even LOO=0.825 is held out on n=40. A canonical §Formula on n=40 with no
        recompute surface is the 'n=40 too weak for a canonical claim' failure mode."
  verdict_path = ".verdicts/sandbox/m2_safety_mechanical_probe.txt  (⚪ T4 empirical, --fence ⚪)"

@section_method := "§Method — activation-capture protocol (HF forward-hook residual/attn/mlp tap)" :: gate [active]
  tier        = "🟠 only ⚪-tier link available"
  note        = "Protocol is real + reproducible (activation_capture_hf.hexa hook logic, full-precision
                 Qwen2.5-1.5B, ubu-1 RTX 5070). But the only verdict carrying it is the same ⚪ probe
                 verdict — no green/blue method verdict to link, and it stands or falls with §Formula."
  verdict_path = ".verdicts/sandbox/m2_safety_mechanical_probe.txt  (⚪)"

@section_benchmark := "§Benchmark — 40-prompt matched-pair probe (AUROC/LOO numbers)" :: gate [active]
  tier        = "🟠 ⚪-tier; n=40 underpowered for canonical"
  note        = "The matched-pair design is sound and the topic-confound control passes. But (a) the
                 numbers live in a ⚪ T4 verdict with no committed recompute surface, and (b) n=40 is
                 the explicit canonical-strength concern. Real run, yes; canonical-grade green, no."
  verdict_path = ".verdicts/sandbox/m2_safety_mechanical_probe.txt  (⚪)"

@section_benefit := "§Benefit — AUROC 0.98 / LOO 0.825 vs 0.50 majority + route-a-negative contrast" :: gate [active]
  tier        = "🟠 ⚪-tier (benefit delta is real but inherits the §Formula/§Benchmark block)"
  note        = "The benefit framing is genuinely strong: a mechanistic surface succeeds where the
                 first-token-margin surface was a confirmed negative (5.9× below the bimodality bar).
                 But the delta is computed from the same un-recomputable ⚪ numbers; it cannot anchor a
                 green/blue section while §Formula has no closed-form recompute."
  verdict_path = ".verdicts/sandbox/m2_safety_mechanical_probe.txt  (⚪) + m2_safety_bimodality_tighter.txt (route-a negative, ⚪)"

# ════════════════════════════════════════════════════════════════════════════
# DECISION
# ════════════════════════════════════════════════════════════════════════════
@decision := "DO NOT SHIP a violating canonical SAFETY paper" :: workflow [active]
  rationale = "cx_paper_gate fails (no 100% green/blue — every section is ⚪); cx_paper_significance
               fails (§Formula is a learned direction, not a closed-form recompute-verifiable LAW + real
               bench + delta); cx_paper_sections fails (no section links a green/blue verdict).
               cx_paper_violation mandates immediate revocation of a gate-failing paper, so shipping
               then revoking is strictly worse than not shipping. Honest residual over premature claim."
  m4_safety = "stays [ ] — annotated BLOCKED_PENDING_FORMULA_RECOMPUTE in SANDBOX.md"

# ════════════════════════════════════════════════════════════════════════════
# WHAT WOULD UNBLOCK M4.SAFETY (next-cycle claim seed — cx_discovery_log link)
# ════════════════════════════════════════════════════════════════════════════
@unblock := "the closed-form recompute surface §Formula needs" :: workflow [active]
  path_A = "COMMIT the per-row data: write the 40 rows × {84-feature projection score, label} from
            ubu-1's motif_summary.json into a repo TSV (adv snippets REDACTED per cx_hf_safety_private),
            then a hexa-native verify/numerics_safety_refusal_direction.hexa that RECOMPUTES the
            difference-of-means w, the per-row projections, AUROC, the LOO held-out acc, and the
            permutation p from the committed data → deterministic PASS (the substrate-cliff pattern).
            This converts the ⚪ probe into a 🟢 recompute verdict and makes §Formula link-able."
  path_B = "STRENGTHEN n: re-run the probe at n≫40 (more matched pairs / more model rungs) so the
            held-out separation is canonical-grade, not n=40-overfit-flagged."
  note   = "Either path is a clean next-cycle SANDBOX claim. Until one lands, M4.SAFETY is honestly [ ]."

# g51 publish-lint (≥10 pages + ≥1 fal.ai figure) is NOT relevant here — no paper was scaffolded,
# and g51 belongs to M5.SAFETY release, not this section-verdict gate. No page-padding / forced
# figure (no gold-plating).
