#!/usr/bin/env bash
. ~/.brde/config/colors
folder=$1
root=~/Dropbox/CodeArchive/
echo -en "${RED}archiving $folder$RESET > "

if [ -e $folder ]; then
	newestFile=$(find "$folder"  -print0 | xargs -0 stat --format "%W %n" | sort -rn | head -1 | cut -f2- -d" ")			
	#newestFile=$(find $folder -type f -print0 | xargs -0 stat -f "%m %N" | sort -rn | head -1 | cut -f2- -d" ")
	latestChange=$(date -r "$newestFile" +%Y-%m-%d\ %H:%M:%S)
	targetfolder="$(date -r "$newestFile" +%Y-%m)"
	echo " ~/Dropbox/CodeArchive/$targetfolder"
	echo " .. latest change was $latestChange ($newestFile)"
	[ -e $root$targetfolder ] || mkdirls $root$targetfolder
	find $folder -name 'node_modules' -exec rm -rf {} \;
    mv "$folder" "$root$targetfolder"
else
	echo " ERROR!!"
fi
