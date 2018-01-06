# Development guide for `unicode-math`

This document covers both guidelines for issues and pull requests and
the general development details of the `unicode-math` package.


## Issues

If you're reading this to find out more about reporting an issue in the package,
thanks for taking the time! And apologies that I take longer, sometimes
*way longer*, than I should to address them.

There are two important key points for submitting an issue:

* When submitting an issue, please include a *complete* minimal example.
* When loading maths fonts, please do so by *filename* only.
* If you are using a proprietary/unusual font, please try a maths font in TeX Live to see
  if it exhibits the same behaviour; it's obviously much harder for me to test with fonts
  I don't yet have or can't access.

For example, this is a good minimal example:

    \documentclass{article}
    \usepackage{unicode-math}
    \setmathfont{texgyrepagella-math.otf}
    \begin{document}
    \[
      x^2 + y^2 = z^2
    \]
    \end{document}

This is an example of a *bad* example:

    \usepackage{unicode-math}
    \setmathfont{TeX Gyre Pagella Math}

    % later:
    \[
      x^2 + y^2 = z^2
    \]


## Branches and Pull Requests

There are two main branches in this repository: `master` and `working`.
Development happens on the `working` branch; once a release is sent to CTAN,
the `master` branch is rebased to bring it up to date.

The `working` branch should be considered only semi-public; it may have broken
code and/or use force-pushing to rewrite history on occasions.

If you wish to make a contribution, please start from the `master` branch.
Only ‘rebase’ or ‘squash rebase’ will be used to accept pull requests.

If you are changing documentation only (i.e., no code changes), you can add
`[ci skip]` to the commit message and the test suite won't be run to check that
the changes haven't broken anything.


## Test suite and Continuous Integration

The `l3build` system is used to maintain a test suite for the package.
This test suite is used in the Travis CI system to continuously monitor whether
the code passes the test suite.

* `master` branch:  [![Build Status](https://travis-ci.org/wspr/unicode-math.svg?branch=master)](https://travis-ci.org/wspr/unicode-math)
* `working` branch: [![Build Status](https://travis-ci.org/wspr/unicode-math.svg?branch=working)](https://travis-ci.org/wspr/unicode-math)

The test suite is intended to be portable. To try it out yourself, simply run
`texlua build.lua check` and grab a quick coffee. With any luck you should see
that the test suite passes!


## Copyright

Copyright statements in most package files are updated en masse by the bash script
`update-copyright.sh` using the file COPYRIGHT as a template.
(The updating script has been tested on macOS only.)

Contributors are listed in the copyright statement if they have more than one
entry in the following list:

    git log --all --date=short --format='%cN %ad'  | sed 's/\(.*[0-9]*\)-[0-9]*-[0-9]*/\1/' | sort -u

Contributors are added to the COPYRIGHT file manually. If your name doesn't appear
in that list, you might need to check your Git setup.

