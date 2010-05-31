
#### MAKEFILE CONFIG ####

SHELL = /bin/sh
.SILENT:
.SUFFIXES:

#### BEGIN ####

help:
	echo 'UNICODE-MATH makefile targets:'
	echo ' '
	echo '                  help  -  (this message)'
	echo '                  ctan  -  generate archive for CTAN'
	echo '                   doc  -  compile documentation'
	echo '                 clean  -  remove build directory and compiled files'
	echo ' '
	echo '               install  -  install the package into your home texmf tree'
	echo '           install-sys  -  install the package into the system-wide texmf tree'
	echo '                           (may require administration privileges)'
	echo ' install TEXMF=<texmf>  -  install the package into the path <texmf>'
	echo ' '
	echo '                  test  -  run the test suite'
	echo '               initest  -  initialise any new tests'
	echo ' '
	echo '         xfile F=<abc>  -  compile file <abc> with XeLaTeX'
	echo '         lfile F=<abc>  -  compile file <abc> with LuaLaTeX'
	echo ' '
	echo 'To add a new test, add a file called umtest****.ltx to'
	echo 'directory testfiles/,  run `make initest` and ensure'
	echo 'that the output umtest****.safe.png is correct.'
	echo ' '
	echo '`make test` will then compare future compilations of the'
	echo 'test file against this original and warn against any changes.'
	echo '`make build/umtest****.diff.png` will check a single test.'
	echo ' '
	echo 'I recommend `make -j4 test` or thereabouts to parallelise'
	echo 'the testing.'



#### SETUP ####

PKG = unicode-math
TBL = $(PKG)-table.tex
SUITE = $(PKG)-testsuite

UPDATE = `which dtx-update` || true  # TODO: generalise

testdir=testfiles
builddir=build
tds=$(builddir)/$(PKG).tds

PKGSOURCE = $(PKG).dtx $(TBL) $(SUITE).ltx
LTXSOURCE = $(PKG).sty $(TBL)

DOC     = $(PKG).pdf $(SUITE).pdf
DERIVED = $(PKG).sty

SUITESOURCE = \
  $(testdir)/umtest-preamble.tex \
  $(testdir)/umtest-suite.tex
SWEETSAUCE = ginger and chilli

TESTOUT = $(shell ls $(testdir)/umtest*.safe.png)
BUILDTESTSRC = $(subst $(testdir)/,$(builddir)/,$(subst .safe.png,.ltx,$(TESTOUT)))
BUILDTESTTARGET = $(subst $(testdir)/,$(builddir)/,$(subst .safe.png,.diff.png,$(TESTOUT)))

BUILDSOURCE = $(addprefix $(builddir)/,$(LTXSOURCE))
BUILDSUITE  = $(subst $(testdir)/,$(builddir)/,$(SUITESOURCE))
BUILDFILES  = $(BUILDSOURCE) $(BUILDSUITE) $(BUILDTESTSRC)

TDSFILES = \
	$(tds)/source/latex/$(PKG)/$(PKG).dtx \
	$(tds)/source/latex/$(PKG)/$(SUITE).ltx \
	$(tds)/source/latex/$(PKG)/Makefile \
	$(tds)/source/latex/$(PKG)/$(testdir) \
	$(tds)/doc/latex/$(PKG)/unicode-math.pdf \
	$(tds)/doc/latex/$(PKG)/unicode-math-testsuite.pdf \
	$(tds)/doc/latex/$(PKG)/README \
	$(tds)/tex/latex/$(PKG)/unicode-math.sty \
	$(tds)/tex/latex/$(PKG)/unicode-math-table.tex

CTANFILES = $(PKGSOURCE)  $(DOC)  Makefile  README ../$(testdir)

BUILDCTAN = $(addprefix $(builddir)/,$(CTANFILES))

#### BASICS ####

doc: $(DOC)

clean:
	rm -rf $(builddir)
	rm -f $(PKG).zip $(PKG).pdf $(SUITE).pdf

$(PKG).pdf: $(builddir)/$(PKG).pdf
	cp $<  $@

$(SUITE).pdf: $(builddir)/$(SUITE).pdf
	cp $<  $@


#### BUILD FILES

$(builddir)/$(PKG).dtx: $(PKG).dtx
	mkdir -p $(builddir)
	$(UPDATE)
	cp -f  $<  $@

$(builddir)/$(PKG).sty: $(builddir)/$(PKG).dtx
	echo "Updating $@"
	cd $(builddir); \
	tex $(PKG).dtx > /dev/null ;

$(builddir)/unicode-math-table.tex: unicode-math-table.tex
	echo "Updating $@"
	cp -f  $<  $@

$(builddir)/$(PKG).pdf:  $(builddir)/$(PKG).dtx $(BUILDSOURCE)
	cd $(builddir); \
	xelatex $(PKG).dtx && \
	makeindex -s gind.ist $(PKG) && \
	xelatex $(PKG).dtx;

$(builddir)/$(SUITE).pdf: $(SUITE).ltx $(BUILDSUITE)
	xelatex -output-directory=$(builddir) $<

$(builddir)/umtest-preamble.tex: $(testdir)/umtest-preamble.tex
	cp -f  $<  $@

$(builddir)/umtest-suite.tex: $(testdir)/umtest-suite.tex
	cp -f  $<  $@

$(builddir)/%.ltx: $(testdir)/%.ltx
	cp -f  $<  $@

$(builddir)/README: README.markdown
	cp -f  $< $@

$(builddir)/Makefile: Makefile
	cp -f  $< $@

$(builddir)/$(SUITE).ltx: $(SUITE).ltx
	cp -f  $< $@


##### CTAN INSTALLATION #####

../$(testdir):

tds: $(TDSFILES)
	cd $(builddir); \
	zip -r $(PKG).tds.zip $(PKG).tds -x *.DS_Store -x *.safe.png

ctan: $(BUILDCTAN) tds
	cd $(builddir); \
	zip -r \
	  ../$(PKG).zip  $(CTANFILES)  $(PKG).tds.zip \
	  -x *.DS_Store -x *.safe.png

$(tds)/doc/latex/$(PKG)/% \
$(tds)/tex/latex/$(PKG)/% \
$(tds)/source/latex/$(PKG)/% : $(builddir)/%
	mkdir -p $(shell dirname $@)
	cp -f  $< $@

$(tds)/source/latex/$(PKG)/$(testdir):
	cp -rf $(testdir)  $(tds)/source/latex/$(PKG)/$(testdir)

##### LOCAL TEXMF INSTALLATION #####

TEXMFHOME=$(shell kpsewhich --var-value TEXMFHOME)
TEXMFLOCAL=$(shell kpsewhich --var-value TEXMFLOCAL)

install: $(TDSFILES)
	if test -n "$(TEXMFHOME)" ; then \
		echo "Installing in '$(TEXMFHOME)'."; \
		cp -rf  $(tds)/  $(TEXMFHOME); \
	else \
		echo "Cannot locate your home texmf tree. Specify manually with\n\n    make install TEXMFHOME=/path/to/texmf\n" ; \
		false ; \
	fi ;

install-sys: $(TDSFILES)
	if test -n "$(TEXMFLOCAL)" ; then \
		echo "Installing in '$(TEXMFLOCAL)'."; \
		cp -rf  $(tds)/  $(TEXMFLOCAL); \
	else \
		echo "Cannot locate your system-wide local texmf tree. Specify manually with\n\n    make install TEXMFLOCAL=/path/to/texmf\n" ; \
		false ; \
	fi ;



##### USEFUL FOR TEST FILES #####

xfile: $(F)  $(BUILDSOURCE)
	if [ "$(F)" = "" ] ; then \
	  echo "Need a filename!\nE.g.  \`make xfile F=test.ltx\`" ; \
	  false ; \
	fi
	echo Typesetting $(F):
	cp -f $(F) $(builddir)/$(F)
	cd $(builddir); xelatex $(F)

lfile: $(F)  $(BUILDSOURCE)
	if [ "$(F)" = "" ] ; then \
	  echo "Need a filename!\nE.g.  \`make lfile F=test.ltx\`" ; \
	  false ; \
	fi
	echo Typesetting $(F):
	cp -f $(F) $(builddir)/$(F)
	cd $(builddir); lualatex $(F)


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

lonelystub = $(shell cd $(testdir); ls | egrep 'umtest(.*\.ltx)|(.*\.safe.png)' | cut -d . -f 1 | uniq -u)
lonelyfile = $(addsuffix .safe.png,$(lonelystub))
lonelypath = $(addprefix $(testdir)/,$(lonelyfile))
lonelytest = $(addprefix $(builddir)/,$(addsuffix .test.png,$(lonelystub)))

initest: $(lonelypath)

$(lonelypath): $(lonelytest)
	cp  `echo $@ | sed -e s/$(testdir)/$(builddir)/ -e s/.safe.png/.test.png/`  $@

