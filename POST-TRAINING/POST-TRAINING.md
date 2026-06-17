# POST-TRAINING — 후처리 조련사

@title: 🎓 POST-TRAINING — "후처리 조련사"
@goal: **pre-train 된 base model 을 SFT·RLHF·DPO·GRPO·Constitutional 로 정렬·연마할 때 helpfulness·safety·capability 사이의 trade 를 영구 측정·확장하는 lane.** 새 post-train 방법·alignment 목표·reward model 이 등장할 때마다 측정 frontier 가 다시 열린다. **도착지 없음 · 종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> orchestra-research 20-skill 카탈로그의 **"Post-Training"** 항목이 hexa-codex 에 미흡수 (cycle-10 orchestra-research 누락 점검) → 흡수처 도메인 없음 → **신규 단독 도메인** 으로 승격. A1 (alignment tax) 이 본 도메인의 first probe.
>
> **Falsifier class:** alignment tuning 후 capability drop > 5pp (helpfulness↑ 인데 base 능력 희생) → alignment tax 과다 (over-aligned).
>
> **Sibling parallel:** ARCHITECTURE 는 'model 구조의 능력', POST-TRAINING 는 '정렬 후 능력 보존' — 별 dimension. lm_foundry/ Mk.I 의 SFT/GRPO 실험 (r38~r43 routing-RL) 이 본 도메인의 실측 substrate 후보.

## North-star

base model 을 사람 선호로 정렬하면서, helpfulness 를 올리되 원래 가진 capability (추론·코딩·수학) 를 희생하지 않을 수 있는가, 그리고 helpfulness·safety·capability 세 목표를 동시에 개선하는 Pareto frontier 가 존재하는가 (정렬세 alignment tax 의 진짜 한계).

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> POST-TRAINING 은 완료되지 않는다. 새 post-train 방법·alignment 목표·reward model 이 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — alignment tax (closed-form baseline)
- [x] A1 — alignment tax @ base-vs-post capability · 5 post-train 방법 × {helpfulness_gain_pct, capability_retention_pct}. 반증자: alignment tuning 후 capability drop > 5pp (helpfulness↑ 인데 능력 희생) → alignment tax 과다. **CYCLE-10 orchestra-research 흡수 (2026-05-28):** `POST-TRAINING/bench/post_training_a1_alignment_tax.hexa` + `POST-TRAINING/verify/numerics_post_training_a1_alignment_tax.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL + 🟡 BY-CITATION. Identity: `alignment_tax_pct = base_capability − post_capability` (× 100 ledger of pp · capability drop) · falsifier `alignment_tax > 5pp`. Worked example 5 methods × {base/post capability, helpfulness_gain}: **sft_base (80/79 · tax 1pp · help +8pp · silent)** · **good_dpo (80/78 · 2pp · +15pp · silent)** · **rlhf_ppo (80/76 · 4pp · +20pp · silent)** · **grpo (80/77 · 3pp · +18pp · silent)** · **over_aligned (80/68 · 12pp · +25pp · fires — helpfulness↑ 인데 capability 12pp 희생)**. bidirectional: 4 silent (good alignment · drop ≤ 5pp) + 1 fires (over-aligned · capability 희생) · retention-monotone sanity (높은 tax ⇒ 낮은 retention). External anchors: Ouyang 2022 InstructGPT/RLHF (arXiv:2203.02155) · Rafailov 2023 DPO (arXiv:2305.18290) · Shao 2024 GRPO (arXiv:2402.03300) · Bai 2022 Constitutional AI (arXiv:2212.08073). Verifier: `POST-TRAINING/verify/numerics_post_training_a1_alignment_tax.hexa` · verdict `POST-TRAINING/verdicts/a1_alignment_tax_verdict.txt`. **실측 측정 DEFERRED** — cycle-11+ T4 (base vs post capability bench: MMLU·GSM8K·HumanEval pre/post alignment on local SANDBOX stack · lm_foundry/ Mk.I SFT/GRPO 실험 재활용). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — identity close ≠ measured close. 축 N (helpfulness-safety-capability 3-way trade) 다음 ⭐ MAIN priority lane.

### 축 B — method 효율 비교 (measured ladder)
- [ ] B1 — DPO vs PPO vs GRPO sample-efficiency · 같은 reward gain 도달에 필요한 sample/step 수 fit. 반증자: GRPO sample-eff < DPO × 0.8 → GRPO 가 group-relative advantage 에도 불구하고 DPO 의 offline 효율에 못 미침.

### 축 N — 🆕 NOVEL: helpfulness-safety-capability 3-way trade (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — POST-TRAINING self-NOVEL. alignment 의 다목표 Pareto frontier. helpfulness↑ · safety↑ · capability 보존 세 목표를 동시에 개선할 수 있는가, 아니면 한 축을 올리면 나머지 두 축이 반드시 깎이는가. 도착지 없음. 외부 anchor: Ouyang 2022 InstructGPT/RLHF · Rafailov 2023 DPO · Bai 2022 Constitutional AI · Shao 2024 GRPO.
- [ ] N1 — 세 목표의 동시 최적화 가능성 (Pareto) · {helpfulness, safety, capability} 3-way cross-product frontier fit. 반증자: 한 축 ↑ 가 다른 두 축 평균 > 5pp 희생 → 3-way 동시 개선 불가 (Pareto frontier 가 면이 아니라 곡선/점으로 collapse).

## SANDBOX 활용 (measurement substrate)

POST-TRAINING 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시). lm_foundry/ Mk.I 의 SFT/GRPO routing-RL 실험 (r38~r43) 이 본 도메인 A1/B1 의 실측 base↔post capability ladder 1차 후보.

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local · lm_foundry SFT/GRPO | `POST-TRAINING/verdicts/a1_alignment_tax_verdict.txt` |
| B1 ladder | SANDBOX bench harness · DPO/PPO/GRPO sweep | `.verdicts/POST-TRAINING/b1_*` |
| N1 ⭐ NOVEL | mac M3 / vast.ai pod · 3-way Pareto sweep | `.verdicts/POST-TRAINING/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| alignment-tax budget · method sample-efficiency · 3-way Pareto frontier | post-train 방법 선택 · alignment 강도 budget · helpfulness/safety/capability 동시 최적화 router | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **POST-TRAINING 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반. A1 은 현재 placeholder data 의 closed-form identity (🔵 STRUCTURAL + 🟡 BY-CITATION) — 실측 (🟢 SUPPORTED-NUMERICAL) 아님.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: alignment tuning 후 capability drop > 5pp → over-aligned (능력 희생)
> **Anticipated ENGINE behavior wire**: alignment-tax budget allocation · post-train method router · 3-way Pareto-aware reward shaping
>
> ⏸ DEFERRED waiting on cycle-11+ T4 measured fire (base vs post capability bench: MMLU · GSM8K · HumanEval pre/post alignment on local SANDBOX stack).

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../ARCHITECTURE.json)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../ARCHITECTURE.json)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 흡수 출처 (cycle-10): orchestra-research 20-skill "Post-Training" (누락 흡수)
- 실측 substrate 후보: `lm_foundry/` Mk.I SFT/GRPO routing-RL 실험 (r38~r43) — [[feedback_lever4_rl_sft_conflict]] · [[feedback_pure_rl_exploration_collapse]] · [[feedback_rl_tail_vs_greedy]]
- 기존 sibling 참고 (축 구조 패턴): [`../MULTIMODAL/MULTIMODAL.md`](../MULTIMODAL/MULTIMODAL.md) · [`../LONG-CONTEXT/LONG-CONTEXT.md`](../LONG-CONTEXT/LONG-CONTEXT.md)
- this domain: [`POST-TRAINING.md`](POST-TRAINING.md) (snapshot) · [`POST-TRAINING.log.md`](POST-TRAINING.log.md) (history)
