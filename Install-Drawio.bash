#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Baixando
curl -L https://github.com/jgraph/drawio-desktop/releases/download/v24.7.5/drawio-amd64-24.7.5.deb -o drawio.deb

# Instalando
apt install -y ./drawio.deb 