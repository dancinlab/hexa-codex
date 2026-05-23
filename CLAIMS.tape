@V := "tape" :: spec [active]
  version = "1.2"

@I := "claims-index" :: identity [active]
  brief = "Single audit index of verifiable hexa-codex claims (cx_claim_manifest)."
  flow  = "claim → hexa verify (g5) → .verdicts/<slug>.tape → /paper gate"

# economics-n6-ladder — n=6 lattice atlas atom recompute (slug)
#
# Scope: pure atlas-atom arithmetic for the n=6 lattice that the
# ECONOMICS group's verb internals (train_cost · infer_cost ·
# quality_scale) reference. Modeling-level claims that bind these
# constants to empirical AI scaling laws are out of scope — they
# belong to a separate slug with T4 empirical contact.
#
# Method legend (cx_claim_verify):
#   atom  — `hexa verify --expr <fn> <n> <v>` (atlas atom recompute → BLUE)
#
# Gate (cx_paper_gate): 100% BLUE required. No non-blue residual.

@C ec_sigma_6 := "sigma(6) = 12" :: atom [slug=economics-n6-ladder]
  method = "atom"
  cmd    = "hexa verify --expr sigma 6 12"

@C ec_phi_6 := "phi(6) = 2" :: atom [slug=economics-n6-ladder]
  method = "atom"
  cmd    = "hexa verify --expr phi 6 2"

@C ec_tau_6 := "tau(6) = 4" :: atom [slug=economics-n6-ladder]
  method = "atom"
  cmd    = "hexa verify --expr tau 6 4"

@C ec_sigma2_6 := "sigma_2(6) = 50" :: atom [slug=economics-n6-ladder]
  method = "atom"
  cmd    = "hexa verify --expr sigma_2 6 50"
