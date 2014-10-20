#!/bin/bash

set -e
set -x

CLONE="git clone --depth 1"

$CLONE http://llvm.org/git/llvm.git
cd llvm

pushd tools
$CLONE http://llvm.org/git/clang.git
popd

pushd projects
$CLONE http://llvm.org/git/compiler-rt.git
popd

./configure --enable-optimized
make -j 4

Release+Asserts/bin/clang -v

