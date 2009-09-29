

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


#### SETUP ####

testdir=testfiles
builddir=build
PKG = $(shell basename `pwd`)

safepng = $(shell ls $(testdir)/umtest*.safe.png)
diffpng = $(subst .safe.png,.diff.png,$(safepng))
testltx = $(subst .safe.png,.ltx,$(safepng))
buildltx = $(subst $(testdir)/,$(builddir)/,$(testltx))
builddiff = $(subst $(testdir)/,$(builddir)/,$(diffpng))

buildfiles = $(BUILDSOURCE) $(builddir)/umtest-preamble.tex $(buildltx)

SOURCE = $(PKG).dtx $(PKG)-table.tex

SUITE = unicode-math-testsuite
SUITESOURCE = \
  $(SUITE).ltx \
  testfiles/umtest-preamble.tex \
  testfiles/umtest-suite.tex
SWEETSAUCE = ginger and chilli

DOC = $(PKG).pdf $(SUITE).pdf
DERIVED = $(PKG).sty README $(PKG).ins
TYPESET = xelatex -shell-escape

ALLFILES = $(SOURCE) $(SUITESOURCE)

BUILDFILES = $(addprefix $(builddir)/,$(ALLFILES))

BUILDSOURCE = $(addprefix $(builddir)/,$(SOURCE))
BUILDDOC = $(addprefix $(builddir)/,$(DOC))


#### BASICS ####

clean:
	rm -f $(builddir)/*

pkg: $(SOURCE) $(DERIVED) $(DOC)
	ctanify $(PKG).ins $(PKG).pdf README

doc: $(DOC)

$(PKG).pdf: $(builddir)/$(PKG).pdf
	cp $<  $@

$(SUITE).pdf: $(builddir)/$(SUITE).pdf
	cp $<  $@

README: README.markdown
	cp -f README.markdown README

#### BUILD FILES

$(builddir)/$(PKG).sty: $(PKG).dtx
	tex $(PKG).ins > /dev/null
	rm dtx-style.sty
	mv $(PKG).sty $@

$(builddir)/$(PKG).dtx: $(PKG).dtx
	cp -f  $<  $@

$(builddir)/unicode-math-table.tex: unicode-math-table.tex
	cp -f  $<  $@

$(builddir)/umtest-preamble.tex: $(testdir)/umtest-preamble.tex
	cp -f  $<  $@

$(builddir)/%.ltx: $(testdir)/%.ltx
	cp -f  $<  $@

$(builddir)/$(PKG).pdf:  $(BUILDSOURCE)
	cd $(builddir); \
	$(TYPESET) $(PKG).dtx; \
	makeindex -s gind.ist $(PKG); 

$(builddir)/$(SUITE).pdf:
	$(TYPESET) -output-directory=$(builddir) $(SUITE).ltx


##### PROBABLY ONLY USEFUL FOR WILL #####

push:
	if ~/bin/dtx-update ; then \
	  make $(PKG).pdf ; \
	  git commit -a -m "bump package date" ; \
	fi
	git push origin master



#############
# TESTSUITE #
#############


#### All tests ####

test: $(buildfiles) $(builddiff)
	cd $(testdir); \
	ls umtest*.ltx | sed -e 's/umtest\(.*\).ltx/\\inserttest{\1}/g' > umtest-suite.tex
	@if [ `ls $(builddir)/*.diff.png | wc -l` = 0 ] ; then \
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


#### Each step of the process ####

$(builddir)/%.diff.png: $(builddir)/%.test.png
	@echo ' '
	cd $(builddir); \
	rm -f /tmp/pngdiff.txt ; \
	compare -metric RMSE $*.test.png ../$(testdir)/$*.safe.png $*.diff.png | grep 'dB' > /tmp/pngdiff.txt ; \
	if [ "`cat /tmp/pngdiff.txt`" = "0 dB" ] ; then \
	  rm $*.diff.png ; \
	  echo 'Test passed.' \
	fi

$(builddir)/%.test.png: $(builddir)/%.pdf
	@echo ' '
	convert -density 300x300  $<  $(builddir)/$*.test.png

$(builddir)/umtest%.pdf: $(BUILDSOURCE) $(builddir)/umtest%.ltx
	@echo ' '
	@echo ' '
	@echo 'TEST $*'
	@echo ' '
	cd $(builddir); xelatex -interaction=batchmode umtest$*.ltx


#### Generating new tests ####

lonelystub = $(shell cd testfiles; ls -1 | egrep 'umtest(.*\.ltx)|(.*\.safe.png)' | cut -d . -f 1 | uniq -u)
lonelyfile = $(addsuffix .safe.png,$(lonelystub))
lonelypath = $(addprefix $(testdir)/,$(lonelyfile))

testinit: $(lonelypath)

$(testdir)/%.safe.png: $(builddir)/%.test.png
	cp  $<  $@

