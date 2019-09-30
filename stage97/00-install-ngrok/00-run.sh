if [ -d ${ROOTFS_DIR}/home/pi/systemd-ngrok ]; then
  cd ${ROOTFS_DIR}/home/pi/systemd-ngrok;
  git pull --rebase origin master
else
  git clone git@github.com:vincenthsu/systemd-ngrok.git ${ROOTFS_DIR}/home/pi/systemd-ngrok
fi