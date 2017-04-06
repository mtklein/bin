#!/bin/bash

set -e
set -x

BRANCH=$(git branch | grep \* | cut -d" "  -f 2)

git stash
git checkout clean
git rebase
git stash apply

ninja -C out ok
out/ok $@ png:dir=before

git stash
git checkout $BRANCH
git rebase
git stash apply

ninja -C out ok
out/ok $@ png:dir=after

idiff before after
open diff.html
