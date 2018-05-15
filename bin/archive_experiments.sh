#!/usr/bin/env bash
. ~/.brde/config/colors

MAX_DAYS=30

cd ~/Dropbox/CodeBackup/
for x in learn experiments gg/* solo/*;do
	cd ~/Dropbox/CodeBackup/$x
	echo -e "\n$BLUE$x$RESET\n"
	ask=false
	for folder in *;do
		oldestFile=$(find $folder -type f -print0 | xargs -0 stat -f "%m %N" | sort -rn | head -1 | cut -f2- -d" ")
		latestChange=$(date -r "$oldestFile" +%Y-%m-%d\ %H:%M:%S)

		if [ "$(find $folder -mtime -$MAX_DAYS|head -1)" != "" ]; then
			echo -e $GREY $latestChange $folder$RESET
		else 
			ask=true
			echo -e $RED $latestChange MOVE $folder$RESET
		fi
	done
	yes=n
	[ $ask == "true" ] && echo "do it?"  && read yes && [ "$yes" == "y" ] && for folder in *;do
		if [ "$(find $folder -mtime -$MAX_DAYS|head -1)" == "" ]; then
			echo -e $YELLOW MOVING $folder$RESET
			archive_code.sh $folder
		fi
	done
done 
