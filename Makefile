
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

SUITESOURCE = \
  umtest-preamble.tex \
  umtest-suite-X.tex \
  umtest-suite-L.tex

TESTOUT = $(shell ls $(testdir)/*.safe.pdf)
BUILDTESTSRC = $(subst $(testdir)/,$(builddir)/,$(subst .safe.pdf,.ltx,$(TESTOUT)))
BUILDTESTTARGET = $(subst $(testdir)/,$(builddir)/,$(subst .safe.pdf,.diff.pdf,$(TESTOUT)))

BUILDSOURCE = $(addprefix $(builddir)/,$(LTXSOURCE))
BUILDSUITE  = $(addprefix $(builddir)/,$(SUITESOURCE))
BUILDFILES  = $(BUILDSOURCE) $(BUILDSUITE) $(BUILDTESTSRC)

# and this is how the TDS zip file is produced:

INSFILES = \
	$(tds)/tex/latex/$(PKG)/unicode-math.sty \
	$(tds)/tex/latex/$(PKG)/unicode-math-table.tex

OTHERFILES = \
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

TDSFILES = $(INSFILES) $(OTHERFILES)


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
	cd $(builddir) && \
	tex $(PKG).dtx > /dev/null ;

$(builddir)/$(PKG).pdf:  $(builddir)/$(PKG).dtx $(BUILDSOURCE)
	cd $(builddir) && \
	xelatex $(PKG).dtx && \
	makeindex -s gind.ist $(PKG) && \
	xelatex $(PKG).dtx;

$(builddir)/$(SYM).pdf:  $(builddir)/$(SYM).ltx
	cd $(builddir) && \
	xelatex $(SYM).ltx && \
	xelatex $(SYM).ltx;

$(builddir)/%.ltx: $(testdir)/%.ltx
	$(COPY)  $<  $@

$(builddir)/%.tex: $(testdir)/%.tex
	$(COPY)  $<  $@

$(builddir)/$(testdir): $(testdir)
	$(COPY)  $< $@

$(builddir)/%: %
	$(COPY)  $< $@

$(builddir)/README: $(builddir)/README.markdown
	mv -f  $<  $@


# Test suite PDF

$(builddir)/$(SUITE).pdf: $(builddir)/$(SUITE).ltx $(BUILDSUITE) $(builddir)/$(testdir)
	cd $(builddir) && \
	xelatex $(SUITE).ltx




##### CTAN INSTALLATION #####

TDS = $(builddir)/$(PKG).tds.zip

tds: TDS

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
	$(COPY) $(testdir)  $(tds)/source/latex/$(PKG)/

##### LOCAL TEXMF INSTALLATION #####

TEXMFHOME=$(shell kpsewhich --var-value TEXMFHOME)
TEXMFLOCAL=$(shell kpsewhich --var-value TEXMFLOCAL)

install: $(INSFILES)
	if test -n "$(TEXMFHOME)" ; then \
		echo "Installing in '$(TEXMFHOME)'."; \
		$(COPY)  $(tds)/*  $(TEXMFHOME); \
	else \
		echo "Cannot locate your home texmf tree. Specify manually with\n\n    make install TEXMFHOME=/path/to/texmf\n" ; \
		false ; \
	fi ;

install-sys: $(INSFILES)
	if test -n "$(TEXMFLOCAL)" ; then \
		echo "Installing in '$(TEXMFLOCAL)'."; \
		$(COPY)  $(tds)/*  $(TEXMFLOCAL); \
	else \
		echo "Cannot locate your system-wide local texmf tree. Specify manually with\n\n    make install TEXMFLOCAL=/path/to/texmf\n" ; \
		false ; \
	fi ;



##### USEFUL FOR TEST FILES #####

xfile: $(F)  $(BUILDSOURCE)
	if test -z "$(F)" ; then \
	  echo "Need a filename!\nE.g.  \`make xfile F=test.ltx\`" ; \
	  false ; \
	fi
	echo Typesetting $(F):
	$(COPY) $(F) $(builddir)/$(F)
	cd $(builddir); xelatex $(F)

lfile: $(F)  $(BUILDSOURCE)
	if test -z "$(F)" ; then \
	  echo "Need a filename!\nE.g.  \`make lfile F=test.ltx\`" ; \
	  false ; \
	fi
	echo Typesetting $(F):
	$(COPY) $(F) $(builddir)/$(F)
	cd $(builddir); lualatex $(F)


#############
# TESTSUITE #
#############

#### Needed to compile and make stuff ####

builddir=build
testdir=testfiles
lprefix=L
xprefix=X
both=F
NAME=unicode-math

COPY = cp -a
MOVE = mv -f
COMPARE_OPTS = -density 300x300 -metric ae -fuzz 35%

# Redefine this to print output if you need:
REDIRECT = > /dev/null

LTXSOURCE = $(NAME).sty

TESTLIST = testsuite-listing.tex

SUITESOURCE = \
  $(testdir)/umtest-preamble.tex \
  $(testdir)/$(TESTLIST)

TESTOUT = $(wildcard $(testdir)/*.*safe.pdf)
BUILDTESTSRC = $(subst $(testdir)/,$(builddir)/,$(subst .safe.pdf,.ltx,$(TESTOUT)))
BUILDTESTTARGET1 = $(TESTOUT)
BUILDTESTTARGET2 = $(subst $(testdir)/,$(builddir)/,$(BUILDTESTTARGET1))
BUILDTESTTARGET3 = $(subst .safe.pdf,.diff.pdf,$(BUILDTESTTARGET2))
BUILDTESTTARGET4 = $(subst .Xsafe.pdf,-X.diff.pdf,$(BUILDTESTTARGET3))
BUILDTESTTARGET5 = $(subst .Lsafe.pdf,-L.diff.pdf,$(BUILDTESTTARGET4))
BUILDTESTTARGET = $(BUILDTESTTARGET4)

BUILDSOURCE = $(addprefix $(builddir)/,$(LTXSOURCE))
BUILDSUITE  = $(subst $(testdir)/,$(builddir)/,$(SUITESOURCE))
BUILDFILES  = $(BUILDSOURCE) $(BUILDSUITE) $(BUILDTESTSRC)

#### All tests ####

check: $(TESTLIST)
	echo $(BUILDTESTTARGET)

$(TESTLIST): $(BUILDFILES) $(BUILDTESTTARGET)
	@cd $(testdir); \
	ls *.ltx | sed -e 's/\(.*\).ltx/\\TEST{\1}/g' > $(TESTLIST)

$(builddir)/%: $(testdir)/%
	@mkdir -p $(builddir); \
	$(COPY) $< $@

$(builddir)/%: %
	@mkdir -p $(builddir); \
	$(COPY) -f $< $@


#### Generating new tests ####

lonelystub = $(shell cd $(testdir); ls | egrep '(X|L)(.*\.ltx)|(X|L)(.*\.safe.pdf)' | cut -d . -f 1 | uniq -u)
lonelyfile = $(addsuffix .safe.pdf,$(lonelystub))
lonelypath = $(addprefix $(testdir)/,$(lonelyfile))
lonelytest = $(addprefix $(builddir)/,$(addsuffix .pdf,$(lonelystub)))

Xlonelystub = $(shell cd $(testdir); ls | egrep '(F.*\.ltx)|(F.*.Xsafe.pdf)' | cut -d . -f 1 | uniq -u)
Xlonelyfile = $(addsuffix .Xsafe.pdf,$(Xlonelystub))
Xlonelypath = $(addprefix $(testdir)/,$(Xlonelyfile))
Xlonelytest = $(addprefix $(builddir)/,$(addsuffix -X.pdf,$(Xlonelystub)))

Llonelystub = $(shell cd $(testdir); ls | egrep '(F.*\.ltx)|(F.*.Lsafe.pdf)' | cut -d . -f 1 | uniq -u)
Llonelyfile = $(addsuffix .Lsafe.pdf,$(Llonelystub))
Llonelypath = $(addprefix $(testdir)/,$(Llonelyfile))
Llonelytest = $(addprefix $(builddir)/,$(addsuffix -L.pdf,$(Llonelystub)))

initest: $(lonelypath) $(Xlonelypath) $(Llonelypath)

$(lonelypath): $(lonelytest)
	$(COPY)  `echo $@ | sed -e s/$(testdir)/$(builddir)/ -e s/.safe.pdf/.pdf/`  $@

$(Xlonelypath): $(Xlonelytest)
	$(COPY)  `echo $@ | sed -e s/$(testdir)/$(builddir)/ -e s/.Xsafe.pdf/-X.pdf/`  $@

$(Llonelypath): $(Llonelytest)
	$(COPY)  `echo $@ | sed -e s/$(testdir)/$(builddir)/ -e s/.Lsafe.pdf/-L.pdf/`  $@


#### TESTS FOR BOTH ENGINES ####

$(builddir)/F%-L.diff.pdf: $(builddir)/F%-L.pdf
	@echo 'F$*: Comparing PDF from LuaLaTeX against reference output.'
	if test $(shell compare \
	                $(COMPARE_OPTS) \
	                $(builddir)/F$*-L.pdf \
	                $(testdir)/F$*.Lsafe.pdf \
	                $(builddir)/F$*-L.diff.pdf 2>&1) -le 1 ; then \
	  echo 'F$*: Test passed.' ; \
	else \
	  echo 'F$*: Test failed.' ; \
	  false ; \
	fi

$(builddir)/F%-X.diff.pdf: $(builddir)/F%-X.pdf
	@echo 'F$*: Comparing PDF from XeLaTeX against reference output.'
	if test $(shell compare \
	                $(COMPARE_OPTS) \
	                $(builddir)/F$*-X.pdf \
	                $(testdir)/F$*.Xsafe.pdf \
	                $(builddir)/F$*-X.diff.pdf 2>&1) -le 1 ; then \
	  echo 'F$*: Test passed.' ; \
	else \
	  echo 'F$*: Test failed.' ; \
	  false ; \
	fi

$(builddir)/F%-L.pdf: $(BUILDSOURCE) $(BUILDSUITE) $(builddir)/F%-L.ltx
	@echo 'F$*: Generating PDF output with LuaLaTeX.'
	@cd $(builddir); lualatex -interaction=nonstopmode F$*-L.ltx  $(REDIRECT)

$(builddir)/F%-X.pdf: $(BUILDSOURCE) $(BUILDSUITE) $(builddir)/F%-X.ltx
	@echo 'F$*: Generating PDF output with XeLaTeX.'
	@cd $(builddir); xelatex -interaction=nonstopmode F$*-X.ltx   $(REDIRECT)

$(builddir)/F%-L.ltx: $(builddir)/F%.ltx
	$(COPY) $< $@

$(builddir)/F%-X.ltx: $(builddir)/F%.ltx
	$(COPY) $< $@


#### TEST FOR EACH ENGINE INDIVIDUALLY ####

$(builddir)/L%.diff.pdf: $(builddir)/L%.pdf
	@echo 'L$*: Comparing PDF against reference output.'
	if test $(shell compare $(COMPARE_OPTS) \
	          $(builddir)/L$*.pdf $(testdir)/L$*.safe.pdf \
	          $(builddir)/L$*.diff.pdf 2>&1) -le 1 ; then \
	  echo 'L$*: Test passed.' ; \
	else \
	  echo 'L$*: Test failed.' ; \
	  false ; \
	fi

$(builddir)/X%.diff.pdf: $(builddir)/X%.pdf
	@echo 'X$*: Comparing PDF against reference output.'
	if test $(shell compare \
	                $(COMPARE_OPTS) \
	                $(builddir)/X$*.pdf \
	                $(testdir)/X$*.safe.pdf \
	                $(builddir)/X$*.diff.pdf 2>&1) -le 1 ; then \
	  echo 'X$*: Test passed.' ; \
	else \
	  echo 'X$*: Test failed.' ; \
	  false ; \
	fi

$(builddir)/X%.pdf: $(BUILDSOURCE) $(BUILDSUITE) $(builddir)/X%.ltx
	@echo 'X$*: Generating PDF output with XeLaTeX.'
	@cd $(builddir); xelatex -interaction=nonstopmode X$*.ltx $(REDIRECT)

$(builddir)/L%.pdf: $(BUILDSOURCE) $(BUILDSUITE) $(builddir)/L%.ltx
	@echo 'L$*: Generating PDF output with LuaLaTeX.'
	@cd $(builddir); lualatex -interaction=nonstopmode L$*.ltx $(REDIRECT)

#### HACK: allow `make <foobar>` run that test.

L%: build/L%.ltx
	make build/L$*.diff.pdf

X%: build/X%.ltx
	make build/X$*.diff.pdf

F%: build/F%.ltx
	make build/F$*-L.diff.pdf
	make build/F$*-X.diff.pdf







############################
###### NIGHTLY BUILDS ######
############################

UNAME_S := $(shell uname -s)

# Mac OS X:
ifeq ($(UNAME_S),Darwin)
	MD5 = md5
endif

# Linux:
ifeq ($(UNAME_S),Linux)
	MD5 = md5sum
endif

BRANCH = tdsbuild

TMP = /tmp
LOG =  $(TMP)/gitlog.tmp


checkbranch:
	@if  git branch | grep $(BRANCH) > /dev/null ; \
	then echo "TDS branch exists"; \
	else \
	  echo "TDS branch does not exist; doing so will remove all untracked files from your working directory. Create the TDS branch with\n    make createbranch"; \
	  false; \
	fi;

createbranch: $(TDS)
	cp -f $(TDS) $(TMP)/
	git symbolic-ref HEAD refs/heads/$(BRANCH)
	rm .git/index
	git clean -fdx
	unzip -o $(TMP)/$(TDS) -d .
	rm $(TMP)/$(TDS)
	git add --all
	git commit -m "Initial TDS commit"
	git checkout master
	git push origin $(BRANCH) master
	@echo "\nTDS branch creation was successful.\n"
	@echo "Now create a new package at TLContrib: http://tlcontrib.metatex.org/"
	@echo "Use the following metadata:"
	@echo "    Package ID: $(PKG)"
	@echo "        BRANCH: $(BRANCH)"
	@echo "\nAfter this process, use \`make tdsbuild\` to"
	@echo "    (a) push your recent work on the master branch,"
	@echo "    (b) automatically create a TDS snapshot,"
	@echo "    (c) send the TDS snapshot to TLContrib."


ifeq ($(UNAME_S),Darwin)
  tlclogin:  USERNAME = $(shell security find-internet-password -s tlcontrib.metatex.org | grep "acct" | cut -f 4 -d \")
  tlclogin:  PASSWORD = $(shell security 2>&1 >/dev/null find-internet-password -gs tlcontrib.metatex.org | cut -f 2 -d ' ')
endif

ifeq ($(UNAME_S),Linux)
  tlclogin:  USERNAME = ""
  tlclogin:  PASSWORD = ""
endif

tlclogin:  VERSION = $(shell date "+%Y-%m-%d@%H:%M")
tlclogin: ;

tdsbuild: checkbranch tlclogin $(TDS)
	cp -f $(TDS) $(TMP)/
	@echo "Constructing commit history for snapshot build"
	date "+TDS snapshot %Y-%m-%d %H:%M" > $(LOG)
	echo '\n\nApproximate commit history since last snapshot:\n' >> $(LOG)
	git log --after="`git log -b $(BRANCH) -n 1 --pretty=format:"%aD"`" --pretty=format:"%+H%+s%+b" >> $(LOG)
	@echo "Committing TDS snapshot to separate branch"
	git checkout $(BRANCH)
	unzip -o $(TMP)/$(TDS) -d .
	rm $(TMP)/$(TDS)
	git commit --all --file=$(LOG)
	git clean -df
	@echo "Pushing TDS and master branch"
	git checkout master
	git push origin $(BRANCH) master
	@echo "Pinging TLContrib for automatic update"
	curl http://tlcontrib.metatex.org/cgi-bin/package.cgi/action=notify/key=$(PKG)/check=$(shell echo $(USERNAME)/$(PASSWORD)/$(VERSION) | $(MD5) )?version=$(VERSION) > /dev/null 2>&1

