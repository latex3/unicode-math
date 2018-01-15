#!/usr/bin/env texlua

changeslisting = nil
do
  local f = assert(io.open("CHANGES-NEW.md", "r"))
  changeslisting = f:read("*all")
  f:close()
end
pkgversion = string.match(changeslisting,"## (%S+) %(.-%)")
print('Current version (from entry in CHANGES-NEW.md): '..pkgversion)

print('Current tag:')
os.execute('git tag --contains | head -n1')

gitcmd = 'git tag -a \''..pkgversion..'\' -F CHANGES-NEW.md'
print(gitcmd)
os.execute(gitcmd)
