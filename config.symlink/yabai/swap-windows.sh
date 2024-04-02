win=$(yabai -m query --windows id --window last | jq '.id')

while : ; do
    yabai -m window $win --swap $1 &> /dev/null
    if [[ $? -eq 1 ]]; then
        break
    fi
done