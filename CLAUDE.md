# hexa-codex

`hexa-codex` is an AI knowledge substrate: a 17-verb spec library across 4 groups
(safety · economics · ops · substrate) plus the `lm_foundry/` domain-LLM foundry
(a hexa-lang code-LLM at 94.29% Mk.I with a 3-vendor orchestration runtime). It is
a never-completing codex — each domain lane advances a verify-driven permanent axis
forever. Architecture SSOT: [ARCHITECTURE.json](ARCHITECTURE.json) (AI-parsable tree;
humans read it via [ARCHITECTURE.html](ARCHITECTURE.html) — `python3 serve.py`).

> 이 문서가 단일 markdown 거버넌스 SSOT · project.tape 은퇴 (this file is the single markdown governance SSOT; project.tape retired).

## Structure

```
hexa-codex/
├─ ARCHITECTURE.json      — architecture SSOT (AI-parsable tree · update-in-place)
├─ ARCHITECTURE.html      — human viewer for ARCHITECTURE.json (`python3 serve.py`)
├─ serve.py               — static server that auto-opens ARCHITECTURE.html over http
├─ CHANGELOG.md           — append-only history / decisions (absorbed <DOMAIN>.log.md + release notes)
├─ README.md              — domain narrative, verbs, badges
├─ CLAUDE.md              — single markdown governance SSOT (this file)
├─ CLAIMS.tape            — single index of verifiable claims
├─ DOMAINS.tape           — live domain roster (NAME → snapshot path; progress/@goal derived)
├─ alignment/ safety/ welfare/ adversarial/ consciousness/ interpret/  — SAFETY verbs (6)
├─ train_cost/ infer_cost/ quality_scale/                              — ECONOMICS verbs (3)
├─ deploy/ enterprise/ agent_serving/ eval/                            — OPS verbs (4)
├─ multimodal/ rlhf/ cog_arch/ causal/                                 — SUBSTRATE verbs (4)
├─ lm_foundry/            — domain-LLM training pipeline + orchestration runtime (v0.6.0 GA)
├─ LAB/                   — falsifiable experiments routed to the SANDBOX substrate
├─ discovery/ .discoveries/ — continuous /kick · /gap discovery + per-slug findings
├─ verify/ .verdicts/ t4_empirical/ — claim verification → persisted verdicts
├─ PAPER/ papers/         — gated /paper output (one positive + one closed-negative per group)
├─ ENGINE/ NEUROEXP/ RAG/ LONG-CONTEXT/ … — measurement-axis sibling domains (per DOMAINS.tape)
├─ cli/                   — hexa-lang entrypoints + discovery/verify engine
├─ state/                 — single runtime/scratch artifact root (c5): scratch/ (docs scratchDir) · markers/ + *.log untracked
└─ .harness-engine/       — harness submodule (governance · docs discipline · gates)
```

> The scattered root domain docs (ARCHITECTURE.md · ECONOMICS/SAFETY/OPS/SUBSTRATE/SANDBOX/
> ORCHESTRATION/OPERATIONS/LEARNING_PROGRAMMING `.md` + their `.log.md` + LEARNING_BIO ·
> LATTICE_POLICY · LIMIT_BREAKTHROUGH · TAPE-AUDIT · IMPORTED_FROM_CANON · AXIS.easy ·
> HEXA_CODEX · RELEASE_NOTES_v* · V0_6_0_GA) were retired 2026-06-18 into the single
> `ARCHITECTURE.json` tree (design) + `CHANGELOG.md` (history). Use `git log` for the old files.

## Governance

Governance verbs (formerly `project.tape` `@D` entries, now folded into this file):

- **HF artifacts**: register every model/dataset/ckpt to HF Hub completely under
  `dancinlab/*` (`hexa-forge-*` models, `hexa-codex-<domain>-evals-v<N>` evals);
  adversarial/refusal/jailbreak sets default PRIVATE; completeness proven by an
  authenticated HF↔local sync audit on a token host.
- **Claims**: every verifiable claim indexed in `CLAIMS.tape` → `hexa verify` →
  `.verdicts/` with raw stdout verbatim (no LLM self-judge). Empirical (T4) claims
  run real train/infer/serve benchmarks.
- **Papers**: `/paper` gated on every section CLOSED-by-recompute + significance
  (formula + benchmark + benefit\|closed refutation); max one positive + one
  closed-negative per group; violating papers revoked immediately.
- **Discovery**: runs continuously every batch, logged to `.discoveries/<slug>.tape`.
- **LAB**: every experiment routes to the self-hosted SANDBOX substrate and states
  an explicit falsifier.
- **Branches**: `main` / `master` are protected — changes flow through PRs.

## Harness

This repo is governed by the `dancinlab/harness` engine, vendored as the
`.harness-engine` git submodule (branch `harness-hardcore`). Activate it after a
fresh clone:

```bash
git submodule update --init --remote .harness-engine
```

Run any harness command via the wrapper (falls back to `npx tsx` when the clone
has no node_modules):

```bash
bash .harness-engine/bin/harness <cmd>
# e.g.
bash .harness-engine/bin/harness docs check     # expect: docs: ok
bash .harness-engine/bin/harness lint            # staged-L0 + freshness + changelog gates
bash .harness-engine/bin/harness verify          # run configured verify checks
```

Config — [harness.config.json](harness.config.json):

- `profile: hardcore`, `stack: [hexa]`, `protectedBranches: [main, master]`.
- `lockdown.files` guards core sources; edits remind to update `CHANGELOG.md`.
- `lint.changelog` requires `CHANGELOG.md` to be staged alongside `*.hexa` changes.
- `docs` block: architecture SSOT = `ARCHITECTURE.json`, log = `CHANGELOG.md`,
  scratch = `state/scratch/`, scope limited to root docs, with the root
  SSOT/README-variant docs allow-listed.

Agent hooks (pre-bash / pre-write / post-edit / prompt / prefs · easy · recommend
inject / SessionStart) are wired in [.claude/settings.json](.claude/settings.json),
each guarded so they no-op when the engine binary is absent.

## Quick reference

| Need | Path / command |
|------|----------------|
| Architecture SSOT (AI) | [ARCHITECTURE.json](ARCHITECTURE.json) |
| Architecture viewer (human) | `python3 serve.py` → [ARCHITECTURE.html](ARCHITECTURE.html) |
| History / decisions | [CHANGELOG.md](CHANGELOG.md) |
| Governance verbs | this file (`## Governance`) |
| Claim index | `CLAIMS.tape` · verdicts `.verdicts/` |
| Domain roster (live) | `DOMAINS.tape` |
| Domain-LLM foundry | [lm_foundry/README.md](lm_foundry/README.md) · ARCHITECTURE.json `lm_foundry/` node |
| Docs discipline check | `bash .harness-engine/bin/harness docs check` |
| Run a harness command | `bash .harness-engine/bin/harness <cmd>` |
