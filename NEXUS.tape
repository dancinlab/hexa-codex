#!/usr/bin/env tape
# NEXUS.tape — hexa-codex intra-project reuse lattice (SSOT)
# Canonical structured SSOT of the cross-group reuse graph.
# Governance: commons @D g67 (universal commons reuse-lattice).
# Substrate: discovery = hexa-lang atlas (verified atoms) · primitive home = hexa-lang stdlib (@D d3).
# Scope: intra-project ONLY — never link domains across repos (@D g67).
#
# Block legend:
#   @I nexus                  — identity (kind · scope)
#   @X e<n> :: reuse-edge        — a VERIFIED reuse edge (one provides -> one reused_by)
#   @X p<n> :: provides          — a group's provides[] registry (primitives it offers)
#   @X c<n> :: reuse-candidate   — a conceptual edge, no code reuse yet (proposed)
#   @N n<n> :: note              — usage protocol / human ASCII graph view + scope honesty
# Block type is @X (External-citation / declarative, one of the closed 17-type
# alphabet @S@U@A@T@R@H@D@K@P@?@I@X@F@N@C@L@V). Body keys are free-form (the
# @D-only do/dont field restriction does NOT apply to @X). Values kept ASCII-safe
# for portability (circled digits -> (n), arrows -> -> / <->). Lints clean v1.2.

@V := "tape" :: spec [active]
  version = "1.2"

@I nexus := "hexa-codex intra-project reuse lattice" :: identity [active]
  kind    = "cross-group reuse graph — verified primitives + substrate shared between the 4 codex groups (SAFETY · ECONOMICS · OPS · SUBSTRATE)"
  scope   = "intra-project ONLY — links the 4 groups WITHIN hexa-codex; cross-repo deps (e.g. hexa-lang self/runtime/math_pure stdlib) are EXCLUDED per @D g67 (see @N n3)"
  ssot    = "this file (NEXUS.tape) · README.md carries a pointer to it"
  governs = "commons @D g67 (universal reuse-lattice)"

# ── 1. VERIFIED reuse edges (provides -> reused_by, with evidence) ──

@X e1 := "n6-lattice atoms -> all 4 groups (cross-pillar binding)" :: reuse-edge [tier-2 active]
  provides  = "n6-lattice (.roadmap.hexa_codex A.1 + hexa.toml [invariants.n6])"
  primitive = "sigma(6)=12 · phi(6)=2 · tau(6)=4 · J2 = sigma*phi = n*tau = 24 · N6_EXP = 24/25 = 0.96"
  reused_by = "ECONOMICS (F-CODEX-1 train_cost N6_EXP · F-CODEX-2 infer_cost^tau) · SAFETY (F-CODEX-3 alignment 1/sigma avg) · SUBSTRATE/interpret (F-CODEX-4 motif sigma-phi=10)"
  evidence  = "verify/numerics_cross_pillar.hexa (10/10 cross-pillar identities PASS) · CLAIMS.tape ec_sigma_6/ec_phi_6/ec_tau_6/ec_sigma2_6 atoms"

@X e2 := "lattice-closure audit -> all 4 F-CODEX falsifiers (T1 algebraic floor)" :: reuse-edge [tier-2 active]
  provides  = "verify/lattice_check.hexa (n6 closure audit)"
  primitive = "closure identity sigma*phi = n*tau = J2 = 24 as the T1 algebraic floor"
  reused_by = "F-CODEX-1..4 falsifier preregister (each pillar must clear closure before any empirical fit)"
  evidence  = "verify/lattice_check.hexa header (Falsifier coverage: T1 floor for F-CODEX-1..4) · verify/falsifier_check.hexa"

@X e3 := "SANDBOX self-hosted substrate -> SAFETY · OPS · SUBSTRATE benches" :: reuse-edge [tier-2 active]
  provides  = "SANDBOX (self-hosted llama-server substrate · @D cx_lab_sandbox)"
  primitive = "stock llama-server /v1/chat/completions + logprobs surface (Qwen2.5 GGUF, $0 local)"
  reused_by = "SAFETY (bench/sandbox_stage4_refusal_matrix.hexa) · OPS (bench/sandbox_stage4_slo_full_grid.hexa) · SUBSTRATE (bench/sandbox_stage4_context_scaling.hexa · rwkv_m2m3_ctx_sweep.hexa)"
  evidence  = "@D cx_lab_sandbox (every LAB routes LLM calls to SANDBOX) · CLAIMS.tape sr_*/op_slo_grid/rwkv_sweep .verdicts"

# ── 2. provides[] registry (per-group offered primitives) ──

@X p1 := "SAFETY provides" :: provides [active]
  domain     = "SAFETY"
  primitives = "alignment HELM-12-axis aggregator · refusal-direction linear classifier (route b) · refusal-matrix logprob surface"

@X p2 := "ECONOMICS provides" :: provides [active]
  domain     = "ECONOMICS"
  primitives = "train_cost (F-CODEX-1 N6_EXP) · infer_cost (F-CODEX-2 ctx^tau) · quality_scale · tier-routing length-heuristic router (72.69% saving)"

@X p3 := "OPS provides" :: provides [active]
  domain     = "OPS"
  primitives = "M/M/c (Erlang-C) SLO surface law · 18-cell SLO grid bench · accuracy-cliff mechanism (timeout + slot-preempt)"

@X p4 := "SUBSTRATE provides" :: provides [active]
  domain     = "SUBSTRATE"
  primitives = "RWKV-7 vs Transformer context-scaling laws (8/8) · BitNet 1.58-bit lattice · interpret motif (sigma-phi=10) · SANDBOX llama-server substrate"

@X p5 := "n6-lattice provides" :: provides [active]
  domain     = "n6-lattice"
  primitives = "sigma · phi · tau · sigma_2 · J2 · N6_EXP (atlas atoms · .roadmap.hexa_codex A.1 · hexa.toml [invariants.n6])"

# ── 3. candidate edges (conceptual · no code reuse yet) ──

@X c1 := "ECONOMICS tier-router <-> OPS SLO surface" :: reuse-candidate [proposed draft]
  note = "router tier choice could feed the M/M/c arrival-rate model (cost x latency joint optimization) — conceptual, no shared code yet"

@X c2 := "SAFETY refusal-direction <-> SUBSTRATE interpret motif" :: reuse-candidate [proposed draft]
  note = "both are linear-probe / activation-norm directions on the same SANDBOX models — a shared probe harness could unify them; unverified"

@X c3 := "lm_foundry orchestration runtime <-> SANDBOX substrate" :: reuse-candidate [proposed draft]
  note = "lm_foundry 3-vendor router + SANDBOX llama-server could share one routing/observability layer — candidate, distinct codepaths today"

# ── 4. usage protocol + scope honesty (@D g67) ──

@N n1 := "reuse protocol" :: note [active]
  step1 = "before building a primitive — `hexa atlas lookup --prefix=<topic>` + grep sibling group SSOT (SAFETY.md · ECONOMICS.md · OPS.md · SUBSTRATE.md)"
  step2 = "on reuse stamp the consumer's CLAIMS.tape row · on offering add the primitive to that group's @X p<n> provides block"
  step3 = "add the edge here (one @X e<n> reuse-edge block, with an evidence row) — this file is the SSOT"

@N n2 := "human ASCII graph view" :: note [active]
  graph <<~GRAPH
  n6-lattice --sigma/phi/tau/J2--+--> ECONOMICS  (F-CODEX-1 train · F-CODEX-2 infer)
                                 +--> SAFETY     (F-CODEX-3 alignment 1/sigma avg)
                                 +--> SUBSTRATE  (F-CODEX-4 motif sigma-phi=10)
  lattice_check (closure audit) ----> F-CODEX-1..4 falsifiers (T1 algebraic floor)
  SANDBOX (llama-server) --------+--> SAFETY     (refusal-matrix)
                                 +--> OPS        (SLO grid)
                                 +--> SUBSTRATE  (rwkv / context scaling)
  GRAPH

@N n3 := "scope honesty — cross-repo deps excluded" :: note [active]
  excluded = "verify/numerics_*.hexa (31 files across all 4 groups) share `use self/runtime/math_pure` — but `self/` is the hexa-lang stdlib (cross-repo primitive home per @D d3), NOT an intra-project file, so per @D g67 (intra-project ONLY) it is recorded here as context, NOT as a reuse-edge"
  note     = "the 3 verified edges above are all WITHIN hexa-codex (group <-> group / shared local primitive); no fabricated edges"
