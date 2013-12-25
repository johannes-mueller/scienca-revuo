
MAIN = numero

CLASSFILE = srevuo.cls

.SUFFIXES: .tex .pdf .aux .toc .bbl .bib

LATEX = xelatex -interaction=nonstopmode --shell-escape --enable-write18
BIBER = biber -q

MAINPDF=$(addsuffix .pdf, $(MAIN))

define run-latex
	$(LATEX) $(basename $@) \
	| perl -ne 'BEGIN{$$s=0;} $$s=1 if /^!/; print $$_ if $$s; exit(1) if /^l\./'
endef

EXTENDED_PREAMBLE = extended_preamble.tex

all: articles_and_numero 

$(EXTENDED_PREAMBLE): $(ARTICLES)
	@echo "making extended preamble"
	@echo %%% This is an automatically generated file\; dont change it ... > $(EXTENDED_PREAMBLE)
	@grep -h \\\\usepackage $(ARTICLES) >> $(EXTENDED_PREAMBLE) || true
	@grep -h \\\\bibliography $(ARTICLES) >> $(EXTENDED_PREAMBLE) || true
	@grep -h \\\\usetikzlibrary $(ARTICLES) >> $(EXTENDED_PREAMBLE) || true

define getarts
	arts=`perl -ne '($$_)=/^[^%]*\\\(?:SRinput)\{(.*?)\}/;@_=split /,/;foreach $$t (@_) {print "$$t.tex "}' $<`
endef

define getbibs
	bibs=`perl -ne '($$_)=/^[^%]*\\\bibliography\{(.*?)\}/;@_=split /,/;foreach $$b (@_) {print "$$b.bib "}' $< $$arts`
endef

%.dep: %.tex 
	@echo "making dependencies"
	@$(getarts); $(getbibs); \
	echo "ARTICLES = $$arts" >> $@ ; \
	echo "BIBS = $$bibs" >> $@

include $(MAIN).dep

BIBSBBL = $(addsuffix .bbl, $(basename $(BIBS)))
ARTICLESPDF = $(addsuffix .pdf, $(basename $(ARTICLES)))


articles_and_numero: $(ARTICLESPDF) $(MAINPDF)

numero: $(MAINPDF)

articles: $(ARTICLESPDF) 

%.pdf: %.aux %.tex $(CLASSFILE) %.bib %.bbl
	@echo "making final $(@)"
	@$(run-latex)

%.pdf: %.aux %.tex $(CLASSFILE) %.bbl
	@echo "making final $(@)"
	@$(run-latex)

%.pdf: %.aux %.tex $(CLASSFILE)
	@echo "making final $(@)"
	@$(run-latex)


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
	$(RM) *.aux *.blg *.bbl *.bcf *.toc *.log *.run.xml *-blx.bib *.dep *.trm $(EXTENDED_PREAMBLE)

totalclean: clean
	$(RM) *~

targetclean: clean
	$(RM) $(ARTICLESPDF) $(MAINPDF)
