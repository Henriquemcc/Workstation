#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Updating packages sources
apt update

# Installing requirements
apt install -y wget
apt install -y gpg
apt install -y apt-transport-https

# Adding public key
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg

# Adding repository
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | tee /etc/apt/sources.list.d/vscode.list > /dev/null

# Deleting useless file
rm -f packages.microsoft.gpg

# Updating packages sources
apt update

# Installing Visual Studio Code
apt install -y code
