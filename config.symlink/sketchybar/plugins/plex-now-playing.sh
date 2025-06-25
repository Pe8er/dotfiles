#!/bin/bash

plexUrl="192.168.1.199"
plexToken="$(cat /Users/pe8er/.dotfiles/secrets/plex)"
plexUrlSession="/status/sessions"

plexUrl () {
    echo "http://$plexUrl:32400${1}?X-Plex-Token=${plexToken}"
}

# Fetch the XML response
response=$(curl -s --max-time 3 "$(plexUrl "$plexUrlSession")")
if [ $? -ne 0 ]; then
    echo "Error: Failed to fetch data from Plex server."
    exit 1
fi

# Check if any media is currently playing
if echo "$response" | grep -q 'MediaContainer size="0"'; then
    echo "Nothing is playing."
    exit 0
fi


# Parse and display Artist, Song Name, and Album Name
artist=$(echo "$response" | xmllint --xpath 'string(//Track/@grandparentTitle)' -)
song=$(echo "$response" | xmllint --xpath 'string(//Track/@title)' -)
album=$(echo "$response" | xmllint --xpath 'string(//Track/@parentTitle)' -)
artwork=$(echo "$response" | xmllint --xpath 'string(//Track/@parentThumb)' -)
state=$(echo "$response" | xmllint --xpath 'string(//Track/Player/@state)' -)


# Download the artwork image and save it in a temporary folder
temp_dir=$(mktemp -d)
artwork_path="$temp_dir/artwork.jpg"
curl -s "$(plexUrl "$artwork")" -o "$artwork_path"

# Output the information clearly
echo "$state|$artist|$song|$artwork_path"