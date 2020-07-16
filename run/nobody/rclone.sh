#!/bin/bash

rclone_config="/config/rclone/config/rclone.conf"
rclone_log="/config/rclone/logs/rclone.log"
sleep_period="24h"

# create folder structure for config, temp and logs
mkdir -p /config/rclone/config /config/rclone/logs

if [ ! -f "${rclone_config}" ]; then

	echo "[warn] rclone config file does not exist"

else

	while true; do

		echo "[info] Running rclone..."
		/usr/bin/rclone --config="${rclone_config}" copy /media/Pictures encrypt:/Pictures --log-file="${rclone_log}" --log-level INFO

		echo "[info] rclone finished, sleeping ${sleep_period} before re-running..."
		sleep "${sleep_period}"

	done

fi
