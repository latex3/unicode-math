#!/usr/bin/env texlua

module = "unicode-math"

sourcefiles  = {"*.dtx","*.ins","unicode-math-table.tex"}
installfiles = {"*.sty","unicode-math-table.tex"}
typesetfiles = {"*.ltx"}
docfiles     = {"um-doc-*.tex"}
textfiles    = {"*.md","LICENSE"}
versionfiles = {"unicode-math.dtx","CHANGES.md"}

checkengines = {"xetex","luatex"}
typesetexe = "xelatex"

packtdszip = true
recordstatus = true


-- [2017/11/18 v0.8i Unicode maths in XeLaTeX and LuaLaTeX]

changeslisting = nil
do
  local f = assert(io.open("CHANGES.md", "r"))
  changeslisting = f:read("*all")
  f:close()
end
pkgversion = string.match(changeslisting,"- (%S+) %(.*%)")
print('Current version (from first entry in CHANGES.md): '..pkgversion)

local changesversion = true

function setversion_update_line(line, date, version)
  local lineorig = line
  local date = string.gsub(date, "%-", "/")

  if string.match(line, "%[%d%d%d%d/%d%d/%d%d %S+ .*%]") then
    print("Found line: (unicode-math.dtx)")
    print(line)
    line = line:gsub("%d%d%d%d/%d%d/%d%d", date)
    line = line:gsub("%[(%d%d%d%d/%d%d/%d%d) (%S+) (.*)%]", "["..date.." "..pkgversion.." %3]")
  end

  if changesversion and string.match(line, "- (%S+) %(.*%)") then
    changesversion = false
    print("Found line: (CHANGES.md)")
    print(line)
    line = line:gsub("- (%S+) %(.*%)","- %1 ("..date..")")
  end

  if not(line==lineorig) then
		print("Replaced with line:")
		print(line)
  end

  return line
end



--[[
     MANIFEST SETTINGS
--]]

filematches = {}
filematches["CHANGES.md"] = "Chronological list of release notes"
filematches["LICENSE"]    = "Copy of the LPPL"
filematches["README.md"]  = "General information about the package"


-- improve sorting
dtxlisting = nil
ltxlisting = nil
do
  local f = assert(io.open("unicode-math.dtx", "r"))
  dtxlisting = f:read("*all")
  f:close()
  local f = assert(io.open("unicode-math.ltx", "r"))
  ltxlisting = f:read("*all")
  f:close()
end

sort_by_loc = function(str,x,y)
  m = string.find(str,x,1,true)
  n = string.find(str,y,1,true)
  return n > m
end

manifest_sort_within_match = manifest_sort_within_match or function(files)
  local f = files
  local sortfn = function(x,y) return y>x end

  if f[1] then
		if string.match(f[1],".*%.dtx") then
			sortfn = function(x,y) return sort_by_loc(dtxlisting,x,y) end
		elseif string.match(f[1],".*%.tex") then
			sortfn = function(x,y) return sort_by_loc(ltxlisting,x,y) end
		end
	end

  table.sort(f,sortfn)
  return f
end


-- use an enumerated list for files (mostly just for testing)
manifest_write_group_file = function(filehandle,filename,param)
  filehandle:write(string.format("%2i",param.count)..". " .. filename .. " " .. (param.flag or "") .. "\n")
end


-- Extract file descriptions from the 2nd line of each file:
manifest_extract_filedesc = function(filehandle,filename)

  filedesc = filematches[filename]
  if not(filedesc) then

    local end_read_loop = 2
    local matchstr      = "%%%S%s+(.*)"
    local this_line     = ""

    for ii = 1, end_read_loop do
      this_line = filehandle:read("*line")
    end

    filedesc = string.match(this_line,matchstr)
  end

  return filedesc
end


-- finally run l3build proper:
kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))
