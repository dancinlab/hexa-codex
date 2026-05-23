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
