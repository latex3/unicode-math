________________________
The UNICODE-MATH package
v0.4

This package will provide a complete implementation of unicode maths for
XeTeX. While I do not encourage people to use this package for production
work, I understand that it has certain uses and am making it available for
distribution.

Please be aware that this package is undergoing (very slow) continued
development and the interface and functionality should not be considered
stable. Use at your own risk, in other words.

Unicode maths is currently only supported by the fonts
"Cambria Math" (Microsoft, proprietry) and
"Asana Math" (Apostoulos Syropolous, open source).

Basic usage:
  \setmathfont{Asana Math}

____________
INSTALLATION

Run TeX on unicode-math.dtx to generate the package file unicode-math.sty:
    tex unicode-math.dtx

If you have the necessary fonts, you may compile the documentation
with XeLaTeX:
    xelatex -shell-escape unicode-math.dtx

To install the package, place unicode-math.sty and unicode-math-table.tex
in a place searched by XeLaTeX; for example, on Mac OS X:
    ~/Library/texmf/tex/xelatex/

__________________________________
Copyright 2006-2009 Will Robertson
Released under the LaTeX Project Public License
