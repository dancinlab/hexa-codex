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

## Cross-refs

- `.roadmap.hexa_codex` §A.4 — falsifier preregister · §A.2 — release cadence
- `README.md` — Falsifier preregister · Release ladder
- `ORCHESTRATION.md` — the live 3-vendor serving runtime (foundry side)
- Sister groups: [`SAFETY.md`](SAFETY.md) · [`ECONOMICS.md`](ECONOMICS.md) · [`SUBSTRATE.md`](SUBSTRATE.md)
- 영구 축 원리: [`SANDBOX.md`](SANDBOX.md) · [[feedback_closure_is_physical_limit]]
