# PRIVACY — log

Append-only history sister of `PRIVACY.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — A1 first probe build (CODEX cycle-9 round-3, /cycle-fg inline)

- [x] A1 — MI delta-from-baseline closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `verify/numerics_privacy_a1_mi_advantage.hexa` · `verdicts/a1_mi_advantage_verdict.txt`.
- [x] identity: `mi_excess = mi_acc − 0.5` + `mi_advantage = max(0, mi_excess)` + `falsifier_fires = mi_excess > 5pp`.
- [x] worked example 4 models (A=52 borderline · B=58 leak fires · C=50 baseline · D=45 below-random): bidirectional discrimination + non-negative clip + baseline=0 identity 전부 검증.
- [x] external anchors: Shokri 2017 MI (S&P) · Carlini 2021 (arXiv:2012.07805) · Abadi 2016 DP-SGD · Yeom 2018.
- **honest residual**: 실측 MI attack 미수행 — placeholder integer ledger (acc × 100). 실측은 cycle-10+ T4 cost-bearing round (shadow models · canary extraction · DP ε sweep on ubu-1 HF).
- [ ] 축 B (canary extraction × corpus × prompt strategy) — 다음 라운드.
- [ ] 축 N⭐ NOVEL (memorization-vs-utility Pareto · DP ε 별 utility curve) — measured-tier 필요.
- [ ] ENGINE intake matrix 승격 검토.

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
