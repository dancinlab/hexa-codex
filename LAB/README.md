# LAB — 실험실

> hexa-codex 의 자잘한 실험 폴더. 큰 도메인 연구는 루트 도메인 SSOT
> (`LEARNING_PROGRAMMING.md` · `ORCHESTRATION.md` 등)로 가고, 빠르게
> 던져보는 가설 검증·놀이성 실험은 여기로 모은다.
>
> **규칙** — 실험 1개 = 아래 표 1행 + (필요하면) `LAB/<id-slug>/` 하위 폴더.
> 가설은 반드시 **반증 가능(falsifiable)** 하게 적는다.

## 실험 목록

| ID | 실험 | 가설 / 질문 | 상태 | 결과 · 작업물 |
|------|------|------------|------|--------------|
| LAB-01 | LLM 중간 끼어들기 · 유실 없음 | 응답 생성 중 들어온 추가 입력을 큐에 쌓지 않고 라이브로 이어붙여도 메시지가 유실되지 않는 방법이 존재한다 | 🔵 진행중 | — |
| LAB-02 | MITOSIS · 도메인 유사분열 | 도메인 생성 LLM이 포화된 도메인을 자식 N개로 자율 분열시킬 때, 부모 milestone을 유실·중복 0%로 MECE 분배할 수 있다 | ⬜ 대기 | — |

**상태 범례** — ⬜ 대기 · 🔵 진행중 · ✅ 확인(가설 참) · ❌ 반증(가설 거짓) · ⏸ 보류

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

**진행.** 🔵 설계 단계 — 측정 하니스(끼어들기 N회 주입 → 컨텍스트
도달 여부 카운트)부터.

**작업물.** `LAB/lab-01-interrupt-no-loss/` (예정)

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

**진행.** ⬜ 대기 — 측정 하니스(포화 도메인 입력 → 분열 → 부모/자식
milestone 집합 diff 로 유실·중복 카운트)부터.

**작업물.** `LAB/lab-02-mitosis/` (예정)
