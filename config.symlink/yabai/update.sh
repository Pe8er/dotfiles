#!/usr/bin/env zsh

# thanks to gldtn for this script
# https://github.com/koekeishiya/yabai/discussions/1904#discussion-5730330

function updateSudoers () {
    echo "updating sudoers.d sha256"
    sha256=$(shasum -a 256 $(which yabai) | awk "{print \$1;}")
    if [ -f "/private/etc/sudoers.d/yabai" ]; then
        sudo sed -i '' -e 's/sha256:[[:alnum:]]*/sha256:'${sha256}'/' /private/etc/sudoers.d/yabai
        echo "sudoers > yabai > sha256 hash update complete"
    else
        echo "Sudoers file does not exist yet, or could not be found."
        echo "Please create one before running this script."
    fi
}

# Function to update yabai from HEAD
function updateFromHead () {
    echo "Updating yabai from HEAD…"
    brew reinstall koekeishiya/formulae/yabai
    codesign -fs "${yabaiCert:-yabai-cert}" "$(brew --prefix yabai)/bin/yabai"
}

# Function to update yabai from main
function updateFromMain () {
    echo "Updating yabai from main…"
    brew upgrade yabai
}

# Ask user for update method if not provided
if [[ -z "$1" ]]; then
    echo "Choose update method:"
    echo "1. Update from HEAD"
    echo "2. Update from main"
    echo -n "Enter choice (1 or 2): "
    read choice
else
    choice=$1
fi

# Ensure choice is valid
if [[ "$choice" != "1" && "$choice" != "2" ]]; then
    echo "Invalid choice. Exiting."
    exit 1
fi

# Check & unpin yabai from brew
if brew list --pinned | grep -q yabai; then
    brew unpin yabai
fi

export yabaiCert=yabai-cert
echo "Stopping yabai.."
yabai --stop-service

# Perform the update based on user choice
if [[ "$choice" == "1" ]]; then
    updateFromHead
elif [[ "$choice" == "2" ]]; then
    updateFromMain
fi

updateSudoers
echo "Starting yabai..."
sleep 2
yabai --start-service

# Pin yabai back to brew
brew pin yabai
if brew list --pinned | grep -q yabai; then
    echo "Yabai pinned to brew."
fi

# Success message
sleep 1
yabaiVersion=$(yabai --version)
echo "You are running $yabaiVersion"
echo "Yabai update completed successfully."



# # scripting-addition;
# # function to update sudoers file
# function suyabai () {
#     SHA256=$(shasum -a 256 $(which yabai) | awk "{print \$1;}")
#     if [ -f "/private/etc/sudoers.d/yabai" ]; then
#         sudo sed -i '' -e 's/sha256:[[:alnum:]]*/sha256:'${SHA256}'/' /private/etc/sudoers.d/yabai
#         echo "sudoers > yabai > sha256 hash update complete"
#     else
#         echo "sudoers file does not exist yet. Please create one before running this script."
#     fi
# }

# # check & unpin yabai from brew
# if brew list --pinned | grep -q yabai; then
#     brew unpin yabai
# fi

# # set cert & stop yabai services
# export YABAI_CERT=yabai-cert
# echo "Stopping yabai.."
# yabai --stop-service

# # reinstall yabai & codesign
# echo "Updating yabai.."
# brew reinstall koekeishiya/formulae/yabai
# codesign -fs "${YABAI_CERT:-yabai-cert}" "$(brew --prefix yabai)/bin/yabai"

# # update sudoers file & start yabai
# suyabai
# echo "Starting yabai.."
# yabai --start-service

# # pin yabai back to brew
# brew pin yabai
# if brew list --pinned | grep -q yabai; then
#     echo "Yabai pinned to brew"
# fi

# # Success message
# sleep 1
# YABAI_V=$(yabai --version)
# echo "Your running $YABAI_V"
# echo "Yabai update completed successfully."