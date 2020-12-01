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
 * along with YUMI.  If not, see <http://www.gnu.org/licenses/>.
 */

; ------------ Install Distros Macro -------------- 

; !include ReplaceInFile.nsh
Function FindConfig ; Set config path and file
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\liberte\boot\syslinux\syslinux.cfg" ; Liberte
	  StrCpy $ConfigPath "liberte/boot/syslinux"
	  StrCpy $CopyPath "liberte\boot\syslinux"
	  StrCpy $ConfigFile "syslinux.cfg"    
	  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\i386\loader\isolinux.cfg" ; OpenSuse based 32bit
	  StrCpy $ConfigPath "boot/i386/loader"
	  StrCpy $CopyPath "boot\i386\loader"
	  StrCpy $ConfigFile "isolinux.cfg" 
	  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\x86_64\loader\isolinux.cfg" ; OpenSuse based 32bit
	  StrCpy $ConfigPath "boot/x86_64/loader"
	  StrCpy $CopyPath "boot\x86_64\loader"
	  StrCpy $ConfigFile "isolinux.cfg"   
	  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg"    
	  StrCpy $ConfigPath "syslinux"
	  StrCpy $CopyPath "syslinux"
	  StrCpy $ConfigFile "syslinux.cfg"  
	  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" 
	  StrCpy $ConfigPath "isolinux"
	  StrCpy $CopyPath "isolinux"
	  StrCpy $ConfigFile "isolinux.cfg" 
	  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\syslinux.cfg"  ; AVG
	  StrCpy $ConfigPath "isolinux"
	  StrCpy $CopyPath "isolinux"
	  StrCpy $ConfigFile "syslinux.cfg"   
	  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg"  ; Probably Ubuntu based
	  StrCpy $ConfigPath "isolinux"
	  StrCpy $CopyPath "isolinux"
	  StrCpy $ConfigFile "txt.cfg"
	  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\text.cfg"   ; Probably Ubuntu based
	  StrCpy $ConfigPath "isolinux"
	  StrCpy $CopyPath "isolinux"
	  StrCpy $ConfigFile "text.cfg"
	  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\syslinux\txt.cfg"   
	  StrCpy $ConfigPath "syslinux"
	  StrCpy $CopyPath "syslinux"
	  StrCpy $ConfigFile "txt.cfg"
	  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\syslinux\text.cfg"   
	  StrCpy $ConfigPath "syslinux"
	  StrCpy $CopyPath "syslinux"
	  StrCpy $ConfigFile "text.cfg"  
	  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\system\isolinux\isolinux.cfg"  ; AOSS
	  StrCpy $ConfigPath "system/isolinux"
	  StrCpy $CopyPath "system\isolinux"
	  StrCpy $ConfigFile "isolinux.cfg"    
	  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux.cfg"  ; Probably Puppy based 
	  StrCpy $ConfigPath ""
	  StrCpy $CopyPath ""
	  StrCpy $ConfigFile "isolinux.cfg"  
	  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\syslinux.cfg" 
	  StrCpy $ConfigPath ""
	  StrCpy $CopyPath ""
	  StrCpy $ConfigFile "syslinux.cfg"    
	  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\slax\boot\syslinux.cfg"  ; Slax based 
	  StrCpy $ConfigPath "slax/boot"
	  StrCpy $CopyPath "slax\boot"
	  StrCpy $ConfigFile "syslinux.cfg"    

	  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"     
	  StrCpy $ConfigPath "boot/syslinux"
	  StrCpy $CopyPath "boot\syslinux"
	  StrCpy $ConfigFile "syslinux.cfg"   
	  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg"
	  StrCpy $ConfigPath "boot/isolinux"
	  StrCpy $CopyPath "boot\isolinux"
	  StrCpy $ConfigFile "isolinux.cfg" 
	  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\isolinux\syslinux.cfg"     
	  StrCpy $ConfigPath "boot/isolinux"
	  StrCpy $CopyPath "boot\isolinux"
	  StrCpy $ConfigFile "syslinux.cfg"    
	  ${Else} 
	   StrCpy $ConfigFile "NULL"
  ${EndIf}   
  ;MessageBox MB_OK "$ConfigPath/$ConfigFile"   
FunctionEnd

Function OldSysFix ; fix to force use of new syslinux... 
 DetailPrint "Checking if we need to replace vesamenu.c32, menu.c32, and chain.c32, libutil.c32, libcom32.c32, memdisk"   
  !insertmacro CallFindFiles $BootDir\multiboot\$JustISOName chain.c32 CBFUNC
  !insertmacro CallFindFiles $BootDir\multiboot\$JustISOName vesamenu.c32 CBFUNC
  !insertmacro CallFindFiles $BootDir\multiboot\$JustISOName menu.c32 CBFUNC
  !insertmacro CallFindFiles $BootDir\multiboot\$JustISOName libutil.c32 CBFUNC  
  !insertmacro CallFindFiles $BootDir\multiboot\$JustISOName libcom32.c32 CBFUNC  
  !insertmacro CallFindFiles $BootDir\multiboot\$JustISOName memdisk CBFUNC 
  !insertmacro CallFindFiles $BootDir\multiboot\$JustISOName ifcpu64.c32 CBFUNC 
  !insertmacro CallFindFiles $BootDir\boot\isolinux menu.c32 CBFUNC  ; fix for distros like Dr.Web
FunctionEnd

Function SysFixHirens ; fix to force use of new syslinux... 
 DetailPrint "Checking if we need to replace vesamenu.c32, menu.c32, and chain.c32, libutil.c32, libcom32.c32, memdisk" 
; Replace for Hirens
  !insertmacro CallFindFiles $BootDir\HBCD\Boot chain.c32 CBFUNC
  !insertmacro CallFindFiles $BootDir\HBCD\Boot vesamenu.c32 CBFUNC
  !insertmacro CallFindFiles $BootDir\HBCD\Boot memdisk CBFUNC
FunctionEnd
  
Function WriteStuff
 ; Now done before this function is called (see line 122) CreateDirectory "$BootDir\multiboot\$JustISOName\YUMI\" ; Create the YUMI Directory.. so we can copy the following config file to it.
 CopyFiles "$PLUGINSDIR\$Config2Use" "$BootDir\multiboot\$JustISOName\YUMI\$Config2Use" ; Copy the $Config2Use file to $JustISOName\YUMI folder for the distro (so we know where to remove entry) 
 DetailPrint "$DistroName ($JustISOName) and its menu entry were added!"
 
; Failure to find ConfigFile and was not added as a GRUB Boot ISO, so Remove and Delete   
  ${If} $ConfigFile == "NULL" ; Isolinux/Syslinux config file doesn't exist!
	  ${AndIf} $Config2Use != "menu.lst" ; menu.lst = GRUB, so we shouldn't expect to find a syslinux config file!
		MessageBox MB_OK "YUMI couldn't find a configuration file.$\r$\n'$JustISO' not supported, please report the exact steps taken to arrive at this message!$\r$\nYUMI will now remove this entry."   
		${DeleteMenuEntry} "$BootDir\multiboot\menu\$Config2Use" "#start $JustISOName" "#end $JustISOName" ; Remove entry from config file... I.E. linux.cfg, system.cfg, etc
		StrCpy $DistroName "$JustISOName" ; So we can remove the following Installed.txt entry
		${LineFind} "$BootDir\multiboot\Installed.txt" "$BootDir\multiboot\Installed.txt" "1:-1" "DeleteInstall" ; Remove the Installed.txt entry
		${LineFind} "$BootDir\multiboot\Installed.txt" "$BootDir\multiboot\Installed.txt" "1:-1" "DeleteEmptyLine" ; Remove any left over empty lines from Installed.txt
		RMDir /R "$BootDir\multiboot\$JustISOName"  
		DetailPrint "$JustISOName and its menu entry were Removed!"  	
  ${EndIf}	
FunctionEnd

!macro Install_Distros 

; Initiate Plugins Directory for potential use
  SetShellVarContext all
  InitPluginsDir

; If distro is already installed, delete the entry, so we don't make a mess.
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\*.*"
	 ${DeleteMenuEntry} "$BootDir\multiboot\menu\$Config2Use" "#start $DistroName" "#end $DistroName" ; Remove entry from config file... I.E. linux.cfg, system.cfg, etc
 ${EndIf}
 
; Write $JustISOName to Installed.txt 
 ${InstalledList} "$JustISOName" $R0 ; Write the ISO name to the Installed List "Installed.txt" file (so we can keep track of installs for removal)
 ${LineFind} "$BootDir\multiboot\Installed.txt" "$BootDir\multiboot\Installed.txt" "1:-1" "DeleteEmptyLine" ; Remove any left over empty lines
 
; Create the Directory for this ISOs files
 CreateDirectory "$BootDir\multiboot\$JustISOName\YUMI\" ; Create the YUMI Directory.. so we can eventually copy the config file (see line 90) to it.

; Acronis True Image 
 ${If} $DistroName == "Acronis True Image"
		ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y'  
		File /oname=$PLUGINSDIR\acronisti.cfg "menu\acronisti.cfg"   
		CopyFiles "$PLUGINSDIR\acronisti.cfg" "$BootDir\multiboot\$JustISOName\acronisti.cfg"  
		${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nCONFIG /multiboot/$JustISOName/acronisti.cfg$\r$\nAPPEND /multiboot/$JustISOName$\r$\n#end $JustISOName" $R0 

 ; Calculate Linux Desktop
  ${ElseIf} $DistroName == "Calculate Linux Desktop"
		CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to ISO Directory
		ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -ir!*nitrd -ir!*mlinuz -o"$BootDir\multiboot\$JustISOName\" -y' 
		${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nLINUX /multiboot/$JustISOName/vmlinuz$\r$\nINITRD /multiboot/$JustISOName/initrd$\r$\nAPPEND root=live:LABEL=CLD-20151230 vga=current init=/linuxrc rd.live.squashimg=livecd.squashfs nodevfs noresume splash=silent,theme:calculate console=tty1 iso-scan/filename=/multiboot/$JustISOName/$JustISO$\r$\n#end $JustISOName" $R0 
 
 ; Linux Kid X
  ${ElseIf} $DistroName == "Linux Kid X" 
		ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y'  
  ${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nLINUX /multiboot/$JustISOName/boot/vmlinuz$\r$\nINITRD /multiboot/$JustISOName/boot/initrd.gz$\r$\nAPPEND from=/multiboot/$JustISOName vga=788 nocd max_loop=255 ramdisk_size=6666 root=/dev/ram0 rw $\r$\n#end $JustISOName" $R0      
 
		; Bitdefender
		; ${ElseIf} $DistroName == "Bitdefender Rescue CD"
		; ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y'  
		; ${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/$JustISOName/boot/kernel.i386-pc$\r$\nAPPEND initrd=/multiboot/$JustISOName/boot/initfs.i386-pc root=/dev/ram0 real_root=/dev/loop0 loop=/multiboot/$JustISOName/rescue/livecd.squashfs cdroot_marker=/multiboot/$JustISOName/rescue/livecd.squashfs initrd udev cdroot scandelay=10 quiet splash$\r$\n#end $JustISOName" $R0 
 
  ${ElseIf} $DistroName == "Bitdefender Rescue CD"
		CopyFiles $ISOFile "$BootDir\multiboot\ISOS\$JustISO" 
		${WriteToFile} "#start $JustISOName$\r$\nlabel Bitdefender ($JustISOName)$\r$\nMENU LABEL Bitdefender ($JustISOName)$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/menu/bitdefender.lst$\r$\n#end $JustISOName" $R0   
		File /oname=$PLUGINSDIR\bitdefender.lst "Menu\bitdefender.lst"  
		CopyFiles "$PLUGINSDIR\bitdefender.lst" "$BootDir\multiboot\menu\bitdefender.lst" 
		!insertmacro ReplaceInFile "SLUG" "$JustISO" "all" "all" "$BootDir\multiboot\menu\bitdefender.lst" 
 
  ${ElseIf} $DistroName == "CentOS Installer"
 	  ${OrIf} $DistroName == "Sergei Strelec"  
	  ${OrIf} $DistroName == "CentOS Live"
	  ${OrIf} $DistroName == "Deepin"
	  ${OrIf} $DistroName == "Debian Live"
	  ${OrIf} $DistroName == "Endeavour OS"  
	  ${OrIf} $DistroName == "Q4OS"
	  ${OrIf} $DistroName == "Rescuezilla (Backup + Clone Tool)"
	  ${OrIf} $DistroName == "LinuxFX" 
	  ;${OrIf} $DistroName == "Linux Mint"
	  ${OrIf} $DistroName == "Linux Mint Debian Edition"  
	  ${OrIf} $DistroName == "Slackel"
	  ${OrIf} $DistroName == "Antergos"
	  ${OrIf} $DistroName == "Archlinux"
	  ${OrIf} $DistroName == "Ubuntu Mini (installer)"
	  ${OrIf} $DistroName == "Wifislax (Wireless Penetration Testing)"
	  ${OrIf} $DistroName == "WifiWay (Wireless Penetration Testing)"
	  ${OrIf} $DistroName == "Pop!_OS"  
	  ${OrIf} $DistroName == "OSFClone (Disk Cloning Tool)"
	  ${OrIf} $DistroName == "NetRunner"
	  ${OrIf} $DistroName == "Ubuntu Mini (Netboot Installer)"
	  ${OrIf} $DistroName == "KaOS"
	  ${OrIf} $DistroName == "VyOS (Router OS)"
	  ${OrIf} $DistroName == "Raspberry Pi Desktop"
	  ${OrIf} $DistroName == "Fedora"  
	  ${OrIf} $DistroName == "Ultimate Boot CD (Diagnostics Tools)"    
	  ${OrIf} $DistroName == "GeckoLinux" 
	  ${OrIf} $DistroName == "Manjaro" 
	  ${OrIf} $DistroName == "OpenSUSE" 
	  ${OrIf} $DistroName == "Dr.Web LiveDisk" 
	  ${OrIf} $DistroName == "BionicPup" 
	  ${OrIf} $DistroName == "puppy Linux"  
	  ${OrIf} $DistroName == "Emmabuntus"    
	  ${OrIf} $DistroName == "Norton Bootable Recovery Tool" 
	  ${OrIf} $DistroName == "Quick Save Live (Recovery Tool)" 
	  ${OrIf} $DistroName == "Devuan" 
	  ${OrIf} $DistroName == "Vinari OS" 
	  ${OrIf} $DistroName == "Solus" 
	  ${OrIf} $DistroName == "Finnix" 
	  ${OrIf} $DistroName == "KDE Neon"   
	  ${OrIf} $DistroName == "Kaspersky Rescue Disk (Antivirus Scanner)" 
	  ${OrIf} $DistroName == "Kodachi (Anonymous Browsing)" 
	  ${OrIf} $DistroName == "System Rescue" 
	  ${OrIf} $DistroName == "OpenMandriva"   
	  ${OrIf} $DistroName == "Clonezilla (Backup + Clone Tool)"    
	  ${OrIf} $DistroName == "Parrot OS"
	  ${OrIf} $DistroName == "Clear Linux"
	  ${OrIf} $DistroName == "Alpine Linux"  
      ${OrIf} $DistroName == "Rescatux" 		  
  
	 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" 
	 ${WriteToFile} "#start $JustISOName$\r$\nlabel $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/$JustISOName/basic.lst$\r$\n#end $JustISOName" $R0   
	 File /oname=$PLUGINSDIR\basic.lst "Menu\basic.lst"  
	 CopyFiles "$PLUGINSDIR\basic.lst" "$BootDir\multiboot\$JustISOName\basic.lst" 
	 !insertmacro ReplaceInFile "SLUG" "$JustISO" "all" "all" "$BootDir\multiboot\$JustISOName\basic.lst" 
	 !insertmacro ReplaceInFile "IPATH" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\basic.lst"  
	 
  ${ElseIf} $DistroName == "Bluestar Linux"
	 StrCpy $JustISO "$JustISO" 14 ; Grabs the first 14 characters of the file name.
	 StrCpy $JustISOName "$JustISOName" 14 ; Grabs the first 14 characters of the file name.
	 StrCpy $JustISO "$JustISO.iso"
	 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" 
	 ${WriteToFile} "#start $JustISOName$\r$\nlabel $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/$JustISOName/$JustISOName.lst$\r$\n#end $JustISOName" $R0   
	 File /oname=$PLUGINSDIR\basic.lst "Menu\basic.lst"  
	 CopyFiles "$PLUGINSDIR\basic.lst" "$BootDir\multiboot\$JustISOName\$JustISOName.lst" 
	 !insertmacro ReplaceInFile "SLUG" "$JustISO" "all" "all" "$BootDir\multiboot\$JustISOName\$JustISOName.lst" 
	 !insertmacro ReplaceInFile "IPATH" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\$JustISOName.lst"   
 
  ${ElseIf} $DistroName == "HD Sentinel (HDD Diagnostics)"
	 ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -o"$BootDir\multiboot\$JustISOName\" -y' 
	 File /oname=$PLUGINSDIR\customram.lst "Menu\customram.lst" 
	 CopyFiles "$PLUGINSDIR\customram.lst" "$BootDir\multiboot\$JustISOName\customram.lst" 
	 ${WriteToFile} "#start $JustISOName$\r$\nlabel $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/$JustISOName/customram.lst$\r$\n#end $JustISOName" $R0   
	 !insertmacro ReplaceInFile "SLUG" "hdsdos.iso" "all" "all" "$BootDir\multiboot\$JustISOName\customram.lst" 
	 !insertmacro ReplaceInFile "IPATH" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\customram.lst"  

 
	; Dr.Web Live CD
	 ;${ElseIf} $DistroName == "Dr.Web LiveDisk"
	 ;ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\" -y'
	 ;Call OldSysFix  ; Check for and replace vesamenu.c32, menu.c32, chain.c32 if found 
	 ;${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nCONFIG /boot/isolinux/isolinux.cfg$\r$\nAPPEND /boot/isolinux$\r$\n#end $JustISOName" $R0 

	 ; Medicat (must use NTFS format)
  ${ElseIf} $DistroName == "Medicat (must use NTFS format)"
	 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\" -y'
	 ;Call OldSysFix  ; Check for and replace vesamenu.c32, menu.c32, chain.c32 if found 
	 ${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nCONFIG /isolinux.cfg$\r$\nAPPEND /$\r$\n#end $JustISOName" $R0
 
  ${ElseIf} $DistroName == "Ubuntu" 
     ${OrIf} $DistroName == "Ubuntu Studio"   
     ${OrIf} $DistroName == "Edubuntu" 
     ${OrIf} $DistroName == "Xubuntu" 
     ${OrIf} $DistroName == "Kubuntu" 
     ${OrIf} $DistroName == "Lubuntu" 
	 ${OrIf} $DistroName == "LinuxFX"
	 ${OrIf} $DistroName == "Ubuntu Budgie" 	
	 ${OrIf} $DistroName == "Ubuntu Mate" 
     ${OrIf} $DistroName == "Ubuntu Gnome" 	   
	 ${OrIf} $DistroName == "Linux Mint" 	   
	 ${OrIf} $DistroName == "ChaletOS" 
	 ${OrIf} $DistroName == "Cub Linux" 
	 ${OrIf} $DistroName == "LXLE Desktop" 
     ${OrIf} $DistroName == "mintyMac" 
	 ${OrIf} $DistroName == "Peach OSI" 
	 ${OrIf} $DistroName == "Skywave" 	 
	 ;${OrIf} $DistroName == "Debian Live"
   
		CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory
		ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -ir!vmlinu* -ir!init* -o"$BootDir\multiboot\$JustISOName\" -y'
		File /oname=$PLUGINSDIR\ubuntu.lst "Menu\ubuntu.lst"  
		CopyFiles "$PLUGINSDIR\ubuntu.lst" "$BootDir\multiboot\$JustISOName\ubuntu.lst"   
		${WriteToFile} "#start $JustISOName$\r$\nlabel $JustISOName$\r$\nmenu label $JustISOName$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/$JustISOName/ubuntu.lst$\r$\n#end $JustISOName" $R0   
 
		${If} $DistroName == "Ubuntu"
		${OrIf} $DistroName == "Cub Linux"
		!insertmacro ReplaceInFile "SLEED" "ubuntu.seed" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst"
		${ElseIf} $DistroName == "Edubuntu"
		!insertmacro ReplaceInFile "SLEED" "edubuntu.seed" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst"  
		${ElseIf} $DistroName == "Xubuntu"
		!insertmacro ReplaceInFile "SLEED" "xubuntu.seed" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst"  
		${ElseIf} $DistroName == "Kubuntu"
		!insertmacro ReplaceInFile "SLEED" "kubuntu.seed" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst" 
		${ElseIf} $DistroName == "Lubuntu"
		!insertmacro ReplaceInFile "SLEED" "lubuntu.seed" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst" 	
		${ElseIf} $DistroName == "Ubuntu Gnome"
		!insertmacro ReplaceInFile "SLEED" "ubuntu-gnome.seed" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst"	
		${ElseIf} $DistroName == "Ubuntu Mate"
		!insertmacro ReplaceInFile "SLEED" "ubuntu-mate.seed" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst"		
		${ElseIf} $DistroName == "Linux Mint"
		!insertmacro ReplaceInFile "SLEED" "linuxmint.seed" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst" 
		${ElseIf} $DistroName == "ChaletOS" 
		${OrIf} $DistroName == "Peach OSI"
		${OrIf} $DistroName == "LXLE Desktop"	
		!insertmacro ReplaceInFile "SLEED" "custom.seed" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst" 
		${Else}
		!insertmacro ReplaceInFile "SLEED" "custom.seed" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst" 
		${EndIf}
	
	  !insertmacro ReplaceInFile "SLUG" "$JustISO" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst"
	  !insertmacro ReplaceInFile "DLUG" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst" 
	  
	  ${If} $DistroName == "ChaletOS"   
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\vmlinuz.efi"
	   !insertmacro ReplaceInFile "/casper/VLUG" "/chaletos64bit/casper/vmlinuz.efi" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst" 
	   ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\vmlinuz"
	   !insertmacro ReplaceInFile "/casper/VLUG" "/chaletos64bit/casper/vmlinuz" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst"   
	   ${EndIf}  
  
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\initrd.lz"  
	   !insertmacro ReplaceInFile "/casper/ILUG" "/chaletos64bit/casper/initrd.lz" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst"
	   ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\initrd.gz"  
	   !insertmacro ReplaceInFile "/casper/ILUG" "/chaletos64bit/casper/initrd.gz" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst" 
	   ${EndIf} 

	  ${Else}
	  
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\vmlinuz.efi"
	   !insertmacro ReplaceInFile "VLUG" "vmlinuz.efi" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst" 
	   ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\vmlinuz"
	   !insertmacro ReplaceInFile "VLUG" "vmlinuz" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst"   
	   ${EndIf}  
  
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\initrd.lz"  
	   !insertmacro ReplaceInFile "ILUG" "initrd.lz" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst"
	   ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\initrd.gz"  
	   !insertmacro ReplaceInFile "ILUG" "initrd.gz" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst" 
	   ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\initrd"  
	   !insertmacro ReplaceInFile "ILUG" "initrd" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst"   
	   ${EndIf}  
	  ${EndIf}
   
	  ; Enable Persistence
	   ${If} $Persistence == "casper"
		${AndIf} $Casper != "0"  
		; Add Boot Code Persistent
		 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\ubuntu.lst" ; Rename the following
		 !insertmacro ReplaceInFile "noprompt boot=" "noprompt persistent persistent-path=/multiboot/$JustISOName boot=" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst" 
		 ;!insertmacro ReplaceInFile "#CLUG" "parttype (hd0,3) | set check=$\r$\nset check=%check:~-5,4%$\r$\nif $\"%check%$\"==$\"0x00$\" partnew (hd0,3) 0 0 0$\r$\nif NOT $\"%check%$\"==$\"0x00$\" echo ERROR: third partition table entry is not empty, please delete it if you wish to use this method && pause --wait=5 && configfile /multiboot/$JustISOName/ubuntu.lst$\r$\npartnew (hd0,3) 0x00 %CASPER%$\r$\nmap %CASPER% (hd0,3)" "all" "all" "$BootDir\multiboot\$JustISOName\ubuntu.lst"
		 ${EndIf} 
	   ${EndIf}    
 
	  ${If} $DistroName == "AVIRA AntiVir Rescue CD (Virus Scanner)"
	  ${OrIf} $DistroName == "Cub Linux"
		   CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory
		   ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -ir!*nitrd.* -ir!*mlinu* -o"$BootDir\multiboot\$JustISOName\" -y'  
		   Rename "$BootDir\multiboot\$JustISOName\initrd.gz" "$BootDir\multiboot\$JustISOName\initrd.lz" 
		   Rename "$BootDir\multiboot\$JustISOName\vmlinuz.efi" "$BootDir\multiboot\$JustISOName\vmlinuz" 
		   ${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/$JustISOName/vmlinuz$\r$\nAPPEND initrd=/multiboot/$JustISOName/initrd.lz cdrom-detect/try-usb=true persistent persistent-path=/multiboot/$JustISOName noprompt splash boot=casper iso-scan/filename=/multiboot/$JustISOName/$JustISO$\r$\n#end $JustISOName" $R0
	   ${EndIf}    
 
	 ; OpenSUSE 32bit 
	 ${ElseIf} $DistroName == "OpenSUSE 32bit"
	 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to ISO Directory
	 ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -ir!*nitrd -ir!*inux -o"$BootDir\multiboot\$JustISOName\" -y'  
	 ${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/$JustISOName/linux$\r$\nAPPEND initrd=/multiboot/$JustISOName/initrd ramdisk_size=512000 ramdisk_blocksize=4096 isofrom=/dev/disk/by-label/MULTIBOOT:/multiboot/$JustISOName/$JustISO isofrom_device=/dev/disk/by-label/MULTIBOOT isofrom_system=/multiboot/$JustISOName/$JustISO loader=syslinux$\r$\n#end $JustISOName" $R0
	 
	 ; OpenSUSE 64bit 
	 ${ElseIf} $DistroName == "OpenSUSE 64bit"
	 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to ISO Directory
	 ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -ir!*nitrd -ir!*inux -o"$BootDir\multiboot\$JustISOName\" -y'   
	 ${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/$JustISOName/linux$\r$\nAPPEND initrd=/multiboot/$JustISOName/initrd ramdisk_size=512000 ramdisk_blocksize=4096 isofrom=/dev/disk/by-label/MULTIBOOT:/multiboot/$JustISOName/$JustISO isofrom_device=/dev/disk/by-label/MULTIBOOT isofrom_system=/multiboot/$JustISOName/$JustISO loader=syslinux$\r$\n#end $JustISOName" $R0 

	 ; OpenMediaVault - NOT WORKING YET
	 ; ${ElseIf} $DistroName == "OpenMediaVault"
	 ; CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to ISO Directory
	 ; ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -ir!*nitrd -ir!*inux -o"$BootDir\multiboot\$JustISOName\" -y'  
	 ; ${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/$JustISOName/linux$\r$\nAPPEND initrd=/multiboot/$JustISOName/initrd ramdisk_size=512000 ramdisk_blocksize=4096 isofrom=/dev/disk/by-label/MULTIBOOT:/multiboot/$JustISOName/$JustISO isofrom_device=/dev/disk/by-label/MULTIBOOT isofrom_system=/multiboot/$JustISOName/$JustISO loader=syslinux$\r$\n#end $JustISOName" $R0 
	 
	 ; FreeDOS (Balder img) 
	 ${ElseIf} $DistroName == "FreeDOS (Balder img)"
	 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO"
	 ${WriteToFile} "#start $JustISOName$\r$\nLABEL FreeDOS ($JustISOName)$\r$\nMENU LABEL FreeDOS ($JustISOName)$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/memdisk$\r$\nAPPEND initrd=/multiboot/$JustISOName/$JustISO$\r$\n#end $JustISOName" $R0
	 
	 ; Memtest86+ (Memory Testing Tool)
	 ${ElseIf} $DistroName == "Memtest86+ (Memory Testing Tool)"
	 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y'  
	 ${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nLINUX /multiboot/$JustISOName/$JustISOName$\r$\n#end $JustISOName" $R0

	 ; Kon-Boot  
	 ${ElseIf} $DistroName == "Kon-Boot FREE"
	 CreateDirectory "$EXEDIR\TEMPYUMI" ; Create the TEMPYUMI directory
	 ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -pkon-boot -o"$EXEDIR\TEMPYUMI" -y' 
	 ExecWait '"$PLUGINSDIR\7zG.exe" e "$EXEDIR\TEMPYUMI\FD0-konboot*.zip" -pkon-boot -o"$EXEDIR\TEMPYUMI" -y' 
	 CopyFiles $EXEDIR\TEMPYUMI\FD0-konboot-v1.1-2in1.img "$BootDir\multiboot\$JustISOName\konboot.img" 
	 RMDir /R "$EXEDIR\TEMPYUMI"
	 ${WriteToFile} "#start $JustISOName$\r$\nLABEL Kon-Boot ($JustISOName)$\r$\nMENU LABEL Kon-Boot ($JustISOName)$\r$\nMENU INDENT 1$\r$\nCONFIG /multiboot/menu/konboot.cfg$\r$\nAPPEND /multiboot/menu$\r$\n#end $JustISOName" $R0 
	 File /oname=$PLUGINSDIR\konboot.cfg "Menu\konboot.cfg"  
	 CopyFiles "$PLUGINSDIR\konboot.cfg" "$BootDir\multiboot\menu\konboot.cfg"
	 !insertmacro ReplaceInFile "SLUG" "$JustISOName" "all" "all" "$BootDir\multiboot\menu\konboot.cfg" 
	 
	 ${ElseIf} $DistroName == "Kon-Boot Purchased"
	 CreateDirectory "$EXEDIR\TEMPYUMI" ; Create the TEMPYUMI directory
	 ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -o"$EXEDIR\TEMPYUMI" -y' 
	 CopyFiles $EXEDIR\TEMPYUMI\grldr "$BootDir\multiboot\$JustISOName\grldr"  
	 CopyFiles $EXEDIR\TEMPYUMI\konboot.img "$BootDir\multiboot\$JustISOName\konboot.img"  
	 CopyFiles $EXEDIR\TEMPYUMI\konbootOLD.img "$BootDir\multiboot\$JustISOName\konbootOLD.img" 
	 RMDir /R "$EXEDIR\TEMPYUMI"
	 ${WriteToFile} "#start $JustISOName$\r$\nLABEL Kon-Boot ($JustISOName)$\r$\nMENU LABEL Kon-Boot ($JustISOName)$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/$JustISOName/konboot.lst" $R0 
	 File /oname=$PLUGINSDIR\konboot.lst "Menu\konboot.lst"  
	 CopyFiles "$PLUGINSDIR\konboot.lst" "$BootDir\multiboot\$JustISOName\konboot.lst"
	 !insertmacro ReplaceInFile "SLUG" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\konboot.lst" 
	 
	 ; Falcon 4 Boot CD
	 ${ElseIf} $DistroName == "Falcon 4 Boot CD"
	 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\" -y' 
	 ${WriteToFile} "#start $JustISOName$\r$\nLABEL Falcon 4 Boot CD ($JustISOName)$\r$\nMENU LABEL Falcon 4 Boot CD ($JustISOName)$\r$\nMENU INDENT 1$\r$\nCOM32 /multiboot/chain.c32 ntldr=/grldr$\r$\n#end $JustISOName" $R0
 
	 ; Hiren's Boot CD 
	 ${ElseIf} $DistroName == "Hiren's Boot CD" 
	 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -ir!HBCD -o"$BootDir\" -y' 
	   Call SysFixHirens  ; Check for and replace vesamenu.c32, menu.c32, chain.c32 if found 
	 ${WriteToFile} "#start $JustISOName$\r$\nLABEL Hiren's Boot CD ($JustISOName)$\r$\nMENU LABEL Hiren's Boot CD ($JustISOName)$\r$\nMENU INDENT 1$\r$\nCOM32 /HBCD/Boot/chain.c32 ntldr=/HBCD/grldr$\r$\n#end $JustISOName" $R0  

	 ; Windows Defender Offline
		 ${ElseIf} $DistroName == "Windows Defender Offline"
		 CopyFiles $ISOFile "$BootDir\multiboot\ISOS\$JustISO" 
		 ; ${WriteToFile} "#start $JustISOName$\r$\nLABEL Windows Defender Offline ($JustISOName)$\r$\nMENU LABEL Windows Defender Offline ($JustISOName)$\r$\nMENU INDENT 1$\r$\nLINUX /multiboot/grub.exe$\r$\nAPPEND --config-file=$\"ls /multiboot/ISOS/$JustISO || find --set-root /multiboot/ISOS/$JustISO;map --heads=0 --sectors-per-track=0 /multiboot/ISOS/$JustISO (0xff) || map --heads=0 --sectors-per-track=0 --mem /multiboot/ISOS/$JustISO (0xff);map --hook;chainloader (0xff)$\"$\r$\n#end $JustISOName" $R0
		 ${WriteToFile} "#start $JustISOName$\r$\nlabel Windows Defender Offline ($JustISOName)$\r$\nmenu label title Windows Defender Offline ($JustISOName)$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/menu/WDO.lst$\r$\n#end $JustISOName" $R0   
		 File /oname=$PLUGINSDIR\WDO.lst "Menu\WDO.lst"  
		 CopyFiles "$PLUGINSDIR\WDO.lst" "$BootDir\multiboot\menu\WDO.lst" 
		 !insertmacro ReplaceInFile "SLUG" "$JustISO" "all" "all" "$BootDir\multiboot\menu\WDO.lst"  
	 
	 ; Windows (WIM) boot
	 ${ElseIf} $DistroName == "Multiple Windows Vista/7/8/10 Installers -wimboot"
	 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -o"$BootDir\multiboot\$JustISOName" -y -x![BOOT]*' 
	  ;${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nCOM32 linux.c32$\r$\nappend wimboot initrdfile=$JustISOName/bootmgr,$JustISOName/boot/bcd,$JustISOName/boot/boot.sdi,$JustISOName/sources/boot.wim$\r$\n#end $JustISOName" $R0
	   ${WriteToFile} "#start $JustISOName$\r$\ntitle Install $JustISOName - wimboot$\r$\nmap (hd0) (hd1)$\r$\nmap (hd1) (hd0)$\r$\nmap --hook$\r$\nkernel (hd1,0)/multiboot/wimboot$\r$\nkernel (hd1,0)/multiboot/wimboot$\r$\ninitrd @bootmgr=(hd1,0)/multiboot/$JustISOName/bootmgr @bcd=(hd1,0)/multiboot/$JustISOName/boot/bcd @boot.sdi=(hd1,0)/multiboot/$JustISOName/boot/boot.sdi @boot.wim=(hd1,0)/multiboot/$JustISOName/sources/boot.wim$\r$\n#end $JustISOName" $R0   
	   CopyFiles "$PLUGINSDIR\remount.cmd" "$BootDir\multiboot\$JustISOName\remount.cmd"    
	   CopyFiles "$PLUGINSDIR\ei.cfg" "$BootDir\multiboot\$JustISOName\sources\ei.cfg"	  
	   CopyFiles "$PLUGINSDIR\wimlib\stuff\autounattend.xml" "$BootDir\multiboot\$JustISOName\autounattend.xml"   
	   CopyFiles "$PLUGINSDIR\wimlib\stuff\au.txt" "$BootDir\multiboot\$JustISOName\au.txt"   
	   !insertmacro ReplaceInFile "ISONAMESLUG" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\remount.cmd"  
	   !insertmacro ReplaceInFile "ISONAMESLUG" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\autounattend.xml"  
	   !insertmacro ReplaceInFile "ISONAMESLUG" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\au.txt"  
	   !insertmacro ReplaceInFile "BOOTDIRSLUG" "$BootDir" "all" "all" "$BootDir\multiboot\$JustISOName\au.txt"     
	  
	  ;nsExec::ExecToLog '"cmd" /c $PLUGINSDIR\wimlib\wimlib-imagex update $BootDir\multiboot\$JustISOName\sources\boot.wim 2 < $BootDir\multiboot\$JustISOName\au.txt' 
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\sources\boot.wim"  
	   nsExec::ExecToLog '"cmd" /c $PLUGINSDIR\wimlib\wimlib-imagex update $BootDir\multiboot\$JustISOName\sources\boot.wim 2 < $BootDir\multiboot\$JustISOName\au.txt' 
	  ${Endif}   
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\x64\sources\boot.wim"  
	   nsExec::ExecToLog '"cmd" /c $PLUGINSDIR\wimlib\wimlib-imagex update $BootDir\multiboot\$JustISOName\x64\sources\boot.wim 2 < $BootDir\multiboot\$JustISOName\au.txt'
	  ${Endif} 
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\x86\sources\boot.wim"  
	   nsExec::ExecToLog '"cmd" /c $PLUGINSDIR\wimlib\wimlib-imagex update $BootDir\multiboot\$JustISOName\x86\sources\boot.wim 2 < $BootDir\multiboot\$JustISOName\au.txt'     
	  ${Endif} 
	  ;!insertmacro ReplaceInFile "$BootDir" "BOOTDIRSLUG" "all" "all" "$BootDir\multiboot\$JustISOName\au.txt" 
	 
	 ; Windows - bootmgr at root of USB
	  ${ElseIf} $DistroName == "Multiple Windows Vista/7/8/10 Installers -bootmgr"
	  ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -o"$BootDir\multiboot\$JustISOName" -y -x![BOOT]*'    
	 
	  ${IfNot} ${FileExists} "$BootDir\multiboot\$JustISOName\efi\microsoft\boot\bcd"
	   ${WriteToFile} "#start $JustISOName$\r$\ntitle Install $JustISOName - bootmgr at root$\r$\ndd if=()/multiboot/$JustISOName/boot/bcd of=()/boot/bcd$\r$\nchainloader /multiboot/$JustISOName/bootmgr$\r$\n#end $JustISOName" $R0  
	  ${Else} ; For 32bit variants
	   ${WriteToFile} "#start $JustISOName$\r$\ntitle Install $JustISOName - bootmgr at root$\r$\ndd if=()/multiboot/$JustISOName/boot/bcd of=()/boot/bcd$\r$\ndd if=()/multiboot/$JustISOName/efi/microsoft/boot/bcd of=()/efi/microsoft/boot/bcd$\r$\nchainloader /multiboot/$JustISOName/bootmgr$\r$\n#end $JustISOName" $R0 
	  ${Endif}
	   CopyFiles "$PLUGINSDIR\remount.cmd" "$BootDir\multiboot\$JustISOName\remount.cmd"    
	   CopyFiles "$PLUGINSDIR\ei.cfg" "$BootDir\multiboot\$JustISOName\sources\ei.cfg"	  
	   CopyFiles "$PLUGINSDIR\wimlib\stuff\autounattend.xml" "$BootDir\multiboot\$JustISOName\autounattend.xml"   
	   CopyFiles "$PLUGINSDIR\wimlib\stuff\au.txt" "$BootDir\multiboot\$JustISOName\au.txt"     
	   !insertmacro ReplaceInFile "ISONAMESLUG" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\remount.cmd"  
	   !insertmacro ReplaceInFile "ISONAMESLUG" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\autounattend.xml"  
	   !insertmacro ReplaceInFile "ISONAMESLUG" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\au.txt"  
	   !insertmacro ReplaceInFile "BOOTDIRSLUG" "$BootDir" "all" "all" "$BootDir\multiboot\$JustISOName\au.txt"  
	  
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\sources\boot.wim"  
	  nsExec::ExecToLog '"cmd" /c $PLUGINSDIR\wimlib\wimlib-imagex update $BootDir\multiboot\$JustISOName\sources\boot.wim 2 < $BootDir\multiboot\$JustISOName\au.txt' 
	  ${Endif}  
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\sources\x64\boot.wim"  
	  nsExec::ExecToLog '"cmd" /c $PLUGINSDIR\wimlib\wimlib-imagex update $BootDir\multiboot\$JustISOName\x64\sources\boot.wim 2 < $BootDir\multiboot\$JustISOName\au.txt' 
	  ${Endif}  
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\sources\x86\boot.wim"  
	  nsExec::ExecToLog '"cmd" /c $PLUGINSDIR\wimlib\wimlib-imagex update $BootDir\multiboot\$JustISOName\x86\sources\boot.wim 2 < $BootDir\multiboot\$JustISOName\au.txt'     
	  ${Endif}
	  ;!insertmacro ReplaceInFile "$BootDir" "BOOTDIRSLUG" "all" "all" "$BootDir\multiboot\$JustISOName\au.txt"  
	  
	 /*   ${IfNot} ${FileExists} "$BootDir\autounattend.xml" 
	  CopyFiles "$PLUGINSDIR\autounattend.xml" "$BootDir\autounattend.xml"  
	  ${Endif}   */

	 !include "x64.nsh"
	 ${DisableX64FSRedirection} 
	 DetailPrint "bcdedit /store $BootDir/multiboot/$JustISOName/boot/bcd /set {default} device ramdisk=[boot]\multiboot\$JustISOName\sources\boot.wim,{7619dcc8-fafe-11d9-b411-000476eba25f}" 
	 nsExec::ExecToLog '"cmd" /c bcdedit /store $BootDir/multiboot/$JustISOName/boot/bcd /set {default} device ramdisk=[boot]\multiboot\$JustISOName\sources\boot.wim,{7619dcc8-fafe-11d9-b411-000476eba25f}'
	 DetailPrint "bcdedit /store $BootDir/multiboot/$JustISOName/boot/bcd /set {default} osdevice ramdisk=[boot]\multiboot\$JustISOName\sources\boot.wim,{7619dcc8-fafe-11d9-b411-000476eba25f}"
	 nsExec::ExecToLog '"cmd" /c bcdedit /store $BootDir/multiboot/$JustISOName/boot/bcd /set {default} osdevice ramdisk=[boot]\multiboot\$JustISOName\sources\boot.wim,{7619dcc8-fafe-11d9-b411-000476eba25f}'
	 DetailPrint 'bcdedit /store $BootDir/multiboot/$JustISOName/efi/microsoft/boot/bcd /set {default} device ramdisk=[boot]\multiboot\$JustISOName\sources\boot.wim,{7619dcc8-fafe-11d9-b411-000476eba25f}'
	 nsExec::ExecToLog '"cmd" /c bcdedit /store $BootDir/multiboot/$JustISOName/efi/microsoft/boot/bcd /set {default} device ramdisk=[boot]\multiboot\$JustISOName\sources\boot.wim,{7619dcc8-fafe-11d9-b411-000476eba25f}'
	 DetailPrint 'bcdedit /store $BootDir/multiboot/$JustISOName/efi/microsoft/boot/bcd /set {default} osdevice ramdisk=[boot]\multiboot\$JustISOName\sources\boot.wim,{7619dcc8-fafe-11d9-b411-000476eba25f}' 
	 nsExec::ExecToLog '"cmd" /c bcdedit /store $BootDir/multiboot/$JustISOName/efi/microsoft/boot/bcd /set {default} osdevice ramdisk=[boot]\multiboot\$JustISOName\sources\boot.wim,{7619dcc8-fafe-11d9-b411-000476eba25f}'
	 ${EnableX64FSRedirection} 
	 
	  ${IfNot} ${FileExists} "$BootDir\boot\bcd"
		  CreateDirectory $BootDir\boot
		  
		 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\boot.sdi"
		  CopyFiles $BootDir\multiboot\$JustISOName\boot\boot.sdi "$BootDir\boot\bcd" ;just copying a file large enough in size to be used for our bcd container...
		  CopyFiles $BootDir\multiboot\$JustISOName\boot\boot.sdi "$BootDir\boot"	 
		 ;${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\SSTR\boot.sdi"
		  ;CopyFiles $BootDir\multiboot\$JustISOName\SSTR\boot.sdi "$BootDir\boot\bcd" ;just copying a file large enough in size to be used for our bcd container...
		 ; CopyFiles $BootDir\multiboot\$JustISOName\SSTR\boot.sdi "$BootDir\boot"	
		 ${EndIf} 
		 
	   ${AndIfNot} ${FileExists} "$BootDir\efi\microsoft\boot\bcd"  
		  CreateDirectory $BootDir\efi\microsoft\boot	
		  CopyFiles $BootDir\multiboot\$JustISOName\efi\microsoft\boot\bcd "$BootDir\efi\microsoft\boot"  
	   ${AndIfNot} ${FileExists} "$BootDir\bootmgr"  
		  CopyFiles $BootDir\multiboot\$JustISOName\bootmgr "$BootDir\bootmgr" 
	   ${AndIfNot} ${FileExists} "$BootDir\bootmgr.efi" 	  
		  CopyFiles $BootDir\multiboot\$JustISOName\bootmgr.efi "$BootDir\bootmgr.efi"  
	  ${EndIf}  
	  
	 ; Windows PE (WIM) boot
		 ${ElseIf} $DistroName == "Multiple Windows PE -wimboot"
		 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -o"$BootDir\multiboot\$JustISOName" -y -x![BOOT]*' 
		  ${WriteToFile} "#start $JustISOName$\r$\ntitle $JustISOName - wimboot$\r$\nkernel /multiboot/wimboot$\r$\nkernel /multiboot/wimboot$\r$\ninitrd @bootmgr=/multiboot/$JustISOName/bootmgr @bcd=/multiboot/$JustISOName/boot/bcd @boot.sdi=/multiboot/$JustISOName/boot/boot.sdi @boot.wim=/multiboot/$JustISOName/sources/boot.wim$\r$\n#end $JustISOName" $R0   

	 ; Windows PE - bootmgr at root of USB
		 ${ElseIf} $DistroName == "Multiple Windows PE -bootmgr"
		 
	 ; Hiren's BootCD PE - bootmgr at root of USB
		  ${OrIf} $DistroName == "Hiren's Boot CD PE" 

		 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -o"$BootDir\multiboot\$JustISOName" -y -x![BOOT]* -x!Programs'   
		 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -ir!Programs -o"$BootDir\"'   
	 
	  ${IfNot} ${FileExists} "$BootDir\multiboot\$JustISOName\efi\microsoft\boot\bcd"
	   ${WriteToFile} "#start $JustISOName$\r$\ntitle $JustISOName - bootmgr at root$\r$\ndd if=()/multiboot/$JustISOName/boot/bcd of=()/boot/bcd$\r$\nchainloader /multiboot/$JustISOName/bootmgr$\r$\n#end $JustISOName" $R0  
	  ${Else} ; For 32bit variants
	   ${WriteToFile} "#start $JustISOName$\r$\ntitle $JustISOName - bootmgr at root$\r$\ndd if=()/multiboot/$JustISOName/boot/bcd of=()/boot/bcd$\r$\ndd if=()/multiboot/$JustISOName/efi/microsoft/boot/bcd of=()/efi/microsoft/boot/bcd$\r$\nchainloader /multiboot/$JustISOName/bootmgr$\r$\n#end $JustISOName" $R0 
	  ${Endif}
	  
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\CdUsb.Y"
		CopyFiles $BootDir\multiboot\$JustISOName\CdUsb.Y "$BootDir\CdUsb.Y"
	  ${Endif}
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\pecmdExt.ini"
		CopyFiles $BootDir\multiboot\$JustISOName\pecmdExt.ini "$BootDir\pecmdExt.ini"
	  ${Endif}
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\Win10PE.cd"
		CopyFiles $BootDir\multiboot\$JustISOName\Win10PE.cd "$BootDir\Win10PE.cd"
	  ${Endif} 
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\bootmgr.exe"
		CopyFiles $BootDir\multiboot\$JustISOName\bootmgr.exe "$BootDir\bootmgr.exe"
	  ${Endif}   
  
	 !include "x64.nsh"
	 ${DisableX64FSRedirection} 
	 DetailPrint "bcdedit /store $BootDir/multiboot/$JustISOName/boot/bcd /set {default} device ramdisk=[boot]\multiboot\$JustISOName\sources\boot.wim,{7619dcc8-fafe-11d9-b411-000476eba25f}" 
	 nsExec::ExecToLog '"cmd" /c bcdedit /store $BootDir/multiboot/$JustISOName/boot/bcd /set {default} device ramdisk=[boot]\multiboot\$JustISOName\sources\boot.wim,{7619dcc8-fafe-11d9-b411-000476eba25f}'
	 DetailPrint "bcdedit /store $BootDir/multiboot/$JustISOName/boot/bcd /set {default} osdevice ramdisk=[boot]\multiboot\$JustISOName\sources\boot.wim,{7619dcc8-fafe-11d9-b411-000476eba25f}"
	 nsExec::ExecToLog '"cmd" /c bcdedit /store $BootDir/multiboot/$JustISOName/boot/bcd /set {default} osdevice ramdisk=[boot]\multiboot\$JustISOName\sources\boot.wim,{7619dcc8-fafe-11d9-b411-000476eba25f}'
	 DetailPrint 'bcdedit /store $BootDir/multiboot/$JustISOName/efi/microsoft/boot/bcd /set {default} device ramdisk=[boot]\multiboot\$JustISOName\sources\boot.wim,{7619dcc8-fafe-11d9-b411-000476eba25f}'
	 nsExec::ExecToLog '"cmd" /c bcdedit /store $BootDir/multiboot/$JustISOName/efi/microsoft/boot/bcd /set {default} device ramdisk=[boot]\multiboot\$JustISOName\sources\boot.wim,{7619dcc8-fafe-11d9-b411-000476eba25f}'
	 DetailPrint 'bcdedit /store $BootDir/multiboot/$JustISOName/efi/microsoft/boot/bcd /set {default} osdevice ramdisk=[boot]\multiboot\$JustISOName\sources\boot.wim,{7619dcc8-fafe-11d9-b411-000476eba25f}' 
	 nsExec::ExecToLog '"cmd" /c bcdedit /store $BootDir/multiboot/$JustISOName/efi/microsoft/boot/bcd /set {default} osdevice ramdisk=[boot]\multiboot\$JustISOName\sources\boot.wim,{7619dcc8-fafe-11d9-b411-000476eba25f}'
	 ${EnableX64FSRedirection}   
	 
	  ${IfNot} ${FileExists} "$BootDir\boot\bcd"
		  CreateDirectory $BootDir\boot
		  CopyFiles $BootDir\multiboot\$JustISOName\boot\boot.sdi "$BootDir\boot\bcd" ;just copying a file large enough in size to be used for our bcd container...
		  CopyFiles $BootDir\multiboot\$JustISOName\boot\boot.sdi "$BootDir\boot"		  
	   ${AndIfNot} ${FileExists} "$BootDir\efi\microsoft\boot\bcd"  
		  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\efi\microsoft\boot\bcd"
		   CreateDirectory $BootDir\efi\microsoft\boot	
		   CopyFiles $BootDir\multiboot\$JustISOName\efi\microsoft\boot\bcd "$BootDir\efi\microsoft\boot"  
		  ${Endif}
	   ${AndIfNot} ${FileExists} "$BootDir\bootmgr"  
		  CopyFiles $BootDir\multiboot\$JustISOName\bootmgr "$BootDir\bootmgr" 
	   ${AndIfNot} ${FileExists} "$BootDir\bootmgr.efi" 	
		  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\bootmgr.efi"
		   CopyFiles $BootDir\multiboot\$JustISOName\bootmgr.efi "$BootDir\bootmgr.efi" 
		  ${Endif}
	  ${EndIf}    
	 
	 ; Single Windows Vista/7/8/10 -files at root
	 ${ElseIf} $DistroName == "Single Windows Vista/7/8/10 Installer"
	 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -o"$BootDir\" -y -x![BOOT]*' 
	 ;CreateDirectory $BootDir\multiboot\$JustISOName	
	 CopyFiles "$BootDir\bootmgr" "$BootDir\multiboot\$JustISOName"
	 CopyFiles "$BootDir\boot" "$BootDir\multiboot\$JustISOName"
	 
	  ${IfNot} ${FileExists} "$BootDir\efi\microsoft\boot\bcd"
	   ${WriteToFile} "#start $JustISOName$\r$\ntitle Install $JustISOName$\r$\ndd if=()/multiboot/$JustISOName/boot/bcd of=()/boot/bcd$\r$\nchainloader /multiboot/$JustISOName/bootmgr$\r$\n#end $JustISOName" $R0  
	  ${Else} 
	   CopyFiles "$BootDir\bootmgr.efi" "$BootDir\multiboot\$JustISOName"
	   CopyFiles "$BootDir\efi" "$BootDir\multiboot\$JustISOName"
	   ${WriteToFile} "#start $JustISOName$\r$\ntitle Install $JustISOName$\r$\ndd if=()/multiboot/$JustISOName/boot/bcd of=()/boot/bcd$\r$\ndd if=()/multiboot/$JustISOName/efi/microsoft/boot/bcd of=()/efi/microsoft/boot/bcd$\r$\nchainloader /multiboot/$JustISOName/bootmgr$\r$\n#end $JustISOName" $R0 
	  ${Endif}
	  
	 ; Single Windows PE -files at root
	 ${ElseIf} $DistroName == "Single Windows PE"
	 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -o"$BootDir\" -y -x![BOOT]*' 	
	 CopyFiles "$BootDir\bootmgr" "$BootDir\multiboot\$JustISOName"
	 CopyFiles "$BootDir\boot" "$BootDir\multiboot\$JustISOName"
	 
	  ${IfNot} ${FileExists} "$BootDir\efi\microsoft\boot\bcd"
	   ${WriteToFile} "#start $JustISOName$\r$\ntitle Start $JustISOName - Single PE$\r$\ndd if=()/multiboot/$JustISOName/boot/bcd of=()/boot/bcd$\r$\nchainloader /multiboot/$JustISOName/bootmgr$\r$\n#end $JustISOName" $R0  
	  ${Else} 
	   CopyFiles "$BootDir\bootmgr.efi" "$BootDir\multiboot\$JustISOName"
	   CopyFiles "$BootDir\efi" "$BootDir\multiboot\$JustISOName"
	   ${WriteToFile} "#start $JustISOName$\r$\ntitle Start $JustISOName - Single PE$\r$\ndd if=()/multiboot/$JustISOName/boot/bcd of=()/boot/bcd$\r$\ndd if=()/multiboot/$JustISOName/efi/microsoft/boot/bcd of=()/efi/microsoft/boot/bcd$\r$\nchainloader /multiboot/$JustISOName/bootmgr$\r$\n#end $JustISOName" $R0 
	  ${Endif}  
	  
	 ; For Syslinux ---- ${WriteToFile} "#start $JustISOName$\r$\nLABEL Windows Vista/7/8 Installer$\r$\nMENU LABEL Windows Vista/7/8/10 Installer$\r$\nMENU INDENT 1$\r$\nCOM32 /multiboot/chain.c32 fs ntldr=/bootmgr$\r$\n#end $JustISOName" $R0  
	 ; CopyFiles $ISOFile "$BootDir\multiboot\ISOS\$JustISO"
	 ; ${WriteToFile} "title$\r$\nroot$\r$\n#start $JustISOName$\r$\ntitle Start $JustISOName Single Installer$\r$\nchainloader /bootmgr$\r$\n#end $JustISOName" $R0  
	 ; File /oname=$PLUGINSDIR\firadisk.img "firadisk.img"  
	 ; CopyFiles "$PLUGINSDIR\firadisk.img" "$BootDir\multiboot\ISOS\firadisk.img"   

	 ; Windows XP
	 ${ElseIf} $DistroName == "Single Windows XP Installer" 
	 CopyFiles $ISOFile "$BootDir\multiboot\ISOS\$JustISO"
	 ${WriteToFile} "title$\r$\nroot$\r$\n#start $JustISOName$\r$\ntitle Begin Install of Windows XP from $JustISO (Stage 1)$\r$\nfind --set-root /multiboot/ISOS/$JustISO$\r$\nmap (hd0) (hd1)$\r$\nmap (hd1) (hd0)$\r$\nmap --mem /multiboot/ISOS/firadisk.img (fd0)$\r$\nmap --mem /multiboot/ISOS/firadisk.img (fd1)$\r$\nmap --mem /multiboot/ISOS/$JustISO (0xff)$\r$\nmap --hook$\r$\nchainloader (0xff)/I386/SETUPLDR.BIN$\r$\n$\r$\ntitle Continue Windows XP Install from $JustISO (Stage 2)$\r$\nfind --set-root /multiboot/ISOS/$JustISO$\r$\nmap (hd0) (hd1)$\r$\nmap (hd1) (hd0)$\r$\nmap --mem /multiboot/ISOS/$JustISO (0xff)$\r$\nmap --hook$\r$\nchainloader (hd0)+1$\r$\n$\r$\ntitle Boot Windows XP - If fails, reboot with USB removed (Stage 3)$\r$\nmap (hd1) (hd0)$\r$\nmap (hd0) (hd1)$\r$\nroot (hd1,0)$\r$\nfind --set-root /ntldr$\r$\nchainloader /ntldr$\r$\n#end $JustISOName" $R0  
	 File /oname=$PLUGINSDIR\firadisk.img "firadisk.img"  
	 CopyFiles "$PLUGINSDIR\firadisk.img" "$BootDir\multiboot\ISOS\firadisk.img"   
	 
	 ; Unlisted ISOs

	 ; Multiple Windows To Go (Virtual Hard Disk)
	 ${ElseIf} $DistroName == "Windows to Go (Virtual Hard Disk)"
	 StrCpy $ConfigFile == "win2go.lst" ; Make sure it isn't NULL   

	 StrCpy $VHDSize "$Casper" ; was 20000
	 StrCpy $VHDLBL "$JustISOName" 11
	 
	 !insertmacro ReplaceInFile "DSK" "$BootDir\multiboot\$JustISOName" "all" "all" "$PLUGINSDIR\w2gdiskpart.txt" 
	 !insertmacro ReplaceInFile "SLUG" "$JustISOName" "all" "all" "$PLUGINSDIR\w2gdiskpart.txt" 
	 !insertmacro ReplaceInFile "DSK" "$BootDir\multiboot\$JustISOName" "all" "all" "$PLUGINSDIR\diskpartdetach.txt" 
	 !insertmacro ReplaceInFile "SLUG" "$JustISOName" "all" "all" "$PLUGINSDIR\diskpartdetach.txt"  
	 !insertmacro ReplaceInFile "VHDFMT" "ntfs" "all" "all" "$PLUGINSDIR\w2gdiskpart.txt"  ; edit this to format type
	 !insertmacro ReplaceInFile "VHDSIZE" "$VHDSize" "all" "all" "$PLUGINSDIR\w2gdiskpart.txt"  ; edit this to beyond the calculated filesize in bytes
	 !insertmacro ReplaceInFile "VHDLBL" "$VHDLBL" "all" "all" "$PLUGINSDIR\w2gdiskpart.txt"  
	 
	 DetailPrint "Creating a Virtual Hard Disk for $JustISOName. Please be patient, this may take time..." 
	 nsExec::ExecToLog '"DiskPart" /S $PLUGINSDIR\w2gdiskpart.txt' 
	 CopyFiles "$PLUGINSDIR\dskvol.txt" "$BootDir\multiboot\$JustISOName\dskvol.txt" 
	 Call GetVolNameDSK 
	 StrCpy $VHDDisk "$VHDDisk" 1
	 DetailPrint "Installing $JustISOName to Virtual Hard Disk. Please be patient, this may take time..." 
	 CreateDirectory "$EXEDIR\TEMPYUMI" ; Create the TEMPYUMI directory
	 ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -ir!boot.sdi -ir!install.wim -ir!install.esd -o"$EXEDIR\TEMPYUMI" -y'

	  ${If} ${FileExists} "$EXEDIR\TEMPYUMI\install.wim" 
		 ExecWait '"cmd" /c $PLUGINSDIR\wimlib\wimlib-imagex apply "$EXEDIR\TEMPYUMI\install.wim" 1 $VHDDisk:\' 
		 ${ElseIf} ${FileExists} "$EXEDIR\TEMPYUMI\install.esd" 
		 ExecWait '"cmd" /c $PLUGINSDIR\wimlib\wimlib-imagex apply "$EXEDIR\TEMPYUMI\install.esd" 1 $VHDDisk:\'  
	  ${EndIf} 
	  
	  !insertmacro ReplaceInFile "VHDDISK" "$VHDDISK" "all" "all" "$PLUGINSDIR\boot.cmd"  
	  
	  !include "x64.nsh"
	  ${DisableX64FSRedirection} 
	  nsExec::ExecToLog '"cmd" /c $PLUGINSDIR\boot.cmd'
	  
	  !insertmacro ReplaceInFile "$VHDDISK" "VHDDISK" "all" "all" "$PLUGINSDIR\boot.cmd" ;revert back in case of reuse during add additional distro
	  
	  CopyFiles "$VHDDISK:\bootmgr" "$BootDir\multiboot\$JustISOName"
	  CopyFiles "$VHDDISK:\boot" "$BootDir\multiboot\$JustISOName"
	 
	  ;${IfNot} ${FileExists} "$VHDDISK\efi\microsoft\boot\bcd"
	   nsExec::ExecToLog '"cmd" /c bcdedit /store $BootDir/multiboot/$JustISOName/boot/bcd /set {default} device vhd=[locate]\multiboot\$JustISOName\$JustISOName.vhd'
	   nsExec::ExecToLog '"cmd" /c bcdedit /store $BootDir/multiboot/$JustISOName/boot/bcd /set {default} osdevice vhd=[locate]\multiboot\$JustISOName\$JustISOName.vhd'
	   ${WriteToFile} "#start $JustISOName$\r$\ntitle Boot $JustISOName$\r$\ndd if=()/multiboot/$JustISOName/boot/bcd of=()/boot/bcd$\r$\nchainloader /multiboot/$JustISOName/bootmgr$\r$\n#end $JustISOName" $R0  
	  ;${Else} 
	  ; CopyFiles "$VHDDISK\bootmgr.efi" "$BootDir\multiboot\$JustISOName"
	  ; CopyFiles "$VHDDISK\efi" "$BootDir\multiboot\$JustISOName"
	  ; nsExec::ExecToLog '"cmd" /c bcdedit /store $BootDir/multiboot/$JustISOName/boot/bcd /set {default} device vhd=[locate]\multiboot\$JustISOName\$JustISOName.vhd'
	  ; nsExec::ExecToLog '"cmd" /c bcdedit /store $BootDir/multiboot/$JustISOName/boot/bcd /set {default} osdevice vhd=[locate]\multiboot\$JustISOName\$JustISOName.vhd'
	  ; nsExec::ExecToLog '"cmd" /c bcdedit /store $BootDir/multiboot/$JustISOName/efi/microsoft/boot/bcd /set {default} device vhd=[locate]\multiboot\$JustISOName\$JustISOName.vhd'
	  ; nsExec::ExecToLog '"cmd" /c bcdedit /store $BootDir/multiboot/$JustISOName/efi/microsoft/boot/bcd /set {default} osdevice vhd=[locate]\multiboot\$JustISOName\$JustISOName.vhd'
	  ; ${WriteToFile} "#start $JustISOName$\r$\ntitle Boot $JustISOName$\r$\ndd if=()/multiboot/$JustISOName/boot/bcd of=()/boot/bcd$\r$\ndd if=()/multiboot/$JustISOName/efi/microsoft/boot/bcd of=()/efi/microsoft/boot/bcd$\r$\nchainloader /multiboot/$JustISOName/bootmgr$\r$\n#end $JustISOName" $R0 
	   ;;${WriteToFile} "#start $JustISOName$\r$\ntitle Boot $JustISO$\r$\nchainloader /bootmgr$\r$\n#end $JustISOName" $R0  
	  ;${Endif}
	 ${EnableX64FSRedirection} 
	  
	 ${IfNot} ${FileExists} "$BootDir\boot\bcd"
	   CreateDirectory $BootDir\boot	    
	 ${Endif}
	   CopyFiles "$VHDDISK:\boot" "$BootDir"
	   CopyFiles $EXEDIR\TEMPYUMI\boot.sdi "$BootDir\boot\bcd" ;just copying a file large enough in size to be used for our bcd container...
	 
	  RMDir /R "$EXEDIR\TEMPYUMI"
	  nsExec::ExecToLog '"DiskPart" /S $PLUGINSDIR\diskpartdetach.txt'   
	  
	 ;revert back in case of reuse during add additional distro
	 !insertmacro ReplaceInFile "$BootDir\multiboot\$JustISOName" "DSK" "all" "all" "$PLUGINSDIR\w2gdiskpart.txt" 
	 !insertmacro ReplaceInFile "$JustISOName" "SLUG" "all" "all" "$PLUGINSDIR\w2gdiskpart.txt" 
	 !insertmacro ReplaceInFile "$BootDir\multiboot\$JustISOName" "DSK" "all" "all" "$PLUGINSDIR\diskpartdetach.txt" 
	 !insertmacro ReplaceInFile "$JustISOName" "SLUG" "all" "all" "$PLUGINSDIR\diskpartdetach.txt"  
	 !insertmacro ReplaceInFile "ntfs" "VHDFMT" "all" "all" "$PLUGINSDIR\w2gdiskpart.txt"  ; edit this to format type
	 !insertmacro ReplaceInFile "$VHDSize" "VHDSIZE" "all" "all" "$PLUGINSDIR\w2gdiskpart.txt"  ; edit this to beyond the calculated filesize in bytes
	 !insertmacro ReplaceInFile "$VHDLBL" "VHDLBL" "all" "all" "$PLUGINSDIR\w2gdiskpart.txt"   

	 
	 ${ElseIf} $DistroName == "Try Unlisted ISO (Virtual Hard Disk DD)"  
	 CopyFiles "$PLUGINSDIR\dd-diskpart.txt" "$BootDir\multiboot\$JustISOName\dd-diskpart.txt" 
	 CopyFiles "$PLUGINSDIR\diskpartdetach.txt" "$BootDir\multiboot\$JustISOName\diskpartdetach.txt"   
	 Call SetISOSize
	 IntOp $VHDSize $SizeOfCasper + 100 ; add buffer space for vhd
	 !insertmacro ReplaceInFile "DSK" "$BootDir\multiboot\$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\dd-diskpart.txt" 
	 !insertmacro ReplaceInFile "SLUG" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\dd-diskpart.txt" 
	 !insertmacro ReplaceInFile "DSK" "$BootDir\multiboot\$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\diskpartdetach.txt" 
	 !insertmacro ReplaceInFile "SLUG" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\diskpartdetach.txt"  
	 !insertmacro ReplaceInFile "VHDFMT" "fat32" "all" "all" "$BootDir\multiboot\$JustISOName\dd-diskpart.txt"  ; edit this to format type
	 !insertmacro ReplaceInFile "VHDSIZE" "$VHDSize" "all" "all" "$BootDir\multiboot\$JustISOName\dd-diskpart.txt"  ; edit this to beyond the calculated filesize in bytes (buffer)
	 nsExec::ExecToLog '"DiskPart" /S $BootDir\multiboot\$JustISOName\dd-diskpart.txt'
	 ExecWait '"$PLUGINSDIR\dd.exe" if=$ISOFile of=$BootDir\multiboot\$JustISOName\$JustISOName.vhd bs=2M --progress'
	; nsExec::ExecToLog '"DiskPart" /S $BootDir\multiboot\$JustISOName\diskpartdetach.txt' 
	 ${WriteToFile} "#start $JustISOName$\r$\ntitle Boot $JustISO$\r$\nmap --heads=0 --sectors-per-track=0 /multiboot/$JustISOName/$JustISOName.vhd (hd0)$\r$\nmap --hook$\r$\nchainloader (hd0)+1$\r$\nrootnoverify (hd0)$\r$\n#end $JustISOName" $R0    

	 ${ElseIf} $DistroName == "Super Grub2 Disk" 
	 CopyFiles $ISOFile "$BootDir\multiboot\ISOS\$JustISO"
	 ${WriteToFile} "#start $JustISOName$\r$\nlabel $JustISOName$\r$\nmenu label $JustISOName$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/menu/sgd.lst$\r$\n#end $JustISOName" $R0   
	 File /oname=$PLUGINSDIR\sgd.lst "Menu\sgd.lst"  
	 CopyFiles "$PLUGINSDIR\sgd.lst" "$BootDir\multiboot\menu\sgd.lst" 
	 !insertmacro ReplaceInFile "SLUG" "$JustISO" "all" "all" "$BootDir\multiboot\menu\sgd.lst"  

	 ${ElseIf} $DistroName == "Try Unlisted ISO (Virtual Hard Disk)"
	 CopyFiles "$PLUGINSDIR\autounattend.xml" "$BootDir\multiboot\$JustISOName\autounattend.xml"   
	 CopyFiles "$PLUGINSDIR\vhdremount.cmd" "$BootDir\multiboot\$JustISOName\vhdremount.cmd" 
	 CopyFiles "$PLUGINSDIR\wimlib\stuff\au.txt" "$BootDir\multiboot\$JustISOName\au.txt"   
	 
	 CopyFiles "$PLUGINSDIR\diskpart.txt" "$BootDir\multiboot\$JustISOName\diskpart.txt" 
	 CopyFiles "$PLUGINSDIR\diskpartdetach.txt" "$BootDir\multiboot\$JustISOName\diskpartdetach.txt"   
	 
	 !insertmacro ReplaceInFile "ISONAMESLUG" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\vhdremount.cmd"  
	 !insertmacro ReplaceInFile "ISONAMESLUG" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\autounattend.xml"  
	 !insertmacro ReplaceInFile "ISONAMESLUG" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\au.txt"  
	 !insertmacro ReplaceInFile "BOOTDIRSLUG" "$BootDir" "all" "all" "$BootDir\multiboot\$JustISOName\au.txt" 
	 Call SetISOSize
	 IntOp $VHDSize $SizeOfCasper + 100 ; add buffer space for vhd
	 !insertmacro ReplaceInFile "DSK" "$BootDir\multiboot\$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\diskpart.txt" 
	 !insertmacro ReplaceInFile "SLUG" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\diskpart.txt" 
	 !insertmacro ReplaceInFile "DSK" "$BootDir\multiboot\$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\diskpartdetach.txt" 
	 !insertmacro ReplaceInFile "SLUG" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\diskpartdetach.txt"  
	 !insertmacro ReplaceInFile "VHDFMT" "fat32" "all" "all" "$BootDir\multiboot\$JustISOName\diskpart.txt"  ; edit this to format type
	 !insertmacro ReplaceInFile "VHDSIZE" "$VHDSize" "all" "all" "$BootDir\multiboot\$JustISOName\diskpart.txt"  ; edit this to beyond the calculated filesize in bytes
	 nsExec::ExecToLog '"DiskPart" /S $BootDir\multiboot\$JustISOName\diskpart.txt'
	 ;CopyFiles $ISOFile "v:\"
	 ;Call GetVolNameDSK
	 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"V:\" -y'  

	  ${If} ${FileExists} "V:\sources\boot.wim"  
	  nsExec::ExecToLog '"cmd" /c $PLUGINSDIR\wimlib\wimlib-imagex update V:\sources\boot.wim 2 < $BootDir\multiboot\$JustISOName\au.txt' 
	  ${Endif}
	  ${If} ${FileExists} "V:\x64\sources\boot.wim"  
	  nsExec::ExecToLog '"cmd" /c $PLUGINSDIR\wimlib\wimlib-imagex update V:\x64\sources\boot.wim 2 < $BootDir\multiboot\$JustISOName\au.txt' 
	  ${Endif}
	  ${If} ${FileExists} "V:\x86\sources\boot.wim"  
	  nsExec::ExecToLog '"cmd" /c $PLUGINSDIR\wimlib\wimlib-imagex update V:\x86\sources\boot.wim 2 < $BootDir\multiboot\$JustISOName\au.txt'     
	  ${Endif}
	  nsExec::ExecToLog '"DiskPart" /S $BootDir\multiboot\$JustISOName\diskpartdetach.txt' 
	 ${WriteToFile} "#start $JustISOName$\r$\ntitle Boot $JustISO$\r$\nmap (hd0) (hd1)$\r$\nmap (hd1) (hd0)$\r$\nmap --heads=0 --sectors-per-track=0 /multiboot/$JustISOName/$JustISOName.vhd (hd1)$\r$\nmap --hook$\r$\nchainloader (hd1)+1$\r$\nrootnoverify (hd1)$\r$\n#end $JustISOName" $R0    
	 
	 
		# The following Grub at Partition 4 entry adds a 4th partition table entry to the USB device and uses this as a placeholder for the ISO. 
		# Entry derived from information obtained from Steve of rmprepusb.com. Steve said the following were his original sources: http://reboot.pro/topic/9916-grub4dos-isohybrided/page-2#entry88531 and http://reboot.pro/topic/9916-grub4dos-isohybrided/page-2#entry164127
		 ${ElseIf} $DistroName == "Try Unlisted ISO (GRUB Partition 4)" 
		 CopyFiles $ISOFile "$BootDir\multiboot\ISOS\$JustISO"
		 ; ${WriteToFile} "#start $JustISOName$\r$\n#Modify the following entry if it does not boot$\r$\ntitle Boot $JustISOName$\r$\nset ISO=/multiboot/ISOS/$JustISO$\r$\nfind --set-root %ISO%$\r$\nparttype (hd0,3) | set check=$\r$\nset check=%check:~-5,4% $\r$\nif %check%==0x00 partnew (hd0,3) 0x00 %ISO%$\r$\nif NOT %check%==0x00 echo ERROR: Fourth partition table entry is not empty, please delete it if you wish to use this method! && pause --wait=5 && configfile /multiboot/menu/grubpart4.lst$\r$\nmap %ISO% (0xff)$\r$\nmap --hook$\r$\nroot (0xff)$\r$\nchainloader (0xff)$\r$\n#end $JustISOName" $R0
		 ; ${WriteToFile} "#start $JustISOName$\r$\nparttype (hd0,3) | set check=$\r$\nset check=%check:~-5,4%$\r$\nif %check%==0x00 partnew (hd0,3) 0 0 0$\r$\nif not %check%==0x00 echo WARNING: Fourth partition is not empty, please delete it if you wish to use this boot method! && pause --wait=5 && configfile /multiboot/menu/menu.lst$\r$\n#Modify the following entry if it does not boot$\r$\ntitle Boot $JustISOName$\r$\nset ISO=/multiboot/ISOS/$JustISO$\r$\nfind --set-root %ISO%$\r$\nparttype (hd0,3) | set check=$\r$\nset check=%check:~-5,4% $\r$\nif %check%==0x00 partnew (hd0,3) 0x00 %ISO%$\r$\nif NOT %check%==0x00 echo ERROR: Fourth partition table entry is not empty, please delete it if you wish to use this method! && pause --wait=5 && configfile /multiboot/menu/grubpart4.lst$\r$\nmap %ISO% (0xff)$\r$\nmap --hook$\r$\nroot (0xff)$\r$\nchainloader (0xff)$\r$\n#end $JustISOName" $R0
		 ${WriteToFile} "#start $JustISOName$\r$\n#Modify the following entry if it does not boot$\r$\ntitle Boot $JustISOName$\r$\nset ISO=/multiboot/ISOS/$JustISO$\r$\nfind --set-root %ISO%$\r$\n$\r$\nparttype (hd0,3) | set check=$\r$\nset check=%check:~-5,4%$\r$\nif $\"%check%$\"==$\"0x00$\" partnew (hd0,3) 0 0 0$\r$\nif NOT $\"%check%$\"==$\"0x00$\" echo ERROR: Fourth partition table entry is not empty, please delete it if you wish to use this method && pause --wait=5 && configfile /multiboot/menu/grubpart4.lst$\r$\npartnew (hd0,3) 0x00 %ISO%$\r$\nmap %ISO% (0xff)$\r$\nmap --hook$\r$\nroot (0xff)$\r$\nchainloader (0xff)$\r$\n#end $JustISOName" $R0
		 
		 ${ElseIf} $DistroName == "Try Unlisted ISO (GRUB)" 
		 CopyFiles $ISOFile "$BootDir\multiboot\ISOS\$JustISO"
		 ${WriteToFile} "#start $JustISOName$\r$\n#Modify the following entry if it does not boot$\r$\ntitle Boot $JustISO$\r$\nfind --set-root --ignore-floppies --ignore-cd /multiboot/ISOS/$JustISO$\r$\nmap --heads=0 --sectors-per-track=0 /multiboot/ISOS/$JustISO (hd32)$\r$\nmap --hook$\r$\nchainloader (hd32)$\r$\n#end $JustISOName" $R0 
		 
		 ${ElseIf} $DistroName == "Try Unlisted ISO (GRUB from RAM)" 
		 CopyFiles $ISOFile "$BootDir\multiboot\ISOS\$JustISO"
		 ${WriteToFile} "#start $JustISOName$\r$\n#Modify the following memory based entry if it does not boot$\r$\ntitle Boot $JustISO from Memory$\r$\nfind --set-root --ignore-floppies --ignore-cd /multiboot/ISOS/$JustISO$\r$\nmap --heads=0 --sectors-per-track=0 --mem /multiboot/ISOS/$JustISO (hd32)$\r$\nmap --hook$\r$\nroot (hd32)$\r$\nchainloader (hd32)$\r$\n#end $JustISOName" $R0
		 
		; Ultimate Boot CD (Diagnostics Tools)
		; ${ElseIf} $DistroName == "Ultimate Boot CD (Diagnostics Tools)"  
		; CopyFiles $ISOFile "$BootDir\multiboot\ISOS\$JustISO"
		; ${WriteToFile} "#start $JustISOName$\r$\nlabel Ultimate Boot CD ($JustISOName)$\r$\nmenu label Ultimate Boot CD ($JustISOName)$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/menu/ubcd.lst$\r$\n#end $JustISOName" $R0   
		; File /oname=$PLUGINSDIR\ubcd.lst "Menu\ubcd.lst"  
		; CopyFiles "$PLUGINSDIR\ubcd.lst" "$BootDir\multiboot\menu\ubcd.lst" 
		; !insertmacro ReplaceInFile "SLUG" "$JustISO" "all" "all" "$BootDir\multiboot\menu\ubcd.lst"  
		 
		 ${ElseIf} $DistroName == "Puppy Arcade"  
		 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y'  
		 ${WriteToFile} "#start $JustISOName$\r$\nlabel $JustISOName$\r$\nmenu label $JustISOName$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/$JustISOName/arcade.lst$\r$\n#end $JustISOName" $R0   
		 File /oname=$PLUGINSDIR\arcade.lst "Menu\arcade.lst"  
		 CopyFiles "$PLUGINSDIR\arcade.lst" "$BootDir\multiboot\$JustISOName\arcade.lst" 
		 !insertmacro ReplaceInFile "SLUG" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\arcade.lst"  
		 
		 ${ElseIf} $DistroName == "Super Grub2 Disk"  
		 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y'  
		 ${WriteToFile} "#start $JustISOName$\r$\nlabel $JustISOName$\r$\nmenu label $JustISOName$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/$JustISOName/sgd.lst$\r$\n#end $JustISOName" $R0   
		 File /oname=$PLUGINSDIR\sgd.lst "Menu\sgd.lst"  
		 CopyFiles "$PLUGINSDIR\sgd.lst" "$BootDir\multiboot\$JustISOName\sgd.lst" 
		 !insertmacro ReplaceInFile "SLUG" "$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\sgd.lst"   
	 
	 ; Vba32 Rescue - NOT READY YET
	 ; ${ElseIf} $DistroName == "Vba32 Rescue"
	 ; ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\" -y' 
	 ; ${WriteToFile} "#start $JustISOName$\r$\nLABEL Vba32 Rescue ($JustISOName)$\r$\nMENU LABEL Vba32 Rescue ($JustISOName)$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/$JustISOName/vba/kernel$\r$\nAPPEND initrd=/multiboot/$JustISOName/vba/initrd$\r$\n#end $JustISOName" $R0
	 
	 ${Else}
	 ;Else:
	 ; Start Catch All Install Methods 
	 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y'  
	 Call FindConfig
	 ${WriteToFile} "#start $JustISOName$\r$\nLABEL $JustISOName$\r$\nMENU LABEL $JustISOName$\r$\nMENU INDENT 1$\r$\nCONFIG /multiboot/$JustISOName/$ConfigPath/$ConfigFile$\r$\nAPPEND /multiboot/$JustISOName/$ConfigPath$\r$\n#end $JustISOName" $R0 

	 ; For Ubuntu Desktop and derivatives
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg" ; Rename the following for isolinux txt.cfg
	  !insertmacro ReplaceInFile "file=/cdrom/preseed/" "file=/cdrom/multiboot/$JustISOName/preseed/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg"  
	  !insertmacro ReplaceInFile "initrd=/casper/" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid live-media-path=/multiboot/$JustISOName/casper/ initrd=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg"  
	  !insertmacro ReplaceInFile "kernel /casper/" "kernel /multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg"  
	  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\text.cfg" ; Rename the following for isolinux text.cfg
	  !insertmacro ReplaceInFile "file=/cdrom/preseed/" "file=/cdrom/multiboot/$JustISOName/preseed/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\text.cfg"  
	  !insertmacro ReplaceInFile "initrd=/casper/" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid live-media-path=/multiboot/$JustISOName/casper/ initrd=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\text.cfg"  
	  !insertmacro ReplaceInFile "kernel /casper/" "kernel /multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\text.cfg"  
	  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" ; Rename the following for isolinux.cfg
	  !insertmacro ReplaceInFile "file=/cdrom/preseed/" "file=/cdrom/multiboot/$JustISOName/preseed/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"  
	  !insertmacro ReplaceInFile "initrd=/casper/" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid live-media-path=/multiboot/$JustISOName/casper/ initrd=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"  
	  !insertmacro ReplaceInFile "kernel /casper/" "kernel /multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"  
	  ${EndIf}
	  
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\menuentries.cfg" ; Rename the following for menuentries.cfg
	  ;!insertmacro ReplaceInFile "file=/cdrom/preseed/" "file=/cdrom/multiboot/$JustISOName/preseed/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\menuentries.cfg"  
	  !insertmacro ReplaceInFile "KERNEL /casper/" "KERNEL /multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\menuentries.cfg"  
	  !insertmacro ReplaceInFile "INITRD /casper/" "INITRD /multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\menuentries.cfg"  
	  !insertmacro ReplaceInFile "boot=casper" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid boot=NULL live-media-path=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\menuentries.cfg"  
	  !insertmacro ReplaceInFile "boot=NULL" "boot=casper" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\menuentries.cfg"   
	  ${EndIf}
		
	 ; For ChaletOS
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\chaletos32bit\*.*" 
	  !insertmacro ReplaceInFile "file=/cdrom" "file=/multiboot/$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"  
	  !insertmacro ReplaceInFile "initrd=/chaletos" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid initrd=/multiboot/$JustISOName/chaletos" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"  
	  !insertmacro ReplaceInFile "kernel /chaletos" "kernel /multiboot/$JustISOName/chaletos" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"   
	  !insertmacro ReplaceInFile "live-media-path=chaletos" "live-media-path=/multiboot/$JustISOName/chaletos" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"   
	  !insertmacro ReplaceInFile "file=/cdrom" "file=/multiboot/$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\bootproblemmenu.cfg"  
	  !insertmacro ReplaceInFile "initrd=/chaletos" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid initrd=/multiboot/$JustISOName/chaletos" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\bootproblemmenu.cfg"  
	  !insertmacro ReplaceInFile "kernel /chaletos" "kernel /multiboot/$JustISOName/chaletos" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\bootproblemmenu.cfg"   
	  !insertmacro ReplaceInFile "live-media-path=chaletos" "live-media-path=/multiboot/$JustISOName/chaletos" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\bootproblemmenu.cfg"   
	  ${EndIf}  
	  
	 ; Alt For derivatives like Dr.Web Livedisk
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\syslinux\txt.cfg" ; Rename the following for syslinux txt.cfg
	  !insertmacro ReplaceInFile "file=/cdrom/preseed/" "file=/cdrom/multiboot/$JustISOName/preseed/" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\txt.cfg"  
	  !insertmacro ReplaceInFile "initrd=/casper/" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid live-media-path=/multiboot/$JustISOName/casper/ initrd=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\txt.cfg"  
	  !insertmacro ReplaceInFile "kernel /casper/" "kernel /multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\txt.cfg"  
	  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\syslinux\text.cfg" ; Rename the following for syslinux text.cfg
	  !insertmacro ReplaceInFile "file=/cdrom/preseed/" "file=/cdrom/multiboot/$JustISOName/preseed/" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\text.cfg"  
	  !insertmacro ReplaceInFile "initrd=/casper/" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid live-media-path=/multiboot/$JustISOName/casper/ initrd=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\text.cfg"  
	  !insertmacro ReplaceInFile "kernel /casper/" "kernel /multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\text.cfg"  
	  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg" ; Rename the following for syslinux.cfg
	  !insertmacro ReplaceInFile "file=/cdrom/preseed/" "file=/cdrom/multiboot/$JustISOName/preseed/" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg"  
	  !insertmacro ReplaceInFile "initrd=/casper/" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid live-media-path=/multiboot/$JustISOName/casper/ initrd=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg"  
	  !insertmacro ReplaceInFile "kernel /casper/" "kernel /multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg"  
	  ${EndIf}

	 ; Disable Ubuntu modified gfxboot as older Ubuntu bootlogo archives might not contain all necessary files for newer syslinux 6+.
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" ; Rename the following for isolinux.cfg  
		 ${StrContains} $0 "buntu-17" "$JustISO"   
		 ${StrContains} $1 "buntu-16" "$JustISO"
		 ${StrContains} $2 "buntu-15" "$JustISO" 
		 ${StrContains} $3 "buntu" "$JustISO" 		 
		 ${If} $0 != "buntu-17" 
		 ${AndIf} $1 != "buntu-16"  
		 ${AndIf} $2 != "buntu-15"  
		 ${AndIf} $3 == "buntu" 	 
		 !insertmacro ReplaceInFile "ui gfxboot bootlogo" "# ui gfxboot bootlogo" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"   
		 ${EndIf}
	   ${EndIf}  
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg"
		 ${StrContains} $0 "buntu-17" "$JustISO"   
		 ${StrContains} $1 "buntu-16" "$JustISO"
		 ${StrContains} $2 "buntu-15" "$JustISO" 
		 ${StrContains} $3 "buntu" "$JustISO" 		 
		 ${If} $0 != "buntu-17" 
		 ${AndIf} $1 != "buntu-16"  
		 ${AndIf} $2 != "buntu-15" 
		 ${AndIf} $3 == "buntu" 	 
		 !insertmacro ReplaceInFile "ui gfxboot bootlogo" "# ui gfxboot bootlogo" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg"      
		 ${EndIf}
	   ${EndIf}
	 ; Various Antivius (New Method) 
	  ${If} $DistroName == "ESET SysRescue Live"
	  ;${OrIf} $DistroName == "Dr.Web LiveDisk" 
	  ${OrIf} $DistroName == "Boot Repair Disk 32bit"  
	  ${OrIf} $DistroName == "Boot Repair Disk 64bit" 
	  ${OrIf} $DistroName == "Elementary OS"   
	  ${OrIf} $DistroName == "Zorin OS Core"   
	 ; Disable Ubuntu modified gfxboot as the Ubuntu bootlogo archive does not currently contain all necessary files for newer syslinux 6+.
	 	${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" ; Rename the following for isolinux.cfg  
		!insertmacro ReplaceInFile "ui gfxboot bootlogo" "# ui gfxboot bootlogo" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"   
		${EndIf} 
		${If} ${FileExists} "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg"
		!insertmacro ReplaceInFile "ui gfxboot bootlogo" "# ui gfxboot bootlogo" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg"      
		${EndIf}
	  ${EndIf}
	  
	 ; Vinux Project / Trisquel
	  ${If} $DistroName == "Vinux (for visually impaired)"  
	  ${OrIf} $DistroName == "Trisquel"  
		 !insertmacro ReplaceInFile "ui gfxboot" "#ui gfxboot" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"  
	  ${EndIf}  
		  
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\grub\loopback.cfg" ; Rename the following for grub loopback.cfg
	  !insertmacro ReplaceInFile "file=/cdrom/preseed/" "file=/cdrom/multiboot/$JustISOName/preseed/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\loopback.cfg"  
	  !insertmacro ReplaceInFile "/casper/vmlinuz" "/multiboot/$JustISOName/casper/vmlinuz" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\loopback.cfg"  
	  !insertmacro ReplaceInFile "/casper/initrd" "/multiboot/$JustISOName/casper/initrd" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\loopback.cfg" 
	  !insertmacro ReplaceInFile "boot=casper" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid boot=NULL live-media-path=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\loopback.cfg"  
	  !insertmacro ReplaceInFile "boot=NULL" "boot=casper" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\loopback.cfg"  
	  ${EndIf}
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg" ; Rename the following for grub.cfg
	  !insertmacro ReplaceInFile "file=/cdrom/preseed/" "file=/cdrom/multiboot/$JustISOName/preseed/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg"  
	  !insertmacro ReplaceInFile "/casper/vmlinuz" "/multiboot/$JustISOName/casper/vmlinuz" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg"  
	  !insertmacro ReplaceInFile "/casper/initrd" "/multiboot/$JustISOName/casper/initrd" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg"   
	  !insertmacro ReplaceInFile "boot=casper" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid boot=NULL live-media-path=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg"  
	  !insertmacro ReplaceInFile "boot=NULL" "boot=casper" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg"  
	  ${EndIf}  

	 ; For Ubuntu Server  
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\install\netboot\ubuntu-installer\i386\*.*"  
	   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg" ; Rename the following for isolinux txt.cfg
	   !insertmacro ReplaceInFile "initrd=/install/" "cdrom-detect/try-usb=true noprompt initrd=/multiboot/$JustISOName/install/netboot/ubuntu-installer/i386/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg"  
	   !insertmacro ReplaceInFile "kernel /install/vmlinuz" "kernel /multiboot/$JustISOName/install/netboot/ubuntu-installer/i386/linux" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg"    
	   ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\install\netboot\ubuntu-installer\i386\*.*"     
	   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\text.cfg" ; Rename the following for isolinux text.cfg  
	   !insertmacro ReplaceInFile "initrd=/install/" "cdrom-detect/try-usb=true noprompt initrd=/multiboot/$JustISOName/install/netboot/ubuntu-installer/i386/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\text.cfg"  
	   !insertmacro ReplaceInFile "kernel /install/vmlinuz" "kernel /multiboot/$JustISOName/install/netboot/ubuntu-installer/i386/linux" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\text.cfg"   
	   ; Ubuntu Server amd64
	   ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\install\netboot\ubuntu-installer\amd64\*.*"  
	   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg" ; Rename the following for isolinux txt.cfg
	   !insertmacro ReplaceInFile "initrd=/install/" "cdrom-detect/try-usb=true noprompt initrd=/multiboot/$JustISOName/install/netboot/ubuntu-installer/amd64/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg"  
	   !insertmacro ReplaceInFile "kernel /install/vmlinuz" "kernel /multiboot/$JustISOName/install/netboot/ubuntu-installer/amd64/linux" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg"    
	   ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\install\netboot\ubuntu-installer\amd64\*.*"     
	   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\text.cfg" ; Rename the following for isolinux text.cfg  
	   !insertmacro ReplaceInFile "initrd=/install/" "cdrom-detect/try-usb=true noprompt initrd=/multiboot/$JustISOName/install/netboot/ubuntu-installer/amd64/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\text.cfg"  
	   !insertmacro ReplaceInFile "kernel /install/vmlinuz" "kernel /multiboot/$JustISOName/install/netboot/ubuntu-installer/amd64/linux" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\text.cfg"    
	  ${EndIf}  
	  
	 ; OpenMediaVault - NOT WORKING YET
	  ; ${IfNot} ${FileExists} "$BootDir\multiboot\$JustISOName\install\netboot\ubuntu-installer\i386\*.*"  
	   ; ${AndIfNot} ${FileExists} "$BootDir\multiboot\$JustISOName\install\netboot\ubuntu-installer\amd64\*.*" 
		; ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\live.cfg" 
	   ; !insertmacro ReplaceInFile "kernel /install/vmlinuz" "kernel /multiboot/$JustISOName/install/vmlinuz" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\live.cfg"   
	   ; !insertmacro ReplaceInFile "initrd=/install/initrd.gz" "initrd=/multiboot/$JustISOName/install/initrd.gz" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\live.cfg"   
	   ; ${EndIf} 
	  
	 ; For Debian Based and derivatives
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" ; Rename the following for isolinux.cfg
	  !insertmacro ReplaceInFile "linux /live/" "linux /multiboot/$JustISOName/live/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"  
	  ${EndIf}
	  
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\live.cfg" ; Rename the following for isolinux live.cfg
	  !insertmacro ReplaceInFile "linux /live/" "linux /multiboot/$JustISOName/live/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\live.cfg"  
	  !insertmacro ReplaceInFile "initrd /live/" "initrd /multiboot/$JustISOName/live/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\live.cfg" 
	  !insertmacro ReplaceInFile "append boot=live" "append live-media-path=/multiboot/$JustISOName/live cdrom-detect/try-usb=true noprompt boot=live" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\live.cfg" 
	  ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\install.cfg" ; Rename the following for isolinux install.cfg  
	  !insertmacro ReplaceInFile "linux /install/" "linux /multiboot/$JustISOName/install/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\install.cfg"  
	  !insertmacro ReplaceInFile "initrd /install/" "initrd /multiboot/$JustISOName/install/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\install.cfg" 
	  !insertmacro ReplaceInFile "-- quiet" "cdrom-detect/try-usb=true quiet" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\install.cfg"
	  ${EndIf}  
	  
	 ; Newer Debian Based and derivatives 
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\menu.cfg" ; Rename the following for isolinux live.cfg
	  !insertmacro ReplaceInFile "linux /live" "linux /multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\menu.cfg"  
	  !insertmacro ReplaceInFile "initrd=/live" "initrd=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\menu.cfg" 
	  !insertmacro ReplaceInFile "boot=live components" "boot=live live-media-path=/multiboot/$JustISOName/live cdrom-detect/try-usb=true noprompt components" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\menu.cfg" 
	  !insertmacro ReplaceInFile "linux /d-i" "linux /multiboot/$JustISOName/d-i" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\menu.cfg"  
	  !insertmacro ReplaceInFile "initrd=/d-i" "initrd=/multiboot/$JustISOName/d-i" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\menu.cfg" 
	  ${EndIf}  
	  
	 ; SolydX
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\solydxk\filesystem.squashfs" 
	  !insertmacro ReplaceInFile "kernel /solydxk" "kernel /multiboot/$JustISOName/solydxk" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	  !insertmacro ReplaceInFile "initrd=/solydxk" "initrd=/multiboot/$JustISOName/solydxk" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	  !insertmacro ReplaceInFile "live-media-path=/solydxk" "live-media-path=/multiboot/$JustISOName/solydxk" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"   
	  ${EndIf} 
		
	 ; For Desinfec't Distro 
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\os.cfg" ; Rename the following for isolinux os.cfg
	  !insertmacro ReplaceInFile "file=/cdrom/preseed/" "file=/cdrom/multiboot/$JustISOName/preseed/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\os.cfg"  
	  !insertmacro ReplaceInFile "initrd=/casper/" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid live-media-path=/multiboot/$JustISOName/casper/ initrd=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\os.cfg"  
	  !insertmacro ReplaceInFile "kernel /casper/" "kernel /multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\os.cfg"    
	  !insertmacro ReplaceInFile "BOOT_IMAGE=/casper/" "BOOT_IMAGE=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\os.cfg"    
	  ${EndIf} 
	   
	 ; For Fedora Based and derivatives
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" 
	   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\LiveOS\livecd-iso-to-disk"  ; Probably Fedora based
	   !insertmacro ReplaceInFile "root=live:CDLABEL=" "root=live:LABEL=MULTIBOOT live_dir=/multiboot/$JustISOName/LiveOS rd.live.dir=/multiboot/$JustISOName/LiveOS NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"   
	   ${EndIf} 

	 ; For Puppy Based and derivatives
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux.cfg" 
	   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\help2.msg"  ; Probably Puppy based  
	   !insertmacro ReplaceInFile "pmedia=cd" "psubdir=/multiboot/$JustISOName psubok=TRUE" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux.cfg"    
	   !insertmacro ReplaceInFile "append pfix=" "append psubdir=/multiboot/$JustISOName psubok=TRUE pfix=" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux.cfg"       
	   !insertmacro ReplaceInFile "#append rootfstype=ramfs" "append psubdir=/multiboot/$JustISOName psubok=TRUE" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux.cfg"       
	  
	   ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux.cfg" 
	   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\help\help.msg"  ; Probably Puppy based 
	   !insertmacro ReplaceInFile "append search" "append search psubdir=/multiboot/$JustISOName psubok=TRUE" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux.cfg"       
	   !insertmacro ReplaceInFile "#append rootfstype=ramfs" "append psubdir=/multiboot/$JustISOName psubok=TRUE" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux.cfg"       
	   !insertmacro ReplaceInFile "append pfix=" "append psubdir=/multiboot/$JustISOName psubok=TRUE pfix=" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux.cfg"       
	   ${EndIf} 
	  
	 ; For Clonezilla, and DRBL
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg" ; Rename the following for syslinux syslinux.cfg
	  !insertmacro ReplaceInFile "kernel /live" "kernel /multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg"  
	  !insertmacro ReplaceInFile "initrd=/live" "live-media-path=/multiboot/$JustISOName/live/ initrd=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\syslinux\syslinux.cfg"  
	  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" ; Rename the following for isolinux isolinux.cfg
	  !insertmacro ReplaceInFile "kernel /live" "kernel /multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"  
	  !insertmacro ReplaceInFile "initrd=/live" "live-media-path=/multiboot/$JustISOName/live/ initrd=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" 
	 ; Linux Mint 2014
	  !insertmacro ReplaceInFile "live-media-path=/live" "live-media-path=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"  
	  ${EndIf}
	  
	 ; Xpud
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\vesamenu.c32"
	  ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\opt\media"  
	  !insertmacro ReplaceInFile "KERNEL /boot/" "KERNEL /multiboot/$JustISOName/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	  !insertmacro ReplaceInFile "/opt/media,/opt/scim" "/multiboot/$JustISOName/opt/media,/multiboot/$JustISOName/opt/scim" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	  !insertmacro ReplaceInFile "DEFAULT /boot/" "DEFAULT /multiboot/$JustISOName/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"   
	  !insertmacro ReplaceInFile "MENU BACKGROUND /boot/" "MENU BACKGROUND /multiboot/$JustISOName/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	  !insertmacro ReplaceInFile "APPEND initrd=/opt/media" "APPEND initrd=/multiboot/$JustISOName/opt/media" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"   
	  ${EndIf}
	  
	; AntivirusLiveCD, Comodo
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\bzImage"  
	  !insertmacro ReplaceInFile "kernel /boot/bzImage" "kernel /multiboot/$JustISOName/boot/bzImage" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	  ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\initrd*" 
	  ${OrIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\rootfs*"   
	  !insertmacro ReplaceInFile "append initrd=/boot" "append initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	  ${EndIf} 
	  
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\*.jpg" ; Fix background Image Paths
	  ${OrIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\*.png"   
	  !insertmacro ReplaceInFile "MENU BACKGROUND /boot" "MENU BACKGROUND /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"   
	  ${EndIf} 
	  
	; AOSS
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\system\stage1"  
	   !insertmacro ReplaceInFile "KERNEL /system" "KERNEL /multiboot/$JustISOName/system" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	   !insertmacro ReplaceInFile "initrd=/system" "initrd=/multiboot/$JustISOName/system" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"    
	   !insertmacro ReplaceInFile "boot=cdrom" "boot=usb" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"    
	   ${EndIf} 
	   
	; TinyCore, + REVISIT WifiWay, + REVISIT Dr.Web
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\vmlinuz"  
	   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\initrd" 
	   ${OrIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\initrd.gz"  
	   ${OrIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\initrd.lz"     
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	   ${EndIf}
	   
	; WifiSlax Old Entry
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\menus\wifislax.cfg"  
	   !insertmacro ReplaceInFile "/boot/" "/multiboot/$JustISOName/NULL/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg" 
	   !insertmacro ReplaceInFile "/NULL/" "/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"     
	   
	   !insertmacro ReplaceInFile "/boot/" "/multiboot/$JustISOName/NULL/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg" 
	   !insertmacro ReplaceInFile "/NULL/" "/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg" 
	   
	   !insertmacro ReplaceInFile "/boot/" "/multiboot/$JustISOName/NULL/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\wifislax.cfg" 
	   !insertmacro ReplaceInFile "/NULL/" "/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\wifislax.cfg"  

	   !insertmacro ReplaceInFile "/boot/" "/multiboot/$JustISOName/NULL/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\wifislax-english.cfg" 
	   !insertmacro ReplaceInFile "/NULL/" "/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\wifislax-english.cfg"   
	   
	   !insertmacro ReplaceInFile "/boot/" "/multiboot/$JustISOName/NULL/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-normal.cfg" 
	   !insertmacro ReplaceInFile "/NULL/" "/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-normal.cfg"
	   !insertmacro ReplaceInFile "/vmlinuz" "/NULL from=multiboot/$JustISOName noauto" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-normal.cfg" 
	   !insertmacro ReplaceInFile "/NULL" "/vmlinuz" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-normal.cfg"
	   !insertmacro ReplaceInFile "changes=" "NULL=/multiboot/$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-normal.cfg" 
	   !insertmacro ReplaceInFile "NULL=" "changes=" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-normal.cfg"
	   
	   !insertmacro ReplaceInFile "/boot/" "/multiboot/$JustISOName/NULL/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-normal.cfg"
	   !insertmacro ReplaceInFile "/NULL/" "/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-normal.cfg"
	   !insertmacro ReplaceInFile "/vmlinuz" "/NULL from=multiboot/$JustISOName noauto" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-normal.cfg" 
	   !insertmacro ReplaceInFile "/NULL" "/vmlinuz" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-normal.cfg"
	   !insertmacro ReplaceInFile "changes=" "NULL=/multiboot/$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-normal.cfg" 
	   !insertmacro ReplaceInFile "NULL=" "changes=" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-normal.cfg"

	   !insertmacro ReplaceInFile "/boot/" "/multiboot/$JustISOName/NULL/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-pae.cfg" 
	   !insertmacro ReplaceInFile "/NULL/" "/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-pae.cfg"
	   !insertmacro ReplaceInFile "/vmlinuz2" "/NULL from=multiboot/$JustISOName noauto" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-pae.cfg"
	   !insertmacro ReplaceInFile "/NULL" "/vmlinuz2" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-pae.cfg"
	   !insertmacro ReplaceInFile "changes=" "NULL=/multiboot/$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-pae.cfg"
	   !insertmacro ReplaceInFile "NULL=" "changes=" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-pae.cfg"

	   !insertmacro ReplaceInFile "/boot/" "/multiboot/$JustISOName/NULL/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-pae.cfg"
	   !insertmacro ReplaceInFile "/NULL/" "/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-pae.cfg"   
	   !insertmacro ReplaceInFile "/vmlinuz2" "/NULL from=multiboot/$JustISOName noauto" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-pae.cfg"
	   !insertmacro ReplaceInFile "/NULL" "/vmlinuz2" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-pae.cfg"
	   !insertmacro ReplaceInFile "changes=" "NULL=/multiboot/$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-pae.cfg"
	   !insertmacro ReplaceInFile "NULL=" "changes=" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-pae.cfg"
	   
	   !insertmacro ReplaceInFile "/boot/" "/multiboot/$JustISOName/NULL/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-smp.cfg" 
	   !insertmacro ReplaceInFile "/NULL/" "/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-smp.cfg"
	   !insertmacro ReplaceInFile "/vmlinuz2" "/NULL from=multiboot/$JustISOName noauto" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-smp.cfg"
	   !insertmacro ReplaceInFile "/NULL" "/vmlinuz2" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-smp.cfg"
	   !insertmacro ReplaceInFile "changes=" "NULL=/multiboot/$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-smp.cfg"
	   !insertmacro ReplaceInFile "NULL=" "changes=" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\kernel-smp.cfg"

	   !insertmacro ReplaceInFile "/boot/" "/multiboot/$JustISOName/NULL/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-smp.cfg"
	   !insertmacro ReplaceInFile "/NULL/" "/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-smp.cfg"   
	   !insertmacro ReplaceInFile "/vmlinuz2" "/NULL from=multiboot/$JustISOName noauto" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-smp.cfg"
	   !insertmacro ReplaceInFile "/NULL" "/vmlinuz2" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-smp.cfg"
	   !insertmacro ReplaceInFile "changes=" "NULL=/multiboot/$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-smp.cfg"
	   !insertmacro ReplaceInFile "NULL=" "changes=" "all" "all" "$BootDir\multiboot\$JustISOName\boot\menus\english-kernel-smp.cfg"   
	   ${EndIf}
	   
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\core.gz" ; TinyCore specific
	   !insertmacro ReplaceInFile "initrd=/boot/core.gz" "initrd=/multiboot/$JustISOName/boot/core.gz" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	   !insertmacro ReplaceInFile "INITRD /boot/core.gz" "INITRD /multiboot/$JustISOName/boot/core.gz" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"     
	   ${EndIf}
	   
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\tinycore.gz" ; Partition Wizard, TinyCore specific 
	   !insertmacro ReplaceInFile "initrd=/boot/tinycore.gz" "initrd=/multiboot/$JustISOName/boot/tinycore.gz" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	   !insertmacro ReplaceInFile "INITRD /boot/tinycore.gz" "INITRD /multiboot/$JustISOName/boot/tinycore.gz" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"     
	   ${EndIf}   
	   
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\casper\tinycore.gz" ; Partition Wizard specific 
	   !insertmacro ReplaceInFile "initrd=/casper/tinycore.gz" "initrd=/multiboot/$JustISOName/casper/tinycore.gz" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	   !insertmacro ReplaceInFile "INITRD /casper/tinycore.gz" "INITRD /multiboot/$JustISOName/casper/tinycore.gz" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"     
		${If} ${FileExists} "$BootDir\multiboot\$JustISOName\casper\vmlinuz.efi" 
		${OrIf} ${FileExists} "$BootDir\multiboot\$JustISOName\casper\vmlinuz"  
		!insertmacro ReplaceInFile "kernel /casper" "kernel /multiboot/$JustISOName/casper" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
		${EndIf}   
	   ${EndIf}       
	   
	; F-Secure Rescue CD
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\isolinux\fsecure\linux"  
	   !insertmacro ReplaceInFile "kernel fsecure" "kernel /multiboot/$JustISOName/boot/isolinux/fsecure" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	   !insertmacro ReplaceInFile "initrd=fsecure" "initrd=/multiboot/$JustISOName/boot/isolinux/fsecure" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	   !insertmacro ReplaceInFile "fsecure/boot." "/multiboot/$JustISOName/boot/isolinux/fsecureNULL/boot." "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	   !insertmacro ReplaceInFile "fsecureNULL/boot." "fsecure/boot." "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"    
	   !insertmacro ReplaceInFile "APPEND ramdisk_size" "APPEND noprompt knoppix_dir=/multiboot/$JustISOName/KNOPPIX ramdisk_size" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	   ${EndIf}   

	; GData
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\linux6"  
	   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	   !insertmacro ReplaceInFile "INITRD /boot" "INITRD /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	   !insertmacro ReplaceInFile "APPEND boot=live" "APPEND live-media-path=/multiboot/$JustISOName/live boot=live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"
	   ${EndIf} 
	   
	; Solus
	   ; ${If} $DistroName == "Solus"
	   ; !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	   ; !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	   ; ${EndIf}    

	; Liberte
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\liberte\boot\syslinux\syslinux.cfg"  
	   !insertmacro ReplaceInFile "/liberte/boot/syslinux/" "" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	   !insertmacro ReplaceInFile "/liberte/boot/" "/multiboot/$JustISOName/liberte/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	   !insertmacro ReplaceInFile "cdroot_hash=" "initrd=/multiboot/$JustISOName/liberte/boot/initrd-x86.xz loop=/multiboot/$JustISOName/liberte/boot/root-x86.sfs NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"   
	   ${EndIf}    

	; Panda Safe CD, Tails
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\live.cfg"  
	   !insertmacro ReplaceInFile "kernel /live" "kernel /multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live.cfg" 
	   !insertmacro ReplaceInFile "initrd=/live" "initrd=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live.cfg" 
	   !insertmacro ReplaceInFile "live-media=removable" "" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live.cfg"    
	   !insertmacro ReplaceInFile "append initrd=" "append noprompt live-media-path=/multiboot/$JustISOName/live initrd=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live.cfg"
	   ${EndIf}   
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\live486.cfg"  ; Tails Specific 486
	   !insertmacro ReplaceInFile "kernel /live" "kernel /multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live486.cfg"  
	   !insertmacro ReplaceInFile "initrd=/live" "initrd=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live486.cfg" 
	   !insertmacro ReplaceInFile "live-media=removable" "" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live486.cfg"   
	   !insertmacro ReplaceInFile "append initrd=" "append noprompt live-media-path=/multiboot/$JustISOName/live initrd=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live486.cfg"
	   ${EndIf}   
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\live686.cfg"  ; Tails Specific
	   !insertmacro ReplaceInFile "kernel /live" "kernel /multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live686.cfg"  
	   !insertmacro ReplaceInFile "initrd=/live" "initrd=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live686.cfg" 
	   !insertmacro ReplaceInFile "live-media=removable" "" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live686.cfg"    
	   !insertmacro ReplaceInFile "append initrd=" "append noprompt live-media-path=/multiboot/$JustISOName/live initrd=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live686.cfg"    
	   ${EndIf}   
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\isolinux.cfg"  
	   !insertmacro ReplaceInFile "default /isolinux/vesamenu.c32" "default /multiboot/$JustISOName/isolinux/vesamenu.c32" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	   ${EndIf}   
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\splash.png"   
	   !insertmacro ReplaceInFile "menu background /isolinux" "menu background /multiboot/$JustISOName/isolinux" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\stdmenu.cfg"   
	   ${EndIf} 
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\liveamd64.cfg"  ; Tails Specific
	   !insertmacro ReplaceInFile "kernel /live" "kernel /multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\liveamd64.cfg"  
	   !insertmacro ReplaceInFile "initrd=/live" "initrd=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\liveamd64.cfg" 
	   !insertmacro ReplaceInFile "live-media=removable" "" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\liveamd64.cfg"    
	   !insertmacro ReplaceInFile "append initrd=" "append noprompt live-media-path=/multiboot/$JustISOName/live initrd=" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\liveamd64.cfg"    
	   ${EndIf} 
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\live64.cfg"  ; Tails Specific
	   !insertmacro ReplaceInFile "kernel /live" "kernel /multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\live64.cfg"  
	   !insertmacro ReplaceInFile "initrd=/live" "initrd=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\live64.cfg" 
	   !insertmacro ReplaceInFile "live-media=removable" "" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\live64.cfg"    
	   !insertmacro ReplaceInFile "append initrd=" "append noprompt live-media-path=/multiboot/$JustISOName/live initrd=" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\live64.cfg"    
	   ${EndIf}    
	   
	; Webconverger
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\live.cfg"  
	   !insertmacro ReplaceInFile "kernel /live" "kernel /multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\boot\live.cfg"  
	   !insertmacro ReplaceInFile "initrd=/live" "noprompt live-media-path=/multiboot/$JustISOName/live initrd=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\boot\live.cfg" 
	   ${EndIf} 

	; AntiX
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\antiX\vmlinuz"  
	   !insertmacro ReplaceInFile "/antiX/vmlinuz" "/multiboot/$JustISOName/antiX/vmlinuz" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	   !insertmacro ReplaceInFile "INITRD /antiX" "INITRD /multiboot/$JustISOName/antiX" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	   !insertmacro ReplaceInFile "APPEND quiet" "APPEND bdir=/multiboot/$JustISOName/antiX blab=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	   ;!insertmacro ReplaceInFile "UI gfxboot" "default vesamenu.c32 $\r$\nprompt 0 #" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"    
	   ${EndIf}   
	   
	; Archlinux
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso.cfg"    
	   !insertmacro ReplaceInFile "CONFIG /arch" "CONFIG /multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	   !insertmacro ReplaceInFile "APPEND /arch" "APPEND /multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
		  
	   !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_pxe64.cfg"     
	   !insertmacro ReplaceInFile "archisolabel=ARCH" "archisolabel=MULTIBOOT NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_pxe64.cfg"     
	   !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_pxe32.cfg"     
	   !insertmacro ReplaceInFile "archisolabel=ARCH" "archisolabel=MULTIBOOT NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_pxe32.cfg"  

	   !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys.cfg"     
	   !insertmacro ReplaceInFile "archisolabel=ARCH" "archisolabel=MULTIBOOT NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys.cfg"    
	   
	   !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys64.cfg"     
	   !insertmacro ReplaceInFile "archisolabel=ARCH" "archisolabel=MULTIBOOT NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys64.cfg"     
	   !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys32.cfg"     
	   !insertmacro ReplaceInFile "archisolabel=ARCH" "archisolabel=MULTIBOOT NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys32.cfg"     
	   ${EndIf}  
	   
	; ArchBang
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\syslinux.cfg"    
	   !insertmacro ReplaceInFile "CONFIG /arch" "CONFIG /multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	   !insertmacro ReplaceInFile "APPEND /arch" "APPEND /multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	   !insertmacro ReplaceInFile "LINUX /arch" "LINUX /multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\syslinux.cfg"     
	   !insertmacro ReplaceInFile "INITRD /arch" "INITRD /multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\syslinux.cfg"     
	   !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\syslinux.cfg"     
	   !insertmacro ReplaceInFile ",/arch" ",/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\syslinux.cfg"     
	   !insertmacro ReplaceInFile "archisolabel=ARCH" "archisolabel=MULTIBOOT NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\syslinux.cfg"     
	   ${EndIf}     

	; Manjaro/Netrunner
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\.miso"  
	   !insertmacro ReplaceInFile "kernel /manjaro" "kernel /multiboot/$JustISOName/manjaro" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	   !insertmacro ReplaceInFile "append initrd=/manjaro" "append initrd=/multiboot/$JustISOName/manjaro" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	   !insertmacro ReplaceInFile "misobasedir=manjaro" "misobasedir=/multiboot/$JustISOName/manjaro" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"    
	   !insertmacro ReplaceInFile ",/manjaro" ",/multiboot/$JustISOName/manjaro" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	   !insertmacro ReplaceInFile "misolabel=MJRO" "misolabel=MULTIBOOT NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"
	   CopyFiles "$BootDir\multiboot\$JustISOName\.miso" "$BootDir"
	   ${AndIf} $DistroName == "Netrunner" 
	   !insertmacro ReplaceInFile "kernel /netrunner" "kernel /multiboot/$JustISOName/netrunner" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	   !insertmacro ReplaceInFile "append initrd=/netrunner" "append initrd=/multiboot/$JustISOName/netrunner" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	   !insertmacro ReplaceInFile "misobasedir=netrunner" "misobasedir=/multiboot/$JustISOName/netrunner" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"    
	   !insertmacro ReplaceInFile ",/netrunner" ",/multiboot/$JustISOName/netrunner" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	   !insertmacro ReplaceInFile "misolabel=NR" "misolabel=MULTIBOOT NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"
	   ${EndIf}   

	 ; MX Linux
	   ;${If} $DistroName == "MX Linux"
	   ;!insertmacro ReplaceInFile "APPEND bdir=" "APPEND blab=MULTIBOOT bdir=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"
	   ;${EndIf}      

	; Slax
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\slax\boot\syslinux.cfg"  
	   !insertmacro ReplaceInFile "/slax/boot/" "/multiboot/$JustISOName/slax/bootNULL" "all" "all" "$BootDir\multiboot\$JustISOName\slax\boot\syslinux.cfg"  
	   !insertmacro ReplaceInFile "NULL" "/" "all" "all" "$BootDir\multiboot\$JustISOName\slax\boot\syslinux.cfg"   
	   !insertmacro ReplaceInFile "APPEND vga=" "APPEND from=/multiboot/$JustISOName/slax changes=/multiboot/$JustISOName/slax vga=" "all" "all" "$BootDir\multiboot\$JustISOName\slax\boot\syslinux.cfg"
	   ${EndIf}   
	   
	; Not Linux Kid X but maybe Slax Based   
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\syslinux.cfg"  
	   ${AndIf} $DistroName != "Linux Kid X" 
	   !insertmacro ReplaceInFile "DEFAULT /boot/vesamenu.c32" "DEFAULT /multiboot/$JustISOName/boot/vesamenu.c32" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	   !insertmacro ReplaceInFile "APPEND vga=" "APPEND from=/multiboot/$JustISOName changes=/multiboot/$JustISOName vga=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	   ${EndIf}     
	   
	; Porteus
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\syslinux\porteus.cfg"  
	   !insertmacro ReplaceInFile "APPEND initrd=" "APPEND from=/multiboot/$JustISOName initrd=" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\porteus.cfg" 
	   !insertmacro ReplaceInFile "changes=/porteus" "" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\porteus.cfg" ;eventually use changes=/multiboot/$JustISOName/changes.dat
	  ; for later versions
	   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\porteus.cfg"  
	   !insertmacro ReplaceInFile "INITRD /boot" "INITRD /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\porteus.cfg" 
	   !insertmacro ReplaceInFile "UI vesamenu.c32" "UI /multiboot/vesamenu.c32" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\porteus.cfg"  
	   !insertmacro ReplaceInFile "APPEND" "APP END from=/multiboot/$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\porteus.cfg"
	   !insertmacro ReplaceInFile "APP END" "APPEND" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\porteus.cfg"     
	   ${EndIf} 

	; Knoppix - tested on v6 and 7
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg"  
	   ${OrIf} ${FileExists} "$BootDir\multiboot\$JustISOName\KNOPPIX\KNOPPIX"    
	   !insertmacro ReplaceInFile "APPEND lang=" "APPEND noprompt knoppix_dir=/multiboot/$JustISOName/KNOPPIX lang=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	   !insertmacro ReplaceInFile "APPEND ramdisk_size" "APPEND noprompt knoppix_dir=/multiboot/$JustISOName/KNOPPIX ramdisk_size" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"   
	   ${EndIf}  
	   
	; Mandriva
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"
	   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\LiveOS\*.*"   
	   !insertmacro ReplaceInFile "append initrd=" "append live_dir=/multiboot/$JustISOName/LiveOS rd.live.dir=/multiboot/$JustISOName/LiveOS initrd=" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" 
	   !insertmacro ReplaceInFile "root=live:CDLABEL=" "root=live:LABEL=MULTIBOOT NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"    
	   ${EndIf}  
	   
	; VoidLinux
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg"
	   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\LiveOS\*.*" 
	   !insertmacro ReplaceInFile "append initrd=" "append live_dir=/multiboot/$JustISOName/LiveOS rd.live.dir=/multiboot/$JustISOName/LiveOS initrd=" "all" "all" "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg" 
	   !insertmacro ReplaceInFile "root=live:CDLABEL=" "root=live:LABEL=MULTIBOOT NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg"    
	   ${EndIf} 

	; !REVISIT BROKEN Mageia
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"
	   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\loopbacks\distrib-lzma.sqfs"   
	   !insertmacro ReplaceInFile "root=mgalive:LABEL=Mageia" "root=mgalive:LABEL=MULTIBOOT NULL=Mageia" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"  
	   !insertmacro ReplaceInFile "ui gfxboot.c32" "#ui NULL gfxboot.c32" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" 
	   !insertmacro ReplaceInFile "display /boot" "display /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"
	   !insertmacro ReplaceInFile "append initrd=/boot" "append initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"  
	   ${EndIf}     

	; PCLinuxOS
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" 
	   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\livecd.sqfs"    
	   !insertmacro ReplaceInFile "append livecd=livecd" "append fromusb livecd=/multiboot/$JustISOName/livecd" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" 
	   !insertmacro ReplaceInFile "prompt" "#prompt" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"   
	   !insertmacro ReplaceInFile "ui gfxboot.com" "#ui gfxboot.com" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"  
	   !insertmacro ReplaceInFile "timeout" "#timeout" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"    
	   ${EndIf}     
	   
	; SlitaZ
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg"
	   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\*slitaz"   
	   !insertmacro ReplaceInFile "kernel /boot/isolinux" "kernel /multiboot/$JustISOName/boot/isolinux" "all" "all" "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg" 
	   !insertmacro ReplaceInFile ",/boot" ",/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg"  
	   !insertmacro ReplaceInFile "append /md5sum" "append /multiboot/$JustISOName/md5sum" "all" "all" "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg"
	   !insertmacro ReplaceInFile "KERNEL /boot/gpxe" "KERNEL /multiboot/$JustISOName/boot/gpxe" "all" "all" "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg"  
	   !insertmacro ReplaceInFile "LABEL slitaz" "# LABEL slitaz" "all" "all" "$BootDir\multiboot\$JustISOName\boot\isolinux\isolinux.cfg"  
	   ${EndIf}     

	; Easus Disk Copy, Panda Safe CD
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\stdmenu.cfg" 
	   !insertmacro ReplaceInFile "default /$CopyPath/" "default " "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	   !insertmacro ReplaceInFile "menu background /$CopyPath/" "menu background " "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\stdmenu.cfg"  
	   ${EndIf} 
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\bzImage"     
		${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\live.cfg"    
		!insertmacro ReplaceInFile "kernel /bzImage" "kernel /multiboot/$JustISOName/bzImage" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live.cfg"
		!insertmacro ReplaceInFile "initrd=/initrd" "initrd=/multiboot/$JustISOName/initrd" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\live.cfg"   
	   ${EndIf} 
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\bzImage"     
		${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\isolinux.cfg"    
		!insertmacro ReplaceInFile "kernel /bzImage" "kernel /multiboot/$JustISOName/bzImage" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\isolinux.cfg"
		!insertmacro ReplaceInFile "initrd=/initrd" "initrd=/multiboot/$JustISOName/initrd" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\isolinux.cfg"   
	   ${EndIf} 
	 
	; ESET SysRescue Live
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\eset-favicon.ico" 
	   !insertmacro ReplaceInFile "live-media=/dev/disk/by-label/eSysRescueLiveCD" " " "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\txt.cfg"    
	   ${EndIf} 
	   
	; GRML (system rescue)
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\addon_10_grub2.cfg" 
	   !insertmacro ReplaceInFile "kernel /boot/addons/mboot.c32 /boot/grub/grub.img" "kernel /multiboot/$JustISOName/boot/addons/mboot.c32 /multiboot/$JustISOName/boot/grub/grub.img" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\addon_10_grub2.cfg" 
	   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\addon_20_allinone.cfg"  
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\addon_20_allinone.cfg"
	   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\addon_25_gxpe.cfg"     
	   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\addon_30_dos.cfg"     
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\addon_30_dos.cfg" 
	   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\addon_35_bsd.cfg"  
	   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\addon_40_memtest.cfg"  
	   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\addon_45_hdt.cfg"  
	   !insertmacro ReplaceInFile "pciids=/boot" "pciids=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\addon_45_hdt.cfg"    
	   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\hidden.cfg"  
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\hidden.cfg"  
	   !insertmacro ReplaceInFile "live-media-path=/live" "live-media-path=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\hidden.cfg"       
	   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\grml.cfg"  
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\grml.cfg"  
	   !insertmacro ReplaceInFile "live-media-path=/live" "live-media-path=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\grml.cfg"     
	   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\default.cfg"  
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\default.cfg"  
	   !insertmacro ReplaceInFile "live-media-path=/live" "live-media-path=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\default.cfg"  
	   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\default.cfg"  
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\default.cfg"  
	   !insertmacro ReplaceInFile "live-media-path=/live" "live-media-path=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\default.cfg"  
	   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\grml32_full_grml.cfg"  
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\grml32_full_grml.cfg"  
	   !insertmacro ReplaceInFile "live-media-path=/live" "live-media-path=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\grml.cfg"  
	   !insertmacro ReplaceInFile "kernel /boot" "kernel /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\hidden.cfg"  
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\hidden.cfg"  
	   !insertmacro ReplaceInFile "live-media-path=/live" "live-media-path=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\hidden.cfg" 
	   !insertmacro ReplaceInFile "bootid=" "ignore_bootid NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\grml.cfg"  
	   !insertmacro ReplaceInFile "bootid=" "ignore_bootid NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\hidden.cfg"  
	   !insertmacro ReplaceInFile "bootid=" "ignore_bootid NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\default.cfg"
	   !insertmacro ReplaceInFile "bootid=" "ignore_bootid NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\grml.cfg"  
	   !insertmacro ReplaceInFile "bootid=" "ignore_bootid NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\hidden.cfg"
	   !insertmacro ReplaceInFile "bootid=" "ignore_bootid NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\default.cfg"   
		${EndIf}  

	; Ophcrack
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\ophcrack.cfg" 
	   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\ophcrack.cfg" 
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\ophcrack.cfg" 
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\default.cfg" 
	   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\default.cfg"     
	   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\be.cfg" 
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\be.cfg" 
	   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\br.cfg" 
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\br.cfg"
	   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\ca.cfg" 
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\ca.cfg"  
	   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\ca.cfg" 
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\de.cfg"
	   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\de.cfg" 
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\de_CH.cfg" 
	   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\de_CH.cfg"    
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\en.cfg" 
	   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\en.cfg"       
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\es.cfg" 
	   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\es.cfg"  
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\fi.cfg" 
	   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\fi.cfg"  
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\fr.cfg" 
	   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\fr.cfg" 
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\fr_CH.cfg" 
	   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\fr_CH.cfg"   
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\hu.cfg" 
	   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\hu.cfg"    
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\it.cfg" 
	   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\it.cfg" 
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\jp.cfg" 
	   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\jp.cfg"    
	   ${EndIf}  

	; Android-x86   
	  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\android-x86.png" 
	  !insertmacro ReplaceInFile "kernel /kernel" "kernel /multiboot/$JustISOName/kernel" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	  !insertmacro ReplaceInFile "initrd=/initrd.img" "initrd=/multiboot/$JustISOName/initrd.img" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	  ${EndIf}   

	; RIP Linux
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\BOOT\DOC\RIPLINUX.TXT" 
	   !insertmacro ReplaceInFile "F1 /boot" "F1 /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"
	   !insertmacro ReplaceInFile "F2 /boot" "F1 /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"
	   !insertmacro ReplaceInFile "F3 /boot" "F1 /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"
	   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"
	   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"     
	   ${EndIf}  
	   
	; Trinity Rescue Kit
	  ${If} $DistroName == "Trinity Rescue Kit" 
	  CreateDirectory "$BootDir\trk3\" ; Create trk3 directory
	  ${EndIf} 
	  
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\trk3\trkramfs" 
	   CopyFiles "$BootDir\multiboot\$JustISOName\trk3\*.*" "$BootDir\trk3\" 
	   RMDir /R "$BootDir\multiboot\$JustISOName\trk3" 
	   !insertmacro ReplaceInFile "initrd=initrd.trk r" "initrd=initrd.trk vollabel=MULTIBOOT r" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	   ${EndIf}  
	  
	  Call OldSysFix  ; Check for and replace vesamenu.c32, menu.c32, chain.c32 if found 
	 ${EndIf} 
	; End Catch All Install Methods
	  
	; Start Distro Specific 
	 ${If} $JustISO == "ubuntu-13.10-server-i386.iso"
	  ReadEnvStr $R0 COMSPEC ; grab commandline
	  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\pool\main\l\linux\*.ude *.udeb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*.ude *.udeb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
	; Ubuntu Server 12.04 i386
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precise*.deb *precise1_i386.deb" ; rename broken udeb files    
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.deb *precise1_i386.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\linux-headers-3.5.0-23_3.5.0-23.35~precise1_i386.deb linux-headers-3.5.0-23_3.5.0-23.35~precise1_all.deb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files    
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\m\maas\python-maas-provisioningserver*.deb python-maas-provisioningserver_1.2+bzr1373+dfsg-0ubuntu1~12.04.1_all.deb" ; rename broken udeb files     
	  
	 ${ElseIf} $JustISO == "ubuntu-13.10-server-amd64.iso"
	  ReadEnvStr $R0 COMSPEC ; grab commandline
	  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\pool\main\l\linux\*.ude *.udeb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*.ude *.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*.ude *.udeb" ; rename broken udeb files     
	  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\dists\precise\main\dist-upgrader\binary-amd64\*.ude *.udeb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
	; Ubuntu Server 12.04 amd64
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precise*.deb *precise1_amd64.deb" ; rename broken udeb files    
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*precise*.deb *precise1_amd64.deb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.deb *precise1_amd64.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\linux-headers-3.8.0-29_3.8.0-29.42~precise1_amd64.deb linux-headers-3.8.0-29_3.8.0-29.42~precise1_all.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\g\grub2-signed\grub-efi-amd64-signed_1.9~ubuntu12.04.4+1.99-21ubuntu3.10_amd.deb grub-efi-amd64-signed_1.9~ubuntu12.04.4+1.99-21ubuntu3.10_amd64.deb" ; rename broken udeb files   
	  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.deb *precise1_amd64.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\linux-headers-3.5.0-23_3.5.0-23.35~precise1_amd64.deb linux-headers-3.5.0-23_3.5.0-23.35~precise1_all.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\g\grub2-signed\grub-efi-amd64-signed_1.9~ubuntu12.04.3+1.99-21ubuntu3.9_amd6.deb grub-efi-amd64-signed_1.9~ubuntu12.04.3+1.99-21ubuntu3.9_amd64.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\m\maas\python-maas-provisioningserver*.deb python-maas-provisioningserver_1.2+bzr1373+dfsg-0ubuntu1~12.04.1_all.deb" ; rename broken udeb files     

	 ${ElseIf} $JustISO == "ubuntu-13.04-server-i386.iso"
	 ${OrIf} $JustISO == "ubuntu-13.04.2-server-i386.iso"
	 ${OrIf} $JustISO == "ubuntu-13.04.3-server-i386.iso" 
	 ${OrIf} $JustISO == "ubuntu-13.04.4-server-i386.iso" 
	  ReadEnvStr $R0 COMSPEC ; grab commandline
	  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\pool\main\l\linux\*.ude *.udeb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*.ude *.udeb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
	; Ubuntu Server 12.04 i386
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precise*.deb *precise1_i386.deb" ; rename broken udeb files    
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.deb *precise1_i386.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\linux-headers-3.5.0-23_3.5.0-23.35~precise1_i386.deb linux-headers-3.5.0-23_3.5.0-23.35~precise1_all.deb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files    
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\m\maas\python-maas-provisioningserver*.deb python-maas-provisioningserver_1.2+bzr1373+dfsg-0ubuntu1~12.04.1_all.deb" ; rename broken udeb files     
	  
	 ${ElseIf} $JustISO == "ubuntu-13.04-server-i386.iso"
	 ${OrIf} $JustISO == "ubuntu-13.04.2-server-i386.iso"
	 ${OrIf} $JustISO == "ubuntu-13.04.3-server-i386.iso" 
	 ${OrIf} $JustISO == "ubuntu-13.04.4-server-i386.iso" 
	  ReadEnvStr $R0 COMSPEC ; grab commandline
	  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\pool\main\l\linux\*.ude *.udeb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*.ude *.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*.ude *.udeb" ; rename broken udeb files     
	  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\dists\precise\main\dist-upgrader\binary-amd64\*.ude *.udeb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
	; Ubuntu Server 12.04 amd64
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precise*.deb *precise1_amd64.deb" ; rename broken udeb files    
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*precise*.deb *precise1_amd64.deb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.deb *precise1_amd64.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\linux-headers-3.8.0-29_3.8.0-29.42~precise1_amd64.deb linux-headers-3.8.0-29_3.8.0-29.42~precise1_all.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\g\grub2-signed\grub-efi-amd64-signed_1.9~ubuntu12.04.4+1.99-21ubuntu3.10_amd.deb grub-efi-amd64-signed_1.9~ubuntu12.04.4+1.99-21ubuntu3.10_amd64.deb" ; rename broken udeb files   
	  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.deb *precise1_amd64.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\linux-headers-3.5.0-23_3.5.0-23.35~precise1_amd64.deb linux-headers-3.5.0-23_3.5.0-23.35~precise1_all.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\g\grub2-signed\grub-efi-amd64-signed_1.9~ubuntu12.04.3+1.99-21ubuntu3.9_amd6.deb grub-efi-amd64-signed_1.9~ubuntu12.04.3+1.99-21ubuntu3.9_amd64.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\m\maas\python-maas-provisioningserver*.deb python-maas-provisioningserver_1.2+bzr1373+dfsg-0ubuntu1~12.04.1_all.deb" ; rename broken udeb files     

	 ${ElseIf} $JustISO == "ubuntu-12.10-server-i386.iso"
	  ReadEnvStr $R0 COMSPEC ; grab commandline
	  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\pool\main\l\linux\*.ude *.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*.ude *.udeb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
	; Ubuntu Server 12.04 i386
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precise*.deb *precise1_i386.deb" ; rename broken udeb files    
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.deb *precise1_i386.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\linux-headers-3.5.0-23_3.5.0-23.35~precise1_i386.deb linux-headers-3.5.0-23_3.5.0-23.35~precise1_all.deb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files    
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\m\maas\python-maas-provisioningserver*.deb python-maas-provisioningserver_1.2+bzr1373+dfsg-0ubuntu1~12.04.1_all.deb" ; rename broken udeb files     
	  
	 ${ElseIf} $JustISO == "ubuntu-12.10-server-amd64.iso"
	  ReadEnvStr $R0 COMSPEC ; grab commandline
	  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\pool\main\l\linux\*.ude *.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*.ude *.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*.ude *.udeb" ; rename broken udeb files     
	  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\dists\precise\main\dist-upgrader\binary-amd64\*.ude *.udeb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
	; Ubuntu Server 12.04 amd64
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precise*.deb *precise1_amd64.deb" ; rename broken udeb files    
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*precise*.deb *precise1_amd64.deb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.deb *precise1_amd64.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\linux-headers-3.8.0-29_3.8.0-29.42~precise1_amd64.deb linux-headers-3.8.0-29_3.8.0-29.42~precise1_all.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\g\grub2-signed\grub-efi-amd64-signed_1.9~ubuntu12.04.4+1.99-21ubuntu3.10_amd.deb grub-efi-amd64-signed_1.9~ubuntu12.04.4+1.99-21ubuntu3.10_amd64.deb" ; rename broken udeb files   
	  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.deb *precise1_amd64.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\linux-headers-3.5.0-23_3.5.0-23.35~precise1_amd64.deb linux-headers-3.5.0-23_3.5.0-23.35~precise1_all.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\g\grub2-signed\grub-efi-amd64-signed_1.9~ubuntu12.04.3+1.99-21ubuntu3.9_amd6.deb grub-efi-amd64-signed_1.9~ubuntu12.04.3+1.99-21ubuntu3.9_amd64.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\m\maas\python-maas-provisioningserver*.deb python-maas-provisioningserver_1.2+bzr1373+dfsg-0ubuntu1~12.04.1_all.deb" ; rename broken udeb files      
	  
	 ${ElseIf} $JustISO == "ubuntu-12.04-server-i386.iso"
	 ${OrIf} $JustISO == "ubuntu-12.04.2-server-i386.iso"
	 ${OrIf} $JustISO == "ubuntu-12.04.3-server-i386.iso" 
	 ${OrIf} $JustISO == "ubuntu-12.04.4-server-i386.iso" 
	  ReadEnvStr $R0 COMSPEC ; grab commandline
	  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\pool\main\l\linux\*.ude *.udeb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*.ude *.udeb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
	; Ubuntu Server 12.04 i386
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precise*.deb *precise1_i386.deb" ; rename broken udeb files    
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.deb *precise1_i386.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\linux-headers-3.5.0-23_3.5.0-23.35~precise1_i386.deb linux-headers-3.5.0-23_3.5.0-23.35~precise1_all.deb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files    
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\m\maas\python-maas-provisioningserver*.deb python-maas-provisioningserver_1.2+bzr1373+dfsg-0ubuntu1~12.04.1_all.deb" ; rename broken udeb files     
	  
	 ${ElseIf} $JustISO == "ubuntu-12.04-server-amd64.iso"
	 ${OrIf} $JustISO == "ubuntu-12.04.2-server-amd64.iso"
	 ${OrIf} $JustISO == "ubuntu-12.04.3-server-amd64.iso" 
	 ${OrIf} $JustISO == "ubuntu-12.04.4-server-amd64.iso"
	  ReadEnvStr $R0 COMSPEC ; grab commandline
	  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\pool\main\l\linux\*.ude *.udeb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*.ude *.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*.ude *.udeb" ; rename broken udeb files     
	  nsExec::Exec "$R0 /C Rename $BootDir\multiboot\$JustISOName\dists\precise\main\dist-upgrader\binary-amd64\*.ude *.udeb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
	; Ubuntu Server 12.04 amd64
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-quantal\*precise*.deb *precise1_amd64.deb" ; rename broken udeb files    
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-signed-lts-raring\*precise*.deb *precise1_amd64.deb" ; rename broken udeb files 
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.deb *precise1_amd64.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-raring\linux-headers-3.8.0-29_3.8.0-29.42~precise1_amd64.deb linux-headers-3.8.0-29_3.8.0-29.42~precise1_all.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\g\grub2-signed\grub-efi-amd64-signed_1.9~ubuntu12.04.4+1.99-21ubuntu3.10_amd.deb grub-efi-amd64-signed_1.9~ubuntu12.04.4+1.99-21ubuntu3.10_amd64.deb" ; rename broken udeb files   
	  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.deb *precise1_amd64.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\l\linux-lts-quantal\linux-headers-3.5.0-23_3.5.0-23.35~precise1_amd64.deb linux-headers-3.5.0-23_3.5.0-23.35~precise1_all.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\g\grub2-signed\grub-efi-amd64-signed_1.9~ubuntu12.04.3+1.99-21ubuntu3.9_amd6.deb grub-efi-amd64-signed_1.9~ubuntu12.04.3+1.99-21ubuntu3.9_amd64.deb" ; rename broken udeb files   
	  nsExec::Exec "$R0 /C rename $BootDir\multiboot\$JustISOName\pool\main\m\maas\python-maas-provisioningserver*.deb python-maas-provisioningserver_1.2+bzr1373+dfsg-0ubuntu1~12.04.1_all.deb" ; rename broken udeb files       
	   
	; Parted Magic
	 ${ElseIf} $DistroName == "Parted Magic (Partition Tools)" 
	  !insertmacro ReplaceInFile "/boot/syslinux" "/multiboot/$JustISOName/boot/syslinux" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"  
	  !insertmacro ReplaceInFile "/pmagic/bzIma" "/multiboot/$JustISOName/pmagic/bzIma" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"  
	  !insertmacro ReplaceInFile "/pmagic/initrd64.img" "/multiboot/$JustISOName/pmagic/initrd64.img" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"  
	; added next 10 changes for pmagic_2015_01_13.iso
	  !insertmacro ReplaceInFile "/pmagic/fu.img" "/multiboot/$JustISOName/pmagic/fu.img" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"    
	  !insertmacro ReplaceInFile "/pmagic/m32.img" "/multiboot/$JustISOName/pmagic/m32.img" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"    
	  !insertmacro ReplaceInFile "/pmagic/m64.img" "/multiboot/$JustISOName/pmagic/m64.img" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg" 
	  !insertmacro ReplaceInFile "/EFI/boot/grub.cfg" "/multiboot/$JustISOName/EFI/boot/grub.cfg" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg"  
	  !insertmacro ReplaceInFile "/pmagic/fu.img" "/multiboot/$JustISOName/pmagic/fu.img" "all" "all" "$BootDir\multiboot\$JustISOName\EFI\boot\grub.cfg" 
	  !insertmacro ReplaceInFile "/pmagic/m32.img" "/multiboot/$JustISOName/pmagic/m32.img" "all" "all" "$BootDir\multiboot\$JustISOName\EFI\boot\grub.cfg"   
	  !insertmacro ReplaceInFile "/pmagic/m64.img" "/multiboot/$JustISOName/pmagic/m64.img" "all" "all" "$BootDir\multiboot\$JustISOName\EFI\boot\grub.cfg"    
	  !insertmacro ReplaceInFile "/pmagic/bzIma" "/multiboot/$JustISOName/pmagic/bzIma" "all" "all" "$BootDir\multiboot\$JustISOName\EFI\boot\grub.cfg" 
	  !insertmacro ReplaceInFile "/pmagic/initrd.img" "/multiboot/$JustISOName/pmagic/initrd.img" "all" "all" "$BootDir\multiboot\$JustISOName\EFI\boot\grub.cfg" 
	  !insertmacro ReplaceInFile "/EFI/boot/" "/multiboot/$JustISOName/EFI/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\EFI\boot\grub.cfg"
	 ; added for pmagic_2020_10_12  
	  !insertmacro ReplaceInFile "/pmagic/m.img" "/multiboot/$JustISOName/pmagic/m.img" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg" 	 

	  !insertmacro ReplaceInFile "/pmagic/initrd.img" "/multiboot/$JustISOName/pmagic/initrd.img" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"    
	  !insertmacro ReplaceInFile "APPEND edd=" "APPEND directory=/multiboot/$JustISOName/ edd=" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"    
	  !insertmacro ReplaceInFile "APPEND iso" "APPEND directory=/multiboot/$JustISOName/ iso" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"    
	  !insertmacro ReplaceInFile "/boot/syslinux/reboot.c32" "/multiboot/$JustISOName/boot/syslinux/reboot.c32" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"    
	  !insertmacro ReplaceInFile "/boot/ipxe/ipxe.krn" "/multiboot/$JustISOName/boot/ipxe/ipxe.krn" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"    
	  !insertmacro ReplaceInFile "/boot/plpbt/plpbt.bin" "/multiboot/$JustISOName/boot/plpbt/plpbt.bin" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"    
	  !insertmacro ReplaceInFile "INITRD /boot/" "INITRD /multiboot/$JustISOName/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"    
	  !insertmacro ReplaceInFile "LINUX /boot/" "LINUX /multiboot/$JustISOName/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg"    
	  !insertmacro ReplaceInFile "COM32 /boot/" "COM32 /multiboot/$JustISOName/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg" 
	  ; For older pmagic
	 ${AndIf} $JustISO == "pmagic_2013_06_15.iso"   
	 ${OrIf} $JustISO == "pmagic_2013_05_01.iso"  
	  !insertmacro ReplaceInFile "edd=off load" "edd=off directory=/multiboot/$JustISOName/ load" "all" "all" "$BootDir\multiboot\$JustISOName\boot\syslinux\syslinux.cfg" 

	; System Rescue CD
	/*  ${ElseIf} $DistroName == "System Rescue CD" 
	  !insertmacro ReplaceInFile "INITRD initram.igz" "INITRD NULL initram.igz$\r$\nAPPEND subdir=multiboot/$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"    
	  !insertmacro ReplaceInFile "INITRD NULL initram.igz" "INITRD initram.igz" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"   
	  !insertmacro ReplaceInFile "APPEND docache" "APPEND subdir=multiboot/$JustISOName docache" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"   
	  !insertmacro ReplaceInFile "APPEND nomodeset" "APPEND subdir=multiboot/$JustISOName nomodeset" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"   
	  !insertmacro ReplaceInFile "APPEND video=800x600" "APPEND subdir=multiboot/$JustISOName video=800x600" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	  !insertmacro ReplaceInFile "APPEND video=800x600" "APPEND subdir=multiboot/$JustISOName video=800x600" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	  !insertmacro ReplaceInFile "APPEND root=auto" "APPEND subdir=multiboot/$JustISOName root=auto" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	  !insertmacro ReplaceInFile "APPEND dostartx" "APPEND subdir=multiboot/$JustISOName dostartx" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	  !insertmacro ReplaceInFile "kernel /bootdisk" "kernel /multiboot/$JustISOName/bootdisk" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
	  !insertmacro ReplaceInFile "kernel /ntpasswd" "kernel /multiboot/$JustISOName/ntpasswd" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	  !insertmacro ReplaceInFile "/ntpasswd/initrd.cgz,/ntpasswd/scsi.cgz" "/multiboot/$JustISOName/ntpasswd/initrd.cgz,/multiboot/$JustISOName/ntpasswd/scsi.cgz" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	  !insertmacro ReplaceInFile "initrd=/bootdisk" "initrd=/multiboot/$JustISOName/bootdisk" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
	  
	  !insertmacro ReplaceInFile "/sysresccd/" "/multiboot/$JustISOName/sysresccd/" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"     
	  !insertmacro ReplaceInFile "archisolabel=SYS" "archisolabel=MULTIBOOT old=SYS" "all" "all" "$BootDir\multiboot\$JustISOName\sysresccd\boot\syslinux\sysresccd_sys.cfg"   
	  !insertmacro ReplaceInFile "archisobasedir=sysresccd" "archisobasedir=/multiboot/$JustISOName/sysresccd" "all" "all" "$BootDir\multiboot\$JustISOName\sysresccd\boot\syslinux\sysresccd_sys.cfg"   */ 
	 
	; JustBrowsing 
	 ${ElseIf} $DistroName == "JustBrowsing"  
	;  !insertmacro ReplaceInFile "CONFIG boot" "CONFIG /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso.cfg"
	;  !insertmacro ReplaceInFile "INCLUDE boot" "INCLUDE /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_browser.cfg"
	;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_chrome.cfg"
	;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_chrome.cfg" 
	  !insertmacro ReplaceInFile "archisolabel=justbrowsing" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_chrome.cfg"  
	  !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_chrome.cfg"    
	;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_fallback.cfg"    
	;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_fallback.cfg"  
	  !insertmacro ReplaceInFile "archisolabel=justbrowsing" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_fallback.cfg" 
	  !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_fallback.cfg"    
	;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_firefox.cfg"  
	;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_firefox.cfg"
	  !insertmacro ReplaceInFile "archisolabel=justbrowsing" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_firefox.cfg"  
	  !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_firefox.cfg"    
	;  !insertmacro ReplaceInFile "COM32 boot" "COM32 /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_hdt.cfg"  
	  !insertmacro ReplaceInFile "modules_alias=boot" "modules_alias=/multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_hdt.cfg"    
	;  !insertmacro ReplaceInFile "F1 boot" "F1 /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_head.cfg"  
	;  !insertmacro ReplaceInFile "F2 boot" "F2 /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_head.cfg"  
	;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_http.cfg"  
	;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_http.cfg"   
	;  !insertmacro ReplaceInFile "INCLUDE boot" "INCLUDE /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_keymaps.cfg"  
	;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_locales.cfg"  
	;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_locales.cfg"
	  !insertmacro ReplaceInFile "archisolabel=justbrowsing" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_locales.cfg" 
	  !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_locales.cfg"    
	;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_nbd.cfg"  
	;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_nbd.cfg"
	  !insertmacro ReplaceInFile "archisolabel=%ARCHISO_LABEL%" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_nbd.cfg" 
	;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_newprofiles.cfg"  
	;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_newprofiles.cfg"
	  !insertmacro ReplaceInFile "archisolabel=justbrowsing" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_newprofiles.cfg" 
	;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_nfs.cfg"  
	;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_nfs.cfg"
	;  !insertmacro ReplaceInFile "INCLUDE boot" "INCLUDE /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_pxe.cfg"
	;  !insertmacro ReplaceInFile "INCLUDE boot" "INCLUDE /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_pxe_both_inc.cfg"  
	;  !insertmacro ReplaceInFile "CONFIG boot" "CONFIG /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_pxe_choose.cfg" 
	;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_pxe32.cfg"  
	;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_pxe32.cfg"
	;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_pxe64.cfg"  
	;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_pxe64.cfg"
	;  !insertmacro ReplaceInFile "INCLUDE boot" "INCLUDE /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys_32_inc.cfg"
	;  !insertmacro ReplaceInFile "INCLUDE boot" "INCLUDE /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys_both_inc.cfg" 
	;  !insertmacro ReplaceInFile "CONFIG boot" "CONFIG /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys_choose.cfg"  
	;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys32.cfg"  
	;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys32.cfg"
	  !insertmacro ReplaceInFile "archisolabel=justbrowsing" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys32.cfg"   
	;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys64.cfg"  
	;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys64.cfg"
	  !insertmacro ReplaceInFile "archisolabel=justbrowsing" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_sys64.cfg"  
	;  !insertmacro ReplaceInFile "COM32 boot" "COM32 /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_tail.cfg"  
	;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_timezones.cfg"  
	;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_timezones.cfg"
	  !insertmacro ReplaceInFile "archisolabel=justbrowsing" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_timezones.cfg" 
	;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_vbox.cfg"  
	;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_vbox.cfg"
	  !insertmacro ReplaceInFile "archisolabel=justbrowsing" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_vbox.cfg" 
	  !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_vbox.cfg"  
	;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_videomodes.cfg"  
	;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_videomodes.cfg"
	  !insertmacro ReplaceInFile "archisolabel=justbrowsing" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_videomodes.cfg" 
	  !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_videomodes.cfg"    
	;  !insertmacro ReplaceInFile "LINUX boot" "LINUX /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_vmware.cfg"  
	;  !insertmacro ReplaceInFile "INITRD boot" "INITRD /multiboot/$JustISOName/arch/boot" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_vmware.cfg"
	  !insertmacro ReplaceInFile "archisolabel=justbrowsing" "archisolabel=MULTIBOOT" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_vmware.cfg"
	  !insertmacro ReplaceInFile "archisobasedir=arch" "archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso_vmware.cfg"    
	 
	; Xiaopan 
	  ${ElseIf} $DistroName == "Xiaopan (Penetration Testing)"   
	  ;CopyFiles "$BootDir\multiboot\$JustISOName\cde\*.*" "$BootDir\cde\" ;(quick hack until a cde bootcode/cheatcode is made upstream from tinyCore)
	  ;CopyFiles "$BootDir\multiboot\$JustISOName\mydata.tgz" "$BootDir\mydata.tgz"
	  !insertmacro ReplaceInFile "MENU BACKGROUND /boot/isolinux/splash.jpg" "MENU BACKGROUND /multiboot/$JustISOName/boot/isolinux/splash.jpg" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"
	  !insertmacro ReplaceInFile "MENU BACKGROUND /boot/isolinux/splash.jpg" "MENU BACKGROUND /multiboot/$JustISOName/boot/isolinux/splash.jpg" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"
	  
	; Ophcrack
	 ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\ophcrack.cfg"  
	  CopyFiles "$BootDir\multiboot\$JustISOName\tables\*.*" "$BootDir\tables\"
	  RMDir /R "$BootDir\multiboot\$JustISOName\tables"  
	 ${EndIf} 
	 
	; OpenSuse/BlehOS  
	   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\i386\loader\isolinux.cfg"       
	   !insertmacro ReplaceInFile "ui gfxboot" "#ui NULL gfxboot" "all" "all" "$BootDir\multiboot\$JustISOName\boot\i386\loader\isolinux.cfg"     
	  ${EndIf}   
	  
	; For OpenSuSe like compilations!
	 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\grub\mbrid" 
	  StrCpy $ConfigFile == "syslinux.cfg" ; Make sure it isn't NULL  
	  StrCpy $SUSEDIR "$JustISOName" 
	  Call MBRID  
	 ${EndIf}   

	; Enable Casper  
		 ${If} $Persistence == "casper" ; Casper
			  ${AndIf} $Casper != "0" ; Casper Slider (Size) was not Null
			  ; Add Boot Code Persistent
			  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg" ; Rename the following for isolinux txt.cfg
			  !insertmacro ReplaceInFile "cdrom-detect/try-usb=true noprompt" "cdrom-detect/try-usb=true persistent persistent-path=/multiboot/$JustISOName noprompt" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\txt.cfg" 
		 ${EndIf}  
	  
		 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\text.cfg" ; Rename the following for isolinux text.cfg
			 !insertmacro ReplaceInFile "cdrom-detect/try-usb=true noprompt" "cdrom-detect/try-usb=true persistent persistent-path=/multiboot/$JustISOName noprompt" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\text.cfg" 
		 ${EndIf}
	  
		 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" ; Rename the following for isolinux.cfg
			 !insertmacro ReplaceInFile "cdrom-detect/try-usb=true noprompt" "cdrom-detect/try-usb=true persistent persistent-path=/multiboot/$JustISOName noprompt" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"    
		 ${EndIf}
		
		 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\menuentries.cfg" ; Rename the following for menuentries.cfg
			 !insertmacro ReplaceInFile "cdrom-detect/try-usb=true noprompt" "cdrom-detect/try-usb=true persistent persistent-path=/multiboot/$JustISOName noprompt" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\menuentries.cfg"    
		 ${EndIf}
		
		 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\grub\loopback.cfg" ; Rename the following for grub loopback.cfg
			 !insertmacro ReplaceInFile "cdrom-detect/try-usb=true noprompt" "cdrom-detect/try-usb=true persistent persistent-path=/multiboot/$JustISOName noprompt" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\loopback.cfg"  
		 ${EndIf} 
		 ; Create Casper-rw file
		 Call CasperScriptAlt1  
		 Call WriteStuff
    ${EndIf}
!macroend