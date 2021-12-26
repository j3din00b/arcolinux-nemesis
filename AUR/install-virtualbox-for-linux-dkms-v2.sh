#!/bin/bash
set -e
##################################################################################################################
# Author	:	Erik Dubois
# Website	:	https://www.erikdubois.be
# Website	:	https://www.arcolinux.info
# Website	:	https://www.arcolinux.com
# Website	:	https://www.arcolinuxd.com
# Website	:	https://www.arcolinuxb.com
# Website	:	https://www.arcolinuxiso.com
# Website	:	https://www.arcolinuxforum.com
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################
echo "################################################################"
echo "##  This script assumes you have the linux kernel running     ##"
echo "################################################################"

sudo pacman -S --noconfirm --needed virtualbox
sudo pacman -S --noconfirm --needed linux-hardened-headers
sudo pacman -S --needed virtualbox-host-dkms

echo "################################################################"
echo "##      Removing all the messages virtualbox produces         ##"
echo "################################################################"
VBoxManage setextradata global GUI/SuppressMessages "all"

echo "################################################################"
echo "#########           You have to reboot.                 #########"
echo "################################################################"
