# DRIVE — log

`DRIVE.md` 의 append-only 기록 자매 문서. 각 엔트리는 `## <ISO timestamp> — <header>` (최신이 위); 본문 = `- [x]` (완료) / `- [ ]` (대기) 체크박스.

## 2026-05-28 — git(commit·push·PR) + LLM 응답·완료 메시지 (유저 명시 요청)

- [x] git 디렉티브 — `@@COMMIT: <msg>` (`git add -A` + commit) · `@@PUSH` (`git push -u origin HEAD`) · `@@PR: <title>` (`gh pr create`). `run_git` 헬퍼가 rc + 출력 보고. 멀티 디렉티브 한 turn 처리.
- [x] force 차단 (유저 명시 "force 막아줘") — drive 가 고정 플래그로 명령을 빌드, 모델은 shq-quote 된 데이터(메시지·제목)만 → `--force` 주입 불가. `--force` 코드 경로 없음(grep 확인). live: diverged history push → `[rejected] non-fast-forward`, remote SHA 불변.
- [x] LLM 응답 + `✓ 완료` (유저 명시 "완료 메시지 없음 · LLM 응답 필요") — 라우팅 콜은 "디렉티브만"(prose 섞으면 작은 모델이 @@EDIT 중복+플레이스홀더로 파일 망가뜨림 — 실측). 액션 실행 후 system-free 요약 콜로 한국어 한 문장 → `bot >`, 그 뒤 `✓ 완료`.
- [x] 5/5 패턴 회귀 없음 — create·append·replace·no-trigger·multiline 전부 통과, 각 액션에 LLM 응답+완료 동반.

## 2026-05-28 — 자연어 자동 파일 수정 (유저 명시 요청 · 5/5 패턴)

- [x] 자연어 라우팅 — `/edit` 없이 평문 지시로 파일 수정. SYS 가 모델에 `@@EDIT <path>: <instr>` 한 줄을 내도록 지시 → `apply_nl_action` 파싱 → 검증된 `edit_file` 2-패스(실제 내용 읽고 전체 새 버전 생성, `.bak`). 단일-패스 대비 기존 내용 보존.
- [x] 버그 발견+우회 — ` ```drive-edit: ` 코드펜스 SYS 지시가 abliterated gemma 3n 에서 `<|channel>` 특수 토큰 emit → llama-server 500 (`Failed to parse input`). **평문 구분자 `@@EDIT`** 로 전환해 해결. 일반 질문은 평문 답(오작동 0).
- [x] `edit_file` 프롬프트에 리터럴 형식 보존 절 추가 — "config.txt" 를 JSON 으로 변환하던 P5 실패 → `key=value` 리터럴 유지로 수정.
- [x] 5-패턴 시뮬레이션 5/5 통과 — P1 create · P2 append(기존보존) · P3 replace · P4 no-trigger(질문은 파일 안 건드림) · P5 multiline literal.

## 2026-05-28 — `/edit` 파일 수정 (유저 명시 요청)

- [x] `/edit <파일> <지시>` 추가 — 채팅이 파일을 못 고치는 한계("UNCENSORED.md 안 바뀜" 실증)를 유저가 "fix" 지시 → `cx_drive_minimal` 부합 (유저 명시분).
- [x] 안전 설계 — 모델 셸 명령 실행 금지 (abliterated `rm -rf` 방어). 모델은 새 전체 내용만 반환, `.bak` 백업 후 덮어씀. `/build` 와 같은 명시적 디스크 명령 패턴.
- [x] live 검증 — `note.txt` "ORIGINAL LINE" → `/edit ... append EDITED-BY-MODEL, keep original` → 원본 보존 + 새 줄 추가 (diff 1a2), `.bak` 생성.

## 2026-05-28 — 도메인 등록 + 최소기능 법칙

- [x] DRIVE 도메인 등록 — `DOMAINS.tape` 로스터 row + `DRIVE/DRIVE.md` 스냅샷 + 이 로그.
- [x] project.tape `@D cx_drive_minimal` 추가 — 기능은 유저 명시분만, 에이전트 제안·자동추가·feature-creep 금지.
- [x] 구현 기능 사실 기록 (PR #135~#140 · hexa-lang #1898) — 제안이 아니라 이미 들어간 것.
- [ ] open = 비어 있음 — 유저가 명시할 때만 새 기능 추가.
