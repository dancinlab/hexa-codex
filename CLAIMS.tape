@V := "tape" :: spec [active]
  version = "1.2"

@I := "claims-index" :: identity [active]
  brief = "Single audit index of verifiable hexa-codex claims (cx_claim_manifest)."
  flow  = "claim → hexa verify (g5) → .verdicts/<slug>.tape → /paper gate"

# ECONOMICS group — n=6 ladder claims (slug = economics-n6-ladder)
#
# Method legend (cx_claim_verify):
#   atom  — `hexa verify --expr <fn> <n> <v>` (atlas atom recompute)
#   expr  — `hexa verify --expr <fn> <a> <b> <v>` (2-operand atom recompute)
#   fence — `hexa verify --fence "<claim>"` (honest speculation fence)
#   run   — `hexa run verify/<file>.hexa` (closed-form recompute via verifier)

@C ec_sigma_6 := "sigma(6) = 12" :: atom [slug=economics-n6-ladder]
  method = "atom"
  cmd    = "hexa verify --expr sigma 6 12"

@C ec_phi_6 := "phi(6) = 2" :: atom [slug=economics-n6-ladder]
  method = "atom"
  cmd    = "hexa verify --expr phi 6 2"

@C ec_tau_6 := "tau(6) = 4 — infer_cost ctx exponent" :: atom [slug=economics-n6-ladder]
  method = "atom"
  cmd    = "hexa verify --expr tau 6 4"

@C ec_sigma2_6 := "sigma_2(6) = 50" :: atom [slug=economics-n6-ladder]
  method = "atom"
  cmd    = "hexa verify --expr sigma_2 6 50"

@C ec_quality_alpha := "quality_scale loss-fit exponent alpha = phi(6)/sigma(6) = 1/6" :: modeling [slug=economics-n6-ladder]
  method = "fence"
  cmd    = "hexa verify --fence \"quality_scale loss-fit exponent alpha = phi(6)/sigma(6) = 1/6 (n=6 modeling claim)\""

@C ec_train_n6exp := "train_cost exponent N6_EXP = J2/(J2+1) = 24/25 = 0.96" :: modeling [slug=economics-n6-ladder]
  method = "fence"
  cmd    = "hexa verify --fence \"train_cost exponent N6_EXP = J2/(J2+1) = 24/25 (n=6 modeling claim, J2 = sigma*phi = 24)\""

@C ec_pareto_optimum := "Pareto optimum D/N = (A/B)^(1/alpha) approx 1.07 for n=6, vs Chinchilla 20" :: modeling [slug=economics-n6-ladder]
  method = "fence"
  cmd    = "hexa verify --fence \"ECONOMICS Pareto optimum D/N approx 1.07 at n=6 alpha=1/6, distinct from Chinchilla published ~20 (modeling)\""

@C ec_cross_pillar := "ECONOMICS 3-pillar cross-pillar verifier closes 10/10" :: run [slug=economics-n6-ladder]
  method = "run"
  cmd    = "hexa run verify/numerics_economics_cross_pillar.hexa"
  sent   = "__HEXA_CODEX_NUMERICS_ECONOMICS_CROSS_PILLAR__ PASS"

@C ec_scaling_laws := "ECONOMICS scaling-laws sweep closes 10/10" :: run [slug=economics-n6-ladder]
  method = "run"
  cmd    = "hexa run verify/numerics_economics_scaling_laws.hexa"
  sent   = "__HEXA_CODEX_NUMERICS_ECONOMICS_SCALING_LAWS__ PASS"

@C ec_pareto_envelope := "ECONOMICS Pareto envelope verifier closes 10/10" :: run [slug=economics-n6-ladder]
  method = "run"
  cmd    = "hexa run verify/numerics_economics_pareto.hexa"
  sent   = "__HEXA_CODEX_NUMERICS_ECONOMICS_PARETO__ PASS"

@C ec_ladder_report := "ECONOMICS recipe §3 ladder report closes 10/10 — per-verb closure_pct=100%" :: run [slug=economics-n6-ladder]
  method = "run"
  cmd    = "hexa run verify/report_economics_ladder.hexa"
  sent   = "__HEXA_CODEX_REPORT_ECONOMICS_LADDER__ PASS"
