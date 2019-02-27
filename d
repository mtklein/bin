#!/bin/bash

set -e
#set -x

BRANCH=$(git rev-parse --abbrev-ref HEAD)
PARENT=$(git show-branch | grep '*' | grep -v "$BRANCH" | head -n1 | sed 's/.*\[\(.*\)\].*/\1/' | sed 's/[\^~].*//')

function reset {
    git checkout -q $BRANCH
}
trap reset EXIT

git checkout -q $PARENT
ninja -C out dm
out/dm $@ -w $PARENT

git checkout -q $BRANCH
ninja -C out dm
out/dm $@ -w $BRANCH

idiff $PARENT $BRANCH
open diff.html
