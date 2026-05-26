# SUBSTRATE.log.md — substrate verb group history

> History sibling of [`SUBSTRATE.md`](SUBSTRATE.md). Per the dancinlab
> root `.md` spec/history split. Repo-wide cycle history shared across
> all 4 groups lives in `CHANGELOG.md` + `.roadmap.hexa_codex` §A.3.

---

## 2026-05-27 — cycle-28 N1 spawned — ⭐ MAIN priority lane (model-family vs scaling-law)

NOVEL perpetual axis **N1** added to `SUBSTRATE.md` §영구 축 ·
⭐ MAIN priority lane · mirrors ECONOMICS cycle-27 E1 (MoE-vs-dense)
pattern.

Spawn lineage:
- cycle-23c P1 BREAKTHROUGH (4-rung VL ladder, non-monotone
  0.81/0.94/0.81/1.00, Qwen-VL-7B counting RECOVERS 5/5)
- cycle-24 `verify/numerics_substrate_multimodal_fit.hexa` honest
  residual: "7B counting recovery cannot discriminate 'subitizing
  emerges at scale' from 'Qwen2.5-VL-7B-specifically subitizes well'
  — needs a 5th rung at a non-Qwen-7B"
- cycle-26 C1 ECONOMICS (12 dense overtrain + 1 MoE Chinchilla-exact)
  → cycle-27 E1 (MoE-vs-dense) — same family-confound pattern echo

Seed: `.discoveries/substrate-n1-family-vs-scaling.tape` — 3 `@C` seeds:
1. cycle-23c per-family slope decomposition ($0 closed-form)
2. non-Qwen-7B VL DL plan (InternVL-7B-MPO / LLaVA-NeXT-7B, cycle-29+)
3. cross-family text cliff replication (Llama-3.1-8B / Mistral-7B-v0.3,
   cycle-29+)

`hexa tape` lint: 5 entries (1 @V + 1 @I + 3 @C), 0 malformed.

Verifier: `verify/numerics_substrate_n1_family_vs_scaling.hexa`
(cycle-28 first-probe, closed-form recompute on
`.verdicts/sandbox/p1_multimodal_ladder_7b.tsv`).

| field | value |
|:---|:---|
| per-rung counting | SmolVLM-0.5B=4/5 · SmolVLM-2.2B=4/5 · Qwen-VL-3B=2/5 · Qwen-VL-7B=5/5 |
| SmolVLM-family slope | 0.0 (within-family flat across 0.5B→2.2B) |
| Qwen-VL-family slope | 0.490841 (within-family rise on 3.0B→7.0B) |
| slope divergence | 0.490841 > 0.05 — families do NOT share counting-axis scaling |
| Qwen-VL dip detected | 3B (0.4) < 7B (1.0) AND 3B < SmolVLM-2.2B (0.8) |
| verifier checks | **5/5 PASS** |
| tier | 🟢 SUPPORTED-NUMERICAL (directional, n=2 family pairs) |
| verdict path | `.verdicts/sandbox/n1_family_vs_scaling_verdict.txt` |
| cost | $0 (closed-form recompute, no substrate fire) |

**Headline** — family confound EMPIRICALLY DETECTABLE in committed
cycle-23c data. The dip-then-recover signature lives ENTIRELY within
the Qwen-VL split (3.0B → 7.0B); the SmolVLM-family rungs
(0.5B → 2.2B) are flat-monotone on counting. Per-family slope
divergence (0.49 vs 0.00) > 0.05 gate → the two families do NOT follow
the same counting-axis scaling law in the data we already own.

**Honest residual (preregistered).** n=2 family pairs is ANECDOTE,
not statistical evidence. The family grid and scale grid are
CO-VARIED by construction (smaller = SmolVLM, larger = Qwen). Per-family
slope DETECTS the confound; it cannot ATTRIBUTE the recovery to family
vs scale at n=2 pairs alone. True cross-family fire is gated on a
non-Qwen 7B VL rung at the matched 7B scale (cycle-29+ seed 2 —
InternVL-7B-MPO or LLaVA-NeXT-7B, ~5GB DL, mac M3 local, $0).
The N1 axis is **PERPETUAL** — every future SUBSTRATE capability claim
must pass the family-vs-scale gate before scaling-law tier
([[feedback_closure_is_physical_limit]]).


## 2026-05-24 — M2.SUBSTRATE done — 1.5B Stage 2 persona rerun · `routing_viable` flipped TRUE

First SUBSTRATE T4 verdict landed via
`bench/sandbox_stage2_persona_scaled_1_5b.hexa` (the cycle-6 0.5B
bench cloned with `MODEL_PATH=Qwen2.5-1.5B-Instruct-Q4_K_M.gguf`).
N=150 × 3 personas FULL completion on M3 Metal,
`stage2_persona_scaled_1_5b_summary.txt`:

| persona | overall | wc_5_15 | wc_16_30 | wc_31_60 | wc_61_100 | wc_101_200 |
|:---|:---:|:---:|:---:|:---:|:---:|:---:|
| nano (32 tok) | 46% | 96% | 96% | 16% | 16% | 3% |
| mid (256 tok) | 40% | 96% | 96% | 3% | — | — |
| max (1024 tok) | 40% | 96% | — | 7% | — | — |

**Headline 1 — routing simulation viable.** `tier_separation_observed=true`,
`routing_simulation_viable=true`, `spread_tasks=8` (>3pp gate). Cycle-6
0.5B had spread=4 / viable=false; 1.5B's larger spread + per-stratum
ranking inversion (nano best in wc_5_15..wc_61_100, mid best in
wc_101_200) cross the gate. SUBSTRATE's capability-eval falsifier
class is now empirically measurable on the substrate.

**Headline 2 — difficulty cliff partially lifted, not cleared.**
`cliff_shifted_vs_0_5b=false` per the strict 50% threshold (1.5B
nano on wc_31_60 reaches 16%, still <50%), but the 0.5B baseline
was 6% — a 10pp lift on the cliff stratum. wc_101_200 stays near
zero. Full clearance gated on 3B (cycle-10 56aae56, base-on-disk +
smoke PASS) and 7B (PENDING). M3.SUBSTRATE saturation remains open.

| 0.5B → 1.5B per-stratum nano accuracy lift |
|:---|
| wc_5_15: 73% → 96% (+23pp) |
| wc_16_30: 86% → 96% (+10pp) |
| wc_31_60: 6% → 16% (+10pp, partial) |
| wc_61_100: 0% → 16% (+16pp, lift OFF the floor) |
| wc_101_200: 0% → 3% (~floor) |

SANDBOX.md M2.SUBSTRATE flipped `[ ]` → `[x]` (matrix + line item).
`.discoveries/sandbox.tape` `d_qwen_1_5b_scale` upgraded from
`confirmed_base_pick` (cycle-8 008482e) to `confirmed_full` with
honest `cliff_partially_lifted` annotation.

## 2026-05-24 — Stage-4 ladder extended to 7B — Qwen2.5-7B-Instruct-Q4_K_M on disk, smoke-test PASS (M3.SUBSTRATE 4-rung prereq met)

The SANDBOX scale ladder closes to 4 rungs (0.5B PoC + 1.5B
M1.SUBSTRATE + 3B cycle-11-3B + 7B this cycle). Direct execution of
the cycle-11 `d_qwen_7b_scale` candidate (`.discoveries/sandbox.tape`
line 471), modelled on the cycle-10 3B pattern (commit `56aae56`) and
ultimately on the cycle-8 1.5B M1.SUBSTRATE pattern (commit `008482e`).
4-rung scale-ladder is the explicit prerequisite for M3.SUBSTRATE
*saturation* AND for the F-CODEX-1 v1.2.0 release-gate scale-grid
(per `ECONOMICS.md` §M5.ECON, the 4 scale rungs are exactly the
F-CODEX-1 fit input) — but **M3.SUBSTRATE itself stays `[ ]`** because
saturation still requires running the FULL ladder through Stage 2 +
locating per-stratum cliff position, not merely adding rungs to disk.

| field | value |
|:---|:---|
| base_model | Qwen2.5-7B-Instruct-Q4_K_M (bartowski GGUF) |
| model_path | `~/Models/gguf/Qwen2.5-7B-Instruct-Q4_K_M.gguf` |
| model_size | 4 683 074 240 bytes (≈ 4.36 GiB / 4.47 GB) |
| sha256 | `65b8fcd92af6b4fefa935c625d1ac27ea29dcb6ee14589c55a8f115ceaaa1423` |
| download via | `curl -L` (huggingface-cli still not installed; task-spec fallback) |
| download wall | 1 124 s (≈ 4.0 MB/s, 4.47 GB total — ≈ 2.7× the 3B wall as file is ≈ 2.4× larger) |
| smoke prompt | "What is 2+2? Reply with the digit only." |
| smoke output | `4 [end of text]` (substring match on kw "4" ✓) |
| smoke verdict | **PASS** |
| smoke wall | 2 364 ms total (date+%s%N brackets) · load 1 150.76 ms · prompt-eval 261.87 ms · single-tok decode 65.27 ms |
| prompt_eval throughput | 80.19 tok/s on 21 prompt tokens (M3 Metal); vs 3B 173.00 / 1.5B 173.00 — 7B sees the expected ~2× slowdown vs 3B on prompt-eval |
| eval throughput | 15.32 tok/s reported — *thin 1-token sample*, load+EOS-dominated, not steady-state; vs cycle-10 3B 20.81 tok/s and cycle-8 1.5B 62.15 tok/s; monotone-decreasing 62.15 → 20.81 → 15.32 across 1.5B / 3B / 7B as expected. To be remeasured under the Stage-2 rerun. |
| MTL memory (post-load) | total 18 186 MiB · free 11 921 MiB · self 6 264 MiB (model 4 168 + ctx 1 792 + compute 304) — ~11.6 GB headroom on 16 GB UMA |
| host / tool | mac mini M3 · `llama-completion` (brew llama.cpp + Metal) |
| cost | $0 (local download + local inference) |

Persisted: `.verdicts/sandbox/m3_substrate_7b_pick.txt` carries the
full provenance header (sha256, size, smoke verdict, source URL,
download method, MTL memory breakdown, next-milestone link). Schema
mirrors `m3_substrate_3b_pick.txt`.

The `d_qwen_7b_scale` candidate in `.discoveries/sandbox.tape` flips
from `candidate` → `confirmed_base_pick` (mirror of the cycle-10
`d_qwen_3b_scale` flip pattern; honest scope =
`base-on-disk+smoke-test-only`, `bench_rerun_pending=true`).
`SANDBOX.md` M3.SUBSTRATE checkbox is **NOT** flipped — saturation gate
is full-ladder Stage-2 + cliff position, separate later cycle.

Co-resident scale ladder on disk now: {0.5B 397 808 192 B, 1.5B
986 048 768 B, 3B 1 929 903 264 B, 7B 4 683 074 240 B} = 4-of-4 rungs,
total ~8.0 GB of GGUFs in `~/Models/gguf/`. Next on the substrate
lane: run all 4 rungs through `bench/sandbox_stage2_persona_scaled.hexa`
for per-stratum cliff position; that cycle closes M3.SUBSTRATE.

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
