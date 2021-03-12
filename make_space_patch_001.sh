#!/usr/bin/env bash
set -e

SUDO=''
if (( $EUID != 0 )); then
    echo "Please be ready to enter the device´s sudo password:"
    SUDO='sudo'
fi

echo "Space on device before freeing up space!"
$SUDO df -H /dev/mmcblk0p1

# Completely remove docker
$SUDO apt-get purge -y docker-ce docker-ce-cli || true
$SUDO rm -rf /var/lib/docker || true
$SUDO apt autoremove --purge -y || true
$SUDO apt clean || true

# Remove unused images from containerd
$SUDO k3s crictl rmi --prune

echo "Space on device after freeing up space!"
$SUDO df -H /dev/mmcblk0p1

echo "Install nvidia bloatware"
# Install cuda drivers & nvidia-runtime
$SUDO apt-get install -y \
  cuda-compiler-10-2 cuda-cudart-10-2 cuda-libraries-10-2 cuda-toolkit-10-2 cuda-tools-10-2 nvidia-container-csv-cuda \
  nvidia-container-runtime jq libsystemd-dev p7zip minicom Jetson.GPIO python3-serial python3-pip isc-dhcp-client \
  networkd-dispatcher

echo "Space on device after patch!"
$SUDO df -H /dev/mmcblk0p1
