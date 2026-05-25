# safety-refusal-direction — A Mechanistic Refusal Direction in a Small Instruct Model

> Canonical SAFETY-domain paper (M4.SAFETY). The refusal decision in
> Qwen2.5-1.5B-Instruct is linearly legible in last-prompt-token activation
> norms (AUROC 0.98, leave-one-out 0.825, permutation p=0.005) where the
> first-token logit margin is not. All 4 sections (§Formula·§Method·§Benchmark·
> §Benefit) link 🟢 SUPPORTED-NUMERICAL verdicts; §Formula recompute is
> `verify/numerics_safety_refusal_direction.hexa` against the committed
> numbers-only matrix `.verdicts/sandbox/m2_safety_refusal_norms.tsv`
> (adversarial prompt text redacted per cx_hf_safety_private). M5.SAFETY
> residual (1) RESOLVED (cycle-18): expanded to 11pp + 1 fal.ai figure for g51
> publish-readiness (Background · Related Work · fuller LDA derivation ·
> Discussion · Limitations · Appendix), every numeric claim still on its
> existing 🟢 verdict. Residual (2) — a causal single-direction ablation +
> SAE decomposition (GPU-heavy) — and the release tag remain open.

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

The template ships with one working matplotlib example so `make` produces
a paper that compiles end-to-end out of the box:

- `figures/_scripts/fig01_example.py` — matplotlib bar chart (3 placeholder
  data points). Replace the `DATA` rows + y-axis label + caption with your
  result, then `make figures` to regenerate the PDF.
- `figures/fig01_example.pdf` — the rendered output, included by `main.tex`.

Add `fig02`, `fig03`, ... by copying the `_scripts/fig01_example.py` pattern;
the Makefile picks up `figures/_scripts/*.py` automatically.

Drop other figure sources under `figures/`:

- vector: `.pdf` / `.eps` (preferred for plots)
- raster: `.png` (cover / teaser / AI-generated schematics only)
- TikZ: inline in `main.tex`

For AI-generated figures, keep the verbatim prompt under
`figures/_prompts/<name>.txt` so provenance is reproducible. Mark the
caption with `% generated via <tool> (prompt: figures/_prompts/<name>.txt)`.

Generate a fal.ai cover via the sidecar plugin:

```bash
/paper fig square_hd figures/_prompts/cover.txt figures/cover.png
```

For a richer reference paper with multiple figures, tables, and 18 real
bibtex entries, see `/paper sample <slug>` (copies the bundled
`sample-nb-bcs-absorbed` verbatim).

## Honest stance

- Every claim traces to a bibtex entry with DOI / arxiv / URL.
- Caveats live in `\section{Limitations and honest caveats}` and
  should word-for-word match any companion data record.
- Pre-register thresholds in the methods section — don't pick them
  after seeing results.
