# UNICODE-MATH RELEASE CHECKLIST

- [ ] Ensure `CHANGES.md` is up-to-date with a new version number
- [ ] Finish final changes on `working` branch including `build setversion`
- [ ] Update local distro fully with tlmgr
- [ ] Run `build check` locally; push and check Travis build status
- [ ] Install prerelease versions of `fontspec` and `latex3` and re-check
- [ ] Rebase `working` onto `master`
- [ ] `build ctan`
- [ ] Upload to CTAN
- [ ] `texlua tagrelease.lua` to tag release with version number, annotated with changes
- [ ] `build install`
- [ ] Check `latex3/contrib/testfiles/unicode-math001.lvt` and update if necessary
