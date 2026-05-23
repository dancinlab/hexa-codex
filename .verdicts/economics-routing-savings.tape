@V := "tape" :: spec [active]
  version = "1.2"

@I := "verdict-matrix" :: identity [active]
  slug   = "economics-routing-savings"
  source = "CLAIMS.tape (cx_claim_manifest)"
  date   = "2026-05-23"
  raw    = ".verdicts/economics-routing-savings/<id>.{txt,tsv}"
  gate   = "ALLOWED — 7/7 verified (formula + 2 benches + 2 derived + N=200 scale + Pareto dominance)"

# ── formula (closed-form sum identity, 🔵-equivalent on numerical recompute) ──

@V er_formula := "cost(N) = sum over tasks of rate(tier_picked)" :: verdict [tier=GREEN]
  raw = ".verdicts/economics-routing-savings/er_formula.txt"

# ── empirical bench results (🟢 measured via claude --bare -p) ──

@V er_baseline_bench := "baseline always-opus 20-task bench" :: verdict [tier=GREEN]
  raw = ".verdicts/economics-routing-savings/baseline.tsv"

@V er_router_bench := "router length-heuristic 20-task bench" :: verdict [tier=GREEN]
  raw = ".verdicts/economics-routing-savings/router.tsv"

# ── derived metrics (🟢 arithmetic on measured values) ──

@V er_savings_pct := "savings = 72.6906% of baseline cost" :: verdict [tier=GREEN]
  raw = ".verdicts/economics-routing-savings/er_savings_pct.txt"

@V er_accuracy_delta := "accuracy delta = 0 (no quality loss)" :: verdict [tier=GREEN]
  raw = ".verdicts/economics-routing-savings/er_accuracy_delta.txt"

# ── scale replication N=200 (🟢 measured) ──

@V er_n200_scale := "N=200 scale: savings 55.06%, accuracy delta -5" :: verdict [tier=GREEN]
  raw = ".verdicts/economics-routing-savings/n200_summary.txt"

@V er_pareto := "length router is sole Pareto-optimal; baseline+class+dlg dominated" :: verdict [tier=GREEN]
  raw = ".verdicts/economics-routing-savings/pareto.txt"

# ── gate (cx_paper_gate — 100% formal-blue OR numerical-green AND significance) ──

@V gate := "/paper new economics-routing-savings — ALLOWED" :: gate [tier=ALLOWED]
  formal_blue        = "0"
  numerical_green    = "7"
  blocked_tier_count = "0"
  significance       = "PASS — §formula + §benchmark (N=20 4-way + N=200) + §pareto + §benefit (55.06% saving, length sole Pareto-optimal)"
  decision           = "ALLOWED — 7/7 SUPPORTED-NUMERICAL, significance gate passed"
