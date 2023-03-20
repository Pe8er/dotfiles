#!/bin/bash
# Command-line world clock

HOME=$(dirname "$0")
: ${WORLDCLOCK_ZONES:=$HOME/time.zones}
: ${WORLDCLOCK_FORMAT:='+%Z %l:%M%p'}

while read zone
do echo $(TZ=$zone date "$WORLDCLOCK_FORMAT")
done < $WORLDCLOCK_ZONES |
awk -F '!' '{printf "%s • ", $1, $2;}' |
sort -b -r -k2,2 -k3,3 |
sed 's/.....$//'