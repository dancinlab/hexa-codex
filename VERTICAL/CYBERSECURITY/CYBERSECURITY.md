# CYBERSECURITY — 보안 분석가

@title: 🛡️ CYBERSECURITY — "보안 분석가"
@goal: **보안 전문 모델의 능력 (취약점 탐지율 · false-positive 비율 · preemptive 선제 차단 우위) 을 영구 측정·확장하는 lane — 전적으로 DEFENSIVE 관점.** 2026 frontier 의 Foundation-Sec-8B-Reasoning (첫 open-source native reasoning security LLM) 가 등장하며 보안 전문 모델이 범용 모델을 능가하기 시작했다 — 모델이 코드/시스템 내 취약점을 얼마나 놓치지 않고 탐지하는가, 정상을 위협으로 오탐하지 않는가, 그리고 공격이 실행되기 전에 선제 차단하는가. **⚠ DUAL-USE 주의: 측정은 defensive (탐지율·취약점 발견·방어) 만 — 공격 기법 생성·exploit 합성은 측정 대상이 아니다 (그런 set 은 PRIVATE default · [[cx_hf_safety_private]]).** 새 보안 model·benchmark·취약점 class 가 등장할 때마다 측정 frontier 가 다시 열린다. **도착지 없음 · 종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> `VERTICAL/*` 그룹 폴더의 보안 도메인 (cycle-10) — 2026 frontier 의 보안 전문 모델 측정. CYBERSECURITY = 보안 분석 모델 (Foundation-Sec frontier) 측정. ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **⚠ DUAL-USE governance** ([[cx_hf_safety_private]]): 본 도메인은 **defensive 측정만** — 취약점 탐지 coverage · 방어 신뢰도. 공격 기법 생성·jailbreak·exploit 합성은 측정하지 않는다. 적대적/harmful eval set 은 PRIVATE default (공개는 사용자 sign-off 시에만). 측정 metric (탐지율↑ = 방어↑) 은 본질적으로 defender 의 관점.
>
> **Falsifier class:** 취약점 탐지율 < 60% → 보안 모델로 부족 (취약점 절반 가까이를 놓침 · 방어 신뢰 불가). 또는 false-positive > 20% → 운영 마비 (alert fatigue · 정상을 위협으로 오탐). 또는 preemptive 탐지율 < reactive × 1.2 → 예측 무의미 (사후 대응으로 충분).
>
> **Sibling parallel:** VERTICAL/CODE 의 B1 (생성 코드 취약점률 · CWE) 은 '모델이 만든 코드가 안전한가', CYBERSECURITY 는 '모델이 취약점을 얼마나 탐지·방어하는가' — 생성-측 보안 ↔ 분석-측 보안. ROBUSTNESS (adversarial) 와 인접 — adversarial perturbation 견고성 ↔ adversarial 공격 탐지. SUBSTRATE 는 '능력 일반', VERTICAL/CYBERSECURITY 는 '보안 분석이라는 한 vertical 의 깊이'.

## North-star

보안 전문 모델이 주어진 취약점(CTF/CVE) 중 얼마나 탐지해 내는가 (detection rate) — 보안 분석가라면 취약점을 놓치지 않아야 한다. 그리고 정상 트래픽/코드를 위협으로 오탐하지 않는가 (false positive · alert fatigue 는 실제 위협을 묻어버린다). 마지막으로, 공격이 실행된 뒤에 대응(reactive)하는 것이 아니라 공격이 일어나기 전에 예측·선제 차단(preemptive)하는가 — 2026 preemptive cybersecurity 패러다임의 핵심.

모든 측정은 defensive — 탐지·방어 coverage 다. 공격 기법 생성은 측정하지 않는다 ([[cx_hf_safety_private]]).

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> CYBERSECURITY 는 완료되지 않는다. 새 보안 model·benchmark·취약점 class·공격 패턴이 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — A1 취약점 탐지율 (defensive · closed-form baseline · Foundation-Sec frontier 직결)
- [x] A1 — 취약점 탐지율 (defensive) · 5 security-analyst model × {vulns_total, vulns_detected} (CTF/CVE 탐지). 반증자: `detection_rate < 60` (취약점 탐지율 < 60% · 보안 모델로 부족) → 방어 신뢰 불가. **CYCLE-10 first probe (2026-05-28 · VERTICAL/CYBERSECURITY 신규 도메인):** `VERTICAL/CYBERSECURITY/bench/cybersecurity_a1_vuln_detection.hexa` + `VERTICAL/CYBERSECURITY/verify/numerics_cybersecurity_a1_vuln_detection.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL + 🟡 BY-CITATION. Identity: `detection_rate_x100 = vulns_detected × 100 / vulns_total` (vulns_total=100 정규화 count ledger → rate in plain %) · falsifier `rate < 60%`. Worked example 5 models × {vulns_total, vulns_detected}: **foundation_sec_8b (100/85 · rate 85% silent · Foundation-Sec-8B-Reasoning)** · **sec_gpt5 (100/80 · 80% silent)** · **sec_claude (100/78 · 78% silent)** · **general_gpt5 (100/45 · 45% FIRES · 범용 강력하지만 보안 탐지율 부족)** · **weak_sec (100/30 · 30% FIRES · 방어 신뢰 불가)** — bidirectional 3 silent (보안 전문 · 방어 신뢰) + 2 fires (탐지율 부족) + general-vs-sec gap (범용 강력 모델 general_gpt5 가 보안 탐지율 45% 로 FIRES — 일반 능력 ≠ 보안 능력 · 보안 전문 모델이 필요한 이유). Verdict `VERTICAL/CYBERSECURITY/verdicts/a1_vuln_detection_verdict.txt`. **⚠ DUAL-USE: DEFENSIVE 측정만 (탐지 coverage) · 공격 기법 생성 아님** ([[cx_hf_safety_private]]). External anchors: Foundation-Sec-8B-Reasoning 첫 open-source native reasoning security LLM (arXiv:2601.21051) · Zhang 2024 CyBench (arXiv:2408.08926) · SecEval · MITRE ATT&CK. sentinel `__HEXA_CODEX_CYBERSECURITY_A1_VULN_DETECTION__ DONE` (bench) + `__HEXA_CODEX_NUMERICS_CYBERSECURITY_A1__ DONE` (verify). **실측 측정 DEFERRED** — cycle-11+ T4 (CyBench/SecEval CTF·CVE 탐지 eval · vast.ai pod). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — identity close ≠ measured close. 축 N (preemptive vs reactive 우위) 다음 ⭐ MAIN priority lane.

### 축 B — B1 false-positive 비율 (measured ladder)
- [ ] B1 — false-positive 비율 · 정상 트래픽/코드를 위협으로 오탐하는 비율 측정 (alert fatigue). 반증자: false-positive > 20% → 운영 마비 (오탐이 너무 많으면 실제 위협이 묻히고 분석가가 alert 를 무시하게 됨 · alert fatigue). A1 의 탐지율(놓치지 않는가) 과 dual — 탐지율이 높아도 오탐이 20% 넘으면 실전 배포 불가 (precision/recall trade-off 의 보안 버전).

### 축 N — 🆕 NOVEL: preemptive vs reactive 우위 (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — CYBERSECURITY self-NOVEL. preemptive cybersecurity 패러다임 (공격이 실행되기 전에 예측·선제 차단). 2026 frontier 의 핵심 — Foundation-Sec 같은 reasoning security LLM 이 공격 chain 을 미리 추론해 선제 차단하는가, 아니면 공격이 일어난 뒤에야 대응(reactive)하는가. 도착지 없음. 외부 anchor: Foundation-Sec-8B-Reasoning (arXiv:2601.21051 · native reasoning → preemptive chain 추론) · MITRE ATT&CK (kill-chain 단계별 차단).
- [ ] N1 — 공격 실행 전 예측 차단 (preemptive) vs 사후 대응 (reactive) 효율 cross-product fit. 반증자: preemptive 탐지율 < reactive × 1.2 → 예측 무의미 (선제 차단이 사후 대응 대비 20% 이상 우위가 없으면 reasoning-기반 preemptive 비용이 정당화 안 됨 · 사후 대응으로 충분). measured-tier 필요. ⚠ defensive — 공격 chain 을 *탐지·차단* 하는 측정이지 *생성* 이 아님.

## SANDBOX 활용 (measurement substrate)

CYBERSECURITY 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — 보안 모델 infer (mac M3 / ubu-1) / HF transformers infer / CyBench·SecEval 탐지 eval / vast.ai pod (cost-bearing 시). **⚠ 적대적/공격 기법 set 은 PRIVATE default** ([[cx_hf_safety_private]]) — 측정 input 은 defensive 탐지 eval (취약점이 주어지고 모델이 찾아내는가) 만.

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `VERTICAL/CYBERSECURITY/verdicts/a1_*` |
| B1 ladder (false-positive) | SANDBOX bench harness (정상셋 오탐 측정) | `VERTICAL/CYBERSECURITY/verdicts/b1_*` |
| N1 ⭐ NOVEL (preemptive) | 보안 모델 infer / CyBench / vast.ai pod | `VERTICAL/CYBERSECURITY/verdicts/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 보안-분석 routing wire 로 변환. ⚠ 전적으로 defensive routing — 탐지 gate · 오탐 억제 · 선제 차단 분기.

| surface | wired target | wiring path |
|---|---|---|
| 취약점 탐지율 gate · false-positive 억제 · preemptive 선제 차단 router | 탐지율 < 60% 모델 보안 task 차단 gate · 오탐 20% 초과 모델 alert 억제 · preemptive 우위 시 선제 차단 분기 | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **CYBERSECURITY 측정 = DEFENSIVE only.** 모든 axis 는 방어 관점 (탐지·오탐·선제 차단) — 공격 기법 생성·exploit 합성은 측정하지 않으며 그런 set 은 PRIVATE default ([[cx_hf_safety_private]]). dual-use 우려 차단.
- **측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반. A1 은 현재 placeholder data 의 closed-form identity (🔵 STRUCTURAL + 🟡 BY-CITATION) — 실측 (🟢 SUPPORTED-NUMERICAL) 아님.
- **일반 능력 ≠ 보안 능력.** A1 의 general_gpt5 (범용 강력 모델 · 보안 탐지율 45% FIRES) 가 핵심 — 범용 LLM 성능이 높다고 보안 탐지를 잘하는 게 아니다 (보안 전문 모델이 필요한 이유 · Foundation-Sec frontier 의 존재 근거).
- **탐지율 ↔ 오탐 dual.** A1 (놓치지 않는가) 과 B1 (오탐하지 않는가) 은 trade-off — 탐지율만 높이면 오탐이 늘어 운영이 마비된다 (precision/recall 의 보안 버전).
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: detection_rate < 60% → 보안 모델로 부족 · false-positive > 20% → 운영 마비 (alert fatigue) · preemptive < reactive × 1.2 → 예측 무의미
> **Anticipated ENGINE behavior wire**: 탐지율 gate (defensive) · false-positive 억제 · preemptive 선제 차단 router
>
> ⏸ DEFERRED waiting on cycle-11+ T4 measured fire (CyBench/SecEval CTF·CVE 탐지 eval · vast.ai pod).

## Cross-refs

- 후보 카탈로그: [`../../AXIS.easy.md`](../../ARCHITECTURE.json)
- ENGINE intake matrix (driving lane): [`../../ENGINE/ENGINE.md`](../../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../../SANDBOX.md`](../../ARCHITECTURE.json)
- 인접 sibling (생성-측 보안 ↔ 분석-측 보안): [`../CODE/CODE.md`](../CODE/CODE.md) (B1 생성 코드 취약점률 CWE = 모델이 만든 코드의 보안 · CYBERSECURITY A1 = 모델이 취약점을 탐지하는 보안)
- 인접 sibling (adversarial 견고성 ↔ adversarial 탐지): [`../../ROBUSTNESS/ROBUSTNESS.md`](../../ROBUSTNESS/ROBUSTNESS.md)
- dual-use governance: [[cx_hf_safety_private]] (공격 기법/exploit set PRIVATE default)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../ROBOTICS/ROBOTICS.md`](../ROBOTICS/ROBOTICS.md) · [`../MATH/MATH.md`](../MATH/MATH.md)
- this domain: [`CYBERSECURITY.md`](CYBERSECURITY.md) (snapshot) · [`CYBERSECURITY.log.md`](CYBERSECURITY.log.md) (history)
