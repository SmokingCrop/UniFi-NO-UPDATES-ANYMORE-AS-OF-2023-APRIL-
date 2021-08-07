#! /bin/bash

Kleur='\033[1;31m'
loos='\033[0m'

echo -e "${Kleur}Met dit script wordt je systeem, de UniFi Controller en Pi-hole upgedatet.\n${loos}"
read -p "Typ de gewenste Stabiele UniFi Controller versie (bijv. 6.0.43) of druk op ENTER voor versie 6.2.26: " version

if [[ -z "$version" ]]; then
	version='6.2.26'
fi

echo -e "${Kleur}\n\nNu wordt het systeem up-to-date gebracht en worden de oude en niet gebruikte packages verwijderd.\n\n${loos}"
sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt-get autoclean -y
echo -e "${Kleur}\n\nDe UniFi Controller met versie $version wordt gedownload.\n\n${loos}"
wget http://dl.ui.com/unifi/$version/unifi_sysvinit_all.deb -O unifi_$version\_sysvinit_all.deb
echo -e "${Kleur}\n\nDe UniFi controller wordt nu geupdatet.\n\n${loos}"
sudo dpkg -i unifi_$version\_sysvinit_all.deb

if hash pihole 2>/dev/null; then
	echo -e "${Kleur}\n\nPi-hole wordt nu geupdatet.\n\n${loos}"
        pihole -up
fi
