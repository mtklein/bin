#!/bin/bash

set -e
set -x

BRANCH=$(git branch | grep \* | cut -d" "  -f 2)

git diff > local.patch

function reset {
    git checkout .
    git checkout $BRANCH
    git rebase
    [ -s local.patch ] && git apply local.patch
    rm local.patch
}
trap reset EXIT

git checkout .
git checkout clean
git rebase
[ -s local.patch ] && git apply local.patch

ninja -C out ok
out/ok $@ png:dir=before

git checkout .
git checkout $BRANCH
git rebase
[ -s local.patch ] && git apply local.patch

ninja -C out ok
out/ok $@ png:dir=after

rm local.patch
idiff before after
open diff.html
