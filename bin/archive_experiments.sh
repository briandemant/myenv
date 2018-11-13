#!/usr/bin/env bash
. ~/.brde/config/colors

MAX_DAYS=60
KEEP_DAYS=30 # folder still relevant but untouched
TRESHOLD=$(date -d "$MAX_DAYS days ago" +%s)
KEEP=$(date -d "$KEEP_DAYS days ago" +%Y-%m-%d\ %H:%M:%S)
cd ~/Dropbox/CodeBackup/
for x in learn experiments gg/* solo/*;do
	cd ~/Dropbox/CodeBackup/$x
	echo -e "\n$BLUE$x$RESET\n"
	ask=false
	hits=()
	if [ "" == "$(ls */ 2>/dev/null)" ]; then
		echo -e $YELLOW is empty$RESET
	else
		for folder in *;do 
			newestFile=$(find "$folder"  -print0 | xargs -0 stat --format "%W %n" | sort -rn | head -1 | cut -f2- -d" ")
			latestTS=$(date -r "$newestFile" +%s)
			latestChange=$(date -r "$newestFile" +%Y-%m-%d\ %H:%M:%S)
	
			if [ $latestTS -gt $TRESHOLD ]; then
				echo -e $GREY $latestChange $folder$RESET
			else 
				ask=true
				echo -e $RED $latestChange MOVE $folder$RESET
				hits+=($folder)
			fi
		done 
		yes=n
		if [ $ask == "true" ] ; then
			 echo "do it?"  
			 if read yes && [ "$yes" == "y" ] ; then
				for folder in "${hits[@]}" ; do 
					archive_code.sh $folder
				done
			else 
				for folder in "${hits[@]}" ; do 
					touch -d "$KEEP" $folder/.keep
				done 
			fi
		fi
	fi
done 
