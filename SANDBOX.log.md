# SANDBOX.log.md — measurement substrate history

> History sibling of [`SANDBOX.md`](SANDBOX.md). Per the dancinlab
> root `.md` spec/history split. Repo-wide cycle history shared
> across all groups lives in `CHANGELOG.md` + `.roadmap.hexa_codex`
> §A.3.

---

## 2026-05-24 — M1.SAFETY fork attempt — BLOCKED_AT_PROJECT (flags absent in upstream HEAD)

Cycle-8 follow-up to the `d_activation_capture_pipeline` PARTIAL verdict
(`activation_capture.hexa` self-test exited `BLOCKED_AT_BUILD` on stock
Homebrew llama-server 9150). This task investigated whether building
upstream llama.cpp from source would expose the required CLI flags
(`--logits-all`, `--n-probs`) that the M1.SAFETY interface depends on for
intermediate-activation capture.

**Result — fork would not have helped. Build not attempted.**

Probed upstream HEAD `b22ff4b7b43b6d0d91636f85692ff216cb7cb607` (shallow
clone at `/tmp/llama-cpp-probe`) BEFORE building, per the task spec's
honesty rule "If upstream HEAD doesn't have these flags either, the
BLOCKED moves UP-the-stack to 'feature doesn't exist in llama.cpp at
all' — report that honestly and stop. Do NOT fork/PR upstream from this
task."

Evidence (all 4 zero-match searches recorded in the verdict file):

```
grep -rE "logits-all|logits_all" /tmp/llama-cpp-probe       → 0 matches
grep -nE "logits.all|n_probs"  common/arg.cpp               → 0 matches
grep -nE -- "--logits-all|--n-probs" /tmp/llama-cpp-probe   → 0 matches
only "n_probs" hit: common/common.h:214 — a SAMPLING-STRUCT FIELD,
                    not a CLI flag (read per-request from the JSON body
                    of /v1/chat/completions, lines 72/125/303/334-335 of
                    tools/server/server-task.cpp)
```

The `--save-all-logits` flag does exist in `common/arg.cpp:2126`, but
that belongs to the `--kl-divergence-base` perplexity tool, not server
or any activation-capture path.

**Blocker class transition recorded:** cycle-7 `BLOCKED_AT_BUILD` (stock
Homebrew lacks the flags) → cycle-8 `BLOCKED_AT_PROJECT` (upstream HEAD
also lacks them; the feature does not exist anywhere in llama.cpp).

**M1.SAFETY checkbox stays `[ ]` (NOT flipped)** — per task spec
"Do NOT flip M1.SAFETY on any failure path — leave `[ ]` honestly."
The path forward is either (a) redefine M1.SAFETY around the
already-confirmed logprob HTTP-body path (cycle-5 `d_logit_calibration`
proved `/v1/chat/completions` `logprobs=true` + `top_logprobs=N` works
end-to-end on stock Homebrew), or (b) write an actual ggml-graph
callback patch to llama.cpp's compute path (not a CLI flag add — a real
source change). (b) is out of scope here.

Verdict file: `.verdicts/sandbox/m1_safety_unblock_fork.txt` — full
provenance (upstream sha · all 4 grep evidence · blocker-class
transition · path forward). Cost $0. Wall ~5 min (clone + grep, no
build). Tape candidate `d_activation_capture_forked_llama` added with
state `dead [BLOCKED_AT_PROJECT]` to seal the lane.

## 2026-05-24 — M1.SUBSTRATE done — scale-ladder base on disk

Qwen2.5-1.5B-Instruct-Q4_K_M GGUF downloaded (940 MB, sha256
`1adf0b11065d8ad2…`) and load-verified via a 1-prompt smoke test on
the M3 Metal `llama-completion` surface — answered "What is 2+2?" with
clean `4 [end of text]` in 5 440 ms (load 1 516 ms · 62.15 tok/s
decode). Closes the SANDBOX M1.SUBSTRATE matrix checkbox and directly
executes the cycle-7 `d_qwen_1_5b_scale` candidate (.discoveries/sandbox.tape,
commit `f98e858`). Full provenance — model path, size, sha256, smoke
output, throughput, source URL, download method — persisted at
`.verdicts/sandbox/m1_substrate_base_pick.txt`. Detailed table cross-ref
in `SUBSTRATE.log.md` 2026-05-24 entry (this turn). Cost $0,
download ~2 min, smoke test ~5 s. Next on the substrate lane:
M2.SUBSTRATE — rerun `bench/sandbox_stage2_persona_scaled.hexa`
against the 1.5B base to map the cycle-6 wc≥31 difficulty cliff.

## 2026-05-24 — M1.OPS done — `slo_under_load` harness script written (no exec yet)

Shipped `bench/sandbox_stage4_slo_under_load.hexa` — the OPS SLO
measurement harness modelled on the cycle-6 server-spawn-trap-teardown
pattern from `bench/sandbox_stage4_continuous_batching.hexa` (double-fork
nohup, port isolation, `date +%s%N` bracketing, `xargs -P` concurrent
dispatch). Port 8090 (distinct from sibling benches at 8081/8082/8083/8088).

The harness sweeps a 3 × 3 SLO grid (9 cells total):

```
                   rate=5 qps     rate=20 qps    rate=100 qps
   np=1            cell (1,5)     cell (1,20)    cell (1,100)
   np=2            cell (2,5)     cell (2,20)    cell (2,100)
   np=4            cell (4,5)     cell (4,20)    cell (4,100)
```

`np=8` intentionally omitted — cycle-6 `d_continuous_batching_server`
found np=8 was 27.9% slower than np=4 on the 16GB UMA mac-mini M3
(memory-bandwidth saturation), and a sustained-load run there would
OOM/thrash. Documented as `np_8_skipped` in the summary header.

Per cell: 30s warm-up (excluded from rollup) + 60s measurement window,
arrivals at fixed-tick `sleep $(1/r)` s; per-request bracket
`enqueue_t → complete_t` via `date +%s%N`; percentile rollup offline via
`sort -n | awk NR==floor(N*q)`. Shard files at
`/tmp/sandbox_stage4_slo_shards/<np>_<rate>.tsv`.

Honesty gates baked in: (a) `p999=NA` whenever `n_completed < 1000`
(the 5 qps cells deliver only ~300 measure-phase arrivals — that's by
design, not a bug); (b) `error_rate` captured separately from latency
so HTTP failures don't pollute percentiles as sub-ms p50s;
(c) `accuracy` per cell tracked as a secondary signal against the
Stage-2 manifest `expected_kw` (byte_exact_subset), compared to the
`np=1 / rate=5` reference cell at lowest contention; (d) server
killed between cells for clean `-np` state.

**This commit ships the SCRIPT only — no execution.** Placeholder
verdict at `.verdicts/sandbox/stage4_slo_under_load_summary.txt` marks
`# status=harness-written-not-yet-run` and projects the grid + next
command. The first verdict (M2.OPS) is a separate later cycle —
estimated wall-clock ~30 min (9 cells × ~90s + boot/teardown).

`.discoveries/sandbox.tape` `d_slo_under_load` flipped to
`harness_only` (substrate confirmed, verdict pending). M1.OPS
SANDBOX.md checkbox + matrix cell flipped to `[x]`.

## 2026-05-24 — kick round 3 — Stage 4 scale-ladder + all-domain candidates

Ran `hexa kick --rounds 1` against the post-cycle-6 + post-rescope
context: cycle-6 surfaced a difficulty cliff (Qwen2.5-0.5B fails wc≥31
multi-step arithmetic in 3 of 5 Stage-2 strata, 0-6% accuracy) and
SANDBOX rescoped (commit `d983211`) to host SAFETY/OPS/SUBSTRATE as
consumers. Seed explicitly asked for *cross-cutting* candidates that
unlock 2+ consumer domains at once. Raw at
`.discoveries/sandbox-kick3.raw` (mk9, 653 atoms, 517 overlay lines).

Five new `@C` entries appended to `.discoveries/sandbox.tape`:

| slug | tier | $est | cross-cuts | gate |
|:---|:-:|:-:|:---|:---|
| `d_qwen_1_5b_scale` | GREEN | $0 | ECONOMICS + SUBSTRATE | direct cycle-6 cliff successor |
| `d_qwen_3b_scale` | GREEN | $0 | SUBSTRATE | gated_on=d_qwen_1_5b_scale |
| `d_activation_capture_pipeline` | GREEN | $0 | **SAFETY + SUBSTRATE** | substrate-instrumentation |
| `d_slo_under_load` | GREEN | $0 | **OPS + ECONOMICS** | server-mode follow-up |
| `d_multimodal_base` | GREEN | $0 | SUBSTRATE | gated_on=d_qwen_3b_scale |

Top-2 ROI by all-domain unlock: (1) `d_activation_capture_pipeline`
(2 domains: SAFETY interp + SUBSTRATE RLHF — the single .hexa
wrapper unlocks both falsifier classes), (2) `d_qwen_1_5b_scale`
(direct cycle-6 successor that ungates all subsequent Stage 4 work).

`d_slo_under_load` is the second cross-cutting candidate (OPS SLO +
ECONOMICS $/latency on the same harness). Both `d_qwen_*_scale`
follow the same pattern cycle-4's `d_kv_prefix_share_persistent`
established for cycle-4 successors (kick-derived but cycle-direct).

Cumulative SANDBOX tape: **7 confirmed · 3 dead · 11 candidates
remaining** (round-1+2 6 + round-3 5 new).

## 2026-05-24 — scope redefined — all-domain shared experiment substrate

SANDBOX.md rescoped from an ECONOMICS-only measurement ground to the
**shared empirical-contact substrate for all four verb-group domains**
(ECONOMICS · SAFETY · OPS · SUBSTRATE). The redefinition follows the
"build a tiny experiment model, run experiments on it" framing the
user confirmed: we self-host a small open-weights pick (no training),
and *every* domain runs its T4 (empirical) claims on it.

Rationale — the self-hosted surface is not an ECONOMICS convenience;
for several domains it is the **only** measurement path:

| sibling | falsifier class | why API surface can't measure it |
|:---|:---|:---|
| ECONOMICS | cost-curve fits | no cache/stop/max-tok/batch knobs (proven cycles 1-6) |
| SAFETY | interpretability (circuits · SAE) | API returns no activations/attention at all |
| OPS | SLO checks | API hides the serving process + scheduling |
| SUBSTRATE | capability evals (multimodal · RLHF) | metered + non-deterministic + no seed control |

This makes SANDBOX the physical realization of the `cx_empirical_contact`
gate — one substrate, every domain's T4 claims. ECONOMICS is the
proven consumer (routing-savings cycles 1-6); SAFETY/OPS/SUBSTRATE are
candidates whose empirical landings now have a home. Sibling domains
recorded in SANDBOX.md §"Sibling domains" + Cross-refs; lm_foundry
(LEARNING_PROGRAMMING · LEARNING_BIO) noted as the host platform whose
trained artefacts are future candidate base models, distinct from
today's OSS pick.

No bench/verdict change — this is a scope + documentation commit.

## 2026-05-23 — domain opened

`SANDBOX.md` / `SANDBOX.log.md` created. Triggered by the ECONOMICS
routing-savings cycle-1/2 surface exhaustion:

- 3 candidates BLOCKED at the `claude --bare -p` 2.1.150 dispatch
  surface (`d_cache_aware` no cache_control flag, `d_early_stop` no
  stop-sequences flag, `d_prompt_compress` no compression lever).
- 1 stale (`d_batch_amortized` likely-BLOCKED parallel to the others
  — same surface family).
- `verify/numerics_economics_pareto_floor.hexa` (commit `5bbb9ad`,
  10/10 PASS BLUE) proved the canonical 2-tier router is **within
  0.44 pp of the analytic Pareto floor** on the 20-task manifest at
  20/20 accuracy — heuristic-router and CLI-knob axes both exhausted.

Remaining slack must come from a substrate change: host the LLM
ourselves. The SANDBOX domain captures that decision — self-hosted
measurement substrate that returns logits, KV cache, stop sequences,
deterministic seeds, batch dispatch, and unmetered manifest scale,
unblocking both the cycle-2 BLOCKED candidates and the F-CODEX-1/2
empirical landings the ECONOMICS roadmap v1.2.0/1.3.0 gates on.

The 8-round brainstorm that produced the Stage 0-4 ladder ran to
depletion (Rounds 1-8: model choice, routing-bench dimensions, infra,
experiment design, verification, risks, integration, residual sweep).
The Occam-recommended path: Stage 0 PoC with an OSS pretrained pick
(no training cost) + a thin dispatch wrapper, before climbing the
ladder to Stage 4 empirical landings.

Next: Stage 0 PoC — pick Qwen2.5-0.5B (M2), wire
`lm_foundry/tool/route_dispatch.hexa` (I8), dispatch one canonical
20-task pass on mac mini llama.cpp to measure accuracy floor +
serving cost. No commit lands until accuracy floor and dispatch
parity vs `claude --bare -p` are both measured.

---

## 2026-05-23 — kick round 1 — 12 candidates inventoried

`hexa kick --seed "<SANDBOX substrate axes>" --rounds 1` (mk9,
smash+414 free+211 res+20, 645 total) → `.discoveries/sandbox.tape`
opened with 12 candidates: 5 SANDBOX.md ladder stages
(d_stage0_poc → d_stage4_empirical_landing), 3 cycle-2 BLOCKED
revivals (d_cache_aware_local, d_early_stop_local,
d_prompt_compress_local — `_local` suffix to differentiate from
the API-surface dead entries that remain `BLOCKED` in
`economics-routing-savings.tape`), and 4 kick-1 orthogonal axes
the substrate unlocks beyond the SANDBOX.md ladder
(d_logit_calibration, d_kv_prefix_share, d_speculative_decode_model,
d_quantization_tier). Raw: `.discoveries/sandbox-kick1.raw`. Top-2
ROI: `d_stage0_poc` (gates everything) + `d_kv_prefix_share`
(finest-grained replacement for cycle-1 `d_batch_amortized`,
combines additively with the confirmed length-router 2-tier
policy). Six other seed axes (prompt-distillation,
retrieval-augmented dispatch, continuous-batching) deferred —
distillation pinned by §"Honesty rules" (Anthropic ToS),
retrieval/continuous-batching redundant with d_stage2_scale_manifest
+ d_kv_prefix_share.

---

## 2026-05-23 — Stage 0 PoC — Qwen2.5-0.5B-Instruct baseline

`bench/sandbox_stage0_baseline.hexa` measured the self-hosted
accuracy floor on the canonical 20-task economics-routing manifest
(verbatim from `bench/economics_routing_2tier.hexa`). Threshold for
"usable floor" = `>= 15/20`.

| metric | value |
|---|---|
| model | Qwen2.5-0.5B-Instruct-Q4_K_M (GGUF, ~379 MB) |
| host / tool | mac mini M3 · `llama-completion` (brew llama.cpp + Metal) |
| accuracy | ~~19/20 (95.0%)~~ **16/20 (80.0%)** — see 2026-05-24 rebaseline entry |
| total wall-clock | 26.13 s (~1.3 s/task incl. model-load amortization) |
| cost | $0 USD (local serving; `wall_ms` is the proxy cost surface) |
| usable floor reached | **true** (16/20 >= 15/20 — still clears) |

Stage 0 verdict: self-hosted small-OSS substrate clears the usable
floor on the canonical manifest at 80% (clean scorer; original 95%
reading was inflated by stderr-trailer leakage, corrected in the
2026-05-24 rebaseline entry below) — still above the 15/20 floor and
within reach of the baseline opus reference at zero per-call cost.
Stage 1 (3-tier persona via temperature/max-tok on the same single
base, mock haiku/sonnet/opus) is unblocked.

Honest residuals (g5 compliance — no cherry-picking):

- Task 9 (ASCII for 'A') — answered "97" (lowercase 'a'); honest
  model-knowledge miss, single failure of the run.
- Task 18 (binary 1101 -> decimal) — answer text said "= 42 decimal"
  (arithmetically wrong; correct = 13), but `byte_exact_subset`
  scorer matched "13" embedded in the working "11 * 2^2 + 1 * 2^1"
  — same scorer-artifact class as the cycle-1/2 rambling-cover
  pattern; reported as-is.
- Output snippets contain llama-completion's `[end of text]
  common_perf_print:` trailer because stderr was merged into the
  capture stream; expected-keyword substring match is unaffected.

Persisted:
- `bench/sandbox_stage0_baseline.hexa` — bench source (hexa-only).
- `.verdicts/sandbox/stage0_accuracy_floor.tsv` — per-task rows.
- `.verdicts/sandbox/stage0_accuracy_floor_summary.txt` — aggregate.

## 2026-05-23 — Stage 1 PoC — tier-persona convention degenerate (manifest no-op)

Implemented `bench/sandbox_stage1_persona.hexa` — the SANDBOX.md
§"Tier persona convention (Stage 1)" — single base model
(Qwen2.5-0.5B-Instruct-Q4_K_M, same as Stage 0) + 3 personas
distinguished by system prompt + decoding params only:

| persona | system prompt                          | temp | max_tok | mock tier |
|:--------|:---------------------------------------|:----:|:-------:|:---------:|
| `nano`  | "Answer in <=15 tokens."               | 0.0  |   32    | haiku     |
| `mid`   | "Answer concisely."                    | 0.0  |   256   | sonnet    |
| `max`   | "Answer carefully and thoroughly."     | 0.0  |  1024   | opus      |

Dispatch via `llama-completion -sys ... -p ...` (chat-template aware),
same scorer (byte_exact_subset, case-insensitive), same canonical
20-task manifest verbatim from Stage 0.

Result (ORIGINAL — pre-2026-05-24 rebaseline): all 3 personas score
20/20 — apparent perfect ceiling saturation. This figure was inflated
by the same stderr-trailer scorer artifact as Stage 0; the rebaseline
entry at the bottom of this log corrects to nano 17/20 · mid 18/20
· max 17/20, with `tier_separation_observed = true` (ms_ladder) and
`routing_simulation_viable = true`.

- ~~`nano_accuracy = 20/20`~~ **17/20** · `nano_total_wall_ms ≈ 25.7s` (rerun)
- ~~`mid_accuracy  = 20/20`~~ **18/20** · `mid_total_wall_ms  ≈ 46.7s` (rerun)
- ~~`max_accuracy  = 20/20`~~ **17/20** · `max_total_wall_ms  ≈ 176.4s` (rerun)
- `tier_separation_observed = true` (ms_ladder=true; rebaseline)
- `routing_simulation_viable = true` (spread_tasks=1; rebaseline)

The persona convention is **NOT falsified** — dispatch, scorer parity,
and per-persona wall_ms accounting all work mechanically. It is
**dead-on-manifest**: the canonical 20-task set is too short / too
uniform / too saturated for any tier-routing simulation to have signal.
Notably, even `nano` (max_tok=32 + "Answer in <=15 tokens.") produces
correct short answers including the two tasks Stage 0 missed
(task 9 ASCII for 'A' → "65" instead of "97"; task 18 binary 1101
correct in `mid` working line). The system-prompt constraint
"answer in <=15 tokens" outperforms Stage 0 vanilla on these — the
sys_prompt is actively HELPING accuracy, not hurting it.

ms_ladder is also non-monotone (`mid` is the fastest at 104s vs
nano 123s vs max 142s) — short max_tok=32 + early-EOS doesn't beat
mid's looser max_tok=256 in practice because most outputs hit the
natural `[end of text]` token early in all three regimes.

**Honest signal** (g5 compliance): Stage 2 (scaled stratified
manifest, `wc ∈ [5, 200]`, N >= 2000, 5 task strata) is the BLOCKING
dependency before tier-routing has any observable signal. Every
downstream substrate-only candidate that consumes Stage 1
(`d_cache_aware_local`, `d_logit_calibration`, `d_kv_prefix_share`,
`d_quantization_tier`) inherits this observability gap on the
20-task canonical manifest. The cycle-1/2 length-router 81.79%
saving cannot be reproduced under SANDBOX until Stage 2 lands.

`.discoveries/sandbox.tape` flipped: `d_stage0_poc` → confirmed
(verdict ref attached), `d_stage1_persona` → dead-on-manifest
(verdict ref attached); top-ROI candidate is now
`d_stage2_scale_manifest`.

Persisted:
- `bench/sandbox_stage1_persona.hexa` — bench source (hexa-only).
- `.verdicts/sandbox/stage1_persona.tsv` — 60 rows (3 personas × 20).
- `.verdicts/sandbox/stage1_persona_summary.txt` — aggregate verdict.

---

## 2026-05-23 — Stage 3 KV-prefix share — flag exposed, BLOCKED_AT_SCALE

`bench/sandbox_stage3_kvprefix.hexa` revived cycle-2 `d_cache_aware`
(BLOCKED at the `claude --bare -p` 2.1.150 dispatch surface — no
`cache_control` flag, warm was 24.10% MORE expensive than cold). The
self-hosted `llama-completion` (llama.cpp brew build 9150) DOES expose
the `--prompt-cache` family of flags; evidence captured at
`.discoveries/sandbox-llama-cache-flags.raw`:

| flag | role |
|:---|:---|
| `--prompt-cache FNAME` | file to cache prompt state for faster startup |
| `--prompt-cache-all` | also save user input + generations |
| `--prompt-cache-ro` | use the prompt cache read-only (don't update) |

Two strategies on the canonical 20-task manifest (verbatim from
Stage 0 / `economics_routing_2tier.hexa`) with a shared **376-token**
operating-contract preamble (probed empirically; `n_tokens = 376`
per `llama-completion` perf print) attached to every task:

- `cold` — each task standalone, no cache flag (prefix re-tokenized fresh per call)
- `warm` — task[0] writes the cache via `--prompt-cache /tmp/sandbox_prefix.bin --prompt-cache-all`; tasks[1..19] read-only via `--prompt-cache /tmp/sandbox_prefix.bin --prompt-cache-ro`

| metric | value |
|---|---|
| llama_cpp_cache_flag_exposed | **true** (substrate unlock confirmed) |
| cache_file_size | 4,725,349 bytes (~4.7 MB) on disk for 376 tokens |
| accuracy_cold | ~~19/20~~ **16/20** (post-rebaseline; see 2026-05-24 entry) |
| accuracy_warm | ~~19/20~~ **17/20** (cache replay accuracy within ±1 task of cold on the clean scorer) |
| cold_total_wall_ms | 123,914 (avg 6,195 ms/task) |
| warm_total_wall_ms | 130,826 (avg 6,576 ms/task after first cache-write) |
| warm_first_wall_ms (cache write) | 5,869 |
| **warm_speedup_pct** | **−6.15%** (warm SLOWER than cold) |
| viable threshold | ≥ +20% speedup AND accuracy_warm ≥ accuracy_cold |
| **kv_prefix_share_viable** | **false** |

**Honest residual** (cx_empirical_contact + g5): the lever is real,
substrate-exposed, accuracy-safe, and the cache file is written +
replayed bit-identically (warm matches cold on all 20 answers, same
single miss at task 8 boiling-point). What kills it at THIS scale is
per-invocation model-load: each `llama-completion` process pays
~3-4 s for Metal init + GGUF mmap, which dwarfs the 530 ms
prefix-eval saving the cache is supposed to recover. Cache load also
adds ~50 ms of 4.7 MB I/O on top. The lever needs either (a) a
persistent server (`llama-server --cache-prompt`) so model-load is
amortized across calls, or (b) a much longer prefix (few-thousand
tokens) where prefix-eval dominates startup. Neither is in scope for
cycle-4; both are concrete successor candidates.

**Contrast with cycle-2 `d_cache_aware`** (`.verdicts/economics-routing-savings/cache_summary.txt`):

| | cycle-2 (claude --bare -p) | cycle-4 (llama-completion) |
|---|---|---|
| cache flag exposed | **false** (no `cache_control`) | **true** (`--prompt-cache` works) |
| warm_saving_pct | **−24.10%** | **−6.15%** |
| blocker class | surface-limit (BLOCKED) | scale-limit (BLOCKED_AT_SCALE) |
| accuracy parity | 10/10 == 10/10 (small manifest) | 16/20 vs 17/20 (clean-scorer, post-rebaseline) |

Cycle-4 narrowed the blocker by 17.95 pp and converted the failure
mode from *unfixable-at-the-vendor-surface* to
*fixable-by-changing-dispatch-shape*. The lever survives as an axis
for a future persistent-serve revival; flipped to **dead
[actual_tier=BLOCKED_AT_SCALE]** in `.discoveries/sandbox.tape`
with successor `d_kv_prefix_share_persistent` noted.

Persisted:
- `bench/sandbox_stage3_kvprefix.hexa` — bench source (hexa-only).
- `.verdicts/sandbox/stage3_kvprefix.tsv` — 40 rows (2 strategies × 20).
- `.verdicts/sandbox/stage3_kvprefix_summary.txt` — aggregate verdict.
- `.discoveries/sandbox-llama-cache-flags.raw` — flag-grep evidence.

---

## 2026-05-23 — Stage 3 early-stop local — d_early_stop_local CONFIRMED

`bench/sandbox_stage3_earlystop_local.hexa` revives the cycle-2 BLOCKED
`d_early_stop` candidate via the local llama.cpp surface. The cycle-2
attempt died at the `claude --bare -p` 2.1.150 dispatch surface (no
`--stop-sequences` flag); `llama-completion -r/--reverse-prompt` exposes
the equivalent decoder-level lever on the Stage 0 substrate.

A/B on the canonical 20-task manifest, Qwen2.5-0.5B-Instruct-Q4_K_M,
warm-cache run (3rd run of the day, system disk-cache stabilized):

| strategy | accuracy | total_wall_ms | avg_out_tok | note |
|---|---:|---:|---:|---|
| nostop          | 16/20 | 50049 | 14 | baseline (no -r) |
| stop_dblnl      | 16/20 | 48006 | 13 | -r "\n\n" — near no-op (Qwen2.5-0.5B emits compact prose without paragraph breaks) |
| stop_dot        | 16/20 | 34712 | 8  | **best** — -r "." truncates at first sentence end |
| stop_eos_marker | 0/20  | 22050 | 0  | DEAD — `-r "\n"` fires on chat-template `assistant\n` prefix before any answer token |

**Best strategy `stop_dot`:** -41.55% output_tok and -30.64% wall_ms at
**0pp accuracy loss** (16/20 parity with `nostop`). Exceeds the cycle-1
`d_early_stop` hypothesis target (≥30% output_tok cut at 0pp accuracy
loss). `d_early_stop_local` flipped → **confirmed** in
`.discoveries/sandbox.tape` with verdict link.

Honest residuals (g5 / cycle-2 backfire check):

- **Stage 3 nostop = 16/20 vs Stage 0 nostop = 19/20.** Same model, same
  decoder. The Stage 0 awk pipeline did NOT halt at `^common_perf_print`,
  so the substring scorer grep'd `expected_kw` against the post-`assistant`
  text INCLUDING llama-completion's perf-print + memory-breakdown trailer.
  Three tasks scored spuriously-correct in Stage 0:
    - T7 (kw="7"): answer "6", but "7" appears in trailer fields like
      "/ 2**7** tokens" / total time "= 5**7** ms".
    - T10 (kw="29"): answer "28", but "29" appears in trailer
      "prompt eval time = **29**.34 ms".
    - T18 (kw="13"): answer "1101 binary = ... = 42 decimal" (model
      arithmetic wrong, gold = 13), but "13" appears in trailer fields.

  The Stage 3 awk explicitly halts at `^common_perf_print` (cleaner
  scorer surface), so the 16/20 figure is the **honest baseline** and
  Stage 0's 19/20 is upward-biased by the same rambling-cover scorer
  artifact noted in `feedback_t3_quote_fragility.md`. Reported as-is;
  not retroactively patching Stage 0 (orthogonal cycle's deliverable).
  Critically the saving claims (output_tok -41.55%, wall_ms -30.64%)
  hold IDENTICALLY under either scorer because they are within-strategy
  ratios — the artifact biases all 4 strategies equally.
- **`stop_dblnl` near-no-op:** Qwen2.5-0.5B answers tasks compactly
  without paragraph breaks, so the `\n\n` trigger almost never fires —
  the 4% wall reduction is noise, not lever-driven savings.
- **`stop_eos_marker` 0/20:** `-r "\n"` matches against the running
  output stream including the chat-template-injected `assistant\n` prefix
  that `llama-completion` emits before the model's first generated token.
  The lever halts at byte zero of the answer. This is a **reverse-prompt
  scope** semantic, NOT an instruction-following failure — Qwen could
  in principle emit `FINAL: <answer>` correctly, but the stop trigger
  beats the model to the first token. cycle-2 `d_response_budget_cap`'s
  haiku-quoting-cap backfire pattern is therefore NOT observable on
  this variant; the lever dies for a different reason.
- **wall_ms is noisy across runs.** Three back-to-back invocations of
  the same bench produced nostop totals of {126658, 49443, 50049} ms;
  cold-cache penalty dominates the first-strategy slot. `output_tok` is
  deterministic (decoder-driven) and the more reliable metric — 41.55%
  reduction reproduces bit-for-bit across all runs. The 30.64% wall_ms
  number is from the warmed canonical run, reported as-is.

Persisted:
- `bench/sandbox_stage3_earlystop_local.hexa` — bench source (hexa-only).
- `.verdicts/sandbox/stage3_earlystop_local.tsv` — 80 rows (4 strategies × 20 tasks).
- `.verdicts/sandbox/stage3_earlystop_local_summary.txt` — per-strategy aggregate + best-strategy verdict.
- `.discoveries/sandbox.tape` — `d_early_stop_local` flipped to `confirmed`, footer cumulative tally updated.

Cumulative SANDBOX state: **2 confirmed** (d_stage0_poc · d_early_stop_local)
· 2 dead (d_stage1_persona · d_kv_prefix_share) · 8 candidates remaining.

---

## 2026-05-23 — Stage 3 max_tokens cap — d_prompt_compress_local CONFIRMED (max_tokens_cap_only)

`bench/sandbox_stage3_maxtokens_cap.hexa` revisits the cycle-2
`d_response_budget_cap` dead-end. The cycle-2 attempt (commit
`99e135d`, `.verdicts/economics-routing-savings/tokencap_summary.txt`)
tried a **prompt-prefix gimmick** — prepending `"Answer in <= N
tokens."` to the user prompt as a lexical instruction. At cap=15 the
haiku tier BACKFIRED by **quoting the cap instruction into its prose**
before answering, blowing output 747 → 1979 tokens (haiku output went
UP at tighter cap — the cap raised cost rather than lowered it). The
gimmick was advisory, and the model dodged it.

This cycle replays the lever at the **decoder layer** via `-n N`
(hard max_tokens flag). The decoder loop stops emitting at N tokens
regardless of what the model "wants" to say — there's no prose channel
for the model to quote the cap into, because the cap is structural
(decoder loop), not lexical (prompt prefix). This is the structural
advantage over cycle-2; the lever the API surface foreclosed becomes
measurable below it.

Five strategies on the canonical 20-task manifest verbatim from
Stage 0 (Qwen2.5-0.5B-Instruct-Q4_K_M, same model, same scorer with
the cleaned `[end of text]+common_perf_print:` trailer-strip used by
the early-stop bench):

| strategy | -n  | accuracy | total_wall_ms | avg_out_tok |
|---|---:|---:|---:|---:|
| nocap  | 1024 | 16/20 | 53018 | 23 |
| cap256 |  256 | 16/20 | 35298 | 15 |
| cap128 |  128 | 16/20 | 27144 | 13 |
| cap64  |   64 | 16/20 | 30141 |  9 |
| cap32  |   32 | 16/20 | 25662 |  6 |

Tightest cap holding the usable floor (>= 15/20) = **cap32** (-n 32);
none of the 5 strategies reach the originally-reported 19/20 Stage 0
ceiling because that figure was a scorer artifact (see honest note 2
below + early-stop log entry above — same observation, independent
discovery). Avg output_tok strictly decreasing 23 → 15 → 13 → 9 → 6.
`cycle2_backfire_pathology_present = false` — output_tok decreases
monotonically as cap tightens, confirming decoder enforcement.

**Wall_ms reduction at cap32 vs nocap: 51.59%** (25662 / 53018 ms).
This is informational only — the run-to-run wall_ms variance on this
manifest is ~3× across three back-to-back invocations (nocap totals
of {149632, 44491, 53018} ms), so the single-run delta is
noise-dominated when outputs are this short. The deterministic signal
is `output_tok`: cap32 cuts avg output to 6 tokens vs 23 (−73.9%) at
bit-identical accuracy.

**Cycle-2 backfire pathology absent**, definitively. Three independent
checks:
1. avg_out_tok monotone decreasing across the 5 strategies (no growth
   at any cap tightening — would be structural impossibility under -n).
2. Same 4 task failures (idx 7, 9, 10, 18) across all caps — accuracy
   is unaffected by cap; capacity is in the model, not the budget.
3. Output snippets contain no quoted cap instruction (the prompts
   themselves carry no cap text; the cap is decoder-side only, so
   there's nothing for the model to echo).

Honest residuals (g5 compliance):

- **Stage 0 19/20 → real 16/20:** Stage 0 didn't strip the
  `[end of text] + common_perf_print:` trailer from llama-completion
  stderr before substring-matching. Three tasks scored spuriously
  correct (T7, T10, T18 — perf-line digits leaked into the substring
  match). Stage 3 + the early-stop bench both independently strip the
  trailer and both arrive at 16/20 as the honest baseline. Not
  retroactively patching Stage 0; both logs document the artifact for
  posterity.
- **Wall_ms noise ~3×.** Run-to-run thermal + model-load variance
  dominates the cap-driven delta when outputs are short. Reporting
  the warmed-cache run-3 number as the canonical figure (51.59%
  reduction), but flagging that this is single-run.
- **NAMING MISMATCH (disclosed):** The candidate slug in
  `.discoveries/sandbox.tape` is `d_prompt_compress_local`, opened
  for LLMLingua-style **input-side** prompt compression. What's
  actually tested here is **output-side** max_tokens cap — distinct
  lever (different attack surface, different mechanism). The result
  is filed under the same slug because (a) the cycle-2 ancestor
  `d_response_budget_cap` was an output-budget gimmick that backfired,
  and (b) the SANDBOX-exposed `-n N` is the first output-budget lever
  that's actually measurable. True LLMLingua input-compression
  remains UNMEASURED and should get a separate slug when pursued
  (it requires the Stage 2 wc>=30 scaled manifest, which doesn't
  exist yet). The tape entry's `result =` line and `scope=
  max_tokens_cap_only` modifier carry the same disclosure.
- **Cap32 wall_ms reduction is noise-amplified by short manifest.**
  On longer-output workloads (Stage 4's wc>=30 reasoning prompts the
  model expands into) the wall_ms reduction would persist more
  cleanly; the same lever could yield much larger absolute savings.
  Not measured here.

Persisted:
- `bench/sandbox_stage3_maxtokens_cap.hexa` — bench source (hexa-only).
- `.verdicts/sandbox/stage3_maxtokens_cap.tsv` — 100 rows (5 strategies × 20 tasks).
- `.verdicts/sandbox/stage3_maxtokens_cap_summary.txt` — per-strategy aggregate + honest notes.
- `.discoveries/sandbox.tape` — `d_prompt_compress_local` flipped to `confirmed [scope=max_tokens_cap_only]`; footer cumulative tally updated.

Cumulative SANDBOX state: **3 confirmed** (d_stage0_poc · d_early_stop_local
· d_prompt_compress_local[max_tokens_cap_only]) · 2 dead
(d_stage1_persona · d_kv_prefix_share) · 7 candidates remaining.

---

## 2026-05-23 — kick round 2 — 4 new candidates, post-cycle-4 narrowing

`hexa kick --seed "<post-cycle-4 substrate-server axes>" --rounds 1` (mk9,
smash+414 free+211 res+17, 642 total) → 4 new `@C` entries appended to
`.discoveries/sandbox.tape`. Raw: `.discoveries/sandbox-kick2.raw` (engine
output is symbolic atlas-atom expansion; the 4 axes below are curator
distillation of the seed's enumerated hypothesis space, matching round-1
methodology — disclosed honestly).

Cycle-4 revealed 4 search-space narrowings: (a) manifest saturation at 20
tasks blocks Stage 1 until Stage 2 N>=2000 lands; (b) revivals work
(stop_dot -30.64% wall, max_tokens cap -51.59%); (c) one-shot CLI dispatch
has a fixed ~3-4s Metal-init+mmap floor that swamps fine-grained KV/cache
savings (kv_prefix BLOCKED_AT_SCALE); (d) scorer artifacts inflate
baselines (Stage 0 19/20 → real 16/20). (c) opens an entirely new axis
class — **long-lived server-mode dispatch** (`llama-server`) — that
one-shot CLI cannot reach.

Four new candidates inventoried:

| slug | tier | cost | source |
|:---|:---|:---|:---|
| `d_kv_prefix_share_persistent` | GREEN | $0 | cycle-4 successor (NOT kick-surfaced — direct response to `d_kv_prefix_share` BLOCKED_AT_SCALE verdict; honest disclosure) |
| `d_continuous_batching_server` | GREEN | $0 | kick-2 substrate-server axis; revives cycle-1 `d_batch_amortized` (BLOCKED at single-shot CLI) via `-np N` parallel slots |
| `d_json_schema_constrained` | GREEN | $0 | kick-2 axis; lever the `claude --bare -p` surface does not expose at all |
| `d_parallel_dispatch_local` | GREEN | $0 | kick-2 axis; control comparison for server-mode batching — N processes vs 1 process N slots |

**Top-2 ROI:** `d_kv_prefix_share_persistent` (GREEN, $0, directly rescues
the cycle-4 BLOCKED_AT_SCALE finding — the only candidate with prior
empirical narrowing of the blocker class, from surface→scale to scale→none
if hypothesis holds) + `d_continuous_batching_server` (GREEN, $0, subsumes
cycle-1 `d_batch_amortized` 50%-discount claim with a measurable
substrate-level mechanism; benefits from but does not require Stage 2 to
exercise — works on the canonical 20-task manifest at B=2/4 too).

Deferred from the seed: prompt-distillation (Honesty rules — Anthropic
ToS), retrieval-augmented dispatch (redundant with `d_stage2_scale_manifest`),
streaming-tok early-cancel (tightly coupled to `d_logit_calibration`,
folded there). `d_logit_calibration`, `d_speculative_decode_model`,
`d_quantization_tier` from round-1 remain candidate-state (still relevant,
orthogonal to server-mode).

Cumulative SANDBOX state: **3 confirmed** · **2 dead** · **11 candidates
remaining** (7 round-1 + 4 round-2).

---

## 2026-05-24 — Stage 3 logit calibration — d_logit_calibration CONFIRMED (cycle-2 d_confidence_gated substrate revival)

Cycle-5 closes the kick round-1 `d_logit_calibration` axis. Substrate
revival of cycle-2's dead `d_confidence_gated` candidate (commit
5d5b7d2). On the heuristic surface, cycle-2's best confgate (τ=0.9)
saved 55.59% @ 19/20 — strictly dominated by length-cutoff 70.10% @
20/20 (`.verdicts/economics-routing-savings/confgate_summary.txt`).
The "confidence" was the DLG-mk0 classifier's heuristic score, not
actual model logits. Cycle-5 asks: does the model itself know what
it knows?

### Surface probe — logprobs are server-only

`llama-cli --help` and `llama-completion --help` do NOT expose
`--logprobs` / `--n-probs` flags (probe persisted to
`.discoveries/sandbox-logprob-flags.raw`). The CLI surface is silent
on token-level probability output. However, `llama-server` exposes
the OpenAI-compatible `/v1/chat/completions` endpoint with
`logprobs=true` + `top_logprobs=5` request fields — verified probe
returns `choices[0].logprobs.content[i].top_logprobs[0..4]` with raw
`logprob` floats per token. **`llama_cpp_logprob_surface_exposed=true`**
(via HTTP server, not CLI).

### Bench — first-token margin on the canonical 20-task manifest

`bench/sandbox_stage3_logit_calibration.hexa` (this cycle, new
artefact). For each of the 20 canonical tasks (verbatim from
`bench/sandbox_stage0_baseline.hexa`):

1. POST `/v1/chat/completions` with `logprobs=true · top_logprobs=5 ·
   temperature=0 · max_tokens=96`.
2. Extract first-token margin: `top_logprobs[0].logprob −
   top_logprobs[1].logprob`.
3. Extract seq_avg_logprob: arithmetic mean of every emitted
   token's chosen logprob (cross-check signal).
4. Score correct via the SCORER-FIXED pattern (clean JSON, no stderr
   trailer leak — the cycle-4 max_tokens_cap reference).

### Result — signal_present=true at margin_corr_signal=53.33%

```
strategy    total correct top_q top_q_total bot_q bot_q_total
logit_calib    20      15     5           5     3           5
# top_quartile_accuracy=100.0
# bottom_quartile_accuracy=60.0
# overall_accuracy=75.0
# margin_corr_signal=53.33  (top_q_acc − bot_q_acc) / overall_acc, percent
# calibration_signal_present=true  (threshold = 20.00%)
```

Top-5 margins (sorted desc): 7.17, 3.99, 3.96, 3.77, 3.75 — **5/5
correct**. Bottom-5 margins: 0.19, 0.40, 0.57, 0.72, 0.96 — 3/5
correct (tasks 14 `Sort {3,1,2}` margin=0.19, 17 `fib memo`
margin=0.40, 12 `O(log n)` margin=0.96 all correct despite low
margin; tasks 6 `smallest prime`→`1` margin=0.57 wrong; task 7
`continents`→`6` margin=0.72 wrong). The signal direction is
unambiguous — high-margin tasks are reliably correct on this
manifest, low-margin tasks include the failures.

### vs cycle-2 d_confidence_gated

| surface | confidence source | best | full 20/20? | dominated by length? |
|:--------|:------------------|:-----|:-----------:|:--------------------:|
| cycle-2 (claude --bare -p) | DLG-mk0 heuristic classifier | 55.59% saving @ 19/20 (τ=0.9) | no | yes (length 70.10% @ 20/20) |
| cycle-5 (llama-server HTTP) | first-token logprob margin (top1−top2) | margin_corr_signal=53.33% | n/a (no stronger tier yet) | n/a |

Cycle-2 reported a **saving %** because both tiers existed on the
claude --bare -p surface (haiku/sonnet/opus). Cycle-5 reports a
**signal-presence verdict** instead — SANDBOX has only the Stage-0
base (Qwen2.5-0.5B) live; the cycle-1 length-router's "escalate"
tier has no SANDBOX counterpart yet (`d_stage1_persona`
dead-on-manifest, all 3 personas score 20/20 — no spread). The
SIGNAL is what we measure; the SAVING-% measurement is gated on
Stage 1 multi-base or Stage 4 multi-scale grid landing first.

### Honest limits

1. **N=20, 5 wrong rows** — quartile delta is power-limited.
   Direction + magnitude only, no p-value claim. Stage 2 manifest
   N≥2000 needed for proper signal test + Platt-scaling fit.
2. **No saving-% number** — there is no stronger tier in SANDBOX
   yet (`d_stage1_persona` dead-on-manifest). d_logit_calibration
   confirms the SIGNAL exists; integrating with routing policy
   requires multi-base or multi-scale grid before $/task delta is
   measurable.
3. **Overall accuracy 15/20 here vs cycle-4's 16/20** — the gap is
   task 6 `Smallest prime` → `1`, which cycle-4's
   `stage3_maxtokens_cap` byte-exact_subset substring scorer
   false-positive-matched (kw=`2` ⊂ output text containing other
   `2`s in subsequent prose). The chat-completion endpoint emits a
   minimal `1` (no prose), so the false-positive surface is gone —
   this cycle's 15/20 is the cleaner baseline.

### Artifacts

- bench — `bench/sandbox_stage3_logit_calibration.hexa`
- per-task — `.verdicts/sandbox/stage3_logit_calibration.tsv`
- summary — `.verdicts/sandbox/stage3_logit_calibration_summary.txt`
- CLI-flag probe — `.discoveries/sandbox-logprob-flags.raw`
- discovery flip — `.discoveries/sandbox.tape` (d_logit_calibration
  candidate → confirmed)

Cumulative SANDBOX state: **4 confirmed** · **2 dead** · **10
candidates remaining**.

---

## 2026-05-24 — Stage 2 manifest factory — N=2000 stratified across 5 wc buckets

`bench/sandbox_stage2_manifest_gen.hexa` lands the SANDBOX.md
§Stages-row-2 deliverable: a pure-deterministic local generator that
emits `N=2000` prompts stratified across five word-count buckets in
`wc ∈ [5, 200]`. Triggered by the Stage 1 finding (commit `ef759cf`,
2026-05-23) — nano/mid/max all scored 20/20 on the canonical
20-task manifest, `tier_separation_observed=false`,
`routing_simulation_viable=false`. The canonical manifest is too
saturated to exercise any tier signal; Stage 2 is the BLOCKING
dependency for every downstream tier-routing simulation
(`d_cache_aware_local`, `d_logit_calibration` saving-% gate,
`d_kv_prefix_share_persistent`, `d_quantization_tier`).

This is a **manifest factory, NOT a measurement bench** — no
llama-completion / llama-server dispatched, no model touched, $0
cost, deterministic re-runs produce a bit-identical TSV. The
generator runs in <30s wall and writes 2001 lines (1 header + 2000
rows) to `.verdicts/sandbox/stage2_manifest.tsv`.

| stratum    | wc range  | n   | wc_min | wc_max | wc_mean | difficulty | template family |
|:-----------|:---------:|:---:|:------:|:------:|:-------:|:----------:|:----------------|
| wc_5_15    |  [5, 15]  | 400 |   5    |   11   |   6.6   |     1      | A+B sum, A*B product, Capital-of, Reverse-word, "A plus B equals which integer" |
| wc_16_30   | [16, 30]  | 400 |  18    |   19   |  18.5   |    1-2     | "Compute the sum of integer A and integer B …" / "Multiply integer A by integer B …" |
| wc_31_60   | [31, 60]  | 400 |  31    |   57   |  43.7   |     2      | 3-operand chain `(a+b)*c` + FILL clauses |
| wc_61_100  | [61, 100] | 400 |  63    |   99   |  78.8   |    2-3     | 3-operand chain + extra FILL padding |
| wc_101_200 |[101, 200] | 400 | 102    |  194   | 146.2   |     3      | 4-operand chain `(a+b)*c-d` + SCAFFOLD preamble + FILL padding |
| **total**  |           |**2000**|      |        |         |            | |

Verifier:

```
# total_n=2000
# per_stratum_min_100=true
# wc_ranges_non_overlap=true
# stratification_viable=true
```

Padding mechanic: each non-trivial stratum starts from a fixed base
prompt (e.g. wc_31_60 base `"Take integer {a}, add integer {b},
then multiply the running total by integer {c}, and reply with the
final integer answer."`, base_wc=22) and appends deterministic FILL
clauses from a 12-entry pool until the running wc enters a band
`[target_min, target_min+5]` inside the stratum. The padder is
**overshoot-safe** — before adding each clause it scans the FILL
pool for the first entry whose wc would NOT push the total past
`stratum_max`; the first pass produced wc_31_60 max=66 (overshoot),
the second-pass clamp lands max=57 cleanly.

Every prompt carries a known-correct `expected_kw` substring (e.g.
arithmetic answer, capital name, reversed string). Determinism is
parameter-grid based — no RNG — same Hexa runner invocation
reproduces the manifest bit-identically (verified by re-running:
identical row count, identical per-stratum wc histograms).

Honest residuals (g5 / cycle-5 conventions):

- **Substring-scorer fragility for short kw.** Many arithmetic
  answers are 1-3 digit integers; `byte_exact_subset` of "12" will
  false-positive against any answer text containing "12" anywhere
  (including "120", "1234"). This is the same scorer artifact as
  the cycle-4 trailer-leak (`stage3_maxtokens_cap` 19/20→16/20) and
  the cycle-5 logit_calibration false-positive note — INHERENT to
  the byte-exact_subset scorer, not new to Stage 2. Downstream
  measurement benches inherit this; any future scorer-tightening
  cycle (e.g. exact-line, regex anchor) applies uniformly.
- **wc_16_30 wc range is narrow (18-19).** Both templates in this
  stratum produce wc ≈ 18, so the empirical wc range is only 2
  values wide; still strictly within the [16, 30] band, but
  diversity is template-bound. Acceptable for Stage 2's purpose
  (escape wc≤14 saturation) but documented honestly.
- **Strata 3-5 share the same arithmetic chain.** The 3-operand
  `(a+b)*c` core repeats across wc_31_60 and wc_61_100 with
  different padding lengths; wc_101_200 extends to 4 operands. The
  manifest exercises wc-bin separation cleanly but does NOT
  exercise diverse reasoning domains (no NL summarization, no code
  generation, no adversarial). That diversity expansion is a
  future-cycle deliverable; Stage 2 here closes the wc-saturation
  axis specifically (the BLOCKING dependency Stage 1 surfaced),
  per the cycle-5 task scope.
- **Deduplication is structural.** All 2000 prompts are unique
  (verified `sort -u | wc -l = 2000`) because the parameter grids
  in each template don't overlap and the FILL/SCAFFOLD picks vary
  by stratum index.
- **No model dispatch in this cycle.** Stage 2 manifest-on-personas
  rerun (Stage 1 redo at scale) is a SEPARATE successor cycle, NOT
  this one. The factory is a prerequisite, not a measurement.

Persisted:

- `bench/sandbox_stage2_manifest_gen.hexa` — generator source (hexa-only).
- `.verdicts/sandbox/stage2_manifest.tsv` — 2001 lines (header +
  2000 stratified rows; idx · word_count · stratum · prompt ·
  expected_kw · expected_difficulty).
- `.verdicts/sandbox/stage2_manifest_summary.txt` — per-stratum
  count + wc min/max/mean + viability gates.
- `.discoveries/sandbox.tape` — `d_stage2_scale_manifest` flipped
  candidate → **confirmed [verified_tier=GREEN cost_actual=$0]`;
  footer cumulative tally updated.

Cumulative SANDBOX state: **5 confirmed** (d_stage0_poc ·
d_early_stop_local · d_prompt_compress_local[max_tokens_cap_only] ·
d_logit_calibration · d_stage2_scale_manifest) · 2 dead
(d_stage1_persona · d_kv_prefix_share) · 9 candidates remaining.

---

## 2026-05-24 — scorer-fix rebaseline — Stage 0/1/3 verdicts cleaned

The cycle-4 `sandbox_stage3_maxtokens_cap.hexa` bench (commit `d79306e`)
discovered that the Stage 0 / Stage 1 / Stage 3 KV-prefix benches had a
**scorer artifact**: stderr `[end of text]` + `common_perf_print:` trailer
from `llama-completion` leaked into the substring-match scorer because the
`awk` extractor ran from `^assistant$` to `^> EOF by user` without stripping
the perf trailer that appears before EOF in single-turn `-st` mode.

`sandbox_stage3_earlystop_local.hexa` had a partial fix (line-based
`/^common_perf_print/{flag=0}` in awk) that incidentally produced the
correct accuracy; `sandbox_stage3_maxtokens_cap.hexa` had the canonical
sed-based fix (`sed 's/ *\[end of text\].*$//' | sed 's/ *common_perf_print:.*$//'`).

This rebaseline patches all 4 buggy benches to the canonical sed-strip
pattern (atomic, single commit) and reruns them. Awk/sed block changed
only; rest of each `run_one()` preserved verbatim.

| bench | old accuracy | new accuracy | flipped task indices |
|---|---|---|---|
| Stage 0 baseline | 19/20 | **16/20** | tasks 7, 10, 18 (ans=6/28/"=42 decimal" → kw "7"/"29"/"13" no longer match perf-line digits) |
| Stage 1 persona — nano | 20/20 | **17/20** | tasks 7, 10, 18 |
| Stage 1 persona — mid  | 20/20 | **18/20** | tasks 7, 10 (task 18 still passes because the working-line answer ranges over the digits) |
| Stage 1 persona — max  | 20/20 | **17/20** | tasks 7, 10, 18 |
| Stage 3 early-stop local | 16/16/16/0 (4 strats) | **16/16/16/0** (no change — awk strip was sufficient) | none |
| Stage 3 KV-prefix — cold | 19/20 | **16/20** | tasks 7, 10, 18 (+ task 8 ans="0" kw="100" now correctly fails; was already at 19/20 before so net cold flips = -3) |
| Stage 3 KV-prefix — warm | 19/20 | **17/20** | tasks 10, 18 (task 7 now passes warm: kw "7" matches the model's full answer text including digit 7 in this run; cache replay drift across runs) |

**Tier separation now actually observed** in Stage 1: `ms_ladder = true`
(nano 25.7s < mid 46.7s < max 176.4s on this rerun), `spread_tasks = 1`,
`routing_simulation_viable = true`. The trailer artifact had been masking
real tier behavior — the 20/20 ceiling was scorer-saturation, not model
saturation. Stage 1 verdict is now **partially revised**: persona dispatch
+ scorer parity still work mechanically; routing simulation is **viable
on cold-baseline accuracy** but the spread (1 task / 5pp) is still tight
— Stage 2 (scaled stratified manifest) remains the right successor.

**Substantive verdict-headline impact** (kept honest, no candidate
state flipped):
- d_stage0_poc — confirmed → confirmed (clean baseline 16/20 still
  clears usable floor `>= 15/20`).
- d_stage1_persona — dead-on-manifest → still dead, but now with
  routing_simulation_viable=true (the manifest still saturates at
  ≤3-task spread; Stage 2 dependency unchanged).
- d_kv_prefix_share — dead [BLOCKED_AT_SCALE] → still dead at same
  threshold (warm_speedup_pct 13.30% < 20% target on rerun; cold 16/20
  vs warm 17/20 within run-to-run cache-replay noise).
- d_early_stop_local — confirmed → confirmed (no change; awk strip
  was already correct).
- d_prompt_compress_local — confirmed [scope=max_tokens_cap_only] →
  unchanged (this bench had the canonical strip from the start).

**Cycle-4 honest_note_2 in `stage3_maxtokens_cap_summary.txt` is now
RESOLVED.** The artifact it disclosed has been removed from the
upstream benches; the Stage 0 / Stage 1 / KV-prefix verdicts now agree
with the Stage 3 max_tokens_cap reading. Verdict refs throughout
`.discoveries/sandbox.tape` still point at the same paths — the
files have been rewritten in place with clean numbers.

Persisted:
- All 4 benches modified with `// SCORER FIX 2026-05-23: ...` header
  block + sed trailer-strip in `run_one()`.
- `.verdicts/sandbox/stage0_accuracy_floor*` — rewritten (16/20).
- `.verdicts/sandbox/stage1_persona*` — rewritten (17/18/17).
- `.verdicts/sandbox/stage3_earlystop_local*` — rerun (no accuracy
  change; wall_ms numbers refreshed).
- `.verdicts/sandbox/stage3_kvprefix*` — rewritten (16/17).

Cumulative SANDBOX state UNCHANGED by this rebaseline (5 confirmed ·
2 dead · 9 remaining after Stage 2 + logit calibration landed in
parallel commits 91ac831 + c7e03a5). No candidate state flipped by
the scorer-fix itself — the rebaseline only cleans the numbers that
the existing verdict refs point at. **However:** the Stage 1
rebaseline reveals `tier_separation_observed=TRUE` and
`routing_simulation_viable=TRUE` (the trailer artifact had been
masking real tier behavior under saturation); the
"dead-on-manifest" verdict for `d_stage1_persona` is now itself
suspect and should be revisited in a future cycle — the spread is
tight (1 task / 5pp) but real, so Stage 2 manifest dependency
remains the right successor.

## 2026-05-24 — Stage 4 JSON-schema-constrained decoding (cycle-6)

**d_json_schema_constrained — PARTIAL / dead at the 30% threshold
(substrate lever ALIVE, hypothesis missed at the scale of the
canonical 20-task manifest).**

`bench/sandbox_stage4_json_schema.hexa` boots `llama-server` once on
port 8083 (sibling-agent-disjoint from 8081/8082), POSTs the canonical
20-task manifest through `/v1/chat/completions` under three strategies,
and tears the server down on exit:

1. `unconstrained` — no `response_format`, REFERENCE.
2. `json_object` — `response_format: {"type":"json_object"}`, loose hint.
3. `json_strict` — `response_format: {"type":"json_schema","json_schema":
   {"schema":{"type":"object","properties":{"answer":{"type":"string"}},
   "required":["answer"]}}}` — STRICT grammar.

Pre-bench probe (`.discoveries/sandbox-llama-server-jsonschema.raw`)
confirmed `llama-server b9150` accepts BOTH levels; the strict-schema
mode bit-for-bit enforces the grammar (returns `{"answer":"4"}`), the
json_object mode is a HINT only (returned bare prose `2+2 equals 4.`
when only the `type:json_object` flag was set without a JSON-shape
instruction).

Results (`.verdicts/sandbox/stage4_json_schema_summary.txt`):

| strategy        | correct | total_wall_ms | total_out_tok | avg_tok | fallback_rows |
|:----------------|--------:|--------------:|--------------:|--------:|--------------:|
| unconstrained   |  15/20  | 17 185        | 625           |  31.2   | 0             |
| json_object     |  14/20  | 14 335        | 591           |  29.5   | 7             |
| json_strict     |  14/20  | 13 853        | 512           |  25.6   | 2             |

- `json_object_output_tok_reduction_pct = 5.44%`
- `json_strict_output_tok_reduction_pct = 18.80%`
- `json_object_wall_ms_reduction_pct    = 16.58%`
- `json_strict_wall_ms_reduction_pct    = 19.38%`
- `accuracy_preserved = false` (both modes lost 1 task vs unconstrained)
- `llama_server_json_schema_exposed = true`
- `reduction_target_pct = 30`

**Verdict: DEAD AT THE THRESHOLD.** The hypothesis required ≥30%
output-token reduction at preserved accuracy. `json_strict` got the
best numbers but landed at 18.80% (substantially short of 30%) AND
lost task #11 (`sum(range(...))` → emitted
`for i in range(1, 101): print(i)` — the JSON wrapper appears to
perturb the decode trajectory enough to flip a code-style choice on
a borderline task). `json_object` mode was weaker: 5.44% tok
reduction AND 7/20 rows came back wrapped in markdown fences
(` ```json {…} ``` `) that broke the `.answer` jq parse — the model
is hint-mode-prone to its training distribution (markdown-fenced
JSON), not bare JSON.

**Failure-mode honesty:**

1. For SHORT bare answers (1-5 tokens — the bulk of the manifest's
   arithmetic / one-word strata), the JSON wrapper ADDS framing
   tokens (`{"answer":"4"}` is ~6 tokens vs raw `4` is ~1 token).
   The 30% reduction hypothesis silently assumed a VERBOSE
   unconstrained baseline, but Qwen2.5-0.5B-Instruct already obeys
   `Reply with the digit only` tightly — there is no prose padding
   to amputate.
2. The savings the bench DID measure (18.80% tok / 19.38% wall) come
   from the long-tail tasks (#15 TCP-vs-UDP 85→29 tok, #19 mergesort
   56→56, #20 halting 96→96) where strict mode truncates the prose
   tail. But these tasks are a minority of the manifest.
3. `json_object` hint mode is too weak to be useful without
   `system`-prompt scaffolding telling the model to emit bare JSON.

**Scope where this might still win:** Stage 2's longer-tail
synthetic tasks (story generation, multi-paragraph explanations)
where prose padding dominates the token budget. Flagged in
`.discoveries/sandbox.tape` as `REVIVAL_CANDIDATE_AT_STAGE_2`.

**Hygiene:** server PID captured in
`/tmp/sandbox_stage4_llama_8083.pid`;
`pkill -f 'llama-server.*8083'` runs in `teardown_server()` AND as
a pre-launch sweep; `lsof -i :8083` post-run shows the port freed.

Persisted:

- `bench/sandbox_stage4_json_schema.hexa` (new) — server-mode bench
  using the `nohup llama-server &` pattern + `curl --data-binary` +
  `jq` over the OpenAI-compatible `/v1/chat/completions` route.
- `.verdicts/sandbox/stage4_json_schema.tsv` — 60 rows
  (3 strategies × 20 tasks).
- `.verdicts/sandbox/stage4_json_schema_summary.txt` — aggregate.
- `.discoveries/sandbox-llama-server-jsonschema.raw` — pre-bench
  probe showing the substrate's response_format surface accepted
  both modes.
- `.discoveries/sandbox.tape` — `d_json_schema_constrained` flipped
  from CANDIDATE → DEAD with
  `verdict=PARTIAL_BLOCKED_AT_THRESHOLD` ref.

Cumulative SANDBOX state: 5 confirmed · 3 dead (added
d_json_schema_constrained at threshold) · 8 candidates remaining.

---

## 2026-05-24 — cycle-6 Stage 4 — two server-mode wins + a difficulty cliff

Three benches dispatched in parallel (json-schema logged above). All
on Qwen2.5-0.5B-Instruct-Q4_K_M, mac-mini-m3, $0. The two
`llama-server` long-lived-process benches both landed strong wins;
the Stage 1 reopen surfaced a model-capability cliff.

**⭐ `d_kv_prefix_share_persistent` — CONFIRMED, cycle-4 BLOCKED_AT_SCALE fully reversed.**
The cycle-4 one-shot CLI floor (~3-4 s Metal-init + GGUF mmap per call
dwarfing the 530 ms prefix-eval saving) collapses once the server is
long-lived:

| strategy | total wall | avg/task | accuracy |
|:---|---:|---:|:---:|
| `cold_cli` (cycle-4 mode) | 98 594 ms | 4 929 ms | 16/20 |
| `warm_server_no_prefix` | 17 362 ms | 868 ms | 15/20 |
| `warm_server_with_prefix` | 10 142 ms | 507 ms | 17/20 |

`warm_server_with_prefix` vs `cold_cli` = **89.71%** wall reduction
(gate: 20%). Prefix lever isolated (with- vs no-prefix) = 41.58%.
`cached_tokens_sum_after_first=6992` (368 tok/call = full hit on the
376-tok shared prefix). Accuracy parity holds (17 ≥ 16).

**`d_continuous_batching_server` — CONFIRMED at +30.65%, cycle-1 50% target honestly missed.**
`llama-server -np N -cb`, batch wall-clock over the 20-task manifest:

| -np | batch wall | speedup vs np1 | accuracy |
|:---:|---:|---:|:---:|
| 1 | 14 518 ms | — | 15/20 |
| 2 | 12 204 ms | +15.93% | 15/20 |
| **4** | **10 068 ms** | **+30.65%** | 15/20 |
| 8 | 12 878 ms | +11.29% | 15/20 |

np4 is the sweet spot; np8 is 27.9% *slower* than np4 — UMA
memory-bandwidth saturation on the M3 (the predicted failure mode).
All hold 15/20. cycle-1 `d_batch_amortized` (BLOCKED — no batch
surface on `claude --bare -p`) is now substrate-confirmed: the
vendor's 50% discount is a pricing decision atop this physical
mechanism, which here yields +30.65% at $0. The 50% target needs a
larger model + longer-output strata where decode dominates setup.

**`d_stage1_persona_at_scale` — tier separation real but routing not viable; difficulty cliff found.**
Re-ran the 3 personas on 150 Stage-2 tasks (30/stratum). nano 33% ≈
mid 34% ≈ max 36% (spread 4 tasks). `tier_separation_observed=true`
(per-stratum ranking differs) but `routing_simulation_viable=false`
(< 3pp gate). The dominant signal is a **capability cliff**:

| stratum | nano | mid | max |
|:---|:---:|:---:|:---:|
| wc_5_15 | 73% | 86% | 90% |
| wc_16_30 | 86% | 83% | 86% |
| wc_31_60 | 6% | 3% | 3% |
| wc_61_100 | 0% | 0% | 0% |
| wc_101_200 | 0% | 0% | 0% |

Qwen2.5-0.5B cannot solve the wc≥31 multi-step arithmetic strata at
all. So cycle-4's "dead-on-manifest" has a NEW root cause at scale —
not saturation (too easy) but a model-capability cliff (too hard
above wc=30). A real routing simulation needs a larger base (Stage 4
scale ladder) or a Stage-2b manifest whose long strata stay within
0.5B capability.

Cumulative SANDBOX state: **7 confirmed** (d_stage0_poc ·
d_early_stop_local · d_prompt_compress_local · d_logit_calibration ·
d_stage2_scale_manifest · d_kv_prefix_share_persistent ·
d_continuous_batching_server) · 3 dead (d_stage1_persona ·
d_kv_prefix_share · d_json_schema_constrained) · 6 candidates
remaining. d_stage1_persona_at_scale ran but is inconclusive (cliff
blocks routing signal — gated on a larger base model).

## 2026-05-24 — M1.SAFETY interface SHIPPED, self-test BLOCKED_AT_BUILD (honest gap)

`lm_foundry/tool/activation_capture.hexa` (interface only, no bench
execution) landed as the SAFETY-side substrate entry point, modelled
on `lm_foundry/tool/route_dispatch.hexa` (commit `b376590`). One
public function:

```
capture_activations(prompt, model_path, layers, capture_kinds,
                    n_probs, out_path) -> status\ttotal_tokens\t
                                          bytes_written\tschema_version
```

TSV schema v1 (one row per (token, layer, capture_kind)):

```
token_idx · layer · kind · activation_dim_or_token · value · model · schema_version
```

Self-test (no `llama-server` spawn, no network) probes the stock
Homebrew `llama-server --help` surface for the two CLI flags the
intermediate-tap path requires:

| flag | matches in `llama-server --help` |
|:-----|---:|
| `--logits-all` | 0 |
| `--n-probs` | 0 |

Both absent → self-test verdict = **`BLOCKED_AT_BUILD`** (same family
as cycle-4 `d_kv_prefix_share` BLOCKED_AT_SCALE — the wrapper still
ships; the downstream signal is honest). The logprob HTTP-body path
remains live (cycle-5 `d_logit_calibration` proved
`/v1/chat/completions` with `logprobs=true · top_logprobs=N` works
end-to-end); only the residual / attn / mlp intermediate-tensor taps
that SAFETY's interpretability falsifier class needs are gated on a
forked llama.cpp build with a ggml-graph hook.

M1.SAFETY checkbox stays `[ ]` (per the BLOCKED_AT_BUILD honesty
rule), now annotated with the forked-build dependency. The
`d_activation_capture_pipeline` candidate in
`.discoveries/sandbox.tape` flips candidate → confirmed with
`actual_tier=PARTIAL`: interface ships, logprob path live, intermediate
taps gated on fork. Consumer reference per `SAFETY.log.md` 2026-05-24
entry (commit `a233bff`) — SANDBOX is the only viable surface for
SAFETY interpretability work.

Cumulative SANDBOX state: **8 confirmed** (added
`d_activation_capture_pipeline` PARTIAL — interface-only) · 3 dead · 5
candidates remaining.

## 2026-05-24 — M3.ECON F-CODEX-1/2 empirical-fit harness shipped (closed-form, harness-only)

Shipped `verify/numerics_economics_empirical_landing.hexa` — the
M3.ECON closed-form audit surface for the F-CODEX-1 (training-cost
`∝ N^σφ`) and F-CODEX-2 (inference-cost `∝ context^τ`) empirical
landings. Modelled on `verify/numerics_economics_pareto_floor.hexa`
(commit `5bbb9ad`) — same T1/BLUE structure: literal `let` tables of
empirical rows at the top, closed-form math middle, 10 checks +
per-check PASS/FAIL bottom. Pure `math_pure` (`log_pure`, `pow_pure`,
`abs_pure`) — no inference, no API, no exec subprocess.

Constants table (cross-checked against
`verify/numerics_economics_scaling_laws.hexa` for n=6-lattice
consistency):

| const | value | source |
|:------|:------|:-------|
| `N6_EXP_TRAIN` | 24/25 = 0.96 | F-CODEX-1 — `σ·φ / (σ·φ + 1)` |
| `TAU_INFER` | 4 | F-CODEX-2 — `τ(6) = 4` |
| `EPS_RESIDUAL_THRESHOLD` | 0.10 | BLUE-tier pass gate |

Data ladder (4 scale points × 5 wc-strata):

| scale | row | state | source |
|:------|:----|:------|:-------|
| 0.5B | `[0.9000, 0.8667, 0.0667, 0.0000, 0.0000]` | LIVE | cycle-6 verbatim (`stage2_persona_scaled_summary.txt` per-stratum max{persona}) |
| 1.5B | `[-1, -1, -1, -1, -1]` | PENDING | M2.SUBSTRATE bench rerun (sibling agent this cycle batch) |
| 3B | `[-1, -1, -1, -1, -1]` | PENDING | `d_qwen_3b_scale` candidate (gated on cliff-clearance) |
| 7B | `[-1, -1, -1, -1, -1]` | PENDING | Stage-4 RunPod cloud bridge |

The `-1.0` sentinel is the explicit `PENDING_M2_SUBSTRATE_VERDICT`
marker; `fit_exponent()` filters those rows out and returns
`NAN_SLOPE = -999.0` when fewer than 2 valid `(x, y)` pairs survive.
With `k_active = 1` today, both F-CODEX-1 and F-CODEX-2 fits are
deferred → verdict-line `🟠 INSUFFICIENT — empirical data PENDING on
3 of 4 scale points (1.5B/3B/7B)`, exit code 0 (honest-defer per g5,
not a structural fail).

10-check skeleton (today's expected outcome):

```
01  scale_grid_monotone                       PASS
02  scale_grid_length_4                       PASS
03  0_5b_row_live_and_in_band                 PASS
04  0_5b_mean_reconciles_cycle6  (≈ 0.3667)   PASS
05  0_5b_wc_5_15_max_27_30                    PASS
06  theoretical_constants_24_25_and_4         PASS
07  pending_sentinel_detected_k_active_1      PASS
08  f_codex_1_residual_DEFERRED               PASS  (NAN_SLOPE)
09  f_codex_2_residual_DEFERRED               PASS  (LATENCY_MS_PENDING)
10  verdict_line_INSUFFICIENT                 PASS
```

Placeholder verdict file at
`.verdicts/sandbox/m3_econ_empirical_landing.txt` marks
`status=harness-written-not-yet-empirical`. **SANDBOX.md M3.ECON
checkbox STAYS `[ ]`** — per the cx_empirical_contact honesty rule,
the M3.ECON gate flips `[ ] → [x]` only when `k_active == 4` (all 4
ladder rungs measured) AND both residuals `≤ ε = 0.10`. The sibling
M2.SUBSTRATE bench rerun on the 1.5B base in this cycle batch
advances `k_active` from 1 to 2 (still INSUFFICIENT, but begins the
fit), and downstream Stage-4 work fills 3B/7B.

`.discoveries/sandbox.tape` `d_stage4_empirical_landing` flipped
`candidate → harness_ready` (same family as cycle-7
`d_activation_capture_pipeline` PARTIAL and cycle-8
`d_slo_under_load` `harness_only`). Cost $0, wall <1 s.
