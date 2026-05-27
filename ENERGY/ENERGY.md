# ENERGY — 토큰당 배터리

@title: 🔋 ENERGY — "토큰당 배터리"
@goal: **학습·추론·서빙의 에너지 소모를 watt·joule 단위로 영구 측정·최적화하는 lane.** 새 HW (CPU/GPU/NPU)·kernel·model arch 가 등장할 때마다 측정 frontier 가 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Candidate sibling from [`AXIS.easy.md`](../AXIS.easy.md) (브레인스토밍 ⭐⭐⭐). ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** tokens/J 가 SOTA 모델 대비 2배 초과 → 비효율 모델/구현
>
> **Sibling parallel:** OPS 는 '초당 처리량' (시간 차원), ENERGY 는 '같은 처리량의 비용' (에너지 차원) — 직각

## North-star

토큰 1개당 전기 얼마. 자동차 연비처럼 같은 거리 가는데 어느 모델이 덜 먹나.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> ENERGY 은 완료되지 않는다. 새 HW (CPU/GPU/NPU)·kernel·model arch 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — first probe (closed-form baseline)
- [x] A1 — RAPL (CPU) · NVIDIA-smi (GPU) 로 tokens/J at fixed task 측정. 반증자: tokens/J 가 SOTA 모델 대비 2배 초과 → 비효율 모델/구현. **CYCLE-9 round-1 first probe (2026-05-28):** `ENERGY/bench/energy_a1_tokens_per_joule.hexa` + `ENERGY/verify/numerics_energy_a1_tokens_per_joule.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL (closed-form identity 6/7) + 🟡 BY-CITATION (SOTA floor 1/7). Identity tokens/J = N_tokens / E_total[J] where E_total = ∫P(t)dt ≈ Σ P_k·Δt_k ≈ mean_W·T (Riemann ↔ mean-power bit-identical, |Δ|=0 mJ). Worked example 200 W · 60 s · 480 tok → 12 000 J → 0.040 tok/J > 0.025 floor. Linearity (2× N → 2× tok/J) + inverse (2× E → ½ tok/J) closed-form. **Real RAPL + NVIDIA-smi 측정 = COST-BEARING, deferred** to a separate cycle on ubu-1 (RTX 5070 + 13900K, per-task fixture); macOS Mx 는 `bench/bitnet_m6_energy_per_token.hexa` 의 powermetrics recipe 재사용. External anchors: Patterson 2021 (arXiv:2104.10350) · Strubell 2019 (arXiv:1906.02243) · Schwartz 2020 (arXiv:1907.10597). **frontier OPEN** (feedback_closure_is_physical_limit) — instrumentation close ≠ measurement close; 새 HW (CPU/GPU/NPU) 등장 시 axis 재오픈.

### 축 B — second probe (measured ladder)
- [ ] B1 — model scale · quant tier · batch size × tokens/J fit (Pareto frontier). 반증자: quant int4 의 energy 절감 < 30% vs fp16 → quant 의 energy 이득 marginal.

### 축 N — 🆕 NOVEL (⭐ MAIN priority lane)

- [x] N1 — MoE active-param efficiency · "MoE free lunch" 신화 검증 (ENERGY 의 NOVEL — sparse activation 으로 연산 절감). 반증자: same-active-param dense 보다 MoE ≥ 1.2× 못함. **CYCLE-10 reorg (2026-05-28 · FRONTIER F1 흡수)** ✅ 🔵+🟡 · 7/7 PASS · `ENERGY/verify/numerics_energy_n1_sparse_moe_active_premium.hexa` · active_premium=982/1000 (Gemma 4 E4B 675 vs 26B/A4B 663) → 🔴 myth FALSIFIED in family · synthetic strong-MoE silent.

> **⭐ MAIN priority lane** — ENERGY 의 self-NOVEL. dense 전체 활성화 대비 MoE sparse routing 의 연산-효율. Gemma 4 26B/A4B · arXiv:2604.07035 anchor. 도착지 없음 ([[feedback_closure_is_physical_limit]]).

- [ ] N2 — per-layer energy decomposition (이전 N1 · cycle-10 reorg 로 N2 강등). 전체 watt 가 아니라 layer/component 별 watt 가 어디 집중 — attention vs FFN vs embedding. 반증자: attention/FFN/embed 의 energy 분포가 FLOP 분포와 ε > 20% 불일치 → memory-bound 영역 존재. 외부 anchor: Patterson 2021 carbon footprint · Strubell 2019 energy NLP · Schwartz 2020 Green AI.

## SANDBOX 활용 (measurement substrate)

ENERGY 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `.verdicts/ENERGY/a1_*` |
| B1 ladder | SANDBOX bench harness | `.verdicts/ENERGY/b1_*` |
| N1 ⭐ MAIN (MoE active-premium · ex-FRONTIER F1) | mac M3 GGUF Gemma 4 / vast.ai pod | `ENERGY/verdicts/n1_*` |
| N2 (per-layer energy decomp) | mac M3 / vast.ai pod | `ENERGY/verdicts/n2_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| kernel/quant tier per-layer | power-aware batch · DVFS schedule · region-time routing · per-layer quant tier | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **ENERGY 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter (H, I, J, ...) 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: tokens/J 가 SOTA 모델 대비 2배 초과 → 비효율 모델/구현
> **Anticipated ENGINE behavior wire**: tokens-per-J budget aware model selection · energy-efficient kernel pick
> **Status path**: [`../CALIBRATION/CALIBRATION.md`](../CALIBRATION/CALIBRATION.md) ← reference 패턴 (cycle-10 round-1 promoted to ENGINE axis G).

> ⏸ DEFERRED waiting on cycle-10+ T4 measured fire.

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../ECONOMICS.md`](../ECONOMICS.md) · [`../NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md)
- this domain: [`ENERGY.md`](ENERGY.md) (snapshot) · [`ENERGY.log.md`](ENERGY.log.md) (history)
