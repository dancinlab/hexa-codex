# BIODATA — log

Append-only history sister of `BIODATA.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.


## 2026-05-27 — cycle-1 BIODATA 도메인 init (BIO → NEUROEXP+BIODATA 분리 reorg)

**사용자 지시:** "아 이 BIO 도메인 이름 바꿔야될듯, BIO 모델 이야기가 아니라,,, LLM 에
생물학적 실험을 해보는거야" → AskUserQuestion → A1/A2 (bio-data 어긋난 cycle) 는 **별
도메인 BIODATA 로 이관** 선택 (8/8 verdict 보존).

기존 BIO 도메인의 A 축 (BIO-data LLM training) 과 B/C 축 (reasoning bench/inference)
은 *원래 의미* 가 "LLM 에게 생명 데이터" 였으나 사용자의 진짜 의도는 "LLM 자체에 신경학
실험" → 별 lane 으로 분리하는 게 정직. NEUROEXP 가 사용자 의도 lane, BIODATA 가 원래
의미의 lane.

### Init artifacts

- [x] `BIODATA/BIODATA.md` — 도메인 SSOT (3 영구 axes A·B·C)
- [x] `BIODATA/BIODATA.log.md` — append-only history (이 파일)
- [x] `DOMAINS.tape` 에 `@domain BIODATA := "./BIODATA/BIODATA.md"` 추가
- [x] A1 cycle-2 verifier+verdict 이관 (구 BIO → BIODATA, 이름 `biodata_a1_*` 유지)
- [x] A2 cycle-3 verifier+verdict 이관 (구 BIO → BIODATA, 이름 `biodata_a2_*`)
- [x] sister 도메인 NEUROEXP 참조 명시 (단방향 cross-link 아님 — 둘 다 hexa-codex 내부)

### 3 영구 axes (재정의 — LLM × 생명 데이터 명확화)

| axis | scope | 이관/신설 |
|------|-------|----------|
| **A** | BIO-data LLM training (ESM / protein-LLM / DNA-LLM scaling law) | A1 ← BIO cycle-2 ✅ · A2 ← BIO cycle-3 ✅ |
| **B** | BIO reasoning benchmarks (MedQA · PubMedQA · BioASQ · ESM2 zero-shot) | B1·B2 신설 (구 BIO 와 동일) |
| **C** | BIO inference for science (drug repurposing · target ID · structure intuition) | C1·C2 신설 (구 BIO 와 동일) |

> 구 BIO 의 D 축 (bio-inspired architecture) 과 E 축 (BIO × IIT4) 은 NEUROEXP 의
> N/Φ/L/C/S 5 axes 로 재정의되어 이관됨 ([`NEUROEXP/NEUROEXP.log.md`](../NEUROEXP/NEUROEXP.log.md) 참조).

### 이관된 closure 들 (verdict tier 그대로 보존)

**A1 (← BIO cycle-2)**: 🔵 STRUCTURAL + 🟡 α-by-citation + 🟠 β-assumed · 9/9 PASS — text
Hoffmann α=0.34 vs ESM2 α≈0.10, ε=0.24 ≫ 0.05 → BIO scaling 가족 DISTINCT. D/N C-exp
부호 정반대 (+0.097 text vs −0.474 protein). 운영: protein-LLM 은 text Chinchilla 보다
deeply UNDER-trained 가 최적. verifier: `BIODATA/verify/numerics_biodata_a1_protein_llm_scaling.hexa`.
verdict: `BIODATA/verdicts/a1_protein_llm_scaling_verdict.txt`.

**A2 (← BIO cycle-3)**: 🔵 SUPPORTED-FORMAL 8/8 — embed = 2·V·d 선형 → 'V 무관'
반증자 REFUTED. text 102.4M / protein 41K / DNA 8K (2500× / 5× ratios). 작은 V 는
sequence² 비용으로 attention 에서 보상 (DNA attn = 900× text). 운영: ESM2 V=20 amino =
protein sweet spot · DNA-LLM 은 Mamba/Caduceus 같은 linear-attn 필수. verifier:
`BIODATA/verify/numerics_biodata_a2_vocab_size_capacity.hexa`. verdict:
`BIODATA/verdicts/a2_vocab_size_capacity_verdict.txt`.

### 진행도

```
A: ✅A1 ✅A2                 (A축 완료, 이관 closure 들)
B: ☐B1 ☐B2
C: ☐C1 ☐C2
```

2/6 closed · 4 open · ♾️ perpetual frontier.

### 영구 axis 의미

cycle-1 = init+reorg only. 다음 cycle 부터:
- cycle-2+ B2 first probe (ESM2 zero-shot vs LLM+RAG · closed-form 가능)
- cycle-3+ C2 first probe (LLM helix/sheet zero-shot · T4 cost-bearing, 가벼움)
- cycle-4+ B1 first probe (MedQA Qwen vs PMC-LLaMA · T4 cost-bearing, 표준 BIO benchmark)
- cycle-5+ C1 first probe (drug-target leave-one-out · T4 cost-bearing, 가장 큰)

### Honesty invariants 적용 (reorg 무손실)

- 이관된 A1/A2 verdict tier 그대로 보존 (🔵+🟡+🟠 → 그대로, downgrade/upgrade 없음).
- 이관된 verifier 의 axis 메타데이터만 `BIO::A1` → `BIODATA::A1` 등으로 업데이트
  (closed-form 결과 자체는 deterministic 그대로).
- closed-form A1+A2 의 cross-axis 관계 (V=4 → linear-attn) 가 sister domain NEUROEXP
  의 N1+Φ1 (linear-attn ≡ Hebbian + 통합 Φ>0) 와 자연수렴 — 두 lane 모두에서 관찰되는
  구조적 짝으로 보존.
- frontier perpetual: 도메인 reorg 가 frontier 종료 아니라 단지 lane 재구획
  ([[feedback_closure_is_physical_limit]]).

### 연결

- this domain SSOT: [`BIODATA.md`](BIODATA.md)
- sister domain (hexa-codex 내부): [`NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md) — LLM substrate 실험 lane
- DOMAINS.tape roster: `@domain BIODATA := "./BIODATA/BIODATA.md"`
- 6 sibling 도메인 (hexa-codex 내부): SANDBOX · ECONOMICS · SAFETY · OPS · SUBSTRATE · ENGINE
- ECONOMICS C1 Hoffmann Lagrangian (A1 응용 source): `ECONOMICS/verify/numerics_hoffmann_lagrangian.hexa`
