The UNICODE-MATH package
========================

This package will provide a complete implementation of unicode maths for
XeLaTeX and LuaLaTeX.

While I am a little wary of encouraging people to use this package for
production work, I understand that it has certain uses and am making it
available for distribution. Your testing and feedback is essential to fill
in the many gaps that I miss!

Please be aware that this package is undergoing continued development and the
interface and functionality should not be considered completely stable. But
the more the package is used the more stable it will become. (Things are
generally working now; it is only minutiae that may change in the future.)

Unicode maths is currently supported to one degree or another by the fonts

 - [Cambria Math][CM] (Microsoft),
 - [Latin Modern Math][LM] (Bogusław Jackowski, Janusz M. Nowacki)
 - [TeX Gyre Pagella Math][PM] (Bogusław Jackowski, Janusz M. Nowacki)
 - [Asana Math][AM] (Apostolos Syropolous),
 - [Neo Euler][NE] (Khaled Hosny),
 - [STIX][SM] (STI Pub), and
 - [XITS Math][XM] (Khaled Hosny).

With the exception of Cambria Math, which is proprietry, the fonts above
are all freely available and released under open source licences
(the [GUST Font License][GFL] and [Open Font Licence][OFL]).

I'm always looking for new fonts to test with, so please let me know of any
new releases.

[CM]: http://www.ascenderfonts.com/font/cambria-regular.aspx
[LM]: http://www.gust.org.pl/projects/e-foundry/lm-math
[PM]: http://www.ctan.org/pkg/tex-gyre-math-pagella
[AM]: http://www.ctan.org/tex-archive/fonts/Asana-Math/
[NE]: http://github.com/khaledhosny/euler-otf
[SM]: http://www.aip.org/stixfonts/
[XM]: http://github.com/khaledhosny/xits-math
[GFL]: http://www.gust.org.pl/projects/projects/e-foundry/licenses/
[OFL]: http://scripts.sil.org/OFL


PACKAGE USAGE
-------------

Please see the PDF documentation for full details. A simple beginning is:

    \usepackage{unicode-math}
    \setmathfont{xits-math.otf}

Most LaTeX math should still work after this. (Let me know if it doesn't.)
Furthermore, it will be in a different font.


REQUIREMENTS
------------

If you're using an up-to-date TeX Live 2011/2012 or MiKTeX 2.9 then there'll
be no problems. Otherwise, read on.

As well as running XeTeX or LuaTeX, this package requires recent versions of
the `fontspec`, `expl3`, `xpackages`, `catchfile`, `trimspaces`,
`filehook`, and `lualatex-math` packages.


MAINTENANCE
-----------

The current release version is available from CTAN:
> <http://tug.ctan.org/pkg/unicode-math>

Latest developmental and archived historical versions are
available from Github:
> <http://github.com/wspr/unicode-math>

Please file bug reports with minimal examples:
> <http://github.com/wspr/unicode-math/issues>


INSTALLATION
------------

If you are using the currently supported version of TeX Live (about to be 2012
at time of writing), you may install the latest release version of the package
with

    sudo tlmgr update unicode-math

The steps below assume that you have obtained unicode-math either from CTAN or
Github and you wish to install the package yourself.

Installation and compilation are automated by the Makefile; see below for the
manual procedure. To re-compile the documentation (requiring XeLaTeX and a
variety of installed fonts):

    make doc

To install unicode-math in your home texmf tree:

    make install

To install it for all users in your system-wide local texmf tree:

    make install-sys

See `make help` for further information.


### Manual procedure

Run TeX on unicode-math.dtx to generate the package file `unicode-math.sty`:

    tex unicode-math.dtx

If you have the necessary fonts, you may compile the documentation
with XeLaTeX:

    xelatex unicode-math.dtx

To install the package, place unicode-math.sty and unicode-math-table.tex in a
location searched by XeLaTeX, inside the directory structure
`<texmf>/tex/latex/unicode-math/`. The appropriate `<texmf>` location for a
single-user installation can be found with

    kpsewhich --var-value TEXMFHOME

For a system-wide (multi-user) installation, use the location returned by

    kpsewhich --var-value TEXMFLOCAL


TEST SUITE
----------

After installation you can initialise the testsuite with

    make initest

Subsequently, the test suite may be executed with

    make check

Both of these operations will take quite some time and require ImageMagick's
`convert` tool to be installed.
They are only necessary if you wish to make changes to unicode-math yourself
(be sure to initialise the test suite *before* any changes are made to the
package) and you wish to ensure that your changes have not affected the
standard behaviour.


CHANGE HISTORY
--------------

- v0.7e (2014/06/30)

  * No longer assume fixltx2e has been loaded.
  * Some ascii math symbols have been renamed with a \math... prefix, such as \mathquestion.
  * Assume latest luaotfload is being used; no need for a separate unicode-math.lua script.
  * Assorted typos and minor bugs.

- v0.7e (2013/05/04)

  * Track luaotfload updates.

- v0.7d (2013/03/16)

  * More expl3 changes missed first time around. (Sorry again.)

- v0.7c (2013/02/25)

  * The Latin Modern math font name changed TWICE. Only caught the first one.
    Sorry for any inconvenience caused.

- v0.7b (2013/02/22)

  * Keep in sync with Latin Modern Math font name change.
  * Keep in sync with expl3 changes.

- v0.7a (2012/07/28)

  * Keep in sync with expl3 changes.

- v0.7 (2012/05/30): The TeX Live 2012 release.

  * Most changes (and all significant ones) in this release thanks to Khaled
    Hosny, who is now credited as an author of the package.
  * Many improvements for XeTeX support to take advantage of the new engine
    (v0.9998) in TL2012.
      * As a result, `\resetmathfont` is no longer required.
  * Improve `\not` to use pre-combined glyphs where possible.
  * LM Math is loaded by default.
  * Support bottom accents.
      * And add `\wideutilde`.
  * The ‘symbols’ document is somewhat better organised and contains
    information on whether a symbol is defined in plain TeX or amssymb.
  * Various other minor fixes and additions:
      * `\underleftrightarrow` added for fonts that support it.
      * Don’t overwrite mathtool’s `\overbracket` and `\underbracket`.
      * Bug in `[range=...]` parsing fixed.
      * Add `\longdivision`.
      * Add `\lgroup` and `\rgroup`.
      * Fix ‘moustache’ delimiters.
      * `\openbox` renamed to `\mathvisiblespace`, since it is already defined
        in amsthm as an empty box.

- v0.6a (2011/09/19)

  * Always a bug that slips through the cracks! Fixes `\left.` and `\right.`
  * Add experimental package option `warnings-off=...` which allows warnings
    to be suppressed on an individual basis.

- v0.6 (2011/09/18)

  * Keep in sync with fontspec internals
    (sorry for the small delay where things were broken)
  * Keep in sync with expl3 deprecated functions
  * Math versions (finally) implemented; can now change maths fonts
    mid-document without reinitialising everything
    (thanks to Ulrike Fischer and Ulrik Vieth)
  * Symbols file `unimath-symbols.pdf` now uses maths versions to compare
    all of the OpenType maths fonts I currently have access to
  * Over- and under- braces, brackets, and parentheses now work in XeTeX
    (thanks to Claudio Beccari)
  * Many internal changes, including a re-write of the `range` feature;
    it should now be faster and more robust
  * Tentative programmer's interface for querying the current math style:
    `\l_um_mathstyle_tl`.
  * Remove (outdated) interaction with beamer; you must specify
    `professionalfonts` manually for now
  * Quieten the console output when loading maths fonts with incomplete maths
    style coverage
  * Synonym added: `\lnot` -> `\neg`
  * Two added Unicode symbols (names tentative): `\blanksymbol` and `\openbox`
    (thanks to Apostolos Syropoulos)
  * Fixed literal sub-/super-script input.

- v0.5e (2011/07/31)

  * Fix forward compatibility clash with deprecated expl3 functions (sorry)
  * Command names are now `\protected`; this makes them safe to use in moving
    arguments and so on
  * Similarly to the change in v0.5c, the main math font is now loaded in
    math family zero (equiv. to LaTeX's `operators` math font)
  * `\mathring` added
  * Ensure that a math font has been selected in order to prevent problems
    in minimal documents (this will be unnecessary when the OpenType LM math
    font is released)
  * Documentation for which was which of epsilon/varepsilon was backwards!
    (thank to Rasmus Villemoes for pointing this out)
  * Spurious `\upUpsilon` removed (the one at U+03A5 is now the correct one)
  * Typo when defining `\dprime` fixed
    (thanks to Ulrik Vieth for these last two)
  * Fix the math class of `\modtwosum`; it is now a large operator
    (thanks to Michael Ummels)
  * Move several LuaTeX-related patches to the `lualatex-math` package
  * Fixed mathtool's `\cramped` in XeLaTeX usage

- v0.5d (2011/01/30)

  * Assorted improvements to LuaLaTeX support, including non-growing accents
    available in LuaTeX v0.65 and later
  * Improved behaviour with reading and using maths font dimensions
  * Better compatibility with legacy maths packages and environments
    (always more worked needed, though)
  * Fix the default setting for "vargreek-shape"

- v0.5c (2010/09/27)

  * Fix a long-standing bug in XeLaTeX in which the "master" math
    families 2 and 3 weren't being set; hence fraction rules and many other
    parameters were not being set correctly
  * Stay in sync with internal fontspec changes

- v0.5b (2010/09/19): Tune-up

  * Added missing symbols/synonyms:
      \diamond  \smallint  \emptyset  \hbar  \backepsilon  \eth
  * \overline works for LuaLaTeX
  * Fix \slash; previously, it overwrote the text definition
  * \vartriangle now has the correct math class

- v0.5a (2010/07/14): TeX Live 2010 release

  * Numerous documentation improvements
  * Bug fix against stray catcode changes
  * Add `\mathcal` and `\mathbfcal` as distinct from the Script style;
    these are only supported by the XITS fonts at present
  * Small changes to the range of symbols offered (especially note that `\ac`
    is now `\invlazys` to avoid acronym package clash)
  * Superscripts are allowed after primes (as they should be)
  * Numerous LuaLaTeX improvements, including roots and over/under braces.

- v0.5 (2010/06/03): Initial CTAN release


LICENCE
-------

The unicode-math package may be modified and distributed under the terms and
conditions of the [LaTeX Project Public License][LPPL], version 1.3c or
greater.

[LPPL]: http://www.latex-project.org/lppl/

This work is author-maintained and consists of the files

- unicode-math.dtx,
- unicode-math-table.tex,
- unimath-example.ltx,
- unimath-symbols.ltx,
- unicode-math-testsuite.ltx;

the derived files

- unicode-math.lua,
- unicode-math.sty;

the compiled documentation files

- unicode-math.pdf,
- unicode-math-testsuite.pdf,
- unimath-example.pdf,
- unimath-symbols.pdf;

and the test suite for this package

- testfiles/umtest-preamble.tex,
- testfiles/umtest-suite-(F|L|X).tex,
- testfiles/*.ltx.

____________________________________
Copyright 2006-2012   Will Robertson  <will.robertson@latex-project.org>
Copyright 2010-2011 Philipp Stephani  <st_philipp@yahoo.de>
Copyright 2012          Khaled Hosny  <khaledhosny@eglug.org>
