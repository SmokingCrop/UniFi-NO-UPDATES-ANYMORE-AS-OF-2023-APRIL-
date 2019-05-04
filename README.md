> [Original Post](https://community.ubnt.com/t5/UniFi-Routing-Switching/Step-By-Step-Tutorial-Guide-Raspberry-Pi-with-UniFi-controller/td-p/2470231) is linked in the upstream repo, but it is out of date so this is the improved version in markdown hosted on github for ease of updating and version tracking.

# Prerequisites

 - Raspberry Pi 3 model B(+) with a MicroSD card of atleast 4GB
 - Ethernet cable to connect it to an existing network
 - capability to connect the MicroSD card to a computer via a card reader

# Installing UniFi Controller on Raspberry Pi

## Download the necessary tools and raspbian operating system image

1. Raspbian Stretch Lite (= without desktop interface) through the ZIP option (or torrent).

    a. https://www.raspberrypi.org/downloads/raspbian/
  
    b. Direct: https://downloads.raspberrypi.org/raspbian_lite_latest

2. Rufus to install the image on to the MicroSD card.

    a. https://rufus.akeo.ie

    b. Direct: https://github.com/pbatard/rufus/releases/download/v3.5/rufus-3.5.exe

3. Advanced IP Scanner to figure out the assigned IP address of your Raspberry Pi.

    a. http://www.advanced-ip-scanner.com
    
    b. Direct: http://www.advanced-ip-scanner.com/download/Advanced_IP_Scanner_2.5.3850.exe
 
4. If you are _not_ using Windows 10, you can use PuTTY instead of the command prompt to connect to your Raspberry Pi.

    a. https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html

    b. Direct: https://the.earth.li/~sgtatham/putty/latest/w64/putty-64bit-0.71-installer.msi

5. If you are having issues with the partitions on your MicroSD card, I recommend using MiniTool Partition Wizard. This program makes it very easy to start from scratch by removing every partition on your MicroSD and creating a new Fat32 partition.

    a. https://www.partitionwizard.com/free-partition-manager.html
    
    b. Direct: https://www.partitionwizard.com/download/v11/pw11-free.exe
    
## Install Raspbian Lite on the MicroSD

1. Open Rufus (or preferred imaging software)

2. Make __sure__ you have the correct MicroSD card selected (This operation wipes all data on all partitions of the device selected)

3. Press START

4. Accept the warning about removing all data

