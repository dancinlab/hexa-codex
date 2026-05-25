# Constant Memory, Linear Time — measured RWKV-7 vs Transformer context-scaling laws

> hexa-codex SUBSTRATE-group canonical paper (RWKV domain, milestone M4).
> Status: SHIPPABLE — all 4 canonical sections (§Formula · §Method · §Benchmark
> · §Benefit) are linked to a 🟢 SUPPORTED-NUMERICAL verdict per project.tape
> cx_paper_gate. Compiles to 11 pages with 1 fal.ai figure (commons g51 ✓).

## What this paper measures

RWKV-7 "Goose" 2.9B (attention-free RNN, no KV-cache) vs Qwen2.5-0.5B-Instruct
(KV-cache Transformer) on a single Mac mini M3 (stock `llama.cpp` 9150,
Metal/UMA, $0 local), swept over context 512 → 65536 (128×). Four closed-form
laws, each re-derived by deterministic recompute (8/8 PASS):

1. RWKV recurrent state is FLAT at 20.62 MiB (slope 0); Qwen KV-cache is exactly
   `n · 12 KiB/tok` (R²=1). Memory crossover at n ≈ 1760; 4.66× less @ 8192.
2. RWKV prefill is power-law p=0.962 ≈ 1 (R²=0.996); Qwen prefill p=1.366 > 1.
3. RWKV decode is O(1) in depth (ms/tok ratio 1.24×); Qwen decode degrades
   3.55× over the same depth (slope > 0, R²=0.985).
4. Both pre-registered falsifiers (RWKV memory grows / RWKV latency superlinear)
   are NOT triggered.

Honest negative on the record: RWKV's *absolute* prefill is slower than the tiny
quantized Transformer over the whole measured range — the win is in the
exponent + decode + memory, not the prefill constant.

## Verdict links (cx_paper_sections)

| Section     | Verdict glyph        | Path |
|-------------|----------------------|------|
| §Formula    | 🟢 SUPPORTED-NUMERICAL | `.verdicts/rwkv/m2_constant_memory.txt` (L1–L3) · `.verdicts/rwkv/m3_linear_time.txt` (L4–L8) |
| §Method     | 🟢 SUPPORTED-NUMERICAL | `verify/numerics_rwkv_m2m3_laws.hexa` (8/8 recompute) |
| §Benchmark  | 🟢 SUPPORTED-NUMERICAL | `.verdicts/rwkv/m2m3_ctx_sweep.tsv` (27-row sweep) |
| §Benefit    | 🟢 SUPPORTED-NUMERICAL | both verdicts above (crossover + Δ-deltas) |

## Source

- `main.tex` — single-column arxiv-style LaTeX (article class, 11pt A4)
- `references.bib` — BibTeX; every entry an arXiv id / DOI / URL, arXiv ids
  confirmed against the live arXiv API (RWKV-7 2503.14456, RWKV-4 2305.13048,
  Mamba 2312.00752, RetNet 2307.08621, Linear-Transformers 2006.16236,
  Attention 1706.03762, Qwen2.5 2412.15115, PagedAttention 2309.06180, …)
- `figures/fig01_memory_latency_laws.png` — fal.ai (gpt-image-2) schematic;
  prompt in `figures/_prompts/memory_latency_laws.txt`

## Build

```bash
make            # → main.pdf (pdflatex × 3 + bibtex)
# or: /paper compile .
```

## Honest stance

- Every section carries its 🟢 verdict path inline; no number rests on author
  judgement alone — the recompute (`verify/numerics_rwkv_m2m3_laws.hexa`) is the
  source of truth and its verbatim 8/8 stdout is reproduced in Appendix B.
- The prefill-constant caveat is stated without hedging in §Limitations and
  §Benefit; the single-pair / single-substrate / single-quant scope is explicit.
