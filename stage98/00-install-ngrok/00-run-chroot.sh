#!/bin/bash -e

cat <<EOF >/opt/ngrok/ngrok.yml
authtoken: 6eNe3KoHjBe1CnQdhSFWi_27jL5UeeBdFLsvbgX9euc
json_resolver_url: ""
dns_resolver_ips: []
console_ui: false
log_format: logfmt
log: /opt/ngrok/ngrok.log
region: eu
web_addr: false
tunnels:
  ssh:
    proto: tcp
    addr: 22
    inspect: false
EOF

cat <<EOF >/etc/systemd/system/ngrok.service
[Unit]
Description=Share local port(s) with ngrok
After=syslog.target network.target

[Service]
PrivateTmp=true
Type=simple
Restart=always
RestartSec=1min
StandardOutput=null
StandardError=null
ExecStart=/opt/ngrok/ngrok start -config /opt/ngrok/ngrok.yml --all
ExecStop=/usr/bin/killall ngrok

[Install]
WantedBy=multi-user.target
EOF
