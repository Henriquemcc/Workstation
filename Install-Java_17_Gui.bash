#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing Java
bash ./Install-Java_17_Headless.bash

# Installing Java 17 JRE and JDK
apt install -y openjdk-17-jre

# Creating shortcuts
{
  echo "[Desktop Entry]"
  echo "Type=Application"
  echo "Name=Java Runtime Environment 17"
  echo "GenericName=Java 17"
  echo "Icon=openjdk-17"
  echo "Exec=java17 -jar %f"
  echo "Terminal=false"
  echo "MimeType=application/x-java-archive"
  echo "Keywords=java; runtime; environment; 17; jre"
  echo "StartupNotify=true"
} | tee "/usr/share/applications/java17.desktop"
