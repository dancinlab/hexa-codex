@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "m5-substrate-multimodal-residual"
  source = "M5.SUBSTRATE release gate — text capability-eval half landed, multimodal half scoped (cycle-17)"
  date   = "2026-05-25"
  flow   = "g51-paper-land -> milestone-half-done -> explicit multimodal residual -> next-milestone seed (cx_discovery_log)"

# ════════════════════════════════════════════════════════════════════
# CONTEXT — what landed this cycle vs what M5.SUBSTRATE still names
# ════════════════════════════════════════════════════════════════════
# M5.SUBSTRATE = "SUBSTRATE release with multimodal + capability eval landing".
# Cycle-17 landed the TEXT capability-eval half: PAPER/substrate-capability-evals/
# expanded to commons g51 publish-readiness — 11 pages (>=10 OK) + 1 fal.ai figure
# (figures/fig01_cliff_schematic.png, provenance figures/_prompts/01_cliff_schematic.txt,
# embedded page 5). All 4 sections stay 🟢 SUPPORTED-NUMERICAL; §Formula links the
# 2-param logistic recompute (.verdicts/sandbox/m4_substrate_formula_fit.txt, 5/5).
# NO new numeric claim was added — the expansion is derivation + Related Work +
# extended results + limitations + per-rung appendix + recompute transcript.
#
# The "multimodal" half of M5.SUBSTRATE is HEAVY NEW SCOPE and was NOT attempted
# this round (honest-no-pad). It needs a multimodal model ON the substrate + a NEW
# eval family with a deterministic byte-exact scorer + a closed-form fit recomputed
# by a hexa-native verifier against committed multimodal-bench data — i.e. the same
# cx_paper_gate bar the text half just met, but for a modality the substrate does
# not yet serve. So M5.SUBSTRATE stays [ ] PENDING the multimodal landing even
# though g51 now passes for the text paper.
#
# Tool note (cross-ref INBOX.log.md 2026-05-25): `/paper lint` page check is
# blocked by a hexa runtime same-name `let` shadowing bug (registered to INBOX,
# target hexa-lang); g51's two conditions were verified INDEPENDENTLY (pdfinfo
# Pages:11; fal PNG embedded + provenance prompt) — pass on the merits.

@C d_m5_substrate_text_half_landed := "M5.SUBSTRATE text capability-eval half landed — substrate paper at commons g51 (11 pages + 1 fal.ai figure), 4 sections 🟢" :: landed [verified_tier=GREEN status=published-in-repo]
  cmd     = "expand PAPER/substrate-capability-evals to g51 with genuine content (derivation, related work, extended results, limitations, per-rung appendix, recompute transcript); generate fal.ai cliff schematic; compile + verify page count"
  hyp     = "the stepwise-cliff logistic finding honestly supports >=10 pages without padding"
  verdict = "TRUE — 11 pages of genuine content (no padding); fal.ai fig01_cliff_schematic.png embedded; §Formula 2-param logistic recompute 5/5 PASS re-run this cycle. g51 met on the merits (page check auto-lint blocked by hexa let-shadowing bug, verified manually via pdfinfo). NO new numeric claim — expansion only."

@C d_m5_substrate_multimodal_residual := "M5.SUBSTRATE multimodal half — heavy new scope, NOT attempted; explicit next-milestone seed" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "scope (not build) a multimodal SUBSTRATE capability eval: (1) serve a vision-language Qwen2.5-VL rung on the substrate with seed-pinned byte-exact replay (image-input determinism, a serving-stack extension not a config flag); (2) build + commit an image-grounded task manifest stratified by a difficulty axis analogous to wc, with a byte-exact non-self-judging scorer; (3) fit a closed-form capability curve and recompute it with a hexa-native verifier vs committed multimodal-bench data -> 🟢"
  hyp     = "a multimodal rung exhibits a locatable capability cliff fittable by a closed-form law under the same cx_paper_gate bar the text half met"
  verdict = "PENDING — next-milestone work; M5.SUBSTRATE stays [ ] until this lands. Effort comparable to building the text Stage-2 manifest + a new serving path; NOT a one-cycle add. Cheapest first probe: a single VL rung smoke-eval to confirm the substrate can serve image inputs deterministically before any manifest build."

@C d_m5_substrate_4b_rung_prediction := "falsifiable side-prediction the text paper makes — cliff midpoint x0≈3.9B testable by landing a 4B rung" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "land a 4B Qwen2.5 rung (existing SKU, not yet on disk) on the substrate; re-run the wc_31_60 nano eval; check whether the measured 4B accuracy lands on the logistic at x=log2(4)=2.0 (predicted y≈0.371) — tightening the cliff bracket from [3B,7B] to a sharper interval"
  hyp     = "the logistic-fitted cliff midpoint x0=1.973 (≈3.9B) predicts the 4B rung accuracy within the N=30 binomial band"
  verdict = "PENDING — single most informative next text-side measurement (§Limitations item 1); distinct from the multimodal residual, cheaper ($0 local if 4B GGUF fits 24GB UMA)."
