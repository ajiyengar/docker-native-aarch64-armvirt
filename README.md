# EDK2 ArmVirt AARCH64 Docker

Building EDK2 ArmVirtPkg inside native Aarch64 docker container

## Pre-Requisites

* Sync edk2 submodules after cloning

```sh
    cd edk2
    git submodule update --init
    cd ..
```

* Ensure docker desktop is running

## Build Aarch64 docker container

```sh
    cd Docker-Fedora-40-Aarch64
    ./build.sh
    cd ..
```

This creates docker image: fedora40-aarch64-edk2-dev

## Build edk2 with Aarch64 docker container

Execute `build_with_docker.sh`
