#!/bin/sh

set -e

sync-and-gyp
ninja -C out/Debug $1
/usr/bin/time out/Debug/$@
