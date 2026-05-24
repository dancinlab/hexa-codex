# BITNET — Microsoft 1.58-bit (ternary) LLM evaluation (domain SSOT)

@goal: Empirically characterize Microsoft BitNet b1.58 (1.58-bit ternary-weight LLM) on the self-hosted SANDBOX substrate — accuracy / memory / latency vs full-precision baselines — and confirm-or-refute the atlas BT-77 quantization claim by recompute.

> Rides on the SANDBOX measurement substrate (sibling domain). Seed: atlas `BT-77`
> ("BitNet Quantization n=6 — 2B4T 25/26 EXACT, 3 models × 2 teams, 40/41 total", `[10*]`).
> BitNet b1.58 = weights ∈ {-1, 0, +1} (~1.58 bits/weight); claims near-fp16 quality at a
> fraction of memory/energy. Runnable via `bitnet.cpp` / `llama.cpp` GGUF (BitNet b1.58 2B4T).

## Milestones

- [ ] M1 Surface — serve BitNet b1.58 2B4T on the substrate (bitnet.cpp / llama.cpp GGUF), 20-task canonical-manifest accuracy floor at $0 local
- [ ] M2 Memory — resident-memory profile vs a Qwen2.5-1.5B-Q4 baseline; test "1.58-bit ≈ full quality at a fraction of memory" (falsifier: accuracy gap > ε OR memory ratio not below the claimed fraction)
- [ ] M3 Pareto — accuracy-per-bit ladder: BitNet 1.58-bit vs Q4 / Q8 / fp16 on the canonical manifest; locate the bit↔quality knee
- [ ] M4 Paper — BITNET canonical paper (§formula + bench + benefit) once a closed-form bit↔quality law lands (cx_paper_gate)
- [ ] M5 Verdict — confirm-or-refute atlas BT-77 (2B4T 25/26 EXACT) on our own substrate by recompute; register the verdict

## Cross-refs

- [`SANDBOX.md`](SANDBOX.md) — the self-hosted measurement substrate this domain runs on
- [`ECONOMICS.md`](ECONOMICS.md) — memory/energy-per-token consumer of the BitNet result
- atlas `BT-77` — the registered BitNet quantization breakthrough (domain seed)
