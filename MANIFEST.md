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

 | File                   | Flag | Description                                                                   |
 | ---                    | ---  | ---                                                                           |
 | unicode-math.dtx       | ‡    | Metadata for the package code, including files and versioning                 |
 | um-code-base.dtx       | ‡    | Definition of unicode-math.sty, which splits and loads according to engine.   |
 | um-code-opening.dtx    | ‡    | Assorted initialisation tasks, including some low-level function definitions. |
 | um-code-variables.dtx  | ‡    | Declaration of all code-level variables used in the package.                  |
 | um-code-api.dtx        | ‡    | The (underdeveloped) API to interface with the package internals.             |
 | um-code-ui.dtx         | ‡    | The xparse user interface top-level definitions.                              |
 | um-code-pkgopt.dtx     | ‡    | Package options.                                                              |
 | um-code-msg.dtx        | ‡    | Definitions of error, warning, and log messages.                              |
 | um-code-usv.dtx        | ‡    | Mapping of mathematical unicode slots for alphabets.                          |
 | um-code-setchar.dtx    | ‡    | General assignment of maths symbols.                                          |
 | um-code-mathtext.dtx   | ‡    | The "math text" commands such as `\mathbf` and co.                            |
 | um-code-main.dtx       | ‡    | Definition of `\setmainfont`.                                                 |
 | um-code-fontopt.dtx    | ‡    | Keyval for `\setmathfont`                                                     |
 | um-code-fontparam.dtx  | ‡    |                                                                               |
 | um-code-mathmap.dtx    | ‡    | The "math symbol alphabets" such as `\symbf` and co.                          |
 | um-code-epilogue.dtx   | ‡    | Assorted definitions to close up.                                             |
 | um-code-primes.dtx     | ‡    | The definitions needed for the input of primes.                               |
 | um-code-sscript.dtx    | ‡    | Setup for active chars needed to process subscript/superscript input chars.   |
 | um-code-compat.dtx     | ‡    | Compatibility with 3rd party packages.                                        |
 | um-code-alphabets.dtx  | ‡    | Definitions for setting up the "math symbol alphabets".                       |
 | unicode-math.ins       | ‡    | Docstrip installer.                                                           |
 | unicode-math-table.tex | ‡    | Source file of the math symbols.                                              |

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
 2. README.md ‡
 3. LICENSE 

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

These files form the test suite for the package. `.lvt` or `.lte` files are the individual
unit tests, and `.tlg` are the stored output for ensuring changes to the package produce
the same output. These output files are sometimes shared and sometime specific for
different engines (pdfTeX, XeTeX, LuaTeX, etc.).

 1. aaa-loading.lvt 
 2. fontname-log.lvt 
 3. mathit-symit-var.lvt 
 4. mathit-symit.lvt 
 5. aaa-loading.luatex.tlg 
 6. aaa-loading.xetex.tlg 
 7. fontname-log.luatex.tlg 
 8. fontname-log.xetex.tlg 
 9. mathit-symit-var.luatex.tlg 
10. mathit-symit-var.xetex.tlg 
11. mathit-symit.luatex.tlg 
12. mathit-symit.xetex.tlg 


## TDS manifest

The following groups list the files included in the TeX Directory Structure used to install
the package into a TeX distribution.

### Source files (TDS)

All files included in the `unicode-math/source` directory.

 1. um-code-alphabets.dtx 
 2. um-code-api.dtx 
 3. um-code-base.dtx 
 4. um-code-compat.dtx 
 5. um-code-epilogue.dtx 
 6. um-code-fontopt.dtx 
 7. um-code-fontparam.dtx 
 8. um-code-main.dtx 
 9. um-code-mathmap.dtx 
10. um-code-mathtext.dtx 
11. um-code-msg.dtx 
12. um-code-opening.dtx 
13. um-code-pkgopt.dtx 
14. um-code-primes.dtx 
15. um-code-setchar.dtx 
16. um-code-sscript.dtx 
17. um-code-ui.dtx 
18. um-code-usv.dtx 
19. um-code-variables.dtx 
20. unicode-math.dtx 
21. unicode-math.ins 

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
 5. um-code-api.dtx 
 6. um-code-base.dtx 
 7. um-code-compat.dtx 
 8. um-code-epilogue.dtx 
 9. um-code-fontopt.dtx 
10. um-code-fontparam.dtx 
11. um-code-main.dtx 
12. um-code-mathmap.dtx 
13. um-code-mathtext.dtx 
14. um-code-msg.dtx 
15. um-code-opening.dtx 
16. um-code-pkgopt.dtx 
17. um-code-primes.dtx 
18. um-code-setchar.dtx 
19. um-code-sscript.dtx 
20. um-code-ui.dtx 
21. um-code-usv.dtx 
22. um-code-variables.dtx 
23. um-doc-legacyfontdimen.tex 
24. um-doc-main.tex 
25. um-doc-mathfontdimen.tex 
26. um-doc-nfsssummary.tex 
27. um-doc-stixextract.tex 
28. um-doc-style.tex 
29. unicode-math-code.ltx 
30. unicode-math-code.pdf 
31. unicode-math-table.tex 
32. unicode-math.dtx 
33. unicode-math.ins 
34. unicode-math.ltx 
35. unicode-math.pdf 
36. unimath-example.ltx 
37. unimath-example.pdf 
38. unimath-symbols.ltx 
39. unimath-symbols.pdf 
