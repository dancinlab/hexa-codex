# OBSERVABILITY — log

Append-only history sister of `OBSERVABILITY.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — 신규 단독 도메인 scaffold + A1 drift-detection latency (orchestra Observability 흡수, cycle-10)

- [x] orchestra-research 20-skill 누락 흡수 sweep 에서 "Observability" 카테고리가 기존 hexa-codex 도메인에 흡수처 없음 → 신규 단독 도메인 OBSERVABILITY ("관제탑") 으로 승격.
- [x] 3-axis 구조 scaffold (A · B · N⭐ MAIN NOVEL) — 신규 도메인 패턴 (A1 closed-form first probe + B second measured ladder + N⭐ NOVEL MAIN) 따름 (DATA-QUALITY · MULTIMODAL · LONG-CONTEXT 참고).
- [x] A1 — drift detection latency closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `bench/observability_a1_drift_detection.hexa` + `verify/numerics_observability_a1_drift_detection.hexa` · `verdicts/a1_drift_detection_verdict.txt`.
- [x] identity: drift 감지까지 걸린 batch 수 · falsifier `falsifier_fires = (drift_magnitude > 10%) AND (detection_latency > 1 batch)` → 큰 drift 인데 1 batch 안에 못 잡음 → silent degradation 놓침 (관제 실패).
- [x] worked example 5 monitoring scenarios × {drift_magnitude, detection_latency}: good_fast (25% drift · 1 batch · silent · good-monitor 즉시) · good_med (15% drift · 1 batch · silent) · low_drift (5% drift · 3 batch · silent · 작은 drift ≤ 10% 무해) · blind_big (30% drift · 4 batch · FIRES) · blind_med (18% drift · 2 batch · FIRES). bidirectional discrimination 2 FIRES (blind-monitor · 큰 drift 늦게 감지 · 관제 실패) + 3 silent (good-monitor 즉시 감지 + 작은 drift 무해) + conjunction sanity (큰 drift 단독·느린 latency 단독 둘 다 silent — silent degradation = 큰 변화 AND 늦게 잡힘).
- [x] external anchors: Quinonero-Candela 2009 Dataset Shift in Machine Learning (MIT Press) · Gama 2014 A Survey on Concept Drift Adaptation (ACM CSUR · DOI:10.1145/2523813) · Breck 2017 The ML Test Score (Google · production ML monitoring readiness) · Klaise 2020 Monitoring and explainability of models in production (arXiv:2007.06299).
- [x] sentinel: `__HEXA_CODEX_OBSERVABILITY_A1_DRIFT_DETECTION__ DONE` (bench) + `__HEXA_CODEX_NUMERICS_OBSERVABILITY_A1__ DONE` (verify).
- **honest residual**: 실측 production monitoring trace 미수행 — cycle-11+ T4 deferred (PSI/KL drift detector batch-level alert latency on streaming eval · lm_foundry + vast.ai pod · cx_lab_sandbox). placeholder data 의 closed-form identity (🔵+🟡) — 실측 (🟢) 아님.
- [ ] 축 B (B1 metric coverage · TTFT·TPOT·tok/s·GPU-util · production incident 의 < 50% 가 기존 메트릭으로 사전 감지 안 됨 반증자) — 다음 라운드.
- [ ] 축 N⭐ NOVEL (N1 silent-corruption vs loud-failure 감지 비대칭 · silent corruption 감지율 < loud failure 감지율 × 0.5 반증자 — 반쪽 관제) — ⭐ MAIN priority lane · measured-tier 필요.
