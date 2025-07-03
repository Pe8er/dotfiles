#!/bin/bash

SOURCE=/Volumes/Extreme\ Pro/Music/
TARGET=/Volumes/Music/
LOGFILE=~/Desktop/rsync.txt

EXCLUDE=(
  'Trey Gunn'
  'Soundtracks'
  'Red Hot Chili Peppers'
  'Puscifer'
  'Klaus Schulze & Lisa Gerrard'
  'Front Line Assembly'
  'Frank Sinatra'
)

for i in "${!EXCLUDE[@]}"
do
  EXCLUDE[i]="--exclude=${EXCLUDE[i]}"
done

rsync -avhPzrn --stats --delete "${EXCLUDE[@]}" "${SOURCE}" "${TARGET}"

printf 'Proceed with sync? (y/n)'
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then 
  touch "${LOGFILE}"
  rsync -avhPzr --log-file="${LOGFILE}" --stats --delete "${EXCLUDE[@]}" "${SOURCE}" "${TARGET}" 2> ~/Desktop/rsyncErrors.txt
else
  exit
fi

# a - preserve everything
# v - verbose
# h - human readable
# P - progress/partial
# z - compress on the way
# n - dry run
