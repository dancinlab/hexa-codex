@V := "tape" :: spec [active]
  version = "1.2"

@I := "verdict-matrix" :: identity [active]
  slug   = "economics-n6-ladder"
  source = "CLAIMS.tape (cx_claim_manifest)"
  date   = "2026-05-23"
  raw    = ".verdicts/economics-n6-ladder/<id>.txt (one file per claim, stdout verbatim)"

# ── atom verdicts (method=atom · hexa verify --expr) — 4 BLUE ──

@V ec_sigma_6 := "sigma(6) = 12" :: verdict [tier=BLUE]
  raw = ".verdicts/economics-n6-ladder/ec_sigma_6.txt"

@V ec_phi_6 := "phi(6) = 2" :: verdict [tier=BLUE]
  raw = ".verdicts/economics-n6-ladder/ec_phi_6.txt"

@V ec_tau_6 := "tau(6) = 4" :: verdict [tier=BLUE]
  raw = ".verdicts/economics-n6-ladder/ec_tau_6.txt"

@V ec_sigma2_6 := "sigma_2(6) = 50" :: verdict [tier=BLUE]
  raw = ".verdicts/economics-n6-ladder/ec_sigma2_6.txt"

# ── fence verdicts (method=fence · hexa verify --fence) — 3 FENCED ──

@V ec_quality_alpha := "quality_scale alpha = phi(6)/sigma(6) = 1/6 (modeling)" :: verdict [tier=FENCED]
  raw = ".verdicts/economics-n6-ladder/ec_quality_alpha.txt"

@V ec_train_n6exp := "train_cost N6_EXP = J2/(J2+1) = 24/25 (modeling)" :: verdict [tier=FENCED]
  raw = ".verdicts/economics-n6-ladder/ec_train_n6exp.txt"

@V ec_pareto_optimum := "Pareto optimum D/N ~1.07 (n=6) vs ~20 (Chinchilla) (modeling)" :: verdict [tier=FENCED]
  raw = ".verdicts/economics-n6-ladder/ec_pareto_optimum.txt"

# ── run verdicts (method=run · hexa run verify/<file>.hexa) — 4 PASS ──

@V ec_cross_pillar := "numerics_economics_cross_pillar 10/10" :: verdict [tier=PASS]
  raw = ".verdicts/economics-n6-ladder/ec_cross_pillar.txt"

@V ec_scaling_laws := "numerics_economics_scaling_laws 10/10" :: verdict [tier=PASS]
  raw = ".verdicts/economics-n6-ladder/ec_scaling_laws.txt"

@V ec_pareto_envelope := "numerics_economics_pareto 10/10" :: verdict [tier=PASS]
  raw = ".verdicts/economics-n6-ladder/ec_pareto_envelope.txt"

@V ec_ladder_report := "report_economics_ladder 10/10" :: verdict [tier=PASS]
  raw = ".verdicts/economics-n6-ladder/ec_ladder_report.txt"

# ── gate (cx_paper_gate) ──

@V gate := "/paper new economics-n6-ladder — ALLOWED" :: gate [tier=PASS]
  red_count       = "0"
  blue_count      = "4"
  pass_count      = "4"
  fenced_count    = "3"
  fenced_explicit = "true"
  decision        = "ALLOWED — 0 RED + 8 (BLUE+PASS) >= 1 + all 3 FENCED explicit via --fence"
