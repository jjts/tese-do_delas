MAIN     = main
LATEX    = pdflatex
BIBTEX   = bibtex
LATEXMK  = latexmk

# Default: full build with latexmk (handles re-runs automatically)
.PHONY: all clean distclean

all:
	$(LATEXMK) -pdf -interaction=nonstopmode $(MAIN).tex

# Manual multi-pass build (fallback if latexmk is not available)
.PHONY: manual
manual:
	$(LATEX)  -interaction=nonstopmode $(MAIN).tex
	$(BIBTEX) $(MAIN)
	$(LATEX)  -interaction=nonstopmode $(MAIN).tex
	$(LATEX)  -interaction=nonstopmode $(MAIN).tex

# Open the resulting PDF
.PHONY: view
view: all
	xdg-open $(MAIN).pdf &

# Remove intermediate build files
clean:
	$(LATEXMK) -c
	rm -f *.bbl *.run.xml *.glo *.gls *.glg *.loc *.slo *.soc *.xdy *.alg *.acr *.acn

# Remove everything including the PDF
distclean:
	$(LATEXMK) -C
	rm -f *.bbl *.run.xml *.glo *.gls *.glg *.loc *.slo *.soc *.xdy *.alg *.acr *.acn
