<h1>https://community.ubnt.com/t5/UniFi-Routing-Switching/Step-By-Step-Tutorial-Guide-Raspberry-Pi-with-UniFi-controller/td-p/2470231</h1>

<p><font face="helvetica">Greetings,</font></p>
<p>&nbsp;</p>
<p><font face="helvetica">Thought I'd make a step-by-step tutorial for anyone looking for a straight forward installation of both the UniFi controller and <font color="#008080"><a href="https://pi-hole.net/" target="_self">Pi-hole (Advertisement Blocking DNS server)</a></font> without needing to hook up the Raspberry Pi to a monitor with keyboard and mouse (headless). You can install one without the other as well.<br></font></p>
<p><br><font face="helvetica">If you still have questions or if I forgot to explain some part you're stuck at, please post here so I can add this to the tutorial.<br><br>Dutch version: <a href="https://gathering.tweakers.net/forum/list_messages/1873125" target="_blank" rel="noopener">https://gathering.tweakers.net/forum/list_messages/1873125</a><br></font></p>
<p>&nbsp;</p>
<p><font size="4" face="impact,chicago">What you will physically need</font></p>
<p><font face="helvetica">- Raspberry Pi 3 model B(+)</font></p>
<p><font face="helvetica">- Ethernet cable to connect it to an existing network</font></p>
<p><font face="helvetica">- capability to connect the MicroSD card to a computer via a card reader</font></p>
<p>&nbsp;</p>
<p><font size="4" face="impact,chicago">Download the necessary tools and raspbian operating system image</font></p>
<p><font size="2" face="helvetica">1. Raspbian Stretch Lite (= without desktop interface) through the ZIP option (or torrent)</font></p>
<p><font color="#008080"><u><font size="2" face="helvetica"><a href="https://www.raspberrypi.org/downloads/raspbian/" target="_blank" rel="noopener">https://www.raspberrypi.org/downloads/raspbian/</a></font></u></font></p>
<p><font size="1 2 3 4 5 6 7">Direct: <font color="#008080"><u><a href="https://downloads.raspberrypi.org/raspbian_lite_latest" target="_blank" rel="noopener">https://downloads.raspberrypi.org/raspbian_lite_latest</a></u></font></font></p>
<p>&nbsp;</p>
<p><font size="2" face="helvetica"><span>2. Rufus to install the image to the MicroSD card</span></font></p>
<p><u><font size="2" face="helvetica" color="#008080"><a href="https://rufus.akeo.ie" target="_blank" rel="noopener">https://rufus.akeo.ie</a></font></u></p>
<p><font size="1 2 3 4 5 6 7" face="helvetica"><span>Direct: <font color="#008080"><a href="https://github.com/pbatard/rufus/releases/download/v3.4/rufus-3.4.exe" target="_blank" rel="noopener">https://github.com/pbatard/rufus/releases/download/v3.4/rufus-3.4.exe</a></font></span></font></p>
<p>&nbsp;</p>
<p><font size="2" face="helvetica"><span>3. Advanced IP Scanner to get the IP address</span></font></p>
<p><font color="#008080"><u><font size="2" face="helvetica"><a href="http://www.advanced-ip-scanner.com" target="_blank" rel="noopener">http://www.advanced-ip-scanner.com</a></font></u></font></p>
<p><font size="1 2 3 4 5 6 7" color="#008080"><font face="helvetica" color="#000000">Direct: </font><u><font face="helvetica"><a href="http://www.advanced-ip-scanner.com/download/Advanced_IP_Scanner_2.5.3646.exe" target="_blank" rel="noopener">http://www.advanced-ip-scanner.com/download/Advanced_IP_Scanner_2.5.3646.exe</a></font></u></font></p>
<p>&nbsp;</p>
<p><font size="2" face="helvetica"><span>4. If you are <u>not</u> using Windows 10, you can use PuTTY instead of the command prompt</span></font></p>
<p><font color="#008080"><u><font size="2" face="helvetica"><a href="https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html" target="_blank" rel="noopener">https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html</a></font></u></font></p>
<p><font size="1 2 3 4 5 6 7" face="helvetica" color="#008080"><span>Direct: <u><a href="https://the.earth.li/~sgtatham/putty/latest/w64/putty-64bit-0.70-installer.msi" target="_blank" rel="noopener">https://the.earth.li/~sgtatham/putty/latest/w64/putty-64bit-0.70-installer.msi</a></u></span></font></p>
<p>&nbsp;</p>
<p>5. If you are having issues with the partitions on your MicroSD card, I recommend using MiniTool Partition Wizard.<br>Makes it very easy to start from scratch by removing every partition on your MicroSD and creating a new partition.<br><font color="#008080"><a href="https://www.partitionwizard.com/free-partition-manager.html" target="_blank" rel="noopener">https://www.partitionwizard.com/free-partition-manager.html</a></font><br><font size="1 2 3 4 5 6 7">Direct: <font color="#008080"><a href="https://www.partitionwizard.com/download/10.3/pw103-free.exe" target="_blank" rel="noopener">https://www.partitionwizard.com/download/10.3/pw103-free.exe</a></font></font></p>
<p>&nbsp;</p>
<p><font size="4" face="impact,chicago"><span>Install Raspbian on the MicroSD</span></font></p>
<p><font face="helvetica">Open up Rufus to install Raspbian.</font></p>
<ol>
<li>Make sure your MicroSD card is selected<br><br></li>
<li>Press SELECT and select the downloaded raspbian-stretch-lite.zip<br><strong>Tip</strong>: you don’t have to extract the .zip<br><br></li>
<li>Press START<br><br></li>
<li>Accept the warning about removing all of the data on the MicroSD<br><br><li-image width="268" height="345" alt="Rufus.png" align="inline" id="171781i2296BB8C6D0AB56A" size="small" resized="true" sourcetype="new"></li-image><br><br></li>
<li>wait until the process is done.</li>
</ol>
<p>&nbsp;</p>
<p><font size="4" face="impact,chicago">Activate SSH</font></p>
<p>Activate SSH before starting the Raspberry Pi by adding a new text file to the main folder of the MicroSD card (boot partition).</p>
<p>Rename this text file to &nbsp;&nbsp; <font face="helvetica"><strong>ssh</strong> </font>&nbsp;&nbsp;&nbsp;&nbsp;and remove the .txt extension.</p>
<p>&nbsp;</p>
<p>The MicroSD is ready now, insert it into your raspberry pi, connect an ethernet cable and turn on the Raspberry Pi.</p>
<p>&nbsp;</p>
<p><font size="2" face="helvetica"><br><font size="4" face="impact,chicago">Lookup the IP address</font></font></p>
<p>If you’re using Advanced IP Scanner, you can simply press SCAN and wait until the Raspberry Pi shows up.</p>
<p>&nbsp;</p>
<p><font size="4" face="helvetica"><br><font face="impact,chicago">Login via SSH and change the password</font></font></p>
<ol>
<li>Open up the command prompt (cmd in start of windows)<br><strong>Tip</strong>: You should be able to paste commands by right clicking into the command prompt.<br><br></li>
<li>Login with the SSH command<br><strong>Note</strong>: change the IP address with the IP address of your Raspberry Pi<br><br>
<pre><strong>ssh <font color="#808080"><em>192.168.1.2</em></font> -l pi</strong></pre>
</li>
<li>As we have not defined an SSH key, it will ask if we trust the host.<br><br>
<pre>The authenticity of host '192.168.1.2 (192.168.1.2)' can't be established.
ECDSA key fingerprint is SHA256:XXX.
Are you sure you want to continue connecting (yes/no)? 

<strong>yes</strong></pre>
</li>
<li>When typing in the password, you will not see characters being displayed, simply type it and enter<br><br>
<pre>The default password is:

<strong>raspberry<br><br></strong></pre>
<br><font size="1 2 3 4 5 6 7" color="#FF6600"><strong>I've added all the following commands into a simple script that I share through my GitHub project.<br></strong><strong>By entering the following code right after you login into your Raspberry Pi with ssh you will not have to copy/paste all of these commands.<br>You also get to choose the stable version of the UniFi controller that you'd like to install.</strong></font><br><font size="1 2 3 4 5 6 7" color="#FF6600"><strong>If you wish to check the script before executing, check <a href="https://github.com/SmokingCrop/UniFi/blob/master/install-unifi-pihole-English.sh" target="_self"><u>the link</u></a> in the command below.</strong></font><br><br>
<pre>wget "https://github.com/SmokingCrop/UniFi/raw/master/install-unifi-pihole-English.sh" -O install-unifi-pihole.sh &amp;&amp; chmod +x install-unifi-pihole.sh &amp;&amp; ./install-unifi-pihole.sh</pre>
<font size="1 2 3 4 5 6 7" color="#FF6600"><strong>If you do not wish to use the script, just continue following the tutorial:</strong></font><br><br></li>
<li>The first thing you should do is change the default password.&nbsp;<br>After entering the passwd command, it'll ask you to type the current once and your new password twice.<br><br>
<pre>pi@raspberrypi:~ $ <strong>passwd</strong>
Changing password for pi.
(current) UNIX password:
Enter new UNIX password:
Retype new UNIX password:
passwd: password updated successfully</pre>
<br><br></li>
</ol>
<p><font size="4" face="impact,chicago">Update all existing packages</font></p>
<p><font face="helvetica">To make sure you have all the latest and greatest (firmware) updates and to clean up any unused/old ones, execute the following command</font></p>
<p>&nbsp;</p>
<pre><strong>sudo apt-get update &amp;&amp; sudo apt-get upgrade -y &amp;&amp; sudo apt-get autoremove &amp;&amp; sudo apt-get autoclean</strong></pre>
<p><br><br></p>
<p><font size="4" face="impact,chicago">Install the UniFi controller</font></p>
<p>&nbsp;</p>
<p>I'll show two ways of installing the UniFi controller.</p>
<p><br><strong><font color="#008000"><u>Method A</u></font></strong>: manually installing the controller by using the download link on the website/update blog.</p>
<ul>
<li>Easily install any controller version you want, whenever you want. As soon as the blog comes out.</li>
<li>If you're not using the script, it'll take more commands to update your controller in the future</li>
</ul>
<p><strong><font color="#993366"><u>Method B</u></font></strong>: Setting up the repository so you can install and update with the apt-get command.</p>
<ul>
<li>Once it is setup, you can install/update the controller like any other program with apt-get.</li>
<li>When a new controller version is out, it takes like a week before you'll be able to install it.</li>
<li>It's recommended to still go the blog of the update to know if any changes will affect your setup!</li>
</ul>
<p>&nbsp;</p>
<p><font size="3"><strong><u><font color="#008000">Install the UniFi controller with method A</font>:</u></strong></font></p>
<p>&nbsp;</p>
<p>You can go to the (beta) updates blog and copy the Debian download link at the bottom of the posts (UniFi Controller for Debian/Ubuntu) if you want a different version than the one used in this tutorial.<br><font color="#008080"><u><a href="https://community.ubnt.com/t5/UniFi-Updates-Blog/bg-p/Blog_UniFi" target="_blank" rel="noopener">https://community.ubnt.com/t5/UniFi-Updates-Blog/bg-p/Blog_UniFi</a></u></font></p>
<p><span><font color="#008080"><u><a href="https://community.ubnt.com/t5/UniFi-Beta-Blog/bg-p/Blog_UniFi_Beta" target="_blank" rel="noopener">https://community.ubnt.com/t5/UniFi-Beta-Blog/bg-p/Blog_UniFi_Beta</a></u></font> (you need beta access)</span></p>
<p><br><a href="https://community.ubnt.com/t5/UniFi-Updates-Blog/UniFi-SDN-Controller-5-9-29-Stable-has-been-released/ba-p/2516852" target="_self"><li-image width="334" height="164" alt="Image 2.png" align="inline" id="187608i56DEA8ACC6C6BE17" size="medium" resized="true" sourcetype="new"></li-image></a>&nbsp;<br><br></p>
<ol>
<li>Use the link with the wget command to download the controller installation package.<br><br>
<pre><strong>wget http://dl.ubnt.com/unifi/5.9.29/unifi_sysvinit_all.deb</strong></pre>
</li>
<li>
<p>Install Java 8 as it’s not included with the light version of Raspbian.<br><br><font size="1 2 3 4 5 6 7" color="#FF6600">Note: You'll need a newer version for the new 5.10.x 'unstable' controller. </font><font size="1 2 3 4 5 6 7" color="#FF6600">The default java version in Raspbian is too old.<br>You can follow this guide to install the latest version:</font><br><font size="1 2 3 4 5 6 7" color="#FF6600"><a href="https://ribasco.wordpress.com/2018/02/11/how-to-install-the-latest-java-version-in-raspbian-stretch/" target="_blank" rel="noopener">https://ribasco.wordpress.com/2018/02/11/how-to-install-the-latest-java-version-in-raspbian-stretch/</a></font><br><br></p>
<pre><strong>sudo apt-get -y install oracle-java8-jdk</strong> </pre>
</li>
<li>Install UniFi and its dependencies.<br><br>
<pre><strong>sudo dpkg -i unifi_sysvinit_all.deb; sudo apt-get install -f -y</strong></pre>
</li>
</ol>
<p>Go to your UniFi controller via the IP address and port:</p>
<p>E.g: <span><a href="https://192.168.1.2:8443" target="_blank" rel="noopener"><font color="#008080">https://192.168.1.2:8443</font></a></span></p>
<p><span><font color="#008080">&nbsp;</font></span></p>
<p>You’ll want to set a reserved IP in the UniFi controller for the Raspberry Pi.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p><font size="3"><strong><u><font color="#993366">Install the UniFi controller with method B</font>:</u></strong></font></p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<ol>
<li>&nbsp;Install Java 8 as it's not included with the light version of Raspbian.<br><br>
<pre><strong>sudo apt-get -y install oracle-java8-jdk</strong></pre>
</li>
<li>Add a new source list<br><br>
<pre><strong>echo 'deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list</strong></pre>
</li>
<li>Add the GPG keys<br><br>
<pre><strong>sudo wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ubnt.com/unifi/unifi-repo.gpg</strong></pre>
</li>
<li>Update the package information and install UniFi<br><br>
<pre><strong>sudo apt-get update; sudo apt-get install unifi -y</strong></pre>
</li>
</ol>
<p><br>Go to your UniFi controller via the IP address and port:</p>
<p>E.g: <span><a href="https://192.168.1.2:8443" target="_blank" rel="noopener"><font color="#008080">https://192.168.1.2:8443</font><br></a></span><br>You’ll want to set a reserved IP in the UniFi controller for the Raspberry Pi.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p><font size="4" face="impact,chicago">Install Pi-hole</font></p>
<p>Execute the following command and configure Pi-hole</p>
<p><font size="2" face="helvetica">&nbsp;</font></p>
<pre><strong>curl -sSL https://install.pi-hole.net | bash</strong></pre>
<pre>&gt; Choose an interface:
(*) eth0  (= ethernet cable)

&gt; Choose your DNS provider
Custom
1.1.1.1, 8.8.8.8<br>(= fast cloudflare dns &amp; basic Google dns)

&gt; Choose your adblocking providers<br>leave them enabled

&gt; IPv4 and/or IPv6<br>both

&gt; PiHole wants to set a static IP. Let it do its thing.
I guess they haven’t heard of DHCP reservation/central management yet.

&gt; Install the Web admin interface and the web server </pre>
<p><font size="2" face="helvetica">Change the password used to log into the web admin interface</font></p>
<p>&nbsp;</p>
<pre>pi@raspberrypi:~ $ <strong>pihole -a -p</strong>
Enter New Password (Blank for no password):
Confirm Password:
  [✓] New password set</pre>
<p>&nbsp;</p>
<p>Go to your Pi Hole web admin interface via the IP address and /admin:</p>
<p>E.g: <font color="#008080"><span><a href="http://192.168.1.2/admin" target="_blank" rel="noopener">http://192.168.1.2/admin</a></span></font></p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p><font size="4" face="impact,chicago">Updating the UniFi controller and Pi-hole with future updates</font></p>
<p>&nbsp;</p>
<p><strong><u><font color="#008000">Updating/Upgrading the UniFi controller with method A</font>:</u></strong>&nbsp;</p>
<p><font size="1 2 3 4 5 6 7"><strong><font face="helvetica" color="#FF6600">I've also made a simple script for updating your system, controller and pi-hole in one go.<br>Simply enter <u>./update.sh</u> in the future to use the script again without having to redownload it.</font></strong></font></p>
<p><font size="1 2 3 4 5 6 7" face="helvetica">&nbsp;</font></p>
<pre>wget "https://github.com/SmokingCrop/UniFi/raw/master/update-unifi-pihole-English.sh" -O update.sh &amp;&amp; chmod +x update.sh &amp;&amp; ./update.sh</pre>
<p><font size="1 2 3 4 5 6 7" face="helvetica"><strong><font color="#FF6600">or keep following the tutorial:</font></strong></font></p>
<p>&nbsp;</p>
<p><font size="2" face="helvetica">If you want to install a new version of the UniFi controller you basically delete the old downloaded version, download the new and install it.<br><strong>Tip</strong>: you can use Tab to complete commands/file-names etc.<br><br></font></p>
<pre><strong>rm unifi_sysvinit_all.deb
wget http://dl.ubnt.com/unifi/<font color="#FF6600">x.x.xx</font>/unifi_sysvinit_all.deb
sudo dpkg -i unifi_sysvinit_all.deb</strong></pre>
<p>&nbsp;</p>
<p><font size="2" face="helvetica"><strong><u><font color="#993366">Updating/Upgrading the UniFi controller with method B</font>:</u></strong>&nbsp;</font></p>
<p>&nbsp;</p>
<p>&nbsp;This will also update your other programs.<br><br></p>
<pre><font size="2" face="helvetica">sudo apt-get update; sudo apt-get upgrade -y</font></pre>
<p>&nbsp;</p>
<p><font size="2" face="helvetica"><br><strong><u>Updating Pi-hole is very simple</u></strong><br><br></font></p>
<pre>pihole -up</pre>
<p>&nbsp;</p>
<p>&nbsp;</p>
