@V := "tape" :: spec [active]
  version = "1.2"

@I := "verdict-matrix" :: identity [active]
  slug   = "economics-n6-ladder"
  source = "CLAIMS.tape (cx_claim_manifest)"
  date   = "2026-05-23"
  raw    = ".verdicts/economics-n6-ladder/<id>.txt (one file per claim, stdout verbatim)"
  gate   = "ALLOWED — 4/4 BLUE (atlas atom recompute)"

# ── atom verdicts (method=atom · hexa verify --expr) — 4 BLUE ──

@V ec_sigma_6 := "sigma(6) = 12" :: verdict [tier=BLUE]
  raw = ".verdicts/economics-n6-ladder/ec_sigma_6.txt"

@V ec_phi_6 := "phi(6) = 2" :: verdict [tier=BLUE]
  raw = ".verdicts/economics-n6-ladder/ec_phi_6.txt"

@V ec_tau_6 := "tau(6) = 4" :: verdict [tier=BLUE]
  raw = ".verdicts/economics-n6-ladder/ec_tau_6.txt"

@V ec_sigma2_6 := "sigma_2(6) = 50" :: verdict [tier=BLUE]
  raw = ".verdicts/economics-n6-ladder/ec_sigma2_6.txt"

# ── gate (cx_paper_gate — strict 100% BLUE) ──

@V gate := "/paper new economics-n6-ladder — ALLOWED" :: gate [tier=ALLOWED]
  blue_count       = "4"
  non_blue_count   = "0"
  blue_pct         = "100"
  threshold        = "100% BLUE required (cx_paper_gate)"
  decision         = "ALLOWED — 4/4 BLUE, no residual"
