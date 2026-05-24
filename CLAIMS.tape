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

# ───────────────────────────────────────────────────────────────────────
# economics-routing-savings — Claude Code CLI tier-routing cost benchmark
# (slug = economics-routing-savings · paper-track)

@C er_formula := "cost(N) = sum over tasks of rate(tier_picked) · 1 — closed-form sum identity" :: formula [slug=economics-routing-savings]
  method = "definition"
  raw    = ".verdicts/economics-routing-savings/er_formula.txt"

@C er_baseline_bench := "baseline (always-opus) 20-task bench — cost=$0.299947, ms=50270, correct=19/20" :: empirical [slug=economics-routing-savings]
  method = "claude_cli"
  cmd    = "hexa run bench/economics_routing.hexa (baseline strategy)"
  raw    = ".verdicts/economics-routing-savings/baseline.tsv"

@C er_router_bench := "router (length-heuristic) 20-task bench — cost=$0.081914, ms=54285, correct=19/20" :: empirical [slug=economics-routing-savings]
  method = "claude_cli"
  cmd    = "hexa run bench/economics_routing.hexa (router strategy)"
  raw    = ".verdicts/economics-routing-savings/router.tsv"

@C er_savings_pct := "savings = (baseline - router) / baseline = 72.69% cost reduction" :: derived [slug=economics-routing-savings]
  method = "arithmetic"
  cmd    = "(0.299947 - 0.081914) / 0.299947 * 100 = 72.6906%"
  raw    = ".verdicts/economics-routing-savings/er_savings_pct.txt"

@C er_accuracy_delta := "accuracy delta = router correct - baseline correct = 0 (no quality loss)" :: derived [slug=economics-routing-savings]
  method = "arithmetic"
  cmd    = "19 - 19 = 0"
  raw    = ".verdicts/economics-routing-savings/er_accuracy_delta.txt"

@C er_n200_scale := "N=200 scale: baseline $3.2950 (190/200) vs router $1.4808 (185/200) — savings 55.06%, accuracy -5" :: empirical [slug=economics-routing-savings]
  method = "claude_cli"
  cmd    = "hexa run bench/economics_routing_n200.hexa"
  raw    = ".verdicts/economics-routing-savings/n200_summary.txt"

@C er_dlg_4way := "4-way N=20: length 73.56% > class 71.28% > dlg 64.44% saving, all 20/20" :: empirical [slug=economics-routing-savings]
  method = "claude_cli"
  cmd    = "hexa run bench/economics_routing_dlg.hexa"
  raw    = ".verdicts/economics-routing-savings/dlg_summary.txt"

@C er_pareto := "length router is the SOLE Pareto-optimal point — baseline+class+dlg all dominated" :: derived [slug=economics-routing-savings]
  method = "arithmetic"
  cmd    = "dominance on (cost_usd, correct) across 4 strategies"
  raw    = ".verdicts/economics-routing-savings/pareto.txt"

# ───────────────────────────────────────────────────────────────────────
# ops-slo-mmc-surface — M/M/c (Erlang-C) SLO surface for self-hosted serving
# (slug = ops-slo-mmc-surface · paper-track · OPS canonical)
#
# Method legend (cx_claim_verify):
#   run     — real llama-server SLO bench (cx_empirical_contact)
#   recompute — hexa-native closed-form recompute (.hexa IS the verify; raw
#               stdout is the verdict — `hexa verify --expr` only accepts
#               single-output registered fns, so the multi-invariant M/M/c law
#               is recomputed directly)

@C op_slo_grid := "M3.OPS 18-cell SLO grid (3 np × 6 rate, Stage-2 N=2000): 12 VALID + 6 WALL_CAPPED, 0 boot-fail, 0 hang; ceilings 9.53/15.01/20.0 qps for np=1/2/4" :: empirical [slug=ops-slo-mmc-surface]
  method = "run"
  cmd    = "hexa run bench/sandbox_stage4_slo_full_grid.hexa (Qwen2.5-0.5B, port 8090)"
  raw    = ".verdicts/sandbox/m3_ops_full_slo_grid_summary.txt"

@C op_mmc_formula := "M/M/c (Erlang-C) law reproduces the SLO surface's scale-invariant structure: ceiling λ_max=c·μ, knee shifts RIGHT with c, stability cap λ<c·μ, Erlang-C sojourn pole at ρ→1 — 5/5 checks (absolute knee NOT claimed)" :: formula [slug=ops-slo-mmc-surface]
  method = "recompute"
  cmd    = "hexa run verify/numerics_ops_mmc_knee.hexa"
  raw    = ".verdicts/sandbox/m4_ops_formula_fit.txt"

@C op_accuracy_cliff := "a saturation SLO violation surfaces as an ACCURACY cliff via two mechanisms — client-timeout truncation (np=1, p99→timeout) + scheduler slot-preemption (np≥2: acc 94→53.82→29.03% at error_rate 0%)" :: derived [slug=ops-slo-mmc-surface]
  method = "run"
  cmd    = "hexa run bench/sandbox_stage4_slo_full_grid.hexa (n_correct vs n_completed across rate sweep)"
  raw    = ".verdicts/sandbox/m3_ops_full_slo_grid_summary.txt"
