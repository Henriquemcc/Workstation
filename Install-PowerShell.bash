#!/bin/bash

# Importing function run_as_root, get_os_type and get_os_version
source RunAsRoot.bash
source OsInfo.bash

# Running as root
run_as_root

# Update the list of packages
apt update

# Install pre-requisite packages.
apt install -y wget

# Get the version of Debian
source /etc/os-release

# Installation variables
os_type="$(get_os_type)"

# Download the Microsoft repository GPG keys
wget -q https://packages.microsoft.com/config/$os_type/$VERSION_ID/packages-microsoft-prod.deb

# Register the Microsoft repository GPG keys
dpkg -i packages-microsoft-prod.deb

# Delete the Microsoft repository GPG keys file
rm packages-microsoft-prod.deb

# Update the list of packages after we added packages.microsoft.com
apt update

# Install PowerShell
apt install -y powershell | {
    curl -L -o powershell.deb https://github.com/PowerShell/PowerShell/releases/download/v7.4.4/powershell_7.4.4-1.deb_amd64.deb
    apt install -y ./powershell.deb
    rm powershell.deb
}