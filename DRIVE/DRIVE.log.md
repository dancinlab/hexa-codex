# DRIVE — log

`DRIVE.md` 의 append-only 기록 자매 문서. 각 엔트리는 `## <ISO timestamp> — <header>` (최신이 위); 본문 = `- [x]` (완료) / `- [ ]` (대기) 체크박스.

## 2026-05-28 — `/edit` 파일 수정 (유저 명시 요청)

- [x] `/edit <파일> <지시>` 추가 — 채팅이 파일을 못 고치는 한계("UNCENSORED.md 안 바뀜" 실증)를 유저가 "fix" 지시 → `cx_drive_minimal` 부합 (유저 명시분).
- [x] 안전 설계 — 모델 셸 명령 실행 금지 (abliterated `rm -rf` 방어). 모델은 새 전체 내용만 반환, `.bak` 백업 후 덮어씀. `/build` 와 같은 명시적 디스크 명령 패턴.
- [x] live 검증 — `note.txt` "ORIGINAL LINE" → `/edit ... append EDITED-BY-MODEL, keep original` → 원본 보존 + 새 줄 추가 (diff 1a2), `.bak` 생성.

## 2026-05-28 — 도메인 등록 + 최소기능 법칙

- [x] DRIVE 도메인 등록 — `DOMAINS.tape` 로스터 row + `DRIVE/DRIVE.md` 스냅샷 + 이 로그.
- [x] project.tape `@D cx_drive_minimal` 추가 — 기능은 유저 명시분만, 에이전트 제안·자동추가·feature-creep 금지.
- [x] 구현 기능 사실 기록 (PR #135~#140 · hexa-lang #1898) — 제안이 아니라 이미 들어간 것.
- [ ] open = 비어 있음 — 유저가 명시할 때만 새 기능 추가.
