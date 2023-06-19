LABEL=$(brightness -l | awk 'NR==2 {printf("%02.0f", $4*100)}')%

sketchybar --set $NAME label=$LABEL