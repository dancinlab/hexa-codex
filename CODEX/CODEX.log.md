# CODEX — log

Append-only history sister of `CODEX.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — cycle-9 round-4: 3 closed-form A1 wires (HALLUCINATION + INST-FOLLOW + PROMPT-SENS · /cycle-bg + salvage)

`/cycle-bg` round-4 (sticky bg · cap=3 batch · bg agent fan-out). 3 closed-form A1 wires, 모두 ⭐⭐⭐ tier. throttle storm ×3 (15s→30s→60s cooldown 누적) 발생 — round-1 패턴 재현. 1 agent (INSTRUCTION-FOLLOWING) 가 21 tool_uses · 254s 후 API rate-limit 으로 죽었지만 **parent salvage 로 복구 성공** (cycle skill recovery pattern: untracked file salvage).

| axis | tier | checks | branch | 비고 |
|---|---|---|---|---|
| HALLUCINATION/A1 | 🔵 STRUCTURAL + 🟡 BY-CITATION | 7/7 | `agent/hallucination-a1-cycle9-r4` | 정상 완료 (5-model + zero-control Z=0) |
| PROMPT-SENSITIVITY/A1 | 🔵 STRUCTURAL + 🟡 BY-CITATION | 7/7 | `worktree-agent-a9dc0f5c4757ff18d` | 정상 완료 (C(5,2)=10 pairwise binomial) |
| INSTRUCTION-FOLLOWING/A1 | 🔵 STRUCTURAL + 🟡 BY-CITATION | 7/7 | (no agent branch · parent salvage) | **agent rate-limit dead → parent salvaged** |

### Build phase 출력

- **HALLUCINATION** — `rate = N_confident_wrong / N_total × 100` · 5-model registry w/ zero-hall control Z=0 (bidirectional + null discrimination 보강). Anchors: Lin 2022 TruthfulQA (arXiv:2109.07958) · Kadavath 2022 P(True) · Yin 2023.
- **PROMPT-SENSITIVITY** — pairwise C(5,2)=10 binomial agreement · all-same→100 · all-diff→0 · surface-prone fires · consistent silent. Anchors: Sclar 2023 (arXiv:2310.11324) · Razavi 2022 · Wei 2022 CoT.
- **INSTRUCTION-FOLLOWING** — `compliance = N_passed / N_total × 100` · 4 models × 4 constraint types · per-constraint sum sanity (Σ_c cells == N_passed). Anchors: Zhou 2023 IFEval · Tam 2024 · Wadhwa 2024.

### Agent death recovery pattern (새 학습)

INSTRUCTION-FOLLOWING bg agent 가 21 tool_uses · 254s 후 "API Error: Server is temporarily limiting requests (not your usage limit) · Rate limited" 으로 사망. 단:
- bench + verify 파일은 main worktree 에 untracked 로 남았다 (HALLUCINATION agent report 가 "untracked 봤다" 확인 → cross-validation).
- `mkdir verdicts/` + `hexa run verify` → 7/7 PASS + verdict.txt 자동 작성.
- parent 가 doc flip + log entry 인라인 마무리.

새 recovery pattern: **agent 가 commit 전 사망 시 main worktree 의 untracked file 으로 살아남기도 함**. 기존 cycle skill "checkpoint commits are replay-safe" 의 변형 — checkpoint 없을 때 main-worktree untracked file 가 cross-process artifact 역할.

### Throttle 관찰 (3-agent bg = 3 storm 재현)

| 라운드 | mode | agents | storm |
|---|---|---|---|
| round-1 | bg | 3 | 3 (15s→30s→60s) · all 3 success |
| round-2 | fg | 2 | 0 |
| round-3 | fg | 2 | 0 |
| round-4 | bg | 3 | 3 (15s→30s→60s) · 2 success + 1 partial-death (salvaged) |

3-agent bg fan-out 은 100% storm 확정. 단 storm 이 작업을 죽이지는 않음 (자체 backoff). 단 누적 storm 이 마지막 단계에서 throttle-kill 한 사례 발생. 다음 round 부터 fg 또는 bg fan-out ≤ 2 권장.

### 정직성 (honest residual)

- 3 axis 모두 closed-form / citation tier · 실측 substrate fire 별 cycle-10+ deferred.
- HALLUCINATION: TruthfulQA/SimpleQA 실측 미수행.
- PROMPT-SENS: 5-prompt 실 LLM run 미수행.
- INST-FOLLOW: IFEval ~541 prompt set × 25 verifier class 실측 미수행.

- [x] dispatched + merged HALLUCINATION/A1 → 🔵+🟡 7/7
- [x] dispatched + merged PROMPT-SENSITIVITY/A1 → 🔵+🟡 7/7
- [x] dispatched + **salvaged** INSTRUCTION-FOLLOWING/A1 → 🔵+🟡 7/7
- [ ] round-5 (남은 12 milestone · ⭐⭐⭐ 2 remaining: AGENT · LONG-CONTEXT + ⭐⭐ 10)

**10/22 milestone done · 12 queued · ♾️ perpetual frontier OPEN.**

## 2026-05-28 — cycle-9 round-3: 2 closed-form A1 wires (PRIVACY + RAG · /cycle-fg inline)

`/cycle-fg` round-3 (sticky fg · cap=2 batch · inline sequential). 2 closed-form A1 wires, 둘 다 ⭐⭐⭐ tier · 다른 compound 패턴 (delta-from-baseline vs OR compound).

| axis | tier | checks | verifier |
|---|---|---|---|
| PRIVACY/A1 | 🔵 STRUCTURAL + 🟡 BY-CITATION | 7/7 | `PRIVACY/verify/numerics_privacy_a1_mi_advantage.hexa` |
| RAG/A1 | 🔵 STRUCTURAL + 🟡 BY-CITATION | 7/7 | `RAG/verify/numerics_rag_a1_recall_at_k.hexa` |

### Build phase 출력

- **PRIVACY** — `mi_excess = mi_acc − 0.5` + `mi_advantage = max(0, excess)` + `falsifier_fires = excess > 5pp`. Worked example 4 models (A=52 borderline · B=58 leak fires · C=50 baseline · D=45 below-random anomaly · advantage clipped 0). Anchors: Shokri 2017 MI · Carlini 2021 extraction · Abadi 2016 DP-SGD · Yeom 2018.
- **RAG** — set-cardinality `recall@k = |retrieved∩relevant|/|relevant|` + **compound OR** `falsifier = (recall@5 < 50%) OR (citation < 30%)`. Worked example 4 retrievers (BM25 62/55 · DPR 78/72 · ColBERT 85/80 silent · naive 35/18 DOUBLE FAIL) + synthetic one-leg-low fires. Anchors: Karpukhin 2020 DPR · Shi 2023 distractor · Asai 2023 Self-RAG · Ram 2023.

### Compound logic 다양화

| round | axis | compound | 패턴 |
|---|---|---|---|
| round-1 | CONTAMINATION/A1 | n-gram threshold (단일) | > 30% |
| round-2 | MULTILINGUAL/A1 | AND (둘 다 위) | ppl > 2.0 AND bytes/tok > 2.0 |
| round-2 | FAIRNESS/A1 | threshold | max gap > 10pp |
| round-3 | PRIVACY/A1 | threshold | excess > 5pp |
| round-3 | RAG/A1 | **OR (하나만 아래)** | recall < 50% OR citation < 30% |

OR vs AND vs threshold — closed-form falsifier 다양한 형태 검증.

### 정직성 (honest residual)

- 둘 다 **closed-form identity tier** · 실측 substrate fire 별 cycle-10+ deferred.
- PRIVACY: placeholder MI acc · 실측은 shadow models + canary extraction on ubu-1 HF.
- RAG: placeholder recall/citation · 실측은 MS MARCO · NQ · TriviaQA + retriever family.
- ⭐ MAIN N⭐ NOVEL (memorization-vs-utility Pareto · retrieve-then-ignore rate) 다음 라운드 후보.

- [x] inline executed PRIVACY/A1 → 🔵+🟡 7/7
- [x] inline executed RAG/A1 → 🔵+🟡 7/7
- [ ] round-4 (남은 15 milestone · ⭐⭐⭐ 5 + ⭐⭐ 10)

**7/22 milestone done · 15 queued · ♾️ perpetual frontier OPEN.**

## 2026-05-28 — cycle-9 round-2: 2 closed-form A1 wires (MULTILINGUAL + FAIRNESS · /cycle-fg inline)

`/cycle-fg` round-2 (sticky fg · cap=2 batch · inline sequential · NO bg agent). throttle 학습 반영 — 1-at-a-time 인-세션 직접 실행. 둘 다 group-comparison 구조의 closed-form metric (ratio · absolute delta).

| axis | tier | checks | verifier |
|---|---|---|---|
| MULTILINGUAL/A1 | 🔵 STRUCTURAL + 🟡 BY-CITATION | 7/7 | `MULTILINGUAL/verify/numerics_multilingual_a1_perplexity_gap.hexa` |
| FAIRNESS/A1 | 🔵 STRUCTURAL + 🟡 BY-CITATION | 7/7 | `FAIRNESS/verify/numerics_fairness_a1_group_gap.hexa` |

### Build phase 출력

- **MULTILINGUAL** — `ppl_gap = PPL_lang / PPL_en` (× 1000) + `bytes_gap = bytes/tok_lang / bytes/tok_en` (× 100) + compound `low_resource = (ppl_gap > 2.0) AND (bytes_gap > 2.0)`. Bidirectional discrimination 검증: sw 정확 발화 (5600/310) · ja 정확 silent (1400/121) · ko AND-trap (ppl 위 2133, bytes 아래 189 → False). Anchors: Pires 2019 · Conneau 2020 XLM-R · Wu 2024.
- **FAIRNESS** — `gap(i,j) = |acc_i − acc_j|` (× 100) absolute-delta metric. 5 properties 검증: self=0 · symmetry · non-neg · range bound · triangle inequality. Worked example 4 groups (A=82·B=78·C=71·D=84): max pairwise = 13 (C↔D) > 10pp → falsifier 정확 발화. Anchors: Buolamwini 2018 · Crenshaw 1989 · Wang 2022 BBQ.

### 정직성 (honest residual)

- 둘 다 **closed-form metric tier** · 실측 substrate fire 별 cycle-10+ deferred.
- MULTILINGUAL: placeholder PPL/bytes per lang · 실측은 mac M3 llama-server / ubu-1 HF + MMLU multilingual.
- FAIRNESS: placeholder acc per group · 실측은 BBQ · CrowS-Pairs · WinoBias on ubu-1 HF.
- ⭐ MAIN N⭐ NOVEL (cross-lingual transfer asymmetry · intersectional vs single-axis gap) 다음 라운드 후보.

### Throttle 회피 성공

bg agent fan-out 0개 → throttle storm 0건 (round-1 의 3 storm 회피). fg sequential 이 다중 milestone batch 에 안전.

- [x] inline executed MULTILINGUAL/A1 → 🔵+🟡 7/7
- [x] inline executed FAIRNESS/A1 → 🔵+🟡 7/7
- [ ] round-3 (남은 17 milestone · ⭐⭐⭐ 7 + ⭐⭐ 10)

**5/22 milestone done · 17 queued · ♾️ perpetual frontier OPEN.**

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
