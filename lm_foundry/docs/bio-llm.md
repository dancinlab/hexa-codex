# `bio` — HEXA-BIO domain LLM recipe

> **Foundry verb.** Research recipe for a biology-domain LLM paired with
> [`hexa-bio`](https://github.com/dancinlab/hexa-bio) — genomic
> sequences, structural biology, pharmacology, and the wet-lab protocol
> language we actually run.

| field        | value                                                  |
| ------------ | ------------------------------------------------------ |
| verb         | `bio`                                                  |
| family       | `hexa-forge`                                           |
| status       | `RESEARCH_FIRST` (spec only, no weights)               |
| dispatch     | `hexa-forge bio`                                       |
| sibling CLIs | `hexa-bio` (data + assays), `hexa-codex serve`          |

---

## §WHY

Biology is **multi-modal sequence land** (DNA / RNA / protein) wrapped
in a thick layer of natural-language papers, protocols, and clinical
notes. A general LLM treats sequences as gibberish; a sequence-only
model (ESM, RNA-FM, Evo) can't read a protocol PDF or reason about a
patient note.

`hexa-forge bio` is the recipe for a **bilingual** model — fluent in
both biological **sequence tokens** and biomedical **prose** — that
can:

- read a paper and propose a CRISPR-Cas13 guide, then call out to
  `hexa-bio crispr` for off-target scoring
- annotate a ribozyme catalytic core from a raw RNA sequence
- translate a wet-lab protocol into a `hexa-bio` automation script
- flag pharmacovigilance signals from FDA AERS prose + drug labels

## §COMPARE

| approach                                  | strength                                | weakness                                       |
| ----------------------------------------- | --------------------------------------- | ---------------------------------------------- |
| sequence-only (ESM-2, RNA-FM, Evo, AlphaFold-LM) | best-in-class structure / function    | can't read prose / protocols                   |
| biomedical LLM (BioGPT, Med-PaLM, MedLM)  | strong clinical text                    | can't ingest raw sequences as first-class tokens |
| general FM + retrieval                    | flexible                                | hallucinates assays, unsafe dosing             |
| **hexa-forge `bio`**                      | **bilingual** — seq + prose first-class | smaller than general FM; narrow                |

## §REQUIRES

- base model: open-weights mid-size (target **7B–13B**)
- tokenizer: **dual vocab** — natural-language BPE + sequence k-mer
  tokens (`<DNA>`, `<RNA>`, `<AA>` modality switches)
- compute: 8× H100 for pretrain; 1× H100 + Mac Studio for SFT/LoRA
- ethics review board sign-off for any clinical evals

## §STRUCT — dataset

| stage      | corpus                                                                 | size target | filter                                              |
| ---------- | ---------------------------------------------------------------------- | ----------- | --------------------------------------------------- |
| seq-pretrain | RefSeq + UniRef90 + Rfam + ENA (DNA + protein + RNA family)           | ~400B tok   | dedup ≤ 90% identity; modality tags injected       |
| lit-pretrain | PubMed Central OA + bioRxiv + medRxiv (full text, OA only)            | ~80B tok    | OA license only; figure captions retained          |
| protocol     | protocols.io OA + Bio-Protocol OA + Nature Protocols (citation only)  | ~3B tok     | OA license; structured into step lists             |
| pharma       | DailyMed (FDA labels) + DrugBank OA + ChEMBL                          | ~5B tok     | public-domain / OA only                            |
| clinical     | MIMIC-IV (DUA), UK Biobank summary stats                              | ~10B tok    | DUA-gated; never commit raw                         |
| hexa-bio     | every doc under `~/core/hexa-bio/{biology,genetics,nanobot,...}/`     | ~0.5B tok   | full repo; weighted ×10                             |

## §FLOW — training stages

1. **Stage 0 — base.** Take open-weights base; extend tokenizer with
   sequence k-mer vocab (~8k new tokens for codons + AA k-mers).
2. **Stage 1 — interleaved pretrain.** `seq-pretrain` and `lit-pretrain`
   interleaved at 4:1 ratio. Modality switch tokens enforced.
3. **Stage 2 — SFT.** `protocol + pharma + hexa-bio` formatted as
   `<question><answer-with-citations>`.
4. **Stage 3 — RLHF/DPO.** Preference signal from:
   - sequence-task ground truth (e.g., known guide vs. random)
   - hallucination penalty on un-cited factual claims
5. **Stage 4 — alignment guard.** Refuse: bioweapon synthesis routes,
   gain-of-function uplift, unsafe dosing prescription, PHI extraction.

## §EVOLVE — eval harness

| benchmark                         | what it measures                          | acceptance bar               |
| --------------------------------- | ----------------------------------------- | ---------------------------- |
| MedQA (USMLE)                     | clinical reasoning                        | ≥ Med-PaLM 2 small-class     |
| PubMedQA                          | literature QA                             | ≥ BioGPT-Large               |
| BC5CDR / NCBI-disease (NER)       | biomedical entity recognition             | ≥ SciSpacy baseline + 5pts   |
| ProteinGym (zero-shot)            | protein fitness                           | ≥ ESM-2-650M                 |
| **hexa-bio-eval** (custom)        | hexa-bio CLI verb intent classification   | ≥ 90% top-1                  |
| **bioweapon-refusal** (custom)    | safety — must refuse uplift queries       | ≥ 99% refusal rate           |
| protocol-replication              | regenerate a known protocol from abstract | judged by 3 domain experts   |

## §VERIFY — serving contract

- **inference**: handed off to `hexa-codex serve` (NOT served here).
- **paired-call contract**: model emits structured intents that
  `hexa-bio` CLI dispatches:
  ```
  <tool_use name="hexa-bio">
    <verb>crispr</verb>
    <args>{"target": "<seq>", "system": "cas13"}</args>
  </tool_use>
  ```
- **citation contract**: every factual claim about a paper, drug, or
  assay MUST cite. Uncited factual sentences are penalized in DPO.
- **refusal contract**: hard-refuse bioweapon/gain-of-function/PHI
  queries with explicit policy text. **No jailbreak escape.**
- **clinical disclaimer**: every clinical-adjacent answer prefixed with
  `not a medical diagnosis` boilerplate.

---

## §FINDINGS — measured (absorbed from retired BIODATA domain, 2026-05-27)

> 두 closed-form finding 이 `hexa-forge bio` recipe 의 §STRUCT (tokenizer · dataset 비례) 와 §FLOW (scaling-law 적용) 결정에 직접 적용된다. verifier 재실행 가능 (`hexa run lm_foundry/verify/numerics_bio_a{1,2}_*.hexa`), verdict 는 `lm_foundry/verdicts/bio_a{1,2}_*_verdict.txt`. 구 BIODATA 도메인 SSOT 폐기 후 이 섹션이 finding 의 canonical 위치.

### FINDING-A1 — protein-LLM scaling = DISTINCT family (≠ text Chinchilla)

> verifier: `lm_foundry/verify/numerics_bio_a1_protein_llm_scaling.hexa` · 9/9 PASS · 🔵 STRUCTURAL + 🟡 α-by-citation + 🟠 β-assumed

| 축 | text Hoffmann 2022 | ESM2 protein (Lin 2023) |
|---|---|---|
| α (loss exponent) | 0.34 | ≈0.10 |
| N_opt exp | 0.45 | 0.74 (STEEPER) |
| D_opt exp | 0.55 | 0.26 (SHALLOWER) |
| D/N C-exp 부호 | +0.097 (D/N 성장) | NEGATIVE (D/N 수축) |

- **결론**: ε = \|α_text − α_protein\| = 0.24 ≫ 0.05 → A1 falsifier MEETS → BIO scaling = **별개 가족** (closed-negative on "protein-LLM follows text Chinchilla" folk claim).
- **운영 (recipe 적용)**: protein-LLM 은 text Chinchilla 보다 **deeply UNDER-trained** 가 최적 — 같은 FLOP 에서 파라미터 ↑·데이터 ↓. text α/β 로 BIO compute planning 하면 operationally WRONG.
- **honest residual**: Lagrangian shift 자체는 🔵 closed-form, α_protein 은 🟡 citation (Lin 2023 5-rung perplexity-vs-params 기울기), β_protein 은 🟠 assumed = text β. 자체 fit 으로 close 하려면 ESM2 checkpoint-by-checkpoint loss 재계산 (T4 cost-bearing).
- **외부 anchor**: Hoffmann 2022 (arXiv:2203.15556) · Lin 2023 (arXiv:2206.13517).

### FINDING-A2 — vocab size cascades into architecture choice

> verifier: `lm_foundry/verify/numerics_bio_a2_vocab_size_capacity.hexa` · 8/8 PASS · 🔵 SUPPORTED-FORMAL

| 도메인 | V | embed (V·d, d=1024) | 동일 컨텐츠 seq-length | attn/layer | 32L total cost |
|---|---|---|---|---|---|
| text BPE | 50000 | 102.4M | 30 | 1× | 132M |
| protein 아미노 | 20 | 41K (2500× 작음) | 300 | 100× text | 2.95G |
| DNA 4-nt | 4 | 8K (12500× 작음) | 900 | **900× text** | 26.5G |

- **결론**: embed = 2·V·d 선형 → 'V 무관' 반증자 REFUTED. 작은 V 는 sequence² 비용으로 attention 에서 보상 — V 선택이 architecture 가능성을 결정.
- **운영 (recipe 적용)**:
  - **ESM2 V=20** (아미노) = protein-LLM sweet spot (embed 41K, seq 300 → 표준 MHA 가능).
  - **DNA-LLM (V=4) 은 linear-attention 필수** (Mamba/Caduceus) — 표준 MHA on DNA = 900× text attention = prohibitive.
  - "tokenization 은 전처리일 뿐" folk view REFUTED.
- **honest residual**: V·d + n²·d = 🔵 structural identity. seq-length 값은 typical operating point (실측 아님). d=1024 = mid-range modern LLM; 더 큰 d 일수록 embed 무게가 dominant → V 중요성 증가.

---

## Cross-link policy

| concern                           | sibling                                  |
| --------------------------------- | ---------------------------------------- |
| genomics & wet-lab data           | `hexa-bio` CLI                           |
| inference / serving               | `hexa-codex serve`                       |
| training fabric                   | `hexa-chip` (neuromorphic)               |
| federated training transport      | `hexa-grid`                              |
| cognitive verbs (general reasoning) | `hexa-mind` (pending)                  |

## Open questions (v0.1.0)

- [ ] base weights — Llama-3.1-8B vs Qwen2.5-7B vs domain base (BioGPT-7B)
- [ ] tokenizer extension — k-mer (k=3 codon) vs character vs BPE-on-seq
- [ ] **safety stack** — primary defence: training-time refusal vs
      inference-time classifier vs both
- [ ] data DUA management — MIMIC-IV / UK Biobank pipelines (separate repo?)
- [ ] paired-call schema — JSON tool-use vs hexa-lang AST emission
- [ ] eval governance — IRB process for any eval involving real patient text
