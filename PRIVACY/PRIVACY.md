# PRIVACY — 학습 데이터 누설 점검

@title: 🔒 PRIVACY — "학습 데이터 누설 점검"
@goal: **학습 corpus 의 개인정보·저작권 텍스트 복원 가능성을 영구 측정·차단하는 lane.** 새 DP 방법·corpus·extraction 기법 가 등장할 때마다 측정 frontier 가 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Candidate sibling from [`AXIS.easy.md`](../AXIS.easy.md) (브레인스토밍 ⭐⭐⭐). ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** membership inference accuracy > random baseline + 5pp → 학습 흔적 식별 가능
>
> **Sibling parallel:** SAFETY 는 '유해 응답 거부', PRIVACY 는 '학습 흔적 보호' — 시간 (학습→추론) 차원의 별 lane

## North-star

학습 데이터를 통째로 외워 그대로 뱉어내면 'knowledge' 가 아니라 'copy'. LLM 도 그러면 저작권·프라이버시 위험.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> PRIVACY 은 완료되지 않는다. 새 DP 방법·corpus·extraction 기법 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — first probe (closed-form baseline)
- [ ] A1 — membership inference accuracy vs random baseline. 반증자: membership inference accuracy > random baseline + 5pp → 학습 흔적 식별 가능.

### 축 B — second probe (measured ladder)
- [ ] B1 — canary extraction rate × corpus type × prompt strategy ladder. 반증자: canary extraction rate > 1% on standard prompt prefix.

### 축 N — 🆕 NOVEL: memorization-vs-utility Pareto (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — PRIVACY 의 self-NOVEL axis. DP ε 별 utility loss 곡선 — privacy 와 capability 의 trade-off frontier. 외부 anchor: Carlini 2021 extraction · Abadi 2016 DP-SGD · Lukas 2023 LLM extraction.
- [ ] N1 — DP ε ∈ {∞, 8, 4, 1, 0.1} 별 utility 측정 + 매핑된 extraction rate. 반증자: ε = 8 (실용적) 에서 utility drop > 20% → DP impractical at scale (Pareto 위치 보고).

## SANDBOX 활용 (measurement substrate)

PRIVACY 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `.verdicts/PRIVACY/a1_*` |
| B1 ladder | SANDBOX bench harness | `.verdicts/PRIVACY/b1_*` |
| N1 ⭐ NOVEL | mac M3 / vast.ai pod | `.verdicts/PRIVACY/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| DP-SGD ε schedule + redaction gate | DP-SGD noise schedule · 학습 데이터 redaction · refusal at extraction prompt | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **PRIVACY 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../ECONOMICS.md`](../ECONOMICS.md) · [`../NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md)
- this domain: [`PRIVACY.md`](PRIVACY.md) (snapshot) · [`PRIVACY.log.md`](PRIVACY.log.md) (history)
