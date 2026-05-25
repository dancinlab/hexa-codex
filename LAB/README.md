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

**상태 범례** — ⬜ 대기 · 🔵 진행중 · ✅ 확인(가설 참) · ❌ 반증(가설 거짓) · ⏸ 보류 · 🎓 도메인 졸업(SSOT가 LAB 하위 `lab-NN-*/<NAME>.md`)

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
