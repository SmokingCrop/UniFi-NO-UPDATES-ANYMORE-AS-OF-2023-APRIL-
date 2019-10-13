#! /bin/bash

Kleur='\033[1;31m'
loos='\033[0m'

echo -e "${Kleur}Met dit script wordt je systeem, de UniFi Controller en Pi-hole upgedatet.\n${loos}"
read -p "Typ de gewenste Stabiele UniFi Controller versie (bijv. 5.9.29) of druk op ENTER voor versie 5.11.50: " version

if [[ -z "$version" ]]; then
	version='5.11.50'
fi

echo -e "${Kleur}\n\nNu wordt het systeem up-to-date gebracht en worden de oude en niet gebruikte packages verwijderd.\n\n${loos}"
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove && sudo apt-get autoclean
echo -e "${Kleur}\n\nDe UniFi Controller met versie $version wordt gedownload.\n\n${loos}"
wget http://dl.ubnt.com/unifi/$version/unifi_sysvinit_all.deb -O unifi_$version\_sysvinit_all.deb
echo -e "${Kleur}\n\nDe UniFi controller wordt nu geupdatet.\n\n${loos}"
sudo dpkg -i unifi_$version\_sysvinit_all.deb
echo -e "${Kleur}\n\nPi-hole wordt nu geupdatet.\n\n${loos}"
pihole -up
