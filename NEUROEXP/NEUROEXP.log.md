# NEUROEXP — log

Append-only history sister of `NEUROEXP.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.


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
