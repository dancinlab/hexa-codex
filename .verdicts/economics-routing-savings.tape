@V := "tape" :: spec [active]
  version = "1.2"

@I := "verdict-matrix" :: identity [active]
  slug   = "economics-routing-savings"
  source = "CLAIMS.tape (cx_claim_manifest)"
  date   = "2026-05-23"
  raw    = ".verdicts/economics-routing-savings/<id>.{txt,tsv}"
  gate   = "ALLOWED — 5/5 verified (1 formula sum-identity + 2 measured benches + 2 derived metrics)"

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

# ── gate (cx_paper_gate — 100% formal-blue OR numerical-green AND significance) ──

@V gate := "/paper new economics-routing-savings — ALLOWED" :: gate [tier=ALLOWED]
  formal_blue        = "0"
  numerical_green    = "5"
  blocked_tier_count = "0"
  significance       = "PASS — §formula (cost sum) + §benchmark (real claude CLI) + §benefit (72.69% cost reduction, 0 accuracy loss)"
  decision           = "ALLOWED — 5/5 SUPPORTED-* (all numerical-green), significance gate passed"
