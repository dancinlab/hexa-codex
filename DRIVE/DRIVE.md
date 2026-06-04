# DRIVE — 모델 시승 카트

@title: 🛺 DRIVE — "모델 시승 카트"
@goal: **로컬 GGUF 모델을 손으로 직접 몰아보는 최소 시승 REPL.** 멀티턴 채팅 + `/build` 단일파일 자가완성 + 진입 폴더(cwd) 인식. **최소기능 유지 — 기능은 유저가 명시할 때만 추가** (project.tape `@D cx_drive_minimal`). 에이전트의 기능 제안·자동 추가·feature-creep 금지.

> 이 문서는 DRIVE **CLI 패키지**(`DRIVE/drive.hexa`)의 진행 기록부다. 코드 자체가 아니라 "무엇이 들어갔고, 무엇을 더 넣을지(=유저 명시분만)"를 추적한다.

## 최소기능 유지 법칙 (`cx_drive_minimal`)

> DRIVE 는 풀 에이전트(Claude/Codex TUI)가 아니라 **가벼운 시승 카트**로 유지한다.
> 기능은 **유저가 명시적으로 이름 댄 것만** 추가. "X 얹을까요?" 식 제안·자동 추가·feature-creep 금지.

```
DRIVE 자체 (자동차)          이 문서 (정비 기록부)
┌──────────────────┐        ┌────────────────────────┐
│ drive.hexa 코드   │   ⊥    │ @goal · 구현됨 · open   │
│ → 실제로 굴러감    │        │ → 무엇을 더 넣을지 추적 │
└──────────────────┘        └────────────────────────┘
   기능 = 유저 명시분만 (에이전트 제안 ✗)
```

## 구현된 기능 (shipped — 사실 기록, 제안 아님)

- [x] 멀티턴 채팅 REPL — `messages[]` 누적, 직전 대화 컨텍스트 이어짐 (7→17 검증) · PR #135
- [x] `/build <목표>` 단일파일 자가완성 — 생성→실행→자가수정 (최대 5회), 결과는 cwd `program.py` · PR #135
- [x] `/edit <파일> <지시>` 파일 실제 수정 — 모델이 새 전체 내용 반환, `.bak` 백업 후 덮어씀 (셸 exec 안 함, 안전). 유저 명시 요청 · live 검증 (note.txt 1a2)
- [x] 자연어 자동 처리 — `/edit` 없이 평문 지시만으로 파일 수정 (모델이 `@@EDIT <path>: <instr>` 라우팅 → `edit_file` 2-패스, 기존 내용 보존). 유저 명시 요청 · 5/5 패턴 통과 (create·append·replace·no-trigger·multiline)
- [x] git 자연어 — `@@COMMIT`/`@@PUSH`/`@@PR`(gh) 디렉티브로 커밋·푸시·PR. **force 구조적 차단** (drive 가 고정 플래그로 명령 빌드 · `--force` 코드 경로 없음 · 모델은 데이터만). 유저 명시 요청 · live 검증 (commit/push 성공 · diverged push rejected)
- [x] git 브랜치 자연어 — `@@BRANCH: <name>` 디렉티브로 `git checkout -b <name>` (새 브랜치 생성+전환). `@@BRANCH`→`@@COMMIT`→`@@PUSH` 순으로 조합되어 "별도 브랜치 만들어 커밋·푸시"가 자연어만으로 가능. force 차단 동일 (고정 플래그 · 모델은 브랜치명 데이터만). 유저 명시 요청 · 100-sim 샌드박스(로컬 bare origin) 검증
- [x] 액션 후 LLM 한 문장 응답 + `✓ 완료` 마커 — 라우팅 콜은 디렉티브만(안정), 실행 후 system-free 요약 콜로 한국어 응답 (5/5 회귀 없음)
- [x] 모델 선택 — `drive <name>` · `--model` · `--list` · 런타임 `/model` 전환 · PR #137
- [x] 진입 폴더(cwd) 인식 — 파일목록을 system 메시지로 주입 · PR #138
- [x] 기본 모델 `supergemma4-e4b-abliterated-Q4_K_M` + 색상 연결 문구 · PR #139
- [x] 인터랙티브 stdout flush 근본 수정 — hexa-lang `exec_replace` (fd 상속) upstream · PR #140 / hexa-lang #1898
- [x] 자연어 디렉티브 컴플라이언스 강화 — system few-shot + 산문답 시 "디렉티브만(else NONE)" 폴백 콜 1회 → 작은 로컬모델의 @@EDIT/@@git 라우팅 신뢰도↑. 유저 명시 요청 · 100-sim 관찰 기반
- [x] no-op 편집 자동 재시도 — 재작성이 원본 그대로면(모델이 변경 누락) 강조 프롬프트로 1회 재시도. 유저 명시 요청 · 100-sim 관찰 기반
- [x] fix-recipe RAG — `fix_recipes.txt` 지식베이스에서 지시문 키워드로 레시피 검색 → edit 프롬프트에 grounding 주입(reverse→`s[::-1]`·`a*b+1`·factorial range n+1·return 누락 등). 누락 파일 graceful. 유저 명시 요청 · 하드 archetype 6/6 PASS 검증

## 열린 기능 (open)

> **비어 있음.** 새 기능은 유저가 명시할 때만 추가한다 (`cx_drive_minimal`). 에이전트 자가 제안 금지 — 진행바 "현재 명시 기능 전부 구현" 상태이며, 종료가 아니라 유저 명시 대기다.

## 산출물

| 항목 | 위치 |
|---|---|
| 코드 | `DRIVE/drive.hexa` |
| 패키지 manifest | `DRIVE/hexa.toml` (`hx install ./DRIVE` → `drive` 셸) |
| 사용 문서 | `DRIVE/README.md` |
| 설치본 | `~/.hx/bin/drive` |
