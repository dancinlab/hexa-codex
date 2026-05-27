# CODEX — log

Append-only history sister of `CODEX.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — cycle-9 round-1: 3 closed-form A1 wires (CALIBRATION + CONTAMINATION + ENERGY)

`/cycle-bg` round-1 (cap=3 batch · bg agent fan-out · worktree isolation). 3 agent 모두 build phase 완료 (closed-form / citation tier) — 실측 substrate fire 는 cost-bearing 으로 별 라운드 deferred.

| axis | tier | checks | branch | verifier |
|---|---|---|---|---|
| CALIBRATION/A1 | 🟢 SUPPORTED-NUMERICAL | 7/7 | `worktree-agent-a428d9e9c06e915ee` | `CALIBRATION/verify/numerics_calibration_a1_ece_formula.hexa` |
| CONTAMINATION/A1 | 🔵 STRUCTURAL + 🟡 BY-CITATION | 6/6 | `worktree-agent-aa9c17f68fe2cd07f` | `CONTAMINATION/verify/numerics_contamination_a1_ngram_ratio.hexa` |
| ENERGY/A1 | 🔵 STRUCTURAL + 🟡 BY-CITATION | 7/7 | `agent/energy-a1-cycle9` | `ENERGY/verify/numerics_energy_a1_tokens_per_joule.hexa` |

### Build phase 출력 (각 도메인)

- **CALIBRATION** — ECE closed-form `Σ_b (n_b/N)·|acc_b−conf_b|` · 3 worked example (perfect-cal=0 · over-conf=40 falsifier fires · mild=4). Anchors: Naeini 2015 · Guo 2017 · Kuleshov 2018.
- **CONTAMINATION** — n-gram ratio closed-form `matched / total ∈ [0,1]` · 6 worked rows (edges 0%/100% · falsifier-trips 42%/85% · just-below 29%). Anchors: Dodge 2021 (arXiv:2104.08758) · Sainz 2023 · Magar 2022.
- **ENERGY** — tokens/J instrumentation identity `N_tokens / E_total[J]` · E_total = ∫P(t)dt ≈ mean_W·T (Riemann ↔ mean-power bit-identical). Anchors: Patterson 2021 · Strubell 2019 · Schwartz 2020.

### 정직성 (honest residual)

- 3 axis 모두 **closed-form 수준** · 실측 substrate fire 별 cycle-10+ deferred (mac M3 llama-server · ubu-1 HF transformers · vast.ai pod).
- CALIBRATION integer ×100 ledger 는 .01 precision (literature float 3-4 sig figs 보다 coarser) — falsifier semantics 충분, 모델 비교는 아님.
- CONTAMINATION placeholder counts — 실제 corpus (C4/Pile/RedPajama) bloom-filter scan 미수행.
- ENERGY worked example placeholder (200W/60s/480tok) — 실제 RAPL+NVIDIA-smi 미실행.
- ⭐ MAIN N⭐ NOVEL probe (temperature-vs-calib · surface-vs-semantic · per-layer energy) 다음 라운드 후보.

### Throttle 학습

라운드 시작 시 3-agent 동시 fan-out 이 storm hit ×3 (15s→30s→60s cooldown) 누적 발생. 다음 라운드 (round-2) 는 throttle 가이드대로 fan-out ≤1 (serialize 또는 ScheduleWakeup pacing) 진행 예정.

- [x] dispatched + merged CALIBRATION/A1 → 🟢 7/7
- [x] dispatched + merged CONTAMINATION/A1 → 🔵+🟡 6/6
- [x] dispatched + merged ENERGY/A1 → 🔵+🟡 7/7
- [ ] round-2 dispatch (남은 19 milestone 중 cap 3, throttle 학습 반영 — fan-out 1-2 권장)
- [ ] cost-bearing substrate fire round (3 axis 의 measured-tier upgrade — 별 cycle)

**3/22 milestone done · 19 queued · ♾️ perpetual frontier OPEN.**

## 2026-05-28 — meta-domain init (옵션 B from AXIS sweep 선택지)

- [x] meta-domain scaffold · 22 milestone (⭐⭐⭐ 12 + ⭐⭐ 10) · cross-domain orchestrator.
- [x] AXIS.easy.md 카드 각각의 A1 first probe 를 CODEX milestone 으로 mirror.
- [x] DOMAINS.tape 등록.
- [ ] `/cycle-bg` 첫 라운드 (⭐⭐⭐ 12 batch first).
- [ ] ⭐⭐⭐ 12 first-probe 측정 완료 시 ENGINE intake matrix 승격 검토.
- [ ] ⭐⭐ 10 후속 batch (cost-bearing 포함).
