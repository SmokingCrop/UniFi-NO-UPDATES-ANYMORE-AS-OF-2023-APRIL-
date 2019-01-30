#! /bin/bash

Colour='\033[1;31m'
less='\033[0m'

echo -e "${Colour}By using this script you will upgrade your system, the UniFi Controller and Pi-hole.\nWhich stable version of the UniFi controller do you wish to install? (E.g: 5.8.28)${less}"
read version
echo -e "${Colour}\n\nThe system will now upgrade all the software and firmware, as well as clean up old/unused packages.\n\n${less}"
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove && sudo apt-get autoclean
echo -e "${Colour}\n\nThe UniFi controller (version $version) will now be downloaded.\n\n${less}"
wget http://dl.ubnt.com/unifi/$version/unifi_sysvinit_all.deb -O unifi_$version\_sysvinit_all.deb
echo -e "${Colour}\n\nThe UniFi controller will now be upgraded.\n\n${less}"
sudo dpkg -i unifi_$version\_sysvinit_all.deb
echo -e "${Colour}\n\nPi-hole will now be upgraded.\n\n${less}"
pihole -up