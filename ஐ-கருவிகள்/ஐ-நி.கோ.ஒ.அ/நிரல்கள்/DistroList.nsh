/*
 * This file is part of YUMI
 *
 * YUMI is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * any later version.
 *
 * YUMI is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with YUMI. If not, see <http://www.gnu.org/licenses/>.
 */

; ------------ Distro List -------------- 

Function SetISOFileName ; $DistroName $ISOFileName $DownLink $Persistence $DistroPath $Homepage $OfficialName
 
     !insertmacro SetISOFileNames "--- Ubuntu 32/64 Bit ---" "" "" "" "" "" ""
	 !insertmacro SetISOFileNames "" "" "" "" "" "" ""
	 
 !insertmacro SetISOFileNames "Ubuntu" "ubuntu*desktop*.iso" "https://www.ubuntu.com/download/desktop" "casper" "Linux-ISOs" "https://www.ubuntu.com/desktop" "Ubuntu"
 !insertmacro SetISOFileNames "Edubuntu" "edubuntu*.iso" "https://edubuntu.org/download" "casper" "Linux-ISOs" "https://edubuntu.org" "Edubuntu" 
 !insertmacro SetISOFileNames "Kubuntu" "kubuntu*desktop*.iso" "https://kubuntu.org/getkubuntu/" "casper" "Linux-ISOs" "https://www.kubuntu.org" "Kubuntu"
 !insertmacro SetISOFileNames "Lubuntu" "lubuntu*desktop*.iso" "https://lubuntu.net/downloads/" "casper" "Linux-ISOs" "https://lubuntu.net" "Lubuntu" 
 !insertmacro SetISOFileNames "Xubuntu" "xubuntu*desktop*.iso" "http://cdimage.ubuntu.com/xubuntu/releases/18.04/release/" "casper" "Linux-ISOs" "https://xubuntu.org" "Xubuntu"
 !insertmacro SetISOFileNames "Ubuntu Budgie" "ubuntu-budgie*desktop*.iso" "https://ubuntubudgie.org/downloads" "casper" "Linux-ISOs" "https://ubuntubudgie.org/" "Ubuntu Budgie" 
 !insertmacro SetISOFileNames "Ubuntu Gnome" "ubuntu-gnome*desktop*.iso" "https://wiki.ubuntu.com/UbuntuGNOME/GetUbuntuGNOME/LTS#Standard_PC" "casper" "Linux-ISOs" "https://www.ubuntugnome.org" "Ubuntu Gnome"
 !insertmacro SetISOFileNames "Ubuntu Server" "ubuntu*server*.iso" "https://www.ubuntu.com/download/server" "NULL" "Linux-ISOs" "https://www.ubuntu.com/server" "Ubuntu Server"
 !insertmacro SetISOFileNames "Ubuntu Studio" "ubuntustudio*.iso" "http://cdimage.ubuntu.com/ubuntustudio/releases/18.04/release/" "casper" "Linux-ISOs" "https://ubuntustudio.org" "Ubuntu Studio" 
 !insertmacro SetISOFileNames "Emmabuntus" "emmabuntus*.iso" "https://sourceforge.net/projects/emmabuntus/files/latest/download" "NULL" "Linux-ISOs" "https://sourceforge.net/projects/emmabuntus/" "Emmabuntus" 

     !insertmacro SetISOFileNames "" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "--- Linux Mint 32/64 Bit ---" "" "" "" "" "" ""
	 !insertmacro SetISOFileNames "" "" "" "" "" "" ""  
   
 !insertmacro SetISOFileNames "Linux Mint" "linuxmint*.iso" "https://www.linuxmint.com/download.php" "casper" "Linux-ISOs" "https://www.linuxmint.com" "Linux Mint"
 !insertmacro SetISOFileNames "Linux Mint Debian" "lmde*.iso" "https://www.linuxmint.com/download_lmde.php" "casper" "Linux-ISOs" "https://www.linuxmint.com" "Linux Mint"

     !insertmacro SetISOFileNames "" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "--- CentOS 32/64 Bit ---" "" "" "" "" "" ""
	 !insertmacro SetISOFileNames "" "" "" "" "" "" ""

 !insertmacro SetISOFileNames "CentOS Live" "CentOS*LIVE*.iso" "https://mirrors.oit.uci.edu/centos/7.8.2003/isos/x86_64/CentOS-7-x86_64-LiveGNOME-2003.iso" "NULL" "Linux-ISOs" "https://www.centos.org" "CentOS"
 !insertmacro SetISOFileNames "CentOS Minimal" "CentOS*Minimal*.iso" "https://mirrors.mit.edu/centos/8/isos/x86_64/CentOS-8.3.2011-x86_64-boot.iso" "NULL" "Linux-ISOs" "https://www.centos.org" "CentOS"

     !insertmacro SetISOFileNames "" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "--- Debian Live 32/64 Bit ---" "" "" "" "" "" ""
	 !insertmacro SetISOFileNames "" "" "" "" "" "" ""
	 
 !insertmacro SetISOFileNames "Debian Live" "debian-live*.iso" "hhttps://cdimage.debian.org/cdimage/release/current-live/amd64/iso-hybrid/" "NULL" "Linux-ISOs" "https://www.debian.org" "Debian Live"

     !insertmacro SetISOFileNames "" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "--- Fedora 32/64 Bit ---" "" "" "" "" "" ""
	 !insertmacro SetISOFileNames "" "" "" "" "" "" ""
 
 !insertmacro SetISOFileNames "Fedora" "Fedora*Live*.iso" "https://getfedora.org/en/workstation/download/" "NULL" "Linux-ISOs" "https://fedoraproject.org" "Fedora"	 

     !insertmacro SetISOFileNames "" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "--- OpenSUSE ---" "" "" "" "" "" ""
	 !insertmacro SetISOFileNames "" "" "" "" "" "" ""  

 !insertmacro SetISOFileNames "OpenSUSE" "openSUSE*.iso" "http://linuxfreedom.com/opensuse/distribution/13.2/iso/openSUSE-13.2-GNOME-Live-x86_64.iso" "NULL" "Linux-ISOs" "https://software.opensuse.org" "OpenSUSE"	 

     !insertmacro SetISOFileNames "" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "--- Puppy Linux Based ---" "" "" "" "" "" ""
	 !insertmacro SetISOFileNames "" "" "" "" "" "" ""  
	 
 !insertmacro SetISOFileNames "Puppy Linux" "*pup*.iso" "http://distro.ibiblio.org/puppylinux/puppy-fossa/fossapup64-9.5.iso" "NULL" "Linux-ISOs" "puppylinux.com" "Puppy Linux" 	 
 !insertmacro SetISOFileNames "BionicPup" "bionicpup*.iso" "https://distro.ibiblio.org/puppylinux/puppy-bionic/" "NULL" "Linux-ISOs" "http://wikka.puppylinux.com/BionicPup" "Bionic Puppy 8"	
 !insertmacro SetISOFileNames "Tahrpup" "tahr*.iso" "https://distro.ibiblio.org/puppylinux/puppy-tahr/iso/tahrpup64-6.0.5/tahr64-6.0.5.iso" "NULL" "Linux-ISOs" "http://puppylinux.org/wikka/tahrpup" "Tahrpup"
 !insertmacro SetISOFileNames "Fatdog64" "Fatdog64*.iso" "https://distro.ibiblio.org/fatdog/iso/Fatdog64-702.iso" "NULL" "Linux-ISOs" "http://www.puppylinuxforum.org/thread-180.html" "Fatdog64"
 !insertmacro SetISOFileNames "Lucid Puppy Linux" "lupu*.iso" "https://distro.ibiblio.org/pub/linux/distributions/puppylinux/puppy-5.2.8/lupu-528.005.iso" "NULL" "Linux-ISOs" "http://www.puppylinux.org" "Puppy Linux"
 !insertmacro SetISOFileNames "Precise Puppy Linux" "precise*.iso" "https://distro.ibiblio.org/quirky/precise-5.7.1/precise-5.7.1.iso" "NULL" "Linux-ISOs" "http://bkhome.org/blog/?viewDetailed=03063" "Precise Puppy"
 !insertmacro SetISOFileNames "Puppy Arcade" "slacko_arcade*.iso" "https://archive.org/download/Puppy_Linux_Puppy_Arcade/slacko_arcade.iso" "NULL" "Linux-ISOs" "" ""	
 !insertmacro SetISOFileNames "Racy Puppy Linux" "racy*.iso" "https://distro.ibiblio.org/quirky/racy-5.5/racy-5.5.iso" "NULL" "Linux-ISOs" "http://puppylinux.org/main/New%20Racy%20Puppy.htm" "Racy Puppy Linux" 
 !insertmacro SetISOFileNames "Slacko Puppy" "slacko*uefi.iso" "https://distro.ibiblio.org/puppylinux/puppy-slacko-6.3.2/64/slacko64-6.3.2-uefi.iso" "NULL" "Linux-ISOs" "http://slacko.eezy.xyz/index.php" "Slacko Puppy" 

     !insertmacro SetISOFileNames "" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "--- Netbook Distributions 32/64 Bit---" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "" "" "" "" "" "" ""
	 
 !insertmacro SetISOFileNames "EasyPeasy (NetBook Distro)" "EasyPeasy*.iso" "https://sourceforge.net/projects/ubuntu-eee/files/EasyPeasy/EasyPeasy-1.6.iso/download" "NULL" "Netbook-ISOs" "https://sourceforge.net/projects/ubuntu-eee/" "EasyPeasy"
 !insertmacro SetISOFileNames "xPUD (Netbook Distro)" "openwebos*.iso" "https://ftp.ubuntu-tw.org/mirror/download.xpud.org/xpud-0.9.2.iso" "NULL" "Netbook-ISOs" "http://www.xpud.org" "xPud"

     !insertmacro SetISOFileNames "" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "--- Other Distros 32/64 Bit ---" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "" "" "" "" "" "" ""	 

 !insertmacro SetISOFileNames "Academix" "academix*.iso" "https://sourceforge.net/projects/academix/files/latest/download" "NULL" "Linux-ISOs" "https://academixproject.com/" "Academix"  
 !insertmacro SetISOFileNames "AntiX" "antiX*.iso" "https://sourceforge.net/projects/antix-linux/files/latest/download" "NULL" "Linux-ISOs" "http://sourceforge.net/projects/antix-linux/" "AntiX"   
 !insertmacro SetISOFileNames "Archbang" "archbang*.iso" "https://sourceforge.net/projects/archbang/files/ArchBang-OpenRC/archbang-openrc-rc-100816-x86_64.iso/download" "NULL" "Linux-ISOs" "https://sourceforge.net/projects/archbang/" "Archbang"  
 !insertmacro SetISOFileNames "Archlinux" "archlinux*.iso" "http://mirrors.us.kernel.org/archlinux/iso/latest/" "NULL" "Linux-ISOs" "https://www.archlinux.org" "Archlinux"  
 !insertmacro SetISOFileNames "Bluestar Linux" "bluestar*.iso" "https://sourceforge.net/projects/bluestarlinux/files/latest/download" "NULL" "Linux-ISOs" "https://sourceforge.net/projects/bluestarlinux/" "Bluestar" 
 !insertmacro SetISOFileNames "Bodhi" "bodhi*.iso" "https://sourceforge.net/projects/bodhilinux/files/3.2.1/bodhi-3.2.1-64.iso/download" "NULL" "Linux-ISOs" "http://www.bodhilinux.com" "Bodhi"  
 !insertmacro SetISOFileNames "CAELinux (Computer Aided Engineering)" "caelinux*.iso" "https://sourceforge.net/projects/caelinux/files/latest/download" "NULL" "Linux-ISOs" "http://caelinux.com/CMS/" "CAELinux"  
 !insertmacro SetISOFileNames "Calculate Linux Desktop" "cld*.iso" "http://mirror.umd.edu/calculate/release/15.17/cldx-15.17-x86_64.iso" "NULL" "Linux-ISOs" "http://www.calculate-linux.org/" "Calculate Linux"
; !insertmacro SetISOFileNames "Clear Linux" "clear*.iso" "https://clearlinux.org/downloads" "NULL" "Linux-ISOs" "https://clearlinux.org/" "Clear Linux" 
 !insertmacro SetISOFileNames "Cub Linux" "CubLinux*.iso" "https://sourceforge.net/projects/cublinux/files/latest/download" "casper" "Linux-ISOs" "https://sourceforge.net/projects/cublinux/" "CubLinux" 
 !insertmacro SetISOFileNames "Deepin" "deepin*.iso" "https://sourceforge.net/projects/deepin/files/latest/download" "NULL" "Linux-ISOs" "https://www.deepin.org/en/" "Deepin"
 !insertmacro SetISOFileNames "Damn Small Linux (DSL)" "dsl*initrd.iso" "http://www.damnsmalllinux.org/download.html" "NULL" "Linux-ISOs" "http://www.damnsmalllinux.org" "DSL"
 !insertmacro SetISOFileNames "Elementary OS" "elementaryos*.iso" "https://elementary.io/" "NULL" "Linux-ISOs" "https://elementary.io/" "Elementary OS"
 !insertmacro SetISOFileNames "Endeavour OS" "endeavour*.iso" "https://endeavouros.com/latest-release/" "NULL" "Linux-ISOs" "https://endeavouros.com/" "Endeavour OS"
 !insertmacro SetISOFileNames "Feren OS" "Feren*.iso" "https://sourceforge.net/projects/ferenoslinux/files/latest/download" "casper" "Linux-ISOs" "https://ferenos.weebly.com/get-feren-os.html" "Feren OS"
 !insertmacro SetISOFileNames "Fuduntu" "Fuduntu*.iso" "https://sourceforge.net/projects/fuduntu/files/latest/download" "NULL" "Linux-ISOs" "http://www.fuduntu.org/" "Fuduntu"
 !insertmacro SetISOFileNames "JustBrowsing" "justbrowsing64*.iso" "https://sourceforge.net/projects/justbrowsing/files/64bit/justbrowsing64_20140808.iso/download" "NULL" "Linux-ISOs" "http://justbrowsing.info/" "JustBrowsing"
 !insertmacro SetISOFileNames "KDE Neon" "neon*.iso" "https://neon.kde.org/download" "casper" "Linux-ISOs" "https://neon.kde.org/" "KDE Neon"
 !insertmacro SetISOFileNames "KNOPPIX" "KNOPPIX*.iso" "http://ftp.knoppix.nl/os/Linux/distr/knoppix/KNOPPIX_V7.2.0CD-2013-06-16-EN.iso" "NULL" "Linux-ISOs" "https://knopper.net" "KNOPPIX"
 !insertmacro SetISOFileNames "KXStudio" "KXStudio*.iso" "http://sourceforge.net/projects/kxstudio/files/latest/download" "NULL" "Linux-ISOs" "http://kxstudio.sourceforge.net" "KXStudio"
 !insertmacro SetISOFileNames "Linux Arcade" "Linux-Arcade*.iso" "https://sourceforge.net/projects/linux-arcade/files/64%20bits/Linux-Arcade-2.1-64-bits.iso/download" "NULL" "Linux-ISOs" "https://linuxarcade.com.br/page6.html" "LinuxArcade"   
 !insertmacro SetISOFileNames "LinuxFX" "linuxfx*.iso" "https://sourceforge.net/projects/linuxfxdevil/files/latest/download" "casper" "Linux-ISOs" "https://www.linuxfx.org/" "LinuxFX"
 !insertmacro SetISOFileNames "Linux Lite" "linux-lite*.iso" "https://sourceforge.net/projects/linuxlite/files/latest/download" "NULL" "Linux-ISOs" "https://www.linuxliteos.com/" "Linux Lite"
 !insertmacro SetISOFileNames "Linux Kid X" "linuxKidX*.iso" "http://sourceforge.net/projects/linuxkidx/" "NULL" "Linux-ISOs" "http://sourceforge.net/projects/linuxkidx/files/latest/download" "Linux Kid X" 
 ;BROKEN !insertmacro SetISOFileNames "Linpus Lite" "linpus-Lite*.iso" "http://update10.linpus.com/Linpus/Linpus-image/Lite2.2/Linpus-Lite-2.2.1.0-x86_64-LiveCD-gdm.iso" "NULL" "Linux-ISOs" "http://www.linpus.com/products_linpuslite.html" "LinPus Lite"
 !insertmacro SetISOFileNames "LXLE Desktop" "lxle*.iso" "http://sourceforge.net/projects/lxle/files/latest/download?source=files" "casper" "Linux-ISOs" "http://lxle.net/" "LXLE Desktop" 
 !insertmacro SetISOFileNames "Mageia Live" "Mageia*Live*x86_64*.iso" "http://mirrors.kernel.org/mageia/iso/7.1/Mageia-7.1-Live-GNOME-x86_64/Mageia-7.1-Live-GNOME-x86_64.iso" "NULL" "Linux-ISOs" "http://www.mageia.org" "Mageia"
 !insertmacro SetISOFileNames "OpenMandriva" "openMandriva*.iso" "https://sourceforge.net/projects/openmandriva/files/latest/download" "NULL" "Linux-ISOs" "https://www.openmandriva.org/" "OpenMandriva"	
 !insertmacro SetISOFileNames "Manjaro" "Manjaro*.iso" "https://manjaro.org/downloads/official/xfce/" "NULL" "Linux-ISOs" "http://manjaro.org" "Manjaro"
 !insertmacro SetISOFileNames "mintyMac" "minty*.iso" "http://sourceforge.net/projects/mintymacpremium/files/latest/download" "casper" "Linux-ISOs" "http://sourceforge.net/projects/mintymacpremium/" "MintyMac"
 !insertmacro SetISOFileNames "MX Linux" "MX*.iso" "https://sourceforge.net/projects/mx-linux/files/latest/download" "NULL" "Linux-ISOs" "https://mxlinux.org/" "MX Linux"   
 !insertmacro SetISOFileNames "Mythbuntu" "mythbuntu*.iso" "http://www.mythbuntu.org/downloads" "NULL" "Linux-ISOs" "http://mythbuntu.org/" "Mythbuntu"
 !insertmacro SetISOFileNames "Netrunner" "netrunner*.iso" "http://www.netrunner-os.com/download/" "NULL" "Linux-ISOs" "http://www.netrunner-os.com" "Netrunner"
 !insertmacro SetISOFileNames "OSGeo Live" "osgeo-live*.iso" "http://sourceforge.net/projects/osgeo-live/files/latest/download" "NULL" "Linux-ISOs" "http://live.osgeo.org" "OSGeo Live"
 !insertmacro SetISOFileNames "PCLinuxOS" "pclinuxos*.iso" "http://www.pclinuxos.com/?page_id=10" "NULL" "Linux-ISOs" "http://www.pclinuxos.com" "PCLinuxOS"
 !insertmacro SetISOFileNames "Peach OSI" "PeachOSI*.iso" "http://www.peachosi.com/Doors/DonateDownloadPageFluid.html" "casper" "Linux-ISOs" "http://www.peachosi.com" "Peach OSI"
 !insertmacro SetISOFileNames "Pear Linux" "pearlinux*.iso" "http://sourceforge.net/projects/pearoslinux/files/latest/download?source=recommended" "NULL" "Linux-ISOs" "http://sourceforge.net/projects/pearoslinux/" "Pear Linux"
 !insertmacro SetISOFileNames "Peppermint" "Peppermint*.iso" "http://peppermintos.com/guide/downloading/" "NULL" "Linux-ISOs" "http://peppermintos.com" "Peppermint"
 !insertmacro SetISOFileNames "Pinguy OS" "Pinguy*.iso" "http://sourceforge.net/projects/pinguy-os/files/latest/download" "NULL" "Linux-ISOs" "http://pinguy-os.sourceforge.net" "Pinguy" 
 !insertmacro SetISOFileNames "Porteus" "porteus*.iso" "http://www.ponce.cc/porteus/i486/current/" "NULL" "Linux-ISOs" "https://porteus.org/" "Porteus"
 !insertmacro SetISOFileNames "POP!_OS" "Pop*.iso" "https://system76.com/pop" "NULL" "Linux-ISOs" "https://system76.com/" "POP!_OS"
 !insertmacro SetISOFileNames "Samurai-WTF" "samurai-0.9.5.iso" "http://sourceforge.net/projects/samurai/files/samurai/samurai-0.9.5/samurai-0.9.5.iso/download" "NULL" "Linux-ISOs" "http://samurai.inguardians.com/" "Samurai"
 !insertmacro SetISOFileNames "Q4OS" "q4os*.iso" "https://sourceforge.net/projects/q4os/files/latest/download" "NULL" "Linux-ISOs" "https://q4os.org/index.html" "Q4OS" 
 !insertmacro SetISOFileNames "Raspberry Pi Desktop" "*rpd*.iso" "https://www.raspberrypi.org/downloads/raspberry-pi-desktop/" "NULL" "Linux-ISOs" "https://www.raspberrypi.org/downloads/raspberry-pi-desktop/" "Raspberry Pi"
 ;!insertmacro SetISOFileNames "RemixOS" "Remix_OS*.zip" "http://www.jide.com/remixos-for-pc#downloadNow" "NULL" "Linux-ISOs" "http://www.jide.com/remixos-for-pc" "RemixOS"
 !insertmacro SetISOFileNames "Skywave" "skywave*.iso" "https://sourceforge.net/projects/skywavelinux/files/latest/download" "casper" "Linux-ISOs" "http://skywavelinux.com/" "Skywave Linux"  
 !insertmacro SetISOFileNames "SLAX (Tiny Slackware Based Distro)" "slax*.iso" "http://www.slax.org/download.php" "NULL" "Linux-ISOs" "http://slax.org" "SLAX"
 !insertmacro SetISOFileNames "Slitaz (Another Tiny Distro)" "slitaz*.iso" "http://distro.ibiblio.org/slitaz/iso/5.0/" "NULL" "Linux-ISOs" "http://www.slitaz.org" "SliTaZ"
 !insertmacro SetISOFileNames "LuninuX OS" "LuninuxOS*Desktop*.iso" "http://sourceforge.net/projects/luninuxos/files/latest/download" "NULL" "Linux-ISOs" "http://luninuxos.com" "LuninuX OS" 
 !insertmacro SetISOFileNames "Solus" "Solus*.iso" "https://getsol.us/download/" "NULL" "Linux-ISOs" "https://getsol.us/home/" "Solus"
 !insertmacro SetISOFileNames "SolydX" "solydx*.iso" "http://solydxk.com/downloads/solydx/" "NULL" "Linux-ISOs" "http://solydxk.com" "SolydX Linux" 
 !insertmacro SetISOFileNames "Sparky Linux" "sparkylinux*.iso" "http://sourceforge.net/projects/sparkylinux/files/latest/download" "NULL" "Linux-ISOs" "http://sparkylinux.org" "Sparky Linux" 
 !insertmacro SetISOFileNames "Subgraph OS" "subgraph*.iso" "https://subgraph.com/sgos/download/index.en.html" "NULL" "Linux-ISOs" "https://subgraph.com" "Subgraph OS"
 !insertmacro SetISOFileNames "Sugar on a Stick" "Fedora-Live-SoaS*.iso" "http://dl.fedoraproject.org/pub/alt/releases/19/Spins/i386/Fedora-Live-SoaS-i686-19-1.iso" "NULL" "Linux-ISOs" "http://wiki.sugarlabs.org/go/Sugar_on_a_Stick" "Sugar On A Stick"
 !insertmacro SetISOFileNames "Terralinux" "Terra*.iso" "http://sourceforge.net/projects/terralinuxos/files/latest/download" "NULL" "Linux-ISOs" "http://terralinux.blogspot.com/" "Terralinux"
 !insertmacro SetISOFileNames "TinyCore (A Tiny Linux Distribution)" "tinycore*.iso" "http://distro.ibiblio.org/tinycorelinux/7.x/x86_64/release/TinyCorePure64-7.1.iso" "NULL" "Linux-ISOs" "http://www.tinycorelinux.com" "TinyCore"
 !insertmacro SetISOFileNames "Tuxtrans" "tuxtrans*.iso" "https://www.uibk.ac.at/tuxtrans/" "casper" "Linux-ISOs" "https://www.uibk.ac.at/tuxtrans/get.html" "Tuxtrans"
 !insertmacro SetISOFileNames "Uberstudent" "uberstudent*.iso" "https://sourceforge.net/projects/uberstudent/files/latest/download" "NULL" "Linux-ISOs" "http://uberstudent.com/" "Uberstudent"
 !insertmacro SetISOFileNames "Ultimate Edition" "ultimate-edition*.iso" "http://sourceforge.net/projects/ultimateedition/files/latest/download" "NULL" "Linux-ISOs" "http://ultimateedition.info" "Ultimate Edition"
 !insertmacro SetISOFileNames "WattOS" "wattOS*.iso" "http://www.cpufu.com/iso/wattOS-R9-Microwatt64.iso" "NULL" "Linux-ISOs" "http://www.planetwatt.com/" "wattOS" 
 !insertmacro SetISOFileNames "Web Converger (Web Kiosk)" "webc*.iso" "http://dl.webconverger.com/latest.iso" "NULL" "Linux-ISOs" "http://webconverger.com/" "Web Converger" 
 !insertmacro SetISOFileNames "XBMCbuntu" "xbmcbuntu*.iso" "http://mirrors.xbmc.org/releases/XBMCbuntu/" "NULL" "Linux-ISOs" "http://xbmc.org/" "XBMC" 
 !insertmacro SetISOFileNames "Xiaopan (Penetration Testing)" "Xiaopan*.iso" "https://sourceforge.net/projects/xiaopanos/files/latest/download" "NULL" "Linux-ISOs" "https://xiaopan.co" "Xiaopan" 
 !insertmacro SetISOFileNames "Zorin OS Core" "zorin*.iso" "https://zorinos.com/download/" "NULL" "Linux-ISOs" "https://zorin-os.com/" "Zorin OS"
 
     !insertmacro SetISOFileNames "" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "--- Anonymous Browsers ---" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "" "" "" "" "" "" ""
 
 !insertmacro SetISOFileNames "Kodachi (Anonymous Browsing)" "kodachi*.iso" "https://sourceforge.net/projects/linuxkodachi/files/latest/download" "NULL" "Anonymous-Browsers" "https://www.digi77.com/linux-kodachi/" "Kodachi"
 !insertmacro SetISOFileNames "Liberte (Anonymous Browsing)" "liberte*.iso" "https://sourceforge.net/projects/liberte/files/2012.3/liberte-2012.3.iso/download" "NULL" "Anonymous-Browsers" "http://dee.su/liberte" "Liberte" 
 ;!insertmacro SetISOFileNames "Tails (Anonymous Browsing)" "tails*.iso" "http://dl.amnesia.boum.org/tails/stable/" "NULL" "Anonymous-Browsers" "http://amnesia.boum.org" "Tails"
 
     !insertmacro SetISOFileNames "" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "--- Antivirus Tools ---" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "" "" "" "" "" "" ""
	 
 ;!insertmacro SetISOFileNames "Acronis Antimalware CD" "AcronisAntimalwareScanCD.iso" "http://download.acronis.com/iso/AcronisAntimalwareScanCD.iso" "NULL" "AntiVirus-Utilities" "http://kb.acronis.com/content/18647" "Acronis"
 !insertmacro SetISOFileNames "Antivirus Live CD (Virus Scanner)" "AntivirusLiveCD*.iso" "http://sourceforge.net/projects/antiviruslivecd/files/latest/download" "NULL" "AntiVirus-Utilities" "http://antiviruslivecd.4mlinux.com" "Antivirus Live CD"  
 !insertmacro SetISOFileNames "AOSS (Malware Scanner)" "AOSS.iso" "http://download.pctools.com/mirror/AOSS.iso" "NULL" "AntiVirus-Utilities" "http://www.pctools.com/aoss/" "AOSS"  
 !insertmacro SetISOFileNames "AVG Rescue CD (Antivirus Scanner)" "avg*.iso" "http://www.avg.com/us-en/download-file-cd-arl-iso" "NULL" "AntiVirus-Utilities" "http://www.avg.com" "AVG Rescue CD"
 !insertmacro SetISOFileNames "AVIRA AntiVir Rescue CD (Virus Scanner)" "*escue-system.iso" "https://www.avira.com/en/downloads#tab_a3_0" "NULL" "AntiVirus-Utilities" "http://www.avira.com" "Avira"
 !insertmacro SetISOFileNames "Bitdefender Rescue CD" "bitdefender-rescue-cd.iso" "http://download.bitdefender.com/rescue_cd/bitdefender-rescue-cd.iso" "NULL" "AntiVirus-Utilities" "http://bitdefender.com" "Bitdefender"
 !insertmacro SetISOFileNames "Comodo Rescue Disk (Antivirus Scanner)" "comodo_rescue_disk*.iso" "http://help.comodo.com/topic-170-1-493-5214-Downloading-Comodo-Rescue-Disk.html" "NULL" "AntiVirus-Utilities" "http://help.comodo.com/topic-170-1-493-5208-Introduction-to-Comodo-Rescue-Disk.html" "Comodo" 
 !insertmacro SetISOFileNames "Dr.Web LiveDisk" "drweb-livedisk*.iso" "http://download.geo.drweb.com/pub/drweb/livedisk/drweb-livedisk-900-cd.iso" "NULL" "AntiVirus-Utilities" "http://www.freedrweb.com/livecd/" "Dr.Web"  
 !insertmacro SetISOFileNames "Desinfec't 2013" "desinfect*.iso" "NONE" "NULL" "AntiVirus-Utilities" "" ""
 !insertmacro SetISOFileNames "ESET SysRescue Live" "eset*.iso" "https://www.eset.com/int/support/sysrescue/#download" "NULL" "AntiVirus-Utilities" "http://kb.eset.com/esetkb/index?page=content&id=SOLN3509" "ESET SysRecue Live" 
 !insertmacro SetISOFileNames "F-Secure Rescue CD" "rescue-cd*.iso" "https://download.f-secure.com/estore/rescue-cd-3.16-73600.iso" "NULL" "AntiVirus-Utilities" "http://www.f-secure.com/en_EMEA-Labs/security-threats/tools/rescue-cd/" "F-Secure Rescue CD"
 !insertmacro SetISOFileNames "GDATA Rescue CD" "G*.iso" "https://secure.gd/dl-int-bootcd" "NULL" "AntiVirus-Utilities" "https://www.gdatasoftware.com" "GDATA"
 !insertmacro SetISOFileNames "Kaspersky Rescue Disk (Antivirus Scanner)" "krd.iso" "https://rescuedisk.s.kaspersky-labs.com/updatable/2018/krd.iso" "NULL" "AntiVirus-Utilities" "http://support.kaspersky.com/viruses/rescuedisk" "Kaspersky"
 !insertmacro SetISOFileNames "Norton Bootable Recovery Tool" "nbrt*.iso" "https://us.norton.com/support/tools/nbrt.html" "NULL" "AntiVirus-Utilities" "https://us.norton.com/support/tools/nbrt.html" "Norton"
 !insertmacro SetISOFileNames "Panda SafeCD" "*afeCD.iso" "http://www.pandasecurity.com/resources/tools/SafeCD.iso" "NULL" "AntiVirus-Utilities" "http://www.pandasecurity.com/usa/homeusers/support/card?id=80152" "Panda Safe CD"
; REVISIT !insertmacro SetISOFileNames "Vba32 Rescue" "vbarescue.iso" "ftp://anti-virus.by/pub/vbarescue.iso" "NULL" "AntiVirus-Utilities" "http://www.anti-virus.by/en/vba32rescue.shtml" "Vba32 Rescue"
; REVISIT !insertmacro SetISOFileNames "Windows Defender Offline" "WDO_Media*.iso" "http://go.microsoft.com/fwlink/?LinkID=234123" "NULL" "AntiVirus-Utilities" "http://windows.microsoft.com/en-US/windows/what-is-windows-defender-offline" "Windows Defender"
 
     !insertmacro SetISOFileNames "" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "--- System Tools ---" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "" "" "" "" "" "" ""
	 
 !insertmacro SetISOFileNames "AEOMI Backupper" "amlnx*.iso" "https://www.backup-utility.com/download-iso.html" "NULL" "System-Tools" "https://www.backup-utility.com/" "AEOMI Backupper" 	 
 !insertmacro SetISOFileNames "Acronis True Image" "Acronis*.iso" "NONE" "NULL" "System-Tools" "http://www.acronis.com" "Acronis True-Image" 
 !insertmacro SetISOFileNames "BackBox (Penetration Testing)" "backbox*.iso" "http://backbox.mirror.garr.it/mirrors/backbox/backbox-4.5.1-i386.iso" "NULL" "System-Tools" "http://www.backbox.org/" "BackBox"
 ; OBSOLETE !insertmacro SetISOFileNames "BackTrack5 (Penetration Testing)" "BT5*.iso" "http://www.backtrack-linux.org/downloads/" "NULL" "System-Tools" "http://www.backtrack-linux.org" "Backtrack"
 !insertmacro SetISOFileNames "Bugtraq 2 (Penetration Testing)" "bugtraq-II_bw*.iso" "http://www.bugtraq-team.com:6014/isos/bugtraq-II_bw-u-gnome_x32.iso" "NULL" "System-Tools" "http://bugtraq-team.com" "Bugtraq II"
 !insertmacro SetISOFileNames "Boot Repair Disk 32bit" "boot-repair-disk-32bit.iso" "http://sourceforge.net/projects/boot-repair-cd/files/boot-repair-disk-32bit.iso/download" "NULL" "System-Tools" "http://sourceforge.net/projects/boot-repair-cd/" "Boot Repair Disk"
 !insertmacro SetISOFileNames "Boot Repair Disk 64bit" "boot-repair-disk-64bit.iso" "http://sourceforge.net/projects/boot-repair-cd/files/boot-repair-disk-64bit.iso/download" "NULL" "System-Tools" "http://sourceforge.net/projects/boot-repair-cd/" "Boot Repair Disk"
 !insertmacro SetISOFileNames "Caine (Forensics)" "caine*.iso" "http://caine.mirror.garr.it/mirrors/caine/caine7.0.iso" "NULL" "System-Tools" "http://www.caine-live.net/" "Caine" 
 !insertmacro SetISOFileNames "Clonezilla (Backup + Clone Tool)" "clonezilla*.iso" "http://sourceforge.net/projects/clonezilla/files/clonezilla_live_stable/2.4.2-10/clonezilla-live-2.4.2-10-i586.iso/download" "NULL" "System-Tools" "http://clonezilla.org" "Clonezilla"
 !insertmacro SetISOFileNames "Cyborg (Penetration Testing)" "cyborg*.iso" "http://cyborg.ztrela.com/download/" "NULL" "System-Tools" "http://cyborg.ztrela.com/" "Cyborg Linux" 
 !insertmacro SetISOFileNames "DBAN (Hard Drive Nuker)" "dban*.iso" "http://sourceforge.net/projects/dban/files/latest/download" "NULL" "System-Tools" "http://www.dban.org" "DBAN"
 !insertmacro SetISOFileNames "Demon Linux (Penetration Testing)" "demon*.iso" "https://demonlinux.com/download.php" "NULL" "System-Tools" "https://demonlinux.com/" "Demon Linux"
 !insertmacro SetISOFileNames "Deft (Forensics)" "deft*.iso" "http://www.deftlinux.net/download/" "NULL" "System-Tools" "http://www.deftlinux.net/" "Deft"
 !insertmacro SetISOFileNames "DRBL (Diskless Remote Boot in Linux)" "drbl-live*.iso" "http://sourceforge.net/projects/drbl/files/latest/download" "NULL" "System-Tools" "http://drbl.sourceforge.net" "DRBL"	 
 !insertmacro SetISOFileNames "EASEUS Disk Copy (Disk Cloning Tool)" "Disk*.iso" "http://download.easeus.com/free/EaseUS_DiskCopy_Home.exe" "NULL" "System-Tools" "http://www.easeus.com" "EASEUS Disk Copy"
 !insertmacro SetISOFileNames "Finnix x86/64- BIOS ONLY" "finnix*.iso" "https://www.finnix.org/Download" "NULL" "System-Tools" "https://www.finnix.org/" "Finnix"
 !insertmacro SetISOFileNames "FreeDOS (Balder img)" "balder10.img" "http://www.finnix.org/files/balder10.img" "NULL" "System-Tools" "http://www.finnix.org/Balder" "Finnix Balder"
 !insertmacro SetISOFileNames "G4L (Ghost For Linux)" "g4l*.iso" "http://sourceforge.net/projects/g4l/files/latest/download" "NULL" "System-Tools" "http://sourceforge.net/projects/g4l/" "G4L"
 !insertmacro SetISOFileNames "GParted (Partition Tools)" "gparted-live*.iso" "http://sourceforge.net/projects/gparted/files/latest" "NULL" "System-Tools" "http://gparted.sourceforge.net" "gParted"
 !insertmacro SetISOFileNames "GRML (system rescue)" "grml*.iso" "http://download.grml.org/grml64-full_2014.11.iso" "NULL" "System-Tools" "http://grml.org" "GRML"
; REVISIT !insertmacro SetISOFileNames "HDT (Hardware Detection Tool)" "hdt-0.5.2.img" "http://www.hdt-project.org/raw-attachment/wiki/hdt-0.5.0/hdt-0.5.2.img" "NULL" "System-Tools" "http://hdt-project.org" "HDT" 
 !insertmacro SetISOFileNames "Kali (Penetration Testing)" "kali*.iso" "http://www.kali.org/downloads/" "NULL" "System-Tools" "http://www.kali.org/" "Kali"
 ; REVISIT unzip !insertmacro SetISOFileNames "Memtest86 (Memory Testing Tool)" "memtest86-usb.zip" "https://www.memtest86.com/download.htm" "NULL" "System-Tools" "https://www.memtest86.com/" "Memtest86" 
 ; REVISIT unzip !insertmacro SetISOFileNames "Memtest86+ (Memory Testing Tool) BIOS ONLY" "memtest86+-5.01.zip" "http://www.memtest.org/download/5.01/memtest86+-5.01.zip" "NULL" "System-Tools" "http://www.memtest.org" "Memtest86+" 
 !insertmacro SetISOFileNames "Matriux (Penetration Testing)" "Matriux*.iso" "http://sourceforge.net/projects/matriux/files/latest/download" "NULL" "System-Tools" "http://www.matriux.com" "Matriux"
; REVISIT !insertmacro SetISOFileNames "Offline NT Password & Registry Editor" "usb*.zip" "http://pogostick.net/~pnh/ntpasswd/usb140201.zip" "NULL" "System-Tools" "https://pogostick.net/~pnh/ntpasswd/" "Offline NT"
; REVISIT !insertmacro SetISOFileNames "OpenMediaVault" "openmediavault*.iso" "http://sourceforge.net/projects/openmediavault/files/0.5.0.24/" "NULL" "System-Tools" "http://www.openmediavault.org/" "OpenMediaVault"
; !insertmacro SetISOFileNames "Ophcrack (no tables)" "ophcrack-notables-livecd-3.6.0.iso" "http://sourceforge.net/projects/ophcrack/files/ophcrack-livecd/3.6.0/ophcrack-notables-livecd-3.6.0.iso/download" "NULL" "System-Tools" "http://ophcrack.sourceforge.net" "Ophcrack"
; !insertmacro SetISOFileNames "Ophcrack XP (Password Finder)" "ophcrack-xp-livecd-3.6.0.iso" "http://downloads.sourceforge.net/ophcrack/ophcrack-xp-livecd-3.6.0.iso" "NULL" "System-Tools" "http://ophcrack.sourceforge.net" "Ophcrack"
; !insertmacro SetISOFileNames "Ophcrack Vista/7 (Password Finder)" "ophcrack-vista-livecd-3.6.0.iso" "http://downloads.sourceforge.net/ophcrack/ophcrack-vista-livecd-3.6.0.iso" "NULL" "System-Tools" "http://ophcrack.sourceforge.net" "Ophcrack"
 !insertmacro SetISOFileNames "Ophcrack (Password Finder)" "ophcrack*.iso" "https://sourceforge.net/projects/ophcrack/files/ophcrack-livecd/3.6.0/" "NULL" "System-Tools" "http://ophcrack.sourceforge.net" "Ophcrack"
 !insertmacro SetISOFileNames "Parted Magic (Partition Tools)" "*magic*.iso" "NONE" "NULL" "System-Tools" "http://partedmagic.com" "Parted Magic"
 !insertmacro SetISOFileNames "Partition Wizard (Partition Tools)" "pwfree*.iso" "http://www.minitool.com/C3883AF0-D8F8-4CAB-83D8-DA6497F1C8CC/pwfree9.iso" "NULL" "System-Tools" "http://www.partitionwizard.com" "Partition Wizard"
; !insertmacro SetISOFileNames "PING (Partimg Is Not Ghost)" "PING*.iso" "http://ping.windowsdream.com/ping/Releases/3.02/PING-3.02.iso" "NULL" "System-Tools" "http://ping.windowsdream.com" "PING"
 !insertmacro SetISOFileNames "Rescatux" "rescatux*.iso" "https://sourceforge.net/projects/rescatux/files/latest/download" "NULL" "System-Tools" "https://www.supergrubdisk.org/rescatux/" "Rescatux" 
 !insertmacro SetISOFileNames "Rescuezilla (Backup + Clone Tool)" "rescuezilla*.iso" "https://rescuezilla.com/download.html" "NULL" "System-Tools" "https://rescuezilla.com" "Rescuezilla" 
 !insertmacro SetISOFileNames "Redo Backup And Recovery (Recovery Tools)" "redobackup-livecd*.iso" "https://sourceforge.net/projects/redobackup/files/latest/download" "NULL" "System-Tools" "https://sourceforge.net/projects/redobackup/" "RedoBackup"
 !insertmacro SetISOFileNames "REMnux (Reverse Engineer Malware)" "remnux*.iso" "https://sourceforge.net/projects/remnux/files/version5/remnux-5.0-live-cd.iso/download" "NULL" "System-Tools" "http://zeltser.com/remnux/" "Remnux"
 !insertmacro SetISOFileNames "Rip Linux (Recovery Distro) - BIOS ONLY" "RIPLinuX*.iso" "http://sourceforge.net/projects/riplinuxmeta4s/files/latest/download" "NULL" "System-Tools" "http://www.tux.org/pub/people/kent-robotti/looplinux/rip/" "RIP Linux"
 !insertmacro SetISOFileNames "System Rescue CD" "systemrescuecd*.iso" "http://sourceforge.net/projects/systemrescuecd/files/latest/download" "NULL" "System-Tools" "http://www.sysresccd.org" "System Rescue"
 !insertmacro SetISOFileNames "Trinity Rescue Kit - BIOS ONLY" "trinity-rescue-kit*.iso" "ftp://ftp.osuosl.org/pub/trk/trinity-rescue-kit.3.4-build-372.iso" "NULL" "System-Tools" "http://trinityhome.org" "TRK"
 !insertmacro SetISOFileNames "Ultimate Boot CD (Diagnostics Tools) - BIOS ONLY" "ubcd5*.iso" "http://www.ultimatebootcd.com/download/redirect.php" "NULL" "System-Tools" "http://www.ultimatebootcd.com" "Ultimate Boot CD"
 !insertmacro SetISOFileNames "Wifislax (Wireless Penetration Testing)" "wifislax-4*.iso" "http://www.wifislax.com/" "NULL" "System-Tools" "http://www.wifislax.com/" "Wifislax"

     !insertmacro SetISOFileNames "" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "--- Windows Installers ---" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "" "" "" "" "" "" ""

 !insertmacro SetISOFileNames "Windows 10 Installer" "*.iso" "https://www.microsoft.com/en-us/software-download/windows10" "NULL" "Windows-Installers" "https://www.microsoft.com" "Windows 10" 
 !insertmacro SetISOFileNames "Windows Vista/7/8 Installer" "*.iso" "NONE" "NULL" "Windows-Installers" "" "" 
 !insertmacro SetISOFileNames "Windows XP Installer" "*.iso" "NONE" "NULL" "Windows-Installers" "" ""  
 
     !insertmacro SetISOFileNames "" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "--- Windows PE ---" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "" "" "" "" "" "" "" 
 
 !insertmacro SetISOFileNames "Hiren's BootCD PE" "HBCD*.iso" "https://www.hirensbootcd.org/download/" "NULL" "Windows-PE" "https://www.hirensbootcd.org/" "Hiren's BootCD PE"
 !insertmacro SetISOFileNames "Sergei Strelec WinPE" "WinPE*.iso" "" "NULL" "Windows-PE" "https://sergeistrelec.ru/" "Sergei Strelec WinPE"
 !insertmacro SetISOFileNames "Other Windows PE ISO" "*.iso" "" "NULL" "Windows-PE" "" "" 

     !insertmacro SetISOFileNames "" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "--- Other OS/Tools ---" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "" "" "" "" "" "" ""
	 
 !insertmacro SetISOFileNames "Falcon 4 Boot CD - BIOS ONLY" "F4UBCD*.iso" "NONE" "NULL" "Other-Tools" "" ""
 !insertmacro SetISOFileNames "Hiren's Boot CD - BIOS ONLY" "Hiren*.iso" "NONE" "NULL" "Other-Tools" "" ""
 
      !insertmacro SetISOFileNames "" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "--- Unlisted Bootable ISOs ---" "" "" "" "" "" ""
     !insertmacro SetISOFileNames "" "" "" "" "" "" "" 	

 !insertmacro SetISOFileNames "Try an Unlisted ISO" "*.iso" "NONE" "NULL" "Unlisted ISOs" "" "" 
 
FunctionEnd