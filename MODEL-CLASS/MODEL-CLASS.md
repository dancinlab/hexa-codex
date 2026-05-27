# MODEL-CLASS — 모델 분류학자

@title: 🗂️ MODEL-CLASS — "모델 분류학자"
@goal: **LLM 의 macro 품종 (architecture family · specialization type · scale-class) 을 영구 측정·분류하는 lane.** 2026 frontier 에 새 architecture family (Mamba · Jamba · RWKV · diffusion-LM …) 가 등장하거나, 새 specialization (reasoning · code …) · 새 scale-class 가 나올 때마다 측정 frontier 가 다시 열린다. **도착지 없음 · 종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> "LLM 종류" 측정이 빈칸이었음. 모델 종류 관련 축이 흩어져 있음 (ENERGY/N1 dense-vs-MoE · ARCHITECTURE micro 구조 · MULTIMODAL modality · HALLUCINATION reasoning). 통합 "모델 분류학" 도메인 부재. 2026 frontier 에 비-transformer family (Mamba · Jamba · RWKV · diffusion-LM) 등장 → architecture family 측정 가치 발생. **신규 단독 도메인** 으로 승격.
>
> **Falsifier class:** non-transformer architecture family 가 같은 param tier 에서 decoder-only transformer baseline 대비 < 90% quality → architecture diversity 무의미 (decoder-only 만이 답).

## ARCHITECTURE 와의 구분 (micro vs macro)

| 도메인 | 측정 단위 | 대상 |
|---|---|---|
| [`ARCHITECTURE`](../ARCHITECTURE/ARCHITECTURE.md) | **micro 부품** | attention impl · normalization · activation · positional encoding (같은 transformer 안의 설계 부품) |
| **MODEL-CLASS** (this) | **macro 품종** | architecture-family · specialization-type · scale-class (모델 품종 자체) |

같은 transformer 내부의 attention 변형 (MHA → FlashAttention → MLA) 은 ARCHITECTURE A1. transformer-vs-Mamba 처럼 **품종 자체를 가르는 것** 은 MODEL-CLASS A1. 둘은 별 dimension (× 100 ledger convention 공유). MODEL-CLASS 는 "이 모델이 어떤 종(種)인가" 의 분류학, ARCHITECTURE 는 "그 종의 장기(臟器) 가 어떻게 생겼나" 의 해부학.

## North-star

architecture diversity (비-transformer family) 가 같은 param tier 에서 진짜 경쟁력이 있는가, specialization (base/instruct/reasoning/code) 이 task-fit 이득인가 over-specialization 인가, scale-class 별로 emergent 능력이 진짜 step-change 인가 smooth scaling 의 환상인가 ("모델 분류학자" 의 진위 판정).

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> MODEL-CLASS 는 완료되지 않는다. 새 architecture family · 새 specialization · 새 scale-class 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — architecture family scaling (quality ratio · closed-form baseline)
- [x] A1 — architecture family scaling: 5 family × {param_b, quality} (같은 param tier · decoder-only transformer = 100% baseline). 반증자: non-transformer family 가 transformer 대비 < 90% (900) → architecture diversity 무의미 (decoder-only 만이 답). **CYCLE-10 신규 도메인 first probe (2026-05-28):** `MODEL-CLASS/bench/model_class_a1_arch_family.hexa` + `MODEL-CLASS/verify/numerics_model_class_a1_arch_family.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL + 🟡 BY-CITATION. Identity: `family_ratio_x100 = quality[family] × 100 / quality[decoder_baseline]` (decoder-only transformer = 100 baseline) · falsifier `family_ratio < 90` (< 90% of decoder baseline). Worked example 5 family @ same 7B tier × {param_b, quality_x100}: **decoder_transformer (7B·q100 · 100% baseline silent)** · **mamba_ssm (7B·q96 · 96% silent)** · **jamba_hybrid (7B·q98 · 98% silent)** · **rwkv (7B·q92 · 92% silent)** · **early_diffusion_lm (7B·q78 · 78% FIRES — 아직 못 따라잡은 control)** — bidirectional 4 silent (경쟁력 있음) + 1 fires (아직 못 따라잡음). Verifier: `MODEL-CLASS/verify/numerics_model_class_a1_arch_family.hexa` · verdict `MODEL-CLASS/verdicts/a1_arch_family_verdict.txt`. External anchors: Vaswani 2017 decoder transformer (arXiv:1706.03762) · Gu 2023 Mamba SSM (arXiv:2312.00752) · Lieber 2024 Jamba hybrid (arXiv:2403.19887) · Peng 2023 RWKV (arXiv:2305.13048) · Li 2022 Diffusion-LM (arXiv:2205.14217). **실측 측정 DEFERRED** — cycle-11+ T4 (same-tier downstream quality on mac M3 llama-server + vast.ai pod). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — identity close ≠ measured close. 축 N (scale-class emergent 능력) 다음 ⭐ MAIN priority lane.

### 축 B — specialization type (task-fit · measured ladder)
- [ ] B1 — specialization type task-fit: base / instruct / reasoning / code 의 task-fit 분류. 반증자: code-specialized 모델이 일반 task 에서 base 대비 < 0.8× → over-specialization (특화가 일반 능력을 깎음).

### 축 N — 🆕 NOVEL: scale-class emergent 능력 (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — MODEL-CLASS self-NOVEL. nano/small/medium/large/frontier scale-class 별 emergent 능력 출현. 작은 모델에 없던 능력이 큰 모델에 갑자기 나타나는가 (emergent · Wei 2022), 아니면 매끄러운 scaling 의 측정 환상인가 (Schaeffer 2023 mirage 반론). 도착지 없음.
- [ ] N1 — scale-class emergent 능력: nano/small/medium/large/frontier scale-class 별 특정 능력의 step-change 측정. 반증자: scale 10× 증가 시 특정 능력 step-change < 2× → smooth scaling (emergence 환상 · Schaeffer 2023 mirage). 외부 anchor: Wei 2022 emergent abilities (arXiv:2206.07682) · Schaeffer 2023 emergent abilities a mirage? (arXiv:2304.15004).

## SANDBOX 활용 (measurement substrate)

MODEL-CLASS 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `MODEL-CLASS/verdicts/a1_arch_family_verdict.txt` |
| B1 ladder | SANDBOX bench harness | `.verdicts/MODEL-CLASS/b1_*` |
| N1 ⭐ NOVEL | mac M3 / vast.ai pod | `.verdicts/MODEL-CLASS/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| architecture-family 경쟁력 · specialization task-fit · scale-class emergence | family/specialization 선택 router · scale-class capability 예측 | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **MODEL-CLASS 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반. A1 은 현재 placeholder data 의 closed-form identity (🔵 STRUCTURAL + 🟡 BY-CITATION) — 실측 (🟢 SUPPORTED-NUMERICAL) 아님.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: non-transformer family 가 같은 param tier 에서 decoder-only baseline 대비 < 90% quality → architecture diversity 무의미
> **Anticipated ENGINE behavior wire**: architecture-family 선택 router · specialization task-fit 가이드 · scale-class capability 예측
>
> ⏸ DEFERRED waiting on cycle-11+ T4 measured fire (same-tier downstream quality profiling).

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 인접 sibling — micro 부품 측정 (micro-vs-macro 구분): [`../ARCHITECTURE/ARCHITECTURE.md`](../ARCHITECTURE/ARCHITECTURE.md)
- 인접 sibling — modality 품종: [`../MULTIMODAL/MULTIMODAL.md`](../MULTIMODAL/MULTIMODAL.md)
- 인접 sibling — 위치별 능력 (축 구조 패턴): [`../LONG-CONTEXT/LONG-CONTEXT.md`](../LONG-CONTEXT/LONG-CONTEXT.md)
- 흩어진 모델-종류 축 (통합 출처): ENERGY/N1 dense-vs-MoE · MULTIMODAL modality · HALLUCINATION reasoning
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- CODEX governance: [`../CODEX/CODEX.md`](../CODEX/CODEX.md)
- this domain: [`MODEL-CLASS.md`](MODEL-CLASS.md) (snapshot) · [`MODEL-CLASS.log.md`](MODEL-CLASS.log.md) (history)
