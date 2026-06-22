# OPS N⭐ — heterogeneous-μ Erlang-C deviation 설계 노트

> scratch 설계 산출물 (docs scratchDir = `state/scratch/`). ARCHITECTURE.json 노드 아님 (governance c4).
> 작성 2026-06-22 · 대상 lane: `ARCHITECTURE.json` OPS group 영구 축 **N⭐** (heterogeneous-μ multi-node Erlang-C divergence).
> 본 노트는 **설계 + 프로토콜 + pass/fail 결정 규칙** 만 담는다. 모델 run 없음, 측정값 없음 (cost-bearing fire 는 cycle-29+ deferred).
> 코드/수식은 english, 서술은 korean (prefs: code=english, docs=korean).

---

## 0. 현재 상태 (SSOT 인용 — verbatim)

### 0.1 ARCHITECTURE.json — OPS group 영구 축 N⭐
```
"name": "영구 축 N⭐",
"summary": " · N⭐ MAIN heterogeneous-μ multi-node Erlang-C divergence (cycle-28):
  does classical homogeneous-μ M/M/c hold across mac M3 Metal/UMA + ubu-1 x86 CPU-only?
  anchors Bolch 2006 §6.3, Kleinrock 1975 §3.5, Krishnamoorthy 1963."
```
OPS group status: `"v1.4.0 — M/M/c knee surface landed"`.
hosts + provenance: `mini local Metal/UMA port 8090; ubu-1 LAN 192.168.50.119 RTX 5070
(llama-server pre-built bin, P3 install done PR #72)`.

### 0.2 verdict — `.verdicts/sandbox/n1_ops_heterogeneous_mmc_predict.txt` (cycle-28 first probe)
- tier = **🟡 SUPPORTED-BY-CITATION-AND-DERIVED** (closed-form predict, NOT 측정).
- `mu_mac_x1000=9530` (cycle-16 c=1 **MEASURED**, mini M3 Metal/UMA).
- `mu_ubu_x1000=3000` (cycle-24 Option-A CPU-only Q4_K_M **PREDICT** — 측정 아님).
- `heterogeneity_ratio_x1000=3176` (~3.18×).
- 3-variant closed-form λ_max predict:
  - `lambda_homogeneous_x1000=12530` (Bolch 2006 §6.3, = Σμ_i).
  - `lambda_sed_x1000=12530` (Krishnamoorthy 1963, work-conserving).
  - `lambda_slow_bound_x1000=6000` (Whitt 1986 / naive equal-RR = c·μ_min).
- **falsifier band = [6.000, 14.409] qps** (lo = c·μ_min, hi = 1.15·Σμ_i).
- next_probe: `cycle-29+ 2-host fire bench/sandbox_p3_multinode_2host.hexa LAN 192.168.50.119`.

### 0.3 verdict — `.verdicts/sandbox/m4_ops_formula_fit.txt` (cycle-16, homogeneous 단일 호스트 close)
- tier = **🟢 SUPPORTED-NUMERICAL** (5/5). 단일 M3 UMA, **homogeneous-μ 가정** 하 닫힘.
- μ_eff ∈ {9.53, 7.505, 5.0} req/s/slot (c=1/2/4) — c 증가 시 UMA mem-bw 로 **degrades**.
- ceiling λ_max = c·μ → {9.53, 15.01, 20.0} qps. knee 는 -np 와 함께 **RIGHT shift**.
- 두 accuracy-cliff 메커니즘: (a) client-timeout truncation, (b) scheduler slot-preemption.

### 0.4 ENGINE 축 C1 wire — `ENGINE/wires/wire_c1_ops_hetero_scheduler.hexa` (cycle-5 SPEC)
- 6/6 PASS · 🟢 SUPPORTED-NUMERICAL. per-server μ (mini=9.53, ubu-1=3.0) → policy=`weighted-round-robin`.
- λ_max hetero-aware = Σμ_i = 12.53 vs naive equal-RR/Whitt slow-bound = c·μ_min = 6.0 → **예측 gain 2.09×**.
- 단, **runtime 2-host fire 는 cost-bearing — deferred**. C1 falsifier: scheduler 가 단일-UMA formula
  나 dominant-slow-server (Whitt 1986) variant 와 일치하면 wire 무효.

### 0.5 무엇이 OPEN 인가 (요약)
- **닫힘**: 단일 호스트 homogeneous M/M/c (cycle-16, m4 verdict 🟢). μ_mac=9.53 측정됨.
- **열림 (N⭐ MAIN)**: 2개 이상의 **이질적 μ_i** 호스트에 걸친 aggregate λ_max 의 **측정**.
  현재는 closed-form predict (🟡) + wire SPEC (🟢) 만 존재. μ_ubu=3.0 은 **PREDICT, 미측정**.
  2-host bench(`sandbox_p3_multinode_2host.hexa`)는 **SKELETON ONLY (no FIRE)**.
- **falsifier 미발사**: ≥3 host-rate ratio 에서 measured aggregate λ_max 가 falsifier band 를
  homogeneous prediction 쪽으로 collapse 하는지 아직 한 점도 측정 안 됨.

---

## 1. 정확한 이론 gap

### 1.1 Classical homogeneous M/M/c (Erlang-C) — 닫힌 형식
서버 c 개가 **동일** rate μ, arrival 은 Poisson rate λ:
```
a   = λ / μ                         (offered load, Erlangs)
ρ   = a / c = λ / (c·μ)             (utilization; stability requires ρ < 1)

           a^c / (c!·(1−ρ))
C(c,a) = ───────────────────────────────────────         (Erlang-C P[wait>0])
         Σ_{k=0}^{c−1} a^k/k!  +  a^c/(c!·(1−ρ))

Wq  = C(c,a) / (c·μ − λ)            (mean queue wait)
W   = Wq + 1/μ                      (mean sojourn)

THROUGHPUT CEILING:  λ_max = c·μ
KNEE / POLE:         ρ → 1  (W → ∞, sharp pole — not a smooth bend)
```
핵심: **모든 서버가 동일 μ** 이므로 routing 정책은 무의미하다 (어디로 보내든 같은 μ).
ceiling 은 c·μ, 평균 μ̄ = μ.

### 1.2 Heterogeneous-μ 일반화 (서버마다 다른 μ_i)
서버 i 가 distinct μ_i (예: μ_mac=9.53, μ_ubu=3.0). 이 경우:

1. **닫힌 형식 부재**: heterogeneous M/M/c 는 일반적으로 closed-form Erlang-C 가 없다.
   stationary 분포는 routing 정책에 의존하며, state space 가 서버 식별을 요구한다
   (Bolch 2006 §6.3 "heterogeneous servers"; Gumbel 1960; Krishnamoorthy 1963).
2. **routing 이 1차 변수가 됨** (homogeneous 와의 결정적 차이):
   - **equal-RR (naive round-robin)**: arrival 을 c개 서버에 균등 분할 → 각 서버가 λ/c 를 받음.
     느린 서버가 먼저 ρ_slow = (λ/c)/μ_min = 1 에 도달 → 시스템 ceiling 이 **slow server 에
     bound**: `λ_max(equal-RR) = c·μ_min` (Whitt 1986 dominant-slow-server / Larsen-Agrawala 1983).
   - **weighted-RR (split ∝ μ_i)**: arrival 을 μ_i 비례로 분할 → 모든 서버가 동시에 ρ→1.
     work-conserving → `λ_max(weighted-RR) = Σ μ_i`.
   - **SED (shortest-expected-delay)**: state-dependent, expected delay 최소 서버로 라우팅.
     point-wise optimal, λ_max → Σ μ_i (Krishnamoorthy 1963; Larsen-Agrawala 1983).

### 1.3 deviation 의 정확한 진술 — homogeneous 이론이 예측하는 것 vs 우리가 측정할 것
homogeneous M/M/c 이론(§1.1)을 c=2, μ̄=(μ_mac+μ_ubu)/2 로 **잘못 적용**하면:
- ceiling = c·μ̄ = Σμ_i = 12.53 qps 를 예측하되, **routing 정책 간 차이를 0 으로 예측**
  (homogeneous 에서는 equal-RR 도 ceiling 에 도달한다고 봄).

heterogeneous 현실(§1.2)은:
- equal-RR ceiling = c·μ_min = 2·3.0 = **6.0 qps**
- weighted-RR / SED ceiling = Σμ_i = **12.53 qps**
- → **weighted/equal gain = 12.53 / 6.0 = 2.09×** (ENGINE C1 wire 예측값).

**정확한 deviation**: homogeneous 이론은 "routing 정책이 ceiling 에 무영향 (gain = 1.0×)" 을
예측하지만, heterogeneous μ 에서는 weighted-RR 가 equal-RR 를 ceiling 기준 **2.09× 능가**한다.
이 2.09× 가 0(=homogeneous prediction)으로 collapse 하는지가 lane 의 falsifier.

### 1.4 anchors
- Bolch et al. 2006, *Queueing Networks and Markov Chains* (Wiley 2nd ed.) **§6.3** (heterogeneous servers).
- Kleinrock 1975, Vol. I **§3.5** (M/M/c 기본형).
- Krishnamoorthy 1963, *Op. Res.* 11(2):321–330 (heterogeneous-server / SED-style optimal).
- Whitt 1986, *Op. Res. Letters* 5(4):199–204 (dominant-slow-server bound = naive equal-RR).
- Larsen & Agrawala 1983, *IEEE TSE* SE-9(2):189–197 (SED routing).

---

## 2. Falsifier 실험 설계 (probe)

### 2.1 hosts + 측정될 μ_i (≥3 ratio 확보)
| host | hardware | μ_i (req/s) 출처 | 역할 |
|------|----------|-----------------|------|
| `mini` | mac M3 Metal/UMA, port 8090 | **9.53 측정** (cycle-16 m4) | fast anchor |
| `ubu-1` | x86, LAN 192.168.50.119, RTX 5070 (또는 CPU-only) | 3.0 **PREDICT → STEP-0 에서 측정** | slow node |
| `ubu-1-throttled` | ubu-1 의 `-np`/thread 제한으로 μ 인위 변경 (3rd rate point) | STEP-0 에서 측정 | ratio sweep 용 |

> 물리 3번째 박스(pi5-akida/ubu-2)는 현재 rate 미측정·llama-server 미설치이므로,
> **3번째 rate point 는 ubu-1 을 thread-cap 으로 throttle** 하여 같은 박스에서 μ 를 의도적으로
> 낮춰(예: 1 thread → ~1.5 qps) 확보한다. 이게 ratio sweep 의 비용·재현성 모두 최선.
> pi5/ubu-2 가 준비되면 4번째 point 로 추가(설계상 open).

### 2.2 host-rate ratio grid (≥3, derive)
heterogeneity ratio R = μ_fast / μ_slow 를 ≥3 점으로 sweep:
```
R1 ≈ 1.0   : mini vs mini-replica (homogeneous control — gain 은 1.0× 이어야 함)
R2 ≈ 3.18  : mini(9.53) vs ubu-1(≈3.0)         (cycle-28 primary point)
R3 ≈ 6.4   : mini(9.53) vs ubu-1-throttled(≈1.5)  (1-thread cap)
(R4 ≈ 1.6 : mini vs ubu-1-fast(≈6.0, GPU 모드) — optional 4th)
```
**R1 (homogeneous) 는 negative control**: 여기서 gain 이 1.0× 가 아니면 harness 자체 버그.

### 2.3 measure 그리드 {λ} (offered rate)
기존 M3.OPS 그리드 재사용 + slow ceiling 부근 보강:
```
rate_grid_qps = {1, 2, 4, 6, 8, 10, 12, 15, 20, 40}
```
- 6.0(equal-RR ceiling)과 12.53(weighted ceiling) 사이를 {6,8,10,12} 로 조밀 샘플 → 두 정책의
  ceiling 분기점을 분해.
- wall cap 240s/cell (M2.OPS FIX-R2), warmup 15s 제외, measure 60s.

### 2.4 비교할 routing 정책 (3종)
각 ratio × rate 셀에서 동일 arrival stream 을 3 정책으로 분배:
1. `equal-RR` : 50/50 분할 (homogeneous 가정의 naive 정책). ceiling 예측 = c·μ_min.
2. `weighted-RR` : split ∝ μ_i (mini:ubu = 9.53:3.0 ≈ 0.76:0.24). ceiling 예측 = Σμ_i.
3. `SED` : 각 arrival 을 (queue_len_i + 1)/μ_i 최소 서버로 보냄 (state-dependent). ceiling = Σμ_i.

> 분배는 harness client-side (0-dep, nginx/haproxy 없음 — 기존 `_dispatch_one` 패턴).
> 두 llama-server replica 는 각각 `-np 1 -cb`, 셀 간 kill 로 clean state.

### 2.5 closes vs keeps-open 하는 metric (결정 변수)
각 ratio R 에서 **measured** aggregate throughput ceiling λ̂_max 를 정책별로 추출:
```
gain(R) = λ̂_max(weighted-RR) / λ̂_max(equal-RR)
```
- **homogeneous prediction**: gain = 1.0× (routing 무영향).
- **heterogeneous prediction**: gain = Σμ_i / (c·μ_min) = (μ_fast+μ_slow)/(2·μ_slow).
  R2 에서 ≈ 2.09×, R3 에서 ≈ 3.51×, R1 에서 ≈ 1.0×.

### 2.6 sample size
- 셀당 measure 60s × target rate → 정상부 셀은 600–1200 완료. p99 게이트 ≥100, p999 게이트 ≥1000.
- ceiling 추정: 각 정책에서 rate 를 ceiling 위로 밀었을 때 saturated throughput 의
  마지막 3 rate-point 중앙값(λ̂_max). 정책당 ≥3 over-saturated 셀 확보.
- ratio 3점 × 정책 3종 × rate 10점 = 90 셀 (R1 control 포함). 각 셀 ≤240s → 총 ≤6h wall, $0 (local+LAN).

### 2.7 confounds (이미 기존 M/M/c surface 를 물었던 것들 — 반드시 제어)
1. **client timeout truncation** (a-cliff): `req_timeout=30s` 가 느린 ubu-1 tail 을 자르면 accuracy
   가 떨어져 throughput 을 **과소** 측정. → ubu-1 path 의 timeout 을 별도(예: 60s)로 두고,
   error_rate(non-2xx)와 accuracy(content)를 **분리** 집계. ceiling 은 n_completed 기반, accuracy 와 독립.
2. **scheduler slot-preemption** (b-cliff): `-np≥2` continuous-batch 가 in-flight 를 preempt → 짧은
   HTTP-200 content. → 각 replica `-np 1` 로 고정 (per-host c=1), preemption 메커니즘 차단.
3. **network RTT offset** (ubu-1 LAN): knee 를 right-shift 시키지만 ceiling 은 RTT 와 무관해야 함.
   → ceiling 비교는 RTT-invariant. RTT 가 ceiling 을 >25% 깎으면 (Σμ_h 대비) → substrate
   independence 깨짐으로 별도 기록 (p3 bench 의 기존 falsifier).
4. **host background load**: mini μ 는 harness 자체 shell-pipeline(xargs/jq/awk)이 UMA 를 먹으면
   하락(cycle-16 에서 8.9→3.4 변동 관측). → STEP-0 에서 idle-host μ_i 재측정, 모든 정책 run 을
   같은 background 조건에서 back-to-back 실행 (정책 순서 randomize).
5. **arrival-generator serialization**: client-side LB 가 직렬화되면 두 ceiling 이 모두 깎임.
   → R1 homogeneous control 이 이를 잡는다 (직렬화 있으면 R1 gain 이 1.0× 미달).

---

## 3. pass/fail 결정 규칙

STEP-0 에서 idle μ_mac, μ_ubu, μ_ubu_throttled 를 **측정**하여 각 R 의 heterogeneous-prediction
`G_het(R) = Σμ̂_i / (c·μ̂_min)` 를 산출한다. 이후 각 R 에서 measured `gain(R)` 을 비교한다.

```
for each ratio R in {R1≈1.0, R2≈3.18, R3≈6.4}:
    G_het(R)  = Σμ̂_i / (c·μ̂_min)          # heterogeneous theory
    G_hom     = 1.0                         # homogeneous theory (routing-invariant)
    gain(R)   = λ̂_max(weighted-RR) / λ̂_max(equal-RR)   # MEASURED

DECISION:
  • KEEPS LANE OPEN (deviation 확인, novel):
        gain(R) ≥ 1.5×  AND  |gain(R) − G_het(R)| / G_het(R) ≤ 0.20
        가 ≥2 개의 heterogeneous R (R2, R3) 에서 성립
        (즉 measured gain 이 homogeneous 1.0× 가 아니라 het prediction 에 ±20% 로 붙음)
        + R1 homogeneous control 에서 gain ≈ 1.0× (±0.15) — harness 무결성 확인.

  • CLOSES LANE (falsifier 발사 — homogeneous 로 collapse):
        gain(R) 가 ≥3 host-rate ratio 에서 모두 [1.0 − 0.15, 1.0 + 0.15] 안에 들어옴
        (= routing 정책이 ceiling 에 무영향 = homogeneous M/M/c prediction).
        이 경우 2.09× weighted-vs-equal divergence 는 환상이었고 lane 닫힘.

  • INCONCLUSIVE (재측정):
        confound 2.7 중 하나라도 미제어로 판명 (R1 control 실패, RTT >25% ceiling 잠식,
        timeout truncation 이 ceiling 추정 오염) → 해당 confound 고정 후 재발사.
```

### 3.1 한 줄 falsifier (frontier-gap.json 와 일치)
> ≥3 host-rate ratio 에서 heterogeneous-μ routing gain 이 classical homogeneous M/M/c
> prediction(gain=1.0×)으로 collapse 하면 (no 2.09× weighted-vs-equal divergence) → **lane closes**.

### 3.2 다음 발사 (cost-bearing, deferred)
1. STEP-0: `bench/sandbox_p3_multinode_2host.hexa` 를 FIRE 로 승격 — idle μ_mac, μ_ubu(GPU/CPU 모드),
   μ_ubu_throttled(1-thread) 를 각각 c=1 baseline 으로 측정 (R grid 확정).
2. STEP-1: 3 정책 × 3 ratio × rate-grid 셀 sweep, per-cell λ̂_max + accuracy(분리) emit →
   `.verdicts/sandbox/n1_ops_heterogeneous_mmc_measured.tsv`.
3. STEP-2: §3 결정 규칙 적용 → verdict 갱신 (🟡 predict → 🟢/🔴 measured), ARCHITECTURE.json N⭐
   summary 갱신, ENGINE C1 wire λ_max 재검증.

---

## 4. 산출물 경로
- 이 설계 노트: `state/scratch/ops-heterogeneous-mu-design.md`
- 측정될 verdict (예정): `.verdicts/sandbox/n1_ops_heterogeneous_mmc_measured.tsv`
- 발사 bench (skeleton→fire): `bench/sandbox_p3_multinode_2host.hexa`
- 관련 closed-form predict: `.verdicts/sandbox/n1_ops_heterogeneous_mmc_predict.txt`
- 관련 wire SPEC: `ENGINE/wires/wire_c1_ops_hetero_scheduler.hexa`
