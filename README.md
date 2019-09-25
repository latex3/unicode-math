The UNICODE-MATH package
========================

This package provides an implementation of Unicode/OpenType mathematics for
XeLaTeX and LuaLaTeX.

While I am a little wary of encouraging people to use this package for
production work, I understand that it has certain uses and am making it
available for distribution. Your testing and feedback is essential to fill
in the many gaps that I miss!

Please be aware that this package is undergoing continued development and the
interface and functionality should not be considered completely stable. But
the more the package is used the more stable it will become. (Things are
generally working now; it is only minutiae that may change in the future.)

Unicode maths is currently supported by the following freely available fonts:

 - [Latin Modern Math][LM] (Bogusław Jackowski, Janusz M. Nowacki)
 - [TeX Gyre Bonum Math][BM] (B. Jackowski, P. Strzel­czyk and P. Pianowski)
 - [TeX Gyre Pagella Math][PM] (B. Jackowski, P. Strzelczyk and P. Pianowski)
 - [TeX Gyre Schola Math][SCM] (B. Jackowski, P. Strzelczyk and P. Pianowski)
 - [TeX Gyre Termes Math][TM] (B. Jackowski, P. Strzelczyk and P. Pianowski)
 - [DejaVu Math TeX Gyre][DEJA] (B. Jackowski, P. Strzelczyk and P. Pianowski)
 - [Asana Math][AM] (Apostolos Syropolous),
 - [STIX][STIX] (STIpub), and
 - [XITS Math][XM] (Khaled Hosny),
 - [Libertinus Math][LIB] (Philipp H. Poll and Khaled Hosny).
 - [Fire Math][FIRA] (Xiangdong Zeng).

These fonts are available under open source licences
(the [GUST Font License][GFL] and [Open Font Licence][OFL]).

The following fonts are proprietary with OpenType maths support:

 - [Lucida Bright Math][LUCI] (Charles Bigelow and Kris Holmes)
 - [Cambria Math][CM] (Microsoft),
 - [Minion Math][MM] (Johannes Küster, typoma GmbH)

I'm always looking for new fonts to test with, so please let me know of any
new releases.

[CM]: http://www.ascenderfonts.com/font/cambria-regular.aspx
[LUCI]: http://tug.org/store/lucida/opentype.html
[MM]: http://www.typoma.com/en/fonts.html
[LM]: http://www.gust.org.pl/projects/e-foundry/lm-math
[PM]: http://www.ctan.org/pkg/tex-gyre-math-pagella
[BM]: http://www.ctan.org/pkg/tex-gyre-math-bonum
[SCM]: http://www.ctan.org/pkg/tex-gyre-math-schola
[TM]: http://www.ctan.org/pkg/tex-gyre-math-termes
[DEJA]: https://ctan.org/pkg/tex-gyre-math-dejavu
[AM]: http://www.ctan.org/pkg/asana-math
[STIX]: http://www.stixfonts.org
[XM]: http://github.com/khaledhosny/xits-math
[LIB]: https://ctan.org/pkg/libertinus
[GFL]: http://www.gust.org.pl/projects/projects/e-foundry/licenses/
[OFL]: http://scripts.sil.org/OFL
[FIRA]: https://github.com/firamath/firamath


PACKAGE USAGE
-------------

Please see the PDF documentation for full details. A simple beginning is:

```tex
\usepackage{unicode-math}
\setmathfont{texgyrepagella-math.otf}
```

Most LaTeX math should still work after this. (Let me know if it doesn't.)
Furthermore, it will be in a different font.


REQUIREMENTS
------------

As well as running XeTeX or LuaTeX, this package requires recent versions of the
`lm-math`, `fontspec`, `expl3`, `xpackages`, and `lualatex-math` packages.


THANKS
------

I write LaTeX code as a hobby and a passion, not as part of my day job.
If you would like to say thanks, please consider a donation at: <https://www.patreon.com/wspr>


DEVELOPMENT and MAINTENANCE
---------------------------

The current release version is available from CTAN:
> <https://ctan.org/pkg/unicode-math>

Latest developmental and archived historical versions are available from Github:
> <http://github.com/wspr/unicode-math>

Please file bug reports with minimal examples:
> <http://github.com/wspr/unicode-math/issues>

See `CHANGES.md` for the complete listing of change history.

Further information on the details surrounding the development of the package
can be found in the `CONTRIBUTING.md` file in the Github repository.


LICENCE
-------

The unicode-math package may be modified and distributed under the terms and
conditions of the [LaTeX Project Public License][LPPL], version 1.3c or
greater.

[LPPL]: http://www.latex-project.org/lppl/

This work is maintained by Will Robertson and consists of the files listed in `MANIFEST.md`.
