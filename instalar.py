import subprocess
import sys
import os
from os.path import expanduser
import re

def executar_comandos_shell(comandos_shell: []):
    """
    Esta funcao serve para executar uma sequencia de comandos shell.
    :param comandos_shell: Lista de comandos shell a serem executados.
    """
    for comando_shell in comandos_shell:
        executar_comando_shell_sem_erro(comando_shell)


def executar_comando_shell_sem_erro(comando: str, numero_maximo_de_repeticoes: int = 5):
    """
    Este metodo serve para executar um comando shell repetindo, caso ocorra algum erro.
    :param comando: Comando shell que sera executado.
    :param numero_maximo_de_repeticoes: Numero maximo de repeticoes do comando antes que o programa aborte.
    """
    print(comando)
    repetir = True
    while repetir and numero_maximo_de_repeticoes >= 0:
        try:
            subprocess.run(comando, shell=True, check=True)
            repetir = False
        except subprocess.CalledProcessError as erro:
            print(erro)
            repetir = True
            numero_maximo_de_repeticoes -= 1

    if numero_maximo_de_repeticoes < 0:
        sys.exit(-1)


def alterar_mirror():
    """
    Esta funcao serve para alterar o servidor mirror do Ubuntu.
    """
    comandos = \
        [
            "sudo mv /etc/apt/sources.list ~/sources.list.old;",
            "sudo chmod 666 ~/sources.list.old;",
            "sudo cp ./sources.list /etc/apt/sources.list;"
        ]
    executar_comandos_shell(comandos)


def instalar_prerequisitos():
    """
    Esta funcao serve para instalar os programas pre-requisitos necessarios para instalar os outros programas.
    """
    comandos = \
        [
            "sudo apt-get update;",
            "sudo apt-get install curl apt-transport-https snapd apt -y;"
        ]
    executar_comandos_shell(comandos)


def atualizar():
    """
    Esta funcao serve para atualizar todos os programas do sistema.
    """
    comandos = \
        [
            "sudo apt update;",
            "sudo apt full-upgrade -y;"
        ]
    executar_comandos_shell(comandos)


def adicionar_repositorios():
    """
    Esta funcao serve para adicionar os repositorios do apt.
    """
    comandos = \
        [
            # Google Chrome
            "wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -;",
            "echo 'deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee --append /etc/apt/sources.list.d/google-chrome.list;",

            # Google Earth
            "echo 'deb [arch=amd64] https://dl.google.com/linux/earth/deb/ stable main' | sudo tee --append /etc/apt/sources.list.d/google-earth-pro.list;",

            # Signal
            "curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -",
            "echo \"deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main\" | sudo tee --append /etc/apt/sources.list.d/signal-xenial.list"
        ]
    executar_comandos_shell(comandos)


def instalar_programas_deb():
    """
    Esta funcao serve para baixar e instalar os arquivos .deb.
    """

    comandos = \
        [
            # Baixando

            # Minecraft: Não será baixado e nem instalado
            #"wget https://launcher.mojang.com/download/Minecraft.deb;",

            # Veracrypt
            "wget https://launchpad.net/veracrypt/trunk/1.24-update7/+download/veracrypt-1.24-Update7-Ubuntu-20.04-amd64.deb;",

            # .NET Core SDK
            "wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb;",

            "sudo apt install ./packages-microsoft-prod.deb ./veracrypt-1.24-Update7-Ubuntu-20.04-amd64.deb -y;"
        ]
    executar_comandos_shell(comandos)




def instalar_drivers():
    """
    Esta funcao serve para instalar os drivers do Ubuntu.
    """
    comandos = \
        [
            "sudo ubuntu-drivers autoinstall;"
        ]
    executar_comandos_shell(comandos)


def instalar_programas_apt():
    """
    Esta funcao serve para instalar os programas por meio do apt.s
    """

    programas_apt = [

        # Ferramentas do sistema
        "gufw",  # Firewall

        # Ferramentas de desenvolvimento
        "python3",
        "python3-pip",
        "python3-setuptools",
        "make",
        "gcc",
        "g++",
        "git",
        "gcc-multilib",
        "manpages-dev",
        "autoconf",
        "automake",
        "libtool",
        "flex",
        "bison",
        "gdb",
        "gcc-doc",
        "gradle",
        "git-gui",
        "openjdk-11-jdk",
        "ca-certificates-java",

        # VirtualBox
        "virtualbox",
        #"virtualbox-ext-pack",
        "virtualbox-guest-additions-iso",

        # Google Chrome
        "google-chrome-stable",
        "chrome-gnome-shell",

        # LibreOffice
        "libreoffice",
        "libreoffice-lightproof-pt-br",
        "libreoffice-lightproof-en",
        "libreoffice-l10n-pt-br",
        "libreoffice-l10n-en-gb",

        # Flatpak
        "flatpak",
        "gnome-software-plugin-flatpak",

        # Outros programas
        "evince",
        "alien",
        "audacity",
        "brasero",
        "asunder",
        "file-roller",
        "gnome-disk-utility",
        "usb-creator-gtk",
        "transmission-gtk",
        "steam",
        "signal-desktop",
        "kdenlive",
        "obs-studio",
        "gpa",
        "logisim",

        # VPN
        "openvpn",
        "network-manager-openvpn-gnome",
        "resolvconf",

        # Utilitários do sistema
        "blueman",
        "ubuntu-report",
        "exfat-utils",
        "samba",
        "linux-headers-$(uname -r)",
        "dkms",
        "unrar",
        "unrar-free",
        "p7zip-full",
        "ffmpeg",
        "unattended-upgrades"
        # Não serão instalados: bless, dialog, libcanberra-gtk-module ,libcanberra-gtk3-module
    ]

    comando = "sudo apt install "

    for i in programas_apt:
        comando += i
        comando += " "

    comando += "-y;"

    executar_comando_shell_sem_erro(comando)


def instalar_flathub():
    """
    Esta funcao serve para instalar o flathub.
    """
    comandos = \
        [
            "sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo;"
        ]
    executar_comandos_shell(comandos)


def instalar_programas_snap():
    """
    Esta funcao serve para instalar os programas por meio do snap.
    """
    comandos = \
        [
            "sudo snap install spotify;",
            "sudo snap install slack --classic;",
            "sudo snap install skype --classic;",
            "sudo snap install intellij-idea-community --classic;",
            "sudo snap install code --classic;",
            "sudo snap install --devmode keepassxc;",
            "sudo snap install --classic android-studio;",
            "sudo snap install pycharm-community --classic;"
        ]
    executar_comandos_shell(comandos)


def instalar_programas_pip():
    """
    Esta funcao serve para instalar os programas por meio do pip.
    """
    comandos = \
        [
            "sudo pip3 install protonvpn-cli;"
        ]
    executar_comandos_shell(comandos)


def instalar_go_lang():
    """
    Esta funcao serve para instalar o compilador da linguagem Go.
    """

    # Verificando se o diretorio go existe na pasta /usr/local
    if os.path.isdir("/usr/local/go"):
        executar_comando_shell_sem_erro("sudo rm -rf /usr/local/go")

    # Verificando se a pasta go existe no diretorio atual
    if os.path.isdir("./go"):
        executar_comando_shell_sem_erro("sudo rm -rf ./go")

    # Instalando o Go
    comandos = \
        [
            "curl -L -O https://dl.google.com/go/go1.15.3.linux-amd64.tar.gz;",
            "tar -xvzf go1.15.3.linux-amd64.tar.gz;",
            "sudo chown -R root:root ./go;",
            "sudo mv go /usr/local;"
        ]
    executar_comandos_shell(comandos)

    # Adicionando o Go ao arquivo profile
    home = expanduser("~")
    with open(home + "/.profile") as profile:
        if not "GOPATH" in profile:
            executar_comando_shell_sem_erro("echo \"export GOPATH=$HOME/go\" |tee --append ~/.profile;")

        for linha in profile:
            if re.search("export PATH=|(?=:/usr/local/go/bin:)|(?=:/go/bin).*?", linha) is None:
                executar_comando_shell_sem_erro(
                    "echo \"export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin\" |tee --append ~/.profile;")
                break


def instalar_rust_lang():
    """
    Esta funcao serve para instalar o compilador da linguagem Rust.
    """
    comandos = \
        [
            "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh;"
        ]
    executar_comandos_shell(comandos)


def instalar_logisim():
    """
    Esta funcao serve para instalar o Logisim.
    """
    comandos = \
        [
            "sudo mv /usr/share/logisim/logisim.jar /usr/share/logisim/logisim.jar.old;",
            "sudo wget https://raw.githubusercontent.com/LogisimIt/Logisim/master/Compiled/Logisim-ITA.jar# -O /usr/share/logisim/logisim.jar;",
            "sudo chmod a+x /usr/share/logisim/logisim.jar;"
        ]
    executar_comandos_shell(comandos)


def instalar_youtube_dl():
    """
    Esta funcao serve para instalar o Youtube-dl.
    """
    comandos = \
        [
            "sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl;",
            "sudo chmod a+rx /usr/local/bin/youtube-dl;",
            "sudo youtube-dl -U;"
        ]
    executar_comandos_shell(comandos)


def desinstalar_programas_inuteis():
    """
    Esta funcao serve para desinstalar programas inuteis.
    """

    programas_inuteis = [

        "aisleriot",
        "five-or-more",
        "hitori",
        "iagno",
        "gnome-klotski",
        "lightsoff",
        "gnome-mahjongg",
        "gnome-mines",
        "gnome-nibbles",
        "quadrapassel",
        "four-in-a-row",
        "gnome-robots",
        "gnome-sudoku",
        "swell-foop",
        "tali",
        "gnome-taquin",
        "gnome-tetravex",
        "gnome-chess",
        "browser-plugin-freshplayer-pepperflash",
        "flashplugin-installer"
    ]

    comando_remover_programas_inuteis = "sudo apt autoremove "
    for i in programas_inuteis:
        comando_remover_programas_inuteis += i + " "
    comando_remover_programas_inuteis += "-y;"

    comandos = \
        [
            comando_remover_programas_inuteis,
            "sudo apt autoclean -y;"
        ]
    executar_comandos_shell(comandos)


def configurar_atualizacoes_automaticas():
    """
    Esta funcao serve para configurar atualizacoes automaticas no sistema.
    """
    comandos = \
        [
            "sudo mv /etc/apt/apt.conf.d/50unattended-upgrades ~/50unattended-upgrades.old;",
            "sudo chmod 666 ~/50unattended-upgrades.old;",
            "sudo cp ./50unattended-upgrades /etc/apt/apt.conf.d/50unattended-upgrades;"
        ]
    executar_comandos_shell(comandos)


def configurar_visual_studio_code():
    """
    Esta funcao serve para configurar o Visual Studio Code.
    """
    comandos = \
        [
            "echo 'fs.inotify.max_user_watches=524288' | sudo tee --append /etc/sysctl.conf;",
            "sudo sysctl -p;",
            "git config --global core.editor \"code --wait\";"
        ]
    executar_comandos_shell(comandos)


def instalar_extensoes_visual_studio_code():
    """
    Esta funcao serve para instalar as extensoes do Visual Studio Code.
    """
    comandos = \
        [
            # Traducao do VS Code em Portugues
            "code --install-extension ms-ceintl.vscode-language-pack-pt-br;",

            # Linguagem C/C++
            "code --install-extension ms-vscode.cpptools;",
            "code --install-extension ms-vscode.cmake-tools;",
            "code --install-extension austin.code-gnu-global;",

            # Lingugagem C#
            "code --install-extension ms-dotnettools.csharp;",

            # Linguagem Java
            "code --install-extension vscjava.vscode-java-debug;",
            "code --install-extension vscjava.vscode-maven;",
            "code --install-extension vscjava.vscode-java-dependency;",
            "code --install-extension vscjava.vscode-java-pack;",
            "code --install-extension vscjava.vscode-java-test;",
            "code --install-extension redhat.java;",

            # Linguagem Rust
            "code --install-extension matklad.rust-analyzer;",
            "code --install-extension vadimcn.vscode-lldb;",
            "code --install-extension rust-lang.rust;",

            # Linguagem Go
            "code --install-extension golang.Go;",

            # HTML, CSS e Javascript
            "code --install-extension ecmel.vscode-html-css;",
            "code --install-extension firefox-devtools.vscode-firefox-debug;",
            "code --install-extension msjsdiag.debugger-for-chrome;",
            "code --install-extension dbaeumer.vscode-eslint;",

            # Tema do VS Code
            "code --install-extension GitHub.github-vscode-theme;",

            # Markdown
            "code --install-extension DavidAnson.vscode-markdownlint;",

            # Powershell
            "code --install-extension ms-vscode.PowerShell;",

            # Indentacao de codigo
            "code --install-extension NathanRidley.autotrim;",
            "code --install-extension esbenp.prettier-vscode;",

            # AI-assisted IntelliSense
            "code --install-extension VisualStudioExptTeam.vscodeintellicode;"
        ]
    executar_comandos_shell(comandos)


def configurar_alias():
    """
    Esta funcao serve para configurar os alias.
    """
    comandos = \
        [
            "echo \"alias update='sudo apt update && sudo apt full-upgrade -y && sudo snap refresh && flatpak update -y &&  sudo ubuntu-drivers autoinstall && sudo do-release-upgrade'\" | tee --append ~/.bashrc;",
            "echo \"alias reload-sound='sudo apt update;sudo apt full-upgrade -y;sudo apt install --reinstall alsa-base alsa-utils alsa-tools-gui alsa-topology-conf alsa-ucm-conf bluedevil gir1.2-cvc-1.0 gir1.2-rb-3.0 gstreamer1.0-libav gstreamer1.0-nice gstreamer1.0-packagekit gstreamer1.0-pulseaudio indicator-sound libao-common libao4 libasound2-plugins libbasicusageenvironment1 libcanberra-pulse libkf5pulseaudioqt2 libpulse-mainloop-glib0 libpulse0 libpulsedsp lightdm linux-image-`uname -r` linux-sound-base pavucontrol pulseaudio pulseaudio-equalizer pulseaudio-module-bluetooth pulseaudio-module-jack pulseaudio-module-lirc pulseaudio-module-raop pulseaudio-module-zeroconf pulseaudio-utils python3-libdiscid speech-dispatcher-audio-plugins ubuntu-desktop ubuntu-sounds -y;sudo bash ./Fix_Bluetooth.sh;killall pulseaudio;rm -r ~/.pulse*;ubuntu-support-status;sudo usermod -aG `cat /etc/group | grep -e '^pulse:' -e '^audio:' -e '^pulse-access:' -e '^pulse-rt:' -e '^video:' | awk -F: '{print $1}' | tr '\n' ',' | sed 's:,$::g'` `whoami`;sudo pulseaudio -k;sudo alsa force-reload;'\" | tee --append ~/.bashrc;"
        ]
    executar_comandos_shell(comandos)


def main():

    parte = 0
    total = 17

    # Alterando o mirror do ubuntu
    parte += 1
    print("(", parte, "/", total, ")", "Alterando o mirror do Ubuntu")
    alterar_mirror()

    # Instalando prérequisitos
    parte += 1
    print("(", parte, "/", total, ")", "Instalando os softwares prerequisitos")
    instalar_prerequisitos()

    # Atualizando o sistema
    parte += 1
    print("(", parte, "/", total, ")", "Atualizando o sistema")
    atualizar()

    # Fazendo download dos repositórios necessário
    parte += 1
    print("(", parte, "/", total, ")", "Adicionando os repositórios")
    adicionar_repositorios()
    instalar_programas_deb()

    # Atualizando as listas de repositórios
    parte += 1
    print("(", parte, "/", total, ")", "Atualizando a lista de repositorios")
    atualizar()

    # Obtendo automaticamente os novos drivers
    parte += 1
    print("(", parte, "/", total, ")", "Instalando os drivers")
    instalar_drivers()

    # Baixando e Instalando os pacotes apt
    parte += 1
    print("(", parte, "/", total, ")", "Instalando os pacotes pelo grenciador de pacotes APT")
    instalar_programas_apt()

    # Instalando o flathub
    parte += 1
    print("(", parte, "/", total, ")", "Instalando o repositorio flathub")
    instalar_flathub()

    # Baixando e Instalando os pacotes snap
    parte += 1
    print("(", parte, "/", total, ")", "Instalando pacotes snap")
    instalar_programas_snap()

    # Baixando e Instalando os pacotes pip
    parte += 1
    print("(", parte, "/", total, ")", "Instalando pacotes pip")
    instalar_programas_pip()

    # Instalando o compilador de Rust Lang e Go Lang
    parte += 1
    print("(", parte, "/", total, ")", "Instalando o compilador de Rust Lang e Go Lang")
    instalar_go_lang()
    instalar_rust_lang()

    # Instalando o logisim
    parte += 1
    print("(", parte, "/", total, ")", "Instalando o Logisim")
    instalar_logisim()

    # Instalando a ultima versao do Youtube-dl
    parte += 1
    print("(", parte, "/", total, ")", "Instalando a ultima versao do Youtube-dl")
    instalar_youtube_dl()

    # Removendo programas inuteis
    parte += 1
    print("(", parte, "/", total, ")", "Desinstalando programas inuteis")
    desinstalar_programas_inuteis()

    # Configurando atualizacoes automaticas
    parte += 1
    print("(", parte, "/", total, ")", "Configurando atualizacoes automaticas")
    configurar_atualizacoes_automaticas()

    # Configurando o Visual Studio Code
    parte += 1
    print("(", parte, "/", total, ")", "Configurando o Visual Studio Code")
    configurar_visual_studio_code()
    instalar_extensoes_visual_studio_code()

    # Criando alias
    parte += 1
    print("(", parte, "/", total, ")", "Criando alias")
    configurar_alias()

    # Saindo do terminal
    print("Instalacao concluida!")


if __name__ == "__main__":
    main()
