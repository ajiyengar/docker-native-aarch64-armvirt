#!/usr/bin/env bash

set -e

###############
# Build UEFI
###############
export ARCH=AARCH64
ARCH=${ARCH} make -C edk2/BaseTools

export COMPILER=CLANGDWARF
export WORKSPACE="$PWD/edk2"
export PACKAGES_PATH="$WORKSPACE"
export BUILD_FLAGS="-D NETWORK_TLS_ENABLE=1 -D NETWORK_IP6_ENABLE=1 -D NETWORK_HTTP_BOOT_ENABLE=1 -D INCLUDE_TFTP_COMMAND=1 -D SECURE_BOOT_ENABLE=1 -D TPM2_ENABLE=1 -DFD_SIZE_4MB=1"
export DEBUG=NOOPT

source edk2/edksetup.sh
build -a ${ARCH} -t ${COMPILER} -b ${DEBUG} -p ArmVirtPkg/ArmVirtQemu.dsc -Y COMPILE_INFO -y ../BuildReport.log --pcd gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVendor=L"Ajay Aarch64 Qemu" --pcd gEfiMdeModulePkgTokenSpaceGuid.PcdFirmwareVersionString=L"Ajay Aarch64 Qemu v1" ${BUILD_FLAGS}

dd of="/tmp/QEMU_EFI.raw" if="/dev/zero" bs=1M count=64
dd of="/tmp/QEMU_EFI.raw" if="edk2/Build/ArmVirtQemu-AARCH64/${DEBUG}_${COMPILER}/FV/QEMU_EFI.fd" conv=notrunc
dd of="/tmp/QEMU_VARS.raw" if="/dev/zero" bs=1M count=64
dd of="/tmp/QEMU_VARS.raw" if="edk2/Build/ArmVirtQemu-AARCH64/${DEBUG}_${COMPILER}/FV/QEMU_VARS.fd" conv=notrunc
cp -t . /tmp/QEMU_{EFI,VARS}.raw
