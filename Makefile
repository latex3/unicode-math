
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
	echo '                   doc  -  compile documentation inside build/'
	echo '                 clean  -  remove build directory and compiled files'
	echo '                   all  -  clean & doc & ctan'
	echo ' '
	echo '               install  -  install the package into your home texmf tree'
	echo '           install-sys  -  install the package into the system-wide texmf tree'
	echo '                           (may require administration privileges)'
	echo ' install TEXMF=<texmf>  -  install the package into the path <texmf>'
	echo ' '
	echo '                 check  -  run the test suite'
	echo '               initest  -  initialise any new tests'
	echo ' '
	echo '         xfile F=<abc>  -  compile file <abc> with XeLaTeX'
	echo '         lfile F=<abc>  -  compile file <abc> with LuaLaTeX'
	echo ' '
	echo 'To add a new test, add a file called X****.ltx to'
	echo 'directory testfiles/,  run `make initest` and ensure'
	echo 'that the output X****.safe.pdf is correct.'
	echo ' '
	echo '`make test` will then compare future compilations of the'
	echo 'test file against this original and warn against any changes.'
	echo '`make build/X****.diff.pdf` will check a single test.'
	echo ' '
	echo 'I recommend `make -j4 check` or thereabouts to parallelise'
	echo 'the testing.'



#### SETUP ####

# file and folder names:

PKG = unicode-math
TBL = $(PKG)-table.tex
SUITE = $(PKG)-testsuite
XMPL = unimath-example.ltx
SYM = unimath-symbols

COPY = cp -a 

testdir=testfiles
builddir=build
tds=$(builddir)/$(PKG).tds

UPDATE = `which dtx-update` || true  # TODO: generalise

# these files end up in the CTAN directory:

PKGSOURCE = $(PKG).dtx $(TBL) Makefile
DOC     = $(PKG).pdf $(SUITE).pdf README $(XMPL) $(SYM).pdf
CTANFILES = $(PKGSOURCE)  $(DOC)  $(testdir)
BUILDCTAN = $(addprefix $(builddir)/,$(CTANFILES))
BUILDDOC = $(addprefix $(builddir)/,$(DOC))

# these are what's needed to compile and make stuff:

LTXSOURCE = $(PKG).sty $(TBL)

BUILDSUITE = \
  $(builddir)/umtest-preamble.tex \
  $(builddir)/umtest-suite-X.tex \
  $(builddir)/umtest-suite-L.tex

TESTOUT = $(shell ls $(testdir)/*.safe.pdf)
BUILDTESTSRC = $(subst $(testdir)/,$(builddir)/,$(subst .safe.pdf,.ltx,$(TESTOUT)))
BUILDTESTTARGET = $(subst $(testdir)/,$(builddir)/,$(subst .safe.pdf,.diff.pdf,$(TESTOUT)))

BUILDSOURCE = $(addprefix $(builddir)/,$(LTXSOURCE))
BUILDSUITE  = $(subst $(testdir)/,$(builddir)/,$(SUITESOURCE))
BUILDFILES  = $(BUILDSOURCE) $(BUILDSUITE) $(BUILDTESTSRC)

# and this is how the TDS zip file is produced:

TDSFILES = \
	$(tds)/source/latex/$(PKG)/$(PKG).dtx \
	$(tds)/source/latex/$(PKG)/$(SUITE).ltx \
	$(tds)/source/latex/$(PKG)/$(SYM).ltx \
	$(tds)/source/latex/$(PKG)/Makefile \
	$(tds)/source/latex/$(PKG)/$(testdir) \
	$(tds)/doc/latex/$(PKG)/unicode-math.pdf \
	$(tds)/doc/latex/$(PKG)/unicode-math-testsuite.pdf \
	$(tds)/doc/latex/$(PKG)/README \
	$(tds)/doc/latex/$(PKG)/$(XMPL) \
	$(tds)/doc/latex/$(PKG)/$(SYM).pdf \
	$(tds)/tex/latex/$(PKG)/unicode-math.sty \
	$(tds)/tex/latex/$(PKG)/unicode-math-table.tex



#### BASICS ####

doc: $(BUILDDOC)

README:

$(XMPL):

clean:
	rm -rf $(builddir)
	rm -f $(PKG).zip $(PKG).pdf $(SUITE).pdf

all: clean doc ctan

#### BUILD FILES

$(builddir)/$(PKG).dtx: $(PKG).dtx
	mkdir -p $(builddir)
	$(UPDATE)
	$(COPY)  $<  $@

$(builddir)/$(PKG).sty: $(builddir)/$(PKG).dtx
	echo "Updating $@"
	cd $(builddir); \
	tex $(PKG).dtx > /dev/null ;

$(builddir)/$(PKG).pdf:  $(builddir)/$(PKG).dtx $(BUILDSOURCE)
	cd $(builddir); \
	xelatex $(PKG).dtx && \
	makeindex -s gind.ist $(PKG) && \
	xelatex $(PKG).dtx;

$(builddir)/$(SYM).pdf:  $(builddir)/$(SYM).ltx
	cd $(builddir); \
	xelatex $(SYM).ltx && \
	xelatex $(SYM).ltx;

$(builddir)/%.ltx: $(testdir)/%.ltx
	$(COPY)  $<  $@

$(builddir)/%: %
	$(COPY)  $< $@

$(builddir)/README: $(builddir)/README.markdown
	mv -f  $<  $@


# Test suite PDF

$(builddir)/$(SUITE).pdf: $(builddir)/$(SUITE).ltx $(BUILDSUITE) $(builddir)/$(testdir)
	cd $(builddir); \
	xelatex $(SUITE).ltx

# (these are $(BUILDSUITE):)

$(builddir)/umtest-preamble.tex: $(testdir)/umtest-preamble.tex
	$(COPY)  $<  $@

$(builddir)/umtest-suite-X.tex: $(testdir)/umtest-suite-X.tex
	$(COPY)  $<  $@

$(builddir)/umtest-suite-L.tex: $(testdir)/umtest-suite-L.tex
	$(COPY)  $<  $@


##### CTAN INSTALLATION #####

tds: $(builddir)/$(PKG).tds.zip

$(builddir)/$(PKG).tds.zip: $(tds)/$(PKG).tds.zip
	$(COPY) $< $@

$(tds)/$(PKG).tds.zip: $(TDSFILES)
	cd $(tds); \
	zip -r $(PKG).tds.zip ./* -x *.DS_Store -x *.safe.pdf

ctan: $(BUILDCTAN) tds
	cd $(builddir); \
	zip -r \
	  ../$(PKG).zip  $(CTANFILES)  $(PKG).tds.zip \
	  -x *.DS_Store -x *.safe.pdf

$(tds)/doc/latex/$(PKG)/% \
$(tds)/tex/latex/$(PKG)/% \
$(tds)/source/latex/$(PKG)/% : $(builddir)/%
	mkdir -p $(shell dirname $@)
	$(COPY)  $< $@

$(tds)/source/latex/$(PKG)/$(testdir):
	$(COPY) $(testdir)  $(tds)/source/latex/$(PKG)/$(testdir)

##### LOCAL TEXMF INSTALLATION #####

TEXMFHOME=$(shell kpsewhich --var-value TEXMFHOME)
TEXMFLOCAL=$(shell kpsewhich --var-value TEXMFLOCAL)

install: $(TDSFILES)
	if test -n "$(TEXMFHOME)" ; then \
		echo "Installing in '$(TEXMFHOME)'."; \
		$(COPY)  $(tds)/  $(TEXMFHOME); \
	else \
		echo "Cannot locate your home texmf tree. Specify manually with\n\n    make install TEXMFHOME=/path/to/texmf\n" ; \
		false ; \
	fi ;

install-sys: $(TDSFILES)
	if test -n "$(TEXMFLOCAL)" ; then \
		echo "Installing in '$(TEXMFLOCAL)'."; \
		$(COPY)  $(tds)/  $(TEXMFLOCAL); \
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
	$(COPY) $(F) $(builddir)/$(F)
	cd $(builddir); xelatex $(F)

lfile: $(F)  $(BUILDSOURCE)
	if [ "$(F)" = "" ] ; then \
	  echo "Need a filename!\nE.g.  \`make lfile F=test.ltx\`" ; \
	  false ; \
	fi
	echo Typesetting $(F):
	$(COPY) $(F) $(builddir)/$(F)
	cd $(builddir); lualatex $(F)


#############
# TESTSUITE #
#############


#### All tests ####

test: check # I changed the name of this guy

check: $(BUILDFILES) $(BUILDTESTTARGET)
	cd $(testdir); \
	ls X*.ltx | sed -e 's/\(.*\).ltx/\\inserttest{\1}/g' > umtest-suite-X.tex; \
	ls L*.ltx | sed -e 's/\(.*\).ltx/\\inserttest{\1}/g' > umtest-suite-L.tex;


#### Each step of the process ####

COMPARE_OPTS = -metric AE -density 300x300
PIXEL_TOLERANCE = 1

$(builddir)/%.diff.pdf: $(builddir)/%.pdf
	echo '$*: Comparing with reference PDF.'
	if [ ${shell compare $(COMPARE_OPTS) $(builddir)/$*.pdf $(testdir)/$*.safe.pdf $(builddir)/$*.diff.pdf  2>&1} -le $(PIXEL_TOLERANCE) ] ; then \
	  echo '$*: Test passed.' ; \
	else \
	  echo '$*: Test failed.' ; \
	  false ; \
	fi

$(builddir)/X%.pdf: $(BUILDSOURCE) $(BUILDSUITE) $(builddir)/X%.ltx
	echo 'X$*: Generating PDF output from XeLaTeX.'
	cd $(builddir); xelatex -interaction=batchmode X$*.ltx > /dev/null

$(builddir)/L%.pdf: $(BUILDSOURCE) $(BUILDSUITE) $(builddir)/L%.ltx
	echo 'L$*: Generating PDF output from LuaLaTeX.'
	cd $(builddir); lualatex -interaction=batchmode L$*.ltx > /dev/null


#### Generating new tests ####

lonelystub = $(shell cd $(testdir); ls | egrep '(.*\.ltx)|(.*\.safe.pdf)' | cut -d . -f 1 | uniq -u)
lonelyfile = $(addsuffix .safe.pdf,$(lonelystub))
lonelypath = $(addprefix $(testdir)/,$(lonelyfile))
lonelytest = $(addprefix $(builddir)/,$(addsuffix .pdf,$(lonelystub)))

initest: $(lonelypath)

$(lonelypath): $(lonelytest)
	$(COPY)  `echo $@ | sed -e s/$(testdir)/$(builddir)/ -e s/.safe.pdf/.pdf/`  $@

