#!/bin/sh

set -e

bin/fetch-gn
gn gen /tmp/rel '--args=is_debug=false cc="ccache clang -fcolor-diagnostics" cxx="ccache clang++ -fcolor-diagnostics"'
ninja -C /tmp/rel $1
/tmp/rel/$@
