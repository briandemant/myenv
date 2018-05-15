#!/usr/bin/env bash
dir=$1
root=~/Dropbox/CodeArchive/
echo -n "archiving $dir > "

if [ -e $dir ]; then
	oldestFile=$(find $dir -type f -print0 | xargs -0 stat -f "%m %N" | sort -rn | head -1 | cut -f2- -d" ")
	latestChange=$(date -r "$oldestFile" +%Y-%m-%d\ %H:%M:%S)
	targetDir="$(date -r "$oldestFile" +%Y-%m)"
	echo " ~/Dropbox/CodeArchive/$targetDir"
	echo " .. latest change was $latestChange ($oldestFile)"
	[ -e $root$targetDir ] || mkdir $root$targetDir
	find $dir -name 'node_modules' -exec rm -rf {} \;
    mv "$dir" "$root$targetDir"
else
	echo " ERROR!!"
fi
