#!/usr/bin/env texlua

module = "unicode-math"

sourcefiles  = {"*.dtx","unicode-math-table.tex"}
unpackfiles  = {"unicode-math.dtx"}
installfiles = {"*.sty","unicode-math-table.tex"}
typesetfiles = {"unicode-math.dtx","unimath-symbols.ltx"}
docfiles     = {"unicode-math-doc.tex"}
demofiles    = {"unimath-example.ltx"}

checkengines = {"xetex","luatex"}
typesetexe = "xelatex"

packtdszip = true
recordstatus = true

kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))
