#!/usr/bin/env texlua

module = "unicode-math"

--[[
deps = {"../l3svn/l3kernel","../l3svn/l3packages/xparse"}
checkdeps   = deps
typesetdeps = deps
unpackdeps  = deps
--]]

excludefiles = {}

sourcefiles = {"*.dtx","unicode-math-table.tex"}
unpackfiles = {"unicode-math.dtx"}
installfiles = {"*.sty","unicode-math-table.tex"}

checkopts   = " -interaction=errorstopmode -halt-on-error "

checkengines = {"xetex","luatex"}
stdengine  = "luatex"

kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))
