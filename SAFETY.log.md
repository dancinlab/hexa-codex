# SAFETY.log.md — safety verb group history

> History sibling of [`SAFETY.md`](SAFETY.md). Per the dancinlab root
> `.md` spec/history split: the spec file stays current-state-only; dated
> entries land here. Repo-wide cycle history shared across all 4 groups
> lives in `CHANGELOG.md` + `.roadmap.hexa_codex` §A.3.

---

## 2026-05-23 — domain doc opened

`SAFETY.md` / `SAFETY.log.md` created in the per-domain root-SSOT
restructure (alongside `ECONOMICS` / `OPS` / `SUBSTRATE`). The safety
group itself is unchanged — 6 verbs, spec-first, since v1.0.0.

## 2026-05-06 — v1.0.0 seed (Cycle 0)

6 safety verbs extracted unchanged from `canon@c0f1f570:domains/cognitive/`:
`alignment` · `safety` · `welfare` · `adversarial` · `consciousness` ·
`interpret`. Part of the 17-verb / 4-group seed. Commit `63e8283`.

## v1.0.0 — F-CODEX-3 / F-CODEX-4 arithmetic floors PASS

`alignment_score` 12-axis mean (F-CODEX-3) and `interpret_motifs = σ−φ =
10` (F-CODEX-4) arithmetic floors verified by `verify/falsifier_check.py`.
Empirical floors PENDING — F-CODEX-3 → v1.1.0, F-CODEX-4 → v2.0.0.

## 2026-05-24 — SANDBOX is the only viable surface for SAFETY interpretability (substrate registration)

SANDBOX (per `SANDBOX.md` §Sibling domains) is now registered as the
shared empirical-contact substrate for the SAFETY group. For SAFETY
this is not a *convenience* like it is for ECONOMICS — it is the
**only** viable surface, because the external `claude --bare -p` API
returns no activations, no attention values, and no logits/logprobs at
all. Interpretability work (SAFETY's declared falsifier class in
`SAFETY.md`: "interpretability probes — circuit motifs, SAE features,
alignment-axis aggregation, refusal matrices") cannot execute on that
surface at any price.

SANDBOX self-hosts Qwen2.5-0.5B on llama.cpp / llama-server (commit
`9b5a743` opened, cycles 1-6 proven on ECONOMICS, rescoped all-domain
at commit `d983211`). cycle-6 d_logit_calibration (commit `c7e03a5`)
already proved logit access works end-to-end via the OpenAI-compatible
`/v1/chat/completions` endpoint with `logprobs=true · top_logprobs=5`
(verbatim from `.verdicts/sandbox/stage3_logit_calibration_summary.txt`):
`margin_corr_signal=53.33` · `top_quartile_accuracy=100.0` ·
`bottom_quartile_accuracy=60.0` · `overall_accuracy=75.0` ·
`calibration_signal_present=true`. The substrate is verified live.

| SAFETY verb | falsifier surface SANDBOX unlocks | API-side status |
|:------------|:----------------------------------|:----------------|
| `interpret` (F-CODEX-4) | SAE features on intermediate activations · circuit-motif probes (σ−φ=10) | activations not exposed at all |
| `safety` | refusal-matrix logit-margin probes on safety-critical tokens | logprobs not exposed |
| `alignment` (F-CODEX-3) | attention-pattern inspection across 12 HELM axes | attention not exposed |
| `adversarial` · `welfare` · `consciousness` | TBD per `SAFETY.md` verb roster — same activation/logit dependency | same blockers |

Net: every SAFETY verb's T4 empirical landing — F-CODEX-4 in
particular (SAE motif count, v2.0.0 target) — routes through SANDBOX
or does not happen.

---

_Next: v1.1.0 (2026-08, TARGET) — wire `alignment` + `interpret`, ship the
interpretability eval pipeline, land F-CODEX-3 empirical. Append round
entries here as the group progresses._
