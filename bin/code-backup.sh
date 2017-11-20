#!/bin/bash
zero_pad(){
  # zero_pad <string> <length>
  [ ${#1} -lt $2 ] && printf "%0$(($2-${#1}))d" ''
  printf "%s\n" "$1"
}

source=$1
name=${2:-$(basename $source)}

if [ "" == "$source" ] ||  [ "" == "$name" ]; then
  echo "Usage $0 [folder-to-backup] [name-of-backup]"
  exit
fi

ROOT=~/code-backup/$name
hour=$(date +%H)
minute=$(zero_pad $(( (1$(date +%M)-100) / 15 * 15 )) 2)
#minute=$(zero_pad $(( (115-100) / 15 * 15 )) 2)
now=$hour$minute
mkdir -p $ROOT/current/

diff="$(rsync -avn $source $ROOT/current/|wc -l)"
if [[ "5" == "$diff" ]];then
#  echo nothing changed $diff
  echo -n " |$diff|" >> $ROOT/diff.log
  date >> $ROOT/diff.log
  exit
else
  #rsync -avn $source $ROOT/current/
  echo -n "B|$diff|" >> $ROOT/diff.log
  date >> $ROOT/diff.log
fi
#mv $ROOT/$now $ROOT/$now.bak 2>/dev/null
#cp -al ${ROOT}/current $ROOT/$now
#rm -rf $ROOT/$now.bak 2>/dev/null

keepmax=3
[[ -e $ROOT/old.$keepmax ]] && rm -rf $ROOT/old.$keepmax

for x in $(seq $keepmax -1 2);do
  from=$ROOT/old.$(( $x - 1 ))
  to=$ROOT/old.$x;
  [[ -e $from ]] && mv $from $to 2>/dev/null
done

exclude="--exclude=cache/ --exclude=*.hits --exclude=node_modules --exclude=.idea --exclude=tmp --exclude=*.log"

rsync -a --delete $exclude --link-dest=$ROOT/current/ $ROOT/current/ $ROOT/old.1/
rsync -a --delete $exclude                            $source/       ${ROOT}/current/

date > $ROOT/current/backed_up
