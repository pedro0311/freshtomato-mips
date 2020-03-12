# **FreshTomato-MIPS** #

**Forked off from Tomato by Shibby, builds compiled by pedro**

Forums about Tomato:

PL: https://openlinksys.info/forum/

EN: https://www.linksysinfo.org/

This is a FreshTomato fork, If anyone wants to pick up changes and merge them to your repository, feel free and go ahead. That's the reason Tomato is an open-source project.

**Source code**: https://bitbucket.org/pedro311/freshtomato-mips/commits/all

**Project page**: https://freshtomato.org/

**Donations**: https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=B4FDH9TH6Z8FU  BTC: 1JDxBBQvcJ9XxgagJRNVrqC1nysq8F8B1Y  

For the following **MIPSR1** and **MIPSR2** routers: **Asus** WL500GP, N10U, N12 A1/B1/C1/D1/VP/K, N15U, N16, N53, N66U, AC66U **Netgear** WNR3500LV1, WNR3500LV2, R6300V1, WNDR4500V1, WNDR4500V2, WNDR3400/v2/v3, WNDR3700v3 **Linksys** WRT54 series, E800, E900, E1000v2/v2.1, E1200V1, E1200V2, E1500, E2000, E2500, E3000, E3200, E4200 **Tenda** W1800R, N80 **Dlink** DIR-320 **Belkin** F5D8235v3, F7D3301, F7D3302, F7D4302, F9K1102v1/v3.

Disclaimer: I am not responsible for any bricked routers, nor do I encourage other people to flash alternative firmwares on their routers. Use at your own risk!


**HOW TO PREPARE A WORK ENVIRONMENT FOR FRESHTOMATO COMPILATION (on Debian 9.x/64bit)**

1. Login as root

2. Update system:  
    apt-get update  
    apt-get dist-upgrade  

3. Install basic packages:  
    apt-get install build-essential net-tools  

4. NOT NECESSARY (depends if sys is on vmware); install vmware-tools:  
    mkdir /mnt/cd  
    mount /dev/cdrom /mnt/cd  
    unpack  
    ./vmware-install.pl  
    Or from debian package:  
    apt-get install open-vm-tools  

5. Set proper date/time:  
    dpkg-reconfigure tzdata  

6. Add your <username> to sudo group:  
    apt-get install sudo  
    adduser <username> sudo  
    reboot  

7. Login as <username>, install base packages with all dependencies:  
    sudo apt-get install autoconf m4 bison flex g++ libtool sqlite gcc binutils patch bzip2 make gettext unzip zlib1g-dev libc6 gperf automake groff  
    sudo apt-get install lib32stdc++6 libncurses5 libncurses5-dev gawk gitk zlib1g-dev autopoint shtool autogen mtd-utils gcc-multilib gconf-editor lib32z1-dev pkg-config libssl-dev automake1.11  
    sudo apt-get install libxml2-dev intltool libglib2.0-dev libstdc++5 texinfo dos2unix xsltproc libnfnetlink0 libcurl4-openssl-dev libgtk2.0-dev libnotify-dev libevent-dev mc git  
    sudo apt-get install re2c texlive libelf1 mc nodejs cmake  
    sudo apt-get install linux-headers-$(uname -r)

8. Remove libicu-dev if it's installed, it stopped PHP compilation:  
    sudo apt-get remove libicu-dev  

9. Install i386 elf1 packages:  
    sudo dpkg --add-architecture i386  
    sudo apt-get update  
    sudo apt-get install libelf1:i386 libelf-dev:i386  

10. Clone/download repository:  
    git clone https://bitbucket.org/pedro311/freshtomato-mips.git <chosen-subdir>  

11. Edit profile file, add:  
    PATH="$PATH:/home/<username>/<chosen-subdir>/tools/brcm/hndtools-mipsel-linux/bin"  
    PATH="$PATH:/home/<username>/<chosen-subdir>/tools/brcm/hndtools-mipsel-uclibc/bin"  
    PATH="$PATH:/bin:/sbin:/usr/bin:/usr/X11R6/bin"  

12. Reboot system  

13. Add your email to git config:  
    git config --global user.email "<email-address>"  
   or  
    git config user.email "<email-address>"  
   for a single repo  

14. Add your username to git config:  
    git config --global user.name <name>  


**HOW TO COMPILE**

1. Change dir to git repository ie: ```$ cd /freshtomato-mips```  
2. Before every compilation, use ```$ git clean -fdxq && git reset --hard```, and possibly ```git pull``` to pull recent changes from remote  
3. To compile RT image, use: ```$ git checkout mips-master``` then: ```$ cd release/src-rt```, check for possible targets: ```$ make help```, use one (Mini for ie. WRT54G): ```$ make f```  
4. To compile RT-N image, use: ```$ git checkout mips-RT-AC``` then: ```$ cd release/src-rt```, check for possible targets: ```$ make help```, use one (RT-N66U build AIO): ```$ make r64z```  
5. To compile RT-AC image, use: ```$ git checkout mips-RT-AC``` then: ```$ cd release/src-rt-6.x```, check for possible targets: ```$ make help```, use one (RT-AC66U build AIO): ```$ make ac66z```  

**WARNING**

To compile n60, rtn53, e2500, e3200, wndr3400v2, wndr3400v2-vpn and f9k targets (RT-N), before compilation you have to revert patch to the kernel: ```$ cd release/src-rt/linux``` ```patch -R -p4 < fix4usbap.patch```

