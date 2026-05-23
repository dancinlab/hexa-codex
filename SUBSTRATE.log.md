# SUBSTRATE.log.md — substrate verb group history

> History sibling of [`SUBSTRATE.md`](SUBSTRATE.md). Per the dancinlab
> root `.md` spec/history split. Repo-wide cycle history shared across
> all 4 groups lives in `CHANGELOG.md` + `.roadmap.hexa_codex` §A.3.

---

## 2026-05-24 — Stage-4 ladder extended to 3B — Qwen2.5-3B-Instruct-Q4_K_M on disk, smoke-test PASS (M3.SUBSTRATE prereq)

The SANDBOX scale ladder gains its 3rd rung (after 0.5B PoC and 1.5B
M1.SUBSTRATE). Direct execution of the cycle-7 `d_qwen_3b_scale`
candidate (`.discoveries/sandbox.tape`), modelled on the cycle-8
M1.SUBSTRATE pattern (commit `008482e`) which closed 1.5B. This is the
explicit prerequisite for M3.SUBSTRATE *saturation* (full ladder
0.5/1.5/3/7B Stage-2 rerun + per-stratum cliff position) — but
**M3.SUBSTRATE itself stays `[ ]`** because saturation requires running
the FULL ladder through Stage 2, not merely adding rungs to disk.

| field | value |
|:---|:---|
| base_model | Qwen2.5-3B-Instruct-Q4_K_M (bartowski GGUF) |
| model_path | `~/Models/gguf/Qwen2.5-3B-Instruct-Q4_K_M.gguf` |
| model_size | 1 929 903 264 bytes (≈ 1.84 GB) |
| sha256 | `9c9f56a391a3abbd5b89d0245bf6106081bcc3173119d4229235dd9d23253f94` |
| download via | `curl -L` (huggingface-cli still not installed; task-spec fallback) |
| download wall | 417 s (≈ 4.4 MB/s, 1.84 GB total — ≈ 2.3× the 1.5B wall as file is ≈ 2× larger) |
| smoke prompt | "What is 2+2? Reply with the digit only." |
| smoke output | `4 [end of text]` (substring match on kw "4" ✓) |
| smoke verdict | **PASS** |
| smoke wall | 5 910 ms total · load 2 801 ms · prompt-eval 121 ms · single-tok decode 48 ms |
| prompt_eval throughput | 173.00 tok/s on 21 prompt tokens (M3 Metal) |
| eval throughput | 20.81 tok/s reported — *thin 1-token sample*, load-dominated, not steady-state; vs cycle-8 1.5B 62.15 tok/s on a similar 1-token run. To be remeasured under the Stage-2 rerun. |
| host / tool | mac mini M3 · `llama-completion` (brew llama.cpp + Metal) |
| cost | $0 (local download + local inference) |

Persisted: `.verdicts/sandbox/m3_substrate_3b_pick.txt` carries the
full provenance header (sha256, size, smoke verdict, source URL,
download method, next-milestone link). Schema mirrors
`m1_substrate_base_pick.txt`.

The `d_qwen_3b_scale` candidate in `.discoveries/sandbox.tape` flips
from `candidate` → `confirmed_base_pick` (mirror of the cycle-8
`d_qwen_1_5b_scale` flip pattern; honest scope =
`base-on-disk+smoke-test-only`, `bench_rerun_pending=true`).
`SANDBOX.md` M3.SUBSTRATE checkbox is **NOT** flipped — saturation gate
is full-ladder Stage-2 + cliff position, separate later cycle.

Next on the substrate lane: download the 4th rung (Qwen2.5-7B
Q4_K_M, ~4.7 GB, fits on M3 unified memory) under a sibling
`d_qwen_7b_scale` candidate; then run all 4 rungs through
`bench/sandbox_stage2_persona_scaled.hexa` for per-stratum cliff
position; that pair of cycles closes M3.SUBSTRATE.

## 2026-05-24 — M1.SUBSTRATE done — Qwen2.5-1.5B-Instruct-Q4_K_M on disk, smoke-test PASS

The SANDBOX M1.SUBSTRATE milestone (scale-ladder base model picked +
GGUF on disk + load-verified, ≥1.5B) closes. Direct execution of the
cycle-7 `d_qwen_1_5b_scale` candidate (`.discoveries/sandbox.tape`,
commit `f98e858`) and the explicit prerequisite for M2.SUBSTRATE
(1st capability eval at ≥1.5B on Stage-2 manifest).

| field | value |
|:---|:---|
| base_model | Qwen2.5-1.5B-Instruct-Q4_K_M (bartowski GGUF) |
| model_path | `~/Models/gguf/Qwen2.5-1.5B-Instruct-Q4_K_M.gguf` |
| model_size | 986 048 768 bytes (≈ 940 MB) |
| sha256 | `1adf0b11065d8ad2e8123ea110d1ec956dab4ab038eab665614adba04b6c3370` |
| download via | `curl -L` (huggingface-cli not installed; task-spec fallback) |
| download wall | 134 s (≈ 7.0 MB/s, 940 MB total) |
| smoke prompt | "What is 2+2? Reply with the digit only." |
| smoke output | `4 [end of text]` (substring match on kw "4" ✓) |
| smoke verdict | **PASS** |
| smoke wall | 5 440 ms total · load 1 516 ms · prompt-eval 130 ms · decode 16 ms (1 tok) |
| eval throughput | 62.15 tok/s on M3 Metal (vs ~70-80 tok/s typical for 0.5B Q4_K_M — visible capability/scale tradeoff) |
| host / tool | mac mini M3 · `llama-completion` (brew llama.cpp + Metal) |
| cost | $0 (local download + local inference) |

Persisted: `.verdicts/sandbox/m1_substrate_base_pick.txt` carries the
full provenance header (sha256, size, smoke verdict, source URL,
download method, next-milestone link).

M1.SUBSTRATE matrix cell in `SANDBOX.md` flipped `[ ] → [x]`; the
`d_qwen_1_5b_scale` candidate in `.discoveries/sandbox.tape` flips
to `confirmed_base_pick` with the verdict reference attached. Next
on the substrate lane: rerun `bench/sandbox_stage2_persona_scaled.hexa`
against this 1.5B base to locate the cycle-6 difficulty cliff (the
wc≥31 strata Qwen2.5-0.5B failed at 0-6% accuracy) — M2.SUBSTRATE
proper.

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
