# ops-slo-mmc-surface — An M/M/c SLO Surface for Self-Hosted LLM Serving

> OPS-domain canonical paper. The measured 18-cell (-np × offered-rate)
> p50/p95/p99 × accuracy serving surface is the classical M/M/c (Erlang-C)
> multi-server queue: the throughput ceiling tracks c·μ, the latency knee
> shifts right with parallel slots, and a single offered-load violation
> surfaces as an accuracy cliff via two distinct truncation mechanisms.
> Status: g51-ready (10 pages + 1 fal.ai figure). Every numeric claim links
> to a 🟢 SUPPORTED-NUMERICAL verdict under `.verdicts/sandbox/`. RELEASE-READY
> pending a user-gated tag (M5.OPS).

## Source

- `main.tex` — single-column arxiv-style LaTeX (article class, 11pt A4)
- `references.bib` — BibTeX, all entries with DOI / arxiv / URL
- `Makefile` — `make` builds `main.pdf` (pdflatex × 3 + bibtex)

## Build

```bash
make            # → main.pdf
make clean      # remove .aux/.log/.bbl (keep PDF)
make distclean  # also remove PDF
```

## Figures

- `figures/fig01_knee_shift.png` — fal.ai-generated schematic of the M/M/c SLO
  surface (the knee shifting right with the channel count c, and the accuracy
  cliff strip). Included by `main.tex` §Benchmark via `\includegraphics`.
- `figures/_prompts/knee_shift.txt` — the verbatim generation prompt (provenance,
  per the AI-figure honesty convention). The figure caption marks the tool:
  `% generated via fal.ai (openai/gpt-image-2)`.

The figure is illustrative only — every load-bearing number lives in the
verbatim 18-cell grid (Appendix A / `.verdicts/sandbox/m3_ops_full_slo_grid.tsv`)
and the §Formula recompute (Appendix B / `verify/numerics_ops_mmc_knee.hexa`),
never in the artwork.

Regenerate the figure via the sidecar plugin:

```bash
/paper fig landscape_16_9 figures/_prompts/knee_shift.txt figures/fig01_knee_shift.png
```

## Honest stance

- Every claim traces to a bibtex entry with DOI / arxiv / URL.
- Caveats live in `\section{Limitations and honest caveats}` and
  should word-for-word match any companion data record.
- Pre-register thresholds in the methods section — don't pick them
  after seeing results.
