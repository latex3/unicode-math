#!/usr/bin/env texlua

module = "unicode-math"

sourcefiles  = {"*.dtx","unicode-math-table.tex"}
unpackfiles  = {"unicode-math.dtx"}
installfiles = {"*.sty","unicode-math-table.tex"}
typesetfiles = {"unicode-math.dtx","unimath-symbols.ltx"}
docfiles     = {"unicode-math-doc.tex"}
demofiles    = {"unimath-example.ltx"}

checkopts   = " -interaction=errorstopmode -halt-on-error "

checkengines = {"xetex","luatex"}
stdengine  = "luatex"
typesetexe = "xelatex"

packtdszip = true

kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))
