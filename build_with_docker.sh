#!/usr/bin/env bash


docker run -it -v "$HOME/dockerhome":/home -v .:/work \
  -e EDK2_DOCKER_USER_HOME=/home -w /work \
  fedora40-aarch64-edk2-dev:latest \
  /bin/bash edk2_build.sh
