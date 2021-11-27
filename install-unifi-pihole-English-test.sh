#! /bin/bash

Colour='\033[1;31m'
less='\033[0m'

echo -e "${Colour}By using this script, you'll adjust the password, update the system, install the stable UniFi controller of your choice and install Pi-hole.\nUse CTRL+C to cancel the script\n\n${less}"
read -p "Please enter a STABLE version (e.g: 6.0.43) or press enter for version 6.4.54: " version

if [[ -z "$version" ]]; then
	version='6.4.54'
fi

echo -e "${Colour}\nChange your default password:\nThe default password for the user pi is raspberry\n\nYou can press enter if you don't want to update your password\n${less}"
passwd

echo -e "${Colour}\n\nAdding the Raspbian Stretch sources.list for MongoDB compatability.\n\n${less}"
echo 'deb http://archive.raspbian.org/raspbian stretch main contrib non-free rpi' | sudo tee /etc/apt/sources.list.d/raspbian_stretch_for_mongodb.list

echo -e "${Colour}\n\nThe system will now upgrade all the software and firmware, as well as clean up old/unused packages.\n\n${less}"
sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt-get autoclean -y

echo -e "${Colour}\n\nThe UniFi controller with version $version is downloading now.\n\n${less}"
wget http://dl.ui.com/unifi/$version/unifi_sysvinit_all.deb -O unifi_$version\_sysvinit_all.deb

echo -e "${Colour}\n\nBefore installing the UniFi Controller, it will first install OpenJDK 8 (Java), jsvc and libcommons-daemon-java which are required to install the UniFi controller.\n\n${less}"
sudo apt install openjdk-8-jre-headless jsvc libcommons-daemon-java -y

echo -e "${Colour}\n\nIn order to fix an issue which can cause a slow start for the UniFi controller, haveged is installed.\n\n${less}"
sudo apt install haveged -y

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
