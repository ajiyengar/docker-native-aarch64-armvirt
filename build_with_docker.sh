#!/usr/bin/env bash

# $HOME/dockerhome on host machine contains the docker specific config files

docker run -it \
  -v "$HOME/dockerhome":/home \
  -v "$(realpath $PWD)":"$PWD" \
  -e EDK2_DOCKER_USER_HOME=/home -w "$PWD" \
  fedora40-aarch64-edk2-dev:latest \
  /bin/bash edk2_build.sh
