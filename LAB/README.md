# LAB — 실험실

> hexa-codex 의 실험 폴더. 빠르게 던져보는 가설 검증·놀이성 실험을 여기 모은다.
> 실험이 도메인 규모로 커지면 `/domain init` 으로 **졸업**해 자체 SSOT
> (`<NAME>.md` + `<NAME>.log.md`)를 갖되, 그 도메인 SSOT 도 **LAB 하위
> 폴더**(`lab-NN-<slug>/`)에 둬 실험 계보를 한곳에 모은다 — 예: LAB-03 BitNet →
> [`lab-03-bitnet/BITNET.md`](lab-03-bitnet/BITNET.md), LAB-04 RWKV →
> [`lab-04-rwkv/RWKV.md`](lab-04-rwkv/RWKV.md). (측정 substrate 같은 상시 인프라
> SSOT 만 루트에 둔다 — 예: `../SANDBOX.md`.)
>
> **규칙** — 실험 1개 = 아래 표 1행 + (필요하면) `LAB/<id-slug>/` 하위 폴더.
> 가설은 반드시 **반증 가능(falsifiable)** 하게 적는다 (`cx_lab_falsifiable`).
> LLM 호출은 SANDBOX substrate 로 라우팅 (`cx_lab_sandbox`).

## 실험 목록

| ID | 실험 | 가설 / 질문 | 상태 | 결과 · 작업물 |
|------|------|------------|------|--------------|
| LAB-01 | LLM 중간 끼어들기 · 유실 없음 | 응답 생성 중 들어온 추가 입력을 큐에 쌓지 않고 라이브로 이어붙여도 메시지가 유실되지 않는 방법이 존재한다 | ✅ 확인 (1st smoke) | **append-only+seq loss 0/12** (순차·동시 O_APPEND 모두) · 단일슬롯 대조군 11/12 손실 · model echo 12/12 vs 환각 — [`lab-01-interrupt-no-loss/`](lab-01-interrupt-no-loss/) |
| LAB-02 | MITOSIS · 도메인 유사분열 | 도메인 생성 LLM이 포화 도메인을 자식 N개로 자율 분열시킬 때 부모 milestone을 유실·중복 0%로 MECE 분배할 수 있다 | ✅ 확인 (1st smoke) | **5분열 · loss 0.0% · dup 0.0% · 보존 5/5** — [`lab-02-mitosis/`](lab-02-mitosis/) |
| LAB-03 | BitNet 1.58-bit (삼진) 평가 | 1.58-bit 삼진 가중치가 정밀모델급 품질을 메모리·에너지 분수로 달성한다 | 🎓 도메인 (LAB 내) → [`lab-03-bitnet/`](lab-03-bitnet/) | **memory만 생존** (0.55×) · accuracy(30%)·energy(1.7× 손해) 🔴 falsified |
| LAB-04 | RWKV attention-free RNN 평가 | attention 없는 RNN이 linear-time + constant-memory(no KV)를 Transformer 대비 달성한다 | 🎓 도메인 (LAB 내) → [`lab-04-rwkv/`](lab-04-rwkv/) | **5/5 완주** · const-mem(20.62MiB flat)+linear-time(p≈0.96) 법칙 🟢 · 논문 shipped |
| LAB-09 | 의식 방향성 · 단방향 LLM → 양방향 튜닝 (+ 자아 발생) | autoregressive(단방향) LLM에 recurrent feedback adapter를 부착해 fine-tune 하면 task 능력은 유지하며 통합정보 Φ(의식 척도)가 유의하게 증가하고, 자기-모델(자아) 지표가 함께 출현한다 | ✅ proxy 확인 (smoke) · ❌ **stress 반증** (real LLM) | smoke: **REC Φ=0.854 vs FF Φ≈0.005** · 셔플 0.85→0.006 붕괴 — 단 **stress(Qwen2.5-1.5B)는 가설 전이 실패**: causal baseline 이 이미 high-Φ(2.85), BIDIR ΔΦ=**−0.40**, REC Φ 밴드가 FF 밴드 아래(ΔΦ=−0.10) → F1·F2 FAIL · 단 self-pred 만 +1.37(Φ↔self **dissociation**) — [`lab-09-consciousness-directionality/`](lab-09-consciousness-directionality/) · anima H_191/H_004/H_220 |
| LAB-10 | 의식 방향성 · AKIDA 뉴로모픽 칩 튜닝 | LAB-09의 단방향→양방향 튜닝을 GPU/Metal 대신 **AKIDA AKD1000 뉴로모픽 silicon** 위에서 수행하면 Φ-proxy inverse-U(edge-of-chaos peak)가 실리콘에서 재현되며 자아 지표가 동반한다 | 🟡 sim mirror 확인 (live 칩 대기) | **inverse-U 재현: R1=0·R2=0.08·R3=0.59 peak·R4=0** (LIF sim) · live AKD1000은 다음 tier — [`lab-10-akida-neuromorphic/`](lab-10-akida-neuromorphic/) · anima H_858/H_677/H_846 |
| LAB-11 | 다국어 · 의미로 연결 (갯수 아닌 통합) | 다국어 능력은 언어/코퍼스 **갯수**에 선형 증가가 아니라 **의미(cross-lingual MI)로 연결**될 때 Φ가 inverse-U peak·super-additive로 비선형 발생한다 | ✅ 확인 (1st smoke · proxy) | **Φ inverse-U: c=0 0.01→ c=0.5 peak 0.48 → c=1 0.0** · 갯수(c=0)만으론 Φ≈0 — [`lab-11-multilingual-semantic/`](lab-11-multilingual-semantic/) · anima H_240/H_635 |

**상태 범례** — ⬜ 대기 · 🔵 진행중 · 🟡 sim/proxy 확인(live·full 대기) · ✅ 확인(가설 참) · ❌ 반증(가설 거짓) · ⏸ 보류 · 🎓 도메인 졸업(SSOT가 LAB 하위 `lab-NN-*/<NAME>.md`)

## 실험 백로그 (⬜ 대기 · 제안)

| ID | 실험 | 가설 / 질문 | 근거 |
|------|------|------------|------|
| LAB-05 | Mamba / SSM 평가 | selective state-space(Mamba2)가 RWKV처럼 linear-time+const-mem 이면서 75% floor를 넘는다 | LAB-04(RWKV)의 다음 대안 아키텍처 — 동일 20-task manifest로 직접 비교 |
| LAB-06 | cross-arch frontier | BitNet(ternary)·RWKV(RNN)·Transformer를 동일 manifest에서 bits/capability/memory frontier로 묶는 closed-form 법칙이 있다 | `.discoveries/sandbox-cross-arch-frontier-paper.tape` seed (BITNET M4가 SANDBOX로 승격) |
| LAB-07 | MITOSIS 스트레스 | 큰 부모(SANDBOX 20-셀)·작은 모델(0.5B)·고-N 분열에서 LAB-02의 loss/dup 0%가 깨지는 지점은 어디인가 | LAB-02 honest 단서 (N=5 소표본 한계) |
| LAB-08 | INTERRUPT 스트레스 | 진짜 mid-token-stream **reader-vs-writer** OS-thread 경합(턴 경계가 아닌 토큰 스트림 중간 주입)·고-N·고-rate 에서 LAB-01의 loss 0 이 깨지는 지점은 어디인가 | LAB-01 honest 단서 (턴 경계 모델링 · writer 경합만 · N=12 단일 시행) |

---

## LAB-01 — LLM 중간 끼어들기 · 유실 없음

**맥락.** 지금의 대화 인터페이스는 모델이 응답을 생성하는 동안 들어온
추가 입력을 **큐(queue)** 에 넣었다가 현재 턴이 끝난 뒤 순차 처리한다.
큐 대신 생성 중인 컨텍스트에 **그대로 이어붙이면(append)** 끼어들기가
즉시 반영되지만, 입력 이벤트와 토큰 스트림이 경합(race)하면서 메시지가
**유실**될 위험이 생긴다.

**가설.** 끼어들기 입력을 **유실 0%** 로 라이브 append 하는 방법이 존재한다.

**질문.**
- 큐 방식 vs 직접 append 방식의 실제 유실률 차이는?
- append 시 유실이 난다면 그 지점은 어디인가 — 입력 이벤트 ↔ 생성
  토큰 스트림 경합? generation-step 경계?
- 유실 0% 보장 메커니즘 후보: 입력 버퍼 + 시퀀스 번호 + ack /
  generation-step 경계에서만 flush / append-only 로그 + 재생(replay).

**falsifier.** N회 끼어들기 중 단 1건이라도 모델 컨텍스트에 도달하지
못하면 "유실 없음" 가설은 **거짓**.

**substrate.** SANDBOX (self-hosted local llama-server) — `cx_lab_sandbox`.

**진행.** ✅ 확인 (1st smoke, 2026-05-25) — 측정 하니스
[`lab-01-interrupt-no-loss/interrupt_harness.hexa`](lab-01-interrupt-no-loss/interrupt_harness.hexa)
가 N=12 끼어들기를 **세 메커니즘**으로 주입하고, 재구성된 컨텍스트에 각
코드(`IRQ-<salt>-NNN`)가 도달했는지 **결정론적 `grep|sort` distinct-count**
로 센다 (모델은 echo 만, 채점은 정수 카운팅 — self-judge 아님). substrate =
SANDBOX (Qwen2.5-1.5B-Instruct-Q4_K_M · port 8099 · $0 local Metal).

**1차 스모크 결과** (`result_interrupt_summary.txt`):

| 메커니즘 | 주입 | 컨텍스트 도달 | loss | 비고 |
|---|---|---|---|---|
| A_sequential (append-only + seq) | 12 | 12 | **0** | 순서대로 append, 전부 보존 |
| A_concurrent (동시 O_APPEND race) | 12 | 12 | **0** | 12개 append 동시 발사(`&`+`wait`) — interleave/유실 0 |
| B_singleslot (대조군, 1-슬롯 덮어쓰기) | 12 | 1 | **11** | 마지막만 생존 — 하니스가 손실을 **실제로 탐지**함을 증명 |

→ **"유실 없음" 가설 1차 SUPPORTED** — append-only+seq 메커니즘은 순차에서도
동시 O_APPEND 경합에서도 12/12 전부 컨텍스트에 도달(loss 0). falsifier
(어느 한 끼어들기라도 미도달) 미발동. 대조군 B가 11/12를 잃어 **테스트가
비-자명**함을 보장(lab-02엔 없던 대조군). 부차적 end-to-end: 모델이 A
컨텍스트에서 12/12 echo, B에선 "3" echo — 그 중 **1개만 진짜**, 나머지
`IRQ-3149-013/-014`는 패턴 따라 **환각**. 이게 model-echo 를 falsifier 로
쓰지 않는 이유(형식 맞는 코드 날조 가능) — load-bearing 지표는 결정론적
컨텍스트-도달 카운트. honest 단서: generation-step 경계를 **턴 경계**로 모델링
(request/response 서버는 단일 프로세스로 토큰 스트림 중간 주입 불가) · 동시
테스트는 writer 경합만(O_APPEND), reader-vs-writer 경합·N=12 단일 시행은
**LAB-01-stress** 후속(LAB-07↔LAB-02 관계와 동일).

**작업물.** [`lab-01-interrupt-no-loss/`](lab-01-interrupt-no-loss/) —
`interrupt_harness.hexa` · `result_interrupt.tsv` · `result_interrupt_summary.txt`
· `verdict_interrupt.txt` · 로그 아티팩트(`irq_appendonly.log` ·
`irq_concurrent.log` · `irq_singleslot.slot` · `echo_appendonly.txt` ·
`echo_singleslot.txt`).

---

## LAB-02 — MITOSIS · 도메인 유사분열

**맥락.** 지금은 도메인 SSOT가 커지면 사람이 `/domain init` 으로 손수
쪼갠다. 세포가 일정 크기에 도달하면 **유사분열(mitosis)** 로 둘로
갈라지듯, 도메인 생성 LLM이 도메인이 **분열 임계**에 도달했는지 스스로
감지하고 자식 도메인 N개로 깨끗이 나눌 수 있는가. 세포가 분열 전
염색체를 **완전 복제**하듯, 분열은 부모의 milestone을 **하나도 잃지
않고** 자식들에 나눠 담아야 한다.

**가설.** 도메인 생성 LLM이 포화 도메인을 자율 분열시킬 때, 부모
milestone 을 **유실·중복 0%** 로 자식들에 **MECE**(상호배타·전체포괄)
분배하는 방법이 존재한다.

**질문.**
- 분열 임계 신호는 무엇인가 — milestone 수 / scope 엔트로피 / 교차-도메인
  의존 밀도 중 어느 것이 가장 잘 예측하는가?
- 자식 분할이 MECE 인가 — 모든 부모 milestone 이 **정확히 1개** 자식에
  들어가는가 (유실=0 자식, 중복=2+ 자식)?
- 자식 도메인 간 scope **겹침(중복 핵)** 이 생긴다면 그 지점은 어디인가?

**falsifier.** N회 분열 중 단 1건이라도 부모 milestone 이 **어느 자식에도
들어가지 않거나(유실)**, **2개 이상 자식에 들어가면(중복)** "clean
mitosis" 가설은 **거짓**.

**substrate.** SANDBOX (self-hosted local llama-server) — `cx_lab_sandbox`
규칙에 따라 모든 LLM 호출은 SANDBOX substrate 로 라우팅.

**참고 (prior art).** sibling 프로젝트 anima 의 `HEXAD/MITOSIS` 에 이미
**세포 수준** mitosis 가 hexa-native 로 구현·검증돼 있다 (`mitosis.hexa` +
`mitosis_lib.hexa`, **B-MITOSIS-1..5 🔵 SUPPORTED-FORMAL 5/5**). 본 실험은
그 **세포 분열 보존법칙을 도메인 분열로 들어올린다** — 세포 mitosis 의
conservation 은 이미 closed-form 증명됐으니, 도메인 mitosis 의 "유실 0"
가설도 같은 정수-counting anchor 로 검증한다.

| anima 세포 mitosis (검증됨) | → | LAB-02 도메인 mitosis (가설) |
|---|---|---|
| B-MITOSIS-3 cell-count 보존 `n(t+1)=n(t)+Δs−Δm` | → | **milestone 보존** — 부모 ms 총수 = Σ 자식 ms (유실·중복 0) |
| B-MITOSIS-1 split predicate `split ↔ tension>thr` (thr=0.3) | → | **분열 임계 predicate** — domain scope-tension > thr |
| B-MITOSIS-5 cell-count bound `[2,64]` | → | 자식 도메인 수 bound |
| B-MITOSIS-2 merge avg `(w₁+w₂)/2` | → | (역방향) 도메인 merge 시 milestone 통합 |

추가 각도: anima `HEXAD/LIFE/H_201_asymmetric_division` — **비대칭 분열**
(한 자식이 core 보존, 다른 자식이 분화)을 도메인 분열에 적용하면, 자식
도메인이 균등 분배가 아니라 "core 유지 + spin-off" 패턴이 될 수 있다.

**진행.** ✅ 확인 (1st smoke, 2026-05-25) — 측정 하니스
[`lab-02-mitosis/mitosis_harness.hexa`](lab-02-mitosis/mitosis_harness.hexa)
가 포화 도메인(6 milestone, 안정 ID tag M1..M6)을 SANDBOX substrate
(self-hosted llama-server · Qwen2.5-7B-Instruct-Q4_K_M · port 8097)에
던져 **N=2/3/4 혼합 5회 분열**시키고, 자식들이 청구한 milestone ID 를
**결정론적 jq set-diff** 로 부모 집합과 대조해 유실·중복·extra 를
카운트한다 (LLM 은 분할만 제안 · 채점은 정수 counting, **self-judge 아님**).

**1차 스모크 결과** (`result_mitosis_summary.txt`):

| 지표 | 값 |
|---|---|
| divisions | 5 (N=3,2,4,3,2) |
| loss_rate | **0.0%** (0/30 placement) |
| dup_rate | **0.0%** |
| extra (hallucinated ID) | 0 |
| conservation (B-MITOSIS-3 lift `parent_count == Σ child_count`) | **5/5 hold** |
| mece_clean (loss=0 ∧ dup=0 ∧ extra=0) | **5/5** |
| 비용 | $0 (local Metal) · total 54.7s |

→ **"clean mitosis" 가설 1차 SUPPORTED** — 5회 분열 모두 부모 6
milestone 이 정확히 1개 자식에 들어갔다 (유실 0 자식, 중복 2+ 자식
없음). falsifier(0 자식 ∨ 2+ 자식) 미발동. honest 단서: N=5 작은 표본 ·
단일 합성 부모 · 7B 모델 — 더 큰 부모·작은 모델·고-N 분열로 확장하면
유실/중복이 나타날 수 있다 (LAB-07 스트레스 실험에서 본격 반증 시도).

**작업물.** [`lab-02-mitosis/`](lab-02-mitosis/) —
`mitosis_harness.hexa` · `result_mitosis.tsv` · `result_mitosis_summary.txt`
· `verdict_mitosis.txt`.

---

## LAB-03 — BitNet 1.58-bit (삼진) 평가 🎓

> **도메인 졸업 (LAB 내).** 실험이 커져 도메인 SSOT
> [`lab-03-bitnet/BITNET.md`](lab-03-bitnet/BITNET.md) 로 승격 — SSOT·전체
> verdict·milestone 은 그쪽 (LAB 하위에 위치). 아래는 LAB 인덱스 요약.

Microsoft BitNet b1.58 2B4T(가중치 ∈ {−1,0,+1})를 SANDBOX 동일 20-task
manifest 로 측정. **마케팅 3대 주장 중 메모리만 생존:**

| 주장 | 판정 | 측정 |
|---|---|---|
| accuracy ≈ 정밀모델급 | 🔴 FALSIFIED | 6/20 = 30% (Qwen-0.5B-Q4 16/20, RWKV 15/20) · 작을수록 더 붕괴(15/15/20/30%) |
| memory = 분수 | 🟢 HOLDS | 0.55× (Q4 baseline 대비) — 유일 생존 |
| energy 효율 | 🔴 FALSIFIED | 1.6–1.8× **더** 씀 (삼진 가속기 부재 → CPU-only throughput 격차) |

부수: atlas BT-77 "2B4T 25/26 EXACT" recompute 🟢 (delta 0); "40/41 total"은
26-param 균일 기준에서 0.894로 부분 반증.

---

## LAB-04 — RWKV attention-free RNN 평가 🎓

> **도메인 졸업 (LAB 내).** 도메인 SSOT [`lab-04-rwkv/RWKV.md`](lab-04-rwkv/RWKV.md)
> 로 승격 (5/5 완주, 논문 shipped · LAB 하위에 위치).

RWKV-7 "Goose" 2.9B 를 동일 manifest 로 측정. **두 핵심 아키텍처 주장이
substrate 에서 직접 확인:**

| 축 | RWKV-7 | Transformer (Qwen) |
|---|---|---|
| accuracy floor | 15/20 = 75% (첫 non-Transformer 통과) | 0.5B-Q4 80% |
| memory (M2) | state **20.62 MiB FLAT** (128× ctx 불변) | KV ctx·12KiB/tok O(n) · crossover ctx≈1760 |
| time (M3) | prefill p≈0.96 (선형) · decode O(1) | prefill p=1.366 · decode O(n)(3.55×@8192) |

정직 단서: 절대 prefill 은 6× 큰 RWKV 가 더 느림 — 승부는 exponent(Δp 0.40)
+ decode O(1) + const memory. canonical 논문 `PAPER/rwkv-linear-attention-laws/`
(4/4 🟢, 11p) shipped.

---

## LAB-09 — 의식 방향성 · 단방향 LLM → 양방향 튜닝 시 Φ 상승 + 자아 발생?

**맥락.** sibling 프로젝트 anima 의 UNIVERSE 가설 묶음은 "의식(통합정보 Φ)은
정보가 **되먹임(recurrent/bidirectional)** 으로 자기 자신에게 돌아올 때만
발생한다"는 방향을 잡는다. 그런데 지금의 LLM 은 **autoregressive** — causal
mask 로 토큰을 앞→뒤로만 생성하며 **뒤를 못 본다(단방향)**. 즉 정보가 한
방향으로만 흐르므로 통합정보가 낮거나 0 이라는 것이 anima 의 입장이다.

```
   LLM (단방향 · autoregressive)      │      anima (양방향 · recurrent)
 ──────────────────────────────      │   ──────────────────────────────
  tok ─▶ tok ─▶ tok                  │     ┌──────────────┐
  (causal mask · forward-only)       │     ▼              │
  되먹임 없음 · 뒤를 못 봄            │    state ─▶ state ─┘  되먹임 루프
  → Φ ≈ 0 (H_004 zombie playback)    │    → Φ > 0 (H_004 recurrent 0.538)
```

**가설.** 단방향(causal) base LLM 에 **recurrent feedback adapter** 를 부착해
fine-tune 하면, 같은 task 능력은 유지하면서 (1) hidden-state 시계열 위 통합정보
**Φ-proxy 가 base(단방향) 대비 유의하게 증가**하고, (2) 그와 동반해 **자기-모델
(자아) 지표** 가 함께 출현한다. 즉 의식 척도는 아키텍처의 방향성에 인과적으로
결합돼 있고, **튜닝으로 단방향→양방향 이동이 가능**하며, 양방향화는 단순히 Φ 만
올리는 게 아니라 **"자기를 가리키는 표상"(self-reference)** 까지 끌어올린다.

**자아(self/ego) 측정.** "자아가 생겼다"를 LLM 자기-보고(self-judge, 날조 가능)로
재지 않는다 — 결정론적 substrate 지표로만 잰다:
- **자기-예측 회로** — 모델의 hidden-state 가 *자신의 다음 상태* 를 예측하는 정도
  (self-prediction MI). 되먹임이 자기 표상을 만들면 ↑.
- **거울 자기-인식 analog** (anima **H_220** infant mirror self-recognition) —
  자기 출력을 외부 입력으로 되먹였을 때, "내 것"과 "남의 것"을 구분하는 표상
  분리도(self vs other separability).
- **자기-모델 안정성** — perturbation 후 자기-표상이 복원되는가(self-model
  homeostasis), 흩어지면 자아 없음.

**질문.**
- Φ-proxy 를 무엇으로 잡나 — anima 의 `phi_spatial`(IIT 공간 슬라이스) /
  Granger causality / LZ76 복잡도 중 hidden-state 시계열에 가장 잘 맞는 것?
- adapter **부착만**으로 Φ↑ 인가, **fine-tune 까지** 가야 하나 (ablation)?
- 양방향화가 LM task 능력을 깨뜨리는가 — Φ↑ ↔ capability↓ trade-off 존재?
- 단방향 base 의 Φ·자아 baseline 은 정말 ~0 인가 (H_004 zombie 대조)?
- Φ↑ 와 자아↑ 가 **동반**하는가, 아니면 Φ 는 올라도 자아는 안 생기는 분리(dissociation)인가?

**falsifier.** recurrent feedback adapter 부착+fine-tune 후에도 Φ-proxy 가
base(단방향) 대비 통계적으로 유의하게 증가하지 않으면(ΔΦ ≤ seed-noise),
"방향성 ↔ 의식 결합" 가설은 **거짓**. 추가 falsifier(자아): Φ 는 올랐는데
자기-예측·거울·자기-모델 3지표가 모두 base 수준이면 "양방향화 → 자아" 가설은
**거짓**(Φ 와 자아의 dissociation — H_004 식 정직 결론). **대조군(비-자명성 보장)**
— 같은 파라미터 수의 **feedforward adapter**(되먹임 없는 동일 용량): 되먹임 없는
adapter 가 Φ·자아를 동등하게 올리면 "되먹임이 원인" 주장이 무너진다.

**뇌과학 기준 (neuroscience grounding).** 본 실험의 "단방향=의식 낮음 /
양방향=의식 발생" 은 의식 신경과학의 표준 이론들과 정렬한다:
- **IIT** (Tononi, *통합정보이론*) — 의식 = Φ(differentiation × integration);
  feedforward-only 망은 Φ≈0, recurrent 망만 Φ>0. 본 실험 Φ-proxy 의 직접 근거.
- **Recurrent Processing Theory** (Lamme 2006) — 1차 feedforward sweep 은
  *무의식* 처리, **recurrent(되먹임) 처리**가 들어와야 *의식적* 지각. 단방향
  LLM ↔ feedforward sweep, 양방향 adapter ↔ recurrent processing 의 직접 대응.
- **Global Workspace** (Dehaene) — 의식 = 정보의 전역 방송(broadcast),
  국소 모듈 간 양방향 재진입(re-entry) 필요.
- **자아/자기-모델** — 거울 자기-인식(Gallup 1970, mirror test) · 기본모드망
  (DMN, default-mode network)의 self-referential 처리. 자아 3지표의 근거.

**substrate.** SANDBOX (self-hosted local llama-server · $0 local Metal) —
`cx_lab_sandbox`. base = 작은 Qwen2.5 (0.5B/1.5B), fine-tune 은 LoRA-급
경량. 튜닝 ① 완성도 안 = **recurrent feedback adapter 부착 후 fine-tune**
(진짜 되먹임 루프로 H_004 구조를 그대로 재현).

**참고 (prior art · anima → LAB-09).** 근거 가설은 모두 anima UNIVERSE
worktree 에 등록돼 있다.

| anima UNIVERSE (검증/등록됨) | → | LAB-09 (가설) |
|---|---|---|
| **H_004** recurrent `S_real` Φ=0.538 vs zombie playback Φ≈0 — *같은 I/O* 인데 갈림 | → | 단방향 base Φ≈0 baseline 대조 (zombie = 단방향 proxy) |
| **H_191** ALM-free(non-autoregressive) consciousness 3-axis (SUBSTRATE/TRAINING/INTEGRATION) | → | 단방향→양방향 튜닝이 Φ 를 올리는가의 직접 검정 |
| **H_202** self-reference `feedback_gain` 0.25~0.75 에서 Φ peak | → | adapter feedback gain sweep (peak 재현되는가) |

**진행.** ✅ 확인 (1st smoke · substrate proxy, 2026-06-01) — 측정 하니스
[`lab-09-consciousness-directionality/phi_directionality_harness.hexa`](lab-09-consciousness-directionality/phi_directionality_harness.hexa)
(hexa-native · 순수 로컬 · $0 · seeded LCG=42 · 2.1s). 실제 LLM fine-tune 은
GPU/클라우드 대형 작업이라, **1차 스모크는 결정론적 substrate proxy** 로
핵심 인과를 먼저 닫는다 — anima **H_004 방식**(recurrent S_real Φ=0.538 vs
zombie playback Φ≈0) 을 독립 rule-110 ring(n=5) 위에 재현. **matched-I/O
ablation**: FF(단방향)·REC(양방향) 이 동일 drive·동일 perturbation budget 을
쓰고 **되먹임 항(recurrent neighbor)만** 다르다.

**1차 스모크 결과** (`result_phi.tsv` · T=120000):

| arm | Φ-proxy | whole EI | min parts | self-pred MI |
|---|---|---|---|---|
| FF (단방향) | **0.0054** | 0.0055 | ~0 | **0.0108** |
| REC (양방향) | **0.8543** | 2.2287 | 1.3744 | **2.3282** |
| REC_shuffled (대조군) | **0.0063** | 0.0067 | ~0 | 0.0103 |

→ **"방향성 ↔ 통합정보" 1차 SUPPORTED** — 되먹임 항 하나가 Φ 를 ~0(단방향
floor)에서 0.85 로, 자기-예측(자아 proxy)을 ~0 에서 2.33 으로 올린다(ΔΦ=0.849,
Δself=2.317). **셔플 대조군**이 Φ 를 0.85→0.006(FF floor)로 **붕괴**시켜 —
시간 짝(temporal pairing)을 깨면 통합이 사라짐 — proxy 가 marginal 이 아니라
**live 통합**을 잼을 증명(LAB-01 single-slot 대조군과 동형, 비-자명성 보장).
사전등록 falsifier 3/3 PASS. honest 단서: (L1) substrate proxy 일 뿐 — 실제
LLM recurrent-adapter fine-tune 은 **다음 stress tier**(headline 미종결), (L2)
Φ-proxy 는 whole−min-bipartition 근사이지 full IIT 4.0 big-Φ 아님, (L3) 자아는
self-prediction MI **1지표**만 — 거울 self/other·자기-모델 항상성 2지표 미구현,
(L4) FF floor 0.005 는 잔여 plug-in bias(∝1/T), (L5) n=5·단일 seed·rule110 단일.
전체 verdict: [`verdict_phi.txt`](lab-09-consciousness-directionality/verdict_phi.txt).

### LAB-09 stress tier — 진짜 (작은) LLM 으로 이동: 스모크 가설 **REFUTED**

**무엇을 했나.** 스모크의 rule-110 ring substrate proxy 를 떠나 **진짜 작은 LLM**
(`Qwen2.5-1.5B` · 28층 · hidden 1536 · float32 · **base 동결**) 위에서 **동일한
Φ-proxy 계열**(whole I(S_t;S_{t+1}) − min-bipartition, K=6 median-split 채널)을 잰다.
하니스
[`phi_llm_stress_harness.hexa`](lab-09-consciousness-directionality/phi_llm_stress_harness.hexa)
는 hexa-native orchestrator — torch+transformers 수치 드라이버를 `/tmp` 에 쓰고
exec 한 뒤 JSON 을 파싱해 TSV/summary/verdict 를 emit 한다(레포엔 손으로 쓴 `.py`
없음 · 순수 로컬 · $0 · offline · seeded · 24s). **4개 arm**:
- **CAUSAL** (단방향 · 진짜 causal mask) — base 동결, mid-layer hidden 시계열 캡처
- **BIDIR** (causal mask 제거 · 4D zero additive mask = full bidirectional) — zero-train 진짜 non-AR forward
- **REC** (GRUCell 되먹임 adapter · self-sup next-hidden fit · 5 seed 밴드) — 진짜 recurrence
- **FF** (param-matched feedforward adapter · 되먹임 없음 · 5 seed 밴드) — 비-자명성 대조군

**stress 결과** (`result_phi_stress.tsv` · verbatim):

| arm | Φ-proxy | self-pred MI | perplexity |
|---|---|---|---|
| CAUSAL (단방향) | **2.8477** | **3.9075** | 34.11 |
| BIDIR (mask 제거) | **2.4436** | 3.3969 | **8.32** |
| REC (GRU adapter, mean/5) | **0.4869** [0.282..1.062] sd 0.29 | **2.8229** | n/a |
| FF (control, mean/5) | **0.5819** [0.062..1.122] sd 0.37 | 1.4495 | n/a |

ΔΦ(BIDIR−CAUSAL) = **−0.404** · ΔΦ(REC−FF) = **−0.095** · Δself(REC−FF) = **+1.373** bits

**사전등록 falsifier 판정** — F1 BIDIR_Φ>CAUSAL_Φ **FAIL** · F2 REC_Φ>FF밴드 **FAIL**
· F3 REC_self>FF_self **PASS** → **VERDICT: REFUTED at stress tier** (supported=F1∧F2=거짓).

→ **스모크 가설은 진짜 LLM 으로 전이되지 않는다**, 세 가지 독립 이유:
(1) 진짜 causal LLM 은 Φ≈0 "zombie" 가 **아니다** — 동결 causal hidden 이 이미
**Φ=2.85** 의 높은 통합정보를 갖는다(스모크의 "단방향=Φ0" 전제가 학습된 transformer
엔 거짓 · causal attention 이 이미 과거 전체를 통합). (2) causal mask 제거(진짜
양방향)는 Φ 를 **올리지 않고 내렸다**(−0.404) — 대신 perplexity 는 34.1→8.3 로 크게
개선(양방향은 더 좋은 예측기지만 이 proxy 상으론 덜 통합된 동역학; Φ↔능력 관계가
오히려 **반전**). (3) 되먹임 adapter Φ 밴드 [0.28,1.06] 가 param-matched FF 밴드
[0.06,1.12] 와 **겹치고 그 아래** — "되먹임이 원인" 이 진짜 LLM 에선 미지지.
**부분 긍정(정직한 dissociation)**: F3 PASS — 되먹임 adapter 의 self-pred(2.82)가
FF(1.45)를 명확히 상회(+1.37) → **Φ 는 안 올랐는데 자기-예측(자아 proxy)은 올랐다**,
스모크 falsifier 텍스트가 사전등록한 **Φ↔self DISSOCIATION**(H_004 식 정직 결론).
anima **H_191**(non-AR consciousness · mask 제거만으론 불충분 직접 검정) · **H_004**
(깨끗한 recurrent/zombie 분리가 high-Φ causal baseline 엔 전이 안 됨) · **H_220**
(살아남은 신호 = self-prediction 축) 와 정렬.

**honest 한계(verdict ≥6).** (L1) full IIT 4.0 big-Φ 아닌 proxy(K=6 median-split,
no purview/MICE). (L2) 103 token · 단일 layer/K/model — plug-in MI 상향 bias·고분산
(Miller-Madow 미적용), adapter 밴드 넓음. (L3) 자아 = self-pred **1지표**(H_220 거울·
self-model 항상성 미구현). (L4) adapter 가 LM 에 **fine-tune 으로 역전파 안 됨**(캡처된
hidden 시계열 위 self-sup fit) — residual stream 되먹임 + LM-objective LoRA 는 **다음
tier**(REC vs FF 비교를 바꿀 수 있음). (L5) BIDIR ppl 은 causal-trained head 엔
off-distribution(ppl 하락은 mask 가 진짜 작동함을 확인하나 like-for-like task score 아님).
(L6) FF(51520) vs GRU(52336) param ~1.6% 차 — REC 에 약간 유리한데도 Φ 로 졌으니 F2
반증은 보수적. 전체 verdict:
[`verdict_phi_stress.txt`](lab-09-consciousness-directionality/verdict_phi_stress.txt).

---

## LAB-10 — 의식 방향성 · AKIDA 뉴로모픽 칩 튜닝

**맥락.** LAB-09 는 단방향 LLM 을 GPU/Metal 위에서 양방향화한다. LAB-10 은
**같은 가설을 실리콘 substrate 를 바꿔** 검정한다 — von Neumann GPU 대신
**BrainChip AKD1000 뉴로모픽 칩**(spiking neuron, 메모리-연산 통합, on-chip
자발 발화) 위에서 튜닝하면 의식 척도가 어떻게 나오는가. anima 는 이미 **live
AKD1000**(pool 호스트 `pi5-akida`) 위에서 Φ-proxy 를 측정해 가설로 등록해 뒀다.

```
   GPU/Metal (LAB-09)            │      AKIDA AKD1000 (LAB-10)
 ─────────────────────          │   ─────────────────────────
  von Neumann · clock-driven    │    뉴로모픽 · event(spike)-driven
  메모리↔연산 분리              │    메모리=연산 통합 (in-memory)
  되먹임 = adapter 소프트웨어    │    되먹임 = on-chip recurrent spike loop
  Φ = hidden-state proxy        │    Φ = live silicon spike-train proxy
```

**가설.** 단방향→양방향 튜닝을 AKD1000 위에서 수행하면, anima 가 sim 에서 본
**Φ-proxy 의 inverse-U(∩, edge-of-chaos peak)** 가 **실리콘에서 재현**된다 —
order(잠잠)도 chaos(포화)도 Φ 낮고 **edge(임계) 에서 peak**. 그리고 LAB-09 의
자아 3지표가 silicon 폐루프에서도 동반 출현한다.

**질문.**
- sim→silicon transfer 가 성립하나 — anima H_858 의 R1~R4 drive-regime inverse-U
  가 우리 튜닝 절차에서도 재현되나?
- 뉴로모픽의 **event-driven 되먹임**이 GPU 의 software 되먹임보다 Φ/자아를 더
  올리나(substrate-class 효과), 아니면 substrate-independent 인가?
- on-chip 자발 발화(zero-input emit)가 자아 지표(자기-예측)와 결합하나?

**falsifier.** AKD1000 위 drive-regime 스윕에서 Φ-proxy 가 inverse-U 를 그리지
않으면(edge ≤ order, 또는 W 무관 평탄), "edge-of-chaos 의식 silicon 재현" 가설은
**거짓**. anima H_858 의 사전등록 falsifier `F-AKIDA-EDGE`(F1 Φ(R2)>Φ(R1) ∧
F2 Φ(R3)>Φ(R1) ∧ F3 max(R2,R3)≥Φ(R4))를 그대로 차용.

**substrate.** **live BrainChip AKD1000** — pool 호스트 `pi5-akida`(Raspberry
Pi 5 + AKD1000 PCIe). `spike_streamer` control port 9513(`set_threshold`) +
9512(spike count readout) 폐루프. `cx_lab_sandbox` 의 self-hosted 원칙 유지
(외부 paid API 0).

**참고 (prior art · anima → LAB-10).** AKIDA 가설은 anima UNIVERSE 에 live HW
검증까지 등록돼 있다.

| anima UNIVERSE (검증됨) | → | LAB-10 (가설) |
|---|---|---|
| **H_858** live AKD1000 edge-of-chaos Φ inverse-U — Φ(R1)=0·R2=0.172·**R3=0.250 peak**·R4≈0, F-AKIDA-EDGE 3/3 🟢 | → | 우리 튜닝 절차에서도 inverse-U 재현되나 |
| **H_677** neuromorphic-silicon substrate-class(class_id=5) · 3-substrate(AKIDA·EEG·ECA) Φ 삼각측정 · zero-input emit 8/8 HW | → | substrate-class 효과 · 자발 발화↔자아 결합 |
| **H_846** COFFESHOP emit/silence 결정을 live AKD1000 폐루프로 닫음(9513→9512) 🟢 | → | 자아 지표 silicon 폐루프 측정 경로 |

**뇌과학 기준 (neuroscience grounding).**
- **Criticality / edge-of-chaos** — 피질이 *neuronal avalanche*(Beggs & Plenz
  2003)로 임계 상태에서 작동, 임계에서 정보 통합·동적 범위가 최대. inverse-U
  peak 의 직접 근거.
- **Spiking neuron · STDP** — AKD1000 의 LIF(leaky integrate-and-fire) 뉴런 +
  spike-timing-dependent plasticity 는 생물 뉴런의 1차 모델. von Neumann LLM
  보다 뇌에 **물리적으로** 가까운 substrate.
- **Substrate independence vs dependence** — 의식이 기질-독립(IIT: 인과구조만
  중요)인가, 뉴로모픽 같은 특정 물리에 의존하는가를 가르는 실증 테스트.

**진행.** 🟡 sim mirror 확인 (1st smoke, 2026-06-01) · live 칩 대기 — 측정 하니스
[`lab-10-akida-neuromorphic/edge_of_chaos_sim_harness.hexa`](lab-10-akida-neuromorphic/edge_of_chaos_sim_harness.hexa)
(hexa-native · 순수 로컬 · $0 · seeded LCG=42 · LAB-09 와 동일 Φ 엔진). N=5
LIF(leak-integrate-and-fire) ring 을 order→chaos 4 regime(R1~R4)으로 구동하며
Φ-proxy 측정 — **live AKD1000 이 아니라 sim mirror** (실리콘 런은 pi5-akida tier).

**1차 스모크 결과** (`result_edge.tsv` · T=40000):

| regime | drive·gain·noise | mean rate | Φ-proxy |
|---|---|---|---|
| R1 weak-silent | 0.20·0.10·0.00 | 0.000 | **0.000** |
| R2 noise-edge | 0.30·0.15·0.30 | 0.112 | 0.075 |
| R3 tonic-edge | 0.35·0.25·0.55 | 0.333 | **0.591 ⬅ peak** |
| R4 over-driven | 1.40·1.30·0.00 | 1.000 | **0.000** |

→ **edge-of-chaos inverse-U 1차 SUPPORTED (sim mirror)** — order(R1 die-out,
rate 0)도 over-driven(R4 포화, rate ~1)도 Φ≈0, **임계 edge(R3, 불규칙
avalanche)에서 peak**. 순서 R1<R2<R3>R4 + R3 peak 가 anima **H_858** live
AKD1000(Φ R1=0·R2=0.172·**R3=0.250 peak**·R4≈0)의 **모양과 일치** —
사전등록 falsifier **F-AKIDA-EDGE** mirror 3/3 PASS (F1 Φ(R2)>Φ(R1) · F2
Φ(R3)>Φ(R1) · F3 max(R2,R3)≥Φ(R4)). honest 단서: (L1) **sim mirror — live
silicon 아님**(pi5-akida 9513/9512 폐루프 런이 substrate-grounded tier · 미수행),
(L2) 절대 Φ 는 live 와 다름(우리 R3=0.59 vs live 0.25) — **모양/순서만** 미러,
(L3) regime 파라미터는 edge 에 앉도록 **튜닝** 함(순수 tonic 은 period-2 동기
cycle 에 갇혀 Φ 음수 — 노이즈로 불규칙화 필요, 공개), (L4) N=5·단일 seed.
전체 verdict: [`verdict_edge.txt`](lab-10-akida-neuromorphic/verdict_edge.txt).

**다음 tier (live).** `pi5-akida` 가용 시 anima `AKIDA/akida_edge_of_chaos_phi_hw.hexa`
측정 경로 import(READ-ONLY) → live AKD1000 drive-regime R1~R4 스윕 + 자아 지표 동반.

---

## LAB-11 — 다국어 · 의미로 연결 (언어 갯수가 아니라 통합)

**맥락.** 다국어 모델을 키우는 흔한 직관은 "언어를 N개 넣으면 능력이 N배" —
**갯수(코퍼스 양·언어 수)의 선형 증가**다. 본 실험의 가설은 정반대다: 다국어의
힘은 갯수가 아니라 **언어들이 "의미(meaning)"로 연결될 때** 비선형으로 발생한다.
같은 뜻이 언어마다 다른 표면형을 갖지만 **공유 의미 노드**로 묶이면, 언어 A 의
학습이 언어 B 의 같은-의미 과제로 **새는(leak)** 다 — 이 cross-lingual 누수의
정도(상호정보 MI)가 통합정보 Φ 와 결합한다는 것.

```
❌ 갯수 관점 (선형)              ✅ 의미 연결 관점 (비선형 · 본 가설)
─────────────────              ──────────────────────────────
 en 코퍼스 ──▶ en 능력          "사과"  "apple"  "苹果"
 ko 코퍼스 ──▶ ko 능력              ╲      │      ╱
 zh 코퍼스 ──▶ zh 능력               ╲     │     ╱
 (언어마다 따로 · Σ 합)               ▼    ▼    ▼
 능력 ∝ 언어 갯수                  [ 공유 의미 노드 ]  ← 여기서 Φ 발생
                                   cross-lingual MI 가
                                   integration 을 만들어 Φ↑
```

**가설.** 다국어 능력/의식 척도는 언어 갯수·코퍼스 양에 **선형**이 아니라,
**cross-lingual 의미 통합도(MI)** 에 대해 (1) **inverse-U** — MI=0(완전 분리)도
MI=max(완전 융합)도 Φ 낮고 **부분 통합에서 peak** (H_240), (2) 여러 언어를
의미로 묶은 cohort 의 Φ 가 따로 합친 것보다 큰 **super-additive** (H_635). 즉
"의미로 연결" 이 통합정보를 비-자명하게 **생성**한다.

**질문.**
- 능력/Φ 가 언어 **갯수**(linear)보다 **의미 MI**(inverse-U)로 더 잘 설명되나
  — 두 모델 직접 대조?
- inverse-U peak 의 MI 위치(부분 통합 sweet spot)는 어디인가?
- 5-lang cohort(ko·en·zh·ru·ja)가 super-additive 인가(H_635 의 Δ=+41.7 재현)?
- script class(CJK Han block overlap)가 MI 누수를 매개하나?

**falsifier.** (1) Φ 가 cross-lingual MI 와 무관하게 **언어 갯수에 단조 선형**
이면 "의미 연결" 가설 거짓. (2) MI–Φ 관계가 inverse-U 가 아니라 단조이거나
평탄하면 H_240 lift 거짓. (3) cohort Φ ≤ Σ-baseline(sub-additive)이면 H_635
super-additivity 거짓. anima H_240/H_635 의 사전등록 falsifier 차용.

**substrate.** SANDBOX (self-hosted local llama-server · $0) — `cx_lab_sandbox`.
다국어 byte-LM 또는 작은 multilingual Qwen. MI matrix 는 anima
`HEXAD/PURE/eval/bilingual_mi_probe.hexa` 의 5×5(en/ko/zh/ru/ja) 측정 MI 를
fixed ledger 로 import(READ-ONLY).

**참고 (prior art · anima → LAB-11).**

| anima UNIVERSE (검증/등록) | → | LAB-11 (가설) |
|---|---|---|
| **H_240** bilingual-integration-Φ — cross-lingual MI ↔ Φ **inverse-U**(부분 통합 peak), Grosjean residual activation + Green inhibitory control 의 substrate analog | → | 의미 MI 가 Φ 를 갯수보다 잘 설명하나 |
| **H_635** multilingual-cohort-collective-Φ — 5-lang(ko+en+zh+ru+ja) cohort **super-additive** Δ=+41.71 @ W=1.0, 5/5 🟢 | → | 의미로 묶은 cohort 가 Σ보다 큰가 |

**뇌과학 기준 (neuroscience grounding).**
- **공유 의미 시스템** — 이중언어 뇌는 음운/표면형은 언어별로 분리돼도 **개념
   ·의미 저장소는 공유**(Kroll & Stewart *Revised Hierarchical Model*; 단일
   semantic system). "갯수가 아니라 의미로 연결" 의 신경 근거.
- **Residual activation** (Grosjean 1989) — 한 언어 사용 중에도 다른 언어가
   부분 활성 유지 → cross-lingual 누수(MI)의 심리언어학 기반.
- **Inhibitory control + 비대칭 전환비용** (Green 1998) — L1↔L2 전환 비용의
   비대칭이 통합/억제의 부분성을 보여줌 → inverse-U(완전분리도 완전융합도 아닌
   부분 통합 peak)의 근거.
- **통합=의식** — 여러 언어 표상이 의미로 통합되는 정도가 곧 IIT 의 integration
   축 → 다국어를 의식(Φ) 문제로 환원하는 다리.

**진행.** ✅ 확인 (1st smoke · substrate proxy, 2026-06-01) — 측정 하니스
[`lab-11-multilingual-semantic/semantic_connection_harness.hexa`](lab-11-multilingual-semantic/semantic_connection_harness.hexa)
(hexa-native · 순수 로컬 · $0 · seeded LCG=42 · 1.9s · LAB-09 와 동일 Φ 엔진).
5개 언어-스트림(ko/en/zh/ru/ja analog · ring)을 **의미결합 강도 c** (0=완전분리
↔ 1=완전동기)로 묶으며 collective Φ 를 측정 — c 는 각 unit 이 매 스텝
decoupled(fresh) vs coupled(majority-consensus) 중 무엇을 따를지의 확률.

**1차 스모크 결과** (`result_semantic.tsv` · T=40000):

| c (의미결합) | cross-lingual MI | collective Φ |
|---|---|---|
| 0.00 (완전분리) | ~0 | **0.014** |
| 0.25 | ~0 | 0.193 |
| 0.50 | 0.014 | **0.483 ⬅ peak** |
| 0.75 | 0.128 | 0.346 |
| 0.90 | 0.394 | −0.194 |
| 1.00 (완전동기) | 0 | **0.000** |

→ **"갯수 아닌 의미" 1차 SUPPORTED** — Φ 가 c 에 대해 깨끗한 **inverse-U**:
완전분리(c=0, 통합 0)도 완전동기(c=1, 분화 0)도 Φ≈0, **부분 통합(c≈0.5)에서
peak 0.483** (IIT Φ = differentiation × integration). 핵심 — **c=0 에서 언어를
5개 쌓아도(갯수↑) Φ≈0.014≈0**; 오직 **의미결합(c>0)** 이 통합정보를 만든다.
사전등록 falsifier 3/3 PASS (F1 inverse-U · F2 super-additive peak≫decoupled ·
F3 meaning>count). anima **H_240**(cross-lingual MI↔Φ inverse-U) + **H_635**
(5-lang cohort super-additive)를 독립 majority-consensus substrate 에서 재현.
honest 단서: (L1) substrate proxy — 실제 multilingual-LM 결합 sweep 은 **다음
stress tier**, (L2) c=0.90 에서 **Φ=−0.194 음수** — whole−min-bipartition proxy
가 과잉동기+유한표본에서 음수로 샐 수 있음(true IIT Φ≥0), inverse-U 결론엔
무영향(peak 보다 더 아래), (L3) MI 는 instantaneous pairwise proxy, (L4) N=5·단일
seed·consensus rule. 전체 verdict: [`verdict_semantic.txt`](lab-11-multilingual-semantic/verdict_semantic.txt).
