# CODEX — meta-domain · 22 axis-candidate first probe orchestrator

@title: 🧭 CODEX — "axis 후보 측정 코디네이터"
@goal: **[`AXIS.easy.md`](../AXIS.easy.md) 의 22 candidate sibling 후보 도메인의 first probe (축 A1) 를 cross-domain 으로 영구 orchestrate 하는 meta-domain lane.** 새 candidate 가 등장할 때마다 milestone 추가 · 측정 완료 → 후보 도메인의 N⭐ NOVEL probe → ENGINE intake matrix 승격 검토. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Meta-domain (cross-domain orchestration lane). 22 candidate sibling domain (⭐⭐⭐ 12 + ⭐⭐ 10) 의 first probe 를 한 곳에서 dispatch. 측정은 SANDBOX 기질 위에서 (`cx_lab_sandbox`) · verdict 는 각 후보 도메인의 `.verdicts/` 에 기록.
>
> **Falsifier class:** cross-domain orchestration latency / fidelity — 22 candidate 중 일정 fraction 이 일정 cycle 안에 measured 으로 graduate 하는지.

## North-star

```
       CODEX (meta orchestrator)
          │
          │  /cycle-bg → 22 agent fan-out (worktree isolation)
          │
   ┌──────┴──────┐
   ▼             ▼            22 candidate domains
 CALIBRATION  HALLUCINATION ... USER-MODEL
 A1 probe     A1 probe          A1 probe
   │             │                 │
   ▼             ▼                 ▼
 SANDBOX 기질 위에서 measured (cx_lab_sandbox)
   │             │                 │
   ▼             ▼                 ▼
 🟢 verdict   🟢 verdict        🟢 verdict
                       │
                       ▼
            ENGINE intake matrix 승격 검토
            (sibling 5 → 6 → ... → 27)
```

## 진행 (milestones) — 22 candidate first probe

### ⭐⭐⭐ 12 (강력 후보 · 즉시-wire 가능성 높음)
- [x] CALIBRATION/A1 — ECE (Expected Calibration Error) closed-form 측정 (per-task) · 반증자: ECE > 0.1 OR over-confidence systematic · **CYCLE-9 round-1 (2026-05-28)** ✅ 🟢 SUPPORTED-NUMERICAL · 7/7 PASS · `CALIBRATION/verify/numerics_calibration_a1_ece_formula.hexa`
- [x] HALLUCINATION/A1 — TruthfulQA/SimpleQA hallucination rate (confidence × 정답률) · 반증자: rate > 20% with high confidence · **CYCLE-9 round-4 (2026-05-28 · bg agent)** ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7 PASS · `HALLUCINATION/verify/numerics_hallucination_a1_confident_wrong_rate.hexa`
- [x] LONG-CONTEXT/A1 — needle-in-haystack accuracy @ context-len curve · 반증자: 64k 정확도 < 4k × 0.5 · **CYCLE-9 round-5 (2026-05-28)** ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7 PASS · `LONG-CONTEXT/verify/numerics_long_context_a1_niah_drop.hexa`
- [x] PROMPT-SENSITIVITY/A1 — 5-prompt agreement rate · variance · 반증자: factual 일관성 < 80% · **CYCLE-9 round-4 (2026-05-28 · bg agent)** ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7 PASS · `PROMPT-SENSITIVITY/verify/numerics_prompt_sensitivity_a1_5prompt_agreement.hexa`
- [x] ENERGY/A1 — RAPL+NVIDIA-smi tokens/J at fixed task · 반증자: tokens/J 가 SOTA × 0.5 미만 · **CYCLE-9 round-1 (2026-05-28)** ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7 PASS · `ENERGY/verify/numerics_energy_a1_tokens_per_joule.hexa`
- [x] RAG/A1 — retriever recall@k · 인용 정확도 · 반증자: recall@5 < 50% OR citation rate < 30% · **CYCLE-9 round-3 (2026-05-28)** ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7 PASS · `RAG/verify/numerics_rag_a1_recall_at_k.hexa`
- [x] AGENT/A1 — single-tool call 정확도 · 반증자: basic task 1-step < 70% · **CYCLE-9 round-5 (2026-05-28)** ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7 PASS · `AGENT/verify/numerics_agent_a1_tool_call_rate.hexa`
- [x] CONTAMINATION/A1 — n-gram contamination rate (13-gram match) · 반증자: 표준 eval > 30% · **CYCLE-9 round-1 (2026-05-28)** ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · 6/6 PASS · `CONTAMINATION/verify/numerics_contamination_a1_ngram_ratio.hexa`
- [x] INSTRUCTION-FOLLOWING/A1 — IFEval format compliance · 반증자: simple constraint 준수 < 90% · **CYCLE-9 round-4 (2026-05-28 · bg agent + parent salvage)** ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7 PASS · `INSTRUCTION-FOLLOWING/verify/numerics_instruction_following_a1_compliance_rate.hexa` (agent rate-limit dead mid-doc-flip · parent salvaged untracked files)
- [x] MULTILINGUAL/A1 — per-language perplexity · bytes/token · 반증자: low-resource 성능 < 영어 × 0.5 · **CYCLE-9 round-2 (2026-05-28)** ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7 PASS · `MULTILINGUAL/verify/numerics_multilingual_a1_perplexity_gap.hexa`
- [x] FAIRNESS/A1 — group-wise accuracy gap · counterfactual fairness · 반증자: demographic gap > 10pp · **CYCLE-9 round-2 (2026-05-28)** ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7 PASS · `FAIRNESS/verify/numerics_fairness_a1_group_gap.hexa`
- [x] PRIVACY/A1 — membership inference accuracy vs baseline · 반증자: > random + 5pp · **CYCLE-9 round-3 (2026-05-28)** ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7 PASS · `PRIVACY/verify/numerics_privacy_a1_mi_advantage.hexa`
- [x] MULTIMODAL/A1 — text·image·audio·video 모달리티 균형 · 반증자: 모달리티 간 acc gap > 30pp · **CYCLE-10 reorg (2026-05-28 · FRONTIER F2 graduate · 신규 단독 도메인)** ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7 PASS · `MULTIMODAL/verify/numerics_multimodal_a1_modality_balance.hexa` · gemma4_31B 7pp · qwen3.6_72B 19pp silent · legacy_vlm_4B 75pp fires

### ⭐⭐ 10 (보조 후보)
- [x] ROBUSTNESS/A1 — adversarial attack 성공률 · clean accuracy · 반증자: adv drop > 30pp · **CYCLE-9 round-6 (2026-05-28 · bg agent)** ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7 PASS · `ROBUSTNESS/verify/numerics_robustness_a1_adversarial_drop.hexa`
- [x] TRAINING-DYNAMICS/A1 — loss spike 빈도 · gradient/weight norm · 반증자: spike > 1/1k steps · **CYCLE-9 round-7 (2026-05-28 · bg agent)** ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7 PASS · `TRAINING-DYNAMICS/verify/numerics_training_dynamics_a1_spike_rate.hexa`
- [x] DATA-EFFICIENCY/A1 — curriculum 순서 효과 · sample-eff 곡선 · 반증자: < 5% vs random · **CYCLE-9 round-8 (2026-05-28 · bg agent)** ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7 PASS · `DATA-EFFICIENCY/verify/numerics_data_efficiency_a1_curriculum_delta.hexa`
- [x] HW-VARIANCE/A1 — per-chip throughput 분산 (동일 spec) · 반증자: 분산 > 15% · **CYCLE-9 round-8 (2026-05-28 · bg agent)** ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7 PASS · `HW-VARIANCE/verify/numerics_hw_variance_a1_per_chip_cov.hexa`
- [x] BATCH-COMPOSITION/A1 — length-mix throughput · padding waste · 반증자: random vs sorted > 30% · **CYCLE-9 round-8 (2026-05-28 · bg agent)** ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7 PASS · `BATCH-COMPOSITION/verify/numerics_batch_composition_a1_padding_waste.hexa`
- [x] RELIABILITY/A1 — 결정론 재현률 · silent corruption · 반증자: 재현률 < 99.9% · **CYCLE-9 round-6 (2026-05-28 · bg agent)** ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7 PASS · `RELIABILITY/verify/numerics_reliability_a1_determinism.hexa`
- [x] CARBON/A1 — gCO2/token (region별 grid × tokens/J) · 반증자: 친환경 region 감소 < 20% · **CYCLE-9 round-7 (2026-05-28 · bg agent)** ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7 PASS · `CARBON/verify/numerics_carbon_a1_region_saving.hexa`
- [x] TEMPORAL/A1 — date/duration/ordering accuracy · 반증자: cutoff 이후 confident-wrong > 30% · **CYCLE-9 round-7 (2026-05-28 · bg agent)** ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7 PASS · `TEMPORAL/verify/numerics_temporal_a1_post_cutoff_wrong.hexa`
- [x] DIVERSITY/A1 — self-BLEU · repetition rate · entropy · 반증자: self-BLEU > 0.8 OR repetition > 20% · **CYCLE-9 round-6 (2026-05-28 · bg agent)** ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7 PASS · `DIVERSITY/verify/numerics_diversity_a1_self_bleu_repetition.hexa`
- [x] USER-MODEL/A1 — 10-turn persona 일관성 · context recall · 반증자: 10-turn drift > 20% · **CYCLE-9 round-8 (2026-05-28 · bg agent)** ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · 7/7 PASS · `USER-MODEL/verify/numerics_user_model_a1_persona_drift.hexa`

### 🆕 frontier-동향 흡수 (cycle-10 reorg · 각 도메인 N⭐ NOVEL MAIN)

> 2026 frontier 동향 (Gemma 4 MoE · multimodal · agentic · reasoning · cost · alignment-faking + train/infer/serve stack) 을 별도 meta-domain (구 FRONTIER, 2026-05-28 retire) 대신 **기존 도메인의 N⭐ NOVEL MAIN axis 로 분산 흡수** (사용자 directive: "프론티어 별도 X · NOVEL 과 더불어 frontier 축으로 전부 분산 흡수 · 골 도착지 없이 · NOVEL 이 메인"). 각 흡수 시 기존 N⭐ → N2 강등.

- [x] ENERGY/N1 — SPARSE-MOE active-premium (구 FRONTIER F1) · active_premium 982/1000 → 🔴 "MoE free lunch" myth FALSIFIED in Gemma 4 family
- [x] AGENT/N1 — AGENTIC-TRAJECTORY step-decay (구 F3) · weak_4b_legacy 214 fires · 4 frontier silent
- [x] HALLUCINATION/N1 — REASONING-DEPTH scratch-pad utility (구 F4) · pattern_match Δ3pp fires · 4 frontier Δ40-47 silent
- [x] ECONOMICS/N1 — COST-PERFORMANCE 50× spread (구 F5) · GPT-5 $15 vs DeepSeek V4 $0.30 = 5000/100 fires
- [ ] ROBUSTNESS/N⭐ — ALIGNMENT-FAKING eval-vs-deploy 행동차 (구 F6) · Phase 3
- [ ] RELIABILITY/N⭐ — CHECKPOINT-INTEGRITY (resume·포맷변환 무결성) · Phase 3
- [ ] ENERGY/N2 — QUANTIZATION 품질-크기 trade · Phase 3
- [ ] MULTILINGUAL/N⭐ — TOKENIZER vocab coverage·bytes/token · Phase 3
- [ ] BATCH-COMPOSITION/N⭐ — SPECULATIVE-DECODING draft acceptance · Phase 3
- [ ] HW-VARIANCE/N⭐ — DISTRIBUTED-SCALING multi-GPU 효율 · Phase 3
- [ ] LONG-CONTEXT/N2 — KV-CACHE paged attention 효율 · Phase 3

## SANDBOX 연계 (measurement substrate)

모든 milestone 은 SANDBOX 기질 위에서 측정 (`cx_lab_sandbox`):

| substrate | 적합 후보 (예) |
|---|---|
| mac M3 (Metal/UMA, llama-server) | CALIBRATION · HALLUCINATION · LONG-CONTEXT · PROMPT-SENS · INSTRUCTION-FOLLOWING · DIVERSITY · TEMPORAL · USER-MODEL |
| ubu-1 (RTX 5070 · HF transformers) | FAIRNESS · CONTAMINATION · MULTILINGUAL · CARBON · ENERGY |
| vast.ai pod (cost-bearing) | TRAINING-DYNAMICS · DATA-EFFICIENCY · PRIVACY (DP-SGD) · AGENT (multi-step) · RAG (corpus 큰) |
| serving stack (production) | RELIABILITY · ROBUSTNESS · HW-VARIANCE · BATCH-COMPOSITION |

## ENGINE 연계 (driving lane 승격)

CODEX milestone 이 🟢 도달 → 해당 후보 도메인이 first finding 보유 → [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter (G, H, …) 부여 검토 → wire 작성 → ENGINE 의 sibling 5→6→... 확장.

```
CODEX milestone 🟢 ──▶ AXIS.easy.md 카드 promote ──▶ ENGINE matrix 행 추가 ──▶ wire 후보 N1
```

## 운영 전략 (multiple dispatch strategies)

> CODEX 는 한 가지 fan-out 방식에 묶이지 않는다. 22 milestone 의 성격 (closed-form vs cost-bearing · 측정 vs 발견 · 단일 vs sweep) 에 따라 **상황별 최적 전략을 골라서** dispatch.

### ⭐ PRIMARY: `/micro-exp` — 병렬 verify-driven sweep

> **22 측정 batch 의 canonical 도구.** Self-enumerate sweep 후보 → pod 임대 (≤budget) → 병렬 fire → 🛰️ Monitor (pw.x/ph.x alive-check) → JOB DONE 시 harvest+down · parse Agent → 🟢 도달 시 atlas 자동 등록 (`embedded.gen.hexa` 직접 fold) → `exports/sweep/<batch>/` ledger.

| 적합 milestone | 이유 |
|---|---|
| CALIBRATION · HALLUCINATION · MULTILINGUAL · FAIRNESS · CONTAMINATION | 측정 자체 — 병렬 fire 가능, verdict per probe |
| LONG-CONTEXT · RAG · PROMPT-SENSITIVITY · INSTRUCTION-FOLLOWING | parameter sweep (context-len · k · prompt variant) 핵심 |
| ENERGY · CARBON | per-config measurement (HW · region 별 sweep) |

```bash
/micro-exp 22-axis-candidate first-probe sweep       # 22 milestone 전체 한방
/micro-exp ⭐⭐⭐ batch only                            # tier 별 분할
/micro-exp CALIBRATION HALLUCINATION CONTAMINATION   # 명시 선택
```

### 보조 전략 메뉴

| 전략 | 강점 | 적합 milestone | 비고 |
|---|---|---|---|
| `/cycle-bg` | depletion-driving · per-milestone bg agent | AGENT · INSTRUCTION-FOLLOWING (per-domain 깊이) | worktree fan-out · auto-continue |
| `/cycle-all` | NO cap · 22 한 라운드 전부 발사 | 모든 milestone 일괄 (자원 충분 시) | 무거움 · 자원 충돌 가능 |
| `/cycle-fg` | inline sequential · 사람이 보면서 검토 | TRAINING-DYNAMICS · HW-VARIANCE (디버그) | 한 개씩 |
| `/cycle-full` | 라운드 전 depletion brainstorm | 후보 자체가 모호한 milestone | width 확장 후 fan-out |
| `/kick <seed>` | 발견 엔진 (gap breakthrough · mk9/mk10) | 새 candidate sibling 추가 (AXIS.easy.md 갱신) | discovery → new milestone |
| `/gap` | 40 breakthrough lens sweep | 측정 frontier 막힌 milestone (예: AGENT plan-execute gap) | family triage |
| `/sbs auto` | plan-first · 4-axis weighted pick | RELIABILITY · PRIVACY (안전 중요) | safety / standard 가중치 가능 |
| `/loop <interval>` | 주기적 재측정 | drift 감지 (USER-MODEL · TEMPORAL cutoff) | dynamic mode |
| `/cloud nohup + tail` | long-running pod 측정 | DATA-EFFICIENCY (큰 corpus) · TRAINING-DYNAMICS | preflight 권장 |
| `/pool on <host>` | 다른 호스트 dispatch | HW-VARIANCE (per-host) · multi-node OPS | mini · ubu-1 · ubu-2 · pi5 |

### milestone 별 권장 전략 매핑

```
⭐⭐⭐ 12 (closed-form / cheap-measure 중심)
├─ /micro-exp 일괄 sweep (PRIMARY · default)
│   └─ CALIBRATION · HALLUCINATION · MULTILINGUAL · FAIRNESS · CONTAMINATION
│      LONG-CONTEXT · RAG · PROMPT-SENSITIVITY · INSTRUCTION-FOLLOWING
├─ /cycle-bg per-domain depth
│   └─ AGENT (multi-step plan 깊이)
├─ /cloud nohup + tail
│   └─ ENERGY · PRIVACY (DP-SGD 학습 fire)

⭐⭐ 10 (cost-bearing / depth-heavy 혼합)
├─ /micro-exp parameter sweep
│   └─ ROBUSTNESS · CARBON · DIVERSITY · TEMPORAL
├─ /cloud nohup (long-running)
│   └─ TRAINING-DYNAMICS · DATA-EFFICIENCY
├─ /pool on (host-specific)
│   └─ HW-VARIANCE · RELIABILITY · BATCH-COMPOSITION
└─ /loop interval
   └─ USER-MODEL (drift 주기 검사)
```

### 운영 원칙

- ⭐⭐⭐ 12 먼저 (closed-form/cheap) → ⭐⭐ 10 (cost-bearing 포함) — 순서.
- **각 milestone 의 default = `/micro-exp`**. 그 외 전략은 milestone 성격에 맞을 때만 전환.
- 각 agent 는 isolated worktree 에서 해당 후보 도메인 (예: `CALIBRATION/`) 의 verify/verdict 작성 · CODEX milestone 만 flip.
- 🟢 verdict 도달 시 atlas register (micro-exp 의 경우 자동) → ENGINE intake matrix 승격 신호.
- cost-bearing fire 전 항상 `/cloud preflight` (GPU mem-budget closed-form 체크) · 사용자 sign-off 요청.

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- 22 candidate domains: [`../CALIBRATION/`](../CALIBRATION/CALIBRATION.md) · [`../HALLUCINATION/`](../HALLUCINATION/HALLUCINATION.md) · ... (DOMAINS.tape 참조)
- ENGINE intake matrix (승격 대상): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- this domain: [`CODEX.md`](CODEX.md) (snapshot) · [`CODEX.log.md`](CODEX.log.md) (history)
