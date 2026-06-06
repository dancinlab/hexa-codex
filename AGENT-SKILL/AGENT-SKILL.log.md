# AGENT-SKILL — append-only step log

## 2026-06-07 — domain SEED (SkillOpt/SkillLens topic home)

- Created `AGENT-SKILL/*` domain (SEED, no measurements yet) — measures model-generated
  agent-skill artifacts (natural-language procedure docs a frozen agent reuses).
  Registered in root `DOMAINS.tape`. Snapshot: [`AGENT-SKILL.md`](AGENT-SKILL.md).
- **Name choice** AGENT-SKILL over bare SKILL — the repo already has its own *skills*
  (slash-commands / sidecar / CLAUDE.md plumbing); `AGENT-SKILL` avoids that namespace
  misread and spans the full extraction→consumption→evolution→transfer lifecycle
  (완성도·안전 axes; 표준·단순 axes preferred `SKILL`, fixed-complete auto-pick resolved it).
- Proposed perpetual axes (all `[ ]` unmeasured): A skill-utility Δ (help vs negative
  transfer) · B extraction ≠ execution (EE/TE) · C target-dependent utility · N ⭐ self-
  evolving skill loop (SkillOpt rollout→gate).
- **Seed** — SkillOpt (arXiv:2605.23904) + SkillLens (arXiv:2605.23899) verbatim offline
  mirrors live at `../FRONTEND/sample/` (cross-ref, not moved). This domain is their topic
  home; FRONTEND borrows them as axis-N methodology only.
- Honesty: SEED state — no `🟢` verdict claimed; axis metrics/anchors are candidates until
  first `/cycle` probe. Page-stated model names (GPT-5.5 etc.) / arXiv ids quoted verbatim.
