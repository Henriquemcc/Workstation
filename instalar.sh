#!/bin/bash
#Para o Ubuntu 20

#[Inicio do Programa]
    #Verificando se eh root
    usuario=$(whoami);
    if [ "$usuario" != "root" ]
    then
        echo "Erro: Este shell script nao esta sendo executado como root";
        exit 1;
    fi;

    #Alterando o mirror do ubuntu
    echo "(01/16)Alterando o mirror do Ubuntu";
    sudo mv /etc/apt/sources.list /etc/apt/sources.list.old;
    sudo cp ./sources.list /etc/apt/sources.list;

    #Instalando prérequisitos
    echo "(02/16)Instalando os softwares prerequisitos";
    sudo apt-get update;
    sudo apt-get install curl apt-transport-https snapd apt -y;

    #Atualizando o sistema
    echo "(03/16)Atualizando o sistema";
    sudo apt update;
    sudo apt full-upgrade -y;

    #Fazendo download dos repositórios necessário
    echo "(04/16)Adicionando os repositórios";
        
        #Google Chrome
        wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -;
        echo 'deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list;
        
        #Google Earth
        echo 'deb [arch=amd64] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list;

        #Baixando o Minecraft
        wget https://launcher.mojang.com/download/Minecraft.deb;

        #Veracrypt
        wget https://launchpad.net/veracrypt/trunk/1.24-update4/+download/veracrypt-1.24-Update4-Ubuntu-20.04-amd64.deb;
        
        #Signal
        curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
        echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
        
        #.NET Core SDK
        wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb;
        sudo dpkg -i packages-microsoft-prod.deb;

    #Atualizando as listas de repositórios
    echo "(05/16)Atualizando a lista de repositorios";
    sudo apt update;

    #Obtendo automaticamente os novos drivers
    echo "(06/16)Instalando os drivers";
    sudo ubuntu-drivers autoinstall;

    #Baixando e Instalando os pacotes apt
    echo "(07/16)Instalando os pacotes pelo grenciador de pacotes APT";
    sudo apt install virtualbox virtualbox-ext-pack google-chrome-stable cinnamon-desktop-environment flatpak gnome-software-plugin-flatpak make ubuntu-make libreoffice evince alien codeblocks audacity gpp gcc g++ fp-compiler brasero soundconverter asunder blueman steam ubuntu-report exfat-utils file-roller gnome-disk-utility usb-creator-gtk transmission-gtk samba flashplugin-installer ttf-mscorefonts-installer lib32z1 lib32stdc++6 linux-headers-$(uname -r) dkms git gradle gufw ca-certificates-java chrome-gnome-shell libc6:i386 libncurses5:i386 libstdc++6:i386 libbz2-1.0:i386 browser-plugin-freshplayer-pepperflash unrar unrar-free p7zip-full ffmpeg libuchardet0 mpv phantomjs python3-pyxattr rtmpdump bluetooth tlp openjdk-8-jdk openjdk-8-jre libsdl-ttf2.0-0 vlc virtualbox-guest-additions-iso logisim libcanberra-gtk-module libcanberra-gtk3-module iverilog arduino bless openvpn network-manager-openvpn-gnome resolvconf gpa ./Minecraft.deb ./veracrypt-1.24-Update4-Ubuntu-20.04-amd64.deb signal-desktop kdenlive obs-studio mysql-server mysql-client google-earth-pro-stable git-gui -y;

    #Instalando o flathub
    echo "(08/16)Instalando o repositorio flathub";
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo;

    #Baixando e Instalando os pacotes snap
    echo "(09/16)Instalando pacotes snap";
    sudo snap install spotify;
    sudo snap install slack --classic;
    sudo snap install skype --classic;
    sudo snap install intellij-idea-community --classic;
    sudo snap install code --classic;
    sudo snap install --devmode keepassxc;
    
    #Baixando e Instalando os pacotes flatpak
    echo "(10/16)Instalando pacotes flatpak"
    sudo flatpak install flathub com.google.AndroidStudio -y;

    #Instalando fontes
    echo "(11/16)Instalando as fontes";
    sudo fc-cache;
    sudo fc-match Arial;

    #Instalando o logisim
    echo "(12/16)Instalando o Logisim";
    sudo mv /usr/share/logisim/logisim.jar /usr/share/logisim/logisim.jar.old;
    sudo wget https://raw.githubusercontent.com/LogisimIt/Logisim/master/Compiled/Logisim-ITA.jar# -O /usr/share/logisim/logisim.jar;
    sudo chmod a+x /usr/share/logisim/logisim.jar;

    #Removendo programas inuteis
    echo "(13/16)Desinstalando programas inuteis";
    sudo apt autoremove aisleriot five-or-more hitori iagno gnome-klotski lightsoff gnome-mahjongg gnome-mines gnome-nibbles quadrapassel four-in-a-row gnome-robots gnome-sudoku swell-foop tali gnome-taquin gnome-tetravex gnome-chess -y; 
    sudo apt autoclean -y;

    #Configurando atualizacoes automaticas
    echo "(14/16)Configurando atualizacoes automaticas";
    sudo mv /etc/apt/apt.conf.d/50unattended-upgrades /etc/apt/apt.conf.d/50unattended-upgrades.old;
    sudo cp ./50unattended-upgrades /etc/apt/apt.conf.d/50unattended-upgrades;

    #Configurando o Visual Studio Code
    echo "(15/16)Configurando o Visual Studio Code";
    echo 'fs.inotify.max_user_watches=524288' | sudo tee /etc/sysctl.conf;
    sudo sysctl -p;
    sudo -u "$SUDO_USER" code --install-extension NathanRidley.autotrim;
    sudo -u "$SUDO_USER" code --install-extension ms-vscode.cpptools;
    sudo -u "$SUDO_USER" code --install-extension ms-dotnettools.csharp;
    sudo -u "$SUDO_USER" code --install-extension austin.code-gnu-global;
    sudo -u "$SUDO_USER" code --install-extension ms-vscode.cmake-tools;
    sudo -u "$SUDO_USER" code --install-extension firefox-devtools.vscode-firefox-debug;
    sudo -u "$SUDO_USER" code --install-extension vscjava.vscode-java-debug;
    sudo -u "$SUDO_USER" code --install-extension dbaeumer.vscode-eslint;
    sudo -u "$SUDO_USER" code --install-extension GitHub.github-vscode-theme;
    sudo -u "$SUDO_USER" code --install-extension ecmel.vscode-html-css;
    sudo -u "$SUDO_USER" code --install-extension mythmon.idl;
    sudo -u "$SUDO_USER" code --install-extension vscjava.vscode-java-dependency;
    sudo -u "$SUDO_USER" code --install-extension vscjava.vscode-java-pack;
    sudo -u "$SUDO_USER" code --install-extension vscjava.vscode-java-test;
    sudo -u "$SUDO_USER" code --install-extension redhat.java;
    sudo -u "$SUDO_USER" code --install-extension DavidAnson.vscode-markdownlint;
    sudo -u "$SUDO_USER" code --install-extension vscjava.vscode-maven;
    sudo -u "$SUDO_USER" code --install-extension esbenp.prettier-vscode;
    sudo -u "$SUDO_USER" code --install-extension rust-lang.rust;
    sudo -u "$SUDO_USER" code --install-extension VisualStudioExptTeam.vscodeintellicode;
    sudo -u "$SUDO_USER" code --install-extension ms-ceintl.vscode-language-pack-pt-br;

    #Criando alias
    echo "(16/16)Criando alias";
    echo "alias update='sudo apt update && sudo apt full-upgrade -y && sudo snap refresh && flatpak update -y && sudo ubuntu-drivers autoinstall'" | tee -a ~/.bashrc;
    echo "alias reload-sound='sudo apt update;sudo apt full-upgrade -y;sudo apt install --reinstall alsa-base alsa-utils alsa-tools-gui alsa-topology-conf alsa-ucm-conf bluedevil gir1.2-cvc-1.0 gir1.2-rb-3.0 gstreamer1.0-libav gstreamer1.0-nice gstreamer1.0-packagekit gstreamer1.0-pulseaudio indicator-sound libao-common libao4 libasound2-plugins libbasicusageenvironment1 libcanberra-pulse libkf5pulseaudioqt2 libpulse-mainloop-glib0 libpulse0 libpulsedsp lightdm linux-image-`uname -r` linux-sound-base pavucontrol pulseaudio pulseaudio-equalizer pulseaudio-module-bluetooth pulseaudio-module-jack pulseaudio-module-lirc pulseaudio-module-raop pulseaudio-module-zeroconf pulseaudio-utils python3-libdiscid speech-dispatcher-audio-plugins ubuntu-desktop ubuntu-sounds -y;sudo bash ./Fix_Bluetooth.sh;killall pulseaudio;rm -r ~/.pulse*;ubuntu-support-status;sudo usermod -aG `cat /etc/group | grep -e '^pulse:' -e '^audio:' -e '^pulse-access:' -e '^pulse-rt:' -e '^video:' | awk -F: '{print $1}' | tr '\n' ',' | sed 's:,$::g'` `whoami`;sudo pulseaudio -k;sudo alsa force-reload;'" | tee -a ~/.bashrc;

    #Saindo do terminal
    echo "Instalacao concluida!";
    exit;

#[/Fim do Programa]
