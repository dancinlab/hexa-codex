# MULTILINGUAL — 여러 언어 실력 갭

@title: 🌐 MULTILINGUAL — "여러 언어 실력 갭"
@goal: **언어별 성능 갭 + tokenizer 효율을 영구 측정·균형화하는 lane.** 새 언어·script·domain 가 등장할 때마다 측정 frontier 가 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Candidate sibling from [`AXIS.easy.md`](../AXIS.easy.md) (브레인스토밍 ⭐⭐⭐). ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** low-resource language 성능 < 영어 50% OR tokenizer 효율 2배 이상 나쁨
>
> **Sibling parallel:** SUBSTRATE 는 보통 영어로 측정, MULTILINGUAL 은 '언어 간 일반화' — 직각

## North-star

영어 vs 한국어 vs 스와힐리어 등 성능 갭과 토크나이저 효율. 글자수 차이가 비용 차이로 직결.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> MULTILINGUAL 은 완료되지 않는다. 새 언어·script·domain 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — first probe (closed-form baseline)
- [x] A1 — per-language perplexity · bytes/token 효율 · accuracy gap vs 영어 baseline. 반증자: low-resource language 성능 < 영어 50% OR tokenizer 효율 2배 이상 나쁨. **CYCLE-9 round-2 first probe (2026-05-28):** `MULTILINGUAL/bench/multilingual_a1_perplexity_gap.hexa` + `MULTILINGUAL/verify/numerics_multilingual_a1_perplexity_gap.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL (PPL ratio + bytes/tok identity) + 🟡 BY-CITATION (low-resource threshold convention). Identity: `ppl_gap = PPL_lang / PPL_en × 1000` · `bytes_gap = bytes/tok_lang / bytes/tok_en × 100` · `low_resource_flag = (ppl_gap > 2.0) AND (bytes_gap > 2.0)` (compound AND semantics). Worked example 4 langs (en baseline · ko mid · sw low-resource · ja mid): en→1000/100 (baseline) · ko→2133/189 (ppl 위, bytes 아래 → AND False) · sw→5600/310 (둘 다 위 → 정확 발화) · ja→1400/121 (둘 다 아래 → 정확 silent). bidirectional discrimination 성립 (sw fires · ja silent · ko AND-trap). External anchors: Pires 2019 mBERT (arXiv:1906.01502) · Conneau 2020 XLM-R (arXiv:1911.02116) · Wu 2024 transfer asymmetry. **실측 PPL/tokenizer 측정 DEFERRED** — cycle-10+ T4 (mac M3 llama-server / ubu-1 HF · MMLU multilingual · per-model fixture). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — formula close ≠ measured close · 새 언어·script·domain 등장 시 axis 재오픈. 축 N1⭐ (tokenizer efficiency · bytes/token 불평등) = MAIN priority lane (cycle-10 reorg · A1 의 입력단). 축 N2 (cross-lingual transfer asymmetry · L1→L2 vs L2→L1) = 후속 measured-tier.

### 축 B — second probe (measured ladder)
- [ ] B1 — language family × task class × model scale ladder cross-product. 반증자: non-Indo-European 언어가 Indo-European 보다 정확도 평균 20pp 이상 낮음.

### 축 N — 🆕 NOVEL: tokenizer efficiency (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — MULTILINGUAL self-NOVEL. A1 (perplexity gap) 의 입력단 — tokenizer 가 언어별로 공평한가. Ahia 2023 · Petrov 2023 anchor. 도착지 없음 ([[feedback_closure_is_physical_limit]]).
- [x] N1 — tokenizer 효율: per-lang bytes/token · low-resource 비용 불평등. 반증자: low-resource lang efficiency < 영어 × 0.5 → token 2배 소모. **CYCLE-10 reorg (2026-05-28 · train/infer/serve stack)** ✅ 🔵+🟡 · 7/7 PASS · `MULTILINGUAL/bench/multilingual_n1_tokenizer_efficiency.hexa` + `MULTILINGUAL/verify/numerics_multilingual_n1_tokenizer_efficiency.hexa` + `MULTILINGUAL/verdicts/n1_tokenizer_efficiency_verdict.txt` · hindi/burmese fires · english/spanish/chinese silent. Identity: `efficiency_ratio_x100(lang) = bytes_per_token_x100[lang] × 100 / bytes_per_token_x100[english]` · 반증자 `efficiency_ratio < 50`. 6 언어 ledger (english 420 baseline=100 · spanish 380=90 · chinese 250=59 · korean 200=47 · hindi 150=35 fires · burmese 90=21 fires). External anchors: Sennrich 2016 BPE (arXiv:1508.07909) · Kudo 2018 SentencePiece (arXiv:1808.06226) · tiktoken · Gemma 4 tokenizer (256k vocab) · Ahia 2023 (arXiv:2305.13707) · Petrov 2023 (arXiv:2305.15425). **실측 tokenizer fertility DEFERRED** — cycle-10+ T4 (Gemma 4 / Qwen tokenizer · FLORES-200 parallel corpus · per-tokenizer bytes/token). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — formula close ≠ measured close · 새 언어·script·tokenizer 등장 시 axis 재오픈.
- [ ] N2 — cross-lingual transfer asymmetry: L1→L2 vs L2→L1 task transfer accuracy delta 측정. 반증자: asymmetry > 15pp on multiple language pairs → dominant language bias. 외부 anchor: Pires 2019 cross-lingual transfer · Wu 2024 transfer asymmetry · Conneau 2020 XLM-R. **demoted N1→N2 (cycle-10 reorg · tokenizer-efficiency took ⭐ MAIN N1 slot)** — measured-tier 필요.

## SANDBOX 활용 (measurement substrate)

MULTILINGUAL 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `.verdicts/MULTILINGUAL/a1_*` |
| B1 ladder | SANDBOX bench harness | `.verdicts/MULTILINGUAL/b1_*` |
| N1 ⭐ NOVEL (tokenizer efficiency) | mac M3 / vast.ai pod | `MULTILINGUAL/verdicts/n1_tokenizer_efficiency_verdict.txt` |
| N2 (transfer asymmetry) | mac M3 / vast.ai pod | `.verdicts/MULTILINGUAL/n2_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| language-pair-aware fine-tune | tokenizer 학습 데이터 비율 · 언어별 모델 선택 · 균형 다국어 RLHF | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **MULTILINGUAL 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter (H, I, J, ...) 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: low-resource language 성능 < 영어 50% OR tokenizer 효율 2배 이상 나쁨
> **Anticipated ENGINE behavior wire**: per-language tokenizer pick · low-resource fallback routing
> **Status path**: [`../CALIBRATION/CALIBRATION.md`](../CALIBRATION/CALIBRATION.md) ← reference 패턴 (cycle-10 round-1 promoted to ENGINE axis G).

> ⏸ DEFERRED waiting on cycle-10+ T4 measured fire.

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../ECONOMICS.md`](../ECONOMICS.md) · [`../NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md)
- this domain: [`MULTILINGUAL.md`](MULTILINGUAL.md) (snapshot) · [`MULTILINGUAL.log.md`](MULTILINGUAL.log.md) (history)
