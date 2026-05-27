# BIO — log

Append-only history sister of `BIO.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.


## 2026-05-27 — cycle-3 A2 first probe · vocab size effect on LLM capacity · 🔵 SUPPORTED-FORMAL 8/8 ('V 무관' REFUTED)

BIO 도메인 cycle-3. A2 = 어휘 크기 V (text 50k vs protein 20-amino vs DNA 4-nt) 가
LLM capacity 요구에 미치는 닫힌형 영향. A1 (protein scaling-law 가족 분리) 이후
"왜 protein/DNA LLM 이 다른 scaling 을 따르는가" 의 구조적 한 axis 를 닫는다.

**검증기**: `BIO/verify/numerics_bio_a2_vocab_size_capacity.hexa` (190 lines)
**RUN**: pool ubu-1 native compile (cycle-44/46-50+cycle-2 검증 `hexa cc` 패턴 8번째 적용).

**8/8 PASS (verbatim)**:
- embed params (2·V·d_model, d=1024): text 102.4M · protein 41K · DNA 8K
- text/protein embed ratio = 2500× (= V_text/V_protein)
- protein/DNA embed ratio = 5× (= V_protein/V_DNA)
- attention/layer (n²·d): text 921k · protein 92M (100× text) · DNA 829M (900× text)
- DNA attn = 900× text (sequence² scaling, (900/30)² 정확)
- V 2× → embed 2× (LOAD-BEARING) → **'V 무관' 반증자 REFUTED**
- total cost (embed + 32·attn): DNA 26.5G > protein 2.95G > text 132M
- 결정론 ✓

**verdict tier**: 🔵 SUPPORTED-FORMAL (V·d_model embed + n²·d attention 구조적 항등식, 8/8).

**핵심 발견 (operational implication)**:
1. **V 는 capacity 식에서 LOAD-BEARING** — embed = 2·V·d (선형). 'V 무관' 반증자 closed-form REFUTED.
2. **그러나 trade-off 가 결정**: 작은 V 는 embed 절약 (text 102M → DNA 8K, 12500×) 하되
   동일 content 에 더 긴 sequence (text 30 → DNA 900) → attention n² 비용 폭발 (900× text).
3. **32-layer 합산에서 attention 이 지배** — DNA 26.5G > protein 2.95G > text 132M.
4. **운영 closed-form 결론**:
   - ESM2 V=20 amino = protein-LLM 의 sweet spot (41K embed vs ~300 seq 균형)
   - DNA-LLM (V=4) 은 표준 MHA 비현실 → Mamba/Caduceus 같은 **linear-attention 필수**
   - 'tokenization 은 전처리에 불과' 통념 REFUTED — V 가 viable architecture 를 좁힌다

**honest residual**:
- V·d embed + n²·d attention = 🔵 closed-form structural identity (재계산 결정론).
- 가정한 sequence 길이 (text 30 / protein 300 / DNA 900) = TYPICAL operating points (실측 X).
  실제 content-equivalent 길이는 task/domain 에 따라 ±factor 변동 — directional 결론은 robust.
- d_model=1024 = 현대 mid-range; 더 큰 d 는 embed 항 비중 ↑ → V 영향 더 큼.
- cycle-4+ T4: SANDBOX 위 3 tokenization × 동일 corpus 실측 perplexity-per-byte ladder
  → empirical V-vs-capacity 곡선 (citation-free).
- external anchor: Lin 2023 ESM2 (V=20) · DNABERT (V=4) · Caduceus (V=4 + Mamba) · Llama3 (V≈128k).
- A2 frontier OPEN ([[feedback_closure_is_physical_limit]]): structural close ≠ measured close.
  새 tokenizer 가족 (SAX · 음성 unit · multi-modal) 이 axis 를 다시 연다.

**연결**:
- verifier: [`BIO/verify/numerics_bio_a2_vocab_size_capacity.hexa`](verify/numerics_bio_a2_vocab_size_capacity.hexa)
- verdict: [`BIO/verdicts/a2_vocab_size_capacity_verdict.txt`](verdicts/a2_vocab_size_capacity_verdict.txt)
- 직접 reuse: A1 cycle-2 의 "BIO 별도 scaling 가족" 결론에 *구조적* 원인 한 축 제공
  (V 가 embed/attention trade-off 를 좁혀 architecture 선택을 강제 → 같은 (N,D) 라도 효과적 capacity 다름)
- 다음 순차: B1 (MedQA T4 cost-bearing) · E1 (UNIVERSE H_278 IIT4 on Qwen layer) · C1 (drug repurposing)

---

## 2026-05-27 — cycle-2 A1 first probe · protein-LLM scaling vs text Hoffmann · 🔵+🟡+🟠 9/9 (DISTINCT family 확정)

BIO 도메인 첫 first-probe. A1 = protein-LLM (ESM2) scaling-law α 가 text Hoffmann α 와
얼마나 다른지 closed-form 비교. ECONOMICS C1 cycle-43 Lagrangian 직접 응용 (cross-domain reuse).

**검증기**: `BIO/verify/numerics_bio_a1_protein_llm_scaling.hexa`
**RUN**: pool ubu-1 native compile (cycle-44/46-50 검증 `hexa cc` 패턴).

**9/9 PASS (verbatim)**:
- text Hoffmann α+β = 0.62 (C1 cycle-43 reference)
- ESM2 α_protein ≈ 0.10 (Lin 2023 5-rung 8M→15B perplexity-vs-params 로그-로그 slope ≈ -0.11)
- ε = |α_text − α_protein| = 0.24 ≫ 0.05 (A1 falsifier threshold) → MEETS
- BIO scaling = DISTINCT family (closed-negative on "protein-LLM follows text Chinchilla")
- N_opt exp text 0.4516 vs protein 0.7368 → protein STEEPER N scaling
- D_opt exp text 0.5483 vs protein 0.2631 → protein SHALLOWER D scaling
- duality a+b ≈ 1.0 for both families (Lagrangian conservation)
- D/N C-exp text +0.097 (grows) vs protein NEGATIVE (-0.4736 shrinks) — OPPOSITE trends
- 결정론 ✓

**verdict tier**: 🔵 STRUCTURAL (Lagrangian 9/9) + 🟡 α-by-citation (Lin 2023) + 🟠 β-assumed.

**핵심 발견 (operational implication)**:
1. **protein-LLM 은 text Chinchilla 가족이 아님** — ε=0.24 ≫ 0.05 threshold.
2. **D/N C-exp 부호까지 반대** (+0.097 vs −0.474): text 는 compute 늘수록 D/N 약간 증가
   (overtrain), protein 은 compute 늘수록 D/N **감소** (under-train) → 최적이 정반대 방향.
3. **운영 closed-negative**: BIO compute 계획에 text α/β (Hoffmann ~20:1 D/N rule) 적용하면
   잘못된 deeply over-trained 모델 산출. ESM2 같은 protein-LLM 은 더 많은 parameters,
   더 적은 data 가 compute-optimal.

**honest residual**:
- Lagrangian shift algebra = 🔵 closed-form (C1 cycle-43 reuse, deterministic).
- α_protein ≈ 0.10 = 🟡 BY-CITATION (Lin 2023 ESM2 ladder ballpark; 자체 recompute X).
- β_protein = β_text 가정 = 🟠 PARTIAL (β 독립 fit 안 함; β_protein ∈ (0,1) 어떤 값이든
  DIRECTIONAL 결론 robust — α_protein ≪ α_text 면 distinct family 유지).
- cycle-3+ T4: ESM2 checkpoint loss recompute (5 sizes × multi-D points) → 독립 (α,β) fit
  → directional finding 확인.
- external anchor: Lin 2023 (arXiv:2206.13517) · Hoffmann 2022 (arXiv:2203.15556).
- A1 frontier OPEN: citation-based close ≠ own-fit close.

**연결**:
- verifier: [`BIO/verify/numerics_bio_a1_protein_llm_scaling.hexa`](verify/numerics_bio_a1_protein_llm_scaling.hexa)
- verdict: [`BIO/verdicts/a1_protein_llm_scaling_verdict.txt`](verdicts/a1_protein_llm_scaling_verdict.txt)
- 직접 reuse: ECONOMICS C1 cycle-43 Hoffmann Lagrangian closed-form
- 다음 순차: A2 (어휘크기) · B1 (MedQA T4) · E1 (UNIVERSE H_278 IIT4 on Qwen layer)

---

## 2026-05-27 — cycle-1 BIO 도메인 init (7번째 orthogonal group)

**사용자 지시:** "BIO 도메인 만들자 LLM 에 BIO 를 접목해보는 실험, anima/UNIVERSE 도메인참고 ... 슬리브링 도메인으로 ... BIO → anima UNIVERSE 일방적으로 sibling ... 단방향".

hexa-codex 의 7번째 orthogonal group 으로 BIO 도메인 신설. 다른 6 도메인이 "LLM 자체"
를 다루는 반면 BIO 는 **"LLM × 생명 데이터·구조·평가의 교차"** 를 다룬다.

### Init artifacts

- [x] `BIO/BIO.md` — 도메인 SSOT (5 영구 axes A-E)
- [x] `BIO/BIO.log.md` — append-only history (이 파일)
- [x] `DOMAINS.tape` 에 `@domain BIO := "./BIO/BIO.md"` 추가
- [x] **단방향 sibling 참조**: BIO → [`anima/UNIVERSE`](../../anima/UNIVERSE/UNIVERSE.md) 명시.
  anima/UNIVERSE 는 BIO 를 모름 (anima repo 수정 안 함).

### 5 영구 axes (전부 OPEN, frontier 영구)

| axis | scope | falsifier class |
|------|-------|-----------------|
| **A** | BIO-data LLM training (ESM / protein-LLM / DNA-LLM scaling law) | A1 protein-LLM Chinchilla 일치 · A2 어휘 크기 effect |
| **B** | BIO reasoning benchmarks (MedQA · PubMedQA · BioASQ · ESM2 zero-shot) | B1 domain-specific 갭 · B2 RAG vs 전용 protein LLM |
| **C** | BIO inference for science (drug repurposing · target ID · structure intuition) | C1 LLM accuracy ≈ random · C2 helix/sheet 분류 ≤ chance |
| **D** | Bio-inspired LLM architecture (Hebbian · NCA · spiking) | D1 attention vs Hebbian Δw · D2 NCA vs token-AR dynamical class |
| **E** ⭐ | **BIO × IIT4 (anima/UNIVERSE cross-link MAIN)** — LLM 자체의 Φ 측정 · biology vs transformer Φ 비교 | E1 transformer attention Φ < disconnected baseline · E2 LLM Φ > bio neural Φ |

### Sibling reference matrix (단방향)

anima/UNIVERSE 의 H_002 · H_266 · H_278 · H_281 · H_285 · H_288 · H_290 · H_291 등을 BIO
axis E 의 anchor 로 cite. UNIVERSE 의 verdict tier 그대로 보존 (격상 금지).

### 영구 axis 의미

cycle-1 = init only. 어떤 axis 의 `[x]` flip 도 없음. 다음 cycle 부터:
- cycle-2+ axis E1 first probe (UNIVERSE H_278 faithful-Φ-small-n 을 Qwen2.5-1.5B layer 위 적용)
- cycle-3+ axis B1 first probe (MedQA on Qwen2.5-1.5B-Q4 vs PMC-LLaMA · cost-bearing T4)
- cycle-4+ axis A1 first probe (ESM2 scaling law re-fit vs Hoffmann α/β · WebFetch + closed-form)

### Honesty invariants 적용

- BIO 의 모든 verdict 는 closed-form recompute 또는 measured benchmark 기반.
- anima/UNIVERSE verdict 인용은 tier 그대로 (🔵→🔵), tier 격상 금지.
- closed-negative paper 는 외부 published BIO 주장 (Nature/Science/ESM/AlphaFold) 만 반증.
- frontier perpetual ([[feedback_closure_is_physical_limit]]).

### 연결

- this domain SSOT: [`BIO.md`](BIO.md)
- 단방향 sibling: [`anima/UNIVERSE/UNIVERSE.md`](../../anima/UNIVERSE/UNIVERSE.md)
- DOMAINS.tape roster: `@domain BIO := "./BIO/BIO.md"`
- 6 sibling 도메인 (hexa-codex 내부): SANDBOX · ECONOMICS · SAFETY · OPS · SUBSTRATE · ENGINE
