# BIODATA — LLM × 생명 데이터 lane (도메인 SSOT)

@title: 🧬 BIODATA — "LLM 에게 생명을 먹이는 lane" ("LLM × 단백질·DNA·BIO bench")
@goal: **LLM 의 학습 데이터·평가 벤치·추론 도구로서 생명 (단백질·DNA·RNA·메타볼롬·MedQA·drug-target) 을 다루는 모든 접점을 영구히 발견·검증하는 lane.** 새 BIO foundation model·새 wet-lab benchmark·새 BIO inference task 가 frontier 를 끝없이 다시 연다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Domain doc · dancinlab `domain-meta-domain` principle. The **8th orthogonal group** of the hexa-codex (verb-group 4개 + SANDBOX 기질 + ENGINE driving + NEUROEXP 실험 lane + **BIODATA 생명-데이터 lane**). Current-state spec only; dated history → [`BIODATA.log.md`](BIODATA.log.md).
>
> **Falsifier class:** LLM-as-BIO-tool 측정 (closed-form scaling law 또는 measured benchmark). 단백질 LLM scaling, MedQA accuracy gap, drug-target retrieval precision — 모두 falsifiable numerical claim.
>
> **Sister domain (hexa-codex 내부)**: [`NEUROEXP`](../NEUROEXP/NEUROEXP.md) — LLM substrate 위 신경과학 실험 lane (Hebbian·IIT4 Φ·ablation·circuit probe). BIODATA 는 *LLM 에게* 생명 데이터를 주거나 BIO 도구로 쓰는 반면, NEUROEXP 는 *LLM 자체* 에 신경학적 실험을 한다. 두 lane 의 명확 분리.

## North-star

BIODATA 는 hexa-codex 의 **LLM-engineering 6 도메인** 옆에 **LLM × 생명-데이터 8번째 lane** 으로 선다. NEUROEXP 가 "LLM 을 살아있는 substrate 로 보고 실험" 이라면, BIODATA 는 "**LLM 에게 생명 데이터를 먹이거나 BIO 도구로 쓴다**".

```
   다른 6 도메인              BIODATA                    sister NEUROEXP
   ─────────────             ─────────                  ─────────────
   SANDBOX (기질)            ↑                          ↑
   ECONOMICS (비용)          │ 학습데이터 (단백질·DNA)    │ Hebbian/Φ/ablation/circuit
   SAFETY (정렬)             │ 추론 (drug/fold/RAG-bio)   │ (LLM 자체에 실험)
   OPS (서빙)                │ 평가 (MedQA·BioASQ)
   SUBSTRATE (능력)          │                            ⟵ 두 lane 명확 분리
   ENGINE (발견→실행)        │
                             ↓
                             BIODATA axis A·B·C 영구 frontier
```

각 axis = `/cycle` 로 영구 전진 (`cx_empirical_contact` · `cx_lab_sandbox` · `cx_paper_significance` 적용).

## 영구 축 (perpetual axes)

> BIODATA 는 완료되지 않는다. 새 BIO foundation model · 새 wet-lab benchmark · 새 BIO inference task 가 frontier 를 다시 연다.

### 축 A — BIO-data LLM training: 생명 sequence 로 LLM 학습
> **driving target:** lm_foundry pretrain/finetune 에 BIO sequence (protein · DNA · RNA · 메타볼롬) 데이터 주입 · scaling law 측정.
- [x] A1 — protein-sequence LLM (ESM family / ProtGPT2 family) 의 자체 scaling-law 가 dense-text LLM 의 Chinchilla-family 와 동일한지 closed-form 비교 (ECONOMICS C1 Hoffmann Lagrangian 의 BIO 적용). 반증자: protein-LLM 의 D/N 최적이 텍스트 Hoffmann α/β 와 ε > 0.05 어긋남 → BIO 데이터는 별도 scaling-law 가족. **CYCLE-2 (2026-05-27, 구 BIO/A1 이관)**: `BIODATA/verify/numerics_biodata_a1_protein_llm_scaling.hexa` ✅ 9/9 PASS · 🔵 STRUCTURAL + 🟡 α-by-citation + 🟠 β-assumed · pool ubu-1. **핵심 결과**: ESM2 α≈0.10 vs text α=0.34 → ε=0.24 ≫ 0.05 → DISTINCT 가족 확정. D/N C-exp 부호까지 반대 (+0.097 text vs −0.474 protein). 운영: protein-LLM 은 text Chinchilla 보다 deeply UNDER-trained 가 최적. **frontier OPEN** — cycle-3+ T4 ESM2 checkpoint 별 (α,β) 독립 fit. verdict: `BIODATA/verdicts/a1_protein_llm_scaling_verdict.txt`.
- [x] A2 — DNA-token / amino-acid-token 의 어휘 크기 효과 (text 50k vs protein 20-amino vs DNA 4-nt) 가 model capacity 요구에 미치는 닫힌형 영향. 반증자: 어휘 크기와 model capacity 가 무관 → tokenization 가 BIO scaling 에 영향 없음. **CYCLE-3 (2026-05-27, 구 BIO/A2 이관)**: `BIODATA/verify/numerics_biodata_a2_vocab_size_capacity.hexa` ✅ 8/8 PASS · 🔵 SUPPORTED-FORMAL · pool ubu-1. **핵심 결과**: embed = 2·V·d 선형 → 'V 무관' 반증자 REFUTED. text 102.4M / protein 41K / DNA 8K (2500× / 5× ratios). 작은 V 는 sequence² 비용으로 attention 에서 보상 (DNA attn = 900× text). **운영**: ESM2 V=20 = protein sweet spot · DNA-LLM 은 Mamba/Caduceus 같은 linear-attn 필수. verdict: `BIODATA/verdicts/a2_vocab_size_capacity_verdict.txt`.

### 축 B — BIO reasoning benchmarks: 생명 추론 능력 평가
> **driving target:** SANDBOX 위 BIO 벤치 측정 lane.
- [ ] B1 — MedQA · PubMedQA · BioASQ 위 일반-text LLM (Qwen2.5-1.5B) vs 도메인-특화 (BioMedLM/PMC-LLaMA) 의 accuracy 갭 측정 + scale law. 반증자: domain-specific 가 일반-text 대비 갭 없음 → BIO 사전학습이 reasoning 에 무효.
- [ ] B2 — protein function prediction (GO term) 위 ESM2 zero-shot vs LLM-+-RAG 비교. 반증자: LLM 단순 RAG 가 ESM2 와 ±5pp 안에 들어옴 → 전용 protein LLM 의 인-context 우위 minor.

### 축 C — BIO inference for science: LLM 으로 생물학 도구
> **driving target:** drug repurposing · target identification · 가설 생성 운영규칙.
- [ ] C1 — LLM 이 known drug-target pair 의 missing edge 를 predict 하는 retrieval-augmented inference accuracy 측정 (DrugBank · OpenTargets 위 leave-one-out). 반증자: LLM accuracy ≈ random baseline → BIO knowledge integration 미작동.
- [ ] C2 — LLM 의 protein-structure intuition (helix vs sheet 영역 분류, no AlphaFold) 정확도 측정. 반증자: ≤ chance → text 사전학습이 3D 구조 정보 무전달.

## Honesty invariants

- **BIODATA ≠ overhype.** 모든 axis verdict 는 closed-form scaling law 또는 measured benchmark 기반. "LLM 이 생명을 이해한다" 류 narrative 금지.
- **scaling-law 인용 vs recompute 구분 명시.** 외부 paper (Lin 2023 ESM2 · Hoffmann 2022 등) 의 α/β 값을 인용 시 🟡 BY-CITATION; 직접 fit 시 🟢 NUMERICAL.
- **frontier perpetual.** A/B/C 의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님. 새 BIO foundation model · 새 wet-lab benchmark 가 axis 를 다시 연다.
- **자기-strawman 회피.** closed-negative paper 는 외부 published BIO 주장 (Nature/Science/ESM/AlphaFold paper 등) 만 반증 ([[feedback_negative_paper_external_claim]]).
- **sister domain 명확 분리.** BIODATA = LLM × 생명-데이터·벤치·도구. [`NEUROEXP`](../NEUROEXP/NEUROEXP.md) = LLM substrate 위 신경학 실험. 둘이 섞이지 않게 axis 정의 시 명확히.

## Cross-refs

- 6 sibling 도메인 (hexa-codex 내부): [`SANDBOX.md`](../SANDBOX.md) · [`ECONOMICS.md`](../ECONOMICS.md) · [`SAFETY.md`](../SAFETY.md) · [`OPS.md`](../OPS.md) · [`SUBSTRATE.md`](../SUBSTRATE.md) · [`ENGINE/ENGINE.md`](../ENGINE/ENGINE.md) · [`NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 호스트 인프라: [[reference_host_topology]] (B/C axis cost-bearing T4 실측용)
- ECONOMICS C1 Hoffmann Lagrangian (A1 의 응용 source): `ECONOMICS/verify/numerics_hoffmann_lagrangian.hexa`
- this domain 파일 자체: [`BIODATA.md`](BIODATA.md) (snapshot) · [`BIODATA.log.md`](BIODATA.log.md) (history)
