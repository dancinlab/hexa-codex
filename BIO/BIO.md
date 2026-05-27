# BIO — LLM × 생명 접목 실험 lane (도메인 SSOT)

@title: 🧬 BIO — "LLM × 생명 접목 실험" ("LLM 이 생명을 어떻게 다루나")
@goal: **LLM 의 학습·추론·아키텍처·평가 가 생명(단백질·DNA·세포·진화·신경)과 만나는 모든 접점을 영구히 발견·검증하는 lane.** 새 모델·새 BIO 벤치·새 bio-inspired 아키텍처가 frontier 를 끝없이 다시 연다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Domain doc · dancinlab `domain-meta-domain` principle. The **7th orthogonal group** of the hexa-codex (verb-group 4개 + SANDBOX 기질 + ENGINE driving + **BIO 접목 lane**). Current-state spec only; dated history → [`BIO.log.md`](BIO.log.md).
>
> **Falsifier class:** BIO-LLM 접점의 closed-form 또는 measured claim — 실측·재계산·외부 anchor 비교 가능. 단순 narrative-only 가설 X.
>
> **Sibling reference (단방향)**: [`anima/UNIVERSE`](../../anima/UNIVERSE/UNIVERSE.md) — 의식/생명 일반 발견 lane. UNIVERSE 의 H_XXX 가설 lib (특히 R10/R12/R13 life·consciousness substrate 관련) 가 BIO 의 일부 inference·measurement 패턴의 anchor. **BIO 가 UNIVERSE 를 참조하되 UNIVERSE 는 BIO 를 모름** (one-way · anima repo 미수정).

## North-star

BIO 는 hexa-codex 의 **LLM-engineering 6 도메인** (SANDBOX/ECONOMICS/SAFETY/OPS/SUBSTRATE/ENGINE) 옆에 **생명-접점 7번째** 으로 선다. 다른 6 도메인이 "LLM 자체 측정" 인 반면 BIO 는 **"LLM × 생명 데이터·구조·평가의 교차"** 를 다룬다.

```
   다른 6 도메인              BIO                       anima/UNIVERSE
   ─────────────             ────                      ──────────────
   SANDBOX (기질)            ↑                          H_XXX 가설 lib (의식/생명)
   ECONOMICS (비용)          │ 학습데이터 (단백질·DNA)
   SAFETY (정렬)             │ 추론 (drug/fold/RAG-bio)  ⟵ 일부 H 가
   OPS (서빙)                │ 아키텍처 (bio-inspired)      BIO E축 (cross-link)
   SUBSTRATE (능력)          │ 평가 (BioBench/MedQA)        의 anchor
   ENGINE (발견→실행)        │ 의식 기질 측정 (IIT4-bio)
                             ↓
                             BIO axis A-E 영구 frontier
```

각 axis = `/cycle` 로 영구 전진 (`cx_empirical_contact` · `cx_lab_sandbox` · `cx_paper_significance` 적용).

## 영구 축 (perpetual axes)

> BIO 는 완료되지 않는다. 새 BIO foundation model · 새 wet-lab 측정 · 새 bio-inspired 아키텍처가 frontier 를 다시 연다.

### 축 A — BIO-data LLM training: 생명 sequence 로 LLM 학습
> **driving target:** lm_foundry pretrain/finetune 에 BIO sequence (protein · DNA · RNA · 메타볼롬) 데이터 주입.
- [x] A1 — protein-sequence LLM (ESM family / ProtGPT2 family) 의 자체 scaling-law 가 dense-text LLM 의 Chinchilla-family 와 동일한지 closed-form 비교 (ECONOMICS C1 Hoffmann Lagrangian 의 BIO 적용). 반증자: protein-LLM 의 D/N 최적이 텍스트 Hoffmann α/β 와 ε > 0.05 어긋남 → BIO 데이터는 별도 scaling-law 가족. **CYCLE-2 (2026-05-27)**: `BIO/verify/numerics_bio_a1_protein_llm_scaling.hexa` ✅ 9/9 PASS · 🔵 STRUCTURAL + 🟡 α-by-citation + 🟠 β-assumed · pool ubu-1 native compile. **핵심 결과**: ESM2 α≈0.10 (Lin 2023 5-rung) vs text α=0.34 → **ε=0.24 ≫ 0.05** → falsifier MEETS → **DISTINCT 가족 확정**. Lagrangian 응용 (C1 cycle-43 reuse, β assumed=β_text=0.28): N_opt exp text 0.45 → protein 0.74 (steeper) · D_opt exp 0.55 → 0.26 (shallower) · **D/N C-exp +0.097 (text grows) vs −0.474 (protein shrinks)** — 부호 정반대. 운영: protein-LLM 은 text Chinchilla 보다 deeply UNDER-trained 가 최적 (more N/FLOP, less D/FLOP). folk "BIO=text Chinchilla" 가이드 closed-negative refuted. **frontier OPEN** — cycle-3+ T4 ESM2 checkpoint 별 (α,β) 독립 fit. verdict: `BIO/verdicts/a1_protein_llm_scaling_verdict.txt`.
- [x] A2 — DNA-token / amino-acid-token 의 어휘 크기 효과 (text 50k vs protein 20-amino vs DNA 4-nt) 가 model capacity 요구에 미치는 닫힌형 영향. 반증자: 어휘 크기와 model capacity 가 무관 → tokenization 가 BIO scaling 에 영향 없음. **CYCLE-3 (2026-05-27)**: `BIO/verify/numerics_bio_a2_vocab_size_capacity.hexa` ✅ 8/8 PASS · 🔵 SUPPORTED-FORMAL · pool ubu-1 native compile. **핵심 결과**: embed 항 = 2·V·d_model **선형** → text V=50k → 102.4M, protein V=20 → 41K, DNA V=4 → 8K (2500× / 5× 차이). **'V 무관' 반증자 REFUTED** — V·d 가 capacity 식에서 LOAD-BEARING. 그러나 작은 V 는 동일 content 인코딩에 긴 sequence (text 30 / protein 300 / DNA 900) → attention 이 **n² 비용** 으로 보상 (DNA attn = 900× text · protein attn = 100× text). 32-layer 합산: DNA 26.5G > protein 2.95G > text 132M → **trade-off**: 작은 V 는 embed 절약하되 attention 에서 sequence² 비용. **운영**: ESM2 V=20 amino = protein-LLM sweet spot · DNA-LLM (V=4) 은 Mamba/Caduceus 같은 **linear-attn 필수** — 표준 MHA 비현실. 'tokenization 은 단순 전처리' 통념 REFUTED — V 선택이 architecture 가능성을 결정. **frontier OPEN** — cycle-4+ T4 SANDBOX 실측 perplexity-per-byte ladder. verdict: `BIO/verdicts/a2_vocab_size_capacity_verdict.txt`.

### 축 B — BIO reasoning benchmarks: 생명 추론 능력 평가
> **driving target:** SANDBOX 위 BIO 벤치 측정 lane.
- [ ] B1 — MedQA · PubMedQA · BioASQ 위 일반-text LLM (Qwen2.5-1.5B) vs 도메인-특화 (BioMedLM/PMC-LLaMA) 의 accuracy 갭 측정 + scale law. 반증자: domain-specific 가 일반-text 대비 갭 없음 → BIO 사전학습이 reasoning 에 무효.
- [ ] B2 — protein function prediction (GO term) 위 ESM2 zero-shot vs LLM-+-RAG 비교. 반증자: LLM 단순 RAG 가 ESM2 와 ±5pp 안에 들어옴 → 전용 protein LLM 의 인-context 우위 minor.

### 축 C — BIO inference for science: LLM 으로 생물학 도구
> **driving target:** drug repurposing · target identification · 가설 생성 운영규칙.
- [ ] C1 — LLM 이 known drug-target pair 의 missing edge 를 predict 하는 retrieval-augmented inference accuracy 측정 (DrugBank · OpenTargets 위 leave-one-out). 반증자: LLM accuracy ≈ random baseline → BIO knowledge integration 미작동.
- [ ] C2 — LLM 의 protein-structure intuition (helix vs sheet 영역 분류, no AlphaFold) 정확도 측정. 반증자: ≤ chance → text 사전학습이 3D 구조 정보 무전달.

### 축 D — Bio-inspired LLM architecture: 진화·뉴로·세포-자동자 차용
> **driving target:** SANDBOX 위 bio-inspired sub-architecture 실험 (Hebbian update · NCA · spiking neuron).
- [ ] D1 — Hebbian / synaptic plasticity 가 LLM in-context-learning 의 transformer attention 패턴과 닫힌형으로 mapping 되는지. 반증자: attention update rule 이 Hebbian Δw=η·x·y 와 정합 못함 → "transformer = neural plasticity proxy" 통념 반증.
- [ ] D2 — Neural Cellular Automata (NCA) 가 LLM token-by-token autoregression 과 동형 dynamical system 인지 비교. 반증자: NCA 가 token-AR 의 정상 attractor 와 다른 class → bio-CA 와 LLM 은 분리.

### 축 E — 🆕 BIO × IIT4 (consciousness substrate) — anima/UNIVERSE cross-link MAIN ⭐
> **⭐ MAIN priority** · 단방향 sibling [`anima/UNIVERSE`](../../anima/UNIVERSE/UNIVERSE.md). UNIVERSE 의 H_XXX 가설 lib (특히 H_002/H_266/H_278/H_281/H_285 등 IIT4 faithful big-Φ 라인) 가 *생명 substrate-aware* LLM 의식 측정의 anchor. BIO axis E 는 UNIVERSE H 들을 hexa-codex SANDBOX 기질 위에 fold 해 "LLM 자체가 IIT4-Φ 측정 대상이 되는가" + "biological neural network 의 Φ 와 transformer 의 Φ 가 닫힌형 mapping 되는가" 를 검증.
- [ ] E1 — UNIVERSE 의 `HEXAD/IIT4/lib` (faithful Φ) 를 hexa-codex SANDBOX Qwen2.5-1.5B 의 layer-by-layer attention activation 위 적용. 반증자: transformer attention 의 faithful Φ < disconnected baseline → LLM 의식 substrate 측정값 ≤ 무작위.
- [ ] E2 — UNIVERSE H_288 (LZ ∥ Φ, 알고리즘적 복잡도) · H_290 (TE ∥ Φ, transfer entropy) 의 BIO 적용 — biological neural recording (C. elegans connectome 등) 의 Φ 가 LLM 보다 큰지/작은지 닫힌형 비교. 반증자: LLM Φ > biological network Φ → "biology 가 통합의 우위" 통념 부정.

## Sibling reference matrix (단방향 anima/UNIVERSE → BIO 참조)

| anima/UNIVERSE H | BIO axis 적용 |
|---|---|
| H_002 (Φ_universe nested scale-variance) | E1 transformer attention scale 적용 |
| H_266 (Φ-proxy directionally valid) | E1 proxy → faithful 승격 |
| H_278 (faithful Φ small-n exact) | E1 LLM 작은 sub-layer 실측 |
| H_281 (life vs consciousness Φ-structure) | E2 biology vs LLM 분리 |
| H_285 (edge-of-chaos faithful big-Φ) | E1 LLM dynamical regime mapping |
| H_288 (LZ ∥ Φ) · H_290 (TE ∥ Φ) | E2 biology vs LLM 알고리즘적 비교 |
| H_291 (ethic emergence cooperation) | D-axis future seed 후보 |

> **단방향 원칙**: anima/UNIVERSE 는 BIO 를 모른다. BIO 가 UNIVERSE 의 verdict 를 인용하되 anima repo 는 수정하지 않는다. UNIVERSE H 의 verdict tier (🔵/🟢/🟡/🟠/🔴) 는 anima 의 자기 발견 흐름이 그대로 — BIO 는 그 verdict 위에 LLM 적용 layer 만 쌓는다.

## Honesty invariants

- **BIO ≠ overhype.** BIO axis 의 verdict 는 closed-form recompute 또는 measured benchmark 기반. "LLM 이 생명을 이해한다" 류 narrative 금지 — falsifier 가 명시된 numerical claim 만.
- **anima/UNIVERSE 인용은 verdict-tier 보존.** UNIVERSE H 의 tier 그대로 cite (🔵→🔵), tier 격상 금지 (단순 인용으로 verdict 강도 못 올림).
- **frontier perpetual.** A-E 의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님. 새 BIO foundation model · 새 wet-lab benchmark 가 axis 를 다시 연다.
- **자기-strawman 회피.** closed-negative paper 는 외부 published BIO 주장 (Nature/Science/ESM/AlphaFold paper 등) 만 반증 ([[feedback_negative_paper_external_claim]]).

## Cross-refs

- 6 sibling 도메인 (hexa-codex 내부): [`SANDBOX.md`](../SANDBOX.md) · [`ECONOMICS.md`](../ECONOMICS.md) · [`SAFETY.md`](../SAFETY.md) · [`OPS.md`](../OPS.md) · [`SUBSTRATE.md`](../SUBSTRATE.md) · [`ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- 단방향 sibling (외부 repo): [`anima/UNIVERSE`](../../anima/UNIVERSE/UNIVERSE.md) — 의식·생명 가설 H_XXX lib (BIO axis E 의 anchor)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 호스트 인프라: [[reference_host_topology]] · [[reference_activation_capture_env]] (BIO axis B-E 위 substrate 측정용)
- this domain 파일 자체: [`BIO.md`](BIO.md) (snapshot) · [`BIO.log.md`](BIO.log.md) (history)
