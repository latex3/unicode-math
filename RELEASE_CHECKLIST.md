# UNICODE-MATH RELEASE CHECKLIST

- [ ] Finish final changes on `working` branch
- [ ] Ensure `CHANGES.md` is up-to-date with a new version number
- [ ] `git push`
- [ ] Check Travis build status
- [ ] Update local distro fully with tlmgr
- [ ] Run `build check` locally
- [ ] Install prerelease versions of `fontspec` and `latex3` and re-check
- [ ] `texlua autorelease.lua`
- [ ] Check `latex3/contrib/testfiles/unicode-math001.lvt` and update if necessary
