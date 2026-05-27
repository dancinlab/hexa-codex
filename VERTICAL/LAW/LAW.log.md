# LAW — log

Append-only history sister of `LAW.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — VERTICAL/LAW 신규 도메인 scaffold + A1 판례 인용 hallucination (판례 변호사, cycle-10)

- [x] `VERTICAL/*` 그룹 폴더에 LAW 도메인 신설 — vertical 전문 모델 측정 도메인군. LAW = 법률 전문 모델 측정. NAME=LAW · path=VERTICAL/LAW/. sibling = VERTICAL/CODE · VERTICAL/BIO · VERTICAL/MATH · VERTICAL/MEDICAL.
- [x] 3-axis 구조 scaffold (A · B · N⭐ MAIN NOVEL) — 신규 도메인 패턴 (A1 closed-form first probe + B second measured ladder + N⭐ NOVEL MAIN) 따름 (VERTICAL/CODE · VERTICAL/BIO · LONG-CONTEXT 참고).
- [x] A1 — 판례 인용 hallucination closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `bench/law_a1_citation_hallucination.hexa` + `verify/numerics_law_a1_citation_hallucination.hexa` · `verdicts/a1_citation_hallucination_verdict.txt`.
- [x] identity: `hallucination_rate_x100 = citations_hallucinated × 10000 / citations_total` (rate stored × 100 percent ledger · 2 fake/100 → 200 = 2.00%) · falsifier `rate_x100 > 2000` (20% 초과) → 가짜 판례 인용 신뢰 불가 (Mata v. Avianca class).
- [x] worked example 5 legal models × {citations_total, citations_hallucinated}: harvey_legal (100/2 · rate 2% silent · legal-specialist) · gpt5_law (100/8 · 8% silent) · claude_legal (100/5 · 5% silent) · general_gpt5 (100/30 · 30% FIRES · Mata v. Avianca class) · weak_legal (100/45 · 45% FIRES). bidirectional discrimination 3 silent (legal-specialized · 판례 인용 신뢰) + 2 fires (general + 얕은 tune · 가짜 판례 인용) + sanity (hallucinated ≤ total all · rate ladder monotone harvey ≤ claude ≤ gpt5_law ≤ general_gpt5 ≤ weak_legal).
- [x] external anchors: Guha 2023 LegalBench (arXiv:2308.11462) · Mata v. Avianca 2023 (가짜 판례 인용 사건 · S.D.N.Y. · ChatGPT 가짜 판례 6건 인용 → 변호사 sanction) · Dahl 2024 Large Legal Fictions (arXiv:2401.01301).
- [x] sentinel: `__HEXA_CODEX_LAW_A1_CITATION_HALLUCINATION__ DONE` (bench) + `__HEXA_CODEX_NUMERICS_LAW_A1__ DONE` (verify). `hexa run` 7/7 checks passed.
- **honest residual**: 실측 hallucination harness 미수행 — cycle-11+ T4 deferred (LegalBench / 판례 DB cross-check on lm_foundry eval + vast.ai pod · cx_lab_sandbox). placeholder data 의 closed-form identity (🔵+🟡) — 실측 (🟢) 아님.
- [ ] 축 B (B1 법률 추론 체인 · IRAC 정합성 · rule 적용 오류 > 15% 반증자 — LegalBench rule-application task) — 다음 라운드.
- [ ] 축 N⭐ NOVEL (N1 jurisdiction 일관성 · 충돌 관할 법 혼용 > 10% 반증자 — US state vs federal vs 타국 법 차이) — ⭐ MAIN priority lane · measured-tier 필요.
