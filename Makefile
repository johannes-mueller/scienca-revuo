
MAIN = numero

CLASSFILE = srevuo.cls

#STYS = terminaro.sty

.SUFFIXES: .tex .pdf .aux .toc

LATEX = xelatex -interaction=nonstopmode --shell-escape --enable-write18
BIBER = biber -q

define run-latex-itself
	$(LATEX) $(basename $@) \
	| perl -ne 'BEGIN{$$s=0;} $$s=1 if /^!/; print $$_ if $$s; exit(1) if /^l\./'
endef

define run-latex
	$(run-latex-itself)
	$(check-rerun)
endef

EXTENDED_PREAMBLE = extended_preamble.tex

all: $(MAIN).pdf

$(EXTENDED_PREAMBLE): $(ARTICLES)
	@echo "making extended preamble"
	@echo %%% This is an automatically generated file\; dont change it ... > $(EXTENDED_PREAMBLE)
	@grep -h \\\\usepackage $(ARTICLES) >> $(EXTENDED_PREAMBLE) || true
	@grep -h \\\\bibliography $(ARTICLES) >> $(EXTENDED_PREAMBLE) || true

define getarts
	arts=`perl -ne '($$_)=/^[^%]*\\\(?:SRinput)\{(.*?)\}/;@_=split /,/;foreach $$t (@_) {print "$$t.tex "}' $<`
endef

define getbibs
	bibs=`perl -ne '($$_)=/^[^%]*\\\bibliography\{(.*?)\}/;@_=split /,/;foreach $$b (@_) {print "$$b.bib "}' $< $$arts`
endef

%.dep: %.tex 
	@echo "making dependencies"
	@touch $(basename $@).rerun
	@$(getarts); $(getbibs); \
	echo "ARTICLES = $$arts" >> $@ ; \
	echo "BIBS = $$bibs" >> $@

include $(MAIN).dep

define run-latex-if-necessary
	if [ -f $(basename $@).rerun ]; then \
		echo "running latex (again) ..." ; \
		rm $(basename $@).rerun ;\
		$(run-latex-itself) ;\
	else \
	 	echo "Nichts mehr zu tun." ; \
	fi 
endef

$(MAIN).pdf: $(CLASSFILE) $(MAIN).aux $(MAIN).bbl $(MAIN).tex
	@echo "making final"
	@$(run-latex-if-necessary)
	@$(check-rerun)
	@$(run-latex-if-necessary)

%.pdf: $(CLASSFILE) %.aux %.bbl %.tex
	@echo "making final"
	@$(run-latex-if-necessary)
	@$(check-rerun)
	@$(run-latex-if-necessary)


%.bbl: $(BIBS)
ifdef BIBS
	@echo "making bibliography"
	@$(BIBER) $(basename $@)
	@touch .$(basename $@).rerun
else
	@touch $@
endif


%.aux : %.tex $(CLASSFILE) $(STYS) $(ARTICLES) $(EXTENDED_PREAMBLE)
	@echo "making aux"
	@$(run-latex)
	@grep Biber $(basename $@).log && $(RM) $(basename $@).bbl || true

%.toc : %.tex $(ARTICLES)
	@echo "making toc"
	@$(run-latex)


.DELETE_ON_ERROR:

.NOTPARAlLEL:

.PHONY: clean totalclean targetclean

clean:
	$(RM) *.aux *.blg *.bbl *.bcf *.toc *.log *.run.xml *-blx.bib *.dep *.trm $(EXTENDED_PREAMBLE)

totalclean: clean
	$(RM) *~

targetclean: clean
	$(RM) $(MAIN).pdf
