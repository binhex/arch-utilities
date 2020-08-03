#!/bin/bash

youtubedl_log="/config/youtube-dl/logs/youtube-dl.log"
readonly ourScriptName=$(basename -- "$0")
readonly youtubedl_url="${1}"
readonly youtubedl_format="${2}"

function show_help() {

	echo "[info] ${ourScriptName} '<youtube video/playlist url>' '<audio|video>', e.g:-"
	echo "[info] ${ourScriptName} 'https://www.youtube.com/playlist?list=PLx0sYbCqOb8Q_CLZC2BdBSKEEB59BOPUM' 'audio'"
	echo "[info] exiting ${ourScriptName} script..."
	exit 1

}

function run() {

	echo "[info] youtube-dl url(s) are defined as '${youtubedl_url}'"

	# split comma separated media shares
	IFS=',' read -ra youtubedl_url_list <<< "${youtubedl_url}"

	# loop over list of media share names
	for youtubedl_url_item in "${youtubedl_url_list[@]}"; do

		# if url is not a playlist then pass parameter to youtube-dl
		if [[ "${youtubedl_url_item}" == *"playlist"* ]]; then

			youtubedl_flags=""

		else

			youtubedl_flags="--no-playlist"

		fi

		if [[ "${youtubedl_format}" == "audio" ]];then

			echo "[info] Running youtube-dl for url(s) '${youtubedl_url_item}', check youtube-dl log file '${youtubedl_log}' for output..."
			echo "[debug] youtube-dl --extract-audio --audio-format mp3 -i --geo-bypass -f bestaudio --no-overwrites --default-search 'ytsearch' ${youtubedl_flags} --output '/config/youtube-dl/output/%(playlist_index)s-%(title)s.%(ext)s' '${youtubedl_url_item}' >> '${youtubedl_log}' 2>&1"

			/usr/bin/youtube-dl --extract-audio --audio-format mp3 -i --geo-bypass -f bestaudio --no-overwrites --default-search 'ytsearch' ${youtubedl_flags} --output "/config/youtube-dl/output/%(playlist_index)s-%(title)s.%(ext)s" "${youtubedl_url_item}" >> "${youtubedl_log}" 2>&1

		else

			echo "[info] Running youtube-dl for url(s) '${youtubedl_url_item}', check youtube-dl log file '${youtubedl_log}' for output..."
			echo "[debug] youtube-dl -i --geo-bypass -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' --merge-output-format mp4 --no-overwrites --default-search 'ytsearch' ${youtubedl_flags} --output '/config/youtube-dl/output/%(playlist_index)s-%(title)s.%(ext)s' '${youtubedl_url_item}' >> '${youtubedl_log}' 2>&1"

			/usr/bin/youtube-dl -i --geo-bypass -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' --merge-output-format mp4 --no-overwrites --default-search 'ytsearch' ${youtubedl_flags} --output "/config/youtube-dl/output/%(playlist_index)s-%(title)s.%(ext)s" "${youtubedl_url_item}" >> "${youtubedl_log}" 2>&1
		fi

		echo "[info] youtube-dl for playlist url '${youtubedl_url_item}' finished"

	done

	echo "[info] youtube-dl finished for all playlists/videos"

}

# ensure we have required parameters
if [[ -z "${youtubedl_url}" ]]; then

	echo "[warn] No playlist/video URL's defined via first parameter (comma separated list), displaying help:-"
	show_help

elif [[ -z "${youtubedl_format}" ]]; then

	echo "[warn] No YouTube format defined (audio|video), displaying help:-"
	show_help

fi

# create folder structure for output and logs
mkdir -p /config/youtube-dl/logs /config/youtube-dl/output

# run youtube-dl function
run
