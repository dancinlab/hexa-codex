# LAW — 판례 변호사

@title: ⚖️ LAW — "판례 변호사"
@goal: **법률 전문 모델이 실제 존재하는 판례만 정확히 인용하고, 일관된 법적 추론(IRAC)을 펼치며, 관할(jurisdiction)별 법 차이를 혼용 없이 적용하는가를 영구 측정·확장하는 lane.** 법률은 hallucination 의 cost 가 극단적으로 크다 (Mata v. Avianca 2023 — ChatGPT 가짜 판례 인용 → 변호사 제재). 새 legal model·benchmark·관할·판례 DB 가 등장할 때마다 측정 frontier 가 다시 열린다. **도착지 없음 · 종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> `VERTICAL/*` 그룹 폴더의 도메인 (cycle-10) — vertical 전문 모델 측정 도메인군. LAW = 법률 전문 모델 측정. sibling = VERTICAL/CODE (코드 전문 모델) · VERTICAL/BIO (바이오/의료 전문 모델) · VERTICAL/MATH · VERTICAL/MEDICAL. ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** 인용 판례 중 가짜(hallucinated) 비율 > 20% → 가짜 판례 인용 신뢰 불가 (Mata v. Avianca class). 또는 IRAC rule 적용 오류 > 15% → 법적 추론 정합성 부재. 또는 한 답변에 충돌 관할 법 혼용 > 10% → jurisdiction 일관성 부재.
>
> **Sibling parallel:** SUBSTRATE 는 '능력 일반', VERTICAL/LAW 는 '법률이라는 한 vertical 의 깊이' — vertical 전문화 dimension. 법률은 truth 가 외부 판례 DB 에 ground 되어 있어 hallucination 이 즉시 falsifiable (코드 = 실행, 바이오 = wet-lab, 법률 = 판례 DB).

## North-star

법률 모델이 답변에서 인용한 판례 중 실제로 존재하는 비율 — "판례 변호사" 가 진짜 판례만 인용하는가, 아니면 그럴듯한 가짜 판례를 지어내는가 (Mata v. Avianca 2023 의 실제 사고). 그리고 단순 인용을 넘어 IRAC(Issue-Rule-Application-Conclusion) 추론 체인이 정합한가, 같은 사안을 다른 관할(주/연방/타국)에서 일관되게 다루는가.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> LAW 는 완료되지 않는다. 새 legal model·benchmark·관할·판례 DB·법 개정이 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — A1 판례 인용 정확도 (closed-form baseline)
- [x] A1 — 판례 인용 hallucination · 5 legal model × {citations_total, citations_hallucinated}. 반증자: 가짜(hallucinated) 판례 비율 > 20% → 가짜 판례 인용 신뢰 불가 (Mata v. Avianca 2023 — ChatGPT 가짜 판례 6건 인용 → 변호사 제재된 실제 사건). **CYCLE-10 first probe (2026-05-28 · VERTICAL/LAW 신규 도메인):** `VERTICAL/LAW/bench/law_a1_citation_hallucination.hexa` + `VERTICAL/LAW/verify/numerics_law_a1_citation_hallucination.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL + 🟡 BY-CITATION. Identity: `hallucination_rate_x100 = citations_hallucinated × 10000 / citations_total` (rate stored × 100 percent ledger · 2 fake/100 → 200 = 2.00%) · falsifier `rate_x100 > 2000` (20% 초과). Worked example 5 model × {total, fake}: **harvey_legal (100/2 · rate 2% silent · legal-specialist)** · **gpt5_law (100/8 · 8% silent)** · **claude_legal (100/5 · 5% silent)** · **general_gpt5 (100/30 · 30% FIRES · Mata v. Avianca class)** · **weak_legal (100/45 · 45% FIRES)** — bidirectional 3 silent (legal-specialized · 판례 인용 신뢰) + 2 fires (general + 얕은 tune · 가짜 판례 인용) + sanity (hallucinated ≤ total all · rate ladder monotone harvey ≤ claude ≤ gpt5_law ≤ general_gpt5 ≤ weak_legal). Verdict `VERTICAL/LAW/verdicts/a1_citation_hallucination_verdict.txt`. External anchors: Guha 2023 LegalBench (arXiv:2308.11462) · Mata v. Avianca 2023 (가짜 판례 인용 사건 · S.D.N.Y. · 변호사 sanction) · Dahl 2024 Large Legal Fictions (arXiv:2401.01301). sentinel `__HEXA_CODEX_LAW_A1_CITATION_HALLUCINATION__ DONE` (bench) + `__HEXA_CODEX_NUMERICS_LAW_A1__ DONE` (verify). **실측 측정 DEFERRED** — cycle-11+ T4 (LegalBench / 판례 DB cross-check hallucination harness on lm_foundry eval + vast.ai pod). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — identity close ≠ measured close. 축 N (jurisdiction 일관성) 다음 ⭐ MAIN priority lane.

### 축 B — B1 법률 추론 체인 (measured ladder)
- [ ] B1 — IRAC (Issue-Rule-Application-Conclusion) 정합성 · 법적 추론 체인이 issue 식별 → rule 진술 → application → conclusion 으로 정합하게 흐르는가 측정. 반증자: IRAC rule 적용 오류 > 15% → 법적 추론 정합성 부재 (판례는 맞게 인용해도 사안 적용 논리가 깨짐). LegalBench 의 rule-application task surface 와 직결.

### 축 N — 🆕 NOVEL: jurisdiction 일관성 (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — LAW self-NOVEL. 관할별 법 차이 (US state vs federal vs 타국). 도착지 없음.
- [ ] N1 — 같은 사안을 다른 관할(주/연방/국가)에 적용할 때의 법 일관성 · 한 답변 안에서 충돌하는 관할의 법을 혼용하지 않는가 cross-product fit. 반증자: jurisdiction 혼용 (한 답변에 충돌 관할 법) > 10% → jurisdiction 일관성 부재 (예: California 주법과 Texas 주법을 한 답변에 뒤섞거나, US federal 과 EU 규제를 혼동). 외부 anchor: Guha 2023 LegalBench (관할별 task) · Mata v. Avianca (US federal court).

## SANDBOX 활용 (measurement substrate)

LAW 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — LegalBench eval (mac M3 / ubu-1) / 판례 DB cross-check / HF transformers infer / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local (closed-form) | `VERTICAL/LAW/verdicts/a1_citation_hallucination_verdict.txt` |
| B1 IRAC ladder | SANDBOX bench harness (LegalBench rule-application) | `VERTICAL/LAW/verdicts/b1_*` |
| N1 ⭐ NOVEL jurisdiction | lm_foundry / HF eval / vast.ai pod | `VERTICAL/LAW/verdicts/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM legal-routing wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| 판례 인용 검증 gate · IRAC 추론 정합성 router · jurisdiction 분기 | legal 답변 시 판례 DB cross-check gate · IRAC 정합성 미달 시 refusal/disclaimer · 관할 명시 강제 router | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **LAW 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반. A1 은 현재 placeholder data 의 closed-form identity (🔵 STRUCTURAL + 🟡 BY-CITATION) — 실측 (🟢 SUPPORTED-NUMERICAL) 아님.
- **법률 truth 는 외부 ground.** 판례 인용은 실제 판례 DB 에 cross-check 가능 — hallucination 은 즉시 falsifiable (Mata v. Avianca 가 보여준 cost). 측정은 ground truth 대비여야 하고 self-judge 금지.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **법률 조언 disclaimer.** 모든 legal 측정 출력은 `not legal advice` boilerplate 를 전제 — 측정 layer 이지 실무 변호 아님.
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: 가짜 판례 비율 > 20% → 판례 인용 신뢰 불가 · IRAC rule 적용 오류 > 15% → 추론 정합성 부재 · jurisdiction 혼용 > 10% → 관할 일관성 부재
> **Anticipated ENGINE behavior wire**: 판례 DB cross-check gate · IRAC 정합성 router · jurisdiction 명시 강제 router
>
> ⏸ DEFERRED waiting on cycle-11+ T4 measured fire (LegalBench / 판례 DB cross-check hallucination rate + IRAC rule-application 오류율 + jurisdiction 혼용율).

## Cross-refs

- 후보 카탈로그: [`../../AXIS.easy.md`](../../ARCHITECTURE.json)
- ENGINE intake matrix (driving lane): [`../../ENGINE/ENGINE.md`](../../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../../SANDBOX.md`](../../ARCHITECTURE.json)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- vertical sibling: [`../CODE/CODE.md`](../CODE/CODE.md) (코드 전문 모델 측정) · [`../BIO/BIO.md`](../BIO/BIO.md) (바이오/의료 전문 모델 측정) · VERTICAL/MATH · VERTICAL/MEDICAL
- 기존 sibling 참고 (축 구조 패턴): [`../../MULTIMODAL/MULTIMODAL.md`](../../MULTIMODAL/MULTIMODAL.md) · [`../../DATA-QUALITY/DATA-QUALITY.md`](../../DATA-QUALITY/DATA-QUALITY.md) · [`../../LONG-CONTEXT/LONG-CONTEXT.md`](../../LONG-CONTEXT/LONG-CONTEXT.md)
- this domain: [`LAW.md`](LAW.md) (snapshot) · [`LAW.log.md`](LAW.log.md) (history)
