# SUBSTRATE — hexa-codex substrate verb group (domain SSOT)

@title: 🧠 SUBSTRATE — 역량 eval 영구 측정 lane ("멈추지 않는 capability-curve frontier")
@goal: **모델 역량(multimodal·RLHF·cog-arch·causal)을 SANDBOX 기질에서 결정론적·seed-pinned 하게 영구 측정하는 lane.** v1.4.0(multimodal 0.5/2.2/3.0B ladder, 비단조 honest-negative — counting 축이 trend 깨짐)은 첫 arc 의 종결일 뿐 — 더 큰 rung·새 역량축·새 modality 가 등장할 때마다 capability frontier 는 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Domain doc · dancinlab `domain-meta-domain` principle. One of the
> **4 orthogonal groups** of the hexa-codex 17-verb AI knowledge
> substrate. Current-state spec only; dated history →
> [`SUBSTRATE.log.md`](SUBSTRATE.log.md).
>
> **Falsifier class:** capability evals — multimodal fusion, RLHF
> labelling, cognitive-architecture and causal-reasoning capability
> probes.

## North-star

The SUBSTRATE group is the **4-verb capability surface** of the codex:
the deeper model-substrate concerns — multimodal fusion, RLHF/DPO
labelling, cognitive architecture, and causal-chain reasoning — that
underpin what a model can *do*. Each verb is a closed-form capability
candidate + falsifier preregister. This group is the widest and lands
last on the release ladder (v2.0.0, aspirational).

## Verbs (4)

| Verb | Spec | Role |
|------|------|------|
| `multimodal` | [`multimodal/ai-multimodal.md`](multimodal/ai-multimodal.md) | multimodal fusion spec |
| `rlhf` | [`rlhf/youth-ai-labeling-rlhf-hub.md`](rlhf/youth-ai-labeling-rlhf-hub.md) | DPO / RLHF labelling hub |
| `cog_arch` | [`cog_arch/cognitive-architecture.md`](cog_arch/cognitive-architecture.md) | cognitive-architecture envelope |
| `causal` | [`causal/causal-chain.md`](causal/causal-chain.md) | causal-chain reasoning spec |

## Falsifiers

SUBSTRATE owns **none of F-CODEX-1..4** directly. Its falsifier class is
**per-verb capability evals** — each verb spec preregisters a capability
threshold rather than a scaling law or SLO.

The v2.0.0 substrate release is the empirical-landing window for
**F-CODEX-4** (`interpret_motifs = σ−φ = 10`, owned by
[`SAFETY.md`](SAFETY.md)) — interpretability of the full capability
substrate is the last falsifier to close.

## n=6 projection

This group is one of the **τ(6) = 4** quadrants of the codex taxonomy.
SUBSTRATE spans the **σ(6) = 12** capability-dimension surface — the
12-axis capability bin that `alignment` (SAFETY) later aggregates.

## State (v1.0.0 — RELEASED)

Spec-first: all 4 verbs ship a written capability candidate + falsifier
preregister. **0 verbs wired**, **0 eval pipelines**. No F-CODEX
arithmetic floor applies; per-verb capability falsifiers preregistered,
empirical evals PENDING.

## Roadmap — v2.0.0 (2027-Q2, ASPIRATIONAL · group focus = substrate)

- 17 verbs wired (full library) · 4 eval pipelines.
- **F-CODEX-4 empirical landing** — SAE motif-count parity (Anthropic
  dictionary-learning comparable).
- DoD (`.roadmap.hexa_codex` §0): substrate group multimodal + cog-arch
  + causal + RLHF integrated eval.

## 영구 축 (perpetual axes)

> SUBSTRATE 는 완료되지 않는다. v1.4.0 의 multimodal ladder 는 0.5–3.0B 첫 arc 이고,
> capability frontier 는 더 큰 rung·새 역량축·새 modality 가 등장할 때마다 다시 열린다.
> 각 축은 `/cycle` 로 SANDBOX(결정론 + seed 제어가 가능한 surface) 위에서 영구 전진.

### 축 A — 4번째+ VL rung (7B+) — M5.SUBSTRATE 명시 잔여
> 비단조 곡선: perception saturation 이 scale 에서 유지되고 counting 이 회복되는가?
- [ ] A1 — 7B+ VL rung(mmproj 포함) 측정 → perception 11/11 유지 + counting(5–9 dense) 회복 여부. 반증자: counting 이 7B 에서도 params 와 무관 (subitizing 한계 invariant).

### 축 B — capability-axis 분해 (per-axis 법칙)
> v1.4.0: perception 은 monotone-saturating, counting 은 flat. 축별 capability 법칙 분리.
- [ ] B1 — reasoning·spatial·temporal 신규 축 추가 → 축별 logistic in log2(params) 재적합. 반증자: 단일 logistic 이 overall 곡선에 RMSE > mean SE.

### 축 C — RLHF/DPO reward 역량 (`rlhf` verb)
- [ ] C1 — reward-model 역량 eval 을 SANDBOX 에서 측정 (선호쌍 정확도 ladder). 반증자: reward 정확도가 base capability 와 무상관.

### 축 D — causal-chain · cog-arch 역량 (`causal` · `cog_arch` verb)
- [ ] D1 — causal-reasoning eval ladder (DAG 추론 정확도 vs scale). 반증자: causal 정확도가 scale ladder 에서 비단조.

## Cross-refs

- `.roadmap.hexa_codex` §A.4 — falsifier preregister · §A.2 — release cadence
- `README.md` — Falsifier preregister · Release ladder
- `verify/falsifier_check.py` · `verify/n6_arithmetic.py`
- Sister groups: [`SAFETY.md`](SAFETY.md) · [`ECONOMICS.md`](ECONOMICS.md) · [`OPS.md`](OPS.md)
- 영구 축 원리: [`SANDBOX.md`](SANDBOX.md) · [[feedback_closure_is_physical_limit]]
