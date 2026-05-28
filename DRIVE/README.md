# 🛺 DRIVE — 모델 시승 카트

로컬 GGUF 모델을 `llama-server`에 올려 **대화가 이어지는(멀티턴)** 채팅으로 손맛을 보는
경량 REPL. "이 코드 모델 코딩 잘하나?"를 띄워놓고 바로 물어보는 용도.

## 무겁지 않은 이유

| 축 | Claude / Codex TUI | DRIVE |
|---|---|---|
| 목적 | 실제 작업 수행 | 모델 감 잡기 |
| 구성 | 툴 · 파일편집 · 세션 · 권한 · MCP | 묻고 → 답 |
| 무게 | 풀 에이전트 | 채팅 한 줄 |

비유: 저쪽은 완성차 공장 라인, 이건 주차장에서 한 바퀴 몰아보는 시승 카트.

## 설치

```sh
hx install ./DRIVE      # drive 셸이 ~/.hx/bin 에 생성됨
```

## 실행

```sh
drive                                   # 기본 모델 (Qwen2.5-1.5B-Instruct-Q4_K_M)
drive Qwen2.5-7B-Instruct-Q4_K_M        # ~/Models/gguf 의 다른 GGUF
drive /abs/path/to/model.gguf           # 절대경로도 가능
```

- 처음 실행하면 `llama-server`를 8099 포트에 자동 기동(준비될 때까지 대기).
- 이미 떠 있으면 재사용. **단, 다른 모델로 바꾸려면** 떠 있는 서버를 먼저 종료해야 함:
  `pkill -f 'llama-server.*8099'` 후 `drive <다른모델>`.

## REPL 명령

| 입력 | 동작 |
|---|---|
| (아무 말) | 모델에 질문 — 직전 대화가 컨텍스트로 이어짐 |
| `/build <목표>` | 한 파일짜리 프로그램을 **스스로 완성** (생성→실행→자가수정 루프) |
| `/reset` | 대화 기록 초기화 (새 컨텍스트) |
| `/quit` `/exit` `/q` | 종료 (빈 줄 두 번 또는 Ctrl-D 도 종료) |

## 혼자 완성 — `/build`

목표를 주면 모델이 단일 Python 파일을 **스스로 짜고 → 돌려보고 → 틀리면 고쳐서**
통과할 때까지 반복합니다(최대 5회). 결과물은 `/tmp/drive-build/program.py`.

```
/build print the numbers 1 to 5

[build 1/5] 생성 중...
  ok 통과 (exit 0) — /tmp/drive-build/program.py
  --- 출력 ---
  1
  2
  3
  4
  5
```

- 자가수정 루프라 **모델이 똑똑할수록** 잘 돕니다. 1.5B는 약하니
  `drive Qwen2.5-7B-Instruct-Q4_K_M` 등 큰 모델 권장.
- 실행은 `timeout 15s`(있으면) 안에서 — 무한루프 방어.

> 이 기능을 켜는 순간 DRIVE는 "순수 채팅"을 넘어 **미니 코딩 에이전트**가 됩니다
> (단일 파일 한정 · 도구는 쓰기/실행 2개). 멀티파일 프로젝트는 풀 에이전트 영역.

## 멀티턴이 이어지는 원리

단발 호출이 아니라, 매 턴 전체 `messages[]`를 다시 보냅니다(누적).

```
턴1  you: 피보나치 짜줘    → [user]                → bot: def fib...
턴2  you: 반복문으로 바꿔  → [user, bot, user]     → bot: (앞 코드 기억하고 수정)
```

## 요구 사항

- `llama-server` · `curl` · `jq` (PATH 에 존재)
- `~/Models/gguf/*.gguf` (Qwen2.5 0.5B / 1.5B / 3B / 7B 등)

## 범위

현재는 **(a) 순수 채팅**. 도메인 스모크 자동채점(코드 즉시 실행 ✓/✗ · 수학 정답 대조)은
다음 단계로 얹는다.
