#!/bin/sh

set -e

./gyp_skia >/dev/null
ninja -C out/Debug $1
if [ $1 != "everything" ]; then
    /usr/bin/time catchsegv out/Debug/$@
fi
