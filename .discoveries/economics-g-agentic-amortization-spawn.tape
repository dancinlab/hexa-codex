@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "economics-g-agentic-amortization-spawn"
  source = "ECONOMICS NOVEL 축 G spawned from cycle-44 inference-side maturity (F1-F5 first-probed + C1/C2/C3 VERIFIED) — orthogonal time-horizon axis (cycle-45)"
  date   = "2026-05-27"
  flow   = "cycle-44-Sardana-inference-amortization (single-model lifetime amortization) -> orthogonal-axis spawn: G = AGENTIC / multi-turn compute amortization scaling laws (per-conversation, per-session, per-agent-trajectory) (cx_discovery_log · cx_discovery)"

# ════════════════════════════════════════════════════════════════════
# CONTEXT — why G spawns from cycle-44's inference-maturity wall
# ════════════════════════════════════════════════════════════════════
# By cycle-44 the inference-side cost surface is well-covered:
#
#   C2/C3   — quant × spec-dec stacking VERIFIED (🟢 numerical, multiplicative bound)
#   F1      — energy/tok roofline k_energy=1.0 EXACT structurally (🔵 + 🟠 measured)
#   F2      — KV-cache bytes closed-form 3 exponents = 1.0 EXACT (🔵)
#   F3      — Leviathan-Kalman spec-dec speedup law (🔵 + 🟠 production-α)
#   F5      — k-quants accuracy quant-invariant on P4 ladder (🟢 + 🟠 scope)
#   C1      — Hoffmann Lagrangian closed-form identity (🔵 8/8)
#
# All of F is anchored on a **single-call single-turn** prompt/decode
# economics frame: one inference, one weight-stream pass, one KV-cache
# allocation. Anchored cost = $/tok or J/tok or s(α) at one operating
# point of one conversation.
#
# But production economics in 2026 is NOT single-turn:
#   - Anthropic prompt caching (Sep 2024) → 90% cost reduction on cache
#     reads, 1.25× write surcharge, 5-min default TTL · 1-hour beta;
#   - DeepSeek context-caching → 10× cheaper $/Mtok on cache hits;
#   - Google Gemini implicit + explicit caching (2025);
#   - OpenAI prompt caching (Oct 2024) → 50% discount on >1k-tok cached
#     prefixes;
#   - Agentic loops (ReAct / Reflexion / Voyager / browser-use) issue
#     5-50 LLM calls per "task" with the system prompt + most of the
#     conversation REPEATED every turn — the amortizable surface is
#     a HUGE prefix that the cache hit rate determines.
#
# F-axis says nothing about this **per-conversation** or **per-task**
# cost surface. The frontier is OPEN on:
#   1) How does $/task scale with conversation depth N_turns under a
#      published cache pricing tier? (Anthropic claims 90% read discount;
#      what's the closed-form amortization curve as function of cache
#      hit rate and turn count?)
#   2) For an N-call agent trajectory, what is the closed-form
#      amortized cost vs the naive uncached cost, and where is the
#      break-even point where caching wins despite the 1.25× write
#      surcharge?
#   3) Tool-call latency budget: each tool call adds RTT + parsing;
#      what is the cost-per-completed-task scaling exponent in
#      N_tools per task vs total wall time?
#   4) Multi-turn KV-cache regime change: published prompt-cache cost
#      models assume LINEAR amortization on prefix length, but real
#      hits are SUFFIX-MISALIGNED (system + last-N turns hit, middle
#      diverges); does measured hit rate follow a closed-form
#      decay-in-divergence-point law?
#   5) Speculative draft REUSE across an agent loop — the draft KV
#      state could persist between turns; does the published spec-dec
#      α distribution generalize, or does in-conversation drift
#      degrade α turn-over-turn?
#
# G-family is the **time-horizon orthogonal axis** to A-F:
#   A-E — TRAINING-side scaling (one model, lifetime training compute)
#   F   — INFERENCE single-call (one call, one weight-stream)
#   G   — INFERENCE multi-turn / per-task (N-call trajectory)
#
# G is also orthogonal to D1's Sardana (cycle-44 parallel sibling):
# Sardana amortizes TRAINING compute across the model's INFERENCE
# lifetime (∫ tokens served before retirement). G amortizes
# INFERENCE compute across a SINGLE TASK's multi-turn trajectory.
# Different denominators, different time horizons.
#
# Falsifier discipline (cx_lab_falsifiable + feedback_negative_paper_external_claim):
# every G seed names an INDEPENDENT external published claim — vendor
# pricing pages (Anthropic, OpenAI, DeepSeek, Google), peer-reviewed
# scaling laws (CacheGen, Prompt Cache), and agent-benchmark cost
# numbers (SWE-Bench, AgentBench) — so the falsifier targets a
# PUBLISHED amortization claim, not a self-generated strawman.
#
# Distinct from F-axis: F is per-call; G is per-task (multi-call).
# Distinct from D1 Sardana: Sardana is per-MODEL-lifetime (train+infer);
# G is per-CONVERSATION-lifetime (within one task).
# Distinct from A-C: A-C are training-side; G is inference + caching.

# ════════════════════════════════════════════════════════════════════
# G1 — Prompt-cache amortization curve vs turn count
# ════════════════════════════════════════════════════════════════════

@C d_econ_g1_prompt_cache_amortization_curve := "$/task vs N_turns under cache pricing — does total cost amortize as N_turns·(c_read·prefix + c_full·delta) + c_write·prefix, and at what N_break does the 1.25× write surcharge pay off vs no-cache baseline?" :: seed [verified_tier_target=BLUE status=open]
  cmd     = "harness verify/numerics_economics_g1_prompt_cache_amortization.hexa — cheapest first probe = closed-form recompute of Anthropic + OpenAI + DeepSeek published cache pricing tiers, NO substrate run, $0. Stage 1: assemble the published pricing table — (a) Anthropic Claude Sonnet 4.5 input $3/Mtok / cache-write $3.75/Mtok (1.25×) / cache-read $0.30/Mtok (0.1× = 90% discount) per Anthropic pricing page Oct 2026 snapshot, (b) OpenAI GPT-4o input $2.50/Mtok / cache-read $1.25/Mtok (0.5× = 50% discount) per OpenAI pricing Nov 2024 snapshot, (c) DeepSeek-V3 input $0.27/Mtok / cache-hit $0.07/Mtok (~0.26× = 74% discount) per DeepSeek api-docs Dec 2024 snapshot. Stage 2: derive closed-form $/task(N_turns, p, d, c_w, c_r, c_f) = c_w·p + (N_turns-1)·(c_r·p + c_f·d) + c_f·(p + d) for N_turns conversation rounds with p prefix tokens persistently cached, d delta tokens per turn — naive baseline = N_turns·c_f·(p+d). Stage 3: solve for N_break = ⌈(c_w·p − c_f·p) / (c_f·(p+d) − c_r·p − c_f·d)⌉ → for Anthropic at p=10k/d=500: N_break ≈ 2 (cache wins from turn 2); for OpenAI at same: N_break ≈ 3; for DeepSeek at same: N_break ≈ 2. Stage 4 (optional cycle-47+ T4): SANDBOX llama-server prefix-cache hit rate measurement across a 10-turn synthetic conversation (Qwen2.5-1.5B-Q4_K_M, fixed 10k system prompt, 500-tok user delta per turn) → measured $/task vs closed-form prediction."
  hyp     = "Closed-form amortization curve matches all 3 vendor pricing tiers within ε=0.5% (algebraic identity, this is a pricing-table self-check). The interesting hypothesis: N_break ≤ 2 for ALL 3 vendors at prefix:delta ratio ≥ 10:1 — i.e. prompt caching wins from the SECOND turn for any conversation with substantial system prompt or RAG context. Naive no-cache baseline overpays by a factor approaching (1 − c_r/c_f) ≈ 0.9 for Anthropic on long conversations (N_turns → ∞)."
  verdict = "PENDING — closed-form first probe ($0, recompute only). External anchor: Anthropic prompt-caching pricing page (Sep 2024 launch, $0.30/Mtok cache-read for Sonnet) · OpenAI prompt-caching announcement (Oct 2024, 50% cache discount) · DeepSeek-V3 context-caching api-docs (Dec 2024). Falsifier: if N_break > 5 turns for any vendor at typical agent prefix:delta ratio (10:1), the published '90% discount' headline is misleading for typical workloads — vendor cache pricing only pays off for very long conversations. Conversely, if amortization saturates at less than (1 − c_r/c_f) reduction even at N_turns → 100 (asymptote not reached), the published cache-pricing model has hidden per-request overhead unaccounted for in the closed-form. Distinct from F2 (F2 = KV bytes per request; G1 = $/task across N requests). Distinct from D1 Sardana (Sardana = per-model lifetime; G1 = per-conversation lifetime)."

# ════════════════════════════════════════════════════════════════════
# G2 — Agent trajectory cost scaling law in N_tool_calls
# ════════════════════════════════════════════════════════════════════

@C d_econ_g2_agent_trajectory_cost_law := "$/task ∝ N_tool_calls^k_agent — does total agent-loop cost (LLM calls + tool latency) follow a closed-form power law in tool-call count, and what is k_agent for ReAct vs Reflexion vs CoT-only baselines?" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness verify/numerics_economics_g2_agent_trajectory_cost.hexa — cheapest first probe = closed-form WebFetch + recompute, NO substrate run, $0. Stage 1: collect published per-task cost / token usage from agent benchmarks — candidate sources: (a) Yao et al. 2023 'ReAct' (https://arxiv.org/abs/2210.03629) HotpotQA token usage per trajectory, (b) Shinn et al. 2023 'Reflexion' (https://arxiv.org/abs/2303.11366) iterative refinement token cost, (c) SWE-Bench Verified leaderboard (https://www.swebench.com/) per-task $/solve numbers for Claude / GPT-4 / DeepSeek agents, (d) AgentBench (https://arxiv.org/abs/2308.03688) per-task token+latency profile, (e) Princeton-NLP SWE-Agent trajectories (https://arxiv.org/abs/2405.15793) median 30-50 LLM calls per resolved issue. Stage 2: fit log-log OLS $/task = a · N_tool_calls^k_agent on per-method trajectories — predicted k_agent ∈ {ReAct: ~1.0 (linear, no growing context), Reflexion: ~1.2-1.5 (context grows with each reflection), tree-search agents: ~1.5-2.0 (branching factor)}. Stage 3: separate the components — c_LLM(N) + c_tool(N) + c_orchestration(N) where c_tool is per-call RTT (parser + sandbox + network). Compute the break-even N* where c_tool dominates c_LLM (modern coding agents hit this around N=10-20 with sub-second tool RTT). Stage 4 (optional cycle-47+ T4): SANDBOX run a fixed 5-task agentic loop (HotpotQA subset) with Qwen2.5-1.5B-Q4_K_M + simple search tool, measure per-task token usage vs N_steps to extract empirical k_agent."
  hyp     = "k_agent ≈ 1.5 for context-accumulating agents (ReAct + Reflexion mix) because EVERY tool result is appended to the conversation, so per-call input length grows linearly in N → total cost = Σ_n c·n = O(N^2/2), giving an effective k_agent ≈ 1.5-2.0 when fit as a power law in N_calls. The naive 'agent cost is linear in steps' folk claim is OFF by a factor of N — agent cost is QUADRATIC in steps for context-accumulating loops without summarization/compression. With caching (G1 composition): k_agent drops back toward 1.0 since the growing context is mostly cache-hit on each subsequent call."
  verdict = "PENDING — closed-form first probe ($0). External anchor: Yao et al. 2023 ReAct (https://arxiv.org/abs/2210.03629) · Shinn et al. 2023 Reflexion (https://arxiv.org/abs/2303.11366) · SWE-Bench Verified leaderboard cost columns · Princeton-NLP SWE-Agent paper (https://arxiv.org/abs/2405.15793). Falsifier: if measured k_agent ≤ 1.1 across all 3 method families (ReAct/Reflexion/SWE-Agent) on published benchmark traces, the 'context-accumulation makes agents quadratic' hypothesis is FALSIFIED — agent loops ARE linear in N and the cost dominance must come from per-call fixed overhead (tool RTT, orchestration). Conversely, if k_agent ≥ 1.8 even with prompt-caching enabled, then context-window-quadratic dominates cache benefit and agent cost still blows up super-linearly — operational guideline 'long agentic loops are affordable with caching' is FALSIFIED. Distinct from G1 (G1 = per-conversation amortization curve in N_turns; G2 = per-trajectory total cost in N_tool_calls). Distinct from F3 spec-dec (F3 is per-call algorithmic speedup; G2 is per-task call-count scaling)."

# ════════════════════════════════════════════════════════════════════
# G3 — Cache-hit-rate decay vs conversation divergence point
# ════════════════════════════════════════════════════════════════════

@C d_econ_g3_cache_hit_rate_decay_law := "p_hit(divergence_offset) — does measured prompt-cache hit rate decay with a closed-form law as the conversation's earliest divergence point moves toward the start, and how does this interact with the published vendor cache-block boundary (Anthropic 1024-tok block · OpenAI 128-tok prefix granularity)?" :: seed [verified_tier_target=BLUE status=open]
  cmd     = "harness verify/numerics_economics_g3_cache_hit_decay.hexa — cheapest first probe = closed-form recompute + WebFetch of vendor cache-block documentation, NO substrate run, $0. Stage 1: derive the closed-form hit-rate model from vendor block granularity — Anthropic Claude prompt cache requires a minimum 1024-tok cacheable block and breaks the cache prefix at the FIRST divergence point (Anthropic cache docs Oct 2024); OpenAI prompt cache has 128-tok prefix granularity with automatic prefix matching (OpenAI docs Oct 2024). Closed-form hit_rate(divergence_offset, block_size, prefix_len) = floor(divergence_offset / block_size) · block_size / prefix_len for fixed-block schemes, hit_rate(d, prefix_len) = d / prefix_len for variable-prefix schemes. Stage 2: derive expected $/task under a divergence-offset distribution model — for a typical agent loop, divergence point migrates from token 0 → token prefix_len as the conversation grows; under uniform distribution of divergence, expected hit rate = 0.5; under power-law (divergence concentrated near end-of-prompt), expected hit rate → 0.9+. Stage 3: tie back to G1 amortization curve — effective c_read_amortized = p_hit · c_read + (1 − p_hit) · c_full → ANY divergence in the middle of a long prefix loses the entire remainder (Anthropic), but only the displaced 128-tok block (OpenAI). Stage 4 (optional cycle-47+ T4): SANDBOX llama-server prefix-cache hit-rate measurement under controlled divergence injection at fixed offsets (1k, 2k, 4k, 8k into 10k prefix) → measured hit-rate decay vs closed-form prediction; compare against vendor block-boundary behavior."
  hyp     = "Hit rate decay is STEP-FUNCTION in divergence_offset for Anthropic's 1024-tok-block scheme (hit rate drops to floor(divergence/1024)·1024/prefix_len), making cache hit-rate VERY sensitive to where the conversation diverges; OpenAI's 128-tok granularity is ~8× more divergence-tolerant. The interesting consequence: agent loops with stable system+tools but per-turn user variation (the typical case) hit ~100% cache for the system+tools block and 0% for the per-turn delta — measured aggregate hit rate ≈ (system_len + tools_len) / (system_len + tools_len + per_turn_delta · N_turns), which DECAYS as the conversation grows. After N=20 turns with 500-tok deltas and 10k system, hit rate ≈ 10k / (10k + 10k) = 0.5 → effective cost discount drops from 0.1× headline to ~0.55× (Anthropic) or ~0.75× (OpenAI 50%-on-cached half)."
  verdict = "PENDING — closed-form first probe ($0). External anchor: Anthropic Claude prompt-caching docs (https://docs.anthropic.com/en/docs/build-with-claude/prompt-caching, 1024-tok minimum block, Sep 2024) · OpenAI prompt-caching docs (https://platform.openai.com/docs/guides/prompt-caching, 128-tok prefix granularity, Oct 2024) · DeepSeek context-caching docs (https://api-docs.deepseek.com/news/news0802, automatic prefix). Falsifier: if measured hit-rate decay is GRADUAL (not step-function) for Anthropic's 1024-tok scheme on a substrate that implements the same semantics (e.g., llama-server's per-token cache fallback differs), the closed-form block-boundary law is FALSIFIED for that substrate — the vendor's particular implementation matters more than the documented block size. Conversely, if effective hit rate saturates below 0.5 even on the longest stable-prefix workloads, the published '90% cost reduction' is achievable ONLY in the toy case of fixed prompt + zero delta, not in realistic multi-turn agent loops — published amortization claim is FALSIFIED for production. Distinct from G1 (G1 assumes IDEAL hit rate; G3 fits the realistic hit-rate decay curve). Distinct from F2 (F2 = KV bytes per request; G3 = cache-hit fraction across requests)."

# ════════════════════════════════════════════════════════════════════
# G4 — Multi-turn drift vs speculative-decoding α
# ════════════════════════════════════════════════════════════════════

@C d_econ_g4_multi_turn_specdec_drift := "α(turn_index) — does speculative-decoding acceptance rate α drift across an N-turn conversation (in-context-shift accumulation), and does this break F3's single-call α distribution into a multi-turn-conditional law?" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness verify/numerics_economics_g4_multi_turn_specdec_drift.hexa — cheapest first probe = closed-form composition of F3 Leviathan-Kalman α with multi-turn distribution shift literature + WebFetch of any published per-turn α measurements, NO substrate run, $0. Stage 1: collect published evidence on draft-target divergence drift — candidate sources: (a) Leviathan & Kalman 2023 (https://arxiv.org/abs/2211.17192) baseline α per task class (translation 0.75, summarization 0.85), (b) Cai et al. 2024 'Medusa' (https://arxiv.org/abs/2401.10774) self-draft α across long contexts, (c) Sun et al. 2024 'Speculative Decoding via Online Calibration' (any arXiv long-context measurement on Llama-3 / Qwen2.5 if available), (d) MS Research 'EAGLE' / 'EAGLE-2' (https://arxiv.org/abs/2406.16858) per-token feature-distillation α at different positions. Stage 2: derive closed-form composition — if base α₀ for the prompt class is fixed (F3's hypothesis) but each turn injects new tool-output text that the draft model HAS NOT seen at training, then α(turn) = α₀ · (1 − drift_rate · turn_index) for linear drift, OR α(turn) = α₀ · exp(−turn_index / τ) for exponential drift, OR α(turn) = α₀ (constant) if F3's per-class invariance holds across turns. Stage 3: compose with F3 speedup s(α, c, N) — total speedup across N_turns conversation = Σ s(α(t), c, N_draft) / N_turns; if drift_rate > 0, average speedup DEGRADES below F3's per-class average. Stage 4 (optional cycle-47+ T4): SANDBOX reuse F3's spec-dec harness on a 5-turn synthetic agent loop (Qwen2.5-3B target + Qwen2.5-0.5B draft) measuring α per turn → empirical α(turn) curve."
  hyp     = "α drifts SLOWLY across turns — α(turn) ≈ α₀ · (1 − 0.02 · turn) for first 20 turns (2% drop per turn), then stabilizes; total speedup across a 20-turn conversation degrades by ~15-20% vs the F3 single-call prediction. The 'speculative decoding gives constant α per task class' is APPROXIMATELY true (linear small drift) but NOT exactly invariant. The dominant mechanism: tool-call outputs introduce OOD tokens (JSON, code, log lines) that the draft model trained on natural language has lower confidence on → α drops where tool output appears."
  verdict = "PENDING — closed-form first probe ($0). External anchor: Leviathan & Kalman 2023 (https://arxiv.org/abs/2211.17192) · Cai et al. 2024 Medusa (https://arxiv.org/abs/2401.10774) · Li et al. 2024 EAGLE-2 (https://arxiv.org/abs/2406.16858). Falsifier: if measured α is INVARIANT (drift < 1%) across a 20-turn conversation with mixed tool calls on the SANDBOX P4 substrate, the 'multi-turn drift breaks F3' hypothesis is FALSIFIED — F3's per-class α distribution generalizes to multi-turn loops without correction, and spec-dec scales linearly in N_turns. Conversely, if α drops by ≥30% by turn 20 (compounded), spec-dec becomes near-useless deep into agent loops and the operational guideline 'enable spec-dec for agentic serving' must add a turn-budget cutoff. Distinct from F3 (F3 = single-call α per task class; G4 = α drift across turns within one conversation). Distinct from G2 (G2 = total cost per trajectory; G4 = per-call algorithmic speedup degradation across the trajectory)."

# ════════════════════════════════════════════════════════════════════
# G5 — Conversation-state KV-bytes growth law
# ════════════════════════════════════════════════════════════════════

@C d_econ_g5_conversation_kv_growth_law := "KV-bytes(N_turns) — does per-conversation KV-cache footprint grow linearly in N_turns with no compression, what is the published compression ratio for FORMAL summarization / KV-eviction policies, and where does the 'compress every K turns' policy break vs cost-of-recomputation?" :: seed [verified_tier_target=BLUE status=open]
  cmd     = "harness verify/numerics_economics_g5_conversation_kv_growth.hexa — cheapest first probe = closed-form composition of F2 KV-byte law with published compression ratios + WebFetch, NO substrate run, $0. Stage 1: extend F2's KV closed-form to multi-turn: KV_total(N_turns) = KV_per_turn(ctx_per_turn) · N_turns under naive concatenation OR KV_compressed(N_turns) = KV_per_turn(ctx_summary) · 1 + KV_per_turn(ctx_recent) · K under sliding-K + summary scheme. Stage 2: collect published compression-ratio anchors — (a) Xiao et al. 2024 'StreamingLLM' (https://arxiv.org/abs/2309.17453) attention-sink eviction policy, ratio claim 'unlimited context with ≤4 sink tokens + fixed window K=2048', (b) Zhang et al. 2024 'H2O' (https://arxiv.org/abs/2306.14048) heavy-hitter oracle compression 5× claim, (c) Liu et al. 2024 'Scissorhands' (https://arxiv.org/abs/2305.17118) eviction at 3-5× compression, (d) DeepSeek-V2 'MLA' (https://arxiv.org/abs/2405.04434) compresses KV to ~6% of MHA baseline at iso-quality. Stage 3: derive cost-of-recomputation break point — if every K turns the conversation is summarized (cost ≈ c_LLM · summary_tokens) vs the KV-cache memory cost saved (≈ K · ctx_per_turn · bytes_per_KV_entry · $/GB-hour), what is the optimal K? Closed-form K_opt = sqrt(c_summarize / (cost_per_byte_hour · ctx_per_turn)). Stage 4 (optional cycle-47+ T4): SANDBOX measurement of KV-cache size growth on Qwen2.5-1.5B-Q4_K_M with 1-byte KV-quant during a 30-turn synthetic conversation → measured KV bytes vs N_turns slope."
  hyp     = "Naive multi-turn KV grows LINEARLY in N_turns at slope = 2 × ctx_per_turn × L × n_kv_heads × d_head × dtype_bytes (F2's per-call formula × N_turns), making 30-turn conversations consume 30× the single-turn KV. StreamingLLM-style sliding window CAPS this at K × per-turn cost but at quality cost (forgets middle turns). DeepSeek-V2 MLA achieves the strongest compression (≈ 0.06× of MHA), but at architecture-not-policy level. The interesting closed-form claim: K_opt for the compress-vs-keep tradeoff equals sqrt(c_summarize / cost_per_byte_hour / ctx_per_turn), giving K_opt ≈ 10-20 turns for typical $0.50/Mtok and $0.01/GB-hr economics."
  verdict = "PENDING — closed-form first probe ($0). External anchor: Xiao et al. 2024 StreamingLLM (https://arxiv.org/abs/2309.17453) · Zhang et al. 2024 H2O (https://arxiv.org/abs/2306.14048) · Liu et al. 2024 Scissorhands (https://arxiv.org/abs/2305.17118) · DeepSeek-V2 MLA (https://arxiv.org/abs/2405.04434). Falsifier: if measured KV-bytes growth slope on SANDBOX is SUB-linear in N_turns (engine already does implicit eviction / prefix dedup beyond F2's closed-form), the 'naive multi-turn KV scales linearly' hypothesis is FALSIFIED — the substrate already amortizes KV at process-engine level and policy-side compression brings no further savings. Conversely, if measured K_opt formula closed-form is off by > 2× from substrate-measured cost-optimal summarize cadence, the 'sqrt break-point' law is FALSIFIED and the optimal cadence is dominated by per-substrate constants (eviction cost, recompute prefix cost) not visible in the closed-form. Distinct from F2 (F2 = per-call KV bytes; G5 = per-conversation KV bytes). Distinct from G1 (G1 = $/task amortization under cache pricing; G5 = bytes/conversation under compression policy)."

# ════════════════════════════════════════════════════════════════════
# CROSS-CYCLE LINKAGE
# ════════════════════════════════════════════════════════════════════
# - cycle-43 C1 Lagrangian VERIFIED (🔵 8/8) · cycle-44 Sardana inference-
#   amortization (parallel sibling — single-model lifetime amortization)
# - cycle-45 G-spawn (this tape): orthogonal-axis spawn moving up the
#   time-horizon ladder — F is per-CALL, Sardana is per-MODEL-LIFETIME,
#   G is per-CONVERSATION-LIFETIME (the missing middle tier)
# - G1 first probe (cheapest): closed-form recompute of 3 vendor cache
#   pricing tiers + N_break solve ($0, BLUE tier)
# - G2 first probe: closed-form WebFetch + log-log OLS k_agent fit on
#   3 published agent benchmark traces ($0, GREEN tier)
# - G3 first probe: closed-form hit-rate-decay law derived from 3 vendor
#   block-granularity docs + composition with G1 ($0, BLUE tier)
# - G4 first probe: closed-form composition of F3 α with multi-turn
#   drift literature ($0, GREEN tier)
# - G5 first probe: closed-form extension of F2 KV-bytes to multi-turn
#   + K_opt break-point derivation ($0, BLUE tier)
# - G2-G5 all REUSE F1-F5 verdicts (energy/KV/spec-dec/quant) as
#   per-call inputs; G is the MULTI-TURN reframing of the same physical
#   surface — sibling to D1 Sardana's per-lifetime reframing
#
# Honest residual:
# - G is the per-conversation counterpart to F (per-call) and Sardana
#   (per-lifetime). G seeds are orthogonal axes; none gives a Chinchilla-
#   class universal law in a single batch. Each G probe needs ≥3 vendors
#   OR ≥3 agent benchmark traces to escalate from YELLOW citation-only
#   → GREEN substrate-measured.
# - G1 pricing-table risk: vendor pricing changes frequently (Anthropic
#   adjusted cache-read pricing in 2025); the closed-form is correct but
#   the constants need refresh per cycle. Date-stamp every vendor anchor.
# - G2 trace-availability risk: most published agent papers report
#   aggregate $/task, not per-step token usage — k_agent fit may be
#   under-determined (n=3-5 data points per method) until SWE-Bench
#   leaderboard publishes per-trajectory breakdowns.
# - G3 vendor-implementation risk: published cache-block-size docs do
#   not necessarily match the engine's actual hit-rate decay curve
#   (caching is a vendor implementation detail). SANDBOX substrate
#   measurement (llama-server) is a DIFFERENT engine semantics —
#   the closed-form's relevance to vendor APIs is by-construction NOT
#   testable on SANDBOX, only the LOCAL prefix-cache behavior is.
# - G4 drift risk: per-turn α measurement requires per-turn instrumented
#   spec-dec; F3's existing harness does ONE call. Cycle-47+ T4 needs
#   harness extension (loop over 20 turns, log α per turn).
# - G5 substrate-vs-policy risk: vLLM/llama-server already implement
#   prefix-cache + paged-attention that may shadow naive linear growth;
#   measured slope is engine-policy-dependent, not just KV-byte-physics.
# - G frontier is OPEN ([[feedback_closure_is_physical_limit]]) —
#   even if all 5 first probes close GREEN in cycle-46+, the multi-turn
#   amortization surface keeps reopening as vendor caching evolves
#   (Anthropic 1-hour beta cache, Google implicit caching, OpenAI
#   automatic prompt caching) and as agent frameworks change context
#   accumulation patterns (compaction, sub-agent fork). No 100% closure
#   by design.
