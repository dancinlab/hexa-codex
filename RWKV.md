# RWKV — attention-free RNN LLM evaluation (domain SSOT)

@goal: Empirically validate RWKV's core architectural claims — linear-time inference and constant memory (no KV-cache) — on the self-hosted SANDBOX substrate against a Transformer baseline, and land a closed-form memory/latency-vs-context law.

> Rides on the SANDBOX measurement substrate (sibling domain). Source: https://www.rwkv.com/
> RWKV = 100%-attention-free RNN with Transformer-level quality; claims linear-time inference,
> constant space (no KV-cache), infinite context. Latest: RWKV-7 "Goose" (2.9B / 7.2B), RWKV-8 WIP.
> Linux Foundation AI project. Runnable via llama.cpp / rwkv.cpp GGUF on the substrate.

## Milestones

- [x] M1 Surface — RWKV-7 "Goose" World3 2.9B SERVED on the substrate at $0 local + 20-task canonical-manifest accuracy floor measured. **Engine (the load-bearing unblock): RWKV-7 is NATIVELY supported by stock brew llama.cpp 9150** (`general.architecture = "rwkv7"`, 902 tensors, ctx_len 1048576, embd 2560, 32 blocks) — NO rwkv.cpp build, NO conversion needed. GGUF = community mirror `Mungert/RWKV7-Goose-World3-2.9B-HF-GGUF` q5_k_m (2.13 GB), official source `RWKV/RWKV7-Goose-World3-2.9B-HF` (LF AI & Data project, arxiv 2503.14456). Loads + decodes COHERENTLY on Metal/UMA GPU ("capital of France is Paris.") @ ~13 tok/s. **Two engine gotchas (verified before benching, both honest):** (1) the GGUF's built-in jinja `chat_template = "rwkv-world"` is BROKEN on this engine — `--jinja` leaks the literal template name + decodes garbage ("rwkv-world-cup-2022-qatar-..."), so we DO NOT use `--jinja`; instead the model's native plain `"User: <prompt>\n\nAssistant:"` frame, parsed `assistant_prefix` + cut at next `User:` (the World model is a base/continuation model, keeps generating after the answer). (2) llama-cli's `-no-cnv` is unsupported (use llama-completion — same tool BitNet used). Engine VERIFIED working. **Floor (honest POSITIVE): 15/20 = 75.0%** on the SAME 20-task manifest where BitNet 2B4T = 6/20 = 30% and clean Qwen2.5-0.5B-Q4 = 16/20 = 80% — RWKV-7 2.9B **HITS the usable floor (≥15/20)**, far above BitNet, just 1 task below the 4-bit 0.5B Qwen baseline. **Peak RSS = 2249 MB** on Metal/UMA, **flat ~2353–2358 MB across all 20 tasks** (RNN, NO KV-cache — the M2 constant-memory baseline directly visible in the per-task RSS column). Total wall 158,858 ms (~7.9 s/task incl. per-invocation Metal warmup). **5 misses, honestly characterized:** 2 are World/base-model language-drift to Chinese on number-only prompts (idx10 "days in Feb 2024", idx14 "sort {3,1,2}" — the World tokenizer is heavily multilingual); 1 is a harness PARSE_ERROR on idx17 (tab-laden Fibonacci code broke the 6-field split — counted conservatively as WRONG, NOT a model failure); only idx7 (continents → "5") + idx8 (boiling point → off-topic prose) are genuine factual model errors. A strict-language system prompt would likely recover idx10/idx14 — logged as an M1+ next-cycle seed, NOT silently re-scored (g5/R6 honesty). `bench/rwkv_m1_accuracy_floor.hexa` (20-task manifest + byte_exact_subset scorer VERBATIM from `bench/bitnet_m1_accuracy_floor.hexa` / `sandbox_stage0_baseline.hexa`, only the engine call + prompt frame differ) · `.verdicts/rwkv/m1_accuracy_floor_summary.txt` + `.tsv`. (cx_empirical_contact T4; no `--expr` recompute path — the bench IS the recompute surface, 🟠 DEFERRED per `hexa verify rubric`.)
- [ ] M2 Constant-memory — resident memory vs context length: RWKV flat vs a Transformer's KV-cache O(n) growth (falsifier: RWKV resident memory grows with context length beyond a flat band)
- [ ] M3 Linear-time — per-token + prefill latency vs context length: RWKV O(n) vs Transformer O(n²) prefill (falsifier: RWKV latency superlinear in context)
- [ ] M4 Paper — RWKV canonical paper (§formula + bench + benefit) once a closed-form memory/latency-vs-context law lands (cx_paper_gate)
- [ ] M5 Verdict — release/verdict: the measured RWKV memory + latency laws vs the Transformer baseline, registered

## Cross-refs

- [`SANDBOX.md`](SANDBOX.md) — the self-hosted measurement substrate this domain runs on
- [`OPS.md`](OPS.md) — the SLO/latency consumer of the RWKV linear-time result
- https://www.rwkv.com/ — upstream architecture + claims (domain seed)
