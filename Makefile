
MAIN = numero

CLASSFILE = srevuo.cls

.SUFFIXES: .tex .pdf .aux .toc .bbl .bib .md .pandoc

GPP = gpp
GPPMACROS = macros.gpp

PANDOC = pandoc
PANDOCTEMPLATE = srevuo.latex

LATEX = xelatex -interaction=nonstopmode --shell-escape --enable-write18
BIBER = biber -q

MAINPDF=$(addsuffix .pdf, $(MAIN))

define run-latex
	$(LATEX) $(basename $@) \
	| perl -ne 'BEGIN{$$s=0;} $$s=1 if /^!/; print $$_ if $$s; exit(1) if /^l\./'
endef

define run-latex-final
	@echo "rerun latex final"
	if { [ -s $(basename $@).rerun ] || [ ! -f $@ ] ; } ; \
	then \
		$(run-latex) ; \
	fi
endef

EXTENDED_PREAMBLE = extended_preamble.tex

all: articles_and_numero

$(EXTENDED_PREAMBLE): $(ARTICLES)
	@echo "making extended preamble"
	@echo %%% This is an automatically generated file\; dont change it ... > $(EXTENDED_PREAMBLE)
	@grep -h \\\\usepackage $(ARTICLES) >> $(EXTENDED_PREAMBLE) || true
	@grep -h \\\\bibliography $(ARTICLES) >> $(EXTENDED_PREAMBLE) || true
	@grep -h \\\\usetikzlibrary $(ARTICLES) >> $(EXTENDED_PREAMBLE) || true
	@grep -h \\\\DeclareMathOperator $(ARTICLES) >> $(EXTENDED_PREAMBLE) || true

define getarts
	arts=`perl -ne '($$_)=/^[^%]*\\\(?:SRinput)\{(.*?)\}/;@_=split /,/;foreach $$t (@_) {print "$$t.tex "}' $<`
endef

define getbibs
	bibs=`perl -ne '($$_)=/^[^%]*\\\bibliography\{(.*?)\}/;@_=split /,/;foreach $$b (@_) {print "$$b.bib "}' $< $$arts`
endef


# %.dep: %.tex
#	@echo "making dependencies"
#	@$(getarts); $(getbibs); \
#	echo "ARTICLES = $$arts" >> $@ ; \
#	echo "BIBS = $$bibs" >> $@

# include $(MAIN).dep

include articles.mk

BIBSBBL = $(addsuffix .bbl, $(basename $(BIBS)))
ARTICLESPDF = $(addsuffix .pdf, $(basename $(ARTICLES)))
ARTICLESMDTEX = $(addsuffix .tex, $(basename $(ARTICLESMD)))
ARTICLESHTML = $(addsuffix .html, $(basename $(ARTICLESMD)))


articles_and_numero: $(ARTICLESPDF) $(MAINPDF)

numero: $(MAINPDF)

articles: $(ARTICLESPDF)

%.html: %.md
	$(GPP) --include $(GPPMACROS) -DHMTL=1 -H $< | \
	$(PANDOC) -t html5 -c srevuo.css --standalone -o $@

%.tex: %.md $(PANDOCTEMPLATE)
	$(GPP) --include $(GPPMACROS) -DTEX=1 -H $< | sed '/\S/,$$!d' | \
	$(PANDOC) --template $(PANDOCTEMPLATE) --no-tex-ligatures -t latex -o $@

%.pdf: %.rerun %.tex $(CLASSFILE) %.bib %.bbl
	@echo "making final $(@)"
	@$(run-latex-final)

%.pdf: %.rerun %.tex $(CLASSFILE) %.bbl
	@echo "making final $(@)"
	@$(run-latex-final)

%.pdf: %.rerun %.tex $(CLASSFILE)
	@echo "making final $(@)"
	@$(run-latex-final)

%.rerun: %.aux
	grep  "Warning: .*run" $(basename $<).log > $@ || true

$(MAIN).bbl: $(BIBS)
ifdef BIBS
	@echo "making bibliography $(@)"
	@$(BIBER) $(basename $@)
else
	@touch $@
endif

.SECONDARY:

%.bbl: %.tex %.bib
	@echo "making $(@)"
	@$(BIBER) $(basename $@)

$(MAIN).aux: $(CLASSFILE) $(MAIN).tex $(ARTICLES) $(EXTENDED_PREAMBLE)
	@echo "making $(@)"
	@$(run-latex)
	@grep Biber $(basename $@).log && $(RM) $(basename $@).bbl || true

%.aux : %.tex $(CLASSFILE) $(STYS)
	@echo "making $(@)"
	@$(run-latex)
	@grep Biber $(basename $@).log && $(RM) $(basename $@).bbl || true

%.toc : %.tex $(ARTICLES)
	@echo "making toc"
	@$(run-latex)


.DELETE_ON_ERROR:

.NOTPARALLEL:

.PHONY: clean totalclean targetclean

clean:
	$(RM) *.aux *.blg *.bbl *.bcf *.out *.toc *.log *.run.xml *-blx.bib *.dep *.trm *.rerun \
	$(EXTENDED_PREAMBLE) $(ARTICLESMDTEX) $(ARTICLESHTML)

totalclean: clean
	$(RM) *~

targetclean: clean
	$(RM) $(ARTICLESPDF) $(MAINPDF)
