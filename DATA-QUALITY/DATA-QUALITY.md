# DATA-QUALITY — 재료 검수원

@title: 🧹 DATA-QUALITY — "재료 검수원"
@goal: **pretraining/finetuning corpus 의 품질 (중복·노이즈·선별) 이 downstream 능력에 미치는 효과를 영구 측정·확장하는 lane.** 새 corpus·dedup algo·quality filter·noise model 이 등장할 때마다 측정 frontier 가 다시 열린다. **도착지 없음 · 종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> orchestra-research 20-skill 누락 흡수 (cycle-10) — "Data Processing" 카테고리가 기존 hexa-codex 도메인에 흡수처가 없어 **신규 단독 도메인** 으로 승격. ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** dedup 후 downstream 성능 향상 < 2pp → 중복 무해 (dedup pipeline 불필요). 또는 top-quality 10% 선별이 random 10% 대비 downstream < 1.1× → quality score 무의미.
>
> **Sibling parallel:** POST-TRAINING 은 '학습 후 alignment', DATA-QUALITY 는 '학습 전 재료 품질' — 데이터 lifecycle 의 입구. "data quality > quantity" (FineWeb · DCLM) frontier.

## North-star

같은 모델·같은 토큰 budget 으로, 중복을 제거하고 품질로 선별한 corpus 가 raw corpus 대비 얼마나 더 강한 모델을 만드는가 — 데이터의 양이 아니라 질이 능력을 결정하는가 (data-centric scaling).

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> DATA-QUALITY 은 완료되지 않는다. 새 corpus·dedup algo·quality filter·noise model 이 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — dedup rate (closed-form baseline · orchestra Data Processing 흡수)
- [x] A1 — dedup rate → downstream gain · 5 corpus × {dup_rate_pct, perf_gain_after_dedup_pct}. 반증자: dedup 후 성능 향상 < 2pp → 중복 무해 (dedup 불필요). **CYCLE-10 (2026-05-28) · orchestra Data Processing 흡수:** `DATA-QUALITY/bench/data_quality_a1_dedup_gain.hexa` + `DATA-QUALITY/verify/numerics_data_quality_a1_dedup_gain.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL + 🟡 BY-CITATION. Identity: `gain_after_dedup_x100 = perf_dedup − perf_raw` (× 100 ledger of pp) · falsifier `gain < 2pp` (< 200 in × 100 ledger). Worked example 5 corpora × {dup_rate, perf_raw, perf_dedup}: **common_crawl (65% dup · 60.0→67.5 · gain 7.5pp silent)** · **oscar_web (50% dup · 62.0→68.0 · gain 6.0pp silent)** · **c4_raw (30% dup · 65.0→69.5 · gain 4.5pp silent)** · **fineweb_clean (8% dup · 71.0→72.5 · gain 1.5pp fires)** · **curated_books (3% dup · 73.0→73.8 · gain 0.8pp fires)** — bidirectional 3 silent (high-dup · dedup 유의미) + 2 fires (이미 clean · 중복 무해) + monotone sanity (dup_rate ↑ → gain ↑). Verdict `DATA-QUALITY/verdicts/a1_dedup_gain_verdict.txt`. External anchors: Lee 2022 deduplicating training data (arXiv:2107.06499) · Penedo 2024 FineWeb (arXiv:2406.17557) · Li 2024 DataComp-LM / DCLM (arXiv:2406.11794). **실측 측정 DEFERRED** — cycle-11+ T4 (MinHash dedup 전/후 retrain + downstream eval on lm_foundry + vast.ai pod). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — identity close ≠ measured close. 축 N (quality-classifier 선택 효과) 다음 ⭐ MAIN priority lane.

### 축 B — label noise robustness (measured ladder)
- [ ] B1 — label noise robustness · 10% 노이즈 주입 시 accuracy drop curve fit. 반증자: 10% 노이즈 주입 시 acc drop > 노이즈율 (noise amplification — 노이즈가 비례 이상으로 능력을 깎으면 robustness 부재).

### 축 N — 🆕 NOVEL: quality-classifier 선택 효과 (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — DATA-QUALITY self-NOVEL. "data quality > quantity" (FineWeb · DCLM). 도착지 없음. 외부 anchor: Penedo 2024 FineWeb-Edu · Li 2024 DCLM · Lee 2022 dedup.
- [ ] N1 — FineWeb-Edu style quality score 로 top-10% 선택이 random-10% 대비 downstream 향상. 반증자: top-quality 10% 가 random 10% 대비 downstream < 1.1× → quality score 무의미 (선별 효과 없음 · 양이 곧 질).

## SANDBOX 활용 (measurement substrate)

DATA-QUALITY 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — lm_foundry retrain (mac M3 / ubu-1) / HF transformers eval / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `DATA-QUALITY/verdicts/a1_*` |
| B1 ladder | SANDBOX bench harness | `DATA-QUALITY/verdicts/b1_*` |
| N1 ⭐ NOVEL | lm_foundry retrain / vast.ai pod | `DATA-QUALITY/verdicts/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM data-pipeline wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| dedup-gain estimator · quality-classifier 선별 · noise robustness budget | corpus dedup 결정 · quality-score top-k 선별 · noise-aware 학습 budget | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **DATA-QUALITY 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반. A1 은 현재 placeholder data 의 closed-form identity (🔵 STRUCTURAL + 🟡 BY-CITATION) — 실측 (🟢 SUPPORTED-NUMERICAL) 아님.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: dedup 후 향상 < 2pp → 중복 무해 (dedup 불필요) · top-quality 10% < random 10% × 1.1 → quality score 무의미
> **Anticipated ENGINE behavior wire**: corpus dedup 결정 router · quality-score top-k 선별
>
> ⏸ DEFERRED waiting on cycle-11+ T4 measured fire (MinHash dedup 전/후 retrain + FineWeb-Edu style quality 선별 + downstream eval).

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 흡수 출처 (cycle-10): orchestra-research 20-skill "Data Processing" 누락 흡수
- 기존 sibling 참고 (축 구조 패턴): [`../MULTIMODAL/MULTIMODAL.md`](../MULTIMODAL/MULTIMODAL.md) · [`../LONG-CONTEXT/LONG-CONTEXT.md`](../LONG-CONTEXT/LONG-CONTEXT.md)
- this domain: [`DATA-QUALITY.md`](DATA-QUALITY.md) (snapshot) · [`DATA-QUALITY.log.md`](DATA-QUALITY.log.md) (history)
