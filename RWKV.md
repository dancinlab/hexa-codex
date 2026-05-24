# RWKV — attention-free RNN LLM evaluation (domain SSOT)

@goal: Empirically validate RWKV's core architectural claims — linear-time inference and constant memory (no KV-cache) — on the self-hosted SANDBOX substrate against a Transformer baseline, and land a closed-form memory/latency-vs-context law.

> Rides on the SANDBOX measurement substrate (sibling domain). Source: https://www.rwkv.com/
> RWKV = 100%-attention-free RNN with Transformer-level quality; claims linear-time inference,
> constant space (no KV-cache), infinite context. Latest: RWKV-7 "Goose" (2.9B / 7.2B), RWKV-8 WIP.
> Linux Foundation AI project. Runnable via llama.cpp / rwkv.cpp GGUF on the substrate.

## Milestones

- [ ] M1 Surface — serve RWKV-7 "Goose" (2.9B) on the substrate (llama.cpp / rwkv.cpp GGUF), 20-task canonical-manifest accuracy floor at $0 local
- [ ] M2 Constant-memory — resident memory vs context length: RWKV flat vs a Transformer's KV-cache O(n) growth (falsifier: RWKV resident memory grows with context length beyond a flat band)
- [ ] M3 Linear-time — per-token + prefill latency vs context length: RWKV O(n) vs Transformer O(n²) prefill (falsifier: RWKV latency superlinear in context)
- [ ] M4 Paper — RWKV canonical paper (§formula + bench + benefit) once a closed-form memory/latency-vs-context law lands (cx_paper_gate)
- [ ] M5 Verdict — release/verdict: the measured RWKV memory + latency laws vs the Transformer baseline, registered

## Cross-refs

- [`SANDBOX.md`](SANDBOX.md) — the self-hosted measurement substrate this domain runs on
- [`OPS.md`](OPS.md) — the SLO/latency consumer of the RWKV linear-time result
- https://www.rwkv.com/ — upstream architecture + claims (domain seed)
