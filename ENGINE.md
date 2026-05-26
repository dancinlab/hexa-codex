# ENGINE — discovery-to-execution driving lane (domain SSOT)

@title: ⚙️ ENGINE — 발견 → LLM 실행 자동 driving lane ("측정과 실행을 직접 잇는 frontier")
@goal: **다른 5 도메인의 NOVEL frontier (SANDBOX·ECONOMICS·SAFETY·OPS·SUBSTRATE) 의 verified findings 를 실제 LLM (lm_foundry · SANDBOX substrate · ubu-1 RTX 5070 · vast.ai pod) 의 학습·추론·serving 행동 변경 으로 자동 driving 하는 lane.** 발견 자체가 paper로 끝나는 게 아니라 다음 model run · 다음 inference path 에 직접 반영되도록 closed-loop discovery→execution pipeline 을 구축한다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]) — 발견 frontier 가 무한이므로 driving frontier 도 무한.

> Domain doc · dancinlab `domain-meta-domain` principle. The **6th orthogonal group** of the hexa-codex (verb-group 4개 + SANDBOX substrate + ENGINE driving). Current-state spec only; dated history → [`ENGINE.log.md`](ENGINE.log.md).
>
> **Falsifier class:** discovery → execution latency / fidelity — 발견 verdict 가 실제 LLM behavior 에 적용되는 시간 (latency) 및 적용된 결과가 발견과 일치하는 정도 (fidelity).

## North-star

ENGINE 은 hexa-codex 의 **measurement→execution closed-loop** 을 담당한다. 다른 5 도메인은 "측정 frontier" 이고, ENGINE 은 그 측정 결과를 **실제 LLM 행동 변경** 으로 wire 한다.

```
   측정 frontier              ENGINE driving             실제 LLM 행동
   ─────────────             ────────────             ─────────────
   ECONOMICS finding   ──▶  router weight adapt  ──▶  train/infer cost optimal
   SAFETY finding      ──▶  refusal direction    ──▶  inference time ablation
   OPS finding         ──▶  scheduler / routing  ──▶  serving μ heterogeneous-aware
   SUBSTRATE finding   ──▶  model selector       ──▶  family-confound-aware ladder
   SANDBOX finding     ──▶  bench harness auto   ──▶  next-cycle measurement gate
```

각 lane 은 verified verdict (🟢/🟡/🟠/🔴) 를 input 으로 받고, LLM behavior change 를 output 으로 emit. closed-loop 의 measurement 는 ENGINE 의 **자기 NOVEL axis (N)** 가 담당 — "discovery → execution latency 와 fidelity" 자체를 측정 대상으로 한다.

## 영구 축 (perpetual axes)

> ENGINE 은 완료되지 않는다. 측정 frontier 가 새 발견을 만들 때마다 driving lane 도 다시 열린다. 각 축은 `/cycle` 로 5 sibling 도메인 위에서 영구 전진 (`cx_empirical_contact` · `cx_lab_sandbox`).

### 축 A — ECONOMICS finding → train/infer router driving
> **driving target:** lm_foundry 의 `route_dispatch.hexa` + train-time scale decision.
- [x] A1 — ECONOMICS C1/E1 finding (modern dense overtrain · MoE active D/N) 을 router 가 자동 반영 → 어떤 prompt class 에 어떤 model tier (dense vs MoE vs distilled) 를 routing 할지 결정. 반증자: routing decision 이 cycle-27/29 finding 과 contradict (예: MoE 가 일관적 Chinchilla-hit 인데 router 가 dense 만 선택). **CYCLE-1 first wire (2026-05-27):** `engine/wire_a1_econ_e1_router_rule.hexa` + `verify/numerics_engine_a1_wire_econ_e1.hexa` ✅ 5/5 PASS · 🟢 SUPPORTED-NUMERICAL. cost_sensitive_chat top-1 = Granite-3-3B-A800M (MoE, dev=625 = 26× dense median, active=800M), max_quality_research top-1 = Llama3.1-405B (dense, top-tier). N1 first data point: ΔM=7 from E1 spawn (cycle-27→ENGINE cycle-1), ΔM=0 from E1 mature (cycle-34 PARITY→ENGINE cycle-1 same session). **frontier OPEN** — 이 wire 는 E1 의 첫 finding-mature 반영이지 A1 axis 종료 아님; ECONOMICS 가 새 finding 을 발견하면 router rule 재-wire 필요.

### 축 B — SAFETY finding → inference-time intervention driving
> **driving target:** SANDBOX serving stack (llama-server · transformers HF) 의 inference time refusal direction projection-out.
- [x] B1 — SAFETY cycle-19/20 의 refusal direction (L19 difference-of-means) 을 SANDBOX serving 에 inference time intervention 으로 wire (Arditi-style `h ← h − (h·r̂)r̂` projection-out). 반증자: wired intervention 의 refusal-rate 변화가 cycle-19 측정값 (95%→0%) 과 ±10pp 이상 deviation. **CYCLE-2 SPEC wire (2026-05-27):** `engine/wire_b1_safety_refusal_intervention.hexa` + `verify/numerics_engine_b1_wire_safety.hexa` ✅ 6/6 PASS · 🟢 SUPPORTED-NUMERICAL. SPEC = (layer=19, direction=diff_of_means, intervention=projection_out, rank=1, expected adv_after≤10pp, benign≤10pp, source_model=qwen2.5-1.5b-instruct). **runtime application 는 cost-bearing — cycle-3+ deferred** (llama-server inference-hook on SANDBOX). N1 second data point: ΔM_after_mature ≈ 14 cycles (vs A1 의 0 cycles = same-session). **frontier OPEN** — Qwen-specific 인지 cross-family universal 인지 SAFETY N1 axis 가 spawning 중; 닫히면 wire scope 재정의 필요.

### 축 C — OPS finding → multi-node scheduler driving
> **driving target:** SANDBOX pool dispatch (mini + ubu-1 LAN) 의 routing policy.
- [ ] C1 — OPS cycle-16 M/M/c knee + cycle-28 NOVEL N1 (heterogeneous-μ) finding 을 multi-node scheduler 가 반영 → SED routing 또는 weighted-round-robin 자동 선택. 반증자: scheduler 가 dominant-slow-server (Whitt 1986) variant 와 일치 — single-UMA formula 만 사용.

### 축 D — SUBSTRATE finding → model selection driving
> **driving target:** SANDBOX bench manifest 의 model rung selection.
- [ ] D1 — SUBSTRATE cycle-23c POSITIVE + cycle-28 NOVEL N1 (family-vs-scale gap 0.49) finding 을 bench harness 가 자동 반영 → family-confound-aware rung selection (Qwen 만 ladder 가 아니라 non-Qwen 비례 포함). 반증자: bench 가 cycle-28 finding 무시 (Qwen-only rung 으로 capability claim).

### 축 E — SANDBOX measurement → next-cycle gate driving
> **driving target:** SANDBOX 의 next-cycle bench harness 자동 generation.
- [ ] E1 — SANDBOX cycle-28 NOVEL N1 (cross-substrate reproducibility 🟠) finding 이 next-cycle 50-item TIME-CAPPED 5-rung harness 를 자동 generate (현재 manual). 반증자: 자동 generated harness 가 cycle-24 partial 의 statistical confound 를 그대로 재생산.

### 축 N — 🆕 NOVEL: discovery → execution closed-loop latency (ENGINE 메인, ⭐ MAIN priority lane)
> **⭐ MAIN priority lane** (ENGINE 의 self-NOVEL axis). 다른 5 axis 의 *driving 자체를 측정* 하는 meta-axis. measurement frontier 가 발견을 만든 시점부터 그 발견이 실제 LLM behavior change 로 wire 된 시점까지 의 시간 (latency) + 적용된 결과의 fidelity (발견값 ↔ wired-behavior 일치율).
- [ ] N1 — discovery→execution **latency** 측정 baseline 수립: 각 sibling NOVEL axis 의 cycle N 결과 → ENGINE 적용된 cycle M 까지 ΔM 측정 (현재 모두 manual ∞). 반증자: 측정 cycle ↔ ENGINE wire cycle 간격이 5 cycle 초과 → human-in-loop 가 bottleneck 임을 quantify (자동화 필요 신호). 외부 anchor: closed-loop optimization 분야 (Snoek 2012 Bayesian optimization · Sutton 1988 TD learning).

## Sibling 도메인 finding intake matrix (consumer 입장 reverse)

ENGINE 은 5 sibling 의 verdict 를 input 으로 받음. 각 sibling 의 SANDBOX 활용 section 의 역방향.

| sibling | 가장 강한 cycle-21~29 finding | ENGINE driving axis |
|---------|------------------------------|---------------------|
| ECONOMICS | cycle-27 E1 + cycle-29 batch 2 (MoE active vs dense, n=3 directional 🟠) | A1 router |
| SAFETY | cycle-19/20 refusal direction AUROC=0.98 + causal ablation 95%→0% | B1 inference intervention |
| OPS | cycle-16 M/M/c + cycle-28 N1 heterogeneous-μ predict 🟡 | C1 multi-node scheduler |
| SUBSTRATE | cycle-23c 7B counting=5/5 + cycle-28 N1 family-vs-scale gap 0.49 🟢 | D1 model selector |
| SANDBOX | cycle-28 N1 cross-substrate reproducibility 🟠 + 25/25 first-arc | E1 next-cycle harness gen |

## Dispatch surface (ENGINE 의 wire targets)

| surface | wired target | wiring path |
|---------|--------------|-------------|
| `lm_foundry/tool/route_dispatch.hexa` | train/infer model selection | A1 (ECONOMICS) · D1 (SUBSTRATE) |
| SANDBOX `llama-server` inference-time hooks | refusal direction projection-out | B1 (SAFETY) |
| `pool` multi-host dispatcher | SED / weighted-round-robin scheduler | C1 (OPS) |
| `bench/sandbox_*.hexa` generators | manifest + rung selection | E1 (SANDBOX) |

## Honesty invariants

- **driving ≠ paper.** ENGINE 의 verdict 는 "finding 이 wire 되었는가" 와 "wired-behavior fidelity" 이지, finding 의 truth 자체가 아니다 (그건 sibling 의 책임).
- **closed-loop latency 는 ENGINE 의 SELF-MEASUREMENT.** N1 axis 는 ENGINE 자신의 진행 속도를 측정 — 다른 5 axis 가 "다른 도메인 driving" 인 반면 N1 은 "내가 얼마나 늦었나" 자체.
- **frontier perpetual.** 5 axis 의 [x] flip 은 한 finding 의 driving close 이지 frontier 종료 아님. 새 finding → 새 driving = 새 axis cell 추가.
- **자기-strawman 회피.** ENGINE 의 N1 도 외부 anchor 인용 (Snoek 2012 Bayesian opt · Sutton 1988 TD-learning).

## Cross-refs

- 5 sibling 도메인: [`ECONOMICS.md`](ECONOMICS.md) · [`SAFETY.md`](SAFETY.md) · [`OPS.md`](OPS.md) · [`SUBSTRATE.md`](SUBSTRATE.md) · [`SANDBOX.md`](SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 호스트 인프라: [[reference_host_topology]] (mini · ubu-1 · ubu-2 · pi5-akida) · [[reference_runpodctl_cli]] · [[reference_vastai_cli]]
- closed-loop precedent: Snoek 2012 Bayesian opt · Sutton 1988 TD-learning (외부 anchor)
