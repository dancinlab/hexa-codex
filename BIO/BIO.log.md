# BIO — log

Append-only history sister of `BIO.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.


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
