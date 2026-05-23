@V := "tape" :: spec [active]
  version = "1.2"

@I := "verdict-matrix" :: identity [active]
  slug   = "economics-n6-ladder"
  source = "CLAIMS.tape (cx_claim_manifest)"
  date   = "2026-05-23"
  gate   = "PASS — 0 RED · 4 BLUE · 4 PASS · 3 FENCED (all ⚪ explicit, see method=fence in CLAIMS.tape)"

# ─────────────────────────────────────────────────────────────────────────
# atom verdicts (method=atom · hexa verify --expr) — 4 BLUE
# ─────────────────────────────────────────────────────────────────────────

@V ec_sigma_6 := "sigma(6) = 12" :: verdict [tier=BLUE]
  stdout = """
verify --expr sigma(6)=12
  calc   = 12  == expected 12
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form, g_self_verify · TECS-L Tier1)
"""

@V ec_phi_6 := "phi(6) = 2" :: verdict [tier=BLUE]
  stdout = """
verify --expr phi(6)=2
  calc   = 2  == expected 2
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form, g_self_verify · TECS-L Tier1)
"""

@V ec_tau_6 := "tau(6) = 4" :: verdict [tier=BLUE]
  stdout = """
verify --expr tau(6)=4
  calc   = 4  == expected 4
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form, g_self_verify · TECS-L Tier1)
"""

@V ec_sigma2_6 := "sigma_2(6) = 50" :: verdict [tier=BLUE]
  stdout = """
verify --expr sigma_2(6)=50
  calc   = 50  == expected 50
  tier   = 🔵 SUPPORTED-FORMAL  (hexa-native closed-form, g_self_verify · TECS-L Tier1)
"""

# ─────────────────────────────────────────────────────────────────────────
# fence verdicts (method=fence · hexa verify --fence) — 3 FENCED
# ─────────────────────────────────────────────────────────────────────────

@V ec_quality_alpha := "quality_scale alpha = phi(6)/sigma(6) = 1/6 (modeling)" :: verdict [tier=FENCED]
  stdout = """
verify --fence
  claim  = quality_scale loss-fit exponent alpha = phi(6)/sigma(6) = 1/6 (n=6 modeling claim)
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
"""

@V ec_train_n6exp := "train_cost N6_EXP = J2/(J2+1) = 24/25 (modeling)" :: verdict [tier=FENCED]
  stdout = """
verify --fence
  claim  = train_cost exponent N6_EXP = J2/(J2+1) = 24/25 (n=6 modeling claim, J2 = sigma*phi = 24)
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
"""

@V ec_pareto_optimum := "Pareto optimum D/N ~1.07 (n=6) vs ~20 (Chinchilla) (modeling)" :: verdict [tier=FENCED]
  stdout = """
verify --fence
  claim  = ECONOMICS Pareto optimum D/N approx 1.07 at n=6 alpha=1/6, distinct from Chinchilla published ~20 (modeling)
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
"""

# ─────────────────────────────────────────────────────────────────────────
# run verdicts (method=run · hexa run verify/<file>.hexa) — 4 PASS
# ─────────────────────────────────────────────────────────────────────────

@V ec_cross_pillar := "numerics_economics_cross_pillar 10/10" :: verdict [tier=PASS]
  stdout = """
========================================================================
  10/10 checks passed
  ECONOMICS 3-pillar T2 cross-cutter: closed.
__HEXA_CODEX_NUMERICS_ECONOMICS_CROSS_PILLAR__ PASS
"""

@V ec_scaling_laws := "numerics_economics_scaling_laws 10/10" :: verdict [tier=PASS]
  stdout = """
========================================================================
  10/10 checks passed
  ECONOMICS scaling-law sweep: closed.
__HEXA_CODEX_NUMERICS_ECONOMICS_SCALING_LAWS__ PASS
"""

@V ec_pareto_envelope := "numerics_economics_pareto 10/10" :: verdict [tier=PASS]
  stdout = """
========================================================================
  10/10 checks passed
  ECONOMICS Pareto envelope: closed.
__HEXA_CODEX_NUMERICS_ECONOMICS_PARETO__ PASS
"""

@V ec_ladder_report := "report_economics_ladder 10/10" :: verdict [tier=PASS]
  stdout = """
========================================================================
  10/10 checks passed
  ECONOMICS recipe §3 ladder: closed (every verb T1+T2+T3 ✓ + X-ECON 3/3 + T4-stub 3/3).
__HEXA_CODEX_REPORT_ECONOMICS_LADDER__ PASS
"""

# ─────────────────────────────────────────────────────────────────────────
# gate verdict (cx_paper_gate)
# ─────────────────────────────────────────────────────────────────────────

@G gate := "/paper new economics-n6-ladder — ALLOWED" :: gate [active]
  red_count       = 0
  blue_count      = 4
  pass_count      = 4
  fenced_count    = 3
  fenced_explicit = true
  decision        = "ALLOWED — 0🔴 + 8 (🔵+PASS) ≥ 1 + all 3 ⚪ explicit via --fence"
