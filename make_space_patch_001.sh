#!/usr/bin/env bash
set -e

SUDO=''
if (( $EUID != 0 )); then
    echo "Please be ready to enter the device´s sudo password:"
    SUDO='sudo'
fi


echo "Space on device before patch!"
$SUDO df -H /dev/mmcblk0p1

# Completely remove docker
$SUDO apt-get purge -y docker-ce docker-ce-cli || true
$SUDO rm -rf /var/lib/docker || true
$SUDO apt autoremove --purge -y || true
$SUDO apt clean || true

echo "Space on device after patch!"
$SUDO df -H /dev/mmcblk0p1
