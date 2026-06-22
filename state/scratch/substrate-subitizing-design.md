# SUBSTRATE — VLM subitizing-ceiling 설계 노트 (family-confound vs universal scale-law)

> Scratch design artifact (docs scratchDir = `state/scratch/`). NOT an ARCHITECTURE.json node (governance c4).
> 모델 실행 없음 — 기존 verdict 재해석 + 다음 falsifier 프로브 설계만. 모델 ID·수식은 영문.
> 작성: 2026-06-22 · 대상 lane: SUBSTRATE `vlm-subitizing-ceiling` (N⭐ MAIN, cycle-28).

---

## 1. 현재 상태 (정확 인용)

### 1.1 lane 정의 (`state/scratch/frontier-gap.json` → novel-lanes → `vlm-subitizing-ceiling`, RANK 2)

> "Multimodal capability ladder is NON-MONOTONE: perception sub-axis monotone-saturating, but the
> COUNTING axis (5-9 dense objects) breaks the scaling trend — an architectural subitizing ceiling.
> SmolVLM-500M 81.25% → SmolVLM2-2.2B 93.75% → Qwen2.5-VL-3B 81.25%."
>
> FALSIFIER: "if a 7B+ VL rung recovers counting to monotone (perception 11/11 AND counting
> trend-consistent) AND the dip does not replicate across non-Qwen families, the subitizing-ceiling
> claim is refuted (it was a single-family artifact)."

### 1.2 ARCHITECTURE.json (line 480-517) — 현재 status

- 노드: `v1.4.0 SANDBOX result — multimodal ladder (non-monotone)`, status `v1.4.0 — multimodal ladder (non-monotone honest-negative)`.
- 영구 축 A: "4th+ VL rung 7B+ (perception 11/11 + counting recovery?)" — **이미 LANDED** (아래 1.4).
- 영구 축 N⭐ MAIN (cycle-28): **"is Qwen-VL-3B counting=2/5 dip a Qwen anomaly or scale-law dip?
  gate for all capability claims; cycle-28 first-probe SmolVLM-family vs Qwen-VL-family per-family
  slope split, cycle-29+ InternVL-7B/LLaVA-NeXT-7B rung."**

### 1.3 cycle-20 3-rung verdict (`.verdicts/sandbox/m5_substrate_multimodal_fit.txt`, 🟢 SUPPORTED-NUMERICAL, 4/4 PASS)

| rung | params | overall | count | ocr | spatial | shape |
|------|--------|---------|-------|-----|---------|-------|
| 0 SmolVLM-500M-Instruct-Q8_0 | 0.5B | 13/16 = 81.25% | 4/5 | 4/4 | 3/4 | 2/3 |
| 1 SmolVLM2-2.2B-Instruct-Q8_0 | 2.2B | 15/16 = 93.75% | 4/5 | 4/4 | 4/4 | 3/3 |
| 2 Qwen2.5-VL-3B-Instruct-Q4_K_M | 3.0B | 13/16 = 81.25% | **2/5** | 4/4 | 4/4 | 3/3 |

- `monotone_nondecreasing = FALSE` (rise +12.5pp → fall −12.5pp).
- PERCEPTION sub-ladder (ocr+spatial+shape, 11 items): 9/11 → 11/11 → 11/11 (monotone→saturate).
- COUNTING axis (5-9 dense, 5 items): 4/5 → 4/5 → **2/5** (params 무관, subitizing-limit).
- 단일 logistic in log2(params)는 WRONG FAMILY: best monotone-logistic RMSE = 0.0560 (구조적 misfit).
- **양자화 아티팩트 배제됨**: 별도 Q8_0 Qwen-VL-3B 프로브가 Q4_K_M와 동일하게 undercount
  (5,6,6,7,8 vs gold 5,6,7,8,9) → 3B rung이 진짜로 undercount.

### 1.4 cycle-23c 4-rung extension (`.verdicts/sandbox/m5_substrate_multimodal_fit_4rung.txt`, 🟢 6/6 PASS)

| rung | params | overall | count |
|------|--------|---------|-------|
| 3 Qwen2.5-VL-7B-Instruct-Q4_K_M | 7.0B | 16/16 = 100% | **5/5** |

- perception: 9/11 → 11/11 → 11/11 → 11/11 (saturate 유지).
- counting **V-SHAPE**: 4/5 → 4/5 → **2/5** → **5/5** (3B dip 실재 + 7B 완전 회복).
- overall 여전히 NON-MONOTONE (3B dip가 7B 회복에도 살아남음); quadratic-in-log2(params)
  RMSE 0.0545 < monotone-logistic 0.0568 (dip-then-recover를 admit하는 더 나은 family).

### 1.5 무엇이 OPEN인가 (4-rung verdict의 명시 잔여 + N⭐ gate)

> verdict 인용: "a single 7B rung cannot DISCRIMINATE [subitizing-emerges-at-scale] from
> 'Qwen2.5-VL-7B specifically subitizes well, regardless of params'. A 5th rung at a non-Qwen-7B
> (e.g. an InternVL-7B or LLaVA-NeXT-7B with a loading mmproj on llama.cpp) would discriminate the
> family-effect from the scale-effect."

> OPEN 잔여: "5th rung at a non-Qwen-7B to discriminate family-effect from scale-effect on the
> counting axis recovery (the 3B dip + 7B recovery within the Qwen family is consistent with EITHER
> a Qwen-specific 3B regression OR a generic subitizing-emerges-at-scale story; a single point can't
> decide)."

**핵심 confound (현재 데이터의 한계)**: 3B dip(2/5)도 7B 회복(5/5)도 **둘 다 Qwen 패밀리 안에서만**
관측됨. SmolVLM 라인(0.5B, 2.2B)은 dip을 보이지 않지만 두 점 모두 ≤2.2B여서 7B 매칭 스케일 비교가
부재. 즉 N⭐ gate가 아직 열려 있다 — family-vs-scale를 분리하는 matched-scale 데이터가 없음.

---

## 2. 과학 — subitizing 문헌 → VLM 매핑 (두 경쟁 가설)

### 2.1 인간 subitizing 문헌

- **Subitizing range ~1-4**: 1-4개 객체는 즉각·정확·거의-일정 RT로 병렬 보고 (slope ≈ 40-100 ms/item, 매우 평탄).
- **Counting >4는 serial/slow**: 5개 이상은 직렬 주의-이동 카운팅, RT가 항목당 ~250-350 ms로 가파르게 증가, 오류율 상승.
- 근거: **Kaufman et al. 1949** ("subitizing" 용어 도입; 1-5 vs 6+ RT 불연속), **Trick & Pylyshyn 1994**
  (subitizing = 전주의적 FINST 개별화 ≤4, counting = 주의적 직렬 enumeration >4 — 두 메커니즘의 아키텍처적 분리).
- 핵심 주장: subitizing 한계는 학습량이 아니라 **표상 용량(개별화 슬롯 ~4)의 아키텍처적 상한**.

### 2.2 VLM finding에의 매핑

본 manifest는 5-9 dense objects만 테스트 → **전부 counting range (>4)**, subitizing range(1-4)는 미측정.
관측된 break(3B 2/5)는 "counting range에서의 깨짐"이며, 인간의 subitizing **ceiling 자체**(≤4 평탄 →
>4 붕괴의 전이점)는 아직 직접 관측되지 않았다. 즉 현재 라벨 "subitizing ceiling"은 **counting-range
degradation**을 가리키며, 진짜 subitizing 전이(4→5 cliff)는 1-4 vs 5-9 대조 grid가 있어야 검증 가능.

### 2.3 두 경쟁 가설 (in-hand 데이터로 구분)

- **H1 — ARCHITECTURE (subitizing-style ceiling)**: counting >4는 VL 아키텍처(고정 vision-token budget /
  단일-패스 perceptual 병렬성)의 **표상적 상한**. 예측: dense-counting 붕괴는 **family-orthogonal** —
  matched scale의 ≥2 비-Qwen 패밀리에서도 5-9 구간에서 dip이 **재현**되고, 1-4(subitizing range)는 평탄.
- **H2 — TRAINING ARTIFACT (per-family/per-rung)**: 3B dip은 Qwen2.5-VL-3B의 특정 데이터-믹스·체크포인트
  회귀. 예측: dip은 **단일-패밀리 국소** — 비-Qwen 패밀리는 3B급에서 dip이 **없고**, 7B 회복은 Qwen 고유.

**현재 in-hand 데이터의 판정**: 부분적으로 H2 쪽으로 기운다.
- counting이 V-shape(3B dip → 7B 회복)인 점은 **순수 H1(고정 아키텍처 상한)과 불일치** — 상한이면
  7B에서도 5-9가 안 풀려야 함. 회복은 "용량이 스케일로 emergent"임을 시사.
- 그러나 회복·dip 둘 다 **Qwen 단일 패밀리 내부** 관측 → H1(스케일로 풀리는 soft ceiling)과
  H2(Qwen-3B 국소 회귀) **모두와 호환**. 단일 패밀리로는 분리 불가 → **N⭐ gate 미해결**.
- SmolVLM 라인은 dip 없음(4/5, 4/5)이나 ≤2.2B라 matched-scale 대조 부재.
→ 결론: 데이터는 "순수 hard architectural ceiling"은 이미 약화(7B 회복)시켰지만,
  "soft scale-emergent subitizing capacity (H1')" vs "Qwen-3B artifact (H2)"는 **미결**.
  이 둘을 가르는 것이 본 falsifier의 임무.

---

## 3. Falsifier 설계 — FAMILY-confound vs UNIVERSAL scale-law

### 3.1 Gate 문장 (정확)

> N⭐ MAIN gate: "is the Qwen-VL-3B counting=2/5 dip a Qwen anomaly or a scale-law dip?" — gate for
> ALL capability claims.

이는 **2-요인 분리** 문제다: (factor A) FAMILY, (factor B) SCALE. 현재 데이터는 A와 B가 교락(confounded).
요구되는 설계는 **matched-scale cross-family** 셀로 A를 B와 직교화하는 것.

### 3.2 프로브할 모델 패밀리 (≥2 비-Qwen + Qwen 대조; matched scale)

`llama.cpp llama-mtmd-cli` (model + mmproj, CLIP on MTL0 Metal/UMA, 24GB) 로딩 가능 GGUF 우선.

| family | ~3B rung (dip 검증) | ~7B rung (회복 검증) |
|--------|--------------------|--------------------|
| Qwen-VL (대조, in-hand) | Qwen2.5-VL-3B-Instruct-Q4_K_M ✅ | Qwen2.5-VL-7B-Instruct-Q4_K_M ✅ |
| InternVL (비-Qwen #1) | InternVL2.5-2B / InternVL3-2B | InternVL2.5-8B / InternVL3-8B |
| LLaVA-NeXT (비-Qwen #2) | (≈3B 부재 시 7B만) | LLaVA-NeXT-7B (llava-v1.6-vicuna/mistral-7b) |
| SmolVLM (비-Qwen #3, in-hand 하단) | SmolVLM2-2.2B-Instruct-Q8_0 ✅ | (7B 부재 — 하단 앵커로만) |

- **최소 충족**: 비-Qwen 패밀리 **≥2** (InternVL + LLaVA-NeXT). SmolVLM은 보조 하단 앵커.
- 각 패밀리는 가능하면 **3B급 + 7B급 두 rung** 확보 → 패밀리 내부 slope(dip→recover) 측정.
  로딩 실패(mmproj 미로드)는 INBOX-register하고 가용 대체 rung으로 진행 (cycle-20 SmolVLM 선례).
- 양자화는 in-hand 선례대로 Q4_K_M/Q8_0 혼용 허용 (Q8_0 Qwen-VL-3B 프로브가 dip을 양자화로
  설명할 수 없음을 이미 입증).

### 3.3 Counting task grid (subitizing range 분리)

현재 manifest는 5-9만 → **subitizing 전이점(4→5)을 못 본다.** 다음 3-구간 grid로 확장:

- **SUBITIZING range (1-4)**: counts {1,2,3,4} — 인간 평탄 구간. **모든 rung·패밀리에서 ~100% 기대**
  (안 그러면 perception 결함이지 subitizing 현상 아님 — sanity floor).
- **COUNTING range (5-9)**: counts {5,6,7,8,9} — in-hand 5-item, dip이 관측된 구간. **주 신호.**
- **DENSE range (10+)**: counts {10,12,15} — 모든 rung 붕괴 기대 (보편 상한 — H1/H2 무관 확인).

각 count는 seed-pinned PIL로 ≥3 layout(grid 위치·반경 변이)로 복제 → 5-9 구간 통계력 확보
(현재 count당 1샘플 → count당 ≥3샘플로). scorer = `byte_exact_subset` 유지 (NO LLM self-judge).
decode = greedy `--temp 0 -s 42 -n 24` 유지 (byte-exact replay).

### 3.4 Per-axis logistic decomposition (perception vs counting 분리 fit)

overall 단일 fit은 이미 WRONG FAMILY로 판정됨 → **축별 독립 fit**:

- **Perception fit**: y_perc(x) = L_lo + (L_hi−L_lo)/(1+exp(−k·(x−x0))), x = log2(params_B).
  monotone-saturating 기대 (in-hand: 9/11→11/11→11/11). 잘 맞으면 perception은 보편 스케일 법칙.
- **Counting fit (구간별)**: subitizing(1-4)·counting(5-9)·dense(10+) **각각** 별도 곡선.
  - 5-9 구간을 **패밀리별** 별도 fit → per-family slope/dip 위치 비교.
  - 핵심 통계: 각 패밀리에 대해 `dip_depth = max(0, acc(2-3B-rung) − min over rung-below-7B)` 와
    `recovery = acc(7B) − acc(3B)` 를 산출.
- **모델**: per-family counting을 logistic(가능 시) 또는 V-shape(quadratic-in-log2, in-hand 선례)로
  fit하고, **family를 dummy로 둔 pooled fit vs per-family slope** 의 RMSE를 비교
  (family 교호작용이 유의하면 H2, family-orthogonal이면 H1').

### 3.5 정확한 PASS/FAIL 규칙

- **CEILING CONFIRMED (H1' — universal scale-emergent subitizing)**:
  matched scale(≈3B)에서 counting(5-9) dip이 **≥2 비-Qwen 패밀리**에서 **재현**되고
  (각 패밀리에서 5-9 acc가 1-4 acc보다 유의하게 낮음 = subitizing-style 전이 존재),
  dip이 family-orthogonal(family-dummy fit이 per-family slope 대비 RMSE 악화 미미).
  → "VLM은 일반적으로 counting-range에서 subitizing-style 한계를 보인다"는 청구 **확정**.
- **CEILING REFUTED (H2 — single-family artifact)**:
  (a) Qwen-7B처럼 **7B+ rung이 counting을 monotone으로 회복**하고 (perception 11/11 AND counting
  trend-consistent), **그리고** (b) 비-Qwen 패밀리가 3B급에서 dip을 보이지 **않음**
  (≥2 비-Qwen 패밀리의 5-9 acc가 매끄러운 monotone, dip 부재).
  → "3B dip은 Qwen2.5-VL-3B 단일-패밀리 아티팩트"로 **반증**, lane은 honest-negative로 close.
- **부분/미결**: 비-Qwen 패밀리가 dip을 보이되 7B에서 회복 → H1'(soft ceiling) 지지 유지, gate는
  "scale로 풀리는 soft subitizing capacity"로 재문구 (hard ceiling은 폐기). 추가 rung으로 계속.

> 주의: in-hand 데이터는 이미 H1의 **hard** 형태(7B에서도 풀리지 않는 상한)를 반증함(Qwen-7B 5/5).
> 따라서 살아있는 청구는 약화된 **H1' "soft, scale-emergent subitizing capacity that ≥2 families
> share at matched scale"**. CONFIRMED/REFUTED는 이 H1' vs H2(Qwen-국소) 사이의 판정이다.

### 3.6 falsifier 한 줄 (frontier-gap.json 표현과 정합)

> if a 7B+ non-Qwen rung recovers counting to monotone AND ≥2 non-Qwen families do NOT dip at
> matched (~3B) scale → REFUTED (single-family artifact). if the 5-9 dip replicates across ≥2
> non-Qwen families at matched scale (family-orthogonal) → CONFIRMED (universal subitizing-style limit).

---

## 4. 다음 실행 단계 (모델 실행은 본 노트 범위 외 — 설계만)

1. cycle-28 first-probe: SmolVLM-family vs Qwen-VL-family per-family slope split (in-hand 4점 재사용
   + matched-scale 갭 명시). 코드: 기존 `bench/sandbox_p1_multimodal_ladder_7b.hexa` 의 manifest를
   §3.3 3-구간 grid로 확장, `verify/numerics_substrate_multimodal_fit.hexa` 에 per-family/per-range
   recompute 추가.
2. cycle-29+: InternVL-(2/3B + 8B) · LLaVA-NeXT-7B rung 로딩 → 비-Qwen ≥2 패밀리 matched-scale 셀 채움.
3. §3.5 규칙으로 CONFIRMED/REFUTED 판정 → ARCHITECTURE.json N⭐ 노드 status 갱신 + verdict 기록.

---

## 5. 잔여·리스크

- **로딩 리스크**: InternVL/LLaVA-NeXT mmproj가 현 llama.cpp 빌드에서 안 뜰 수 있음 (SmolVLM-Instruct
  2.2B v1 선례). 대체 rung·INBOX-register로 진행, 강제 우회 금지.
- **통계력**: count당 ≥3 layout 없으면 5-9 dip이 단일-샘플 노이즈와 구분 안 됨 → §3.3 복제 필수.
- **subitizing 직접성**: 1-4 vs 5-9 대조가 없으면 "subitizing"이라는 라벨이 과대청구. §3.3 grid가
  이를 교정 (1-4 평탄 + 5-9 전이 = 진짜 subitizing-style; 1-4도 깨지면 일반 perception 결함).
- **양자화**: in-hand에서 배제됨 (Q8_0 == Q4_K_M Qwen-VL-3B undercount). 비-Qwen에서도 가능 시
  per-family로 1점 재확인 권장.
