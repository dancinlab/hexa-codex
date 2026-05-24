# Compile main.pdf — SHIPPABLE. All 4 §verdict-matrix rows are 🟢
# SUPPORTED-NUMERICAL (cx_paper_gate). Expanded to commons g51 (cycle-17):
# 11 pages + 1 fal.ai figure (figures/fig01_cliff_schematic.png). The TikZ
# data figure (fig:cliff-data) renders natively — no pgfplots dependency.

DOC = main
LATEX = pdflatex -interaction=nonstopmode -halt-on-error
BIBTEX = bibtex

.PHONY: all clean distclean

all: $(DOC).pdf

$(DOC).pdf: $(DOC).tex references.bib
	$(LATEX) $(DOC).tex
	$(BIBTEX) $(DOC) || true
	$(LATEX) $(DOC).tex
	$(LATEX) $(DOC).tex

clean:
	rm -f $(DOC).aux $(DOC).bbl $(DOC).blg $(DOC).log $(DOC).out $(DOC).toc

distclean: clean
	rm -f $(DOC).pdf
