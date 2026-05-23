# SANDBOX.log.md — measurement substrate history

> History sibling of [`SANDBOX.md`](SANDBOX.md). Per the dancinlab
> root `.md` spec/history split. Repo-wide cycle history shared
> across all groups lives in `CHANGELOG.md` + `.roadmap.hexa_codex`
> §A.3.

---

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
| accuracy | 19/20 (95.0%) |
| total wall-clock | 26.13 s (~1.3 s/task incl. model-load amortization) |
| cost | $0 USD (local serving; `wall_ms` is the proxy cost surface) |
| usable floor reached | **true** (19/20 >= 15/20) |

Stage 0 verdict: self-hosted small-OSS substrate clears the usable
floor on the canonical manifest at 95% — comparable to the baseline
opus 18-19/20 reference, at zero per-call cost. Stage 1 (3-tier
persona via temperature/max-tok on the same single base, mock
haiku/sonnet/opus) is unblocked.

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

Result: **all 3 personas score 20/20 — perfect ceiling saturation.**

- `nano_accuracy = 20/20`  · `nano_total_wall_ms = 123047`
- `mid_accuracy  = 20/20`  · `mid_total_wall_ms  = 104160`
- `max_accuracy  = 20/20`  · `max_total_wall_ms  = 141580`
- `tier_separation_observed = false` (acc_ladder=false ms_ladder=false)
- `routing_simulation_viable = false` (spread_tasks=0)

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
| accuracy_cold | 19/20 |
| accuracy_warm | 19/20 (bit-identical — cache replay does not drift behavior) |
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
| accuracy parity | 10/10 == 10/10 (small manifest) | 19/20 == 19/20 |

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
