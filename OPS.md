# OPS — hexa-codex ops verb group (domain SSOT)

@title: ⚙️ OPS — 서빙 SLO 영구 측정 lane ("멈추지 않는 큐잉/배포 frontier")
@goal: **모델 서빙의 SLO(throughput·latency·schema·tool-use)를 SANDBOX 기질에서 preregistered falsifiable 하게 영구 측정하는 lane.** v1.4.0(M/M/c knee surface, 18-cell grid, Erlang-C 닫힌형 적합)은 단일 호스트 첫 arc 의 종결일 뿐 — multi-node·실트래픽·새 하드웨어 tier 가 등장할 때마다 SLO frontier 는 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Domain doc · dancinlab `domain-meta-domain` principle. One of the
> **4 orthogonal groups** of the hexa-codex 17-verb AI knowledge
> substrate. Current-state spec only; dated history →
> [`OPS.log.md`](OPS.log.md).
>
> **Falsifier class:** SLO checks — deployment-tier recipes, tool-use
> service-level objectives, eval-handoff schema conformance.

## North-star

The OPS group is the **4-verb operations surface** of the codex: once a
model exists, how is it deployed, customised for an enterprise, served
as a tool-using agent, and handed off to an eval pipeline? Each verb is
a closed-form operational envelope + falsifier preregister; the
falsifiers here are SLO checks rather than scaling laws.

> Note: OPS is the runtime/serving counterpart **inside the codex spec
> library**. The live 3-vendor serving runtime that wraps the foundry's
> code specialist is a separate domain — see [`ORCHESTRATION.md`](ORCHESTRATION.md).

## Verbs (4)

| Verb | Spec | Role |
|------|------|------|
| `deploy` | [`deploy/ai-deployment.md`](deploy/ai-deployment.md) | hardware-tier deployment recipes |
| `enterprise` | [`enterprise/ai-enterprise-custom.md`](enterprise/ai-enterprise-custom.md) | enterprise customisation envelope |
| `agent_serving` | [`agent_serving/ai-agent-serving.md`](agent_serving/ai-agent-serving.md) | tool-use SLO + schema |
| `eval` | [`eval/ai-eval-pipeline.md`](eval/ai-eval-pipeline.md) | Mk-handoff eval template |

## Falsifiers

OPS owns **none of F-CODEX-1..4** (those belong to economics + safety
verbs). Its falsifier class is **per-verb SLO checks** — each verb spec
ships its own preregistered service-level threshold (latency, schema
conformance, refusal-correctness handoff).

The v1.3.0 ops release is also the empirical-landing window for
**F-CODEX-2** (`infer_cost`, owned by [`ECONOMICS.md`](ECONOMICS.md)) —
inference economics are measured once real serving recipes exist.

## n=6 projection

This group is one of the **τ(6) = 4** quadrants of the codex taxonomy —
specifically the **deploy** lifecycle phase of the τ-quartet
(pretrain / SFT / RLHF / **deploy**).

## State (v1.0.0 — RELEASED)

Spec-first: all 4 verbs ship a written operational envelope + falsifier
preregister. **0 verbs wired**, **0 eval pipelines**. No F-CODEX
arithmetic floor applies; per-verb SLO falsifiers are preregistered,
empirical conformance PENDING.

## Roadmap — v1.3.0 (2026-12, PLANNED · group focus = ops)

- 9 verbs wired cumulative · 3 eval pipelines.
- **F-CODEX-2 empirical landing** — inference-cost `context^4` fit.
- DoD (`.roadmap.hexa_codex` §0): ops group deploy + agent-serving
  integrated `.hexa`.

## 영구 축 (perpetual axes)

> OPS 는 완료되지 않는다. v1.4.0 의 M/M/c knee 는 단일 UMA 호스트·합성 Poisson 부하에서의
> 첫 arc 이고, SLO frontier 는 분산·실트래픽·새 하드웨어가 등장할 때마다 다시 열린다.
> 각 축은 `/cycle` 로 SANDBOX(우리가 소유한 serving 프로세스) 위에서 영구 전진.

### 축 A — multi-node / 분산 SLO
> v1.4.0 knee 는 단일 호스트. Erlang-C 가 multi-replica + 실네트워크에서도 성립하는가.
- [ ] A1 — 2+ replica 서빙 + load-balancer 측정 → c·μ 처리량 ceiling 이 노드수에 선형인가. 반증자: 분산 처리량 < Σ 단일노드 μ (네트워크/조정 오버헤드 지배).

### 축 B — 실트래픽 trace replay (vs 합성 Poisson)
- [ ] B1 — bursty/heavy-tailed 도착 trace 재생 → knee 위치가 Poisson 가정과 일치하는가. 반증자: 동일 평균 rate 에서 p99 가 Poisson 예측의 2× 초과.

### 축 C — tool-use agent SLO 루프 (`agent_serving` verb)
- [ ] C1 — multi-turn tool-call latency budget + schema-conformance SLO 측정. 반증자: schema-conformance rate < preregistered threshold.

### 축 D — deploy-tier envelope (`deploy` verb · roofline %)
> 물리 한계 표현 = 하드웨어 tier 별 roofline %.
- [ ] D1 — GPU class(A100/5070/Metal-UMA) 별 mem-bw roofline 대비 달성 token/s % 측정. 닫힘 = roofline %, 100% 아님.

### 축 N — 🆕 NOVEL: heterogeneous-μ multi-node Erlang-C divergence (cycle-28, ⭐ MAIN priority lane)
> cycle-16 M/M/c single-UMA fit (3 np × 6 rate, μ_eff ∈ {9.53, 7.505, 5.0} req/s/slot, ceiling=c·μ R²=1.0) 가 단일 호스트·*동일 μ* 가정 위에 닫혔다. cycle-22 skeleton + cycle-24 ubu-1 install 완료 (PR #72) 로 mini (Metal/UMA) + ubu-1 (x86 CPU, RTX 5070 sm_120 미사용) 2-host 경로가 열렸다. 두 호스트는 *radically* heterogeneous μ — mac M3 Metal UMA vs Linux x86 CPU-only (Option A pre-built bin, no CUDA). **공개 이론 질문:** classical M/M/c (homogeneous μ) 식이 heterogeneous μ_i 에서도 성립하는가, 아니면 별개 family (Bolch 2006 §6.3 heterogeneous-channel · shortest-expected-delay routing · dominated-by-slow-server) 인가? ECONOMICS 축 E (cycle-27, MoE-distinct-family 질문) 의 OPS analog — homogeneous-fit law 의 cross-substrate generalisation 측정 axis.
- [ ] N1 — heterogeneous-μ aggregate Erlang-C 분리 측정: cycle-16 single-UMA fit (μ_eff ∈ {9.53, 7.505, 5.0}) + cycle-24 P3 ubu-1 install host-spec (180 tok/s ≈ ~3 qps CPU-only Q4_K_M predict) 에서 per-server μ_i 도출 → homogeneous M/M/c 가정 하 aggregate λ_max 예측 (Σ μ_i / N · arithmetic mean) vs heterogeneous routing variants (shortest-expected-delay · slow-server-bound · round-robin) 예측 emit. 반증자: cycle-29+ 2-host fire (`bench/sandbox_p3_multinode_2host.hexa`) 에서 measured aggregate throughput 가 homogeneous-c·μ̄ 예측의 ±15% 밖이면 heterogeneous family 필요 — shortest-expected-delay 상한 > 측정 > slow-server-bound 하한 외부면 OS-level scheduler 영향 분리 필요. 외부 anchor: Bolch et al. 2006 *Queueing Networks and Markov Chains* (2nd ed., §6.3 heterogeneous-channel M/M/c), Kleinrock 1975 *Queueing Systems Vol. I* §3.5 (multi-server stability), Krishnamoorthy 1963 "On Poisson Queue with Two Heterogeneous Servers" *Operations Research* 11(2):321-330. cycle-28 first-probe = closed-form recompute only (no substrate fire); cycle-29+ actual fire = P3 2-host harness with explicit per-server throughput measurement.

## SANDBOX 활용 (consumer 입장)

OPS 의 SLO · queueing · serving 측정은 SANDBOX 위에서만 — API surface 가 serving process + per-request scheduling 숨김.

### 측정 axis (SANDBOX Readiness Matrix OPS row 1:1)

| axis | harness | model | verdict path |
|------|---------|-------|--------------|
| -np 별 처음 p50/p99 | `bench/sandbox_stage4_slo_under_load.hexa` | Qwen2.5-0.5B (port 8090) | `.verdicts/sandbox/stage4_slo_under_load_*` |
| full SLO grid (3 np × 6 rate) | `bench/sandbox_stage4_slo_full_grid.hexa` | Qwen2.5-0.5B (Stage-2 N=2000) | `.verdicts/sandbox/m3_ops_full_slo_grid*` |
| M/M/c knee 검증자 | `verify/numerics_ops_mmc_knee.hexa` | (recompute only) | `.verdicts/sandbox/m4_ops_formula_fit.txt` |
| 분산 replica Erlang-C (P3, **ubu-1 install 완료** PR #72) | `bench/sandbox_p3_multinode_2host.hexa` + `inbox/notes/p3-ubu1-llama-cpp-install.md` | mini + ubu-1 (cycle-25 fire) | `.verdicts/sandbox/p3_multinode_2host*` |

### Dispatch surface

| topology | scope | invocation | 활성 |
|----------|-------|-----------|------|
| single-host | mini local (Metal/UMA, port 8090) | `bench/sandbox_stage4_slo_*.hexa` 직접 fire | ✅ |
| multi-host | mini + ubu-1 LAN `192.168.50.119` (RTX 5070 호스트, llama-server pre-built bin 설치 PR #72) | `hexa.real run bench/sandbox_p3_multinode_2host.hexa` (LAN dispatch) | ✅ install 완료 (tailscale `:8090` timeout 알려진 잔여 — LAN 경로로 우회) |

### Quick-fire commands (cycle-25 entry points)

| lane | 진입 명령 | 추정 |
|------|-----------|------|
| P3 2-host pilot fire | `hexa.real run bench/sandbox_p3_multinode_2host.hexa` (LAN 192.168.50.119) | $0, ~30분 |
| multi-rate 24-cell expanded grid | `bench/sandbox_stage4_slo_full_grid.hexa` 변형 (rate sweep ↑) | $0, ~1–2h |
| np=8 ceiling probe | `bench/sandbox_stage4_slo_under_load.hexa` (`-np 8` 추가 rung) | $0, ~30분 |

### Honest invariant

위 lane 의 fire-readiness 는 **현재 arc 의 진입 활성** 신호일 뿐 frontier closure 가 아님. SLO/queueing frontier 는 새 host topology (multi-node → multi-rack) · 새 serving stack (vLLM PagedAttention · slice-scheduling) · 새 GPU class 가 등장할 때마다 다시 열린다 (`## 영구 축` 축 A–D, [[feedback_closure_is_physical_limit]]). readiness ≠ frontier closure.

### Cross-link

- [`SANDBOX.md`](SANDBOX.md) "## Substrate Readiness Matrix" → OPS row (4 axes SSOT)
- `inbox/notes/p3-ubu1-llama-cpp-install.md` — P3 unblock runbook (cycle-23 preflight + cycle-24 install 완료 PR #72)

## Cross-refs

- `.roadmap.hexa_codex` §A.4 — falsifier preregister · §A.2 — release cadence
- `README.md` — Falsifier preregister · Release ladder
- `ORCHESTRATION.md` — the live 3-vendor serving runtime (foundry side)
- Sister groups: [`SAFETY.md`](SAFETY.md) · [`ECONOMICS.md`](ECONOMICS.md) · [`SUBSTRATE.md`](SUBSTRATE.md)
- 영구 축 원리: [`SANDBOX.md`](SANDBOX.md) · [[feedback_closure_is_physical_limit]]
- SANDBOX consumer 표: 본 도메인 `## SANDBOX 활용 (consumer 입장)` (sibling: [`ECONOMICS.md`](ECONOMICS.md) · [`SAFETY.md`](SAFETY.md) · [`SUBSTRATE.md`](SUBSTRATE.md))
