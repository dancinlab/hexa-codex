# hexa-codex — Architecture (SSOT · update-in-place)

> Single source of truth for the actual architecture. **Update (overwrite)
> this file in place** when the architecture changes — it is not append-only.
> History and decisions live in [CHANGELOG.md](CHANGELOG.md); governance lives
> in [CLAUDE.md](CLAUDE.md). Domain narrative and badges live in
> [README.md](README.md).

## Overview

`hexa-codex` is a standalone **AI knowledge substrate** — a *codex* (library)
of AI-domain specifications that the rest of the `dancinlab` stack imports
declaratively. It has two halves:

1. **17-verb spec library** — closed-form candidate specs + preregistered
   falsifiers, organized into **4 orthogonal groups** (safety · economics ·
   ops · substrate, 6 + 3 + 4 + 4 = 17). Each verb is a single `.md` spec under
   a group-named directory. Consumers *read* the codex; they do not run it.
   Empirical landing (T4) is deferred per the release ladder.
2. **`lm_foundry/` domain-LLM foundry** — a working model-training + inference
   pipeline (absorbed from the retired `hexa-forge` repo, 2026-05-13). It ships
   a hexa-lang code-LLM at **94.29% Mk.I strict** (r39 GA, frozen) wrapped by a
   **v0.5.x orchestration runtime** (pre-7B classifier routing, real 3-vendor
   SDKs, persistent cache, multi-turn memory, observability, SQLite-WAL safety).

The codex is governed by a **never-completes** discipline: each domain lane
advances a verify-driven `## 영구 축` (permanent axis) forever, so a 100%
progress bar is by-design unreachable. Every verifiable claim is indexed in
`CLAIMS.tape` and proven through `hexa verify` into `.verdicts/`.

## Component map

| Component | Path | Role |
|-----------|------|------|
| **Spec library — SAFETY (6)** | `alignment/` `safety/` `welfare/` `adversarial/` `consciousness/` `interpret/` | Alignment-score aggregator, refusal/capability gates, welfare probe, red-team taxonomy, IIT×GWT probe, SAE interpretability. SSOT: `SAFETY.md`. |
| **Spec library — ECONOMICS (3)** | `train_cost/` `infer_cost/` `quality_scale/` | Chinchilla-fit training scaling, context^τ inference cost, HumanEval+/hexa-eval quality scaling. SSOT: `ECONOMICS.md`. |
| **Spec library — OPS (4)** | `deploy/` `enterprise/` `agent_serving/` `eval/` | Hardware-tier deployment recipes, enterprise customisation envelope, tool-use SLO/schema, eval-pipeline template. SSOT: `OPS.md`. |
| **Spec library — SUBSTRATE (4)** | `multimodal/` `rlhf/` `cog_arch/` `causal/` | Multimodal fusion, DPO/RLHF labelling hub, cognitive-architecture envelope, causal-chain reasoning. SSOT: `SUBSTRATE.md`. |
| **Domain-LLM foundry** | `lm_foundry/` | Code-LLM training pipeline (Qwen2.5-Coder-7B + LoRA SFT → GRPO compile-RL → GA) and v0.5.x orchestration runtime. SSOT: `LEARNING_PROGRAMMING.md`, `ORCHESTRATION.md`. |
| **Measurement substrate** | `SANDBOX.md`, `LAB/` | Shared self-hosted llama-server substrate; every `LAB/<id>` experiment routes its LLM calls here with a falsifiable hypothesis. |
| **Discovery lane** | `discovery/`, `.discoveries/` | Continuous `/kick` · `/gap` discovery interleaved every batch; findings persisted per-slug. |
| **Claims & verdicts** | `CLAIMS.tape`, `.verdicts/`, `verify/`, `t4_empirical/` | Single index of verifiable claims → `hexa verify` → persisted verdict tapes (raw stdout verbatim). |
| **Papers** | `PAPER/`, `papers/`, `lm_foundry/papers/` | Gated `/paper` output: formula · method · benchmark · benefit\|refutation, one positive + one closed-negative per group. |
| **Research domains** | `RAG/` `LONG-CONTEXT/` `HALLUCINATION/` `MULTILINGUAL/` `ROBUSTNESS/` `CALIBRATION/` `FAIRNESS/` `PRIVACY/` … | Per-axis research lanes, each with a `<DOMAIN>.md` snapshot SSOT + `<DOMAIN>.log.md` append-only history. |
| **CLI & engine** | `cli/`, `ENGINE/`, `hexa.toml`, `install.hexa` | hexa-lang entrypoints and the discovery/verify engine wiring. |
| **Harness governance** | `.harness-engine/` (submodule), `.harness/`, `harness.config.json`, `.claude/` | Project-agnostic AI coding harness — lockdown, docs discipline, lint/verify gates, branch protection. |

## Data flow

```
canon/domains/cognitive/  ──extract──▶  17 verb specs (4 groups)
                                            │
                                            ▼
        CLAIMS.tape (single claim index) ──▶ hexa verify ──▶ .verdicts/<slug>.tape
                                            │                       │
   discovery (/kick · /gap) ──▶ .discoveries/<slug>.tape           │
                                            │                       ▼
   LAB/<id> ──▶ SANDBOX substrate ──▶ falsifier status ──▶ domain <X>.md (snapshot)
                                            │                + <X>.log.md (append)
                                            ▼
   lm_foundry/ train (SFT→RL→GA) ──▶ HF dancinlab/hexa-forge-* ──▶ orchestration runtime
                                            │
                                            ▼
   gated /paper ──▶ PAPER/<slug>/ (formula·method·benchmark·benefit|refutation)
```

Input = extracted specs + measured experiments; processing = verify-driven
verdict generation + model training; output = verdicts, trained HF artifacts,
and gated papers. Each domain lane re-measures its permanent axis indefinitely.

## Governance & verify

- **Governance SSOT**: [CLAUDE.md](CLAUDE.md) summarizes the `project.tape`
  `@D` governance verbs (HF completeness/org/naming, claim manifest + verify,
  empirical T4 contact, gated `/paper` significance, continuous discovery,
  LAB-on-SANDBOX, native I/O, minimal DRIVE, uncensored ENGINE default).
- **Claims**: every verifiable claim is listed in `CLAIMS.tape` (id · text ·
  method = atom\|expr\|fence\|run) and proven via `hexa verify` →
  `.verdicts/`. No LLM self-judge; raw stdout is persisted verbatim.
- **Docs discipline (harness)**: architecture SSOT = this file; append-only log
  = `CHANGELOG.md`; scratch = `scripts/scratch/`. Run
  `bash .harness-engine/bin/harness docs check` → expect `docs: ok`.
- **HF artifacts**: completeness proven by an authenticated HF↔local sync audit
  on a token host; adversarial/refusal/jailbreak eval sets default PRIVATE.
- **Branches**: `main` / `master` are protected (commit directly is a hardcore
  violation); changes flow through PRs.
