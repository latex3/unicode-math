#!/usr/bin/env texlua

changeslisting = nil
do
  local f = assert(io.open("CHANGES.md", "r"))
  changeslisting = f:read("*all")
  f:close()
end

currentchanges = string.match(changeslisting,"(## %S+ %(.-%).-)%s*## %S+ %(.-%)")

do
  local f = assert(io.open("CHANGES-NEW.md", "w"))
  f:write(currentchanges)
  f:close()
end

changeslisting = nil
do
  local f = assert(io.open("CHANGES-NEW.md", "r"))
  changeslisting = f:read("*all")
  f:close()
end

print("******************")
print(changeslisting)
print("******************")
