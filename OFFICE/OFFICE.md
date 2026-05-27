# OFFICE — 만능 비서

@title: 🏢 OFFICE — "만능 비서"
@goal: **범용 사무 업무 generalist 모델의 능력 (이메일·요약·번역·문서·표·일정 6-task 평균) 을 영구 측정·확장하는 lane.** [`VERTICAL/*`](../VERTICAL/CODE/CODE.md) (CODE·BIO·MATH... 12 전문 모델 = "한 분야 깊게") 의 **horizontal 짝** — OFFICE 는 그 반대로 "범용 넓이" (한 모델로 모든 사무 task). 핵심: OFFICE 의 falsifier 가 VERTICAL 존재 이유를 **메타-검증** — generalist 가 전문 모델 못 이기면 DSLM "Small is the New Big" (전문 분산 모델 군) 정당화. 새 generalist model·사무 task·전문 모델 이 등장할 때마다 측정 frontier 가 다시 열린다. **도착지 없음 · 종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> **root-level horizontal 도메인 (cycle-10)** — `VERTICAL/` 그룹이 아니라 root 직속. VERTICAL/* 군 전체와 직교(orthogonal)한 dimension.
>
> | dimension | 무엇 | 예 |
> |---|---|---|
> | **VERTICAL/\*** (깊이 · vertical) | 한 분야를 깊게 — 전문 모델 측정 | CODE (코드 장인) · BIO · MATH · LAW · MEDICAL · FINANCE ... 12 |
> | **OFFICE** (넓이 · horizontal) | 범용 사무를 두루 — generalist 측정 | 이메일 · 요약 · 번역 · 문서 · 표 · 일정 (6-task) |
>
> **Falsifier class:** generalist 6-task 사무 평균이 각 분야 전문 모델 평균의 70% 미만 (`generalist_ratio < 70`) → generalist 가 각 분야 전문 못 따라감 → **VERTICAL/* 12 전문 모델 존재 정당화 · DSLM "Small is the New Big" 정당화 · generalist 대체론(통합 1개로 다 한다) 반증**. 또는 multi-task 세션 품질 < single-task 세션 × 0.8 → task-switching 비용. 또는 전문 모델 N개 합산 비용 < generalist 1개 → generalist 통합 경제 이점 소멸.
>
> **Sibling parallel:** [`VERTICAL/CODE`](../VERTICAL/CODE/CODE.md) 는 '코드라는 한 vertical 의 깊이', OFFICE 는 '모든 사무의 넓이' — 같은 능력 공간의 직교 축. lm_foundry "narrow-and-deep" thesis (specialist > generalist on home turf) 의 **반대편 측정 surface** — generalist 가 home turf 없는 범용에서 얼마나 버티는가.

## North-star

만능 비서(generalist) 한 명이 6가지 사무 task (이메일 작성·문서 요약·번역·문서 생성·표 작성·일정 관리) 를 평균적으로 처리하는 능력 vs 각 task 의 전문 모델(specialist) 평균. generalist 가 specialist 의 70% 미만이면 "넓게 얕게" 가 "깊게" 를 못 따라간다 — 그러면 전문 모델 12개(VERTICAL/*)가 존재할 이유가 정당화되고, generalist 통합론(모델 1개로 다 한다)은 반증된다.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> OFFICE 는 완료되지 않는다. 새 generalist model·사무 task·전문 모델·경제 모델이 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — A1 generalist-vs-specialist gap (closed-form baseline · VERTICAL 메타검증 직결)
- [x] A1 — generalist-vs-specialist gap · 5 model × {office_multitask_avg_x100, specialist_avg_x100} (이메일·요약·번역·문서·표·일정 6-task 평균 vs 각 분야 전문 모델 평균). 반증자: `generalist_ratio < 70` (generalist multi-task 평균 < 전문 모델 × 0.7) → generalist 가 각 분야 전문 못 따라감 (DSLM "Small is the New Big" 정당화 · generalist 대체론 반증). **CYCLE-10 first probe (2026-05-28 · OFFICE 신규 root-level horizontal 도메인):** `OFFICE/bench/office_a1_generalist_gap.hexa` + `OFFICE/verify/numerics_office_a1_generalist_gap.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL + 🟡 BY-CITATION. Identity: `generalist_ratio_pct = office_multitask × 100 / specialist_avg` (score × 100 ledger · × 100 factors cancel → ratio in plain %) · falsifier `ratio < 70%`. Worked example 5 models × {office, spec}: **gpt5_office (88/92 · ratio 95% silent · 거의 대등)** · **claude_office (86/91 · 94% silent)** · **gemini_office (84/90 · 93% silent)** · **weak_generalist (55/92 · 59% FIRES · 전문 못 따라감)** · **tiny_general (40/92 · 43% FIRES · 전문 한참 못 따라감)** — bidirectional 3 silent (강 generalist · 통합 이점) + 2 fires (전문 못 따라감 · DSLM 정당화) + sanity (office ≤ specialist all · ratio ladder monotone). Verdict `OFFICE/verdicts/a1_generalist_gap_verdict.txt`. External anchors: Liang 2022 HELM (arXiv:2211.09110) · Hendrycks 2020 MMLU (arXiv:2009.03300) · Srivastava 2022 BIG-bench (arXiv:2206.04615) · DSLM "Small is the New Big" specialist-swarm trend 2026. sentinel `__HEXA_CODEX_OFFICE_A1_GENERALIST_GAP__ DONE` (bench) + `__HEXA_CODEX_NUMERICS_OFFICE_A1__ DONE` (verify). **실측 측정 DEFERRED** — cycle-11+ T4 (6-task 사무 harness vs 분야별 전문 모델 on SANDBOX bench + vast.ai pod). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — identity close ≠ measured close. 축 N (범용-전문 경제 교차점) ⭐ MAIN priority lane.

### 축 B — B1 task-switching 비용 (measured ladder)
- [ ] B1 — task-switching 비용 · 한 세션에서 여러 사무 task 를 전환할 때 품질 저하. 반증자: multi-task 세션 품질 < single-task 세션 × 0.8 → task-switching 비용 (generalist 가 한 세션에 여러 task 를 섞으면 single-task 전용 대비 0.8 미만으로 떨어짐 — context 분산 cost).

### 축 N — 🆕 NOVEL: 범용-전문 경제 교차점 (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — OFFICE self-NOVEL axis. generalist(편의·통합) vs specialist swarm(정확·분산) 의 경제 교차점 — VERTICAL 군 전체의 메타-검증. generalist 1개 운영 비용이 N개 전문 모델 운영 비용보다 싸면 통합이 이긴다; 비싸면 전문 분산이 이긴다 (break-even). 도착지 없음. 외부 anchor: DSLM "Small is the New Big" specialist-swarm 경제론 2026 · HELM cost-efficiency (Liang 2022 arXiv:2211.09110).
- [ ] N1 — generalist 1개 운영 비용 vs N개 전문 모델 운영 비용의 break-even cross-product fit. 반증자: 전문 모델 N개 합산 비용 < generalist 1개 (전문 분산이 더 경제적) → generalist 통합 이점 소멸 (편의는 있어도 비용이 N-specialist swarm 보다 비싸면 통합론 경제 근거 붕괴).

## SANDBOX 활용 (measurement substrate)

OFFICE 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — 6-task 사무 harness (mac M3 / ubu-1) / HF transformers infer / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `OFFICE/verdicts/a1_*` |
| B1 ladder (task-switching) | SANDBOX bench harness | `OFFICE/verdicts/b1_*` |
| N1 ⭐ NOVEL (경제 교차점) | SANDBOX cost harness / vast.ai pod | `OFFICE/verdicts/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM routing wire 로 변환 (generalist 통합 vs specialist swarm 라우팅 결정).

| surface | wired target | wiring path |
|---|---|---|
| generalist 통합 vs specialist swarm 결정 · task-switching gate · 경제 break-even router | 사무 task 를 generalist 1개로 보낼지 분야별 전문 모델로 분기할지 결정 · 멀티-task 세션 분리 gate · 비용 break-even 기반 라우팅 | ENGINE intake matrix 승격 시 axis letter 부여 |

## VERTICAL 메타-검증 직결 (horizontal ↔ vertical)

OFFICE 는 추상 benchmark 가 아니라 **VERTICAL/* 군 전체의 존재 정당성을 검증**한다:

- **A1 falsifier 가 fires (`generalist_ratio < 70`)** → generalist 가 각 분야 전문 모델 못 따라감 → **VERTICAL/* (CODE·BIO·MATH·LAW·MEDICAL·FINANCE·SCIENCE·ROBOTICS·MATERIALS·WEATHER·CYBERSECURITY ...) 12 전문 모델 존재 정당화** · DSLM "Small is the New Big" 정당화 · generalist 대체론(통합 1개) 반증.
- **A1 falsifier 가 silent (`generalist_ratio ≥ 70`)** → generalist 가 거의 대등 (통합 이점) → 전문 모델의 marginal 우위가 좁음 (그래도 VERTICAL home turf 우위는 별도 측정 — CODE A1 의 hexa_mk1 narrow-and-deep).
- placeholder 결과: **gpt5/claude/gemini_office silent (93–95% · 거의 대등)** vs **weak/tiny_generalist fires (43–59% · 전문 못 따라감)** — 강한 generalist 는 대등하지만 약한 generalist 는 전문 분산 정당화. 실측(T4)에서 어느 쪽이 우세한지가 VERTICAL 군 전체의 메타-검증.

## Honesty invariants

- **OFFICE 측정 ≠ generalist hype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반. A1 은 현재 placeholder data 의 closed-form identity (🔵 STRUCTURAL + 🟡 BY-CITATION) — 실측 (🟢 SUPPORTED-NUMERICAL) 아님.
- **메타-검증은 양방향.** OFFICE 가 generalist 우위를 증명하면 VERTICAL 약화, generalist 열위를 증명하면 VERTICAL 정당화 — strawman 아닌 honest bidirectional. closed-negative paper 는 외부 published 주장 (generalist 가 전문 모델 대체) 만 반증 ([[feedback_negative_paper_external_claim]]).
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: generalist_ratio < 70% → 전문 못 따라감 (VERTICAL 정당화) · multi-task 세션 품질 < single-task × 0.8 → task-switching 비용 · N-specialist 합산 비용 < generalist 1개 → 통합 경제 이점 소멸
> **Anticipated ENGINE behavior wire**: generalist 통합 vs specialist swarm 라우터 · multi-task 세션 분리 gate · 경제 break-even 기반 분기
>
> ⏸ DEFERRED waiting on cycle-11+ T4 measured fire (6-task 사무 harness vs 분야별 전문 모델 on SANDBOX bench + vast.ai pod).

## Cross-refs

- VERTICAL 메타검증 대상 (전문 모델 깊이 dimension): [`../VERTICAL/CODE/CODE.md`](../VERTICAL/CODE/CODE.md) (코드 장인 · 12 도메인 첫째) — OFFICE 의 horizontal 짝, VERTICAL/* 전체(BIO·MATH·LAW·MEDICAL·FINANCE·SCIENCE·ROBOTICS·MATERIALS·WEATHER·CYBERSECURITY)가 메타검증 대상
- 인접 범용 능력 도메인: [`../INSTRUCTION-FOLLOWING/INSTRUCTION-FOLLOWING.md`](../INSTRUCTION-FOLLOWING/INSTRUCTION-FOLLOWING.md) (범용 지시 이행 능력)
- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../MULTIMODAL/MULTIMODAL.md`](../MULTIMODAL/MULTIMODAL.md) · [`../DATA-QUALITY/DATA-QUALITY.md`](../DATA-QUALITY/DATA-QUALITY.md) · [`../LONG-CONTEXT/LONG-CONTEXT.md`](../LONG-CONTEXT/LONG-CONTEXT.md)
- this domain: [`OFFICE.md`](OFFICE.md) (snapshot) · [`OFFICE.log.md`](OFFICE.log.md) (history)
