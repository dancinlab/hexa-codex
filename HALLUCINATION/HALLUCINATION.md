# HALLUCINATION — 헛소리 측정기

@title: 💭 HALLUCINATION — "헛소리 측정기"
@goal: **모델이 모르는 사실에 대해 confident 으로 지어내는 빈도를 영구 측정·억제하는 lane.** 새 knowledge cutoff·fact universe·domain 가 등장할 때마다 측정 frontier 가 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Candidate sibling from [`AXIS.easy.md`](../AXIS.easy.md) (브레인스토밍 ⭐⭐⭐). ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** factual probe 에서 hallucination rate > 20% with high confidence
>
> **Sibling parallel:** SAFETY 는 '위험한 출력 거부', HALLUCINATION 은 '모르는 출력 거부' — 별 종류의 거부

## North-star

답 모르는데 빈칸 두기 싫어서 그럴싸한 답 지어내는 학생. 진짜 정직한 학생은 '모르겠어요'.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> HALLUCINATION 은 완료되지 않는다. 새 knowledge cutoff·fact universe·domain 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — first probe (closed-form baseline)
- [x] A1 — TruthfulQA·SimpleQA 의 hallucination rate (confidence × 정답률). 반증자: factual probe 에서 hallucination rate > 20% with high confidence. **CYCLE-9 round-4 wire (2026-05-28):** `HALLUCINATION/bench/hallucination_a1_confident_wrong_rate.hexa` + `HALLUCINATION/verify/numerics_hallucination_a1_confident_wrong_rate.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL + 🟡 BY-CITATION. Formula: rate_x100(m) = (N_confident_wrong[m]·100)/N_total[m]; falsifier_fires(m) = rate_x100(m) > 20 (Lin 2022 TruthfulQA arXiv:2109.07958 · Kadavath 2022 self-eval arXiv:2207.05221 · Yin 2023 do-LLMs-know arXiv:2305.18153); integer ×100 ledger (closed-form, libm-free). placeholder models: A raw_x100=**18** silent (false-positive 회피, 18 ≤ 20) ✓ · B raw_x100=**25** FIRES (over-confident, 25 > 20) ✓ · C raw_x100=**12** silent (IDK-rich) ✓ · D raw_x100=**42** FIRES heavily (2× threshold) ✓ · Z raw_x100=**0** silent (zero-hallucination control) ✓. core falsifier held: 반증자 (rate > 20% high-conf) D/B 에서 fires · A/C/Z 에서 silent — bidirectional discrimination. structural sanity: weighted_x100 ≤ raw_x100 for all 5 models (high-conf wrong counts full, borderline partial). external anchor: Lin 2022 (original TruthfulQA benchmark) · Kadavath 2022 (self-evaluation tier · P(True)) · Yin 2023 (knowledge-boundary anchor). **TruthfulQA/SimpleQA 실측 substrate fire deferred — cost-bearing** (mac M3 local llama-server / ubu-1 HF transformers · abstention extractor + self-eval gating · A1 measured-tier upgrade). honest residual: integer ×100 ledger truncates rate at .01 (coarser than literature float %); 'confidence' is per-sample weight here — real-fire wires it to logit margin / Kadavath P(True) probe (definition narrows at measured-tier). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — closed-form 만 닫음; 새 knowledge cutoff·fact universe·domain 마다 A1 measured cell 재오픈. 축 N (knowledge-boundary IDK rate · ⭐ MAIN NOVEL lane) 가 다음 priority.

### 축 B — second probe (measured ladder)
- [ ] B1 — self-consistency · multi-sampled agreement 으로 자가-모순율 측정. 반증자: n-sample agreement 가 정답률과 무상관 (correlation < 0.3) → 자가-모순으로도 환각 검출 불가.

### 축 N — 🆕 NOVEL: knowledge-boundary self-awareness (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — HALLUCINATION 의 self-NOVEL axis. 모델이 자기 knowledge cutoff 너머 사실에 대해 인지하고 거부하는 비율 — 'I don't know' rate at boundary. 외부 anchor: Kadavath 2022 self-evaluation · Lin 2022 TruthfulQA · Yin 2023 do-LLMs-know.
- [ ] N1 — cutoff 이후 사건 prompt 에 대한 IDK rate 측정. 반증자: cutoff 이후 사실에 confident hallucination > 50% (IDK 미발화).

## SANDBOX 활용 (measurement substrate)

HALLUCINATION 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `.verdicts/HALLUCINATION/a1_*` |
| B1 ladder | SANDBOX bench harness | `.verdicts/HALLUCINATION/b1_*` |
| N1 ⭐ NOVEL | mac M3 / vast.ai pod | `.verdicts/HALLUCINATION/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| post-training IDK injection + runtime abstention | uncertainty-gated output · RAG 자동 trigger · abstention threshold | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **HALLUCINATION 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../ECONOMICS.md`](../ECONOMICS.md) · [`../NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md)
- this domain: [`HALLUCINATION.md`](HALLUCINATION.md) (snapshot) · [`HALLUCINATION.log.md`](HALLUCINATION.log.md) (history)
