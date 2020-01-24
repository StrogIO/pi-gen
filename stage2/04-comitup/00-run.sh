#!/bin/bash -e

touch ${ROOTFS_DIR}/boot/ssh

rm -f ${ROOTFS_DIR}/etc/network/interfaces
install -m 644 files/interfaces ${ROOTFS_DIR}/etc/network/

install -m 644 files/comitup.list ${ROOTFS_DIR}/etc/apt/sources.list.d/

cp files/comitup.conf ${ROOTFS_DIR}/etc/

on_chroot apt-key add - < files/key-366150CE.pub.txt
on_chroot << EOF
apt-get update
EOF

