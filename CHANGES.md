CHANGE HISTORY
==============

## v0.8q (2020/01/31)

  * Update to adapt to / support new features in the upcoming 2e kernel.
  * Give a better error message if used on non-supported engines that are not pdfTeX.


## v0.8p (2019/09/26)

  * Remove dependency on `filehook` package. Just to simplify.
  * Remove patch code for the `colonequals` package; now if you use that package
    you will simply receive its standard ‘constructed’ symbols.
  * Load `amsmath` automatically. This is not intended to save time for the user,
    but to simplify the code logic. Users should continue to load `amsmath` explicitly IMO.


## v0.8o (2019/03/04)

  * Avoid `'Dimension too large' error` for some (unpredictable) combinations of font
    choice and the `Scale` option. Problems are still known to occur for very large or
    very small values of `Scale`.
  * Documentation is now run through ‘continuous integration’ (viz, *Travis* for the time being)
    as well as the test suite.


## v0.8n (2019/01/26)

  * Add note to readme that the `lm-math` package is required for minimal functionality.
  * Spacing fixed for maths fonts loaded with the `Scale` fontspec feature (#287).
  * Commands like `\crampedtextstyle` now longer lead to an infinite loop under XeTeX (#505).
  * Improvements to the functionality of the test suite. (Although more tests would be nice.)
  * Test suite is now (successfully) run with `expl3` debug mode enabled.


## v0.8m (2018/07/29)

  * Restore behaviour of legacy syntax `x_\mathrm{x}` (i.e., with no braces).
    While strictly ‘incorrectly’, this usage is widely used.
    N.B. this syntax is not supported for the `\symXX` commands.
  * Add `\cuberoot` and `\fourthroot` as proper radicals.
  * Some additional input subscripts/superscripts.
  * Some documentation additions (thanks for the contributions).
  * Deprecation warning: the *internal* `\__um_switchto_XX:` commands will be dropped in
    a future release in favour of `\__um_switch_to:n {XX}` (or similar). These are internal
    commands and shouldn't be used by third-parties; please write if you have a use case.


## v0.8l (2018/02/02)

  * Issue an error message if `\setmathfont{...}[range=...]` is used first; a `range`
    declaration inherently implies a subset, so a ‘main’ math font needs to be set up first.
  * Fix issue when nesting `\mathXX` and `\symZZ` commands. (#356, #435, #438)
  * Fix another issue when using `mathXX` or `\symXX` inside `\DeclareMathOperator`. (#449)
  * Document incompatibility with the `mathspec` package. (#436)
  * Fix bugs for using `range=\partial` and `range=\nabla`. (#441)


## v0.8k (2018/01/13)

  * Eliminate warnings `Variant form 'NV' invalid for base form`... (#430).
  * Fix issue when loading the `cal` range (#431).
  * Fix issue with `\sqrt[n]{x}` with `amsmath` (#432).
  * Error when loading on (really) old versions of XeTeX/LuaTeX removed.
  * More UM fonts listed in the README (#425).


## v0.8j (2018/01/07)

  - NEW

    * Numbers and latin letters in the fullwidth Unicode range are now supported
      as aliases to their ASCII counterparts (#337).
    * New commands `\(New|Renew)NegationCommand \foo` for defining custom negations
      accessed via `\not\foo`.

  - SYMBOLS

    * `\typecolon` is now `\mathrel` instead of `\mathbin` (#360).
    * New symbol `\mathhyphen` which acts like a ‘letter’ (#313).
    * `\nabla` and `\partial` have corrected documentation (#257).
    * The following legacy commands are listed as ‘unsupported’ and will result
      in sensible error messages rather than the old behaviour of meaningless
      output: `\arrowvert`, `\Arrowvert`, `\bracevert`. (#411).

  - BUGS

    * LuaTeX bug with shifted `\underbrace` when it contains accented symbols worked around (#391).
    * When using the `range` feature, users commonly found they needed to call
      `\setmathfont` a final time with the original font to ensure correct
      formatting and correct selection of symbol alphabets. I hope the issues
      that required this have now been corrected (#331, #387).
    * If `\setmathfont` is called a second time in a document, it tries harder
      to more properly reset the maths font setup for the new font (#224).
    * Properly hard-coded the `\delcode` of the period to ensure `\left`/`\right`
      behave correctly in all circumstances (#344, #351, #420).
    * Correct `\mathrm` (etc.) situation when no fonts loaded explicitly by the user (#330).
    * Various bug fixes to `\not` (#126, #343, #363)
    * `\std@minus` & `\std@equal` now properly corrected (#332).
    * Fix problem with infinite loop with `\cdots` when `amsmath` loaded after `unicode-math` (#227).
    * If `\setmath(rm|sf|tt)` is called *before* loading `unicode-math`, the setting
      is now remembered (#407).

  - INTERNALS

    * A number of improvements to efficiency when loading subsequent math fonts
      using the `range` feature.
    * No longer loads the `ucharcat` package.
    * Test suite re-implemented for better portability and use with Travis CI.
      See <https://travis-ci.org/wspr/unicode-math> for the up-to-date status
      of whether the test suite is passing.



## v0.8i (2017/11/18)

  * Many internal changes to support future work.
  * Improved documentation describing the `\mathXX` and `\symXX` commands.
  * Documentation is now split into `unicode-math.pdf` (for the user)
    and `unicode-math-code.pdf` (for the typeset source code).


## v0.8h (2017/10/09)

  * Some bugs crept in in the last update due to some code rearrangement:
      * package version wasn't set;
      * some code was being executed at the wrong time;
      * `\sqrt[]{}` in LuaLaTeX gave incorrect output.
  * The layout of the code is now structured far more sensibly.
  * Remove (long deprecated) `\resetmathfont`; for years it has been a synonym for `\setmathfont`.


## v0.8g (2017/10/02)

  * Better use of scriptstyle sizes in LuaTeX (I think a regression).
  * Fix regression (`\mathbf` etc. not being set automatically) caused by the renaming of a `fontspec` internal command.
  * Minor documentation improvements.
  * (Only relevant for me: I've also disabled the test suite almost entirely to begin a re-write for ‘continuous integration’.)


## v0.8f (2017/08/02)

  * Emergency fix (thanks Bruno) for another bug revealed by `expl3` update.


## v0.8e (2017/07/30)

  * Add `\surd` to access the sqrt symbol.
  * Fix bug exposed by `expl3` update to booleans.
  * Add Deja Vu Math TeX Gyre in list of symbols.
  * Add `\sime` alias for `\simeq` and `\nsimeq` for `\nsime`.
    (For negations it's helpful when they have consistent naming.)


## v0.8d (2017/01/25)

  * `vargreek-shape=TeX` and `vargreek-shape=unicode` package options dropped; for consistency and compatibility, `\phi` and `\epsilon` should and will now behave the same as in `TeX`.
  * On that note, when using control sequences such as `\mbfitsansvarphi` (and so on), there were a few faulty definitions. The new behaviour is to consistenyl define the `varphi` and `varepsilon` ones as those with the "curly" designs.
  * Add `\wideoverbar`, `\widebreve`, `\widecheck`.
  * Add `\mathsection`, `\mathparagraph`.
  * Remove `\mupvarbeta`, `upold(Kk)oppa`, `\up(Ss)tigma`, `\up(Kk)oppa`, `\up(Ss)ampi` — none of these are maths symbols.
  * `!` (`\mathexclam`) changed from `\mathpunct` to `\mathclose` for backwards compatibility with TeX.


## v0.8c (2015/09/24)

  * Add `\over(left/right)harpoon` as "wide" accents.
  * Add RTL mathematics operators `\arabicmaj` and `\arabichad`, which correspond to `U+1EEF0` and `U+1EEF1`, resp.
  * Remove `catchfile` package dependency.
  * Update some internal names to match expl3 standards.


## v0.8b (2015/09/09)

  * Bug fix: Use the "ucharcat" package to simplify some code that caused some headaches with \tl_rescan:nn.


## v0.8a (2015/08/06)

  * Fix bug with \vert, \|, \(l/r)vert, etc., displaying with the wrong characters.

  * Improve documentation to properly reflect changes in v0.8 and fix some broken examples.

  * No longer reset catcodes of : and @ during \setmathfont .

  * Fix remapping of alphabets (needed for Minion Math) in cases such as:

      \setmathfont[range=bfit->it]{MinionMath-Bold.otf}


## v0.8  (2015/07/29)  **Breaking changes in this update!**

  * `\mathrm` (`\mathup`), `\mathit`, `\mathbf`, `\mathsf`, and `\mathtt` revert to their traditional LaTeX meanings; they are set up to match their equivalent text fonts unless specifically set using `\setmathrm` and friends from `fontspec` or the new `\setmathfontface` in `unicode-math`. These commands should be used for *multi*-letter identifiers.

  * New "symbol" commands have been added, `\symrm` (`\symup`), `symit`, ..., to replace the behaviour of the old commands. These should be used for *single*-letter identifiers. See the package documentation for more detail on these and related commands.

  * Package options `mathit=sym`, `mathbf=sym`, etc., reverse the changes above to revert to pre-v0.8 behaviour for `\mathXYZ`. Regardless of package option, `\symXYZ` always maps to symbols and `\mathtextXYZ` is provided for the traditional `\mathXYZ` font switch.

  * New command `\setoperatorfont` to set the font used for commands such as `\sin` and `\cos`. Usage: `\setoperatorfont\mathbf` or any command defined with `\setmathfontface`.

  * Traditional LaTeX `\DeclareMathAlphabet` now works again for legacy font-loading packages.

  * Commands defined to "force" Greek letters with `\upbeta` and `\itbeta`, etc.

  * Assorted bug fixes and minor changes.


## v0.7e (2014/06/30)

  * No longer assume fixltx2e has been loaded.
  * Some ascii math symbols have been renamed with a \math... prefix, such as \mathquestion.
  * Assume latest luaotfload is being used; no need for a separate unicode-math.lua script.
  * Assorted typos and minor bugs.


## v0.7e (2013/05/04)

  * Track luaotfload updates.


## v0.7d (2013/03/16)

  * More expl3 changes missed first time around. (Sorry again.)


## v0.7c (2013/02/25)

  * The Latin Modern math font name changed TWICE. Only caught the first one.
    Sorry for any inconvenience caused.


## v0.7b (2013/02/22)

  * Keep in sync with Latin Modern Math font name change.
  * Keep in sync with expl3 changes.


## v0.7a (2012/07/28)

  * Keep in sync with expl3 changes.


## v0.7 (2012/05/30): The TeX Live 2012 release.

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


## v0.6a (2011/09/19)

  * Always a bug that slips through the cracks! Fixes `\left.` and `\right.`
  * Add experimental package option `warnings-off=...` which allows warnings
    to be suppressed on an individual basis.


## v0.6 (2011/09/18)

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


## v0.5e (2011/07/31)

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


## v0.5d (2011/01/30)

  * Assorted improvements to LuaLaTeX support, including non-growing accents
    available in LuaTeX v0.65 and later
  * Improved behaviour with reading and using maths font dimensions
  * Better compatibility with legacy maths packages and environments
    (always more worked needed, though)
  * Fix the default setting for "vargreek-shape"


## v0.5c (2010/09/27)

  * Fix a long-standing bug in XeLaTeX in which the "master" math
    families 2 and 3 weren't being set; hence fraction rules and many other
    parameters were not being set correctly
  * Stay in sync with internal fontspec changes


## v0.5b (2010/09/19): Tune-up

  * Added missing symbols/synonyms:
      \diamond  \smallint  \emptyset  \hbar  \backepsilon  \eth
  * \overline works for LuaLaTeX
  * Fix \slash; previously, it overwrote the text definition
  * \vartriangle now has the correct math class


## v0.5a (2010/07/14): TeX Live 2010 release

  * Numerous documentation improvements
  * Bug fix against stray catcode changes
  * Add `\mathcal` and `\mathbfcal` as distinct from the Script style;
    these are only supported by the XITS fonts at present
  * Small changes to the range of symbols offered (especially note that `\ac`
    is now `\invlazys` to avoid acronym package clash)
  * Superscripts are allowed after primes (as they should be)
  * Numerous LuaLaTeX improvements, including roots and over/under braces.


## v0.5 (2010/06/03): Initial CTAN release

