#!/bin/sh

set -e

./gyp_skia >/dev/null
ninja -C out/Debug $1
if [ $1 -a $1 != "everything" ]; then
    /usr/bin/time out/Debug/$@
fi
