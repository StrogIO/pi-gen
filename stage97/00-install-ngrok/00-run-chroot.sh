#!/bin/bash -e
# https://github.com/nodesource/distributions
cd ${ROOTFS_DIR}/home/pi/systemd-ngrok
cp ngrok.service /lib/systemd/system/
mkdir -p /opt/ngrok
cp ngrok.yml /opt/ngrok
AUTH_TOKEN=6eNe3KoHjBe1CnQdhSFWi_27jL5UeeBdFLsvbgX9euc
sed -i "s/<add_your_token_here>/$AUTH_TOKEN/g" /opt/ngrok/ngrok.yml

cd /opt/ngrok
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip

chmod +x ngrok

systemctl enable ngrok.service
systemctl start ngrok.service
