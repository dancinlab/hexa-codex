@V := "tape" :: spec [active]
  version = "1.2"

@I := "discoveries-log" :: identity [active]
  slug   = "ops-n1-heterogeneous-mmc"
  source = "OPS NOVEL 축 N1 spawned from cycle-16 single-UMA M/M/c fit + cycle-24 P3 ubu-1 install completion (cycle-28)"
  date   = "2026-05-27"
  flow   = "cycle-16-MMc-singleUMA-fit -> cycle-22-skeleton -> cycle-23-preflight -> cycle-24-ubu1-install-PR72 -> cycle-28-novel-axis-N1-seed (cx_discovery_log)"

# ════════════════════════════════════════════════════════════════════
# CONTEXT — why N1 spawns from cycle-16 + cycle-24
# ════════════════════════════════════════════════════════════════════
# cycle-16 M3.OPS full SLO grid (`.verdicts/sandbox/m3_ops_full_slo_grid_summary.txt`,
# `.verdicts/sandbox/m4_ops_formula_fit.txt`):
#   18-cell single-host UMA fit (3 -np × 6 rate, Stage-2 N=2000, M3 Metal 24GB)
#   c=1 ceiling=9.53 qps · c=2 ceiling=15.01 qps · c=4 ceiling=20.00 qps
#   μ_eff = ceiling/c = {9.53, 7.505, 5.0} req/s/slot (μ degrades with c on UMA mem-bw)
#   M/M/c (Erlang-C) recompute 5/5 PASS — single-UMA, HOMOGENEOUS μ assumption HOLDS.
#
# cycle-22 (`bench/sandbox_p3_multinode_2host.hexa`, 472 lines, parse-PASS):
#   P3 2-host skeleton — mini (Metal) + ubu-1 (RTX 5070 host, then BLOCKED:
#   no llama-server installed).
# cycle-23 preflight (`inbox/notes/p3-ubu1-llama-cpp-install.md`):
#   ubu-1 install probe found ZERO llama-server install paths · GPU sm_120
#   incompatible with shipped CUDA → Option A (CPU-only pre-built bin) chosen.
# cycle-24 (PR #72 merged):
#   ubu-1 llama-server install COMPLETE via Option A (CPU-only). GGUF transferred.
#   tailscale `:8090` path has a known timeout residual; LAN 192.168.50.119 path
#   live. 2-host FIRE is now READY-TO-DRAW (cycle-29+).
#
# OPEN THEORETICAL QUESTION (N1):
#   Classical M/M/c (Erlang-C) assumes HOMOGENEOUS μ across all c servers — every
#   "channel" has the same exponential service rate. The cycle-16 single-UMA fit
#   IS internally heterogeneous-per-slot in the sense that μ_eff degrades with c
#   (9.53 → 7.505 → 5.0 req/s/slot) due to UMA mem-bw contention, BUT all c
#   slots share the SAME host hardware → conceptually each slot has the SAME
#   μ_eff(c) at a given c. The cycle-24 unblocked 2-host topology is the FIRST
#   genuinely heterogeneous-μ measurement opportunity for hexa-codex OPS:
#     - mini  (Metal UMA, np=1): μ_mac ≈ 9.53 req/s/slot (cycle-16 ceiling)
#     - ubu-1 (x86 CPU-only via Option A pre-built bin, RTX 5070 NOT USED
#       because sm_120 ≠ shipped CUDA): μ_ubu predicted ~3 qps (Qwen2.5-0.5B
#       Q4_K_M, CPU x86, per `inbox/notes/p3-ubu1-llama-cpp-install.md`
#       Option A "throughput 충분, M3 mini 9 qps 와 비교, x86 CPU 도 비슷"
#       — but "비슷" is the AUTHOR'S anecdotal predict, not measured;
#       conservative CPU-only Q4 0.5B predict is 2–4 qps based on llama.cpp
#       upstream benches).
#   So at minimum a μ_mac/μ_ubu ≈ 2–5× heterogeneity ratio is expected.
#
#   CLASSICAL ANALOG (Bolch et al. 2006 §6.3, Krishnamoorthy 1963):
#   Heterogeneous-channel M/M/c (servers with distinct μ_i) has CLOSED-FORM
#   variants depending on the dispatch rule:
#     - homogeneous-extension (assume μ̄ = Σμ_i/N, plug into standard M/M/c):
#         aggregate λ_max = Σ μ_i (additive ceiling)
#         knee ρ = λ/Σμ_i = 1 (single global utilisation)
#     - shortest-expected-delay (SED) routing → higher than additive in
#       transient, asymptotically = Σ μ_i in steady-state
#     - dominated-by-slow-server (worst-case wrong routing — e.g. naive
#       round-robin overloads slow ubu-1 first) → aggregate λ_max < Σ μ_i,
#       knee shifts LEFT relative to additive prediction
#
# This seed batches the 3 candidate hypotheses; cycle-28 first-probe runs the
# closed-form recompute (verify/numerics_ops_n1_heterogeneous_mmc.hexa) and
# emits the 3 PREDICTED aggregate-λ values for cycle-29+ measurement to
# falsify.

@C d_ops_n1_homogeneous_extension := "heterogeneous μ_i 에서도 단순 산술합 ceiling = Σ μ_i 가 measured aggregate λ_max 와 ±15% 안에 일치하는가" :: seed [verified_tier_target=YELLOW status=open]
  cmd     = "harness verify/numerics_ops_n1_heterogeneous_mmc.hexa — read cycle-16 single-UMA μ_eff (9.53, 7.505, 5.0 req/s/slot per c∈{1,2,4}) + cycle-24 P3 ubu-1 install host-spec (~3 qps CPU-only Q4_K_M predict) → derive μ_mac (np=1 → 9.53) + μ_ubu (predicted 3.0) → homogeneous-extension predicted aggregate λ_max = Σ μ_i = 9.53 + 3.0 = 12.53 qps · knee at offered rate ≈ 12.53 qps · arithmetic-mean μ̄ = 6.265 qps/slot. 반증자: cycle-29+ 2-host fire 가 aggregate ceiling 을 측정했을 때 |measured − 12.53| / 12.53 > 0.15 → homogeneous-extension breaks · OR knee shift 방향이 예측과 반대 → SED/slow-bound routing dominance."
  hyp     = "homogeneous-extension (단순 산술합 Σ μ_i) 이 heterogeneous 2-host aggregate λ_max 의 ±15% 안 fit — 즉 dispatch overhead 가 negligible 하고 두 호스트가 independent M/M/1 channel 처럼 가산"
  verdict = "PENDING — cycle-28 closed-form predict 만 ($0, mini local). 외부 anchor: Bolch et al. 2006 *Queueing Networks and Markov Chains* (Wiley 2nd ed.) §6.3 heterogeneous-channel M/M/c; Kleinrock 1975 *Queueing Systems Vol. I* (Wiley) §3.5 multi-server stability. cycle-29+ 실측 fire 는 `bench/sandbox_p3_multinode_2host.hexa` LAN 192.168.50.119 경로."

@C d_ops_n1_sed_routing_upper_bound := "shortest-expected-delay (SED) routing 이 transient 에서 단순 산술합 ceiling 보다 높은 aggregate throughput 을 내는가" :: seed [verified_tier_target=YELLOW status=open]
  cmd     = "harness verify/numerics_ops_n1_heterogeneous_mmc.hexa (same file, multi-variant emit) — SED policy 분석: 빠른 호스트 (mini, μ_mac=9.53) 가 항상 비어있을 때 우선 라우팅, 느린 호스트 (ubu-1, μ_ubu=3.0) 는 mini 가 가득 찼을 때만 fallback. classical 결과 (Krishnamoorthy 1963 *Op. Res.* 11(2):321-330 'On Poisson Queue with Two Heterogeneous Servers'): steady-state aggregate λ_max = μ_mac + μ_ubu = 12.53 qps (additive 와 동일) · transient response time 만 감소. 반증자: cycle-29+ 실측 sustained throughput > 12.53 qps + 15% (= 14.41 qps) → predict 위반 (substrate 가 잠재 capacity 발견) — 또는 transient p50 < predicted ceiling-fraction → SED 효과 confirm."
  hyp     = "SED routing 은 steady-state aggregate λ_max 를 변화시키지 않음 (= homogeneous-extension 과 동일 ceiling) 하지만 transient p50 가 round-robin/random 보다 낮아짐 (mini 빈 슬롯 우선)"
  verdict = "PENDING — cycle-28 closed-form predict 만. 외부 anchor: Krishnamoorthy 1963 *Operations Research* 11(2):321-330 (2-heterogeneous-server Poisson queue 의 classical 닫힌형); Larsen & Agrawala 1983 *IEEE TSE* SE-9(2):189-197 (heterogeneous-server scheduling). 본 seed 는 N1 의 UPPER-bound predict variant."

@C d_ops_n1_dominated_slow_server_bound := "naive round-robin 이 ubu-1 (느린 호스트) 를 over-loading 시켜 aggregate λ_max < Σ μ_i 로 떨어뜨리는가" :: seed [verified_tier_target=YELLOW status=open]
  cmd     = "harness verify/numerics_ops_n1_heterogeneous_mmc.hexa — round-robin policy 분석: dispatch 가 (req_i mod 2 → host_i) 로 균등분배할 때 ubu-1 의 instantaneous load = λ/2. ubu-1 의 stability cap: λ/2 < μ_ubu = 3.0 → 글로벌 stable aggregate λ_max < 2·μ_ubu = 6.0 qps (느린 호스트가 bottleneck — mini 의 9.53 qps capacity 중 6.5 qps unused). 반증자: cycle-29+ 실측 aggregate λ_max 가 6.0 qps 근처 (±15% = [5.1, 6.9] qps) → round-robin 이 dominant policy (substrate 의 client-LB 가 naive). 또는 측정 ceiling 이 9.53–12.53 qps band → SED-or-better policy 사용 중."
  hyp     = "naive round-robin client-LB (cycle-22 skeleton 의 _dispatch_one 가 stub) 가 dominant 라면 aggregate λ_max ≈ 2·min(μ_i) = 6.0 qps · = homogeneous-extension predict 12.53 qps 의 절반 미만"
  verdict = "PENDING — cycle-28 closed-form predict 만. 외부 anchor: Whitt 1986 *Op. Res. Letters* 5(4):199-204 (deciding when to use single vs multi-server queues); Bolch et al. 2006 §6.3.2 (heterogeneous-channel with non-SED routing). 본 seed 는 N1 의 LOWER-bound predict variant — falsifier band 의 floor 를 정의."

# ════════════════════════════════════════════════════════════════════
# CROSS-CYCLE LINKAGE
# ════════════════════════════════════════════════════════════════════
# - cycle-16 M3.OPS full SLO grid (18 cells, single-UMA homogeneous fit, R²=1.0 on c·μ ceiling)
# - cycle-22 P3 2-host skeleton (`bench/sandbox_p3_multinode_2host.hexa`, parse-PASS only)
# - cycle-23 ubu-1 preflight (`inbox/notes/p3-ubu1-llama-cpp-install.md`, install paths probed)
# - cycle-24 ubu-1 install COMPLETE (PR #72, Option A CPU-only pre-built bin, GGUF transferred)
# - cycle-26 ECONOMICS C1 (12 dense + 1 MoE landings, distinct-family question seed)
# - cycle-27 ECONOMICS NOVEL 축 E (MoE-vs-dense scaling-law-family probe) — OPS N1 의 mirror
# - cycle-28 OPS NOVEL 축 N1 = cycle-27 E1 의 OPS analog (homogeneous-fit law 의 cross-substrate generalisation 측정)
# - cycle-28 first-probe (본 seed batch 의 cheapest) = closed-form 3-variant predict ($0, no substrate fire)
# - cycle-29+ actual fire = bench/sandbox_p3_multinode_2host.hexa LAN dispatch (mini + ubu-1)
#
# Honest residual (cycle-28):
# - μ_ubu = 3.0 qps 는 PREDICT (Option A CPU-only Q4_K_M Qwen2.5-0.5B llama.cpp upstream
#   bench 기반 추정), 측정값 아님. cycle-29+ fire 의 FIRST 측정 cell 이 mini 단독 c=1 +
#   ubu-1 단독 c=1 두 baseline 을 먼저 찍어야 본 verifier 의 μ_i input 이 calibrate.
# - 3 routing variant (homogeneous-additive · SED · dominated-slow) 의 closed-form predict 는
#   classical 결과 (Bolch · Krishnamoorthy · Whitt) 의 mechanical recompute — novel 발견 아님.
#   N1 의 NOVEL contribution 은 hexa-codex 의 SANDBOX 기질 (llama-server 2-host) 가 어느
#   variant 에 가까운가의 EMPIRICAL determination (cycle-29+).
# - cycle-22 skeleton 의 client-LB stub (_dispatch_one) 는 round-robin 가정이지만 미구현 —
#   cycle-29+ fire 진입 전 LB policy 를 명시적으로 select 해야 본 verifier 의 어느 predict
#   가 적용되는지 결정됨.
