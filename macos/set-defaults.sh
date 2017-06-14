#!/usr/bin/env bash

# Sets reasonable macOS defaults.
#
# Or, in other words, set shit how I like in macos.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.osx
#
# Run ./set-defaults.sh and you'll be good to go.

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "###################################"
echo "SSD-specific tweaks"
echo "###################################"

# Disable hibernation (speeds up entering sleep mode)
sudo pmset -a hibernatemode 0

# Disable the sudden motion sensor as it’s not useful for SSDs
sudo pmset -a sms 0


echo "###################################"
echo "Appearance"
echo "###################################"

# Use a dark menu bar / dock
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Turn off text smoothing for font sizes
defaults write NSGlobalDomain AppleAntiAliasingThreshold -int 4

# Enable smooth scrolling
defaults write -g NSScrollAnimationEnabled -bool true

# Don't show Siri in the menu bar
defaults write com.apple.Siri StatusMenuVisible -bool false

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "icnv"

# Set icon view settings on desktop and in icon views
# for view in 'Desktop' 'FK_Standard' 'Standard'; do

#     # Item info near icons
#     /usr/libexec/PlistBuddy -c "Set :${view}ViewSettings:IconViewSettings:showItemInfo bool false" ~/Library/Preferences/com.apple.finder.plist

#     # Item info to right of icons
#     /usr/libexec/PlistBuddy -c "Set :${view}ViewSettings:IconViewSettings:labelOnBottom bool false" ~/Library/Preferences/com.apple.finder.plist

#     # Arrange by name
#     /usr/libexec/PlistBuddy -c "Set :${view}ViewSettings:IconViewSettings:arrangeBy string name" ~/Library/Preferences/com.apple.finder.plist

#     # Grid spacing for icons
#     /usr/libexec/PlistBuddy -c "Set :${view}ViewSettings:IconViewSettings:gridSpacing integer 100" ~/Library/Preferences/com.apple.finder.plist

#     # Icon size
#     /usr/libexec/PlistBuddy -c "Set :${view}ViewSettings:IconViewSettings:iconSize integer 32" ~/Library/Preferences/com.apple.finder.plist

#     # Text size
#     /usr/libexec/PlistBuddy -c "Set :${view}ViewSettings:IconViewSettings:textSize integer 10" ~/Library/Preferences/com.apple.finder.plist
# done

# View Options
# ColumnShowIcons    : Show preview column
# ShowPreview        : Show icons
# ShowIconThumbnails : Show icon preview
# ArrangeBy          : Sort by
#   dnam : Name
#   kipl : Kind
#   ludt : Date Last Opened
#   pAdd : Date Added
#   modd : Date Modified
#   ascd : Date Created
#   logs : Size
#   labl : Tags
/usr/libexec/PlistBuddy \
    -c "Set :StandardViewSettings:ListViewSettings:iconSize           integer 32"    \
    -c "Set :StandardViewSettings:ListViewSettings:textSize           integer 12"    \
    -c "Set :StandardViewSettings:ListViewSettings:ShowIconPreview    bool    true"  \
    -c "Set :StandardViewSettings:ListViewSettings:sortColumn         string  name"  \
    ~/Library/Preferences/com.apple.finder.plist

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.2


echo "###################################"
echo "System Stuff"
echo "###################################"

# Enable screensharing
sudo defaults write /var/db/launchd.db/com.apple.launchd/overrides.plist com.apple.screensharing -dict Disabled -bool false
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.screensharing.plist

# Enable file sharing
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.smbd.plist
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server.plist EnabledServices -array disk

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Link Quicklook Plugins folder
ln -s $HOME/Dropbox/Library/QuickLook $HOME/Library/QuickLook
qlmanage -r

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "$HOME/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable auto-termination of idle applications
defaults write -g NSDisableAutomaticTermination -bool true

# Open a Finder window after extracting an archive
defaults write com.apple.archiveutility dearchive-reveal-after -bool true

# Enable access for assistive desktopservices
echo -n 'a' | sudo tee /private/var/db/.AccessibilityAPIEnabled > /dev/null 2>&1
sudo chmod 444 /private/var/db/.AccessibilityAPIEnabled

# Disable Resume system-wide
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# Don't save Preview windows on quit
defaults write com.apple.Preview NSQuitAlwaysKeepsWindows -boolean false

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

defaults write com.apple.finder QLEnableXRayFolders -boolean yes

# Allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

# Set keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# New window points to home
defaults write com.apple.finder NewWindowTarget -string "PfHm"

# Expand the "Open with" and "Sharing & Permissions" panes
defaults write com.apple.finder FXInfoPanesExpanded -dict OpenWith -bool true Privileges -bool true

# Use AirDrop over every interface. Srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Show the ~/Library folder.
chflags nohidden ~/Library

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Show unsupported Time Machine volumes.
defaults write com.apple.systempreferences TMShowUnsupportedNetworkVolumes 1

# Menu bar: hide the Time Machine, Volume, and User icons
for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
  defaults write "${domain}" dontAutoLoad -array \
    "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
    "/System/Library/CoreServices/Menu Extras/Volume.menu" \
    "/System/Library/CoreServices/Menu Extras/User.menu"
done
defaults write com.apple.systemuiserver menuExtras -array \
  "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
  "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
  "/System/Library/CoreServices/Menu Extras/Battery.menu"

  # "/System/Library/CoreServices/Menu Extras/Clock.menu" \

# Show date in menu bar.
# defaults write com.apple.menuextra.clock "DateFormat" "EEE MMM d  H.mm"

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

# Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

# Hot corners

# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center

# Top left screen corner → put display to sleep
defaults write com.apple.dock wvous-tl-corner -int 10
defaults write com.apple.dock wvous-tl-modifier -int 0

# Top right screen corner → Desktop
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom left screen corner → Mission Control
defaults write com.apple.dock wvous-bl-corner -int 2
defaults write com.apple.dock wvous-bl-modifier -int 0

# Bottom right screen corner → Notification Center
defaults write com.apple.dock wvous-br-corner -int 12
defaults write com.apple.dock wvous-br-modifier -int 0

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain -int 3

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Set language and text formats
# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
# `Inches`, `en_GB` with `en_US`, and `true` with `false`.
defaults write NSGlobalDomain AppleLanguages -array "en" "pl"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Set first day of week to Monday
defaults write NSGlobalDomain AppleFirstWeekday -dict gregorian 2

# Set temperature units to Celsius
defaults write NSGlobalDomain AppleTemperatureUnit -string "Celsius"

# Speed up mouse scrolling
defaults write -g com.apple.scrollwheel.scaling 300

echo "###################################"
echo "Dock"
echo "###################################"

# Set up the Dock
defaults delete com.apple.dock persistent-apps
for app in "Google Chrome" "Mail" "Messages" "Slack" "Fantastical 2" "Things3" "iTunes" "Reeder" "Photos" "Notes" ; do
  defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/'"${app}"'.app</string><key>_CFURLStringType</key>
<integer>0</integer></dict></dict></dict>' &> /dev/null
done

# Double-click a window's title bar to:
# None
# Minimize
# Maximize (zoom)
defaults write NSGlobalDomain AppleActionOnDoubleClick -string "Minimize"

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Double-click a window's title bar to minimize
defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool true

# Make Dock icons of hidden applications translucent
# defaults write com.apple.Dock showhidden -bool YES

# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Set the icon size of Dock items to 32 pixels
defaults write com.apple.dock tilesize -int 32

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.3

# Don’t show Dashboard as a Space
# defaults write com.apple.dock dashboard-in-overlay -bool true

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -boolean YES

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false


echo "###################################"
echo "Google Chrome"
echo "###################################"


# Allow installing user scripts via GitHub Gist or Userscripts.org
defaults write com.google.Chrome ExtensionInstallSources -array "https://gist.githubusercontent.com/" "http://userscripts.org/*"
defaults write com.google.Chrome.canary ExtensionInstallSources -array "https://gist.githubusercontent.com/" "http://userscripts.org/*"

# Use the system-native print preview dialog
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome.canary DisablePrintPreview -bool true

# Expand the print dialog by default
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true

echo "###################################"
echo "Safari"
echo "###################################"

# Set Safari’s home page to empty.
defaults write com.apple.Safari HomePage -string "about:blank"

# Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Show tab bar
defaults write com.apple.Safari AlwaysShowTabBar -bool true

# Do not track
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

# Set up Safari for development.
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Allow hitting the Backspace key to go to the previous page in history
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true


echo "###################################"
echo "iTunes"
echo "###################################"

# Enable cool iTunes dock notifications
defaults write com.apple.Dock itunes-notifications -bool true

# Point Store links to the library
defaults write com.apple.iTunes invertStoreLinks -bool YES


echo "###################################"
echo "Mail"
echo "###################################"

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# In threads, show most recent message at the top.
defaults write com.apple.mail ConversationViewSortDescending -bool true

# Enable plugins (https://github.com/nompute/GMailinator)
defaults write com.apple.mail EnableBundles -bool true
mkdir ~/Library/Mail/Bundles


echo "###################################"
echo "Messages"
echo "###################################"

# Test size
# 1: Small
# 7: Large
defaults write com.apple.iChat TextSize -int 5

# Enable automatic emoji substitution (i.e. use plain text smileys)
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool true

# Enable continuous spell checking
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool true

# Save history when conversations are closed
defaults write com.apple.iChat SaveConversationsOnClose -bool true

echo "###################################"
echo "Contacts"
echo "###################################"

# Address format
# defaults write com.apple.AddressBook ABDefaultAddressCountryCode -string "fi"

# Display format "Last, First"
# defaults write com.apple.AddressBook ABNameDisplay -int 1

# Sort by last name
defaults write com.apple.AddressBook ABNameSortingFormat -string "sortingLastName sortingFirstName"

LOCAL_PATH='apps/sublime'


echo "###################################"
echo "Sublime Text 3"
echo "###################################"

# Install Package Control
mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages
cd ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages && { curl -sLO https://packagecontrol.io/Package\ Control.sublime-package ; cd -; }
sudo chown -R ~/Library/Application\ Support/Sublime\ Text\ 3
sudo chmod -R 755 ~/Library/Application\ Support/Sublime\ Text\ 3

echo "###################################"
echo "Terminal"
echo "###################################"

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Use a modified version of the Pro theme by default in Terminal.app
open "$HOME/.dotfiles/system/Piotr.terminal"
sleep 2 # Wait a bit to make sure the theme is loaded
defaults write com.apple.terminal "Default Window Settings" -string "Piotr"
sleep 1 # Wait a bit to make sure the theme is loaded
defaults write com.apple.terminal "Startup Window Settings" -string "Piotr"

# Shell opens with: /bin/zsh
defaults write com.apple.Terminal Shell -string "/bin/zsh"



echo "###################################"
echo "Calendar"
echo "###################################"

# timezone support active by default
defaults write com.apple.iCal "TimeZone support enabled" -bool true

# show event times
defaults write com.apple.iCal "Show time in Month View" -bool true

echo "###################################"
echo "Disk Utility"
echo "###################################"

# Enable additional formats
defaults write com.apple.DiskUtility advanced-image-options -bool true

# Enable debug menu
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

echo "###################################"
echo "Photos"
echo "###################################"

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

echo "###################################"
echo "Transmission.app"
echo "###################################"

# Don’t prompt for confirmation before downloading
defaults write org.m0k.transmission DownloadAsk -bool false
defaults write org.m0k.transmission MagnetOpenAsk -bool false

# Trash original torrent files
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

# Hide the donate message
defaults write org.m0k.transmission WarningDonate -bool false
# Hide the legal disclaimer
defaults write org.m0k.transmission WarningLegal -bool false

# IP block list.
# Source: https://giuliomac.wordpress.com/2014/02/19/best-blocklist-for-transmission/
defaults write org.m0k.transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"
defaults write org.m0k.transmission BlocklistAutoUpdate -bool true

echo "###################################"
echo "Mac App Store"
echo "###################################"

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Automatically download apps purchased on other Macs
defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

echo "###################################"
echo "Things"
echo "###################################"

# Quick entry shortcuts - empty panel
defaults write com.culturedcode.thingsmac QuickEntryHotkeyEmpty -dict-add "characters" -string "⌃\`"
defaults write com.culturedcode.thingsmac QuickEntryHotkeyEmpty -dict-add "keyCode" -int 50
defaults write com.culturedcode.thingsmac QuickEntryHotkeyEmpty -dict-add "keyModifiers" -int 4096

# Quick entry shortcuts - filled panel
defaults write com.culturedcode.thingsmac QuickEntryHotkeyAutofill -dict-add "characters" -string "⌃⎋"
defaults write com.culturedcode.thingsmac QuickEntryHotkeyAutofill -dict-add "keyCode" -int 53
defaults write com.culturedcode.thingsmac QuickEntryHotkeyAutofill -dict-add "keyModifiers" -int 4096

# No need for the tutorial
defaults write com.culturedcode.ThingsMac OnboardingDidComplete -bool true

# The widget can launch the app
defaults write com.culturedcode.ThingsMac TodayWidgetCanLaunchThings -bool true

# Dismiss T&C dialog
defaults write com.culturedcode.ThingsMac UserDidAcceptTermsAndConditions -bool true

# Enable calendar events
defaults write com.culturedcode.ThingsMac AppleEventsEnabled -bool true

# Enable reminders import
defaults write com.culturedcode.ThingsMac AppleRemindersImportEnabled -bool true

echo "###################################"
echo "Misc"
echo "###################################"

# Set Alfred sync folder
defaults write com.runningwithcrayons.Alfred-Preferences-3 syncfolder -string "~/Dropbox/Library/Alfred"

# Set Candybar Library folder
defaults write com.panic.CandyBar3 LibraryFolder -string "~/Dropbox/Library/Candybar"

# Screen Saver: Flurry
defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName -string "Flurry" path -string "/System/Library/Screen Savers/Flurry.saver" type -int 0

# Setup keyboard shortcuts
~/.dotfiles/macos/shortcuts.sh

# Setup hosts file
~/.dotfiles/macos/setuphosts.sh

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0

# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen 1
defaults write com.apple.ical CalUIUseSystemHighlightColorForToday -bool TRUE
sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'

# Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Automatically illuminate built-in MacBook keyboard in low light
defaults write com.apple.BezelServices kDim -bool true

# Turn off keyboard illumination when computer is not used for 5 minutes
defaults write com.apple.BezelServices kDimTime -int 300

# Enable the MacBook Air SuperDrive on any Mac
sudo nvram boot-args="mbasd=1"

echo "###################################"
echo "Kill affected applications"
echo "###################################"

for app in "Alfred" "Candybar" "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
  "Dock" "Finder" "Google Chrome" "Google Chrome Canary" "Mail" "Messages" \
  "Opera" "Photos" "Safari" "SizeUp" "Spectacle" "SystemUIServer" \
  "Transmission" "Tweetbot" "Twitter" "iCal"; do
  killall "${app}" &> /dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
