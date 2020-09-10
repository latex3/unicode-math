#!/usr/bin/env sh

# This script is used for testing using Travis
# It is intended to work on their VM set up: Ubuntu 12.04 LTS
# As such, the nature of the system is hard-coded
# A minimal current TL is installed adding only the packages that are
# required

# See if there is a cached version of TL available
export PATH=/tmp/texlive/bin/x86_64-linux:$PATH
if ! command -v texlua > /dev/null; then
  # Obtain TeX Live
  wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
  tar -xzf install-tl-unx.tar.gz
  cd install-tl-20*

  # Install a minimal system
  ./install-tl --profile=../texlive.profile

  cd ..
fi

# basics
tlmgr install tex etex luatex xetex texlive-scripts cm knuth-lib latex-bin tex-ini-files unicode-data

# l3build
tlmgr install l3build

## or bleeding edge:
#
#if [ -d "/tmp/l3build/.git" ]; then
#  cd /tmp/l3build ;
#  git pull --rebase ;
#  cd -;
#else
#  git clone https://github.com/latex3/l3build.git /tmp/l3build ;
#fi
#(cd /tmp/l3build; texlua build.lua install)

# Dependencies
tlmgr install   \
  amsmath       \
  etoolbox      \
  fontspec      \
  geometry      \
  ifluatex      \
  ifxetex       \
  graphics      \
  lualatex-math \
  luaotfload    \
  oberdiek

# Fonts
tlmgr install   \
  Asana-Math    \
  firamath      \
  lm-math       \
  tex-gyre      \
  tex-gyre-math \
  stix2-otf     \
  xits

# for documentation
tlmgr install \
  booktabs \
  caption  \
  collection-latexrecommended \
  dejavu   \
  enumitem \
  fancyvrb \
  geometry \
  graphics-def \
  hyperref \
  inconsolata \
  iwona    \
  ltxmisc  \
  metalogo \
  ms       \
  refstyle \
  subfig   \
  tabu     \
  titlesec \
  tools    \
  underscore \
  url      \
  varwidth \
  xcolor   \
  zapfding


# Keep no backups (not required, simply makes cache bigger)
tlmgr option -- autobackup 0

# Update the TL install but add nothing new
tlmgr update --self --all --no-auto-install
