# FRONTEND — 프론트엔드 디자인 LLM

@title: 🎨 FRONTEND — "프론트엔드 디자인 LLM"
@goal: **프론트엔드/UI 디자인 생성 전문 LLM 의 능력 (디자인→코드 충실도 · 컴포넌트 재사용/일관성 · 자가진화 스킬 효용) 을 영구 측정·확장하는 lane.** code-gen 일반(VERTICAL/CODE)과 직교하는 vertical — 출력이 *정답 코드*가 아니라 *보이는 UI* 라서 정합성/심미/접근성/디자인-의도 충실도가 별개 metric 축이다. 새 design-to-code 모델·UI 벤치·디자인 시스템·자가진화 스킬 기법이 등장할 때마다 측정 frontier 가 다시 열린다. **도착지 없음 · 종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> **상태: SEED (cycle 미진입).** 본 도메인은 측정 전 골격이다 — 아래 축은 모두 `[ ]` (미측정). 어떤 셀도 `🟢 SUPPORTED-NUMERICAL` 를 주장하지 않는다. 첫 `/cycle` first-probe (closed-form identity 또는 measured bench) 전까지 verdict 날조 금지 (`cx_claim_verify` · `cx_empirical_contact`).
>
> **원본 seed:** [`sample/`](sample/README.md) — Microsoft `SkillOpt` · `SkillLens` 두 프로젝트 페이지를 **각각 서브폴더 오프라인 미러**로 보관 (HTML verbatim + 내부 이미지 16개 로컬 저장 · 이미지 URL 로컬 해석). 자가진화 agent-skill 방법론 seed (프론트엔드 전용 벤치 아님 — 방법론 참조).
>
> **Falsifier class (예비):** design→code 충실도(스크린샷 IoU/CLIP-sim) < 0.5 → 디자인 의도 못 옮김 · 생성 UI 접근성(WCAG) 위반율 > 30% → 접근성 부재 · 멀티컴포넌트 디자인-시스템 일관성 < 단일컴포넌트 × 0.5 → 시스템 맥락 못 다룸 · 자가진화 스킬 적용 후 효용 Δ < 0 인 케이스 > 25% → negative transfer (SkillLens Finding 1 mirror).

## North-star

프론트엔드 LLM 이 (1) 목업/스펙을 **보이는 대로** 코드로 옮기는가 (design→code 충실도), (2) 디자인 시스템 안에서 컴포넌트를 **일관되게** 재사용하는가, (3) 접근성/반응형 같은 *보이지 않는 품질* 을 지키는가, (4) SkillOpt/SkillLens 식 **자가진화 스킬 문서**로 스스로 나아지는가 — 그리고 그 스킬이 도움이 되는가 해가 되는가(negative transfer). 출력이 텍스트 정답이 아니라 *렌더된 화면* 이라, CODE 의 pass@k 와 직교하는 metric 으로 측정한다.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes · 전부 미측정 SEED)

> FRONTEND 는 완료되지 않는다. 새 design-to-code 모델·UI 벤치·디자인 시스템·접근성 기준·자가진화 스킬 기법이 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — design→code 충실도 (visible-output fidelity)
- [ ] A1 — 목업/스펙 → 렌더 스크린샷 충실도. 후보 metric: screenshot IoU · CLIP-image-sim · DOM-tree edit distance. 반증자: 충실도 < 0.5 → 디자인 의도 못 옮김. (외부 anchor 후보: Design2Code / WebSight 계열 — first-probe 시 확정.)

### 축 B — 컴포넌트 재사용 · 디자인-시스템 일관성
- [ ] B1 — 단일 컴포넌트 정확도 vs 멀티컴포넌트 디자인-시스템 일관성. 반증자: 멀티컴포넌트 일관성 < 단일 × 0.5 → 시스템 맥락 못 다룸 (토큰/스페이싱/네이밍 표류).

### 축 C — 보이지 않는 품질 (접근성 · 반응형)
- [ ] C1 — 생성 UI 의 WCAG 접근성 위반율 + 반응형 breakpoint 붕괴율. 반증자: 위반율 > 30% → 접근성 부재 (보이는 건 맞지만 쓸 수 없음).

### 축 N — 🆕 NOVEL: 자가진화 스킬 효용 (⭐ MAIN priority lane · sample seed 직결)
> **⭐ MAIN priority lane** — sample/ 의 SkillOpt·SkillLens 직결. 프론트엔드-디자인 agent 가 자기 *스킬 문서*(컴포넌트 패턴·디자인 토큰 규약)를 rollout→reflect→edit→gate 로 진화시킬 때 효용이 오르는가, 아니면 negative transfer 가 나는가.
- [ ] N1 — 자가진화 스킬 적용 전/후 design→code 효용 Δ + negative-transfer 발생률. 반증자: Δ < 0 케이스 > 25% → negative transfer (SkillLens Finding 1: 25% 부정전이 mirror). measured-tier (SANDBOX rollout 루프 · 유해 무관 public).

## SANDBOX 활용 (measurement substrate)

FRONTEND 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — HF transformers / 로컬 design-to-code 모델 infer · headless 브라우저 렌더(스크린샷 충실도) · lm_foundry eval · vast.ai/RunPod pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 design→code 충실도 | headless 렌더 + 스크린샷 sim harness | `FRONTEND/verdicts/a1_*` |
| B1 디자인-시스템 일관성 | SANDBOX bench harness | `FRONTEND/verdicts/b1_*` |
| C1 접근성/반응형 | axe-core / lighthouse headless | `FRONTEND/verdicts/c1_*` |
| N1 ⭐ NOVEL 자가진화 스킬 | SkillOpt-식 rollout 루프 (SANDBOX) | `FRONTEND/verdicts/n1_*` |

## Honesty invariants

- **SEED 상태 — verdict 날조 금지.** 모든 축 `[ ]` 미측정. 첫 first-probe 전까지 `🟢` 주장 없음 (`cx_claim_verify`). 축 metric/anchor 는 first-probe 시 확정 (지금은 후보).
- **sample/ 는 verbatim 원본.** SkillOpt·SkillLens 는 byte-identical 보관 (`cmp` clean) — paraphrase/요약본 아님. 편집 금지, 갱신 필요 시 통째 재fetch.
- **topic 정직.** 두 sample 은 *일반 agent-skill* 연구 — 프론트엔드 전용 벤치가 아니라 축 N 의 **방법론 seed**. 프론트엔드 충실도 주장의 근거로 오용하지 않음.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).

## Cross-refs

- 원본 seed (verbatim): [`sample/README.md`](sample/README.md) — SkillOpt · SkillLens
- vertical peer sibling: [`../VERTICAL/CODE/CODE.md`](../VERTICAL/CODE/CODE.md) (코드 generic — FRONTEND 와 직교) · [`../VERTICAL/UNCENSORED/UNCENSORED.md`](../VERTICAL/UNCENSORED/UNCENSORED.md) (축 구조 패턴 참고)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- ENGINE intake matrix (승격 대상 · measured tier 도달 시): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- this domain: [`FRONTEND.md`](FRONTEND.md) (snapshot) · [`FRONTEND.log.md`](FRONTEND.log.md) (history)
