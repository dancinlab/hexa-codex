# MULTIMODAL — 여러 감각 AI

@title: 🖼️ MULTIMODAL — "여러 감각 AI"
@goal: **text·image·audio·video 균형·교차 능력을 영구 측정하는 lane.** 새 model·modality·benchmark 가 등장할 때마다 측정 frontier 가 다시 열린다. **도착지 없음 · 종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> FRONTIER meta-domain 폐기 (cycle-10 reorg) 시 frontier 축 분산 흡수 — F2 MULTIMODAL 은 흡수처 도메인이 없어 **신규 단독 도메인** 으로 승격. F2 가 본 도메인의 A1 (first probe) 으로 이관됨.
>
> **Falsifier class:** text-baseline 대비 어떤 modality 의 task accuracy 가 30pp 이상 떨어지면 modality balance broken (해당 modality 가 second-class citizen).
>
> **Sibling parallel:** MULTILINGUAL 는 '언어별 능력 갭', MULTIMODAL 는 '감각별 능력 갭' — 별 dimension (× 100 ledger convention 공유).

## North-star

text·image·audio·video 를 한 모델이 동등하게 다루는가, 그리고 한 감각에서 배운 추론이 다른 감각으로 전이되는가 (native multimodal 의 진짜 통합 vs 형식적 결합).

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> MULTIMODAL 은 완료되지 않는다. 새 model·modality·benchmark 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — modality balance (closed-form baseline · FRONTIER F2 이관)
- [x] A1 — modality balance gap @ text-baseline · 감각별 accuracy 갭. 반증자: text-baseline 대비 어떤 modality 의 task accuracy 가 30pp 이상 떨어지면 modality balance broken. **CYCLE-10 reorg (2026-05-28) · FRONTIER/F2 흡수:** `MULTIMODAL/bench/multimodal_a1_modality_balance.hexa` + `MULTIMODAL/verify/numerics_multimodal_a1_modality_balance.hexa` ✅ 7/7 PASS · 🔵 STRUCTURAL + 🟡 BY-CITATION. Identity: `gap_modality_x100 = acc_text − acc_modality` (× 100 ledger of pp) · falsifier `worst_modality_gap ≥ 30pp`. Worked example 3 models × 4 modalities {text/image/audio/video}: **gemma4_31B (85/82/80/78 pp · worst 7pp silent)** · **qwen3.6_72B (87/80/70/68 pp · worst 19pp silent)** · **legacy_vlm_4B (75/70/0/0 pp · worst 75pp fires — audio/video unsupported 2-tower control)**. Verifier: `MULTIMODAL/verify/numerics_multimodal_a1_modality_balance.hexa` · verdict `MULTIMODAL/verdicts/a1_modality_balance_verdict.txt`. External anchors: Yang 2023 GPT-4V · Liu 2023 LLaVA (arXiv:2304.08485) · Driess 2023 PaLM-E (arXiv:2303.03378) · Chu 2024 Qwen-Audio (arXiv:2407.10759) · Google DeepMind 2026 Gemma 4 technical report. **실측 측정 DEFERRED** — cycle-11+ T4 (MMMU · MMBench · AudioBench · Video-MME on local Gemma 4 GGUF + vast.ai pod). **frontier OPEN** ([[feedback_closure_is_physical_limit]]) — identity close ≠ measured close. 축 N (modality-reasoning coupling) 다음 ⭐ MAIN priority lane.

### 축 B — cross-modal transfer (measured ladder)
- [ ] B1 — cross-modal information transfer rate · image→text 정보 전달 효율 fit. 반증자: image→text 정보 transfer rate < within-text × 0.5 → cross-modal 정보 손실 (감각 간 bridge 미작동).

### 축 N — 🆕 NOVEL: modality-reasoning coupling (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — MULTIMODAL 의 self-NOVEL. Gemma 4 / Qwen 3.6 / Llama 4 native multimodal 의 진짜 통합 vs 형식적 결합. 도착지 없음. 외부 anchor: Gemma 4 technical report · Liu 2023 LLaVA · Driess 2023 PaLM-E · Chu 2024 Qwen-Audio.
- [ ] N1 — 한 modality 의 reasoning 이 다른 modality 로 전이되는가 (예: 텍스트로 배운 추론이 이미지 추론에 적용). 반증자: cross-modal reasoning transfer < single-modal × 0.6 → modality silo (감각별 분리).

## SANDBOX 활용 (measurement substrate)

MULTIMODAL 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local Gemma 4 GGUF (mac M3 llama-server) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `.verdicts/MULTIMODAL/a1_*` |
| B1 ladder | SANDBOX bench harness | `.verdicts/MULTIMODAL/b1_*` |
| N1 ⭐ NOVEL | mac M3 / vast.ai pod | `.verdicts/MULTIMODAL/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| modality-balance gap · cross-modal transfer rate · 감각별 router | modality 선택 · per-modality budget allocation · cross-modal routing | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **MULTIMODAL 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반. A1 은 현재 placeholder data 의 closed-form identity (🔵 STRUCTURAL + 🟡 BY-CITATION) — 실측 (🟢 SUPPORTED-NUMERICAL) 아님.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## ENGINE intake (wire stub)

> 🟠 deferred — A1 현재 🔵 STRUCTURAL + 🟡 BY-CITATION (closed-form identity + 외부 citation). measured tier (🟢 SUPPORTED-NUMERICAL) 도달 시 ENGINE intake matrix 승격 검토. axis letter 는 그 시점에 부여 (지금 예약 금지).
>
> **Falsifier class for ENGINE wire**: text-baseline 대비 modality accuracy 30pp 이상 drop → modality second-class citizen
> **Anticipated ENGINE behavior wire**: per-modality budget allocation · cross-modal routing
>
> ⏸ DEFERRED waiting on cycle-11+ T4 measured fire (MMMU · MMBench · AudioBench · Video-MME).

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 흡수 출처 (cycle-10 reorg): `FRONTIER/F2` (multimodal balance)
- 기존 sibling 참고 (축 구조 패턴): [`../MULTILINGUAL/MULTILINGUAL.md`](../MULTILINGUAL/MULTILINGUAL.md) · [`../LONG-CONTEXT/LONG-CONTEXT.md`](../LONG-CONTEXT/LONG-CONTEXT.md)
- CODEX governance: [`../CODEX/CODEX.md`](../CODEX/CODEX.md)
- this domain: [`MULTIMODAL.md`](MULTIMODAL.md) (snapshot) · [`MULTIMODAL.log.md`](MULTIMODAL.log.md) (history)
