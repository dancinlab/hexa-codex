# ARCHITECTURE — 설계도 검사관

@title: 🏗️ ARCHITECTURE — "설계도 검사관"
@goal: **transformer 설계 요소 (attention impl · normalization · activation · positional encoding) 의 효율·안정성·요소 간 결합을 영구 측정하는 lane.** 새 attention impl·norm·activation·position encoding 이 등장할 때마다 측정 frontier 가 다시 열린다. **도착지 없음 · 종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> orchestra-research 20-skill 카탈로그의 "Model Architecture" lane 이 hexa-codex 도메인 목록에 **미등록** 이었음 (cycle-10 흡수 누락 감사). 흡수처 sibling 이 없어 **신규 단독 도메인** 으로 승격. 설계 선택의 quality-per-FLOP · 수렴 안정성 · 요소 결합을 측정.
>
> **Falsifier class:** 새 attention impl 의 quality-per-FLOP 이 baseline MHA (1.0) 미만 → 설계 이득 없음 (FLOP 만 늘고 quality 안 오르는 변형).
>
> **Sibling parallel:** LONG-CONTEXT 는 'attention 의 위치별 능력 감쇠', ARCHITECTURE 는 'attention/norm/activation 설계 자체의 효율·안정성' — 별 dimension (× 100 ledger convention 공유).

## North-star

같은 quality 를 더 적은 FLOP 으로 (또는 같은 FLOP 으로 더 높은 quality 를) 내는 설계가 진짜 이득인가, 그리고 설계 요소 (activation · positional) 들이 서로 독립인가 entangle 돼 있는가 ("설계도 검사관" 의 진위 판정).

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> ARCHITECTURE 는 완료되지 않는다. 새 attention impl·norm·activation·position encoding 이 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — attention 효율 (quality-per-FLOP · closed-form baseline)
- [x] A1 — attention 효율 (quality-per-FLOP) @ baseline MHA · 5 attention 변형 × {quality, flops}. 반증자: 새 attention impl 의 quality-per-FLOP < baseline (1.0) → 설계 이득 없음. **CYCLE-10 신규 도메인 first probe (2026-05-28) · orchestra Model Architecture 흡수:** `ARCHITECTURE/bench/architecture_a1_attention_efficiency.hexa` + `ARCHITECTURE/verify/numerics_architecture_a1_attention_efficiency.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL + 🟡 BY-CITATION. Identity: `efficiency_x100 = quality × 100 / flops` (baseline MHA 대비 · = `(quality_v × flops_mha × 100)/(quality_mha × flops_v)`) · falsifier `efficiency < 1.0` (< 100 in × 100 ledger). Worked example 5 attention 변형 × {quality_x100, flops_x100}: **mha (q80/f100% · 1.00× baseline silent)** · **flash_attn (q80/f60% · 1.66× silent)** · **gqa (q79/f70% · 1.41× silent)** · **mla (q81/f55% · 1.84× silent)** · **naive_variant (q78/f130% · 0.75× FIRES — FLOP 늘고 quality 안 오르는 control)** — bidirectional 4 silent (이득) + 1 fires (이득 없음). Verifier: `ARCHITECTURE/verify/numerics_architecture_a1_attention_efficiency.hexa` · verdict `ARCHITECTURE/verdicts/a1_attention_efficiency_verdict.txt`. External anchors: Vaswani 2017 attention (arXiv:1706.03762) · Dao 2022 FlashAttention (arXiv:2205.14135) · Ainslie 2023 GQA (arXiv:2305.13245) · DeepSeek 2024 MLA (arXiv:2405.04434). **실측 측정 DEFERRED** — cycle-11+ T4 (attention FLOP profiling + downstream quality on mac M3 llama-server + vast.ai pod). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — identity close ≠ measured close. 축 N (activation/positional design coupling) 다음 ⭐ MAIN priority lane.

### 축 B — normalization 선택 (measured ladder)
- [ ] B1 — normalization 선택 안정성: RMSNorm vs LayerNorm vs no-norm 수렴 비교. 반증자: no-norm 이 norm 대비 수렴 < 0.5× → normalization 필수 (no-norm 학습 불안정 / 발산).

### 축 N — 🆕 NOVEL: activation/positional design coupling (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — ARCHITECTURE self-NOVEL. 설계 요소 간 entanglement. 도착지 없음. activation (SwiGLU/GELU) 과 positional (RoPE/ALiBi) 선택이 독립인지 상호작용하는지 분리 측정. 외부 anchor: Shazeer 2020 GLU variants (SwiGLU · arXiv:2002.05202) · Su 2021 RoPE (arXiv:2104.09864) · Press 2021 ALiBi (arXiv:2108.12409).
- [ ] N1 — activation (SwiGLU/GELU) × positional (RoPE/ALiBi) cross-product 상호작용 fit. 반증자: 두 설계 선택이 independent 라고 가정한 monovariate fit error > 10% → activation 과 positional 이 entangle (요소 결합).

## SANDBOX 활용 (measurement substrate)

ARCHITECTURE 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `ARCHITECTURE/verdicts/a1_attention_efficiency_verdict.txt` |
| B1 ladder | SANDBOX bench harness | `.verdicts/ARCHITECTURE/b1_*` |
| N1 ⭐ NOVEL | mac M3 / vast.ai pod | `.verdicts/ARCHITECTURE/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| attention quality-per-FLOP · norm 선택 · activation/positional coupling | attention impl 선택 · norm placement · architecture search 가이드 | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **ARCHITECTURE 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반. A1 은 현재 placeholder data 의 closed-form identity (🔵 STRUCTURAL + 🟡 BY-CITATION) — 실측 (🟢 SUPPORTED-NUMERICAL) 아님.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: 새 attention impl 의 quality-per-FLOP < baseline (1.0) → 설계 이득 없음
> **Anticipated ENGINE behavior wire**: attention impl 선택 router · norm placement · architecture-search 가이드
>
> ⏸ DEFERRED waiting on cycle-11+ T4 measured fire (attention FLOP profiling + downstream quality).

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 흡수 출처 (cycle-10): orchestra-research 20-skill "Model Architecture" lane (도메인 미등록 흡수)
- 기존 sibling 참고 (축 구조 패턴): [`../LONG-CONTEXT/LONG-CONTEXT.md`](../LONG-CONTEXT/LONG-CONTEXT.md) · [`../MULTIMODAL/MULTIMODAL.md`](../MULTIMODAL/MULTIMODAL.md)
- CODEX governance: [`../CODEX/CODEX.md`](../CODEX/CODEX.md)
- this domain: [`ARCHITECTURE.md`](ARCHITECTURE.md) (snapshot) · [`ARCHITECTURE.log.md`](ARCHITECTURE.log.md) (history)
