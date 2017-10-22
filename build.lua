#!/usr/bin/env texlua

module = "unicode-math"

sourcefiles  = {"*.dtx","*.ins","unicode-math-table.tex"}
installfiles = {"*.sty","unicode-math-table.tex"}
typesetfiles = {"*.ltx"}
docfiles     = {"um-doc*.tex"}
textfiles    = {"README.md","CHANGES.md"}

checkengines = {"xetex","luatex"}
typesetexe = "xelatex"

packtdszip = true
recordstatus = true

kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))
