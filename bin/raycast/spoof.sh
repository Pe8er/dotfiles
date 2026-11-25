MAC = $(openssl rand -hex 6 | sed "s/\(..\)/\1:/g; s/.\$//" | sed "s/./2/2")

sudo ifconfig en0 ether $MAC | ifconfig en0 | grep ether