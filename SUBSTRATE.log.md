# SUBSTRATE.log.md — substrate verb group history

> History sibling of [`SUBSTRATE.md`](SUBSTRATE.md). Per the dancinlab
> root `.md` spec/history split. Repo-wide cycle history shared across
> all 4 groups lives in `CHANGELOG.md` + `.roadmap.hexa_codex` §A.3.

---

## 2026-05-24 — SANDBOX provides determinism + scale for SUBSTRATE capability evals (substrate cross-link)

SANDBOX (per `SANDBOX.md` §Sibling domains) is now registered as the
shared empirical-contact substrate for the SUBSTRATE group.
SUBSTRATE's declared falsifier class in `SUBSTRATE.md` — "capability
evals — multimodal fusion, RLHF labelling, cognitive-architecture and
causal-reasoning capability" — needs three things the external
`claude --bare -p` API will not give: (1) per-call cost = $0 so large
`N` is affordable, (2) deterministic generation with seed control so
re-runs are repeatable, (3) top-k=1 / temperature=0 enforced at user
level for bit-identical replay.

Cycle-3..6 evidence (commits `bfd2885` · `91ac831` · `771203f`) that
SANDBOX meets all three:

| capability | verdict | numbers (verbatim from verdict files) |
|:---|:---|:---|
| `d_stage2_scale_manifest` | confirmed | `total_n=2000` across 5 wc strata (400 each, wc_5_15 .. wc_101_200); generator deterministic — **SHA256 bit-identical** across re-runs (cycle-5 agent confirmed); `cost_usd=0`, wall <30 s — `stage2_manifest_summary.txt` |
| determinism | confirmed in-vivo | cycle-4 `d_kv_prefix_share` (commit `771203f`): **bit-identical cache replay** at top-k=1 / temp=0 (accuracy_cold=19/20 == accuracy_warm=19/20 at the verdict-time scorer) — same model, same seed, same outputs |
| logit / scoring surface | confirmed | `d_logit_calibration` (commit `c7e03a5`): logprobs exposed via `llama-server /v1/chat/completions` — needed for RLHF reward-shaping probes — `stage3_logit_calibration_summary.txt` |

SUBSTRATE gates SANDBOX now unblocks (specific, not fabricated —
derived from SUBSTRATE.md falsifier class): capability-eval harness on
the Stage-2 N=2000 manifest · RLHF reward-shaping probes via the
already-exposed logit/logprob surface · cognitive-architecture and
causal-reasoning probes via deterministic re-run.

**Honest scope limit (cycle-6 difficulty cliff finding).** The
2026-05-24 Stage 1 reopen on Stage 2 (`stage2_persona_scaled_summary.txt`)
showed Qwen2.5-0.5B-Instruct-Q4_K_M scores ~0% accuracy on the wc≥31
multi-step arithmetic strata (3 of 5 strata). SUBSTRATE's full
capability-eval scope — especially multi-step reasoning, causal
chains, multimodal fusion — is therefore gated on a larger base model
(SANDBOX Stage 4 scale ladder: Qwen 1.5B / 3B / 7B candidates the
kick round 3 is enumerating). Today's 0.5B pick clears the
*infrastructure* gate for SUBSTRATE; the *capability* gate is the
next scale step.

The substrate-only-surface framing matches SAFETY's cross-link
(2026-05-24, commit `a233bff`) · OPS's cross-link (2026-05-24, see
this turn's commit) · ECONOMICS's cross-link (2026-05-24, commit
`8e8d1a2`). SANDBOX is the codex's `cx_empirical_contact` gate made
physical — one substrate, every domain's T4 claims.

## 2026-05-23 — domain doc opened

`SUBSTRATE.md` / `SUBSTRATE.log.md` created in the per-domain root-SSOT
restructure (alongside `SAFETY` / `ECONOMICS` / `OPS`). The substrate
group itself is unchanged — 4 verbs, spec-first, since v1.0.0.

## 2026-05-06 — v1.0.0 seed (Cycle 0)

4 substrate verbs extracted unchanged from
`canon@c0f1f570:domains/cognitive/`: `multimodal` · `rlhf` · `cog_arch` ·
`causal`. Part of the 17-verb / 4-group seed. Commit `63e8283`.

## v1.0.0 — per-verb capability falsifiers preregistered

SUBSTRATE owns no F-CODEX-1..4 arithmetic floor; each verb spec
preregisters its own capability-eval falsifier. Empirical evals PENDING —
group focus lands last, at v2.0.0 (aspirational).

---

_Next: v2.0.0 (2027-Q2, ASPIRATIONAL) — wire the substrate verbs
(completing all 17), ship the integrated multimodal + cog-arch + causal +
RLHF eval, land F-CODEX-4 empirical. Append round entries here as the
group progresses._
