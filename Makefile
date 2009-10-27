
.SILENT:

help:
	echo 'UNICODE-MATH makefile targets:'
	echo '     help  -  (this message)'
	echo '      pkg  -  generate archive for CTAN (incomplete)'
	echo '      doc  -  compile documentation'
	echo '     push  -  push to GitHub'
	echo '     test  -  run the test suite'
	echo '  initest  -  initialise any new tests'
	echo ' '
	echo 'To add a new test, add a file called umtest****.ltx to'
	echo 'directory testfiles/, then run `make testinit` and then'
	echo 'ensure that the output umtest****.safe.png is correct.'
	echo ' '
	echo '`make test` will then compare future compilations of the'
	echo 'test file against this original and warn against any changes.'
	echo ' '
	echo 'I recommend `make -j4 test` or thereabouts to parallelise
	echo 'the testing.'


#### SETUP ####

PKG = $(shell basename `pwd`)
TBL = $(PKG)-table.tex
SUITE = $(PKG)-testsuite

testdir=testfiles
builddir=build

PKGSOURCE = $(PKG).dtx $(TBL)
LTXSOURCE = $(PKG).sty $(TBL)

SUITESOURCE = \
  testfiles/umtest-preamble.tex \
  testfiles/umtest-suite.tex
SWEETSAUCE = ginger and chilli

DOC     = $(PKG).pdf $(SUITE).pdf
DERIVED = $(PKG).sty $(PKG).ins README

TESTOUT = $(shell ls $(testdir)/umtest*.safe.png)
BUILDTESTSRC = $(subst $(testdir)/,$(builddir)/,$(subst .safe.png,.ltx,$(TESTOUT)))
BUILDTESTTARGET = $(subst $(testdir)/,$(builddir)/,$(subst .safe.png,.diff.png,$(TESTOUT)))

BUILDSOURCE = $(addprefix $(builddir)/,$(LTXSOURCE))
BUILDSUITE  = $(subst $(testdir)/,$(builddir)/,$(SUITESOURCE))
BUILDFILES  = $(BUILDSOURCE) $(BUILDSUITE) $(BUILDTESTSRC)

#### BASICS ####

clean:
	rm -f $(builddir)/*

pkg: $(PKGSOURCE) $(DERIVED) $(DOC)
	ctanify $(PKG).ins $(TBL) $(PKG).pdf README

doc: $(DOC)

$(PKG).pdf: $(builddir)/$(PKG).pdf
	cp $<  $@

$(SUITE).pdf: $(builddir)/$(SUITE).pdf
	cp $<  $@

README: README.markdown
	cp -f README.markdown README

#### BUILD FILES


$(builddir)/$(PKG).sty: $(builddir)/$(PKG).dtx
	echo "Updating $@"
	cd $(builddir); \
	tex $(PKG).dtx > /dev/null ; \

$(builddir)/$(PKG).dtx: $(PKG).dtx
	~/bin/dtx-update
	cp -f  $<  $@

$(builddir)/unicode-math-table.tex: unicode-math-table.tex
	echo "Updating $@"
	cp -f  $<  $@

$(builddir)/$(PKG).pdf:  $(builddir)/$(PKG).dtx $(BUILDSOURCE)
	cd $(builddir); \
	xelatex $(PKG).dtx; \
	makeindex -s gind.ist $(PKG); \
	xelatex $(PKG).dtx;


$(builddir)/$(SUITE).pdf: $(SUITE).ltx $(BUILDSUITE)
	xelatex -output-directory=$(builddir) $<

$(builddir)/umtest-preamble.tex: $(testdir)/umtest-preamble.tex
	cp -f  $<  $@

$(builddir)/umtest-suite.tex: $(testdir)/umtest-suite.tex
	cp -f  $<  $@

$(builddir)/%.ltx: $(testdir)/%.ltx
	cp -f  $<  $@

##### USEFUL FOR TEST FILES #####

file: $(F)  $(BUILDSOURCE)
	if [ "$(F)" = "" ] ; then \
	  echo "Need a filename!\nE.g.  \`make file F=test.ltx\`" ; \
	  false ; \
	fi
	echo Typesetting $(F):
	cp -f $(F) $(builddir)/$(F)
	cd $(builddir); xelatex $(F)


##### PROBABLY ONLY USEFUL FOR WILL #####

push: doc
	git push origin master



#############
# TESTSUITE #
#############


#### All tests ####

test: $(BUILDFILES) $(BUILDTESTTARGET)
	cd $(testdir); \
	ls umtest*.ltx | sed -e 's/umtest\(.*\).ltx/\\inserttest{\1}/g' > umtest-suite.tex


#### Each step of the process ####

$(builddir)/%.diff.png: $(builddir)/%.test.png
	echo '$*: Comparing with good PNG.'
	if [ "${shell compare -metric RMSE $(builddir)/$*.test.png $(testdir)/$*.safe.png $(builddir)/$*.diff.png | grep 'dB'}" = "0 dB" ] ; then \
	  echo '$*: Test passed.' ; \
	else \
	  echo '$*: Test failed.' ; \
	  false ; \
	fi

$(builddir)/%.test.png: $(builddir)/%.pdf
	echo '$*: Converting PDF to PNG.'
	convert -density 300x300  $<  $(builddir)/$*.test.png

$(builddir)/umtest%.pdf: $(BUILDSOURCE) $(BUILDSUITE) $(builddir)/umtest%.ltx
	echo 'umtest$*: Generating PDF output.'
	cd $(builddir); xelatex -interaction=batchmode umtest$*.ltx > /dev/null


#### Generating new tests ####

lonelystub = $(shell cd testfiles; ls | egrep 'umtest(.*\.ltx)|(.*\.safe.png)' | cut -d . -f 1 | uniq -u)
lonelyfile = $(addsuffix .safe.png,$(lonelystub))
lonelypath = $(addprefix $(testdir)/,$(lonelyfile))
lonelytest = $(addprefix $(builddir)/,$(addsuffix .test.png,$(lonelystub)))

initest: $(lonelypath)

$(lonelypath): $(lonelytest)
	cp  `echo $@ | sed -e s/$(testdir)/$(builddir)/ -e s/.safe.png/.test.png/`  $@

