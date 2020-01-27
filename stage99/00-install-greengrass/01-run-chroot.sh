#!/bin/sh

adduser --disabled-password -q --gecos "" ggc_user
addgroup ggc_group
adduser ggc_user ggc_group

cat <<EOF >/etc/init.d/S02greengrass
#!/bin/sh
mkdir -p /greengrass/certs
mkdir -p /greengrass/config
cp -a /boot/greengrass/certs/ /greengrass
cp -a /boot/greengrass/config/ /greengrass
cd /greengrass/ggc/core
./greengrassd \$@
EOF

cat <<EOF >/etc/systemd/system/greengrass.service
[Unit]
Description=AWS Greengrass Service

[Service]
Type=forking
PIDFile=/var/run/greengrass.pid
ExecStart=/etc/init.d/S02greengrass start
ExecReload=/etc/init.d/S02greengrass restart
ExecStop=/etc/init.d/S02greengrass stop
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

chmod 777 /etc/systemd/system/greengrass.service
systemctl enable greengrass.service
systemctl start greengrass.service
