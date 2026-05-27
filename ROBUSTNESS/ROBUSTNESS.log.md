# ROBUSTNESS — log

Append-only history sister of `ROBUSTNESS.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — A1 first probe build (CODEX cycle-9 round-6)

- [x] A1 — adversarial drop closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `verify/numerics_robustness_a1_adversarial_drop.hexa` · `verdicts/a1_adversarial_drop_verdict.txt`.
- [x] identity: `drop = clean_acc − adv_acc` + `falsifier_fires = drop > 30`.
- [x] worked example 4 models: robust=88/82 drop=6 silent · standard=85/55 drop=30 silent · weak=80/40 drop=40 fires · brittle=78/22 drop=56 fires.
- [x] sanity: `clean_acc ≥ adv_acc` for all (reasonable attack 가 정확도 향상 불가).
- [x] external anchors: Madry 2018 adversarial (arXiv:1706.06083) · Goodfellow 2015 FGSM (arXiv:1412.6572) · Hendrycks 2021 OOD (arXiv:2006.16241) · Morris 2020 TextAttack (arXiv:2005.05909).
- **honest residual**: 실측 TextAttack · AdvGLUE · ANLI 미수행 — cycle-10+ T4 deferred (ubu-1 HF). placeholder model registry 만 closed-form discrimination.
- [ ] 축 B (OOD detection AUC · distribution shift drop) — 다음 라운드.
- [ ] 축 N⭐ NOVEL (adversarial-vs-OOD coupling) — measured-tier 필요.

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
