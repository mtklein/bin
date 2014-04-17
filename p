#!/bin/sh

set -e

GYP_DEFINES=skia_keep_frame_pointer=1 ./gyp_skia >/dev/null
ninja -C out/Release $1
perf record -g out/Release/$@
perf report -g
