#!/bin/bash

rclone_config="/config/rclone/config/rclone.conf"
rclone_log="/config/rclone/logs/rclone.log"
sleep_period="24h"

# create folder structure for config, temp and logs
mkdir -p /config/rclone/config /config/rclone/logs

if [ ! -f "${rclone_config}" ]; then

	echo "[warn] rclone config file does not exist"

else

	# split comma separated media shares
	IFS=',' read -ra rclone_media_shares_list <<< "${RCLONE_MEDIA_SHARES}"

	while true; do

		# loop over list of ports and define as v1 template format
		for rclone_media_shares_item in "${rclone_media_shares_list[@]}"; do

			echo "[info] Running rclone for media share '${rclone_media_shares_item}'..."
			echo "/usr/bin/rclone --config=${rclone_config} copy /media/${rclone_media_shares_item} encrypt:/${rclone_media_shares_item} --log-file=${rclone_log} --log-level INFO"
			/usr/bin/rclone --config="${rclone_config}" copy "/media/${rclone_media_shares_item}" "encrypt:/${rclone_media_shares_item}" --log-file="${rclone_log}" --log-level INFO

		done

		echo "[info] rclone finished, sleeping ${sleep_period} before re-running..."
		sleep "${sleep_period}"

	done

fi
