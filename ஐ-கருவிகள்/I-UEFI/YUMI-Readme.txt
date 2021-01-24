YUMI UEFI (Your Universal Multiboot Integrator) ©2021 https://www.pendrivelinux.com (covered under GNU GPL License) - see YUMI-Copying

Background of YUMI:

YUMI is an easy to use Multiboot script created using NSIS. YUMI's purpose is to help automate the creation of a bootable USB Flash Drive that can be used to boot multiple Linux based distributions (one at a time).
The end result should be a bootable USB Flash drive that will get you up and running with your chosen Live Distributions, all without having to do the research and perform the steps by hand. 

How YUMI Works:

YUMI currently utilizes GRUB2 for Legacy BIOS and UEFI booting. Distribution ISO files are copied directly or extracted using 7zip to the multiboot folder on the USB device. Configuration files are used to house the menus used to boot each distribution. 

Credits, Resources, and Third Party Tools used:

* Remnants of Cedric Tissieres's Tazusb.exe for Slitaz (slitaz@objectif-securite.ch) may reside in the YUMI script, as it was derived from UUI, which was originally inspired by Tazusb.exe. 
* Created with NSIS Installer © Contributors http://nsis.sourceforge.net (needed to compile the YUMI.nsi script) - http://nsis.sourceforge.net/License
* A1ive's modified version of GRUB2 © A1ive https://github.com/a1ive/grub (unmodified binaries used)
* Grub4Dos © Chenall https://github.com/chenall/grub4dos (unmodified binary used)
* 7-Zip is © Igor Pavlovis http://7-zip.org (unmodified binaries used)
* Fat32format.exe © Tom Thornhill Ridgecorp Consultants http://www.ridgecrop.demon.co.uk (unmodified binary used)
* Tuffy Font © Thatcher Ulrich http://tulrich.com/fonts/ (unmodified binary used)

Additional instructions and information for YUMI can be found HERE: https://www.pendrivelinux.com/yumi-multiboot-usb-creator/

Changelog:

01/19/21 Version 0.0.3.4: Updated to allow Unlisted ISOs. Switch to use diskpart for single partition creation, then fat32 format.
01/11/21 Version 0.0.3.3: Updated to use Grub2 MBR instead of chainloading from Syslinux. Add additional checkpoints.
11/26/20 Version 0.0.3.2: Updated to create an Ubuntu/Linux-Mint persistence casper-rw/writable file/label based on the ISO name. Supports persistent feature for Linux Mint/Ubuntu version 16 through 20+. Added feature to check for Legacy YUMI.
11/19/20 Version 0.0.3.1: Switched to use Fat32Format on volume drive letter only.
11/18/20 Version 0.0.3.0: Updated to use loopback method for Rescatux. Set to use Windows Diskpart with Fat32Format.
11/15/20 Version 0.0.2.9: Update to detect exFAT format type and suggest reformat as Fat32 before proceeding. Otherwise syslinux can't install.
10/04/20 Version 0.0.2.8: Update to support Puppy Linux 9.5 (Fossapup64), Fix broken CentOS 7 Live link.
09/01/20 Version 0.0.2.7: Update to support KDE Neon, and newer Ubuntu Server 18.04 + 20.04
08/05/20 Version 0.0.2.6: Update to support Endeavour OS, Bluestar, and Cublinux. Fix broken links for EasyPeasy, Avira Rescue CD, and Xpud. 
07/26/20 Version 0.0.2.5: Update to support LinuxFX.
07/17/20 Version 0.0.2.4: Add support for Ubuntu's new "writable" casper persistence file label.
06/29/20 Version 0.0.2.3: Update to support Rescuezilla, Q4OS, and POP!OS.
04/29/20 Version 0.0.2.2: Update to support Solus, Feren OS, and Hiren's BootCD PE.
03/16/20 Version 0.0.2.1: Update to support Linux Mint Debian Edition, Manjaro 19.0x, and newer ESET Sysrescue CD.
11/05/19 Version 0.0.2.0: Update to support Acedemix and Finnix x86/64. Force Clonezilla to boot from RAM.
10/20/19 Version 0.0.1.9: Update to support Tuxtrans, newer KNOPPIX, GData, G4L, and ArchLinux.
10/08/19 Version 0.0.1.8: Added Persistence % progress bar. Update to support Demon Linux, and Open Mandriva.
10/07/19 Version 0.0.1.7: Update to support Ubuntu Budgie and Deepin. Fix various download links.
05/30/19 Version 0.0.1.6: Update to support newer Dr.Web and Kaspersky Rescue Disk and OpenSuse Leap. Add support for BionicPup, MX Linux, and Emmabuntus.
04/28/19 Version 0.0.1.5: Quick fix to support newer Parted Magic 2019.
04/27/19 Version 0.0.1.4: Update to support Manjaro 18.04, System Rescue Cd 6.0.3. Added support for Raspberry Pi Desktop.
02/14/19 Version 0.0.1.3: Update to support Kodachi and Memtest86. Implement 7zip version 18.6. Fix broken Redo Backup homepage link. Add Anonymous Browsers section. Add Home, FAQ and Support links.
01/06/19 Version 0.0.1.2: Fix to remove duplicate Linux Distributions Menu entry. Change Grub 2 to set root by --label MULTIBOOT. Revert to set gfxmode=640x480 as auto still creates issues.
01/05/19 Version 0.0.1.1: Update to support Acronis True Image 2019. Make Memtest 86+ option only appear for BIOS boot. Change to set gfxmode=auto
12/27/18 Version 0.0.1.0: Fix case in configfile path (change from EFI/boot to EFI/BOOT) in boot/grub/grub.cfg. Update to use GRUB 2.03.
11/04/18 Version 0.0.0.9: Update to support newer Ubuntu and derivitives using initrd instead of initrd.lz,.gz, etc.
04/26/18 Version 0.0.0.8: Fix broken links.
03/10/18 Version 0.0.0.7: Update to support UEFI 32 bit firmware. Update to support newer Debian Live, and Fedora Workstation Live. 
12/10/17 Version 0.0.0.6: Update to support AEOMI Backupper. Fix broken Tails.
10/06/17 Version 0.0.0.5: Update to support newer Tails and Manjaro. Fix broken Debian, Lubuntu, and Xubuntu links. Replace empty spaces in copied ISO files with dashes.
01/19/17 Version 0.0.0.4: Fix to replace empty spaces in Distro filename with dashes. Fix to display only FDD+HDD. Correct some wording.
08/19/16 Version 0.0.0.3: Add support for Arch Bang, Skywave Linux, and Cyborg Linux.
07/28/16 Version 0.0.0.2: Fix entry for Slacko Puppy UEFI
06/28/16 Version 0.0.0.1: Initial Release.