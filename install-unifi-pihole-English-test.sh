#! /bin/bash

Colour='\033[1;31m'
less='\033[0m'

echo -e "${Colour}By using this script, you'll adjust the password, update the system, install the stable UniFi controller of your choice and install Pi-hole.\nUse CTRL+C to cancel the script\n\nEnter the Stable UniFi version of your choice (E.g: 5.9.29):${less}"
read version
echo -e "${Colour}\nChange your password:\nThe current password is raspberry\n${less}"
passwd
echo -e "${Colour}\n\nThe system will now upgrade all the software and firmware, as well as clean up old/unused packages.\n\n${less}"
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove && sudo apt-get autoclean
echo -e "${Colour}\n\nThe UniFi controller with version $version is downloading now.\n\n${less}"
wget http://dl.ubnt.com/unifi/$version/unifi_sysvinit_all.deb -O unifi_$version\_sysvinit_all.deb
echo -e "${Colour}\n\nBefore installing the UniFi Controller, it will first install Oracle java 8.\n\n${less}"
sudo apt-get -y install oracle-java8-jdk
echo -e "${Colour}\n\nThe UniFi controller will be installed now.\n\n${less}"
sudo dpkg -i unifi_$version\_sysvinit_all.deb; sudo apt-get install -f -y
echo -e "${Colour}\n\nPi-hole will be installed now.\nThe initial configuration is interactive.\n\n${less}"
curl -sSL https://install.pi-hole.net | bash
echo -e "${Colour}\n\nOne more step is changing the password for the web interface of the Pi-hole.\n\n${less}"
pihole -a -p
