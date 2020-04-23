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
 | um-code-alphabets.dtx    | ‡    | Definitions for setting up the "math symbol alphabets".                       |
 | um-code-amsmath.dtx      | ‡    | Compatibility with amsmath.                                                   |
 | um-code-api.dtx          | ‡    | The (underdeveloped) API to interface with the package internals.             |
 | um-code-compat.dtx       | ‡    | Compatibility with 3rd party packages.                                        |
 | um-code-epilogue.dtx     | ‡    | Assorted definitions to close up.                                             |
 | um-code-fontopt.dtx      | ‡    | Keyval for `\setmathfont`                                                     |
 | um-code-fontparam.dtx    | ‡    | Cross-platform interface for font parameters                                  |
 | um-code-main.dtx         | ‡    | Definition of `\setmainfont`.                                                 |
 | um-code-mathmap.dtx      | ‡    | Setup of symbol alphabets.                                                    |
 | um-code-mathtext.dtx     | ‡    | The "math text" commands such as `\mathbf` and co.                            |
 | um-code-msg.dtx          | ‡    | Definitions of error, warning, and log messages.                              |
 | um-code-opening.dtx      | ‡    | Assorted initialisation tasks, including some low-level function definitions. |
 | um-code-pkgopt.dtx       | ‡    | Package options.                                                              |
 | um-code-primes.dtx       | ‡    | The definitions needed for the input of primes.                               |
 | um-code-setchar.dtx      | ‡    | General assignment of maths symbols.                                          |
 | um-code-sscript.dtx      | ‡    | Setup for active chars needed to process subscript/superscript input chars.   |
 | um-code-sym-commands.dtx | ‡    | Definition of "math symbol alphabet" commands such as `\symbf` and co.        |
 | um-code-ui.dtx           | ‡    | The xparse user interface top-level definitions.                              |
 | um-code-usv.dtx          | ‡    | Mapping of mathematical unicode slots for alphabets.                          |
 | um-code-variables.dtx    | ‡    | Declaration of all code-level variables used in the package.                  |
 | unicode-math.dtx         | ‡    | Metadata for the package code, including files and versioning                 |
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

 1. um-doc-legacyfontdimen.tex ‡
 2. um-doc-main.tex ‡
 3. um-doc-mathfontdimen.tex ‡
 4. um-doc-nfsssummary.tex ‡
 5. um-doc-stixextract.tex ‡
 6. um-doc-style.tex ‡

### Text files

Plain text files included as documentation or metadata.

 1. CHANGES.md ‡
 2. MANIFEST.md ‡
 3. README.md ‡
 4. RELEASE_CHECKLIST.md ‡
 5. LICENSE 

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
 2. aaa-sym.lvt 
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
18. cramped-style.lvt 
19. fontname-log.lvt 
20. hyphen.lvt 
21. input-fullwidth.lvt 
22. lmdefault-mathrm-it-bf.lvt 
23. mathit-symit-var.lvt 
24. mathit-symit.lvt 
25. mathoperator-mathbf.lvt 
26. mathrm-mathcal-nest.lvt 
27. mathrm-nobraces.lvt 
28. mathsizes.lvt 
29. mathstyle-french.lvt 
30. mathstyle-iso.lvt 
31. mathstyle-literal.lvt 
32. mathstyle-tex.lvt 
33. mathstyle-upright.lvt 
34. nabla.lvt 
35. nesting.lvt 
36. not.lvt 
37. operatorname.lvt 
38. partial.lvt 
39. radical-cuberoot-output.lvt 
40. range-char-cmd.lvt 
41. range-class.lvt 
42. range-nabla-partial.lvt 
43. range-up-num.lvt 
44. setmathfontface.lvt 
45. setmathsf.lvt 
46. sqrt-amsmath-output.lvt 
47. style-Bbbit.lvt 
48. url.lvt 
49. aaa-loading.luatex.tlg 
50. aaa-loading.xetex.tlg 
51. aaa-sym.luatex.tlg 
52. aaa-sym.xetex.tlg 
53. active-frac.luatex.tlg 
54. active-frac.xetex.tlg 
55. active-sscripts-amsmath.luatex.tlg 
56. active-sscripts-amsmath.xetex.tlg 
57. active-sscripts.luatex.tlg 
58. active-sscripts.xetex.tlg 
59. alph-range-calscr.luatex.tlg 
60. alph-range-calscr.xetex.tlg 
61. alph-range-fallback.luatex.tlg 
62. alph-range-fallback.xetex.tlg 
63. alph-range-mapping.luatex.tlg 
64. alph-range-mapping.xetex.tlg 
65. alph-range-sym-alph.luatex.tlg 
66. alph-range-sym-alph.xetex.tlg 
67. alph-range-sym-range.luatex.tlg 
68. alph-range-sym-range.xetex.tlg 
69. alph-sym.luatex.tlg 
70. alph-sym.xetex.tlg 
71. ascii-catcodes.luatex.tlg 
72. ascii-catcodes.xetex.tlg 
73. boldstyle-french.luatex.tlg 
74. boldstyle-french.xetex.tlg 
75. boldstyle-iso.luatex.tlg 
76. boldstyle-iso.xetex.tlg 
77. boldstyle-literal.luatex.tlg 
78. boldstyle-literal.xetex.tlg 
79. boldstyle-tex.luatex.tlg 
80. boldstyle-tex.xetex.tlg 
81. boldstyle-upright.luatex.tlg 
82. boldstyle-upright.xetex.tlg 
83. cramped-style.luatex.tlg 
84. cramped-style.xetex.tlg 
85. fontname-log.luatex.tlg 
86. fontname-log.xetex.tlg 
87. hyphen.luatex.tlg 
88. hyphen.xetex.tlg 
89. input-fullwidth.luatex.tlg 
90. input-fullwidth.xetex.tlg 
91. lmdefault-mathrm-it-bf.luatex.tlg 
92. lmdefault-mathrm-it-bf.xetex.tlg 
93. mathit-symit-var.luatex.tlg 
94. mathit-symit-var.xetex.tlg 
95. mathit-symit.luatex.tlg 
96. mathit-symit.xetex.tlg 
97. mathoperator-mathbf.luatex.tlg 
98. mathoperator-mathbf.xetex.tlg 
99. mathrm-mathcal-nest.luatex.tlg 
100. mathrm-mathcal-nest.xetex.tlg 
101. mathrm-nobraces.luatex.tlg 
102. mathrm-nobraces.xetex.tlg 
103. mathsizes.luatex.tlg 
104. mathsizes.xetex.tlg 
105. mathstyle-french.luatex.tlg 
106. mathstyle-french.xetex.tlg 
107. mathstyle-iso.luatex.tlg 
108. mathstyle-iso.xetex.tlg 
109. mathstyle-literal.luatex.tlg 
110. mathstyle-literal.xetex.tlg 
111. mathstyle-tex.luatex.tlg 
112. mathstyle-tex.xetex.tlg 
113. mathstyle-upright.luatex.tlg 
114. mathstyle-upright.xetex.tlg 
115. nabla.luatex.tlg 
116. nabla.xetex.tlg 
117. nesting.luatex.tlg 
118. nesting.xetex.tlg 
119. not.luatex.tlg 
120. not.xetex.tlg 
121. operatorname.luatex.tlg 
122. operatorname.xetex.tlg 
123. partial.luatex.tlg 
124. partial.xetex.tlg 
125. radical-cuberoot-output.luatex.tlg 
126. radical-cuberoot-output.xetex.tlg 
127. range-char-cmd.luatex.tlg 
128. range-char-cmd.xetex.tlg 
129. range-class.luatex.tlg 
130. range-class.xetex.tlg 
131. range-nabla-partial.luatex.tlg 
132. range-nabla-partial.xetex.tlg 
133. range-up-num.luatex.tlg 
134. range-up-num.xetex.tlg 
135. setmathfontface.luatex.tlg 
136. setmathfontface.xetex.tlg 
137. setmathsf.luatex.tlg 
138. setmathsf.xetex.tlg 
139. sqrt-amsmath-output.luatex.tlg 
140. sqrt-amsmath-output.xetex.tlg 
141. style-Bbbit.luatex.tlg 
142. style-Bbbit.xetex.tlg 
143. url.luatex.tlg 
144. url.xetex.tlg 


## TDS manifest

The following groups list the files included in the TeX Directory Structure used to install
the package into a TeX distribution.

### Source files (TDS)

All files included in the `unicode-math/source` directory.

 1. um-code-alphabets.dtx 
 2. um-code-amsmath.dtx 
 3. um-code-api.dtx 
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
17. um-code-sym-commands.dtx 
18. um-code-ui.dtx 
19. um-code-usv.dtx 
20. um-code-variables.dtx 
21. unicode-math.dtx 
22. unicode-math.ins 

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
 4. RELEASE_CHECKLIST.md 
 5. um-doc-legacyfontdimen.tex 
 6. um-doc-main.tex 
 7. um-doc-mathfontdimen.tex 
 8. um-doc-nfsssummary.tex 
 9. um-doc-stixextract.tex 
10. um-doc-style.tex 
11. unicode-math-code.ltx 
12. unicode-math-code.pdf 
13. unicode-math.ltx 
14. unicode-math.pdf 
15. unimath-example.ltx 
16. unimath-example.pdf 
17. unimath-symbols.ltx 
18. unimath-symbols.pdf 


## CTAN manifest

The following group lists the files included in the CTAN package.

### CTAN files

 1. CHANGES.md 
 2. MANIFEST.md 
 3. README.md 
 4. RELEASE_CHECKLIST.md 
 5. um-code-alphabets.dtx 
 6. um-code-amsmath.dtx 
 7. um-code-api.dtx 
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
