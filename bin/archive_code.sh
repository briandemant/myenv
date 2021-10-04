#!/usr/bin/env bash
. ~/.brde/config/colors
set -e
MAX_DAYS=120
KEEP_DAYS=60 # folder still relevant but untouched
TRESHOLD=$(gdate -d "$MAX_DAYS days ago" +%s)
KEEP=$(gdate -d "$KEEP_DAYS days ago" +%Y-%m-%d\ %H:%M:%S)
ROOT=~/Code/
cd $ROOT
FOLDERS="devbox/spikes devbox gg/ on-hold/ projects/ spikes/"
[[ "" != "$1" ]] && FOLDERS="$1"

for x in $FOLDERS; do
	cd $ROOT$x
	echo -e "\n$BLUE$x$RESET\n"
	ask=false
	hits=()
	if [ "" == "$(ls */ 2>/dev/null)" ]; then
		echo -e $YELLOW is empty$RESET
	else
		for folder in *; do
			newestFile=$(find "$folder" -print0 | xargs -0 stat --format "%W %n" | sort -rn | head -1 | cut -f2- -d" ")
			#newestFile=$(find $folder -type f -print0 | xargs -0 stat -f "%m %N" | sort -rn | head -1 | cut -f2- -d" ")

			latestTS=$(date -r "$newestFile" +%s)
			latestChange=$(date -r "$newestFile" +%Y-%m-%d\ %H:%M:%S)

			if [ $latestTS -gt $TRESHOLD ]; then
				echo -e $GREY $latestChange $folder$RESET
			else
				ask=true
				echo -e $RED $latestChange $RESET $folder
				hits+=("$folder")
			fi
		done
		yes=n
		if [ $ask == "true" ]; then
			echo -en "do it $GREY(y/a/n/k) (yes/ask/no/keep)$RESET?"
			if read yes && [ "$yes" == "y" ]; then
				for folder in "${hits[@]}"; do
					archive_path.sh "$folder"
				done
			elif [ "$yes" == "a" ]; then
				for folder in "${hits[@]}"; do
					echo -en "archive $RED$folder$RESET (y/n/k)?"
					if read yes && [ "$yes" == "y" ]; then
						archive_path.sh "$folder"
					elif [ "$yes" == "k" ]; then
						touch -d "$KEEP" "$folder/.keep"
					fi
				done
			elif [ "$yes" == "k" ]; then
				for folder in "${hits[@]}"; do
					touch -d "$KEEP" "$folder/.keep"
				done
			fi
		fi
	fi
done
