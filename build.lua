#!/usr/bin/env texlua

module = "unicode-math"

sourcefiles  = {"*.dtx","*.ins","unicode-math-table.tex"}
installfiles = {"*.sty","unicode-math-table.tex"}
typesetfiles = {"*.ltx"}
docfiles     = {"um-doc-*.tex"}
textfiles    = {"*.md","LICENSE"}

checkengines = {"xetex","luatex"}
typesetexe = "xelatex"

packtdszip = true
recordstatus = true

manifestoptions =
  {
    extractfromline = true  ,
    extractfromfile = false ,
    linenumber      = 2,
    matchstr        = "%%%S%s+(.*)",
  }


kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))
