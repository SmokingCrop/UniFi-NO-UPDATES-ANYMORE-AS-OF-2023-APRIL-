#! /bin/bash

Kleur='\033[1;31m'
loos='\033[0m'

echo -e "${Kleur}Met dit script passen we het wachtwoord aan, wordt het systeem up-to-date gebracht, installeren we de UniFi controller met versie van jouw keuze en wordt Pi-hole geïnstalleerd.\nDruk op CTRL+C om het script te stoppen.\n${loos}"
read -p "Typ de gewenste Stabiele UniFi Controller versie (bijv. 5.9.29) of druk op ENTER voor versie 5.11.46: " version

if [[ -z "$version" ]]; then
	version='5.11.46'
fi

echo -e "${Kleur}\nVerander je wachtwoord:\nHet standaard wachtwoord is raspberry\nJe kan op enter drukken om dit over te slaan\n${loos}"
passwd

echo -e "${Kleur}\n\nNu wordt het systeem up-to-date gebracht en worden de oude en niet gebruikte packages verwijderd.\n\n${loos}"
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove && sudo apt-get autoclean

echo -e "${Kleur}\n\nNu wordt de UniFi Controller met versie $version gedownload.\n\n${loos}"
wget http://dl.ubnt.com/unifi/$version/unifi_sysvinit_all.deb -O unifi_$version\_sysvinit_all.deb

echo -e "${Colour}\n\nVooraleer de UniFi controller geïnstalleerd wordt, dient Java (OpenJDK 8) geïnstalleerd te worden.\n\n${less}"
sudo apt-get install openjdk-8-jre-headless -y

echo -e "${Colour}\n\nOm een oplossing te bieden voor de trage opstart van de UniFi controller door een specifiek probleem, wordt haveged geïnstalleerd.\n\n${less}"
sudo apt-get install haveged -y

echo -e "${Kleur}\n\nDe UniFi controller wordt nu geïnstalleerd.\n\n${loos}"
sudo dpkg -i unifi_$version\_sysvinit_all.deb; sudo apt-get install -f -y

if [[ -z "$1" ]] ; then
echo -e "${Kleur}\n\nPi-hole wordt nu geïnstalleerd.\nVoer de nodige configuratie stappen uit wanneer hier om gevraagd wordt.\n\n${loos}"
curl -sSL https://install.pi-hole.net | bash

echo -e "${Kleur}\n\nNu juist nog het wachtwoord aanpassen van de web interface van Pi-hole.\n\n${loos}"
pihole -a -p
fi
