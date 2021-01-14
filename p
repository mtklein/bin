#!/bin/sh

set -e

exec xcrun xctrace record -t "Time Profiler" --launch -- $@
