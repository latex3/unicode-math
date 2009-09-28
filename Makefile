
PKG = $(shell basename `pwd`)
FILES = README $(PKG).ins $(PKG).dtx
RESULTS = $(PKG).pdf $(PKG).sty
TYPESET = xelatex -shell-escape

$(PKG).tar.gz: $(FILES) $(RESULTS)
	ctanify $(PKG).ins $(PKG).pdf README

$(PKG).pdf: $(PKG).dtx
	$(TYPESET) $<
	makeindex -s gind.ist $(PKG)

$(PKG).sty: $(FILES)
	tex $(PKG).ins

README: README.markdown
	cp -f README.markdown README

#############

push:
	~/bin/dtx-update
	make $(PKG).pdf
	git commit -a -m "bump package date"
	git push origin master

#############


testdir=testfiles
builddir=build

testltx=$(shell ls $(testdir)/umtest*.ltx)
diffpng:= $(subst .ltx,.diff.png,$(testltx))
safepng:= $(subst .ltx,.safe.png,$(testltx))
buildltx = $(subst $(testdir)/,$(builddir)/,$(testltx))
builddiff = $(subst $(testdir)/,$(builddir)/,$(diffpng))


testclean:
	rm -f $(builddir)/*

$(builddir)/unicode-math.sty:
	tex unicode-math.dtx > /dev/null ;
	cp -f unicode-math.sty $(builddir)/ ;
	cp -f unicode-math-table.tex $(builddir)/ ;

test: testclean $(builddir)/unicode-math.sty $(builddir)/umtest-preamble.tex $(buildltx) $(safepng) $(builddiff)
	cd $(testdir); \
	ls umtest*.ltx | sed -e 's/umtest\(.*\).ltx/\\inserttest{\1}/g' > umtest-suite.tex
	if [ `ls $(builddir)/*.diff.png | wc -l` = 0 ] ; then \
	  echo ; \
	  echo All tests passed successfully. ; \
	  echo ; \
	else \
	  echo ; \
	  echo ==================================== ; \
	  echo Some tests failed! ; \
	  echo List of diffs produced during check: ; \
	  echo ==================================== ; \
	  echo ; \
	  ls -1 $(builddir)/*.diff.png ; \
	  echo ; \
	fi ;

$(builddir)/umtest-preamble.tex:
	cp $(testdir)/umtest-preamble.tex $(builddir)

$(builddir)/%.ltx:
	cp -f $(testdir)/$*.ltx      $(builddir)/

$(builddir)/%.safe.png: $(testdir)/%.safe.png
	cp $(testdir)/$*.safe.png $(builddir)/ 

$(builddir)/%.pdf: $(builddir)/unicode-math.sty $(builddir)/%.ltx
	cd $(builddir); \
	xelatex -interaction=batchmode $*.ltx

$(builddir)/%.test.png: $(builddir)/%.pdf
	cd $(builddir); \
	convert -density 300x300 $*.pdf $*.test.png

$(builddir)/%.diff.png: $(builddir)/%.test.png
	cd $(builddir); \
	compare -metric RMSE $*.test.png $*.safe.png $*.diff.png | grep 'dB' > /tmp/pngdiff.txt ; \
	if [ "`cat /tmp/pngdiff.txt`" = "0 dB" ] ; then \
	  rm $*.diff.png; \
	  rm $*.test.png; \
	fi

$(testdir)/%.safe.png: $(builddir)/%.test.png
	cp $(builddir)/$*.test.png $(testdir)/$*.safe.png
