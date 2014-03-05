#!/bin/sh

set -e

./gyp_skia >/dev/null
ninja -C out/Debug $1
if [ $1 -a $1 != "everything" ]; then
    mutrace --max=2 out/Debug/$@
fi
