@V := "tape" :: spec [active]
  version = "1.2"

@I := "verdict-matrix" :: identity [active]
  slug   = "economics-n6-ladder"
  source = "CLAIMS.tape (cx_claim_manifest)"
  date   = "2026-05-23"
  raw    = ".verdicts/economics-n6-ladder/<id>.txt (one file per claim, stdout verbatim)"
  gate   = "BLOCKED — 4 T4 empirical claims DEFERRED until GPU pod dispatch"

# ── atom verdicts (method=atom · hexa verify --expr) — 4 BLUE ──

@V ec_sigma_6 := "sigma(6) = 12" :: verdict [tier=BLUE]
  raw = ".verdicts/economics-n6-ladder/ec_sigma_6.txt"

@V ec_phi_6 := "phi(6) = 2" :: verdict [tier=BLUE]
  raw = ".verdicts/economics-n6-ladder/ec_phi_6.txt"

@V ec_tau_6 := "tau(6) = 4" :: verdict [tier=BLUE]
  raw = ".verdicts/economics-n6-ladder/ec_tau_6.txt"

@V ec_sigma2_6 := "sigma_2(6) = 50" :: verdict [tier=BLUE]
  raw = ".verdicts/economics-n6-ladder/ec_sigma2_6.txt"

# ── T4 empirical verdicts (method=empirical · DEFERRED) — 4 DEFERRED ──

@V ec_t4_quality := "quality_scale T4 loss-vs-(N,D) sweep" :: verdict [tier=DEFERRED]
  raw = ".verdicts/economics-n6-ladder/ec_t4_quality.txt"

@V ec_t4_train := "train_cost T4 FLOPs sweep" :: verdict [tier=DEFERRED]
  raw = ".verdicts/economics-n6-ladder/ec_t4_train.txt"

@V ec_t4_infer := "infer_cost T4 latency-vs-ctx sweep" :: verdict [tier=DEFERRED]
  raw = ".verdicts/economics-n6-ladder/ec_t4_infer.txt"

@V ec_t4_serve := "serve T4 throughput-vs-ctx bench" :: verdict [tier=DEFERRED]
  raw = ".verdicts/economics-n6-ladder/ec_t4_serve.txt"

# ── gate (cx_paper_gate — strict 100% BLUE) ──

@V gate := "/paper new economics-n6-ladder — BLOCKED" :: gate [tier=BLOCKED]
  blue_count       = "4"
  deferred_count   = "4"
  non_blue_count   = "4"
  blue_pct         = "50"
  threshold        = "100% BLUE required (cx_paper_gate)"
  decision         = "BLOCKED — 4 T4 empirical claims DEFERRED; execute GPU pod sweep to unblock"
  next_step        = "lm_foundry train sweep + hexa-eval latency sweep + serving bench (cx_empirical_contact)"
