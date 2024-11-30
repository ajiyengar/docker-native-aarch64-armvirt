#!/usr/bin/env bash

docker build --target "dev" -t "fedora40-aarch64-edk2-dev" \
  "$@" . || exit

exit 0
