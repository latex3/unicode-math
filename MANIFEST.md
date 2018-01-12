# Manifest for unicode-math

This file is a listing of all files considered to be part of this package.
It is automatically generated with `texlua build.lua manifest`.


## Repository manifest

The following groups list the files included in the development repository of the package.
Files listed with a ‘†’ marker are included in the TDS but not CTAN files, and files listed
with ‘‡’ are included in both.

### Source files

These are source files for a number of purposes, including the `unpack` process which
generates the installation files of the package. Additional files included here will also
be installed for processing such as testing.

 | File                     | Flag | Description                                                                   |
 | ---                      | ---  | ---                                                                           |
 | unicode-math.dtx         | ‡    | Metadata for the package code, including files and versioning                 |
 | um-code-base.dtx         | ‡    | Definition of unicode-math.sty, which splits and loads according to engine.   |
 | um-code-opening.dtx      | ‡    | Assorted initialisation tasks, including some low-level function definitions. |
 | um-code-variables.dtx    | ‡    | Declaration of all code-level variables used in the package.                  |
 | um-code-api.dtx          | ‡    | The (underdeveloped) API to interface with the package internals.             |
 | um-code-ui.dtx           | ‡    | The xparse user interface top-level definitions.                              |
 | um-code-pkgopt.dtx       | ‡    | Package options.                                                              |
 | um-code-msg.dtx          | ‡    | Definitions of error, warning, and log messages.                              |
 | um-code-usv.dtx          | ‡    | Mapping of mathematical unicode slots for alphabets.                          |
 | um-code-setchar.dtx      | ‡    | General assignment of maths symbols.                                          |
 | um-code-mathtext.dtx     | ‡    | The "math text" commands such as `\mathbf` and co.                            |
 | um-code-main.dtx         | ‡    | Definition of `\setmainfont`.                                                 |
 | um-code-fontopt.dtx      | ‡    | Keyval for `\setmathfont`                                                     |
 | um-code-fontparam.dtx    | ‡    | Cross-platform interface for font parameters                                  |
 | um-code-mathmap.dtx      | ‡    | Setup of symbol alphabets.                                                    |
 | um-code-sym-commands.dtx | ‡    | Definition of "math symbol alphabet" commands such as `\symbf` and co.        |
 | um-code-alphabets.dtx    | ‡    | Definitions for setting up the "math symbol alphabets".                       |
 | um-code-epilogue.dtx     | ‡    | Assorted definitions to close up.                                             |
 | um-code-primes.dtx       | ‡    | The definitions needed for the input of primes.                               |
 | um-code-sscript.dtx      | ‡    | Setup for active chars needed to process subscript/superscript input chars.   |
 | um-code-compat.dtx       | ‡    | Compatibility with 3rd party packages.                                        |
 | um-code-amsmath.dtx      | ‡    | Compatibility with amsmath.                                                   |
 | unicode-math.ins         | ‡    | Docstrip installer.                                                           |
 | unicode-math-table.tex   | ‡    | Source file of the math symbols.                                              |

### Typeset documentation source files

These files are typeset using LaTeX to produce the PDF documentation for the package.

 | File                  | Flag | Description                                                      |
 | ---                   | ---  | ---                                                              |
 | unicode-math-code.ltx | ‡    | Typeset code.                                                    |
 | unicode-math.ltx      | ‡    | User documentation.                                              |
 | unimath-example.ltx   | ‡    | A minimal example file to demonstrate the package.               |
 | unimath-symbols.ltx   | ‡    | Listing of Unicode mathematics symbols using a variety of fonts. |

### Documentation files

These files form part of the documentation but are not typeset. Generally they will be
additional input files for the typeset documentation files listed above.

 1. um-doc-style.tex ‡
 2. um-doc-main.tex ‡
 3. um-doc-stixextract.tex ‡
 4. um-doc-nfsssummary.tex ‡
 5. um-doc-legacyfontdimen.tex ‡
 6. um-doc-mathfontdimen.tex ‡

### Text files

Plain text files included as documentation or metadata.

 1. CHANGES.md ‡
 2. MANIFEST.md ‡
 3. README.md ‡
 4. LICENSE 

### Derived files

The files created by ‘unpacking’ the package sources. This typically includes
`.sty` and `.cls` files created from DocStrip `.dtx` files.

 1. unicode-math-luatex.sty †
 2. unicode-math-xetex.sty †
 3. unicode-math.sty †

### Typeset documents

The output files (PDF, essentially) from typesetting the various source, demo,
etc., package files.

 1. unicode-math-code.pdf ‡
 2. unicode-math.pdf ‡
 3. unimath-example.pdf ‡
 4. unimath-symbols.pdf ‡

### Checking-specific support files

Support files for checking the test suite.

 1. umtest-preamble.tex 

### Test files

These files form the test suite for the package. The listed `.lvt` files are the individual unit tests, with matching `.tlg` (not shown, for brevity) are the stored output for ensuring changes to the package produce the same output.

 1. Bbbit.lvt 
 2. aaa-loading.lvt 
 3. active-frac.lvt 
 4. active-sscripts-amsmath.lvt 
 5. active-sscripts.lvt 
 6. alph-range-calscr.lvt 
 7. alph-range-fallback.lvt 
 8. alph-range-mapping.lvt 
 9. alph-range-sym-alph.lvt 
10. alph-range-sym-range.lvt 
11. alph-sym.lvt 
12. ascii-catcodes.lvt 
13. boldstyle-french.lvt 
14. boldstyle-iso.lvt 
15. boldstyle-literal.lvt 
16. boldstyle-tex.lvt 
17. boldstyle-upright.lvt 
18. fontname-log.lvt 
19. hyphen.lvt 
20. input-fullwidth.lvt 
21. lmdefault-mathrm-it-bf.lvt 
22. mathit-symit-var.lvt 
23. mathit-symit.lvt 
24. mathsizes.lvt 
25. mathstyle-french.lvt 
26. mathstyle-iso.lvt 
27. mathstyle-literal.lvt 
28. mathstyle-tex.lvt 
29. mathstyle-upright.lvt 
30. nabla.lvt 
31. not.lvt 
32. operatorname.lvt 
33. partial.lvt 
34. range-char-cmd.lvt 
35. range-class.lvt 
36. range-up-num.lvt 
37. setmathsf.lvt 
38. sqrt-amsmath-exec.lvt 
39. sqrt-amsmath-output.lvt 
40. sqrt-exec.lvt 
41. sqrt-output.lvt 


## TDS manifest

The following groups list the files included in the TeX Directory Structure used to install
the package into a TeX distribution.

### Source files (TDS)

All files included in the `unicode-math/source` directory.

 1. um-code-alphabets.dtx 
 2. um-code-amsmath.dtx 
 3. um-code-api.dtx 
 4. um-code-base.dtx 
 5. um-code-compat.dtx 
 6. um-code-epilogue.dtx 
 7. um-code-fontopt.dtx 
 8. um-code-fontparam.dtx 
 9. um-code-main.dtx 
10. um-code-mathmap.dtx 
11. um-code-mathtext.dtx 
12. um-code-msg.dtx 
13. um-code-opening.dtx 
14. um-code-pkgopt.dtx 
15. um-code-primes.dtx 
16. um-code-setchar.dtx 
17. um-code-sscript.dtx 
18. um-code-sym-commands.dtx 
19. um-code-ui.dtx 
20. um-code-usv.dtx 
21. um-code-variables.dtx 
22. unicode-math.dtx 
23. unicode-math.ins 

### TeX files (TDS)

All files included in the `unicode-math/tex` directory.

 1. unicode-math-luatex.sty 
 2. unicode-math-table.tex 
 3. unicode-math-xetex.sty 
 4. unicode-math.sty 

### Doc files (TDS)

All files included in the `unicode-math/doc` directory.

 1. CHANGES.md 
 2. MANIFEST.md 
 3. README.md 
 4. um-doc-legacyfontdimen.tex 
 5. um-doc-main.tex 
 6. um-doc-mathfontdimen.tex 
 7. um-doc-nfsssummary.tex 
 8. um-doc-stixextract.tex 
 9. um-doc-style.tex 
10. unicode-math-code.ltx 
11. unicode-math-code.pdf 
12. unicode-math.ltx 
13. unicode-math.pdf 
14. unimath-example.ltx 
15. unimath-example.pdf 
16. unimath-symbols.ltx 
17. unimath-symbols.pdf 


## CTAN manifest

The following group lists the files included in the CTAN package.

### CTAN files

 1. CHANGES.md 
 2. MANIFEST.md 
 3. README.md 
 4. um-code-alphabets.dtx 
 5. um-code-amsmath.dtx 
 6. um-code-api.dtx 
 7. um-code-base.dtx 
 8. um-code-compat.dtx 
 9. um-code-epilogue.dtx 
10. um-code-fontopt.dtx 
11. um-code-fontparam.dtx 
12. um-code-main.dtx 
13. um-code-mathmap.dtx 
14. um-code-mathtext.dtx 
15. um-code-msg.dtx 
16. um-code-opening.dtx 
17. um-code-pkgopt.dtx 
18. um-code-primes.dtx 
19. um-code-setchar.dtx 
20. um-code-sscript.dtx 
21. um-code-sym-commands.dtx 
22. um-code-ui.dtx 
23. um-code-usv.dtx 
24. um-code-variables.dtx 
25. um-doc-legacyfontdimen.tex 
26. um-doc-main.tex 
27. um-doc-mathfontdimen.tex 
28. um-doc-nfsssummary.tex 
29. um-doc-stixextract.tex 
30. um-doc-style.tex 
31. unicode-math-code.ltx 
32. unicode-math-code.pdf 
33. unicode-math-table.tex 
34. unicode-math.dtx 
35. unicode-math.ins 
36. unicode-math.ltx 
37. unicode-math.pdf 
38. unimath-example.ltx 
39. unimath-example.pdf 
40. unimath-symbols.ltx 
41. unimath-symbols.pdf 
