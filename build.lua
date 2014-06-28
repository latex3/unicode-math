#!/usr/bin/env texlua

-- Build script for breqn

module = "unicode-math"

unpackfiles = {"*.dtx"}

excludefiles = {}

--[[
deps = {"../l3svn/l3kernel","../l3svn/l3packages/xparse"}
checkdeps   = deps
typesetdeps = deps
unpackdeps  = deps
--]]

checkopts   = "-interaction=nonstopmode"

stdengine  = "luatex"
chkengines = {"xetex","luatex"}

kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))
