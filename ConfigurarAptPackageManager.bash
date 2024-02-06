#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing required package
apt-get update
apt-get install -y apt-transport-mirrors
apt-get install -y apt-transport-https
apt-get install -y apt-utils
apt-get install -y apt-mirror

# Backing up configuration file
cp "/etc/apt/sources.list" "/etc/apt/sources.list.backup.$(date "+%d-%m-%Y_%H:%M:%S")"

# Replacing all ocurrences of "http://archive.ubuntu.com/ubuntu/" with "mirror://mirrors.ubuntu.com/mirrors.txt"
sed -i 's/http:\/\/archive.ubuntu.com\/ubuntu\//mirror:\/\/mirrors.ubuntu.com\/mirrors.txt/g' "/etc/apt/sources.list"