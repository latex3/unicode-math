

help:
	@echo 'UNICODE-MATH makefile targets:'
	@echo '     help  -  (this message)'
	@echo '      pkg  -  generate archive for CTAN'
	@echo '      doc  -  compile documentation'
	@echo '     push  -  push to GitHub'
	@echo '     test  -  run the test suite'
	@echo ' testinit  -  initialise new tests'
	@echo ' '
	@echo 'To add a new test, add a file called umtest****.ltx to'
	@echo 'directory testfiles/, then run `make testinit` and then'
	@echo 'ensure that the output umtest****.safe.png is correct.'
	@echo ' '
	@echo '`make test` will then compare future compilations of the'
	@echo 'test file against this original and warn against any changes.'




PKG = $(shell basename `pwd`)
FILES = README $(PKG).ins $(PKG).dtx
RESULTS = $(PKG).pdf $(PKG).sty
TYPESET = xelatex -shell-escape

pkg: $(FILES) $(RESULTS)
	ctanify $(PKG).ins $(PKG).pdf README

doc: $(PKG).pdf unicode-math-testsuite.pdf

$(PKG).pdf: $(PKG).dtx
	$(TYPESET) $<
	makeindex -s gind.ist $(PKG)

$(PKG).sty: $(FILES)
	tex $(PKG).ins

README: README.markdown
	cp -f README.markdown README

unicode-math-testsuite.pdf: unicode-math-testsuite.ltx testfiles/umtest-preamble.tex testfiles/umtest-suite.tex
	$(TYPESET) $<

#############

push:
	if ~/bin/dtx-update ; then \
	  make $(PKG).pdf ; \
	  git commit -a -m "bump package date" ; \
	fi
	git push origin master



#############
# TESTSUITE #
#############

testdir=testfiles
builddir=build

safepng=$(shell ls $(testdir)/umtest*.safe.png)
diffpng:= $(subst .safe.png,.diff.png,$(safepng))
testltx:= $(subst .safe.png,.ltx,$(safepng))
buildltx = $(subst $(testdir)/,$(builddir)/,$(testltx))
builddiff = $(subst $(testdir)/,$(builddir)/,$(diffpng))

buildfiles = $(builddir)/unicode-math.sty $(builddir)/umtest-preamble.tex $(buildltx)


#### Moving files around ####

testclean:
	rm -f $(builddir)/*

$(builddir)/unicode-math.sty:
	tex unicode-math.dtx > /dev/null
	cp -f unicode-math.sty $(builddir)
	cp -f unicode-math-table.tex $(builddir)

$(builddir)/umtest-preamble.tex:
	cp $(testdir)/umtest-preamble.tex $(builddir)

$(builddir)/%.ltx: $(testdir)/%.ltx
	cp -f  $(testdir)/$*.ltx  $(builddir)

#### All tests ####

test: testclean $(buildfiles) $(builddiff)
	cd $(testdir); \
	ls umtest*.ltx | sed -e 's/umtest\(.*\).ltx/\\inserttest{\1}/g' > umtest-suite.tex
	if [ `ls $(builddir)/*.diff.png | wc -l` = 0 ] ; then \
	  echo ; \
	  echo All tests passed successfully: ; \
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

#### Each step of the process ####

$(builddir)/%.diff.png: $(builddir)/%.test.png
	cd $(builddir); \
	rm -f /tmp/pngdiff.txt ; \
	compare -metric RMSE $*.test.png ../$(testdir)/$*.safe.png $*.diff.png | grep 'dB' > /tmp/pngdiff.txt ; \
	if [ "`cat /tmp/pngdiff.txt`" = "0 dB" ] ; then \
	  rm $*.diff.png; \
	fi

$(builddir)/%.test.png: $(builddir)/%.pdf
	cd $(builddir); \
	convert -density 300x300 $*.pdf $*.test.png

$(builddir)/%.pdf: $(builddir)/unicode-math.sty $(builddir)/%.ltx
	cd $(builddir); xelatex -interaction=batchmode $*.ltx

#### Generating new tests ####

lonelystub = $(shell cd testfiles; ls -1 | egrep 'umtest(.*\.ltx)|(.*\.safe.png)' | cut -d . -f 1 | uniq -u)
lonelyfile = $(addsuffix .safe.png,$(lonelystub))
lonelypath = $(addprefix $(testdir)/,$(lonelyfile))

testinit: $(lonelypath)

$(testdir)/%.safe.png: $(builddir)/%.test.png
	cp $(builddir)/$*.test.png $(testdir)/$*.safe.png

