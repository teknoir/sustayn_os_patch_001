#!/usr/bin/env bash
set -x

SUDO=''
if (( $EUID != 0 )); then
    echo "Please be ready to enter the device´s sudo password:"
    SUDO='sudo'
fi

# Write APN with AT-command (Twice)
$SUDO echo 'AT+CGDCONT=1,"IP","iot.kore.com"\r' > /dev/ttyTHS1
$SUDO echo 'AT+CGDCONT=1,"IP","iot.kore.com"\r' > /dev/ttyUSB2

# Update WPA
$SUDO install -m 644 files/wpa_supplicant-wlan0.conf /etc/wpa_supplicant/wpa_supplicant-wlan0.conf

# Change Wifi systemd-networkd settings
$SUDO install -m 644 files/30-wifi.network /etc/systemd/network/30-wifi.network

# Add files that start LTE connection at boot
$SUDO mkdir -p /etc/simcom_wwan
$SUDO install -m 644 files/wwan_preup.sh /etc/simcom_wwan/wwan_preup.sh
$SUDO install -m 644 files/wwan_postdown.sh /etc/simcom_wwan/wwan_postdown.sh
$SUDO install -m 644 files/simcom_wwan@.service /lib/systemd/system/simcom_wwan@.service
$SUDO chmod +x /etc/simcom_wwan/wwan_preup.sh
$SUDO chmod +x /etc/simcom_wwan/wwan_postdown.sh

# Add file that start service that monitor that the LTE connection is up and aggressively tries to keep it up
$SUDO mkdir -p /usr/local/lib/keepup_wwan
$SUDO install -m 644 files/keepup_wwan.py /usr/local/lib/keepup_wwan/keepup_wwan.py
$SUDO install -m 644 files/keepup_wwan@.service /lib/systemd/system/keepup_wwan@.service

# Add scrips that monitor wlan0 status and makes wlan0 an active-backup for wwan0 without using bonding
$SUDO install -m 644 files/no-carrier.d/wlan0.sh /usr/lib/networkd-dispatcher/no-carrier.d/wlan0.sh
$SUDO install -m 644 files/routable.d/wlan0.sh /usr/lib/networkd-dispatcher/routable.d/wlan0.sh
$SUDO install -m 644 files/routable.d/wwan0.sh /usr/lib/networkd-dispatcher/routable.d/wwan0.sh
$SUDO chmod +x /usr/lib/networkd-dispatcher/no-carrier.d/wlan0.sh
$SUDO chmod +x /usr/lib/networkd-dispatcher/routable.d/wlan0.sh
$SUDO chmod +x /usr/lib/networkd-dispatcher/routable.d/wwan0.sh