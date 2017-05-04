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

mkdir -p before/ after/

ninja -C out ok
for dst in $@; do
    out/ok gm $dst -w after/$dst
done

git checkout -q .
git checkout -q clean
git rebase -q
[ -s local.patch ] && git apply local.patch

ninja -C out ok
for dst in $@; do
    out/ok gm $dst -w before/$dst
done

idiff before after
open diff.html
