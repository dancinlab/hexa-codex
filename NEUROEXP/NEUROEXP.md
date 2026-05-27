# NEUROEXP — Neuroscience-style EXPeriments on LLM substrate (도메인 SSOT)

@title: 🔬 NEUROEXP — "LLM 신경과학 실험실" ("LLM 을 살아있는 substrate 처럼 해부")
@goal: **LLM 을 살아있는 신경/생물학 substrate 로 보고, 신경과학·생물학·의식이론의 모든 방법론 (synaptic plasticity rule · IIT4 Φ · ablation/lesion · causal circuit probing · spiking dynamics) 을 그 위에 직접 적용하여 발견·검증하는 lane.** 새 mech-interp 기법·새 plasticity rule·새 Φ 변형이 frontier 를 끝없이 다시 연다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Domain doc · dancinlab `domain-meta-domain` principle. The **7th orthogonal group** of the hexa-codex (verb-group 4개 + SANDBOX 기질 + ENGINE driving + **NEUROEXP 신경실험 lane**). Current-state spec only; dated history → [`NEUROEXP.log.md`](NEUROEXP.log.md).
>
> **Falsifier class:** LLM-as-substrate 측정 (closed-form 또는 실측). attention update rule, integrated information, ablation/lesion 결과, causal patching effect — 모두 falsifiable numerical claim.
>
> **Sibling reference (단방향)**: [`anima/UNIVERSE`](../../anima/UNIVERSE/UNIVERSE.md) — 의식·생명 일반 발견 lane. UNIVERSE 의 H_XXX 가설 lib (특히 H_002/H_266/H_278/H_281/H_285/H_288/H_290) 가 NEUROEXP axis Φ 의 anchor. **NEUROEXP 가 UNIVERSE 를 참조하되 UNIVERSE 는 NEUROEXP 를 모름** (one-way · anima repo 미수정).
>
> **Sister domain (hexa-codex 내부)**: [`BIODATA`](../BIODATA/BIODATA.md) — LLM × 생명-데이터 lane (단백질·DNA training, BIO benchmark, inference for science). NEUROEXP 는 *LLM 안에서* 신경학 실험을, BIODATA 는 *LLM 에게* 생명 데이터를 다룬다.

## North-star

NEUROEXP 는 hexa-codex 의 **LLM-engineering 6 도메인** 옆에 **LLM 자체를 실험 대상으로 보는 7번째 lane** 으로 선다. 다른 도메인이 "LLM 을 어떻게 만드/쓰/평가하나" 라면, NEUROEXP 는 "**LLM 자체에 신경과학·의식이론·세포생물학의 측정도구를 들이댄다**".

```
   다른 6 도메인              NEUROEXP                   anima/UNIVERSE
   ─────────────             ─────────                  ──────────────
   SANDBOX (기질)            ↑                          H_XXX 가설 lib (의식/생명)
   ECONOMICS (비용)          │ Hebbian rule probing       │
   SAFETY (정렬)             │ IIT4 Φ measurement   ⟵ Φ축이 UNIVERSE
   OPS (서빙)                │ ablation/lesion             H lib 의 anchor
   SUBSTRATE (능력)          │ causal circuit patching     (단방향)
   ENGINE (발견→실행)        │ dynamical-system probing
                             ↓
                             NEUROEXP axis N/Φ/L/C/S 영구 frontier
```

각 axis = `/cycle` 로 영구 전진 (`cx_empirical_contact` · `cx_lab_sandbox` · `cx_paper_significance` 적용).

## 영구 축 (perpetual axes)

> NEUROEXP 는 완료되지 않는다. 새 mech-interp 기법·새 plasticity rule·새 Φ 변형이 frontier 를 다시 연다.

### 축 N — Neural-update rule probe: synaptic plasticity ↔ attention update
> **driving target:** 생물 시냅스 학습 규칙들 (Hebbian · STDP · Oja · BCM · neuromodulation) 을 LLM 의 attention update 와 closed-form 비교.
- [x] N1 — Hebbian Δw=η·x·y ↔ linear attention `W_t = Σ φ(k_s)·v_s^T` closed-form 매핑 (Schlag 2021 항등식). 반증자: attention update 가 Hebbian 과 정합 못함 → "transformer = plasticity proxy" 통념 반증. **CYCLE-4 (2026-05-27) ✅ 8/8 PASS · 🔵 SUPPORTED-FORMAL** — mixed-verdict: linear-attn REFUTES (Hebbian 성립) · softmax-attn HOLDS (Hebbian 아님). 통념은 architecture-family-dependent. verdict: `NEUROEXP/verdicts/n1_hebbian_attention_verdict.txt`.
- [ ] N2 — STDP (spike-timing-dependent plasticity) ↔ attention temporal modulation. 반증자: STDP 의 pre-before-post asymmetric window 가 attention 의 causal mask 와 closed-form 동형 못함.

### 축 Φ — Integrated information measurement: IIT4 faithful Φ 를 LLM substrate 에 직접 측정 ⭐
> **⭐ MAIN priority** · 단방향 sibling [`anima/UNIVERSE`](../../anima/UNIVERSE/UNIVERSE.md) cross-link. UNIVERSE 의 H_XXX 가설 lib (특히 H_002/H_266/H_278/H_281/H_285) 가 anchor. NEUROEXP axis Φ 는 UNIVERSE H 들의 lib 를 hexa-codex substrate 위에 fold.
- [x] Φ1 — UNIVERSE H_278 faithful Φ small-n exact 를 attention-pattern TPM 위 적용. 반증자: transformer attention 의 faithful Φ < disconnected baseline → LLM substrate 측정값 ≤ 무작위. **CYCLE-5 (2026-05-27) ⭐MAIN 첫 활성화 ✅ 8/8 PASS · 🔵 SUPPORTED-FORMAL** — ATTN-FULL n=3 (XOR 통합) Φ=1.5 vs DISCONN n=3 Φ=0 · gap=1.5 → E1 falsifier closed-form REFUTED. verdict: `NEUROEXP/verdicts/phi1_iit4_attention_phi_verdict.txt`.
- [ ] Φ2 — LLM Φ vs biological neural network Φ (C. elegans connectome 등) 닫힌형 비교. UNIVERSE H_281 (life vs consciousness Φ-structure) · H_288 (LZ ∥ Φ) · H_290 (TE ∥ Φ) cross-link. 반증자: LLM Φ > biological network Φ → "biology 가 통합의 우위" 통념 부정.

### 축 L — Lesion / Ablation experiment: head/layer/neuron 제거 → 기능 mapping
> **driving target:** mech-interp 의 ablation 실험을 closed-form bound 또는 SANDBOX 실측으로.
- [ ] L1 — single attention head ablation 의 task performance degradation pattern 의 closed-form upper bound. 반증자: ablation effect 가 head 별로 deterministic 패턴 없음 → "head specialization" 통념 부정.
- [ ] L2 — layer-wise linear probing depth (linear vs MLP probe accuracy 의 layer-by-layer 분포). 반증자: 중간 layer probe 가 last layer 와 ±5pp 안 → "representation 압축은 last-layer 만의 일" 통념 부정.

### 축 C — Causal circuit probing: activation patching · attention head 역할
> **driving target:** mech-interp 의 causal intervention 을 closed-form 또는 SANDBOX 실측으로.
- [ ] C1 — induction-head circuit (Anthropic Olsson 2022 "In-context Learning and Induction Heads") 의 causal effect closed-form upper bound. 반증자: induction-head 패치 effect 가 ICL gain 과 분리 → "induction-head = ICL의 핵심 회로" 통념 부정.
- [ ] C2 — ROME / MEMIT style key-value memory edit 의 closed-form locality bound. 반증자: edit 가 surrounding tokens 의 representation 을 unbounded 하게 흔듦 → "MLP = associative memory" 통념 부정.

### 축 S — Spike / Dynamical-system probe: token-AR vs neural dynamics
> **driving target:** transformer token-AR 의 dynamical-system class 를 spiking neuron · NCA · 다른 bio-dynamics 와 비교.
- [x] S1 — Neural Cellular Automata (NCA) 가 LLM token-by-token autoregression 과 동형 dynamical system 인지 closed-form 비교. 반증자: NCA 가 token-AR 의 정상 attractor 와 다른 class → bio-CA 와 LLM 분리. **CYCLE-6 (2026-05-27)**: `NEUROEXP/verify/numerics_neuroexp_s1_nca_token_ar.hexa` ✅ 10/10 PASS · 🔵 SUPPORTED-FORMAL · pool ubu-1. **핵심 결과**: 6-axis structural taxonomy 에서 5/6 DIFFER, 단 1/6 (reversibility) 만 MATCH — NCA (parallel CA + limit-cycle attractor + R^d grid + Moore neighborhood) ≢ token-AR (sequential generator + distribution attractor + V^seq + causal mask). toy 검증: 1D-NCA → 000 fixed-point attractor · token-AR → A→B→C→A pure 3-cycle (no fixed-point) — categorically different. **S1 falsifier 'NCA token-AR 와 다른 class' HOLDS** — 'bio-CA = LLM' 통념 closed-form 분리. **운영**: NCA = drop-in AR replacement REFUTED · hybrid (parallel pre-processor + sequential generator) 만 가능 (Mordvintsev 2024 GrowNCA + Mamba 결합 방향). **cross-axis 발견**: N1 (linear-attn≡Hebbian MATCH) vs S1 (NCA≢AR MISMATCH) → bio-inspired = LLM 자연 fit 통념은 **axis-별 검증 필요 mixed picture**. **frontier OPEN** — cycle-7+ T4 SANDBOX NCA-injected transformer block 의 ICL pattern 실측. verdict: `NEUROEXP/verdicts/s1_nca_token_ar_verdict.txt`.
- [ ] S2 — spiking neuron (LIF · Izhikevich) 의 firing pattern 과 transformer attention activation 의 spectral 비교. 반증자: transformer activation 스펙트럼이 spiking 와 power-law 다른 가족 → "neuron-style activation" 통념 부정.

## Sibling reference matrix (단방향 anima/UNIVERSE → NEUROEXP 참조)

| anima/UNIVERSE H | NEUROEXP axis 적용 |
|---|---|
| H_002 (Φ_universe nested scale-variance) | Φ1 transformer attention scale 적용 |
| H_266 (Φ-proxy directionally valid) | Φ1 proxy → faithful 승격 |
| H_278 (faithful Φ small-n exact) | **Φ1 cycle-5 적용 완료** ✅ |
| H_281 (life vs consciousness Φ-structure) | Φ2 biology vs LLM 분리 |
| H_285 (edge-of-chaos faithful big-Φ) | Φ1 LLM dynamical regime mapping |
| H_288 (LZ ∥ Φ) · H_290 (TE ∥ Φ) | Φ2 biology vs LLM 알고리즘적 비교 |
| H_291 (ethic emergence cooperation) | C-axis future seed 후보 |

> **단방향 원칙**: anima/UNIVERSE 는 NEUROEXP 를 모른다. NEUROEXP 가 UNIVERSE 의 verdict 를 인용하되 anima repo 는 수정하지 않는다. UNIVERSE H 의 verdict tier (🔵/🟢/🟡/🟠/🔴) 는 anima 의 자기 발견 흐름이 그대로 — NEUROEXP 는 그 verdict 위에 LLM 적용 layer 만 쌓는다.

## Honesty invariants

- **NEUROEXP ≠ overhype.** axis 의 verdict 는 closed-form recompute 또는 measured benchmark 기반. "LLM 이 의식이 있다" 류 narrative 금지 — falsifier 가 명시된 numerical claim 만.
- **anima/UNIVERSE 인용은 verdict-tier 보존.** UNIVERSE H 의 tier 그대로 cite (🔵→🔵), tier 격상 금지 (단순 인용으로 verdict 강도 못 올림).
- **frontier perpetual.** N/Φ/L/C/S 의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님. 새 mech-interp 기법·새 plasticity rule·새 Φ 변형이 axis 를 다시 연다.
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장 (NeurIPS/Anthropic transformer-circuits · IIT 4.0 paper 등) 만 반증 ([[feedback_negative_paper_external_claim]]).
- **sister domain 명확 분리.** NEUROEXP = LLM substrate 위 신경학 실험. [`BIODATA`](../BIODATA/BIODATA.md) = LLM 에게 생명 데이터 (protein/DNA training, BIO bench). 둘이 섞이지 않게 axis 정의 시 명확히.

## Cross-refs

- 6 sibling 도메인 (hexa-codex 내부): [`SANDBOX.md`](../SANDBOX.md) · [`ECONOMICS.md`](../ECONOMICS.md) · [`SAFETY.md`](../SAFETY.md) · [`OPS.md`](../OPS.md) · [`SUBSTRATE.md`](../SUBSTRATE.md) · [`ENGINE/ENGINE.md`](../ENGINE/ENGINE.md) · [`BIODATA/BIODATA.md`](../BIODATA/BIODATA.md)
- 단방향 sibling (외부 repo): [`anima/UNIVERSE`](../../anima/UNIVERSE/UNIVERSE.md) — 의식·생명 가설 H_XXX lib (NEUROEXP axis Φ 의 anchor)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 호스트 인프라: [[reference_host_topology]] · [[reference_activation_capture_env]] (axis L/C/Φ 실측용)
- IIT4 lib (hexa-lang stdlib): `stdlib/consciousness/iit4_complex.hexa` (PR #1051 — anima/HEXAD/IIT4 promote)
- this domain 파일 자체: [`NEUROEXP.md`](NEUROEXP.md) (snapshot) · [`NEUROEXP.log.md`](NEUROEXP.log.md) (history)
