#!/bin/bash

mgnatmake main.adb
target="/tmp/tftpboot/world/program"

if [[ -f "${target}" ]]; then
  yes | rm -rf $target;
fi;

cp mprogram $target
