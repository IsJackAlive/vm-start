# Example answer file for setup-alpine script
# setup-interfaces -a

KEYMAPOPTS="pl pl-legacy"

# Set hostname
HOSTNAMEOPTS="-n mountblanc"

# Contents of /etc/network/interfaces
INTERFACESOPTS="auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
    hostname mountblanc
"

# Search domain of example.com, Google public nameserver
DNSOPTS="-d example.com 8.8.8.8"

# Set timezone to UTC
TIMEZONEOPTS="-z UTC"

# set http/ftp proxy
PROXYOPTS="http://webproxy:8080"

# Add a random mirror
APKREPOSOPTS="-r"

# Install Openssh
SSHDOPTS="-c openssh"

# Use openntpd
NTPOPTS="-c openntpd"

# Use /dev/sda as a data disk
DISKOPTS="-m data /dev/sda"

# Setup in /media/sdb1
LBUOPTS="/media/sdb1"
APKCACHEOPTS="/media/sdb1/cache"