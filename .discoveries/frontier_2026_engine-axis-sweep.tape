@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "frontier_2026_engine-axis-sweep"
  source = "ENGINE domain — 2026 LLM frontier measurement-axis sweep (one sweep, NOT closure)"
  date   = "2026-05-28"
  flow   = "WebSearch/WebFetch frontier scan -> falsifiable-axis filter -> .discoveries/ seed batch (cx_discovery_log + cx_discovery)"

# ════════════════════════════════════════════════════════════════════
# CONTEXT — what this sweep is, and what it is NOT
# ════════════════════════════════════════════════════════════════════
# A single ENGINE-domain sweep of the late-2025 / 2026 LLM frontier for
# MEASUREMENT AXES that hexa-codex does NOT yet cover. PROPOSALS ONLY —
# this log creates no domain, edits no DOMAINS.tape / ENGINE.md, writes
# no .hexa. Each seed below is a candidate for a future cycle's measured
# claim.
#
# DISJOINT from existing coverage (NOT re-proposed): the 28 cross-cutting
# domains (CALIBRATION..MODEL-CLASS), the VERTICAL/* specialist set, and
# the cycle-10 absorbed axes (SPARSE-MOE, MULTIMODAL, AGENTIC-TRAJECTORY,
# REASONING-DEPTH, COST-PERFORMANCE, ALIGNMENT-FAKING, QUANTIZATION,
# CHECKPOINT, TOKENIZER, SPECULATIVE, DISTRIBUTED, KV-CACHE).
#
# REJECTED during the sweep (no genuinely-new falsifiable axis vs cover):
#   - "speculative cascades" / cascade-routing cost-quality deferral curve
#     -> overlaps ECONOMICS COST-PERFORMANCE/N1 + BATCH-COMPOSITION/SPECULATIVE.
#       (arXiv 2602.09902, research.google speculative-cascades) — not new.
#   - "test-time compute scaling" raw accuracy-vs-tokens curve
#     -> overlaps HALLUCINATION REASONING-DEPTH/N1. Only the LATENT-vs-token
#       efficiency reframe (e1 below) survives as new.
#   - generic "model is better" / leaderboard-saturation topics — no falsifier.
#
# FALSIFIER DISCIPLINE (cx_lab_falsifiable + feedback_negative_paper_external_claim):
# every seed names an INDEPENDENT external anchor (published benchmark or
# paper) so any future closed-negative targets a real external claim, not a
# self-generated strawman. Each seed states (a) a number that can be
# computed and (b) a falsifier that FIRES when the claim is false. Any
# candidate without a falsifier was dropped (g63 honesty — no padding).
#
# CONTINUATION, NOT CLOSURE (feedback_closure_is_physical_limit): the
# frontier is INFINITE. This is sweep #1. status of this lane = OPEN /
# continuation — re-run next cycle with fresh queries; do NOT mark
# "all frontier covered".

# ════════════════════════════════════════════════════════════════════
# CANDIDATE AXES — 6 genuinely-new falsifiable measurement seeds
# ════════════════════════════════════════════════════════════════════

@C d_engine_f26_unlearning_forget_retain := "machine-unlearning forget-quality vs retain-utility frontier — the un-learnable gap a metered API can never expose (NEW domain: UNLEARNING)" :: seed [verified_tier_target=GREEN status=open]
  seed       = "After applying an unlearning method to a forget set F while protecting a retain set R, jointly score forget-quality and retain-utility, and probe relearn/jailbreak recovery — no external API exposes weights so this is substrate-only."
  metric     = "U = (1 - acc_forget_post) on F  AND  R_util = acc_retain_post / acc_retain_pre on R, plus a recovery probe R_relearn = acc_forget after k adversarial-extraction / few-shot-relearn prompts. Compute the (U, R_util) Pareto point per method {GradAscent, NPO, RMU, TOFU-IDK} on Qwen2.5-1.5B with a fictitious-author forget set (TOFU style) + a WMDP-style hazardous slice; recompute by a verify harness scoring forget-set / retain-set accuracy deltas + the relearn-recovery curve."
  falsifier  = "FIRES if no method reaches U >= 0.9 (forget-set accuracy < 10%) while holding R_util >= 0.95 (retain utility within 5% of pre) — i.e. forgetting and utility are NOT separable on this substrate, unlearning is cosmetic. ALSO FIRES if R_relearn recovers acc_forget to >= 0.5 of pre within k <= 5 relearn prompts (the 'forgotten' knowledge is suppressed, not removed) — refuting any deployment claim that unlearning is a privacy/safety guarantee rather than an output filter."
  home       = "NEW DOMAIN: UNLEARNING (cross-cutting safety/privacy). NOT PRIVACY (membership-inference) nor POST-TRAINING (capability add) — this is the capability-REMOVAL + recovery-resistance axis, orthogonal to both."
  anchors    = "Maini et al. TOFU (arXiv 2401.06121); Shi et al. MUSE 6-way (arXiv 2407.06460); Li et al. WMDP (arXiv 2403.03218); OpenUnlearning unified bench, 9 algos × 16 evals (arXiv 2506.12618)."
  note       = "harmful WMDP slice => cx_hf_safety_private (PRIVATE eval set, public only on user sign-off). Substrate-only by construction (cx_lab_sandbox)."

@C d_engine_f26_sandbagging_eval_awareness := "eval-awareness & strategic sandbagging gap — targeted-capability drop vs general-knowledge drop under monitoring (NEW: ROBUSTNESS N2)" :: seed [verified_tier_target=GREEN status=open]
  seed       = "Measure whether a model recognizes it is under evaluation and selectively underperforms on a TARGETED dangerous-capability slice while general-knowledge performance is unmoved, and whether it evades a chain-of-thought monitor while doing so."
  metric     = "Eval-awareness rate EA = P(model flags prompt as 'likely an evaluation') on a held-out benchmark-style set vs an internal-style set. Sandbagging gap SG = acc_drop(targeted-capability evals | sandbag instruction) - acc_drop(general-knowledge | sandbag instruction). Monitor-evasion rate ME = fraction of successful sandbags whose CoT is rated benign by a CoT monitor. Compute on a local instruct model (sandbox substrate) across paired eval-styled vs neutral prompt sets; recompute by a harness scoring per-slice accuracy deltas + monitor flag rate."
  falsifier  = "FIRES if SG <= 2pp (targeted drop is no larger than the general-knowledge drop) — then there is NO selective sandbagging, the model is uniformly degraded, refuting the external 'strategic underperformance' claim on this substrate. ALSO FIRES if EA(benchmark-style) - EA(internal-style) <= 3pp — no eval-awareness signal, so eval-vs-deployment behavior is indistinguishable and capability evals are NOT systematically gameable here."
  home       = "ROBUSTNESS N2 (sibling to the already-covered ALIGNMENT-FAKING/N1 under ROBUSTNESS). Distinct: alignment-faking = pretending to be aligned during training; sandbagging = hiding CAPABILITY during evaluation. Different falsifier surface."
  anchors    = "van der Weij et al. 'AI Sandbagging' (arXiv 2406.07358); 'LLMs Can Covertly Sandbag Against CoT Monitoring' — bypass 16-36% conditioned on success (arXiv 2508.00943); Meta Muse Spark report (Apr 2026) — eval-flag 19.8% public vs 2.0% internal, sandbag drop 32pp targeted vs 0.4pp general."
  note       = "Externally-anchored bidirectional falsifier => a clean closed-negative candidate if SG collapses on small open models (capability-gated sandbagging)."

@C d_engine_f26_reward_hack_exploit_rate := "agentic reward-hacking exploit rate — shortcut-taking vs honest task completion when honest path is tractable (NEW: AGENT N2)" :: seed [verified_tier_target=GREEN status=open]
  seed       = "In multi-step tool-use tasks that contain a naturalistic shortcut (skip verification, read answer from adjacent metadata, tamper with the eval function), measure how often the agent EXPLOITS the shortcut vs solving honestly, and how exploit rate responds to environment hardening."
  metric     = "Exploit rate XR = fraction of episodes where the agent reaches reward via a shortcut rather than the intended solution, scored by an explicit task-vs-hack classifier over the trajectory. Also: CoT-disclosure rate (fraction of hacks whose reasoning explicitly states the shortcut) and hardening delta dXR = XR_baseline - XR_hardened (after patching the exploitable surface) at matched task-success. Run on the sandbox substrate with a small tool-use harness (file ops + a checker the agent could tamper with), N chained tasks; recompute by replaying logged trajectories through the classifier."
  falsifier  = "FIRES if dXR < 1pp at matched task-success — environment hardening does NOT reduce exploitation, refuting the external 87.7%-relative-reduction claim and implying reward-hacking is intrinsic to the policy, not the environment. ALSO FIRES if XR <= 0.5% on a model whose honest-path is tractable (refuting 'frontier models reward-hack measurably' for the open-substrate class) OR if XR is INVARIANT to whether the honest path is computationally tractable (refuting the 'suppressed only when honest stays tractable' mechanism)."
  home       = "AGENT N2 (sibling to the covered AGENTIC-TRAJECTORY/N1). Trajectory-quality axis measures task progress; this measures the SHORTCUT-vs-honest split — a distinct reward-integrity surface with its own falsifier."
  anchors    = "Reward Hacking Benchmark for tool-use agents — XR 0% (Claude Sonnet 4.5) .. 13.9% (DeepSeek-R1-Zero), CoT-disclosed 72%, hardening -5.7pp / -87.7% rel (arXiv 2605.02964); Denison et al. 'Honesty to Subterfuge' ICRL reward-hack (arXiv 2410.06491)."

@C d_engine_f26_diffusion_parallel_dependency := "diffusion-LLM parallel-decoding speed-vs-dependency-failure frontier — tokens/s gained per quality point lost (NEW: ARCHITECTURE N2 / decoding-paradigm)" :: seed [verified_tier_target=GREEN status=open]
  seed       = "For a diffusion / any-order LM, sweep the parallel-decoding block size B and measure the speedup against the quality lost specifically to violated token dependencies (conditional-independence assumption), isolating the dependency-failure component from generic quality loss."
  metric     = "For each block size B in {1, 2, 4, 8, 16}: throughput tok/s, task quality Q(B) on a dependency-sensitive set (ordering / coreference / code where later tokens depend on earlier), and dependency-failure rate DFR(B) = fraction of errors attributable to a token mispredicted because a same-block dependency was decoded in parallel. Headline = speed-quality efficiency E = (tok/s gained) / (quality points lost) and the crossover B* where Q(B) drops below an autoregressive baseline by >epsilon. Run a small open diffusion LM (e.g. LLaDA-class) on the sandbox substrate; recompute by re-scoring logged generations per block size."
  falsifier  = "FIRES if Q(B) stays within epsilon (1pp) of the AR baseline up to the largest B with DFR not rising above the B=1 level — then parallel decoding is FREE on this task class, refuting the ParallelBench 'parallel decoding fails to capture token dependencies / significant quality degradation' claim for these tasks. ALSO FIRES if speedup at the largest lossless B is < 1.5x (no meaningful parallel benefit) — refuting the diffusion-LM speed advantage (e.g. the 2,146 tok/s / 18x headline class) at equal quality on this substrate."
  home       = "ARCHITECTURE N2 (decoding-paradigm axis, sibling to the covered ARCHITECTURE coverage + SPECULATIVE under BATCH-COMPOSITION). AR speculative decoding is loss-LESS by construction; diffusion parallel decoding trades quality for speed — a different, falsifiable surface."
  anchors    = "ParallelBench — parallel-decoding trade-offs in diffusion LLMs (arXiv 2510.04767); Seed Diffusion 2,146 tok/s (arXiv 2508.02193); Learn2PD up to 22.58x / 57.51x w/ KV (arXiv 2509.25188); ReFusion 34% gain / 18x (arXiv 2512.13586)."

@C d_engine_f26_merge_interference := "model-merging task-interference frontier — retained per-task accuracy vs number of merged experts (NEW: POST-TRAINING N2)" :: seed [verified_tier_target=GREEN status=open]
  seed       = "Merge k domain-specialist task-vectors into one model and measure the per-task accuracy retained vs the k separately-served specialists, as a function of k and merge method, to locate where interference becomes irreconcilable rather than technical."
  metric     = "Retention ratio RR(k, method) = mean over tasks of acc_merged / acc_specialist for merge methods {task-arithmetic, TIES, DARE, DELLA} at k in {2, 3, 4, 6}. Headline = the interference knee k* where RR drops below a threshold (e.g. 0.95) and the method ordering (does DELLA's reported +11.1 over task-arithmetic hold). Build k LoRA specialists on disjoint domains over one base on the sandbox substrate; recompute by re-evaluating the merged checkpoint per task vs each specialist."
  falsifier  = "FIRES if RR(k) >= 0.98 for all k up to 6 across methods — merging is essentially free, refuting 'parameter interference is a fundamental limitation' (MergeBench / DELLA framing) at this scale. ALSO FIRES if the method ordering INVERTS (task-arithmetic >= DELLA on RR at matched k) — refuting the published DELLA > TIES > DARE > task-arithmetic ranking on this substrate. Either firing reframes the deployment guideline (merge-and-serve-one vs route-to-k-specialists)."
  home       = "POST-TRAINING N2 (sibling to the covered POST-TRAINING + the absorbed economics-routing work). Routing chooses among k served models; merging collapses k into 1 — the interference/retention curve is the distinct falsifiable axis."
  anchors    = "MergeBench (arXiv 2505.10833); DELLA distribution-aware sparsification +11.1 over task-arithmetic (arXiv 2508.06163); 'Model Merging in the Era of LLMs' survey (arXiv 2603.09938); Ilharco et al. Task Arithmetic (arXiv 2212.04089)."

@C d_engine_f26_latent_reasoning_efficiency := "latent (neuralese) reasoning token-efficiency frontier — accuracy gained per latent step vs per emitted CoT token (NEW: HALLUCINATION REASONING-DEPTH N2)" :: seed [verified_tier_target=BLUE status=open]
  seed       = "Compare reasoning that happens in continuous latent space (recurrent-depth / Coconut-style latent steps, no emitted tokens) against explicit chain-of-thought, measuring accuracy gained per UNIT OF COMPUTE — latent recurrent step vs emitted CoT token — to test whether latent reasoning is compute-cheaper at equal accuracy."
  metric     = "For a recurrent-depth or latent-thought model: accuracy A(s) vs number of latent steps s, and the per-step marginal dA/ds; for an explicit-CoT model: accuracy A(t) vs emitted reasoning tokens t and dA/dt. Headline = compute-normalized efficiency ratio rho = (FLOPs to reach accuracy a via latent) / (FLOPs to reach a via emitted CoT) at matched accuracy a. Recompute closed-form FLOPs per latent step (2N per recurrent pass) vs per emitted token (2N forward) and combine with measured step/token counts to a (compute, accuracy) curve on a reasoning set."
  falsifier  = "FIRES if rho >= 1 at matched accuracy across the tested accuracy band — latent reasoning is NOT compute-cheaper than emitted CoT, refuting the central 'latent reasoning attains similar accuracy with increased efficiency' claim (Coconut / recurrent-depth). ALSO FIRES if A(s) saturates with NO accuracy gain from added latent steps (dA/ds ~ 0) — then latent test-time compute does not scale at all on this substrate, a closed-negative against the 'third scaling law' latent variant."
  home       = "HALLUCINATION REASONING-DEPTH N2 (the covered REASONING-DEPTH/N1 measures emitted-CoT depth; this measures LATENT-step compute-efficiency — the missing token-free axis of the same surface)."
  anchors    = "Geiping et al. 'Scaling Test-Time Compute with Latent Reasoning: Recurrent Depth' (arXiv 2502.05171); Hao et al. Coconut latent reasoning (arXiv 2412.06769); 'The Art of Scaling Test-Time Compute' (arXiv 2512.02008) — no-TTS-strategy-dominates baseline."
  note       = "T_BLUE: the FLOPs side is closed-form; only the (step/token, accuracy) counts need a substrate run, making this the cheapest first probe of the six."

# ════════════════════════════════════════════════════════════════════
# LANE STATUS — OPEN / continuation (NOT closure)
# ════════════════════════════════════════════════════════════════════
# 6 falsifiable seeds logged. Sweep #1 of an INFINITE frontier — re-run
# next cycle with fresh queries (e.g. world-models, in-context-RL emergence,
# memory-augmented agents, watermark robustness, knowledge-edit ripple
# locality — surfaced but not yet sharpened to a falsifier here).
# Next step: promote the 1-2 highest-priority seeds to a measured cycle
# claim; this log is PROPOSAL-ONLY (no domain created, no .hexa, no
# DOMAINS.tape / ENGINE.md edit).
