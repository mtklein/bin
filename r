#!/bin/sh

set -e

sync-and-gyp
ninja -C out/Release $1
/usr/bin/time out/Release/$@
