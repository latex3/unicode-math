#!/usr/bin/env texlua

module = "unicode-math"

sourcefiles  = {"*.dtx","*.ins","*.tex","*.ltx"}
installfiles = {"*.sty","unicode-math-table.tex"}
typesetfiles = {"*.ltx"}
textfiles    = {"*.md","LICENSE"}

checkengines = {"xetex","luatex"}
typesetexe = "xelatex"

packtdszip = true
recordstatus = true

kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))
