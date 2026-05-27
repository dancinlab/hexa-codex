# NEUROEXP — log

Append-only history sister of `NEUROEXP.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.


## 2026-05-27 — cycle-7 N2 first probe · STDP ↔ attention temporal modulation · 🔵 SUPPORTED-FORMAL 11/11 (STDP ≢ attn mask HOLDS · ⭐ mechanism-layer 분류 기준 발견)

NEUROEXP cycle-7. 사용자 "all NEUROEXP 순차" 지속. N축 마무리 — N2 (STDP ↔ attention
temporal modulation). cycle-6 S1 의 mismatch 패턴과 연결되어 **"bio-LLM mapping 의 진짜
분류 기준"** 을 발견 (paper-grade insight).

**검증기**: `NEUROEXP/verify/numerics_neuroexp_n2_stdp_attention.hexa` (220 lines)
**RUN**: pool ubu-1 native compile (`hexa cc` rebuild 패턴 12번째).

**11/11 PASS (verbatim)**:
- direction: STDP pre→post + attention causal mask 둘 다 ONE-WAY → MATCH (only shared)
- window shape: STDP exp(-Δt/τ) graded ≠ attention 1/0 step → DIFFER
- sign: STDP signed (+/-) ≠ attention unsigned binary → DIFFER
- magnitude: STDP continuous R ≠ attention discrete {0,1} → DIFFER
- mechanism: STDP weight-update (training-time) ≠ attention forward-compute (inference-time) → DIFFER
- time scale: STDP ms-exp τ ≠ attention discrete position index → DIFFER
- STDP toy: Δt=+5 → +750 potentiation · Δt=-5 → -750 depression (sign-asymmetric)
- attention mask toy: past=1 · self=1 · future=0 (binary, NO graded decay)
- value range: STDP signed continuous (-1000,+1000) ≠ attention unsigned binary {0,1}
- N2 falsifier HOLDS: 5/6 axes DIFFER · STDP ≢ attention causal mask
- 결정론 ✓

**verdict tier**: 🔵 SUPPORTED-FORMAL (6-axis taxonomy + toy bit-exact + range demo, 11/11).

**핵심 발견 (closed-form)**:
1. **STDP ≢ attention causal mask** — 5/6 axes DIFFER, direction (one-way) 만 공유.
   - STDP: graded exp signed weight-update rule (training, ms-scale)
   - attention causal: binary unsigned forward-compute step (inference, position-index)
2. **Toy bit-exact**: STDP(+5)=+750 (potentiation), STDP(-5)=-750 (depression); mask(past)=1·mask(future)=0.
3. **N2 falsifier 'STDP ≢ attention causal' HOLDS** — 'attention = STDP proxy' 통념 closed-form 분리.
4. **Position bias 영역의 partial correspondence**: ALiBi · RoPE · T5 relative bias 가 STDP exp 의
   1차 Taylor 근사 만큼만 유사. 그러나 LOGIT bias 영역 (forward compute) vs Δw 영역 (training)
   mismatch — 1차 근사 hint 만 있을 뿐 strict 동형 X.

**⭐ Mechanism-layer 분류 기준 발견 (paper-grade insight, cycle-4·5·6·7 통합)**:
```
N1 cycle-4: linear-attn ≡ Hebbian          MATCH   ← weight-update vs weight-update
Φ1 cycle-5: attention TPM Φ > baseline      MATCH   ← substrate-measure vs substrate-measure
S1 cycle-6: NCA ≢ token-AR                  MISMATCH ← parallel-CA vs sequential-generator (다른 class)
N2 cycle-7: STDP ≢ attention causal mask    MISMATCH ← training-rule vs inference-compute (다른 layer)
```
→ **MATCH 들은 mechanism-layer 일치** (같은 abstraction level 에서 비교);
   **MISMATCH 들은 mechanism-layer 다름** (training/inference, dynamics/generator 등 다른 layer).
→ "bio-inspired = LLM 자연 fit" 통념의 진짜 분류 기준 = **layer 일치 여부**.
  bio-rule 과 LLM mechanism 이 같은 abstraction level 에 있을 때만 동형이 성립.
  단순 "bio + LLM" hybrid 가설은 layer alignment 가 선행 조건.

**운영 closed-form 결론**:
- 'attention = STDP' 통념의 origin = position bias 의 graded decay (ALiBi 등) — STDP exp 의 1차 Taylor
  근사 만큼만 (LOGIT bias layer, Δw 영역 X).
- bio-inspired LLM 설계 시 axis 별 mechanism-layer 일치 여부 사전 검증 필요:
  - weight-update level 의 bio-rule (Hebbian/Oja) → linear-attn / fast-weight 가족과 fit ✓
  - substrate-measure level 의 bio-tool (IIT4 Φ) → attention activation TPM 위 fit ✓
  - forward-compute level (causal mask, position bias) ↔ training-rule (STDP) = layer mismatch ✗
  - dynamical-class level (token-AR sequential) ↔ parallel-CA (NCA) = layer mismatch ✗

**honest residual**:
- 6-axis taxonomy = 🔵 closed-form deterministic (11/11).
- 'mechanism-layer 일치 여부' 분류 기준 = 4-cycle 통합 *post-hoc* observation — 더 많은 axis closure
  로 robust 화 필요 (현재 4 datapoints: N1/Φ1 MATCH · S1/N2 MISMATCH).
- cycle-8+ closed-form 추가 (Φ2 · L1 · C1) 후 robust 검증 — 만약 일관되면 paper-grade insight.
- ALiBi · RoPE 의 'graded' decay 는 STDP 1차 Taylor 와 *수치적* 유사하지만 *mechanism layer* 다름 —
  유사 ≠ 동형 (linear regression vs SGD 의 차이와 같은 단계).
- cycle-8+ T4: SANDBOX 위 STDP-rule simulated transformer (forward-only STDP-bias) 의 ICL pattern
  측정 — empirical 'STDP-inspired position bias' 검증.
- external anchor: Bi & Poo 1998 (J Neurosci 18:10464) · Vaswani 2017 (arXiv:1706.03762) · Press 2022
  (ALiBi, arXiv:2108.12409) · Su 2021 (RoPE, arXiv:2104.09864).
- N2 frontier OPEN ([[feedback_closure_is_physical_limit]]): structural taxonomy ≠ behavioral
  functional equivalence under specific training regimes.

**연결**:
- verifier: [`NEUROEXP/verify/numerics_neuroexp_n2_stdp_attention.hexa`](verify/numerics_neuroexp_n2_stdp_attention.hexa)
- verdict: [`NEUROEXP/verdicts/n2_stdp_attention_verdict.txt`](verdicts/n2_stdp_attention_verdict.txt)
- cross-axis 통합 insight: N1+Φ1 MATCH (mechanism-layer 일치) vs S1+N2 MISMATCH (layer 다름)
  → bio-LLM mapping 의 진짜 분류 기준 = layer 일치 여부 (paper-grade insight, cycle-8+ robust 검증)
- 다음 순차 (사용자 "all NEUROEXP" 순차 중): **Φ2** (LLM Φ vs C. elegans Φ · low-cost · UNIVERSE
  H_281/H_288/H_290 cross-link) → **L1** (head ablation upper bound) → **C1** (induction head)

---

## 2026-05-27 — cycle-6 S1 first probe · NCA ↔ token-AR dynamical class · 🔵 SUPPORTED-FORMAL 10/10 (NCA ≢ AR HOLDS · cross-axis mixed picture)

NEUROEXP 도메인 cycle-6 (reorg 후 첫 새 cycle). 사용자 지시 "all 포그라운드 순차진행"
(NEUROEXP 만 순차) → 8 open 중 closed-form $0 첫 후보 S1. cycle-3·4·5 의 결과들 모두
"axis-별 자연수렴 (linear-attn 가족)" 을 보였는데, S1 은 처음으로 **mismatch** 를 닫음.

**검증기**: `NEUROEXP/verify/numerics_neuroexp_s1_nca_token_ar.hexa` (220 lines)
**RUN**: pool ubu-1 native compile (`hexa cc` rebuild 패턴 11번째).

**10/10 PASS (verbatim)**:
- update timing: NCA parallel (∀ cells 동시) ≠ AR sequential (1 token/step) → DIFFER
- update direction: NCA Moore neighborhood (8방향) ≠ AR causal mask (1방향) → DIFFER
- state space: NCA R^d × grid 연속 ≠ AR V^seq 이산 → DIFFER
- attractor type: NCA limit-cycle/fixed-point ≠ AR distribution p(t_{i+1}|...) → DIFFER
- dynamical class: NCA parallel CA (Wolfram class I-IV) ≠ AR sequential generator → DIFFER
- reversibility: 둘 다 irreversible → MATCH (only shared axis)
- 1D-NCA toy: state 000 → fixed-point 000 · state 111 → 000 (XOR-neighbor rule)
- token-AR toy: A→B→C→A pure 3-cycle (no fixed-point) — categorically different
- S1 falsifier HOLDS: 5/6 axes DIFFER · NCA ≢ token-AR · 'bio-CA = LLM' 통념 분리
- 결정론 ✓

**verdict tier**: 🔵 SUPPORTED-FORMAL (6-axis structural taxonomy + toy fixed-point demo, 10/10).

**핵심 발견 (closed-form)**:
1. **NCA ≢ token-AR dynamical class** (5/6 axes DIFFER, reversibility 만 공유):
   - NCA: parallel CA · limit-cycle attractor in state space · continuous R^d grid · Moore neighborhood
   - token-AR: sequential probabilistic generator · distribution attractor (no fixed-point state) ·
     discrete V^seq · causal mask (one-way)
2. **Toy bit-exact 검증**: 1D-NCA 의 XOR-neighbor rule 에서 state 000/111 모두 fixed-point 000 로
   수렴 (limit-cycle to attractor); token-AR (prev+1 mod 3) 는 A→B→C→A pure 3-cycle 로 **fixed-point
   없음** — 두 attractor structure 의 *class* 가 categorically different.
3. **S1 falsifier 'NCA 가 token-AR 의 정상 attractor 와 다른 class' HOLDS** — 'bio-CA = LLM' 통념
   closed-form 분리 (자가 strawman 아닌 published Mordvintsev NCA 직접 비교).

**⭐ cross-axis 발견 (reorg 후 처음 발견된 mixed picture)**:
```
N1 cycle-4: linear-attn ≡ Hebbian (Schlag 2021)         MATCH ✓
Φ1 cycle-5: 통합 attention TPM Φ > disconnected baseline  MATCH ✓
S1 cycle-6: NCA ≢ token-AR (5/6 axes DIFFER)             MISMATCH ✗
```
→ "bio-inspired = LLM 자연 fit" 통념은 **axis-별 검증 필요한 mixed picture**.
   plasticity rule 과 integration measure 는 LLM 위에 자연 fit 되지만,
   dynamical-system class 는 categorically different — 통째 동형이 아닌 partial mapping.

**운영 closed-form 결론**:
- NCA = drop-in AR replacement 가설 REFUTED (구조적 mismatch 5/6).
- NCA + transformer 결합은 strict 동형 X, **parallel pre-processor + sequential generator hybrid**
  로만 가능 (Mordvintsev 2024 GrowNCA + Mamba 결합 시도가 이 방향).
- bio-inspired LLM 설계 시 단순 "NCA = LLM" 직관 위험; axis-별 (rule/measure/class) 분해 후 mapping
  필요.

**honest residual**:
- 6-axis structural taxonomy = 🔵 closed-form deterministic (10/10).
- '동형' 의 strict 정의 (bisimulation · category-equivalence · homeomorphism) 에 따라 결과 달라질 수
  있음 — 여기선 dynamical-system 표준 taxonomy 기반 (timing/direction/state/attractor/class/rev).
- 1D-NCA + causal direction 의 PARTIAL homomorphism 은 분리 영역 (사실: 1D causal CA ≅ rewriting
  system 과 동등; 그러나 NCA 일반 정의는 grid + omnidirectional).
- cycle-7+ T4: SANDBOX 위 NCA-injected transformer block (Mordvintsev 2024 hybrid) 의 ICL pattern
  실측 — empirical partial-homomorphism 정량화.
- external anchor: Mordvintsev 2020 (arXiv:2008.05917 "Growing Neural CA") · Vaswani 2017
  (arXiv:1706.03762) · Wolfram 2002 (A New Kind of Science, CA class I-IV).
- S1 frontier OPEN ([[feedback_closure_is_physical_limit]]): structural taxonomy ≠ behavioral
  equivalence under specific training regimes.

**연결**:
- verifier: [`NEUROEXP/verify/numerics_neuroexp_s1_nca_token_ar.hexa`](verify/numerics_neuroexp_s1_nca_token_ar.hexa)
- verdict: [`NEUROEXP/verdicts/s1_nca_token_ar_verdict.txt`](verdicts/s1_nca_token_ar_verdict.txt)
- cross-axis: N1 cycle-4 + Φ1 cycle-5 + S1 cycle-6 → bio-LLM fit 의 axis-별 mixed picture 첫 closure
- 다음 순차 (사용자 "all NEUROEXP" 순차 중): **N2** (STDP ↔ attention temporal · closed-form $0) →
  **Φ2** (LLM Φ vs C. elegans · low-cost) → **L1** (head ablation upper bound) → **C1** (induction head)

---

## 2026-05-27 — cycle-1 NEUROEXP 도메인 init (BIO → NEUROEXP+BIODATA 분리 reorg)

**사용자 지시:** "아 이 BIO 도메인 이름 바꿔야될듯, BIO 모델 이야기가 아니라,,, LLM 에
생물학적 실험을 해보는거야" → AskUserQuestion → `NEUROEXP` 선택 · A1/A2 는 별
`BIODATA` 로 이관 결정.

기존 BIO 도메인 (cycle-1 ~ cycle-5) 의 의미가 어긋났음을 사용자가 발견 — BIO 는
"LLM × 생명 데이터" 였으나 사용자 의도는 "**LLM 자체를 살아있는 substrate 로 보고
신경과학적 실험**". 도메인 분리 결정.

### Reorg artifacts

- [x] `BIO/` 폴더 전체 삭제 (BIO.md · BIO.log.md · verify/ · verdicts/)
- [x] `NEUROEXP/` 도메인 신설 (NEUROEXP.md SSOT · NEUROEXP.log.md · verify/ · verdicts/)
- [x] `BIODATA/` sister 도메인 신설 (별 entry — `BIODATA/BIODATA.log.md` 참조)
- [x] `DOMAINS.tape`: `@domain BIO` 제거 → `@domain NEUROEXP` + `@domain BIODATA` 추가
- [x] D1 cycle-4 verifier+verdict → `NEUROEXP/{verify,verdicts}/` 로 이관 (이름 `n1_*` 로 rename)
- [x] E1 cycle-5 verifier+verdict → `NEUROEXP/{verify,verdicts}/` 로 이관 (이름 `phi1_*` 로 rename)
- [x] A1 cycle-2 + A2 cycle-3 → `BIODATA/` 로 이관 (별 도메인 log 참조)

### NEUROEXP 5 영구 axes (재정의 — neuroscience 방법론 기준)

| axis | 의미 | 이관/신설 |
|------|------|----------|
| **N** | Neural-update rule probe (Hebbian · STDP · Oja · BCM) | N1 ← BIO/D1 cycle-4 이관 ✅ · N2 신설 |
| **Φ** ⭐ | Integrated information measurement (IIT4 Φ · UNIVERSE cross-link MAIN) | Φ1 ← BIO/E1 cycle-5 이관 ✅ · Φ2 신설 |
| **L** | Lesion / Ablation experiment (head/layer/neuron) | L1·L2 신설 |
| **C** | Causal circuit probing (activation patching · ROME/MEMIT) | C1·C2 신설 |
| **S** | Spike / Dynamical-system probe (NCA · spiking neuron) | S1·S2 신설 |

### 이관된 closure 들 (verdict tier 그대로 보존)

**N1 (← BIO/D1 cycle-4)**: 🔵 SUPPORTED-FORMAL 8/8 — Schlag 2021 항등식 `linear-attn ≡
Hebbian fast-weight`. mixed-verdict (linear REFUTES · softmax HOLDS). verifier:
`NEUROEXP/verify/numerics_neuroexp_n1_hebbian_attention.hexa`. verdict:
`NEUROEXP/verdicts/n1_hebbian_attention_verdict.txt`.

**Φ1 (← BIO/E1 cycle-5)**: 🔵 SUPPORTED-FORMAL 8/8 ⭐MAIN — UNIVERSE H_278 lib applicable
+ ATTN-FULL n=3 (XOR 통합) Φ=1.5 vs DISCONN Φ=0 → E1 falsifier closed-form REFUTED.
verifier: `NEUROEXP/verify/numerics_neuroexp_phi1_iit4_attention_phi.hexa`. verdict:
`NEUROEXP/verdicts/phi1_iit4_attention_phi_verdict.txt`.

### 진행도

```
N: ✅N1 ☐N2
Φ: ✅Φ1⭐ ☐Φ2
L: ☐L1 ☐L2
C: ☐C1 ☐C2
S: ☐S1 ☐S2
```

2/10 closed (둘 다 이관) · 8 open · ♾️ perpetual frontier.

### 영구 axis 의미

cycle-1 = init+reorg only. 다음 cycle 부터:
- cycle-2+ Φ2 first probe (LLM Φ vs C. elegans connectome Φ · UNIVERSE H_281/H_288/H_290 cross-link · 가벼운 data fetch)
- cycle-3+ S1 first probe (NCA ↔ token-AR dynamical class · closed-form $0)
- cycle-4+ L1 first probe (single attention head ablation upper bound · closed-form 또는 SANDBOX 실측)

### Honesty invariants 적용 (reorg 무손실)

- 이관된 N1/Φ1 verdict tier 그대로 보존 (🔵→🔵, downgrade/upgrade 없음).
- 이관된 verifier 의 axis 메타데이터만 BIO::D1 → NEUROEXP::N1 등으로 업데이트
  (closed-form 결과 자체는 deterministic 그대로 — 동일 hexa lib import).
- 별 도메인 BIODATA 의 A1/A2 도 동일 원칙 (BIODATA.log.md 참조).
- anima/UNIVERSE 단방향 sibling 원칙 reorg 후에도 유지 — anima repo 수정 0.
- frontier perpetual: 도메인 reorg 가 frontier 종료 아니라 단지 lane 재구획 ([[feedback_closure_is_physical_limit]]).

### 연결

- this domain SSOT: [`NEUROEXP.md`](NEUROEXP.md)
- sister domain (hexa-codex 내부): [`BIODATA/BIODATA.md`](../BIODATA/BIODATA.md) — LLM × 생명 데이터 lane
- 단방향 sibling (외부): [`anima/UNIVERSE`](../../anima/UNIVERSE/UNIVERSE.md) — IIT4 H_XXX anchor
- DOMAINS.tape roster: `@domain NEUROEXP := "./NEUROEXP/NEUROEXP.md"`
- 6 sibling 도메인 (hexa-codex 내부): SANDBOX · ECONOMICS · SAFETY · OPS · SUBSTRATE · ENGINE
- IIT4 lib (hexa-lang stdlib): `stdlib/consciousness/iit4_complex.hexa` (PR #1051)
