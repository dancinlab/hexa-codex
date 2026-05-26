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

### 축 N — 🆕 NOVEL: model-family-specific anomaly vs scaling-law universality (cycle-28, ⭐ MAIN priority lane)
> cycle-23c P1 BREAKTHROUGH 의 잔여(cycle-24 verifier honest residual): Qwen2.5-VL-3B 의 counting=2/5 dip 이 Qwen-family anomaly 인지 scale-law dip 인지 미분리. 7B-Qwen 회복(5/5)은 "subitizing emerges at scale" 과 "Qwen-VL-7B-specifically subitizes well" 을 discriminate 못함. cycle-26 C1 (12 dense overtrain, MoE 만 Chinchilla hit) → cycle-27 ECONOMICS E1 (MoE vs dense) 와 같은 family-confound 패턴이 SUBSTRATE 의 모든 capability claim 에도 깔려 있음 (현 ladder 는 Qwen 가 dominant). ⭐ MAIN priority lane — 모든 후속 capability claim 의 family-vs-scale 분리 게이트.
- [ ] N1 — 각 capability claim (text wc_31_60 cliff at 3B→7B · VL counting recovery at 7B · multimodal saturation) 에 대해 non-Qwen 동급 scale 모델(Llama-3.x · Mistral · Gemma-3 · SmolVLM-NeXT)에서 transfer 측정. 반증자: 7B non-Qwen 가 Qwen finding 을 BinomialSE 내 replicate → claim 은 family-universal (scaling-law). non-Qwen 7B 가 다른 pattern (예: counting fails at 7B Mistral-VL) → claim 은 Qwen-specific (model anomaly). cycle-28 first-probe: cycle-23c 4-rung TSV 위 closed-form recompute — rung 0+1 (SmolVLM-family) vs rung 2+3 (Qwen-VL-family) per-family slope 분리. SmolVLM 가 monotone-rise + Qwen 가 dip-then-recover 이면 family confound 가 empirically detectable (anecdotal n=2 family pairs). cycle-29+ real fire = InternVL-7B 또는 LLaVA-NeXT-7B rung.

## SANDBOX 활용 (consumer 입장)

> SUBSTRATE 의 capability eval (text scale ladder · multimodal · RLHF) 은 SANDBOX 위에서 — API surface 가 metered + non-deterministic + seed control 없음.

### Readiness Matrix — SUBSTRATE row (SANDBOX.md mirror, 6 axes verbatim)

| axis | harness | model | verdict path |
|------|---------|-------|--------------|
| 4-rung text scale ladder | `bench/sandbox_stage2_persona_scaled_*.hexa` | Qwen2.5-{0.5,1.5,3,7}B-Q4_K_M | `.verdicts/sandbox/stage2_persona*` |
| 2-param logistic 검증자 | `verify/numerics_substrate_cliff_logistic.hexa` | (recompute only) | `.verdicts/sandbox/m4_substrate_formula_fit.txt` |
| multimodal 3-rung smoke | `bench/sandbox_multimodal_smoke.hexa` | SmolVLM-500M | `.verdicts/sandbox/m5_substrate_multimodal_smoke*` |
| multimodal 4-rung ladder | `bench/sandbox_multimodal_ladder.hexa` + `bench/sandbox_p1_multimodal_ladder_7b.hexa` | SmolVLM 0.5/2.2B + Qwen-VL 3/7B | `.verdicts/sandbox/m5_substrate_multimodal_fit*` + `p1_multimodal_ladder_7b*` |
| 4-rung dip-then-recover 검증자 (cycle-24) | `verify/numerics_substrate_multimodal_fit.hexa` (extended 304→499) | (recompute only) | `.verdicts/sandbox/m5_substrate_multimodal_fit_4rung.txt` |
| 50-item subitizing 정교화 (P1 ↑) | `bench/sandbox_p1_subitizing_50item.hexa` | 4-rung VL (mac M3, cycle-25 재실행) | `.verdicts/sandbox/p1_subitizing_50item*` |

### Dispatch surface (consumer 관점)

| rung | host | runtime | 의존 |
|------|------|---------|------|
| 0.5B / 1.5B / 3B text | mac M3 local | llama-server (Metal/UMA) | ggml-org HF GGUF (이미 캐시) |
| SmolVLM-500M / 2.2B multimodal | mac M3 local | llama-server (Metal/UMA, mmproj 포함) | ggml-org HF GGUF (이미 캐시) |
| Qwen-VL 3B / 7B multimodal | mac M3 local | llama-server (Metal/UMA, mmproj 포함) | ggml-org HF GGUF — **7B+ rung 은 추가 모델 DL 필요** (~5GB / rung) |
| non-Qwen-7B VL (InternVL-7B · LLaVA-NeXT-7B) | mac M3 local | llama-server (mmproj) | **신규 DL** — ggml-org 미러 없으면 변환 필요 |

### Quick-fire commands (cycle-25 entry points)

- **P1 50-item 재실행 (smaller subset + wall-cap)** — `hexa.real run bench/sandbox_p1_subitizing_50item.hexa` (mac M3, TIME-CAPPED 변형 — cycle-24 partial → cycle-25 statistical refinement)
- **non-Qwen-7B VL rung 추가** — InternVL-7B / LLaVA-NeXT-7B 신규 rung 측정 → 4-rung dip-then-recover 의 *Qwen-only* artifact 여부 검증 (mac M3, 모델 DL ~5GB)
- **4-rung verifier 결과로 closed-form fit 확장** — `verify/numerics_substrate_multimodal_fit.hexa` (cycle-24 extended 304→499) → 5+ rung 일반화 → axis-별 logistic 재적합 (축 B1)

### Honest invariant

readiness ≠ frontier closure. SUBSTRATE 의 capability frontier 는 **영구 개방** — 새 modality(audio · video · 3D) / 더 큰 scale(70B+) / 새 architecture(MoE · SSM · diffusion-LM) 이 등장할 때마다 다시 열린다 ([[feedback_closure_is_physical_limit]]).

cycle-23c 의 **BREAKTHROUGH** (multimodal 4-rung dip-then-recover, perception 11/11 saturating + counting recovery 가 7B 에서 회복 신호) 와 cycle-24 의 **50-item subitizing partial** (`.verdicts/sandbox/p1_subitizing_50item.tsv`, n 확장으로 SE 좁히는 중) 이 **함께 진행** — BREAKTHROUGH 도 더 큰 n 에서 다시 본다. 한 rung 의 GREEN 은 *현재 arc 의 한 단면* 일 뿐.

cross-link: [`SANDBOX.md`](SANDBOX.md) — `## Substrate Readiness Matrix`.

## Cross-refs

- `.roadmap.hexa_codex` §A.4 — falsifier preregister · §A.2 — release cadence
- `README.md` — Falsifier preregister · Release ladder
- `verify/falsifier_check.py` · `verify/n6_arithmetic.py`
- Sister groups: [`SAFETY.md`](SAFETY.md) · [`ECONOMICS.md`](ECONOMICS.md) · [`OPS.md`](OPS.md)
- 영구 축 원리: [`SANDBOX.md`](SANDBOX.md) · [[feedback_closure_is_physical_limit]]
- SANDBOX consumer 표: 본 도메인 `## SANDBOX 활용 (consumer 입장)` (sibling: [`ECONOMICS.md`](ECONOMICS.md) · [`SAFETY.md`](SAFETY.md) · [`OPS.md`](OPS.md))
