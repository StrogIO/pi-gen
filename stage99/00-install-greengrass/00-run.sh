#!/bin/bash

install -m 644 files/sources.list "${ROOTFS_DIR}/etc/apt/"
sudo apt install -t jessie-backports openjdk-8-jdk ca-certificates-java

cat <<EOF >>${ROOTFS_DIR}/etc/sysctl.d/98-rpi.conf
fs.protected_hardlinks = 1
fs.protected_symlinks = 1
EOF

tar Czxf ${ROOTFS_DIR} files/greengrass*.tar.gz

# Users should place the extracted keys/config into the fat32 partition.
rm -rf ${ROOTFS_DIR}/greengrass/certs \
       ${ROOTFS_DIR}/greengrass/config
mkdir -p ${ROOTFS_DIR}/greengrass/certs
mkdir -p ${ROOTFS_DIR}/boot/greengrass/certs
mkdir -p ${ROOTFS_DIR}/boot/greengrass/config

# copy root cert into /greengrass/certs
cp files/root.ca.pem ${ROOTFS_DIR}/greengrass/certs/root.ca.pem

# For twitch stream we want viewers to see our text BIG!
# We also don't need to waste memory on GPU by default!
cat <<EOF >>${ROOTFS_DIR}/boot/config.txt
framebuffer_width=800
framebuffer_height=400
gpu_mem=16
EOF
