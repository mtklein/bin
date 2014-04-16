#!/bin/sh

set -e
set -x

wget http://llvm.org/releases/3.4/llvm-3.4.src.tar.gz
wget http://llvm.org/releases/3.4/clang-3.4.src.tar.gz
wget http://llvm.org/releases/3.4/compiler-rt-3.4.src.tar.gz

tar xzf llvm-3.4.src.tar.gz

cd llvm-3.4/tools
tar xzf ../../clang-3.4.src.tar.gz
mv clang-3.4 clang

cd ../projects
tar xzf ../../compiler-rt-3.4.src.tar.gz
mv compiler-rt-3.4 compiler-rt

cd ..
./configure --enable-optimized
make -j

Release+Asserts/bin/clang -v
