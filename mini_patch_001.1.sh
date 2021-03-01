#!/usr/bin/env bash
set -xe

SUDO=''
if (( $EUID != 0 )); then
    echo "Please be ready to enter the device´s sudo password:"
    SUDO='sudo'
fi

$SUDO tee <<EOL "/etc/systemd/network/20-ethernet.network"
[Match]
Name=eth0

[Network]
Address=192.168.0.70/24
EOL
$SUDO ifconfig eth0 down
$SUDO ifconfig eth0 up
$SUDO systemctl restart systemd-networkd

# Install cuda drivers
$SUDO apt-get install -y cuda-compiler-10-2 cuda-cudart-10-2 cuda-libraries-10-2 cuda-toolkit-10-2 cuda-tools-10-2 nvidia-container-csv-cuda

# Make sure nvidia runtime is set by default
$SUDO apt-get install -y nvidia-container-runtime nvidia-docker2 jq

$SUDO tee <<EOL "/etc/docker/daemon.json"
{
  "default-runtime": "nvidia",
  "runtimes": {
    "nvidia": {
      "path": "nvidia-container-runtime",
      "runtimeArgs": []
    }
  }
}
EOL
