#!/bin/bash

set -e
#set -x

out=$1

nice ninja -C out fm
rm -rf $out
mkdir $out
cat << EOF | nice time go run tools/fm/fm_bot/fm_bot.go -quiet -script - out/fm
gms skvm=false b=cpu w=$out/vanilla
gms skvm=true  b=cpu w=$out/skvm
tests b=cpu
#gms skvm=true  b=cpu w=$out/dp3      gamut=p3      tf=srgb
#gms skvm=true  b=cpu w=$out/linear   gamut=srgb    tf=linear
#gms skvm=true  b=cpu w=$out/rec2020  gamut=rec2020 tf=rec2020
EOF
