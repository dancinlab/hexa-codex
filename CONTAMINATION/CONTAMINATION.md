# CONTAMINATION — 시험 답안 미리 봤나

@title: ⚠️ CONTAMINATION — "시험 답안 미리 봤나"
@goal: **평가 벤치마크 데이터의 학습 corpus 누설을 영구 검출·필터링하는 lane.** 새 eval set·pretrain corpus·검출 기법 가 등장할 때마다 측정 frontier 가 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Candidate sibling from [`AXIS.easy.md`](../AXIS.easy.md) (브레인스토밍 ⭐⭐⭐). ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** 표준 eval 의 n-gram contamination > 30% → 점수가 외운 점수 + 실력 점수 mix
>
> **Sibling parallel:** SANDBOX 는 '측정의 reproducibility', CONTAMINATION 은 '측정 자체의 무결성' — meta-eval

## North-star

시험 본 학생이 알고 보니 같은 문제가 교과서에 있었어요. 그럼 진짜 실력일까 외운 걸까?

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> CONTAMINATION 은 완료되지 않는다. 새 eval set·pretrain corpus·검출 기법 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — first probe (closed-form baseline)
- [x] A1 — n-gram contamination rate (eval ↔ pretrain) · 13-gram match. 반증자: 표준 eval 의 n-gram contamination > 30% → 점수가 외운 점수 + 실력 점수 mix. **CYCLE-9 round-1 wire (2026-05-28):** `CONTAMINATION/bench/contamination_a1_ngram_ratio.hexa` + `CONTAMINATION/verify/numerics_contamination_a1_ngram_ratio.hexa` ✅ 6/6 PASS · 🔵 STRUCTURAL (combinatorial ratio identity matched/total ∈ [0,1]) + 🟡 BY-CITATION (13-gram + 30% threshold = Dodge 2021 C4 / Sainz 2023 ChatGPT-eval convention). worked example 6 rows (placeholder counts, NO real corpus scan) — edges {clean=0%, full=100%}, falsifier-trips {tripped 42%, max_real 85%}, just-below {borderline 29%}. external anchors: Dodge 2021 (arXiv:2104.08758) · Sainz 2023 (arXiv:2310.18018) · Magar & Schwartz 2022 (arXiv:2203.08242). **honest residual**: 실제 corpus scan (C4/Pile/RedPajama × MMLU/HellaSwag/GSM8K Dodge-style 13-gram bloom-filter on ubu-1) 는 cycle-10+ T4 cost-bearing round deferred. **frontier OPEN** (feedback_closure_is_physical_limit) — formula close ≠ measured close; 새 eval set·corpus·검출 기법 등장 시 axis 재개.

### 축 B — second probe (measured ladder)
- [ ] B1 — perplexity outlier (학습 본 sample 은 perplexity 낮음) · eval-vs-train per-sample fit. 반증자: eval 셋의 perplexity 분포가 random sample 분포와 KL > 0.3 → 외운 흔적.

### 축 N — 🆕 NOVEL: surface-vs-semantic contamination 분리 (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — CONTAMINATION 의 self-NOVEL axis. n-gram match (surface) 가 없어도 paraphrased memorization (semantic) 가능 — 두 lane 분리 측정. 외부 anchor: Dodge 2021 C4 contamination · Sainz 2023 ChatGPT eval · Magar 2022 data contamination.
- [ ] N1 — n-gram match rate + perplexity outlier + paraphrase invariance 동시 측정. 반증자: n-gram 0% 인데 perplexity outlier > 3σ → semantic contamination 존재.

## SANDBOX 활용 (measurement substrate)

CONTAMINATION 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `.verdicts/CONTAMINATION/a1_*` |
| B1 ladder | SANDBOX bench harness | `.verdicts/CONTAMINATION/b1_*` |
| N1 ⭐ NOVEL | mac M3 / vast.ai pod | `.verdicts/CONTAMINATION/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| eval 필터링 (semantic-aware) · paraphrase test inject | eval 통과 기준 조정 (외운 문제 제외) · dataset filter at pretrain · paraphrase canary | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **CONTAMINATION 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter (H, I, J, ...) 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: 표준 eval 의 n-gram contamination > 30% → 점수가 외운 점수 + 실력 점수 mix
> **Anticipated ENGINE behavior wire**: contamination-discounted eval scoring · novel-prompt routing
> **Status path**: [`../CALIBRATION/CALIBRATION.md`](../CALIBRATION/CALIBRATION.md) ← reference 패턴 (cycle-10 round-1 promoted to ENGINE axis G).

> ⏸ DEFERRED waiting on cycle-10+ T4 measured fire.

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../ECONOMICS.md`](../ECONOMICS.md) · [`../NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md)
- this domain: [`CONTAMINATION.md`](CONTAMINATION.md) (snapshot) · [`CONTAMINATION.log.md`](CONTAMINATION.log.md) (history)
