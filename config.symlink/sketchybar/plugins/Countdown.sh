end=$(date -j -f "%b %d %Y %H:%M:%S" "Jun 24 2023 23:00:00" +%s)
start=$(date +%s)

time=$(awk 'BEGIN {p = ('"$start"'-'"$end"')/2628002.88; printf "%.1f\n", p}')" months"

# countdown=$(printf '%d:%d:%d\n' $(($time/60/60/24%365)) $(($time/3600%24)) $(($time%3600/60)))

sketchybar --set $NAME label="$time"