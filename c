#!/bin/sh

set -e

BRANCH=$(git branch | grep \* | cut -d" "  -f 2)
CLEAN=${CLEAN-clean}

if [ $BRANCH == $CLEAN ]; then
    echo "Comparing $BRANCH to itself."
    exit 1
fi

git checkout $CLEAN
./gyp_skia >/dev/null
ninja -C out/Release $1
out/Release/$@ > $CLEAN.log

git checkout $BRANCH
./gyp_skia >/dev/null
ninja -C out/Release $1
out/Release/$@ > $BRANCH.log

compare $CLEAN.log $BRANCH.log | sort -g | column -t
