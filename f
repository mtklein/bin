#!/bin/bash

set -e
#set -x

out=$1

nice ninja -C out fm
rm -rf $out
mkdir $out

cat << EOF | nice time go run infra/bots/task_drivers/fm_driver/fm_driver.go -script - out/fm
tests b=cpu
gms skvm=false b=cpu w=$out/vanilla
gms skvm=true  b=cpu w=$out/skvm
#gms skvm=true  b=cpu w=$out/dp3      gamut=p3      tf=srgb
#gms skvm=true  b=cpu w=$out/linear   gamut=srgb    tf=linear
#gms skvm=true  b=cpu w=$out/rec2020  gamut=rec2020 tf=rec2020
EOF
