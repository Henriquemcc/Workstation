#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Downloading
curl -L -O "https://cdn.akamai.steamstatic.com/client/installer/steam.deb"

# Installing
apt install -y ./steam.deb

# Deleting useless file
rm -f steam.deb
