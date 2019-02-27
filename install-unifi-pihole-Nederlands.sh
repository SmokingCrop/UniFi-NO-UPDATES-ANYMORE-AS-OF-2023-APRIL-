#! /bin/bash

Kleur='\033[1;31m'
loos='\033[0m'

echo -e "${Kleur}Met dit script passen we het wachtwoord aan, wordt het systeem up-to-date gebracht, installeren we de UniFi controller met versie van jouw keuze en wordt Pi-hole geïnstalleerd.\nDruk op CTRL+C om het script te stoppen.\nGeef de versie van de stabiele UniFi Controller in die je wenst te installeren (Bv: 5.10.19):${loos}"
read version
echo -e "${Kleur}\nVerander je wachtwoord:\nHet standaard wachtwoord is raspberry\nJe kan op enter drukken om dit over te slaan\n${loos}"
passwd
echo -e "${Kleur}\n\nNu wordt het systeem up-to-date gebracht en worden de oude en niet gebruikte packages verwijderd.\n\n${loos}"
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove && sudo apt-get autoclean
echo -e "${Kleur}\n\nNu wordt de UniFi Controller met versie $version gedownload.\n\n${loos}"
wget http://dl.ubnt.com/unifi/$version/unifi_sysvinit_all.deb -O unifi_$version\_sysvinit_all.deb
echo -e "${Kleur}\n\nVooraleer de Controller geïnstalleerd wordt, wordt eerst de laatste versie van Oracle Java 8 geïnstalleerd.\n\n${loos}"
sudo apt-get install dirmngr -y;sudo apt-key adv --recv-key --keyserver keyserver.ubuntu.com EEA14886
echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' | sudo tee --append /etc/apt/sources.list
echo 'deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' | sudo tee --append /etc/apt/sources.list
sudo apt-get update
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
echo "debconf shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
echo "debconf shared/accepted-oracle-license-v1-1 seen true" | sudo debconf-set-selections
sudo apt-get install oracle-java8-installer -y
echo -e "${Kleur}\n\nDe UniFi controller wordt nu geïnstalleerd.\n\n${loos}"
sudo dpkg -i unifi_$version\_sysvinit_all.deb; sudo apt-get install -f -y
echo -e "${Kleur}\n\nPi-hole wordt nu geïnstalleerd.\nVoer de nodige configuratie stappen uit wanneer hier om gevraagd wordt.\n\n${loos}"
curl -sSL https://install.pi-hole.net | bash
echo -e "${Kleur}\n\nNu juist nog het wachtwoord aanpassen van de web interface van Pi-hole.\n\n${loos}"
pihole -a -p
