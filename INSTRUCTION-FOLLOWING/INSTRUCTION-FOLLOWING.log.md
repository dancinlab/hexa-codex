# INSTRUCTION-FOLLOWING — log

Append-only history sister of `INSTRUCTION-FOLLOWING.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — A1 first probe build (CODEX cycle-9 round-4 · agent-death recovery salvage)

- [x] A1 — IFEval compliance closed-form 7/7 🔵 STRUCTURAL + 🟡 BY-CITATION · `verify/numerics_instruction_following_a1_compliance_rate.hexa` · `verdicts/a1_compliance_rate_verdict.txt`.
- [x] identity: `compliance = N_passed / N_total × 100` + per-constraint sum sanity (Σ_c cells == N_passed).
- [x] worked example 4 models × 4 constraint types: strict-trained=95 silent · mid=82·weak=68·raw-base=45 fire.
- [x] external anchors: Zhou 2023 IFEval · Tam 2024 · Wadhwa 2024.
- **agent death recovery (salvage pattern)**: bg agent (id ab03... → typo, actual aa4f...) 가 21 tool_uses · 254s 후 API rate-limit 으로 사망. bench/verify 파일은 main worktree 에 untracked 로 남았고 (HALLUCINATION agent 가 report 에서 untracked 봤다고 확인) parent 가 (1) `mkdir verdicts/` (2) `hexa run` 으로 7/7 확인 + verdict.txt 생성 (3) doc flip + log entry 인라인. cycle skill recovery pattern: "checkpoint commits are replay-safe" 의 변형 — 이 경우 checkpoint commit 은 없었지만 main worktree 의 untracked 파일을 salvage.
- **honest residual**: 실측 IFEval 미수행 (~541 prompt × 25 verifier class) — cycle-10+ T4 cost-bearing deferred (mac M3 llama-server / ubu-1 HF).
- [ ] 축 B (constraint complexity ladder) — 다음 라운드.
- [ ] 축 N⭐ NOVEL (format-vs-content Pareto · strict-vs-loose trade-off) — measured-tier 필요.
- [ ] ENGINE intake matrix 승격 검토.

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
