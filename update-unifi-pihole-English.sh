#! /bin/bash

Colour='\033[1;31m'
less='\033[0m'
requiredver='7.3.76'

echo -e "${Colour}By using this script you will UPGRADE your system, the UniFi Controller and Pi-hole.\n${less}"
read -p "Please enter a STABLE version of your choice (e.g: 7.2.95) or press enter for the latest stable version 7.3.76: " version

if [[ -z "$version" ]]; then
	version='7.3.76'
fi
echo -e "${Colour}\n\nThe system will now upgrade all the software and firmware, as well as clean up old/unused packages.\n\n${less}"
sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt-get autoclean -y

echo -e "${Colour}\n\nStopping the UniFi service...\n\n${less}"
sudo service unifi stop

echo -e "${Colour}\n\nChecking if Java 11 is required for this version...\n\n${less}"
if [ "$(printf '%s\n' "$requiredver" "$version" | sort -V | head -n1)" = "$requiredver" ]; 
 then 
    	echo -e "${Colour}\n\nJava 11 is required. Checking if Java 8 is still installed...\n\n${less}"    
 	if [ $(dpkg-query -W -f='${Status}' openjdk-8-jre-headless 2>/dev/null | grep -c "ok installed") -eq 1 ];
	then
	  echo -e "${Colour}\n\nRemoving Java 8...\n\n${less}"
	  sudo apt purge openjdk-8-jre-headless -y && sudo apt autoremove -y
	fi

    	echo -e "${Colour}\n\nChecking if Java 11 automatically got installed after deleting Java 8...\n\n${less}"
 	if [ $(dpkg-query -W -f='${Status}' openjdk-11-jre-headless 2>/dev/null | grep -c "ok installed") -eq 0 ];
	then
		echo -e "${Colour}\n\nJava 11 wasn't found, installing now...\n\n${less}"
	  sudo apt install openjdk-11-jre-headless -y
	fi	
 else
     echo -e "${Colour}\n\nJava 11 isn't required yet for the chosen version.\n\n${less}"
 fi

echo -e "${Colour}\n\nThe UniFi controller (version $version) will now be downloaded.\n\n${less}"
wget https://dl.ui.com/unifi/$version/unifi_sysvinit_all.deb -O unifi_$version\_sysvinit_all.deb
echo -e "${Colour}\n\nThe UniFi controller will now be upgraded.\n\n${less}"
sudo dpkg -i unifi_$version\_sysvinit_all.deb

if hash pihole 2>/dev/null; then
	echo -e "${Colour}\n\nPi-hole will now be upgraded.\n\n${less}"
        pihole -up
fi
