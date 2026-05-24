# BITNET — Microsoft 1.58-bit (ternary) LLM evaluation (domain SSOT)

@goal: Empirically characterize Microsoft BitNet b1.58 (1.58-bit ternary-weight LLM) on the self-hosted SANDBOX substrate — accuracy / memory / latency vs full-precision baselines — and confirm-or-refute the atlas BT-77 quantization claim by recompute.

> Rides on the SANDBOX measurement substrate (sibling domain). Seed: atlas `BT-77`
> ("BitNet Quantization n=6 — 2B4T 25/26 EXACT, 3 models × 2 teams, 40/41 total", `[10*]`).
> BitNet b1.58 = weights ∈ {-1, 0, +1} (~1.58 bits/weight); claims near-fp16 quality at a
> fraction of memory/energy. Runnable via `bitnet.cpp` / `llama.cpp` GGUF (BitNet b1.58 2B4T).

## Milestones

- [x] M1 Surface — BitNet b1.58 2B4T SERVED on the substrate at $0 local + 20-task canonical-manifest accuracy floor measured. **Engine (the load-bearing unblock): the official `microsoft/bitnet-b1.58-2B-4T-gguf` i2_s GGUF does NOT load in stock brew llama.cpp 9150** (ggml type-id 36 collides with `TYPE_IQ4_NL_4_4 REMOVED` — it targets bitnet.cpp, not installed). The $0-local route = download bf16 safetensors (`microsoft/bitnet-b1.58-2B-4T-bf16`, 4.83 GB) → convert to **TQ2_0** (llama.cpp native 2.06-bpw ternary, file-type 37, 332 tensors / 210 tq2_0) via brew `convert_hf_to_gguf.py` with three local one-off bridges for the 2B4T variant (arch-case `BitNetForCausalLM`→`BitnetForCausalLM`; add `attn_sub_norm`/`ffn_sub_norm` source names; BPE-vocab fallback). Loads + RUNS, but the brew **Metal backend asserts on type 35 (no TQ2_0 GPU kernel) → CPU-only `-ngl 0` (~7.7 tok/s)** + `--jinja` (the "User:/Assistant:" 2B4T template is not a llama.cpp built-in). Engine VERIFIED working. **Floor (honest negative): 6/20 = 30.0%** on the SAME 20-task manifest where clean Qwen2.5-0.5B-Q4 = 16/20 = 80% — BitNet is BELOW the usable floor (≥15/20) AND below the 4-bit 0.5B baseline. Failure mode = the instruct model ignores "reply with X only" and emits verbose/repetitive prose, so the (deliberately unchanged) `byte_exact_subset` scorer misses the keyword even when the fact is present; raw completion (no template) returns EMPTY, so `-st --jinja` is the fair serving mode (30% is a genuine served-instruct number, not template starvation). ~2.0B params @ ~1.58 bits/weight. `bench/bitnet_m1_accuracy_floor.hexa` · `.verdicts/bitnet/m1_accuracy_floor_summary.txt` + `.tsv`. (cx_empirical_contact T4; no `--expr` recompute path — the bench IS the recompute surface.)
- [x] M2 Memory — resident-memory (RSS) profile captured in the same serving session. **BitNet-TQ2_0 peak RSS = 1568 MB (CPU)** vs **Qwen2.5-1.5B-Q4 = 1944 MB (Metal, as-served) / 2878 MB (CPU, same-backend control)** — ratio **0.55× same-backend**, 0.81× cross-backend. The MEMORY half of "1.58-bit ≈ full quality at a fraction of memory" HOLDS (RSS is a real fraction below the Q4 baseline); the QUALITY half FAILS (M1 accuracy gap 30% vs 80%). **Joint claim FALSIFIED on this substrate** — the falsifier "accuracy gap > ε" fired; the "memory not below the fraction" falsifier did NOT. `.verdicts/bitnet/m2_memory_profile_summary.txt`. (Honest note: BitNet RSS is CPU-mode since the brew build has no TQ2_0 Metal kernel; the same-backend CPU control removes the backend confound.)
- [ ] M3 Pareto — accuracy-per-bit ladder: BitNet 1.58-bit vs Q4 / Q8 / fp16 on the canonical manifest; locate the bit↔quality knee
- [ ] M4 Paper — BITNET canonical paper (§formula + bench + benefit) once a closed-form bit↔quality law lands (cx_paper_gate)
- [ ] M5 Verdict — confirm-or-refute atlas BT-77 (2B4T 25/26 EXACT) on our own substrate by recompute; register the verdict

## Cross-refs

- [`SANDBOX.md`](SANDBOX.md) — the self-hosted measurement substrate this domain runs on
- [`ECONOMICS.md`](ECONOMICS.md) — memory/energy-per-token consumer of the BitNet result
- atlas `BT-77` — the registered BitNet quantization breakthrough (domain seed)
