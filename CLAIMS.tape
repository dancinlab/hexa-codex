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
# econ-fcodex2-latency-fit — F-CODEX-2 empirical landing (T4 contact)
# (slug = econ-fcodex2-latency-fit · M3.ECON / M5.ECON v1.3.0 gate)
#
# The modeling-level claim binding tau(6)=4 to the substrate's measured
# inference latency curve — the "separate slug with T4 empirical contact"
# the economics-n6-ladder header reserves. FALSIFIED: the substrate's own
# measured context-latency curve has exponent tau_hat~=0.52, not 4.

@C fc2_context_curve := "context-scaling bench: mean_wall_ms = 569/670/1005/1668 ms at ctx {1k,2k,4k,8k}, acc 17/20 flat" :: empirical [slug=econ-fcodex2-latency-fit]
  method = "run"
  cmd    = "hexa run bench/sandbox_stage4_context_scaling.hexa (Qwen2.5-1.5B, -np 1 -cb, $0 local)"
  raw    = ".verdicts/sandbox/stage4_context_scaling.tsv"

@C fc2_residual := "F-CODEX-2 inference_cost ∝ context^4 FALSIFIED: measured log-log OLS tau_hat=0.524 vs lattice tau=4, residual 3.476 >> eps=0.10" :: empirical [slug=econ-fcodex2-latency-fit]
  method = "run"
  cmd    = "hexa run verify/numerics_economics_empirical_landing.hexa (LATENCY_MS live; check 9/10 -> FALSIFIED, exit 1)"
  raw    = ".verdicts/sandbox/m3_econ_fcodex2_latency_fit.txt"

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

# ───────────────────────────────────────────────────────────────────────
# safety-refusal-direction — mechanistic refusal direction (route b)
# (slug = safety-refusal-direction · paper-track · SAFETY canonical)
#
# Method legend (cx_claim_verify):
#   run       — real HF transformers fp32 forward-pass capture (cx_empirical_contact)
#   recompute — hexa-native deterministic recompute from the committed
#               NUMBERS-ONLY activation-norm matrix (.hexa IS the verify; raw
#               stdout is the verdict — `hexa verify --expr` only accepts
#               single-output registered fns, so the multi-metric linear
#               refusal-direction classifier is recomputed directly)
# Adversarial-set note: harmful prompts default PRIVATE (cx_hf_safety_private) —
#   the committed surface m2_safety_refusal_norms.tsv carries NUMBERS ONLY
#   (84 activation norms + binary labels), prompt TEXT redacted.

@C sr_norms_matrix := "committed recompute surface: 40-row x 84-feature last-prompt-token activation-norm matrix + binary refusal labels (Qwen2.5-1.5B fp32), adversarial prompt text REDACTED per cx_hf_safety_private" :: empirical [slug=safety-refusal-direction]
  method = "run"
  cmd    = "deterministic fp32 forward-pass re-run of route(b) probe on ubu-1 (RTX 5070); reproduced committed label dist + AUROC=0.98 bit-for-bit"
  raw    = ".verdicts/sandbox/m2_safety_refusal_norms.tsv"

@C sr_formula := "linear refusal-direction classifier score(a) = (w . z(a)) > theta, w = mean(z_refused) - mean(z_answered) — recomputed from committed matrix" :: formula [slug=safety-refusal-direction]
  method = "recompute"
  cmd    = "hexa run verify/numerics_safety_refusal_direction.hexa (5/5 checks)"
  raw    = ".verdicts/sandbox/m4_safety_refusal_direction_recompute.txt"

@C sr_auroc := "full-vector difference-of-means projection AUROC = 0.98 (recomputed, drift 0.0 vs committed)" :: derived [slug=safety-refusal-direction]
  method = "recompute"
  cmd    = "hexa run verify/numerics_safety_refusal_direction.hexa (rank AUROC, refused=positive)"
  raw    = ".verdicts/sandbox/m4_safety_refusal_direction_recompute.txt"

@C sr_loo := "leave-one-out held-out linear acc = 0.825 (33/40) vs majority 0.50 — recomputed, drift 0.0" :: derived [slug=safety-refusal-direction]
  method = "recompute"
  cmd    = "hexa run verify/numerics_safety_refusal_direction.hexa (refit w on n-1, threshold at train class-mean midpoint)"
  raw    = ".verdicts/sandbox/m4_safety_refusal_direction_recompute.txt"

@C sr_permutation := "permutation test p = 0.00498 (0/200 fixed-seed label shuffles reach observed LOO) — reproduces committed p~=0.005 under independent PRNG" :: derived [slug=safety-refusal-direction]
  method = "recompute"
  cmd    = "hexa run verify/numerics_safety_refusal_direction.hexa (200-shuffle LCG Fisher-Yates; same design as the probe's Mersenne-Twister)"
  raw    = ".verdicts/sandbox/m4_safety_refusal_direction_recompute.txt"

@C sr_topic_confound := "direction tracks the refusal DECISION not adv-vs-benign topic: lone ADV-but-ANSWERED row14 projects to answered-side (proj=-25.81, matches probe)" :: derived [slug=safety-refusal-direction]
  method = "recompute"
  cmd    = "hexa run verify/numerics_safety_refusal_direction.hexa (full-data threshold control)"
  raw    = ".verdicts/sandbox/m4_safety_refusal_direction_recompute.txt"

@C sr_route_a_negative := "route(a) NEGATIVE contrast: first-token top1-top2 logprob margin gap 0.40 = 5.9x BELOW the bimodality bar, safety_signal_present=false — the activation-norm surface succeeds where the logit margin fails" :: empirical [slug=safety-refusal-direction]
  method = "run"
  cmd    = "hexa run bench/sandbox_stage4_refusal_bimodal_tighter.hexa (Qwen2.5-1.5B, $0 local)"
  raw    = ".verdicts/sandbox/m2_safety_bimodality_tighter.txt"

# ───────────────────────────────────────────────────────────────────────
# rwkv-linear-attention-laws — RWKV-7 vs Transformer context-scaling laws
# (slug = rwkv-linear-attention-laws · paper-track · SUBSTRATE canonical)
#
# Method legend (cx_claim_verify):
#   run       — real llama-bench / llama-completion ctx-sweep (cx_empirical_contact,
#               $0 local, mac-mini-m3 stock llama.cpp 9150 Metal/UMA)
#   recompute — hexa-native deterministic least-squares + log-log power-law fit
#               over the committed (ctx, metric) sweep (.hexa IS the verify;
#               raw stdout is the verdict — `hexa verify --expr` only accepts
#               single-output registered fns, so the 8-law fit is recomputed
#               directly; 8/8 PASS)

@C rwkv_sweep := "RWKV-7 2.9B vs Qwen2.5-0.5B-Q4 ctx sweep 512→65536 (128×): mem buffer MiB + prefill ms + decode tok/s, 27-row warm/steady-state grid, $0 local" :: empirical [slug=rwkv-linear-attention-laws]
  method = "run"
  cmd    = "hexa run bench/rwkv_m2m3_ctx_sweep.hexa (llama-bench latency + llama-completion memory log)"
  raw    = ".verdicts/rwkv/m2m3_ctx_sweep.tsv"

@C rwkv_formula := "4 closed-form context-scaling laws: RWKV state FLAT 20.62 MiB (slope 0) + Qwen KV=n·12 KiB/tok (R²=1) ; RWKV prefill p=0.962≈1 + Qwen prefill p=1.366>1 ; RWKV decode O(1) + Qwen decode O(n) — 8/8 recompute, both falsifiers NOT triggered" :: formula [slug=rwkv-linear-attention-laws]
  method = "recompute"
  cmd    = "hexa run verify/numerics_rwkv_m2m3_laws.hexa (8/8 laws PASS)"
  raw    = ".verdicts/rwkv/m2_constant_memory.txt"

@C rwkv_method := "ctx-sweep protocol: llama-bench (-p N -n 0 prefill ; -n 64 -p 0 -d D decode) + context-construction memory log ; pre-registered L1–L8 fits/tolerances ; engine quirk (llama-completion slow rwkv7 prefill → llama-bench)" :: derived [slug=rwkv-linear-attention-laws]
  method = "recompute"
  cmd    = "hexa run verify/numerics_rwkv_m2m3_laws.hexa (pre-registered thresholds, math_pure recompute over committed grid)"
  raw    = ".verdicts/rwkv/m3_linear_time.txt"

@C rwkv_benefit := "quantified deltas: memory crossover ctx≈1760, 4.66× less cache memory @8192 (diverges linearly) + decode O(1) vs O(n) 3.55× slower @8192 + linear vs superlinear prefill (Δp=0.40). HONEST NEGATIVE: RWKV absolute prefill SLOWER here (59760 vs 14174 ms @8192) — win is exponent+decode+memory, not prefill constant" :: derived [slug=rwkv-linear-attention-laws]
  method = "recompute"
  cmd    = "hexa run verify/numerics_rwkv_m2m3_laws.hexa (crossover + Δ-deltas from L1/L2/L6/L7)"
  raw    = ".verdicts/rwkv/m3_linear_time.txt"
