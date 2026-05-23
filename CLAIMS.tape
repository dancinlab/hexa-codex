@V := "tape" :: spec [active]
  version = "1.2"

@I := "claims-index" :: identity [active]
  brief = "Single audit index of verifiable hexa-codex claims (cx_claim_manifest)."
  flow  = "claim → hexa verify (g5) → .verdicts/<slug>.tape → /paper gate"

# ECONOMICS group — n=6 ladder claims (slug = economics-n6-ladder)
#
# Method legend (cx_claim_verify · cx_empirical_contact):
#   atom      — `hexa verify --expr <fn> <n> <v>` (atlas atom recompute → BLUE)
#   expr      — `hexa verify --expr <fn> <a> <b> <v>` (2-operand atom recompute → BLUE)
#   empirical — real lm_foundry train · hexa-eval infer · serving bench (T4 → BLUE on exact match)
#
# Gate (cx_paper_gate): 100% BLUE required. No fence/numeric/deferred residual.

# ── atlas atoms (4 — BLUE on first run) ────────────────────────────────

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

# ── T4 empirical contact (3 — DEFERRED until lm_foundry/hexa-eval run) ─

@C ec_t4_quality := "quality_scale T4 — train Qwen2.5-Coder-7B at fixed (N,D), measured loss matches E + A*N^-(1/6) + B*D^-(1/6) within 1e-2 rel" :: empirical [slug=economics-n6-ladder]
  method = "empirical"
  cmd    = "lm_foundry train + hexa-eval loss-vs-(N,D) sweep, persist metrics to .verdicts/economics-n6-ladder/ec_t4_quality.txt"
  status = "DEFERRED — requires GPU pod"

@C ec_t4_train := "train_cost T4 — measured FLOPs(N,D) for Qwen2.5-Coder-7B SFT matches (N*D/1e22)^N6_EXP scaling within 1e-2 rel" :: empirical [slug=economics-n6-ladder]
  method = "empirical"
  cmd    = "lm_foundry SFT runs at varying (N,D), capture FLOPs, persist to .verdicts/economics-n6-ladder/ec_t4_train.txt"
  status = "DEFERRED — requires GPU pod"

@C ec_t4_infer := "infer_cost T4 — measured prefill latency vs ctx for Qwen2.5-Coder-7B matches (ctx/8192)^4 within 1e-1 rel" :: empirical [slug=economics-n6-ladder]
  method = "empirical"
  cmd    = "hexa-eval infer latency-vs-ctx sweep (1k..128k), capture, persist to .verdicts/economics-n6-ladder/ec_t4_infer.txt"
  status = "DEFERRED — requires GPU pod"

@C ec_t4_serve := "serve T4 — measured serving throughput vs ctx for v0.5.x stack matches infer-cost-derived prediction within 1e-1 rel" :: empirical [slug=economics-n6-ladder]
  method = "empirical"
  cmd    = "lm_foundry serve bench (vLLM, varying ctx), capture QPS·tok/s, persist to .verdicts/economics-n6-ladder/ec_t4_serve.txt"
  status = "DEFERRED — requires GPU pod"
