@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "sandbox-p3-multinode"
  source = "SANDBOX perpetual axis P3 — multi-node serving substrate, Erlang-C knee re-measured under distributed replicas (cycle-21)"
  date   = "2026-05-26"
  flow   = "first-arc-closed -> M3.OPS+M4.OPS single-UMA Erlang-C closed -> P3 reopens at multi-node fan-out -> distributed-replica re-measurement seed (cx_discovery_log)"

# ════════════════════════════════════════════════════════════════════
# CONTEXT — what P3 is and the first cheap 2-host pilot
# ════════════════════════════════════════════════════════════════════
# SANDBOX.md §영구 축 P3 = "multi-node serving substrate: 단일 UMA 호스트
# → 분산 replica 로 Erlang-C knee 재측정". M3/M4.OPS measured the M/M/c
# law on ONE mac mini UMA (3 -np × 6 rate = 18 cells, λ_max ≈ c·μ with
# c ∈ {1,2,4} and μ_eff degrading 9.53/7.505/5.0 req/s/slot from shared
# UMA mem-bandwidth). The closed paper proves the LAW analytically; what
# the SUBSTRATE has not yet shown is how that law behaves when the c
# slots are split across PHYSICAL hosts with non-uniform μ.
#
# Available pool roster (from session hook):
#   mini       macos / M3 UMA 24GB    (cycle-15 baseline ran here)
#   ubu-1      linux / RTX 5070 12GB  (cycle-16 M1.SAFETY+ HF probe ran here)
#   ubu-2      linux / Intel CPU      (auxiliary worker)
#   pi5-akida  linux / Akida NPU      (heterogeneous low-power lane)
#
# Selection rule (g0 Occam): the SMALLEST 2-host pilot that proves the
# law generalises is mini + ubu-1 with the SAME Qwen2.5-0.5B-Instruct
# GGUF served as 2 replicas behind a round-robin client-side LB. Three
# candidates seeded — pilot first, then full 3-host generalisation, then
# the heterogeneous-μ regime (mini + pi5-akida).

@C d_p3_2host_homogeneous_pilot := "2-host homogeneous-replica Erlang-C knee re-measurement (mini + ubu-1)" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness bench/sandbox_p3_multinode_2host.hexa — serve Qwen2.5-0.5B-Instruct-Q4_K_M as 2 identical llama-server replicas (mini :8090 + ubu-1 :8090 over the existing tailscale/pool route); client-side round-robin LB in the harness (no nginx — keep it 0-dep); rerun the M3.OPS rate grid {1,2,5,10,20,40} with -np 1 per replica (so total c=2 across hosts); measure (a) per-replica p50/p99, (b) aggregate accuracy, (c) network-overhead RTT to ubu-1 vs in-process mini; recompute against the closed-form M/M/c with c=2 by verify/numerics_ops_mmc_knee.hexa extended (REUSE existing verifier with c=2 substituted)"
  hyp     = "aggregate λ_max ≈ Σ_h c_h·μ_h ≈ 2·μ̄ (with μ_h heterogeneous via host hardware) AND the M/M/c pole-knee structure HOLDS modulo a fixed-additive network-RTT offset on the ubu-1 path (so the knee shifts right relative to a same-host c=2 baseline, but the functional family stays Erlang-C)"
  verdict = "PENDING — first multi-node pilot. Cheapest possible variant (2 hosts, both already in pool, no new infra). The KEY substrate-level question is whether splitting c across PHYSICAL hosts changes the law's FUNCTIONAL family or just its constants. Falsifier: if measured aggregate throughput ceiling falls >25% short of Σ μ_h (above what the network RTT explains), the M/M/c independence assumption breaks under distributed serving — a substrate-architecture finding (likely client-side LB serialisation OR shared-resource contention on the pool route)."

@C d_p3_3host_replica_generalisation := "3-host replica scaling — does the law extend to c=3 with mini+ubu-1+ubu-2?" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "as in d_p3_2host_homogeneous_pilot but with 3 replicas (mini + ubu-1 + ubu-2, total c=3); ONLY fires after the 2-host pilot returns the predicted Erlang-C structure (gating on the pilot's verdict to avoid building infra on a falsified premise)"
  hyp     = "the 3-host aggregate throughput ceiling tracks Σ μ_h with c=3 within ±10%; per-replica p50/p99 at sub-knee rate stays within 20% of the 2-host pilot's same-replica numbers (no additional cross-host serialisation as c grows)"
  verdict = "PENDING — contingency on the 2-host pilot landing GREEN. ubu-2 is CPU-only so its μ_h is the slowest of the three — the heterogeneity controls for whether the round-robin LB needs slot-weighted dispatch to avoid head-of-line blocking. Falsifier: if p99 explodes at sub-knee rate when ubu-2 is added (head-of-line blocking on the slow replica), the harness's round-robin LB is wrong for heterogeneous-μ — least-loaded or weighted-round-robin needed (a serving-stack finding)."

@C d_p3_heterogeneous_mu_pi5_akida := "heterogeneous-μ regime — mini (M3 Metal/UMA) + pi5-akida (Akida NPU); does NPU offload change the law?" :: seed [verified_tier_target=YELLOW status=open]
  cmd     = "harness bench/sandbox_p3_heterogeneous_mu.hexa — mini llama-server :8090 + pi5-akida (Akida NPU-routed inference IF a llama.cpp-compatible NPU backend exists OR fall back to pi5's CPU as a low-power slow-μ replica); measure the same rate grid; the Akida NPU's μ_pi5 is unknown a priori, so the bench is also an μ_pi5 measurement; recompute Erlang-C with weighted dispatch (slot probability ∝ μ_h)"
  hyp     = "heterogeneous-μ Erlang-C with WEIGHTED LB matches Σ μ_h; with round-robin LB the slow replica becomes the bottleneck and aggregate throughput → c·min(μ_h) rather than Σ μ_h"
  verdict = "PENDING — third-tier exploration, behind 2-host pilot + 3-host generalisation. Carries an INFRA prerequisite — Akida NPU inference path on pi5 needs validation (llama.cpp upstream doesn't natively target Akida; may need ONNX export + Akida runtime + a llama-server-compatible adapter, OR fall back to pi5 CPU serving as a generic slow-μ replica which still answers the heterogeneity question). VERIFIED_TIER_TARGET=YELLOW because of the NPU-path uncertainty; if Akida path infeasible, falls back to CPU and tier stays GREEN."

@C d_p3_network_rtt_overhead_decomposition := "decompose distributed Erlang-C deviations into (a) network RTT offset, (b) LB-side serialisation, (c) replica heterogeneity — a substrate-instrumentation seed" :: seed [verified_tier_target=GREEN status=open]
  cmd     = "harness bench/sandbox_p3_rtt_decompose.hexa — for each (rate, c, host-set) cell in d_p3_2host/d_p3_3host, also record (1) tcp RTT to each replica via ping/tcping baseline, (2) per-request inflight time on the LB side (request enqueued → response returned, distinguishing wait_in_queue vs in_flight_serving via per-request log timestamps), (3) per-replica μ_h via a single-host control rerun; report a delta-budget table showing how much of (predicted Erlang-C latency − measured latency) each component accounts for"
  hyp     = "the deviation between predicted Erlang-C and measured aggregate latency decomposes additively into (RTT_offset + LB_overhead + heterogeneity_penalty) within 10% residual i.e. no UNEXPLAINED substrate overhead is left"
  verdict = "PENDING — instrumentation seed that turns ANY P3 result (positive or negative) into an interpretable decomposition rather than a black-box deviation. Should run alongside d_p3_2host_homogeneous_pilot — same harness loop, extra telemetry. Falsifier: if the residual after the three components exceeds 15%, an UNNAMED substrate overhead exists — possible candidates: TCP slow-start per-request, llama-server cold-cache restart on idle, mac-mini thermal throttling under sustained load."
