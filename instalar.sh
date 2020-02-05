#!/bin/bash
#Para o Ubuntu 18

#[Inicio do Programa]

    #Instalando prérequisitos
    echo "(01/14)Instalando os softwares prerequisitos";
    sudo apt-get install curl apt-transport-https snapd apt -y;

    #Atualizando o sistema
    echo "(02/14)Atualizando o sistema";
    sudo apt update;
    sudo apt full-upgrade -y;

    #Fazendo download dos repositórios necessário
    echo "(03/14)Adicionando os repositórios";
        
        #Google Chrome
        wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -;
        echo 'deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list;
        
        #Google Earth
        echo 'deb [arch=amd64] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-earth-pro.list;
        
        #Grub Customizer
        #sudo add-apt-repository ppa:danielrichter2007/grub-customizer -y;

        #Baixando o Minecraft
        wget https://launcher.mojang.com/download/Minecraft.deb;

        #Veracrypt
        wget https://launchpad.net/veracrypt/trunk/1.24-hotfix1/+download/veracrypt-1.24-Hotfix1-Ubuntu-19.10-amd64.deb;
        
        #Signal
        curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
        echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
        
        #Kdenlive
        #sudo add-apt-repository ppa:kdenlive/kdenlive-stable -y;
        
        #.NET Core SDK
        wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb;
        sudo dpkg -i packages-microsoft-prod.deb;

    #Atualizando as listas de repositórios
    echo "(04/14)Atualizando a lista de repositorios";
    sudo apt update;

    #Obtendo automaticamente os novos drivers
    echo "(05/14)Instalando os drivers";
    sudo ubuntu-drivers autoinstall;

    #Baixando e Instalando os pacotes apt
    echo "(06/14)Instalando os pacotes pelo grenciador de pacotes APT";
    sudo apt install virtualbox virtualbox-ext-pack google-chrome-stable cinnamon-desktop-environment flatpak gnome-software-plugin-flatpak make simplescreenrecorder ubuntu-make redshift libreoffice evince alien pulseaudio* codeblocks audacity gpp gcc fp-compiler brasero soundconverter asunder blueman steam ubuntu-report exfat-utils nautilus* file-roller gnome-disk-utility usb-creator-gtk transmission-gtk samba flashplugin-installer ttf-mscorefonts-installer lib32z1 lib32stdc++6 linux-headers-$(uname -r) dkms git gradle gufw ca-certificates-java chrome-gnome-shell libc6:i386 libncurses5:i386 libstdc++6:i386 libbz2-1.0:i386 browser-plugin-freshplayer-pepperflash unrar unrar-free okular p7zip-full ffmpeg libuchardet0 mpv phantomjs python3-pyxattr rtmpdump bluetooth tlp vim* openjdk-8-jdk openjdk-8-jre libsdl-ttf2.0-0 vlc virtualbox-guest-additions-iso logisim libcanberra-gtk-module libcanberra-gtk3-module iverilog arduino bless openvpn network-manager-openvpn-gnome resolvconf gpa ./Minecraft.deb ./veracrypt-1.24-Hotfix1-Ubuntu-19.10-amd64.deb signal-desktop kdenlive obs-studio python-pip dotnet-sdk-3.1 mysql-server mysql-client google-earth-pro-stable stubby -y;

    #Instalando o flathub
    echo "(07/14)Instalando o repositorio flathub";
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo;

    #Baixando e Instalando os pacotes snap e flatpack
    echo "(08/14)Instalando pacotes snap e flatpack";
    sudo snap install spotify;
    sudo snap install slack --classic;
    sudo snap install skype --classic;
    #sudo snap install netbeans --classic;
    sudo snap install intellij-idea-community --classic;
    sudo snap install code --classic;
    sudo flatpak install https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref -y;
    sudo snap install --devmode keepassxc;
    sudo flatpak install flathub com.google.AndroidStudio

    #Instalando o Youtube-dl
    echo "(09/14)Instalando o Youtube-dl";
    sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl;
    sudo chmod a+x /usr/local/bin/youtube-dl;
    sudo youtube-dl -U;
    hash -r;

    #Instalando fontes
    echo "(10/14)Instalando as fontes";
    sudo fc-cache;
    sudo fc-match Arial;
    
    #Configurando o Java
    echo "(11/14)Configurando o Java";
    sudo update-java-alternatives --set java-1.8.0-openjdk-amd64;

    #Instalando o logisim
    echo "(12/14)Instalando o Logisim";
    sudo mv /usr/share/logisim/logisim.jar /usr/share/logisim/logisim.jar.old;
    sudo wget https://raw.githubusercontent.com/LogisimIt/Logisim/master/Compiled/Logisim-ITA.jar# -O /usr/share/logisim/logisim.jar;
    sudo chmod a+x /usr/share/logisim/logisim.jar;

    #Instalando o Stubby
    echo "(13/14)Instalando o Stubby";
    sudo netstat -lnptu | grep stubby;
    sudo netstat -lnptu | grep systemd-resolve;
    sudo cp ./stubby.yml /etc/stubby/stubby.yml;

    #Removendo programas inuteis
    echo "(14/14)Desinstalando programas inuteis";
    sudo apt autoremove aisleriot five-or-more hitori iagno gnome-klotski lightsoff gnome-mahjongg gnome-mines gnome-nibbles quadrapassel four-in-a-row gnome-robots gnome-sudoku swell-foop tali gnome-taquin gnome-tetravex gnome-chess -y; 
    sudo apt autoclean -y;

    #Saindo do terminal
    echo "Instalacao concluida!";
    exit;

#[/Fim do Programa]
