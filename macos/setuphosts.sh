echo "Downloading new hosts file…"
curl https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts > ~/.dotfiles/macos/hosts
echo "OK!"
echo ""
echo ""
echo "Replacing system hosts file. You will need to enter administrator password."
sudo rm /etc/hosts
sudo ln -s ~/.dotfiles/macos/hosts /etc/hosts
echo "OK!"
echo ""
echo ""
echo "Flushing DNS cache…"
sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder
echo "OK!"