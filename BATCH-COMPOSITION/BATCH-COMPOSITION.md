# BATCH-COMPOSITION — 한 박스 안 안섞기

@title: 📦 BATCH-COMPOSITION — "한 박스 안 안섞기"
@goal: **배치 내 길이·난이도 mix 가 throughput·loss 에 미치는 영향을 영구 측정·최적화하는 lane.** 새 model size·task mix·packing 알고리즘 가 등장할 때마다 측정 frontier 가 다시 열린다. **종료 조건 없음 · 진행바 100% 미도달 = 설계** ([[feedback_closure_is_physical_limit]]).

> Candidate sibling from [`AXIS.easy.md`](../AXIS.easy.md) (브레인스토밍 ⭐⭐). ENGINE intake matrix **미등록** — measured finding 확보 시 axis letter 부여하여 승격.
>
> **Falsifier class:** random batch vs sorted batch throughput 차이 > 30%
>
> **Sibling parallel:** DATA-EFFICIENCY 는 'epoch 단위 순서', BATCH-COMP 는 'batch 내부 구성' — 다른 granularity

## North-star

다양한 우편물 한 박스에 마구 넣으면 비효율. 정리하면 분류 속도 ↑. 배치도 비슷.

각 axis 는 `/cycle` 로 SANDBOX 기질 위에서 영구 전진 (`cx_lab_sandbox` · `cx_empirical_contact`).

## 영구 축 (perpetual axes)

> BATCH-COMPOSITION 은 완료되지 않는다. 새 model size·task mix·packing 알고리즘 가 등장할 때마다 축이 다시 열리고 새 cell 추가.

### 축 A — first probe (closed-form baseline)
- [ ] A1 — length-mix variance · throughput · padding waste 측정. 반증자: random batch vs sorted batch throughput 차이 > 30%.

### 축 B — second probe (measured ladder)
- [ ] B1 — difficulty-mix × scale × packing 알고리즘 ladder. 반증자: informed pack 의 loss-curve 개선 < sorted baseline + 2% → packing 효과 marginal.

### 축 N — 🆕 NOVEL: informed-pack vs naive-sort (⭐ MAIN priority lane)
> **⭐ MAIN priority lane** — BATCH-COMPOSITION 의 self-NOVEL axis. 단순 length sort 외에 difficulty/topic 기반 informed packing 의 추가 이득이 있는가. 외부 anchor: Krell 2022 sequence packing · Akyürek 2024 in-context · Yu 2024 dynamic batching.
- [ ] N1 — naive sort vs informed pack (difficulty·topic mix) 의 loss curve 비교. 반증자: informed pack 의 추가 이득 < 1% → informed packing 기법 효과 marginal.

## SANDBOX 활용 (measurement substrate)

BATCH-COMPOSITION 측정은 모두 SANDBOX 기질 위에서 (`cx_lab_sandbox`) — local llama-server (mac M3) / HF transformers (ubu-1) / vast.ai pod (cost-bearing 시).

| 측정 | substrate | output |
|---|---|---|
| A1 first probe | mac M3 / ubu-1 local | `.verdicts/BATCH-COMPOSITION/a1_*` |
| B1 ladder | SANDBOX bench harness | `.verdicts/BATCH-COMPOSITION/b1_*` |
| N1 ⭐ NOVEL | mac M3 / vast.ai pod | `.verdicts/BATCH-COMPOSITION/n1_*` |

## Dispatch surface (ENGINE 후보 wire)

> 본 도메인 finding 이 mature 되면 [`ENGINE`](../ENGINE/ENGINE.md) intake matrix 에 신규 axis letter 로 등록되어 실제 LLM behavior wire 로 변환.

| surface | wired target | wiring path |
|---|---|---|
| online batch composer | online batch 정렬 · sequence packing 정책 · pack-vs-pad trade-off | ENGINE intake matrix 승격 시 axis letter 부여 |

## Honesty invariants

- **BATCH-COMPOSITION 측정 ≠ overhype.** 모든 axis verdict 는 closed-form 또는 measured benchmark 기반.
- **frontier perpetual.** 축의 `[x]` flip 은 한 finding 의 close 이지 frontier 종료 아님 ([[feedback_closure_is_physical_limit]]).
- **자기-strawman 회피.** closed-negative paper 는 외부 published 주장만 반증 ([[feedback_negative_paper_external_claim]]).

## Cross-refs

- 후보 카탈로그: [`../AXIS.easy.md`](../AXIS.easy.md)
- ENGINE intake matrix (driving lane): [`../ENGINE/ENGINE.md`](../ENGINE/ENGINE.md)
- SANDBOX 기질 (measurement substrate): [`../SANDBOX.md`](../SANDBOX.md)
- 영구 frontier 원리: [[feedback_closure_is_physical_limit]]
- 기존 sibling 참고 (축 구조 패턴): [`../ECONOMICS.md`](../ECONOMICS.md) · [`../NEUROEXP/NEUROEXP.md`](../NEUROEXP/NEUROEXP.md)
- this domain: [`BATCH-COMPOSITION.md`](BATCH-COMPOSITION.md) (snapshot) · [`BATCH-COMPOSITION.log.md`](BATCH-COMPOSITION.log.md) (history)
