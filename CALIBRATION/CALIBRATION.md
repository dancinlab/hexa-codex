# CALIBRATION — 신뢰도 자판기

@title: 📏 CALIBRATION — "신뢰도 자판기"
@goal: **모델 confidence 와 실제 정답률의 일치도를 영구 측정·교정하는 lane.** 새 모델·task·temperature regime 가 등장할 때마다 측정 frontier 가 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Candidate sibling from [`AXIS.easy.md`](../AXIS.easy.md) (브레인스토밍 ⭐⭐⭐). ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** ECE > 0.1 OR systematic over-confidence → confidence ≠ 정답률
>
> **Sibling parallel:** SUBSTRATE 는 '맞히는가' 측정, CALIBRATION 은 '틀릴 때 모르는 척 잘 하는가' — 직각 차원

## North-star

모델이 자기 답에 얼마나 확신하는지 vs 실제 정답률이 일치하는지 측정. 일기예보 '비 올 확률 70%' 가 실제로 70번 중 70번 맞아야 calibrated.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> CALIBRATION 은 완료되지 않는다. 새 모델·task·temperature regime 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — first probe (closed-form baseline)
- [x] A1 — ECE (Expected Calibration Error) closed-form 측정 (per-task) + reliability diagram. 반증자: ECE > 0.1 OR systematic over-confidence → confidence ≠ 정답률. **CYCLE-9 round-1 wire (2026-05-28):** `CALIBRATION/bench/calibration_a1_ece_formula.hexa` + `CALIBRATION/verify/numerics_calibration_a1_ece_formula.hexa` ✅ 7/7 PASS · 🟢 SUPPORTED-NUMERICAL. Formula: ECE = Σ_b (n_b/N)·|acc_b−conf_b| (Naeini 2015 AAAI · Guo 2017 ICML); integer ×100 ledger (closed-form, libm-free). worked examples: ex1 perfectly-calibrated 10-bin (N=100) → ECE_x100=**0** ✓ · ex2 systematically over-confident conf=90 acc=50 (N=100) → ECE_x100=**40** (falsifier > 10 fires) ✓ · ex3 mild miscal two bins |diff|=4 each (N=100) → ECE_x100=**4** ✓. core falsifier held: 반증자 (ECE > 0.1 → confidence ≠ 정답률) ex2 에서 정확히 fires, perfect-cal ex1 에서 정확히 silent — bidirectional discrimination. external anchor: Naeini 2015 (original ECE) · Guo 2017 (modern over-conf > 0.1) · Kuleshov 2018 (uncertainty regression). **per-model ECE substrate fire deferred — cost-bearing** (mac M3 local llama-server / ubu-1 HF transformers · MMLU/GSM8K logprob extraction · A1 measured-tier upgrade). honest residual: integer ×100 ledger truncates per-bin acc/conf at .01 (coarser than literature float ECE 3-4 sig figs) — acceptable for falsifier semantics, not fine-grained model comparison. **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — closed-form formula 만 닫음; 새 모델·task·temperature regime 마다 A1 measured cell 재오픈. 축 N (temperature commutativity) 가 다음 ⭐ MAIN priority lane.

### 축 B — second probe (measured ladder)
- [ ] B1 — MMLU·GSM8K 등 표준 벤치에서 confidence bin 별 acc fit + scale ladder cross-model. 반증자: 여러 모델 scale 에서 ECE 가 monotone-improve 안 함 → scale 만으로 calibration 미해결.

### 축 N — 🆕 NOVEL: temperature-vs-calibration commutativity (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — CALIBRATION 의 self-NOVEL axis. sampling temperature 와 calibration 이 commute 하는가 — T=1 calibrated 면 T=0.7 도 calibrated 인가. 외부 anchor: Guo 2017 temperature scaling · Platt scaling · Kuleshov 2018 accurate uncertainty.
- [ ] N1 — T ∈ {0.0, 0.5, 0.7, 1.0, 1.2} 별 ECE 변화 fit · closed-form. 반증자: T=0.7 ECE vs T=1.0 ECE 차이 > 0.05 → non-commutative → per-T re-calibrate 필요.

## SANDBOX 활용 (measurement substrate)

CALIBRATION 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `.verdicts/CALIBRATION/a1_*` |
| B1 ladder | SANDBOX bench harness | `.verdicts/CALIBRATION/b1_*` |
| N1 ⭐ NOVEL | mac M3 / vast.ai pod | `.verdicts/CALIBRATION/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| inference temperature/top-p auto-tune | abstention threshold · per-task temperature 결정 · uncertainty-gated output | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **CALIBRATION 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../ECONOMICS.md`](../ECONOMICS.md) · [`../NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md)
- this domain: [`CALIBRATION.md`](CALIBRATION.md) (snapshot) · [`CALIBRATION.log.md`](CALIBRATION.log.md) (history)
