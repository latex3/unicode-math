# UNICODE-MATH RELEASE CHECKLIST

- [ ] Finish final changes on `working` branch
- [ ] Ensure `CHANGES.md` is up-to-date with a new version number
- [ ] `build setversion`
- [ ] Update local distro fully with tlmgr
- [ ] Run `build check` locally; push and check Travis build status
- [ ] Install prerelease versions of `fontspec` and `latex3` and re-check
- [ ] `git checkout master; git rebase working`
- [ ] `build ctan`
- [ ] Upload to CTAN
- [ ] `texlua tagrelease.lua` to tag release with version number, annotated with changes
- [ ] `build install`
- [ ] Check `latex3/contrib/testfiles/unicode-math001.lvt` and update if necessary
