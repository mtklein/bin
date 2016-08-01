#!/bin/sh

set -e

bin/fetch-gn
gn gen /tmp/dbg '--args=cc="ccache clang -fcolor-diagnostics" cxx="ccache clang++ -fcolor-diagnostics"'
ninja -C /tmp/dbg $1
/tmp/dbg/$@
