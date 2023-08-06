end=$(date -j -f "%b %d %Y %H:%M:%S" "Jun 24 2023 22:00:00" +%s)
now=$(date +%s)
time=$(( (now-end) ))

countdown=$(printf '%d Days, %d Hours, %d Minutes\n' $(($time/60/60/24%365)) $(($time/3600%24)) $(($time%3600/60)))

sketchybar --set $NAME label="$countdown"