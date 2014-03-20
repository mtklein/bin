#!/bin/sh

set -e
set -x

./gyp_skia >/dev/null
ninja -C out/Debug $1
if [ $1 -a $1 != "everything" ]; then
    lldb -- out/Debug/$@
fi
