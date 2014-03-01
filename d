#!/bin/sh

set -e

./gyp_skia >/dev/null
ninja -C out/Release $1
if [ $1 -a $1 != "everything" ]; then
    /usr/bin/time out/Release/$@
fi
