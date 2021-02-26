#!/usr/bin/env bash
set -e
sudo tee <<EOL "/etc/systemd/network/20-ethernet.network"
[Match]
Name=eth0

[Network]
Address=192.168.0.70/24
EOL
sudo ifconfig eth0 down
sudo ifconfig eth0 up
sudo systemctl restart systemd-networkd
