#!/bin/bash

set -e
set -x

BRANCH=$(git branch | grep \* | cut -d" "  -f 2)

git diff > local.patch

git checkout .
git checkout clean
git rebase
git apply local.patch

ninja -C out ok
out/ok $@ png:dir=before

git checkout .
git checkout $BRANCH
git rebase
git apply local.patch

ninja -C out ok
out/ok $@ png:dir=after

rm local.patch
idiff before after
open diff.html
