@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "economics-n6-ladder"
  source = "hexa kick + hexa --help calc-fn surface"
  date   = "2026-05-23"
  flow   = "discovery → next-cycle CLAIMS.tape candidate → verify → .verdicts"

# Cycle-1 kick: seed = "n=6 lattice atoms ... what other closed-form identities
# at n=6 are atom-recompute candidates beyond these four?"
# Engine output: mk9 · rounds 1 · total 650 · overlay 517 lines (in-memory pool).
#
# Candidate atoms surfaced (cross-referenced against hexa verify --expr calc fn
# surface: sigma|sigma_0|sigma_2|phi|mu|tau|is_perfect|aliquot|gamma0_index|
# gamma0_cusps|gamma0_genus|isotropy_lcm|first_cusp_form_weight + 2-op
# sigma_k|jacobi|kronecker|dim_cusp_forms).

# ── single-arg atoms at n=6 not yet in CLAIMS.tape ──

@C d_sigma_0_6 := "sigma_0(6) = tau(6) = 4 (divisor count alias)" :: candidate [target_tier=BLUE]
  cmd = "hexa verify --expr sigma_0 6 4"

@C d_mu_6 := "mu(6) = mu(2*3) = (-1)*(-1) = 1 (Mobius, 6 is squarefree)" :: candidate [target_tier=BLUE]
  cmd = "hexa verify --expr mu 6 1"

@C d_is_perfect_6 := "is_perfect(6) = true (sigma(6) - 6 = 6)" :: candidate [target_tier=BLUE]
  cmd = "hexa verify --expr is_perfect 6 1"

@C d_aliquot_6 := "aliquot(6) = sigma(6) - 6 = 6 (perfect-number signature)" :: candidate [target_tier=BLUE]
  cmd = "hexa verify --expr aliquot 6 6"

@C d_gamma0_index_6 := "gamma0_index(6) = 12 (modular-form index)" :: candidate [target_tier=BLUE]
  cmd = "hexa verify --expr gamma0_index 6 12"

@C d_gamma0_cusps_6 := "gamma0_cusps(6) = 4 (modular-form cusp count)" :: candidate [target_tier=BLUE]
  cmd = "hexa verify --expr gamma0_cusps 6 4"

@C d_gamma0_genus_6 := "gamma0_genus(6) = 0 (modular-form genus)" :: candidate [target_tier=BLUE]
  cmd = "hexa verify --expr gamma0_genus 6 0"

# ── 2-op closed-form identities at n=6 (sigma_k family) ──

@C d_sigma_3_6 := "sigma_3(6) = 1+8+27+216 = 252" :: candidate [target_tier=BLUE actual_tier=BLUE]
  cmd = "hexa verify --expr sigma_k 6 3 252"
  raw = ".discoveries/economics-n6-ladder/d_sigma_3_6.txt"
  note = "CLI sig: sigma_k <n> <k> — args in n-first order (cycle-1 caught the swap)"

@C d_sigma_4_6 := "sigma_4(6) = 1+16+81+1296 = 1394" :: candidate [target_tier=BLUE actual_tier=BLUE]
  cmd = "hexa verify --expr sigma_k 6 4 1394"
  raw = ".discoveries/economics-n6-ladder/d_sigma_4_6.txt"

# ── cycle-1 summary ──
# total      : 9 candidates
# blue       : 9 (all SUPPORTED-FORMAL after sigma_k arg-order fix)
# falsified  : 0 (2 cycle-1 RED were arg-order typos, math identities correct)
# next_cycle : promote 9 atoms to CLAIMS.tape under a new slug e.g. n6-lattice-extended
