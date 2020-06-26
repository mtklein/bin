#!/bin/bash

set -e
#set -x

nice ninja -C out dm
out/dm $@

