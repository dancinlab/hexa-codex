# USER-MODEL — log

Append-only history sister of `USER-MODEL.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-28 — A1 first probe · 10-turn persona drift closed-form · cycle-9 round-8 (CODEX bg) · 🔵 STRUCTURAL + 🟡 BY-CITATION 7/7

- [x] `bench/user_model_a1_persona_drift.hexa` — closed-form identity `drift_pct_x100(m) = persona_match_x100[m][turn=1] − persona_match_x100[m][turn=10]` · 4 models · 5 turn samples (1·3·5·7·10) · integer ×100 pp ledger (libm-free).
- [x] `verify/numerics_user_model_a1_persona_drift.hexa` — 7 invariants: drift identity · range [0,100] · zero-drift synthetic · `>20pp fires` (moderate=28 · catastrophic=55) · `≤20pp silent` (consistent=4 · slight=12) · determinism · monotone non-increasing across turn axis.
- [x] `verdicts/a1_persona_drift_verdict.txt` — env-driven `_root()` · `SUPPORTED-NUMERICAL` · tier `🔵 STRUCTURAL + 🟡 BY-CITATION` · 7/7 checks · external anchors Bae 2022 keep-me-updated · Jandaghi 2023 persona-driven · Zheng 2023 MT-Bench (arXiv:2306.05685) · Li 2024 LongChat.
- [x] axis A1 flipped to `[x]` in `USER-MODEL.md` (cycle-9 round-8 close-line).
- [ ] 실측 (cycle-10+ T4) — mac M3 llama-server multi-turn persona probe (MT-Bench-style 10-turn conversations · persona_match scorer decomposing into style/tone/pronoun/fact-recall sub-axes per Jandaghi 2023) deferred. Frontier OPEN.
- [ ] axis B (100-turn ladder · summary effect) and axis N ⭐ MAIN NOVEL (persona-drift vs context-overflow separation) open next.

## 2026-05-28 — domain init from AXIS.easy.md

- [x] scaffold from `AXIS.easy.md` candidate card (⭐⭐) · 3-axis 구조 (A · B · N⭐ MAIN NOVEL) · SANDBOX 측정 substrate · ENGINE dispatch surface 등록.
- [ ] first measured finding 확보 시 ENGINE intake matrix 승격 검토 (axis letter 부여).
