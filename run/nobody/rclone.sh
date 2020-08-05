#!/bin/bash

rclone_config="/config/rclone/config/rclone.conf"
rclone_log="/config/rclone/logs/rclone.log"
sleep_period="24h"

if [[ "${ENABLE_RCLONE}" == 'no' ]]; then

	echo "[info] rclone not enabled"

else

	# create folder structure for config, temp and logs
	mkdir -p /config/rclone/config /config/rclone/logs

	if [ ! -f "${rclone_config}" ]; then

		echo "[warn] rclone config file '${rclone_config}' does not exist, exiting rclone script..."

	elif [[ -z "${RCLONE_MEDIA_SHARES}" ]]; then

		echo "[warn] No media shares defined (via -e RCLONE_MEDIA_SHARES), exiting rclone script..."

	else

		# call log rotate script (background)
		nohup /home/nobody/logrotate.sh "${rclone_log}" >> "/config/supervisord.log" &

		# split comma separated media shares
		IFS=',' read -ra rclone_media_shares_list <<< "${RCLONE_MEDIA_SHARES}"

		while true; do

			# loop over list of media share names
			for rclone_media_shares_item in "${rclone_media_shares_list[@]}"; do

				echo "[info] Running rclone for media share '${rclone_media_shares_item}', check rclone log file '${rclone_log}' for output..."
				if [[ "${DEBUG}" == 'yes' ]]; then
					echo "[debug] /usr/bin/rclone --config=${rclone_config} copy /media/${rclone_media_shares_item} encrypt:/${rclone_media_shares_item} --log-file=${rclone_log} --log-level INFO"
				fi
				/usr/bin/rclone --config="${rclone_config}" copy "/media/${rclone_media_shares_item}" "encrypt:/${rclone_media_shares_item}" --log-file="${rclone_log}" --log-level INFO
				echo "[info] rclone for media share '${rclone_media_shares_item}' finished"

			done

			echo "[info] rclone finished, sleeping ${sleep_period} before re-running..."
			sleep "${sleep_period}"

		done

	fi

fi
