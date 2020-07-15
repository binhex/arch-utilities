#!/bin/bash

rclone_config="/config/rclone/config/rclone.conf"
rclone_log="/config/rclone/logs/rclone.log"

# create folder structure for config, temp and logs
mkdir -p /config/rclone/config /config/rclone/logs

if [ ! -f "${rclone_config}" ]; then

	echo "[warn] rclone config file does not exist"

else

	# run rclone
	/usr/bin/rclone --config="${rclone_config}" copy /media/Pictures encrypt:/Pictures --log-file="${rclone_log}" --log-level INFO

fi
