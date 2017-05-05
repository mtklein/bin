#!/bin/bash

set -e
#set -x

BRANCH=$(git branch | grep \* | cut -d" "  -f 2)

function reset {
    git checkout -q $BRANCH
}
trap reset EXIT

mkdir -p before/ after/

ninja -C out ok
for dst in $@; do
    out/ok gm $dst png:dir=after/$dst
done

git checkout -q origin/master
ninja -C out ok
for dst in $@; do
    out/ok gm $dst png:dir=before/$dst
done

idiff before after
open diff.html
