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

## 2026-05-24 — M1.SAFETY narrowed to logprob surface (cycle-10) — intermediate-tensor capture tracked as M1.SAFETY+

Honest scope redefinition, not new substrate work. The cycle-7 → cycle-9
chain (commit `b683287` → `b5a6c1f`) proved the intermediate-residual /
attention / MLP activation surface does **not** exist anywhere in
upstream llama.cpp HEAD `b22ff4b7`. The original M1.SAFETY criteria
("activation capture") over-promised what the substrate exposes. The
narrowed M1.SAFETY = logit/logprob surface is GENUINELY done via
cycle-5 `d_logit_calibration` (commit `c7e03a5`) — this is not a fake
flip, it is recognizing that existing work already covers the
narrowed scope.

**Cycle-9 fork probe (verbatim from `.verdicts/sandbox/m1_safety_unblock_fork.txt`):**

```
upstream_repo              = https://github.com/ggerganov/llama.cpp
upstream_sha               = b22ff4b7b43b6d0d91636f85692ff216cb7cb607
build_attempted            = false
logits_all_exposed         = false
n_probs_exposed            = false
self_test_verdict          = BLOCKED_AT_PROJECT

evidence:
  1. grep -rE "logits-all|logits_all" /tmp/llama-cpp-probe → 0 matches
  2. grep -nE -- "--logits-all|--n-probs|--logits_all|--n_probs"   → 0 matches
  3. grep -nE "logits.all|n_probs" common/arg.cpp                  → 0 matches
  4. only n_probs match: common/common.h:214 — sampling-struct FIELD,
     per-request, not CLI flag
```

Blocker class transition: cycle-7 `BLOCKED_AT_BUILD` (stock Homebrew
lacks flags) → cycle-8/9 `BLOCKED_AT_PROJECT` (upstream HEAD also lacks
them; the feature does not exist in llama.cpp anywhere).

**Cycle-5 logit-calibration evidence verbatim (`.verdicts/sandbox/stage3_logit_calibration_summary.txt`):**

```
llama_cpp_logprob_surface_exposed = true   (via HTTP server endpoint
                                            /v1/chat/completions
                                            logprobs=true · top_logprobs=5)
top_quartile_accuracy             = 100.0   (5/5)
bottom_quartile_accuracy          = 60.0    (3/5)
overall_accuracy                  = 75.0    (15/20)
margin_corr_signal                = 53.33   (top_q − bot_q) / overall, %
calibration_signal_present        = true    (margin_corr_signal > 20.00)
inverted_degenerate               = false
model                             = Qwen2.5-0.5B-Instruct-Q4_K_M
host                              = mac-mini-m3 (brew llama.cpp + Metal)
cost_usd                          = 0
```

**Resolution applied to `SANDBOX.md`:**

- M1.SAFETY checkbox flipped `[ ] → [x]` with explicit "(narrowed:
  logit/logprob surface)" qualifier, linked to cycle-5 `c7e03a5` +
  the verdict file.
- New line item M1.SAFETY+ added `[ ]` BLOCKED_AT_PROJECT, tracking
  the intermediate-tensor activation capture (residual / attention /
  MLP) — requires either a NEW fork-of-llama with a ggml-graph tap
  injection OR a transformers+hooks substrate addition. This is a
  substrate-extension candidate, not the M1.SAFETY closure path.
- Matrix cell relabeled "logit/logprob (+M1.SF+)" with a footnote on
  the scope split.

**Honesty disclosure:** the substrate did not gain anything new this
cycle. The flip is bookkeeping that aligns the M1.SAFETY definition
with what the substrate physically delivers, while the over-promised
scope is moved into M1.SAFETY+ where it is honestly blocked. `interpret`
(F-CODEX-4 SAE motifs) still depends on M1.SAFETY+ landing. `safety`
refusal-matrix logit-margin probes are immediately reachable today
through the M1.SAFETY-narrow path.

Tape side-effect: `d_activation_capture_pipeline` PARTIAL → confirmed
(narrowed scope); new candidate row `d_activation_capture_intermediate_tap`
added with status BLOCKED_AT_PROJECT. Cumulative tape footer post-cycle-10:
6 confirmed · 3 dead · 1 BLOCKED_AT_PROJECT · 9 candidates remaining.

---

_Next: v1.1.0 (2026-08, TARGET) — wire `alignment` + `interpret`, ship the
interpretability eval pipeline, land F-CODEX-3 empirical. Append round
entries here as the group progresses._
