# AGENT-SKILL — 에이전트 스킬 (model-generated skill artifacts)

@title: 🛠️ AGENT-SKILL — "AI의 업무 매뉴얼"
@goal: **모델이 만든 에이전트 스킬(자연어 절차 문서)의 효용을 영구 측정·확장하는 lane** — 스킬 재사용이 다운스트림 에이전트를 정말 돕는가(vs negative transfer), 무엇이 효용을 가르는가(경험→추출→소비 lifecycle), 스킬을 자가진화로 키울 수 있는가. 가중치를 건드리지 않고 frozen 에이전트가 참고하는 *스킬 문서 한 장* 이 측정 unit. 새 추출기·소비 타깃·도메인·자가진화 기법이 등장할 때마다 측정 frontier 가 다시 열린다. **도착지 없음 · 종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> **상태: SEED (cycle 미진입).** 아래 축은 모두 `[ ]` (미측정). 어떤 셀도 `🟢 SUPPORTED-NUMERICAL` 를 주장하지 않는다. 첫 `/cycle` first-probe (closed-form identity 또는 measured bench) 전까지 verdict 날조 금지 (`cx_claim_verify` · `cx_empirical_contact`).
>
> **이름 선택 (AGENT-SKILL vs SKILL):** 본 repo 는 자체 *skills* (슬래시커맨드 · `sidecar`/`CLAUDE.md` 배관)를 이미 보유 — bare `SKILL` 은 "우리 명령어 스킬 측정"으로 오독 위험. `AGENT-SKILL` 로 네임스페이스 충돌 0 + lifecycle(추출·소비·진화·전이) 전체 포괄 (완성도·안전 축 채택).
>
> **canonical seed (verbatim 원본):** [`../FRONTEND/sample/`](../FRONTEND/sample/README.md) — Microsoft `SkillOpt`(arXiv:2605.23904 · 자가진화 옵티마이저) · `SkillLens`(arXiv:2605.23899 · lifecycle 진단 연구) 오프라인 미러. 본 도메인이 그 두 논문의 토픽 홈 (FRONTEND 는 방법론 차용처). 향후 `AGENT-SKILL/sample/` 로 이전/링크 가능.
>
> **Falsifier class (예비):** 스킬 효용 Δ<0 (negative transfer) 케이스 > 25% → 스킬 재사용 unsafe (SkillLens Finding 1: 75/25) · 추출기 순위와 실행기 순위 상관 r > 0.8 → "추출=실행" (Finding 2 반증) · 동일 스킬의 타깃간 효용 분산이 평균보다 작음 → 소비자-독립 (Finding 3 반증) · 자가진화 루프가 held-out gate 에서 단조 개선 실패 → SkillOpt 루프 무효.

## North-star

frozen 에이전트가 *스킬 문서* 를 재사용할 때 (1) 평균적으로 돕는가, 어디서 역효과(negative transfer)가 나는가, (2) 좋은 스킬을 뽑는 능력(extraction)이 일을 잘하는 능력(execution)과 분리되는가, (3) 같은 스킬이 누가 소비하느냐(target)에 따라 약이 되고 독이 되는가, (4) rollout→reflect→edit→gate 루프로 스킬을 자동 진화시킬 수 있는가. 출력이 *모델 가중치* 가 아니라 *텍스트 절차 문서* 라, AGENT(서빙/궤적) 와 직교하는 metric 으로 측정한다.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes · 전부 미측정 SEED)

> AGENT-SKILL 은 완료되지 않는다. 새 추출기·소비 타깃·도메인·자가진화 기법·전이 시나리오가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — 스킬 효용 Δ (help vs negative-transfer)
- [ ] A1 — 스킬 적용 전/후 점수차 Δ = score_with_skill − score_baseline 의 분포. 반증자: Δ<0 (negative transfer) 케이스 > 25% → 스킬 재사용 unsafe. 외부 anchor: SkillLens Finding 1 (도움 75% / 역효과 25% · ALFWorld 47% 역효과로 가장 fragile).

### 축 B — 추출 ≠ 실행 (extraction is a distinct capability)
- [ ] B1 — 추출기 효율(EE = 타깃 평균 Δ) 순위 vs 실행 능력 순위의 상관. 반증자: r > 0.8 → "센 실행기가 곧 센 추출기" (Finding 2 반증). 외부 anchor: SkillLens Finding 2 (SpreadsheetBench 에서 경량 Gem-3.1-FL 이 EE 1위, 최강 실행기 GPT-5.4 가 꼴찌).

### 축 C — 소비자 의존성 (target-dependent utility)
- [ ] C1 — 도메인·추출기 고정, 타깃만 교체했을 때 동일 스킬의 효용 분산. 반증자: 타깃간 분산 < noise → 소비자-독립 (Finding 3 반증). 외부 anchor: SkillLens Finding 3 (ALFWorld 에서 GPT-5.4 TE=+4.93 vs Qwen-9B −1.69 — 같은 스킬이 약/독).

### 축 N — 🆕 NOVEL: 자가진화 스킬 (⭐ MAIN priority lane · SkillOpt 직결)
> **⭐ MAIN priority lane** — SkillOpt 직결. frozen 에이전트 위에서 스킬 문서를 rollout→reflect→edit(bounded "텍스트 학습률")→held-out gate 로 진화시킬 때 효용이 단조 개선되는가, 통제장치(rejected buffer·slow update·메타-스킬)가 실제로 안정화에 기여하는가. 도착지 없음. 외부 anchor: SkillOpt (arXiv:2605.23904 · 52/52 best, 전이 +15.2 cross-model / +31.8 cross-harness).
- [ ] N1 — 자가진화 루프 라운드별 held-out selection 점수 단조성 + ablation(학습률/buffer/메모리 제거시 하락). 반증자: gate 통과 편집이 held-out 에서 개선 실패 OR ablation 무차별 → 루프가 propose-and-test 최적화 아님. measured-tier (SANDBOX rollout 루프).

## SANDBOX 활용 (measurement substrate)

AGENT-SKILL 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — HF transformers / 로컬 모델 infer (추출기↔타깃 pair) · rollout 루프 harness · lm_foundry eval · vast.ai/RunPod pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 효용 Δ 분포 | SANDBOX bench harness (추출기×타깃×도메인 Δ matrix) | `AGENT-SKILL/verdicts/a1_*` |
| B1 추출≠실행 상관 | EE/TE 랭킹 harness | `AGENT-SKILL/verdicts/b1_*` |
| C1 소비자 의존성 | 타깃 swap 분산 harness | `AGENT-SKILL/verdicts/c1_*` |
| N1 ⭐ NOVEL 자가진화 | SkillOpt-식 rollout→gate 루프 (SANDBOX) | `AGENT-SKILL/verdicts/n1_*` |

## Honesty invariants

- **SEED 상태 — verdict 날조 금지.** 모든 축 `[ ]` 미측정. 첫 first-probe 전까지 `🟢` 주장 없음 (`cx_claim_verify`). 축 metric/anchor 는 first-probe 시 확정 (지금은 후보).
- **seed = verbatim 원본.** SkillOpt·SkillLens 미러는 [`../FRONTEND/sample/`](../FRONTEND/sample/README.md) 에 byte-faithful 보관 — 요약본 아님. 페이지 표기 모델명(GPT-5.5 등)·arXiv id 는 원문 그대로 인용.
- **측정 ≠ 추천.** 본 도메인은 스킬 재사용의 *효용을 측정* 할 뿐 특정 스킬/추출기를 추천하지 않는다. Finding 은 closed-form 또는 measured benchmark 기반.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## Cross-refs

- canonical seed (verbatim 원본): [`../FRONTEND/sample/README.md`](../FRONTEND/sample/README.md) — SkillOpt · SkillLens
- 자매 측정 도메인 (직교): [`../AGENT/AGENT.md`](../AGENT/AGENT.md) (에이전트 서빙/궤적 — AGENT-SKILL 은 그 스킬-아티팩트 축)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../ARCHITECTURE.json)
- ENGINE intake matrix (승격 대상 · measured tier 도달 시): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- this domain: [`AGENT-SKILL.md`](AGENT-SKILL.md) (snapshot) · [`AGENT-SKILL.log.md`](AGENT-SKILL.log.md) (history)
