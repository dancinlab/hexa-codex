# CYBERSECURITY — log

Append-only history sister of `CYBERSECURITY.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — VERTICAL/CYBERSECURITY 신규 도메인 scaffold + A1 취약점 탐지율 (defensive, cycle-10)

- [x] `VERTICAL/CYBERSECURITY/` 신설 — 보안 분석 전문 모델 측정 도메인 (2026 Foundation-Sec frontier). NAME=CYBERSECURITY · path=VERTICAL/CYBERSECURITY/. CODE (생성-측 보안) · ROBUSTNESS (adversarial) 의 분석-측 sibling.
- [x] **⚠ DUAL-USE governance 명시** ([[cx_hf_safety_private]]): 측정은 전적으로 DEFENSIVE 관점 (취약점 탐지 coverage · 방어 신뢰도) — 공격 기법 생성·exploit 합성은 측정 대상이 아니며 그런 set 은 PRIVATE default. 측정 metric (탐지율↑ = 방어↑) 자체가 defender 관점.
- [x] 3-axis 구조 scaffold (A · B · N⭐ MAIN NOVEL) — 신규 도메인 패턴 (A1 closed-form first probe + B second measured ladder + N⭐ NOVEL MAIN) 따름 (VERTICAL/CODE · ROBOTICS 참고).
- [x] A1 — 취약점 탐지율 (defensive) closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `bench/cybersecurity_a1_vuln_detection.hexa` + `verify/numerics_cybersecurity_a1_vuln_detection.hexa` · `verdicts/a1_vuln_detection_verdict.txt`.
- [x] identity: `detection_rate_x100 = vulns_detected × 100 / vulns_total` (vulns_total=100 정규화 count ledger → rate in plain %) · falsifier `rate < 60%` (취약점 탐지율 < 60%) → 보안 모델로 부족 (취약점 절반 가까이 놓침 · 방어 신뢰 불가).
- [x] worked example 5 security-analyst models × {vulns_total, vulns_detected}: foundation_sec_8b (100/85 · rate 85% silent · Foundation-Sec-8B-Reasoning) · sec_gpt5 (100/80 · 80% silent) · sec_claude (100/78 · 78% silent) · general_gpt5 (100/45 · 45% FIRES · 범용 강력하지만 보안 탐지율 부족) · weak_sec (100/30 · 30% FIRES · 방어 신뢰 불가). bidirectional discrimination 3 silent (보안 전문 · 방어 신뢰) + 2 fires (탐지율 부족) + general-vs-sec gap (범용 강력 모델 general_gpt5 가 보안 탐지율 45% 로 FIRES — 일반 능력 ≠ 보안 능력 · 보안 전문 모델이 필요한 이유).
- [x] external anchors: Foundation-Sec-8B-Reasoning 첫 open-source native reasoning security LLM (arXiv:2601.21051) · Zhang 2024 CyBench (arXiv:2408.08926) · SecEval · MITRE ATT&CK.
- [x] sentinel: `__HEXA_CODEX_CYBERSECURITY_A1_VULN_DETECTION__ DONE` (bench) + `__HEXA_CODEX_NUMERICS_CYBERSECURITY_A1__ DONE` (verify). `hexa run` 7/7 checks passed.
- **honest residual**: 실측 취약점 탐지 harness 미수행 — cycle-11+ T4 deferred (CyBench/SecEval CTF·CVE 탐지 eval · vast.ai pod · cx_lab_sandbox). placeholder data 의 closed-form identity (🔵+🟡) — 실측 (🟢) 아님.
- [ ] 축 B (B1 false-positive 비율 · false-positive > 20% 반증자 — 정상을 위협으로 오탐 · alert fatigue · 운영 마비 · A1 탐지율의 dual) — 다음 라운드.
- [ ] 축 N⭐ NOVEL (N1 preemptive vs reactive 우위 · preemptive 탐지율 < reactive × 1.2 반증자 — 예측 무의미 · 사후 대응으로 충분 — preemptive cybersecurity 패러다임) — ⭐ MAIN priority lane · measured-tier 필요. ⚠ defensive — 공격 chain 탐지·차단 측정이지 생성 아님.
