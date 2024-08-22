#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Downloading Google Chrome
curl -L -O https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# Installing Google Chrome
apt install -y ./google-chrome-stable_current_amd64.deb
