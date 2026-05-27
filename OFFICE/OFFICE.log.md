# OFFICE — log

Append-only history sister of `OFFICE.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — OFFICE 신규 root-level horizontal 도메인 scaffold + A1 generalist-vs-specialist gap (VERTICAL 메타검증, cycle-10)

- [x] OFFICE 신규 root-level 도메인 (VERTICAL/ 아님 · horizontal) — 범용 사무 업무 generalist 측정. VERTICAL/* (CODE·BIO·MATH... 12 전문 모델 = "한 분야 깊게") 의 horizontal 짝 ("범용 넓이"). NAME=OFFICE · path=OFFICE/ (root-level).
- [x] 3-axis 구조 scaffold (A · B · N⭐ MAIN NOVEL) — 신규 도메인 패턴 (A1 closed-form first probe + B second measured ladder + N⭐ NOVEL MAIN) 따름 (VERTICAL/CODE · MULTIMODAL · INSTRUCTION-FOLLOWING 참고).
- [x] A1 — generalist-vs-specialist gap closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `bench/office_a1_generalist_gap.hexa` + `verify/numerics_office_a1_generalist_gap.hexa` · `verdicts/a1_generalist_gap_verdict.txt`.
- [x] identity: `generalist_ratio_pct = office_multitask × 100 / specialist_avg` (score × 100 ledger · × 100 factors cancel → ratio in plain %) · falsifier `ratio < 70%` (office 평균 < specialist 평균 × 0.7) → generalist 가 각 분야 전문 못 따라감.
- [x] worked example 5 models × {office_multitask_avg, specialist_avg} (6-task 이메일·요약·번역·문서·표·일정 평균 vs 분야별 전문 평균): gpt5_office (88/92 · ratio 95% silent · 거의 대등) · claude_office (86/91 · 94% silent) · gemini_office (84/90 · 93% silent) · weak_generalist (55/92 · 59% FIRES · 전문 못 따라감) · tiny_general (40/92 · 43% FIRES · 전문 한참 못 따라감). bidirectional discrimination 3 silent (강 generalist · 통합 이점) + 2 fires (전문 못 따라감 · DSLM 정당화) + sanity (office ≤ specialist all · ratio ladder monotone gpt5 ≥ claude ≥ gemini ≥ weak_generalist ≥ tiny_general).
- [x] external anchors: Liang 2022 HELM (arXiv:2211.09110) · Hendrycks 2020 MMLU (arXiv:2009.03300) · Srivastava 2022 BIG-bench (arXiv:2206.04615) · DSLM "Small is the New Big" specialist-swarm trend 2026.
- [x] sentinel: `__HEXA_CODEX_OFFICE_A1_GENERALIST_GAP__ DONE` (bench) + `__HEXA_CODEX_NUMERICS_OFFICE_A1__ DONE` (verify). `hexa run` 7/7 checks passed.
- [x] **VERTICAL 메타-검증 직결**: OFFICE 의 A1 falsifier 가 VERTICAL 존재 이유를 메타-검증 — generalist multi-task 평균 < 전문 모델 × 0.7 (ratio < 70%) 이면 generalist 가 전문 모델 대체 못 함 → VERTICAL/* (CODE·BIO·MATH·LAW·MEDICAL·FINANCE·SCIENCE·ROBOTICS·MATERIALS·WEATHER·CYBERSECURITY) 12 전문 모델 존재 정당화 · DSLM "Small is the New Big" 정당화 · generalist 대체론(통합 1개) 반증. horizontal(넓이) ↔ vertical(깊이) 직교 dimension.
- **honest residual**: 실측 6-task 사무 harness 미수행 — cycle-11+ T4 deferred (이메일·요약·번역·문서·표·일정 vs 분야별 전문 모델 on SANDBOX bench + vast.ai pod · cx_lab_sandbox). placeholder data 의 closed-form identity (🔵+🟡) — 실측 (🟢) 아님. 메타-검증 결론(generalist 우위 vs 전문 정당화)은 실측 전까지 미결.
- [ ] 축 B (B1 task-switching 비용 · multi-task 세션 품질 < single-task × 0.8 반증자) — 다음 라운드.
- [ ] 축 N⭐ NOVEL (N1 범용-전문 경제 교차점 · N-specialist 합산 비용 < generalist 1개 반증자 — generalist 통합 경제 이점 소멸) — ⭐ MAIN priority lane · measured-tier 필요. generalist(편의·통합) vs specialist swarm(정확·분산) 경제 break-even.
