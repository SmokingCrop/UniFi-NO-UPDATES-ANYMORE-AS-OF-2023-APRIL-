#! /bin/bash

Colour='\033[1;31m'
less='\033[0m'

echo -e "${Colour}By using this script you will UPGRADE your system, the UniFi Controller and Pi-hole.\n${less}"
read -p "Please enter the STABLE version (e.g: 6.0.43) or press enter for version 6.5.53: " version

if [[ -z "$version" ]]; then
	version='6.5.53'
fi
echo -e "${Colour}\n\nThe system will now upgrade all the software and firmware, as well as clean up old/unused packages.\n\n${less}"
sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt-get autoclean -y
echo -e "${Colour}\n\nThe UniFi controller (version $version) will now be downloaded.\n\n${less}"
wget http://dl.ui.com/unifi/$version/unifi_sysvinit_all.deb -O unifi_$version\_sysvinit_all.deb
echo -e "${Colour}\n\nThe UniFi controller will now be upgraded.\n\n${less}"
sudo dpkg -i unifi_$version\_sysvinit_all.deb

if hash pihole 2>/dev/null; then
	echo -e "${Colour}\n\nPi-hole will now be upgraded.\n\n${less}"
        pihole -up
fi
