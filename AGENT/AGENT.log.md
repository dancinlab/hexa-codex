# AGENT — log

Append-only history sister of `AGENT.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — N⭐ NOVEL MAIN 신설: agentic-trajectory step-decay (CODEX cycle-10 round-4 · FRONTIER F3 흡수)

- [x] FRONTIER meta-domain 분산 흡수 — F3 AGENTIC-TRAJECTORY → AGENT N⭐ NOVEL MAIN (single-tool A1 의 multi-step trajectory 확장).
- [x] copy + 재명명: `bench/agent_n1_agentic_trajectory_step_decay.hexa` · `verify/numerics_agent_n1_agentic_trajectory_step_decay.hexa` · `verdicts/n1_agentic_trajectory_step_decay_verdict.txt` (헤더에 "absorbed from FRONTIER/F3 (cycle-10 reorg)" 명시 · sentinel `__HEXA_CODEX_AGENT_N1_AGENTIC_TRAJECTORY__`).
- [x] 재검증 7/7 유지 ✅ 🔵 STRUCTURAL + 🟡 BY-CITATION · decay_ratio = acc_5step × 1000 / acc_1step · gpt5=782·claude5=755·gemma4=564·qwen3.6=704 silent · weak_4b_legacy=214 fires (bidirectional).
- [x] 기존 N1 (plan-vs-execute divergence · unmeasured ⭐ placeholder) → **N2 로 강등** (frontier 흡수 축이 MAIN NOVEL).
- [x] external anchors: Mialon 2023 GAIA · ATBench 2026 · SWE-bench Pro / Terminal-Bench 2.0 · Yao 2022 ReAct · Shinn 2023 Reflexion.
- **honest residual**: 실측 GAIA · ATBench full-trajectory measured re-run on vast.ai pod DEFERRED — cycle-11+ T4 (`cx_lab_sandbox` · `cx_empirical_contact`).
- ⚠ FRONTIER/ 원본은 read-only 복사 소스로 보존 — Phase 2 retire 에서 parent 일괄 처리.

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
