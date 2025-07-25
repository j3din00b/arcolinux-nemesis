#!/bin/bash
#set -e
##################################################################################################################################
# Author    : Erik Dubois
# Website   : https://www.erikdubois.be
# Website   : https://www.alci.online
# Website   : https://www.ariser.eu
# Website   : https://www.arcolinux.info
# Website   : https://www.arcolinux.com
# Website   : https://www.arcolinuxd.com
# Website   : https://www.arcolinuxb.com
# Website   : https://www.arcolinuxiso.com
# Website   : https://www.arcolinuxforum.com
##################################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################################
#tput setaf 0 = black
#tput setaf 1 = red
#tput setaf 2 = green
#tput setaf 3 = yellow
#tput setaf 4 = dark blue
#tput setaf 5 = purple
#tput setaf 6 = cyan
#tput setaf 7 = gray
#tput setaf 8 = light blue
##################################################################################################################################

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))

##################################################################################################################################

if [ "$DEBUG" = true ]; then
    echo
    echo "------------------------------------------------------------"
    echo "Running $(basename $0)"
    echo "------------------------------------------------------------"
    echo
    read -n 1 -s -r -p "Debug mode is on. Press any key to continue..."
    echo
fi

##################################################################################################################################

remove_if_installed() {
    for pattern in "$@"; do
        # Find all installed packages that match the pattern (exact + variants)
        matches=$(pacman -Qq | grep "^${pattern}$\|^${pattern}-")
        
        if [ -n "$matches" ]; then
            for pkg in $matches; do
                echo "Removing package: $pkg"
                sudo pacman -R --noconfirm "$pkg"
            done
        else
            echo "No packages matching '$pattern' are installed."
        fi
    done
}

##################################################################################################################################

func_install() {
    if pacman -Qi $1 &> /dev/null; then
        tput setaf 2
        echo "#######################################################################################"
        echo "################## The package "$1" is already installed"
        echo "#######################################################################################"
        echo
        tput sgr0
    else
        tput setaf 3
        echo "#######################################################################################"
        echo "##################  Installing package "  $1
        echo "#######################################################################################"
        echo
        tput sgr0
        sudo pacman -S --noconfirm --needed $1
    fi
}

##################################################################################################################################

echo
tput setaf 2
echo "########################################################################"
echo "################### Remove possible conflicting packages for Chadwm"
echo "########################################################################"
tput sgr0
echo

remove_if_installed arcolinux-rofi-git
remove_if_installed arcolinux-rofi-themes-git
remove_if_installed arcolinux-chadwm-git
remove_if_installed arconet-xfce
remove_if_installed lxappearance

echo
tput setaf 2
echo "########################################################################"
echo "################### Install Chadwm"
echo "########################################################################"
tput sgr0
echo


list=(
alacritty
archlinux-logout-git
edu-chadwm-git
edu-xfce-git
autorandr
dash
dmenu
feh
gcc
gvfs
lolcat
lxappearance-gtk3
make
picom-git
polkit-gnome
rofi
sxhkd
thunar
thunar-archive-plugin
thunar-volman
ttf-hack
ttf-font-awesome
ttf-jetbrains-mono-nerd
ttf-meslo-nerd-font-powerlevel10k
volumeicon
xfce4-notifyd
xfce4-power-manager
xfce4-screenshooter
xfce4-settings
xfce4-taskmanager
xfce4-terminal
xorg-xsetroot
)

count=0

for name in "${list[@]}" ; do
    count=$[count+1]
    tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
    func_install $name
done

echo
tput setaf 3
echo "########################################################################"
echo "SKEL"
echo "Copying all files and folders from /etc/skel/ to ~"
echo "########################################################################"
tput sgr0
echo

cp -af /etc/skel/.config/arco-chadwm ~/.config/
cp -af /etc/skel/.bin ~

echo
tput setaf 6
echo "##############################################################"
echo "###################  $(basename $0) done"
echo "##############################################################"
tput sgr0
echo
