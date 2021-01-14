#!/bin/bash

set -e
#set -x

out=$1

nice ninja -C out fm
rm -rf $out
mkdir $out

TESTS=`out/fm --listTests | grep -v TypefaceStyle | tr '\n' ' '`

cat << EOF | nice time go run tools/fm/fm_bot/fm_bot.go -quiet -exact -script - out/fm
b=cpu $TESTS
gms skvm=false b=cpu w=$out/vanilla
gms skvm=true  b=cpu w=$out/skvm
#gms skvm=true  b=cpu w=$out/dp3      gamut=p3      tf=srgb
#gms skvm=true  b=cpu w=$out/linear   gamut=srgb    tf=linear
#gms skvm=true  b=cpu w=$out/rec2020  gamut=rec2020 tf=rec2020
EOF
