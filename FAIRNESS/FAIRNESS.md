# FAIRNESS — 그룹별 차별 없는가

@title: ⚖️ FAIRNESS — "그룹별 차별 없는가"
@goal: **인구 그룹별 성능 격차·stereotyping 을 영구 측정·완화하는 lane.** 새 demographic axis·domain·intersectional pair 가 등장할 때마다 측정 frontier 가 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Candidate sibling from [`AXIS.easy.md`](../AXIS.easy.md) (브레인스토밍 ⭐⭐⭐). ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** demographic axes 의 accuracy gap > 10pp on standard task
>
> **Sibling parallel:** SAFETY 는 '유해 출력 거부', FAIRNESS 는 '중립일 때 균형' — 별 lane

## North-star

면접관이 같은 자격의 두 지원자를 다르게 평가하면 차별. LLM 도 그룹 명사 바꿔 stereotype 누설하면 fairness 위반.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> FAIRNESS 은 완료되지 않는다. 새 demographic axis·domain·intersectional pair 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — first probe (closed-form baseline)
- [x] A1 — group-wise accuracy gap (race · gender · age) · counterfactual fairness. 반증자: demographic axes 의 accuracy gap > 10pp on standard task. **CYCLE-9 round-2 first probe (2026-05-28):** `FAIRNESS/bench/fairness_a1_group_gap.hexa` + `FAIRNESS/verify/numerics_fairness_a1_group_gap.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL (absolute-delta metric identity) + 🟡 BY-CITATION (10pp threshold = Buolamwini 2018 / Wang 2022 BBQ). Identity: `gap(i,j) = |acc_i − acc_j|` (× 100) · `falsifier_fires = max_pairwise_gap > 10pp`. Metric properties 전부 검증: self-gap=0 · symmetry · non-negativity · range bound [0,100] · triangle inequality. Worked example 4 groups (A=82·B=78·C=71·D=84 × 100), max pairwise = |84−71| = 13 (groups C↔D) → falsifier 정확 발화. External anchors: Buolamwini 2018 gender shades (PMLR 81:1-15) · Crenshaw 1989 intersectionality (Univ Chicago Legal Forum 1989:139) · Wang 2022 BBQ (ACL 2022). **실측 demographic counterfactual eval DEFERRED** — cycle-10+ T4 (BBQ · CrowS-Pairs · WinoBias · ubu-1 HF transformers). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — metric close ≠ measured close. 축 N (intersectional vs single-axis gap · Crenshaw 1989) 다음 ⭐ MAIN priority lane.

### 축 B — second probe (measured ladder)
- [ ] B1 — stereotype rate × profession/role × persona × scale ladder. 반증자: scale ↑ 에도 stereotype rate 가 monotone-decrease 안 함 → scale 만으로 fairness 미해결.

### 축 N — 🆕 NOVEL: intersectional vs single-axis gap (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — FAIRNESS 의 self-NOVEL axis. 흑인-여성 같은 multi-axis 그룹 gap 이 단일축 (흑인 OR 여성) gap 의 합보다 큰가 (Crenshaw 1989 교차성). 외부 anchor: Buolamwini 2018 gender shades · Crenshaw 1989 intersectionality · Wang 2022 BBQ.
- [ ] N1 — single-axis gap (race, gender) vs intersectional gap (race × gender) 비교. 반증자: intersectional gap > single-axis gap sum + 5pp → 교차성 증거 (additive 가 아닌 multiplicative).

## SANDBOX 활용 (measurement substrate)

FAIRNESS 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `.verdicts/FAIRNESS/a1_*` |
| B1 ladder | SANDBOX bench harness | `.verdicts/FAIRNESS/b1_*` |
| N1 ⭐ NOVEL | mac M3 / vast.ai pod | `.verdicts/FAIRNESS/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| intersectional-aware DPO | DPO 데이터 선택 · refusal 기준 · stereotype regularization · group-balanced sampling | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **FAIRNESS 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../ECONOMICS.md`](../ECONOMICS.md) · [`../NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md)
- this domain: [`FAIRNESS.md`](FAIRNESS.md) (snapshot) · [`FAIRNESS.log.md`](FAIRNESS.log.md) (history)
