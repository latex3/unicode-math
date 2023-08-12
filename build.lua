
--[================[--
      PARAMETERS
--]================]--

math.randomseed( os.time() )

module = "unicode-math"

sourcefiles  = {"*.dtx","*.ins","unicode-math-table.tex"}
installfiles = {"*.sty","unicode-math-table.tex"}
typesetfiles = {"*.ltx"}
docfiles     = {"um-doc-*.tex"}
textfiles    = {"*.md","LICENSE"}
tagfiles     = {"unicode-math.dtx","CHANGES.md"}

checkengines = {"xetex","luatex"}

typesetexe   = "xelatex"
typesetopts  = " -shell-escape -interaction=nonstopmode "

packtdszip = true
recordstatus = true

--[===[
   DEV
--]===]

function os.capture(cmd)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

gitbranch = os.capture('git rev-parse --abbrev-ref HEAD')
specialformats = specialformats or {}
if gitbranch == "develop" then
  specialformats.latex = {
    xetex  = {binary = "xetex",    format = "xelatex-dev"},
    luatex = {binary = "luahbtex", format = "lualatex-dev"},
  }
end

--[=============[--
      VERSION
--]=============]--

changeslisting = nil
do
  local f = assert(io.open("CHANGES.md", "r"))
  changeslisting = f:read("*all")
  f:close()
end
currentchanges = string.match(changeslisting,"(## %S+ %(.-%).-)%s*## %S+ %(.-%)")
pkgversion = string.match(changeslisting,"## v(%S+) %(.-%)")
gittag = 'v'..pkgversion

print('Current version (from first entry in CHANGES.md): '..pkgversion)


--[=================[--
      CTAN UPLOAD
--]=================]--

uploadconfig = {
  version      = pkgversion,
  author       = "Will Robertson",
  license      = "lppl1.3c",
  summary      = "Unicode mathematics support for XeLaTeX and LuaLaTeX",
  ctanPath     = "/macros/latex/contrib/unicode-math",
  repository   = "https://github.com/wspr/unicode-math/",
  bugtracker   = "https://github.com/wspr/unicode-math/issues",
  announcement = currentchanges,
}

local function prequire(m) -- from: https://stackoverflow.com/a/17878208
  local ok, err = pcall(require, m)
  if not ok then return nil, err end
  return err
end

prequire("l3build-wspr.lua")


--[=============[--
      TAGGING
--]=============]--

function update_tag(file, content, tagname, tagdate)
  local date = string.gsub(tagdate, "%-", "/")

  if string.match(content, "{%d%d%d%d/%d%d/%d%d}%s*{[^}]+}%s*{[^}]+}") then
    print("Found expl3 version line in file: "..file)
    content = content:gsub("{%d%d%d%d/%d%d/%d%d}(%s*){[^}]+}(%s*){([^}]+)}",
    "{"..date.."}%1{"..pkgversion.."}%2{%3}")
  end
  if string.match(content, "\\def\\filedate{%d%d%d%d/%d%d/%d%d}") then
    print("Found filedate line in file: "..file)
    content = content:gsub("\\def\\filedate{[^}]+}", "\\def\\filedate{"..date.."}")
  end
  if string.match(content, "\\def\\fileversion{[^}]+}") then
    print("Found fileversion line in file: "..file)
    content = content:gsub("\\def\\fileversion{[^}]+}", "\\def\\fileversion{"..pkgversion.."}")
  end

  if string.match(content, "## (%S+) %([^)]+%)") then
    print("Found changes line in file: "..file)
    content = content:gsub("## (%S+) %([^)]+%)","## %1 ("..date..")",1)
  end

  return content
end



--[==============[--
      MANIFEST
--]==============]--


manifest_setup = manifest_setup or function()
  local groups = {
    {
       subheading = "Repository manifest",
       description = [[
The following groups list the files included in the development repository of the package.
Files listed with a ‘†’ marker are included in the TDS but not CTAN files, and files listed
with ‘‡’ are included in both.
]],
    },
    {
       name    = "Source files",
       description = [[
These are source files for a number of purposes, including the `unpack` process which
generates the installation files of the package. Additional files included here will also
be installed for processing such as testing.
]],
       files   = {sourcefiles},
       dir     = sourcefiledir or maindir, -- TODO: remove "or maindir" after rebasing onto master
    },
    {
       name    = "Typeset documentation source files",
       description = [[
These files are typeset using LaTeX to produce the PDF documentation for the package.
]],
       files   = {typesetfiles,typesetsourcefiles,typesetdemofiles},
    },
    {
       name    = "Documentation files",
       description = [[
These files form part of the documentation but are not typeset. Generally they will be
additional input files for the typeset documentation files listed above.
]],
       files   = {docfiles},
       dir     = docfiledir or maindir, -- TODO: remove "or maindir" after rebasing onto master
    },
    {
       name    = "Text files",
       description = [[
Plain text files included as documentation or metadata.
]],
       files   = {textfiles},
       skipfiledescription = true,
    },
    {
       name    = "Demo files",
       description = [[
Files included to demonstrate package functionality. These files are *not*
typeset or compiled in any way.
]],
       files   = {demofiles},
    },
    {
       name    = "Bibliography and index files",
       description = [[
Supplementary files used for compiling package documentation.
]],
       files   = {bibfiles,bstfiles,makeindexfiles},
    },
    {
       name    = "Derived files",
       description = [[
The files created by ‘unpacking’ the package sources. This typically includes
`.sty` and `.cls` files created from DocStrip `.dtx` files.
]],
       files   = {installfiles},
       exclude = {excludefiles,sourcefiles},
       dir     = unpackdir,
       skipfiledescription = true,
    },
    {
       name    = "Typeset documents",
       description = [[
The output files (PDF, essentially) from typesetting the various source, demo,
etc., package files.
]],
       files   = {typesetfiles,typesetsourcefiles,typesetdemofiles},
       rename  = {"%.%w+$", ".pdf"},
       skipfiledescription = true,
    },
    {
       name    = "Support files",
       description = [[
These files are used for unpacking, typesetting, or checking purposes.
]],
       files   = {unpacksuppfiles,typesetsuppfiles,checksuppfiles},
       dir     = supportdir,
    },
    {
       name    = "Release files",
       description = [[
These files are used to manage the package behind the scenes. Not part of a CTAN release.
]],
       files   = {"*.lua"},
       dir     = maindir,
    },
    {
       name    = "Travis files",
       description = [[
These are used to set up Travis CI. Not part of a CTAN release.
]],
       files   = {"texlive.*",".travis.yml"},
       dir     = maindir,
    },
    {
       name    = "Checking-specific support files",
       description = [[
Support files for checking the test suite. Not part of a CTAN release.
]],
       files   = {"*.*"},
       exclude = {{".",".."},excludefiles},
       dir     = testsuppdir,
    },
    {
       name    = "Test files",
       description = [[
These files form the test suite for the package. The listed `.lvt` files are the individual unit tests, with matching `.tlg` (not shown, for brevity) are the stored output for ensuring changes to the package produce the same output. Not part of a CTAN release.
]],
       files   = {"*"..lvtext,"*"..lveext},
       dir     = testfiledir,
       skipfiledescription = true,
    },
    {
       subheading = "TDS manifest",
       description = [[
The following groups list the files included in the TeX Directory Structure used to install
the package into a TeX distribution.
]],
    },
    {
       name    = "Source files (TDS)",
       description = "All files included in the `"..module.."/source` directory.\n",
       dir     = tdsdir.."/source/"..moduledir,
       files   = {"*.*"},
       exclude = {".",".."},
       flag    = false,
       skipfiledescription = true,
    },
    {
       name    = "TeX files (TDS)",
       description = "All files included in the `"..module.."/tex` directory.\n",
       dir     = tdsdir.."/tex/"..moduledir,
       files   = {"*.*"},
       exclude = {".",".."},
       flag    = false,
       skipfiledescription = true,
    },
    {
       name    = "Doc files (TDS)",
       description = "All files included in the `"..module.."/doc` directory.\n",
       dir     = tdsdir.."/doc/"..moduledir,
       files   = {"*.*"},
       exclude = {".",".."},
       flag    = false,
       skipfiledescription = true,
    },
    {
       subheading = "CTAN manifest",
       description = [[
The following group lists the files included in the CTAN package.
]],
    },
    {
       name    = "CTAN files",
       dir     = ctandir.."/"..module,
       files   = {"*.*"},
       exclude = {".",".."},
       flag    = false,
       skipfiledescription = true,
    },
  }
  return groups
end




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

