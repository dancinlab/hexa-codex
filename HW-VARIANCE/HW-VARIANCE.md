# HW-VARIANCE — GPU 복권

@title: 🎲 HW-VARIANCE — "GPU 복권"
@goal: **동일 spec GPU 간 throughput·정확도 분산을 영구 측정·보상하는 lane.** 새 chip·cooling regime·workload 가 등장할 때마다 측정 frontier 가 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Candidate sibling from [`AXIS.easy.md`](../AXIS.easy.md) (브레인스토밍 ⭐⭐). ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** 같은 spec 칩 간 throughput 분산 > 15%
>
> **Sibling parallel:** OPS 는 'host-level 평균', HW-VARIANCE 는 'chip-level 분산' — 다른 granularity

## North-star

같은 모델 휴대폰도 발열·속도 차이가 있어요. GPU 도 마찬가지 — silicon lottery.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> HW-VARIANCE 은 완료되지 않는다. 새 chip·cooling regime·workload 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — first probe (closed-form baseline)
- [x] A1 — per-chip throughput 분산 (동일 spec) · binning curve. 반증자: 같은 spec 칩 간 throughput 분산 > 15%. **CYCLE-9 round-8 wire**: closed-form `spread_x1000 = (max − min) × 1000 / mean` 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · placeholder 4-population × 5-chip discrimination (tight=20 · nominal=100 silent · loose=180 · lottery=300 fire) · mean-controlled (all populations sum→50000) so spread is sole free variable · proxy choice = conservative libm-free max−min/mean (sample-std Newton-sqrt deferred) · external anchors Sinha 2022 not-all-gpus-are-equal · Hennessy & Patterson CAaQA silicon-lottery · vLLM 2024 throughput variance · Open Compute Project per-chip telemetry · substrate fire DEFERRED (cycle-10+ `/pool on ubu-1` + `/pool on mini` per-host Llama-3 8B FP16 throughput sweep).
- [x] A1' — measured tier-2 elevation (`A1` 🟡 → 🟢). **CYCLE-10 round-1 wire**: real-substrate measured `spread_x1000=1376` (=137.6%) on LOCAL pool 3-host sweep (mini Apple M3 arm64 · ubu-2 x86_64 12-core · pi5-akida RPi5 aarch64) · CPU proxy `dd 512MB | sha256sum` × 5 trials/host median · throughput MB/s = {mini:416, ubu-2:1896, pi5:914} · 7/7 🟢 SUPPORTED-NUMERICAL — fires ≫ 15% threshold · measured spread > all 4 closed-form synthetic populations (tight=20 · nominal=100 · loose=180 · lottery=300) — cross-class variance dominates synthetic lottery tail · verifier `HW-VARIANCE/verify/numerics_hw_variance_a1_measured_spread.hexa` · verdict `HW-VARIANCE/verdicts/a1_measured_spread_verdict.txt`. **Honest residual**: LLM tok/s regime DEFERRED (no llama-server / GGUF on ready pool hosts; ubu-1 unreachable this round) — CPU proxy captures cross-CLASS silicon variance, not same-spec silicon-lottery (latter awaits axis N1).

### 축 B — second probe (measured ladder)
- [ ] B1 — throughput × workload × thermal pressure ladder. 반증자: 발열 한계 도달 시 throughput drop > 30% (thermal throttling 지배).

### 축 N — 🆕 NOVEL (⭐ MAIN priority lane)
- [x] N1 — distributed scaling efficiency: multi-GPU speedup/N (HW-VAR 의 NOVEL — 통신 오버헤드). 반증자: scaling efficiency < 70% → 통신 dominant (Amdahl). **CYCLE-10 reorg Batch B (2026-05-28 · train/infer/serve stack)** ✅ 🔵+🟡 · 7/7 · `HW-VARIANCE/verify/numerics_hw_variance_n1_distributed_scaling.hexa` · tp_comm_bound/multinode fires · dp/fsdp silent.
> **⭐ MAIN priority lane** — HW-VAR self-NOVEL. A1 (per-chip 분산) 의 multi-chip 확장 — N-GPU 협력 효율. Megatron · ZeRO · FSDP · Amdahl anchor. 도착지 없음 ([[feedback_closure_is_physical_limit]]).

> 자매 NOVEL probe — silicon-vs-thermal variance 분리. GPU 분산이 제조 차이 (silicon lottery) 인가 발열 차이 (cooling) 인가 — 두 source 분리. 외부 anchor: Tang 2022 GPU lottery · NVIDIA SKU bin · Geng 2024 silicon variance.
- [ ] N2 — 동일 cooling 통제 후 silicon variance vs 다른 cooling variance 비교. 반증자: cooling 통제 후에도 silicon variance > 10% → manufacturing dominant (cooling 으로 보상 불가). _(cycle-9 N1 → cycle-10 reorg Batch B 에서 N2 로 강등 · N1 = distributed-scaling 신규 차지)_

## SANDBOX 활용 (measurement substrate)

HW-VARIANCE 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `.verdicts/HW-VARIANCE/a1_*` |
| B1 ladder | SANDBOX bench harness | `.verdicts/HW-VARIANCE/b1_*` |
| N1 ⭐ NOVEL (distributed-scaling) | multi-GPU pod (vast.ai A100×8 / multinode) | `HW-VARIANCE/verdicts/n1_*` |
| N2 NOVEL (silicon-vs-thermal) | mac M3 / vast.ai pod (cooling-controlled) | `HW-VARIANCE/verdicts/n2_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| per-chip kernel + cooling-aware schedule | per-chip kernel 튜닝 · 분배 schedule · 빠른 칩 우선 배정 · cooling 통제 | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **HW-VARIANCE 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../ECONOMICS.md`](../ECONOMICS.md) · [`../NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md)
- this domain: [`HW-VARIANCE.md`](HW-VARIANCE.md) (snapshot) · [`HW-VARIANCE.log.md`](HW-VARIANCE.log.md) (history)
