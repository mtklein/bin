#!/bin/bash

set -e
#set -x

BRANCH=$(git branch | grep \* | cut -d" "  -f 2)

git diff > local.patch

function reset {
    git checkout -q .
    git checkout -q $BRANCH
    git rebase -q
    [ -s local.patch ] && git apply local.patch
    rm local.patch
}
trap reset EXIT

ninja -C out ok | grep -v Entering
out/ok $@ png:dir=after

git checkout -q .
git checkout -q clean
git rebase -q
[ -s local.patch ] && git apply local.patch

ninja -C out ok | grep -v Entering
out/ok $@ png:dir=before

idiff before after
open diff.html
