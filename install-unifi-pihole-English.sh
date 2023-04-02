#! /bin/bash

Colour='\033[1;31m'
less='\033[0m'
requiredver='7.3.83'

echo -e "${Colour}THIS NO LONGER WORKS ON A FULLY UPDATED RASPBERRY PI 4. Please try this script instead: https://community.ui.com/questions/UniFi-Installation-Scripts-or-UniFi-Easy-Update-Script-or-UniFi-Lets-Encrypt-or-UniFi-Easy-Encrypt-/ccbc7530-dd61-40a7-82ec-22b17f027776?page=1\n\n${less}"
echo -e "${Colour}THE SCRIPT WILL NO LONGER RECEIVE UPDATES. IT MAY NO LONGER WORK WITH A NEW UPDATE. PLEASE TRY TO USE THE SCRIPT IN THE LINK ABOVE.\n\n${less}"


echo -e "${Colour}By using this script, you'll update the system, install the stable UniFi controller of your choice and install Pi-hole.\nUse CTRL+C to cancel the script\n\n${less}"
read -p "Please enter a STABLE version of your choice (e.g: 7.3.76) or press enter for the latest stable version 7.3.83: " version

if [[ -z "$version" ]]; then
	version='7.3.83'
fi

echo -e "${Colour}\n\nAdding the Raspbian Stretch sources.list for MongoDB compatability.\n\n${less}"
echo 'deb http://archive.raspbian.org/raspbian stretch main contrib non-free rpi' | sudo tee /etc/apt/sources.list.d/raspbian_stretch_for_mongodb.list

echo -e "${Colour}\n\nThe system will now upgrade all the software and firmware, as well as clean up old/unused packages.\n\n${less}"
sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt-get autoclean -y

echo -e "${Colour}\n\nThe UniFi controller with version $version is downloading now.\n\n${less}"
wget https://dl.ui.com/unifi/$version/unifi_sysvinit_all.deb -O unifi_$version\_sysvinit_all.deb

echo -e "${Colour}\n\nChecking if Java 11 is required for this version...\n\n${less}"
if [ "$(printf '%s\n' "$requiredver" "$version" | sort -V | head -n1)" = "$requiredver" ]; 
 then 
    echo -e "${Colour}\n\nJava 11 is required. Checking if Java 11 is installed...\n\n${less}"
 	if [ $(dpkg-query -W -f='${Status}' openjdk-11-jre-headless 2>/dev/null | grep -c "ok installed") -eq 0 ];
	then
		echo -e "${Colour}\n\nJava 11 wasn't found, installing now...\n\n${less}"
		sudo apt install openjdk-11-jre-headless -y
	fi	
 else
     echo -e "${Colour}\n\nJava 8 is required for the chosen version. Installing now.\n\n${less}"
     sudo apt install openjdk-8-jre-headless jsvc libcommons-daemon-java -y
 fi
 
echo -e "${Colour}\n\nMongoDB will now be installed as it's a dependency of UniFi.\n\n${less}"
sudo apt install mongodb-server mongodb-clients -y

echo -e "${Colour}\n\nThe UniFi controller will be installed now.\n\n${less}"
sudo dpkg -i unifi_$version\_sysvinit_all.deb; sudo apt install -f -y

if [[ -z "$1" ]] ; then
	echo -e "${Colour}\n\nPi-hole will be installed now.\nThe initial configuration is interactive.\n\n${less}"
	curl -sSL https://install.pi-hole.net | bash

	echo -e "${Colour}\n\nOne more step is changing the password for the web interface of the Pi-hole.\n\n${less}"
	pihole -a -p
fi

echo -e "${Colour}\n\nTo finish the installation, a reboot is required. Starting a reboot in 3 seconds.\n\n${less}"
sleep 3
echo -e "${Colour}\nRestarting the Raspberry Pi now.\n${less}"
sudo reboot now
