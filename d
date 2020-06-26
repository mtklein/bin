#!/bin/bash

set -e

BRANCH=$(git rev-parse --abbrev-ref HEAD)

function reset {
    git checkout -q $BRANCH
}
trap reset EXIT

git checkout -q origin/master
f before

git checkout -q $BRANCH
a
