# AGENT — log

Append-only history sister of `AGENT.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — A1 first probe build (CODEX cycle-9 round-5, /cycle-fg inline)

- [x] A1 — tool call rate closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `verify/numerics_agent_a1_tool_call_rate.hexa` · `verdicts/a1_tool_call_rate_verdict.txt`.
- [x] identity: `acc = N_correct / N_total × 100` + `falsifier_fires = acc < 70`.
- [x] worked example 4 models (N=100, 4 tools × 25 trials): excellent=92 silent · mid=78 silent · weak=55 fires · broken=30 fires.
- [x] external anchors: Yao 2023 ReAct · Schick 2023 Toolformer · Shinn 2023 Reflexion · Patil 2023 Gorilla.
- **honest residual**: 실측 BFCL · ToolBench · API-Bank 미수행 — cycle-10+ T4 deferred (ubu-1 HF).
- [ ] 축 B (multi-step plan depth × error recovery) — 다음 라운드.
- [ ] 축 N⭐ NOVEL (plan-vs-execute divergence) — measured-tier 필요.

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
