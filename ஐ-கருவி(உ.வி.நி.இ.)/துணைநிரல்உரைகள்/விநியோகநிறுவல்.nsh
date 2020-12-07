; ------------ Install Distros Macro -------------- 

Function FindConfig ; Set config path and file
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\liberte\boot\syslinux\syslinux.cfg" ; Liberte
  StrCpy $ConfigPath "liberte/boot/syslinux"
  StrCpy $CopyPath "liberte\boot\syslinux"
  StrCpy $ConfigFile "syslinux.cfg"    
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\i386\loader\isolinux.cfg" ; OpenSuse based 32bit
  StrCpy $ConfigPath "boot/i386/loader"
  StrCpy $CopyPath "boot\i386\loader"
  StrCpy $ConfigFile "isolinux.cfg" 
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\x86_64\loader\isolinux.cfg" ; OpenSuse based 64bit
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

!insertmacro Locate

Function FindGrubConfig ; Set Grub config path and file
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\liberte\boot\grub\grub.cfg" ; Liberte
  StrCpy $GrubConfigPath "liberte/boot/grub"
  StrCpy $GrubCopyPath "liberte\boot\grub"
  StrCpy $GrubConfigFile "grub.cfg"   
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\efi\boot\grub.cfg" ; Fedora...
  StrCpy $GrubConfigPath "efi/boot"
  StrCpy $GrubCopyPath "efi\boot"
  StrCpy $GrubConfigFile "grub.cfg"     
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg" ; Ubuntu...
  StrCpy $GrubConfigPath "boot/grub"
  StrCpy $GrubCopyPath "boot\grub"
  StrCpy $GrubConfigFile "grub.cfg"   
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\grub\grub*.cfg" ; System Rescue CD...
  ${Locate} "$BootDir\multiboot\$JustISOName\boot\grub" "/L=F /M=*.cfg" "FoundGrubFile" ; Could eventually replace this whole section using locate.
  StrCpy $GrubConfigPath "boot/grub"
  StrCpy $GrubCopyPath "boot\grub"
  StrCpy $GrubConfigFile "grubsys.cfg"   
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\grub\loopback.cfg" ; Ubuntu...
  StrCpy $GrubConfigPath "boot/grub"
  StrCpy $GrubCopyPath "boot\grub"
  StrCpy $GrubConfigFile "loopback.cfg"     
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\efi\boot\grub\grub.cfg" ; TinyCore, newer Tails
  StrCpy $GrubConfigPath "efi/boot/grub"
  StrCpy $GrubCopyPath "efi\boot\grub"
  StrCpy $GrubConfigFile "grub.cfg"   
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\grub\sparky.cfg" ; Sparky...
  StrCpy $GrubConfigPath "boot/grub"
  StrCpy $GrubCopyPath "boot\grub"
  StrCpy $GrubConfigFile "sparky.cfg" 
 #${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\grub.cfg" ; Slacko...
 # StrCpy $GrubConfigPath ""
 # StrCpy $GrubCopyPath ""
 # StrCpy $GrubConfigFile "grub.cfg" 
  ${Else} 
  StrCpy $GrubConfigFile "NULL"  
  ${EndIf}   
  ;MessageBox MB_OK "$GrubConfigPath/$GrubConfigFile"   
FunctionEnd

Function FoundGrubFile
  CopyFiles "$R9" "$BootDir\multiboot\$JustISOName\boot\grub\grubsys.cfg"
  StrCpy $0 StopLocate
  Push $0
FunctionEnd

Function WriteStuff
 ; Now done before this function is called (see line 122) CreateDirectory "$BootDir\multiboot\$JustISOName\I\" ; Create the I Directory.. so we can copy the following config file to it.
 CopyFiles "$PLUGINSDIR\$Config2Use" "$BootDir\multiboot\$JustISOName\I\$Config2Use" ; Copy the $Config2Use file to $JustISOName\I folder for the distro (so we know where to remove entry) 
 DetailPrint "$DistroName ($JustISOName) and its menu entry were added!"
 	
FunctionEnd

!macro Install_Distros 

; Initiate Plugins Directory for potential use
  SetShellVarContext all
  InitPluginsDir

; If distro is already installed, delete the entry, so we don't make a mess.
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\*.*"
 ${DeleteMenuEntry} "$BootDir\multiboot\menu\$Config2Use" "#[ $DistroName" "#] $DistroName" ; கட்டமைப்பு கோப்பிலிருந்து உள்ளீட்டை அகற்று... I.E. linux.cfg, system.cfg, etc
 ${EndIf}
 
; Write $JustISOName to நிறுவப்பட்டது.உரை 
 ${InstalledList} "$JustISOName" $R0 ; Write the ISO name to the Installed List "நிறுவப்பட்டது.உரை" file (so we can keep track of installs for removal)
 ${LineFind} "$BootDir\multiboot\நிறுவப்பட்டது.உரை" "$BootDir\multiboot\நிறுவப்பட்டது.உரை" "1:-1" "DeleteEmptyLine" ; Remove any left over empty lines
 ;CopyFiles "$BootDir\multiboot\நிறுவப்பட்டது.உரை" "$BootDir\multiboot\நிறுவப்பட்டது-நகல்.உரை" ; பாதுகாப்பிற்காக நிறுவப்பட்டது காப்புப்பிரதியை உருவாக்கவும்
 
; Create the Directory for this ISOs files
 CreateDirectory "$BootDir\multiboot\$JustISOName\I\" ; Create the I Directory.. so we can eventually copy the config file (see line 90) to it.

; Kaspersky Rescue Disk - Gentoo
 ${If} $DistroName == "Kaspersky Rescue Disk (Antivirus Scanner)" 
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y'   
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nif cpuid -l; then set krn=$\"k-x86_64$\"; else set krn=$\"k-x86$\"; fi$\r$\nsearch -s root -f /multiboot/$JustISOName/boot/grub/$${krn}$\r$\nlinux /multiboot/$JustISOName/boot/grub/$${krn} net.ifnames=0 lang=en dostartx subdir=/multiboot/$JustISOName/data$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd /multiboot/$JustISOName/boot/grub/initrd.xz$\r$\n}$\r$\n#] $JustISOName" $R0  

 ; Acronis True Image 
 ${ElseIf} $DistroName == "Acronis True Image"
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to ISO Directory
 ;ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -ir!*.dat -o"$BootDir\multiboot\$JustISOName\" -y' 
  ;${If} ${FileExists} "$BootDir\multiboot\$JustISOName\ramdisk_merged64.dat" 
  ;Rename "$BootDir\multiboot\$JustISOName\ramdisk_merged64.dat" "$BootDir\multiboot\$JustISOName\ramdisk64.dat"  
  ;${EndIf}
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset isofile=$\"/multiboot/$JustISOName/$JustISO$\"$\r$\nloopback loop $$isofile$\r$\nlinux (loop)/dat10.dat quiet force_modules=usbhid quiet$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd (loop)/dat11.dat (loop)/dat12.dat$\r$\n}$\r$\n#] $JustISOName" $R0 
 ;;ALT BIOS? ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset isofile=$\"/multiboot/$JustISOName/$JustISO$\"$\r$\nloopback loop $$isofile$\r$\nlinux (loop)/dat6.dat quiet force_modules=usbhid quiet$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd (loop)/dat7.dat (loop)/dat8.dat$\r$\n}$\r$\n#] $JustISOName" $R0 

; Calculate Linux Desktop
 ${ElseIf} $DistroName == "Calculate Linux Desktop"
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" 
 ;ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -ir!*nitrd -ir!*mlinuz -o"$BootDir\multiboot\$JustISOName\" -y'    
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nset isofile=$\"/multiboot/$JustISOName/$JustISO$\"$\r$\nloopback loop $$isofile$\r$\nlinux (loop)/boot/vmlinuz root=live:LABEL=TA init=/linuxrc rd.live.squashimg=livecd.squashfs looptype=squashfs nodevfs iso-scan/filename=/multiboot/$JustISOName/$JustISO findiso=$$isofile isoboot=$$isofile$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd (loop)/boot/initrd$\r$\n}$\r$\n#] $JustISOName" $R0 
 
; CentOS
 ${ElseIf} $DistroName == "CentOS Minimal"
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" 
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nset isofile='/multiboot/$JustISOName/$JustISO'$\r$\nloopback loop $$isofile$\r$\nlinux (loop)/isolinux/vmlinuz noeject inst.stage2=hd:LABEL=TA:/$$isofile$\r$\necho $\"https://tamilneram.github.io/...$\"$\r$\ninitrd (loop)/isolinux/initrd.img$\r$\n}$\r$\n#] $JustISOName" $R0 
 
; Linux Kid X
 ${ElseIf} $DistroName == "Linux Kid X" 
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO"
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nset isofile='/multiboot/$JustISOName/$JustISO'$\r$\nloopback loop $$isofile$\r$\nlinux (loop)/boot/vmlinuz from=$$isofile$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd (loop)/boot/initrd.gz$\r$\n}$\r$\n#] $JustISOName" $R0 
 
; KNOPPIX - Wont work on Fat32- filesize too big, revisit after fat32/ntfs partition functional
 ;${ElseIf} $DistroName == "KNOPPIX" 
 ;CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO"
 ;${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nset isofile='/multiboot/$JustISOName/$JustISO'$\r$\nloopback loop $$isofile$\r$\nlinux (loop)/boot/isolinux/linux  ;bootfrom=$$isofile acpi=off keyboard=us language-us$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd (loop)/boot/isolinux/minirt.gz$\r$\n}$\r$\n#] $JustISOName" $R0 
 
; Bitdefender Rescue CD
 ${ElseIf} $DistroName == "Bitdefender Rescue CD"
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" 
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nset isopath=$\"/multiboot/$JustISOName/$JustISO$\"$\r$\nloopback loop $$isopath$\r$\nset root=(loop)$\r$\nlinux (loop)/boot/kernel.x86_64-efi root=/dev/ram0 real_root=/dev/loop0 looptype=squashfs cdroot loop=/rescue/livecd.squashfs cdroot_marker=/rescue/livecd.squashfs initrd udev cdroot scandelay=5 lang=en isoboot=$$isopath$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd (loop)/boot/initfs.x86_64-efi$\r$\n}$\r$\n#] $JustISOName" $R0  
 
; Dr.Web Live CD
 ${ElseIf} $DistroName == "Dr.Web LiveDisk"
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y'  
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nlinux /multiboot/$JustISOName/casper/vmlinuz boot=casper cdrom-detect/try-usb=true noprompt live-media-path=/multiboot/$JustISOName/casper union=aufs console=tty1 ignore_uuid$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd /multiboot/$JustISOName/casper/initrd.lz$\r$\n}$\r$\n#] $JustISOName" $R0  
 
; Antix (New Method) 
 ${ElseIf} $DistroName == "AntiX" 
  ${OrIf} $DistroName == "MX Linux" 
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nloopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux (loop)/antiX/vmlinuz load=all bootlabel=TA fromiso=/multiboot/$JustISOName/$JustISO nomodeset nouveau.modeset=0$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd (loop)/antiX/initrd.gz$\r$\n}$\r$\n#] $JustISOName" $R0  

; AOSS (New Method) 
 ${ElseIf} $DistroName == "AOSS (Malware Scanner)" 
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nloopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux (loop)/system/stage1 root=/dev/ram0 rw rdinit=/linuxrc video=vesa:ywrap,mtrr vga=0x303 loglevel=0 boot=cdrom fromiso=/multiboot/$JustISOName/$JustISO$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd (loop)/system/stage2$\r$\n}$\r$\n#] $JustISOName" $R0  
 
; DBAN (New Method) 
 ${ElseIf} $DistroName == "DBAN (Hard Drive Nuker)" 
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nloopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux (loop)/dban.bzi nuke=$\"dwipe$\" fromiso=/multiboot/$JustISOName/$JustISO$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\n}$\r$\n#] $JustISOName" $R0  
 
; Fedora (New Method) 
 ${ElseIf} $DistroName == "Fedora" 
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -ir!*nitrd* -ir!*mlinu* -o"$BootDir\multiboot\$JustISOName\" -y'  
 
 FindFirst $0 $1 "$BootDir\multiboot\$JustISOName\isolinux\initrd*"
 Call FindInitrd
 FindFirst $0 $1 "$BootDir\multiboot\$JustISOName\isolinux\vmlinuz*"
 Call FindVmlinuz
 ;${StrRep} '$ISONameDotLess' '$JustISOName' '-x86_64-' '-'
 ${StrRep} '$ISONameDotLess' '$JustISOName' '.' '-'
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nloopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux (loop)/isolinux/$Vmlinuz iso-scan/filename=/multiboot/$JustISOName/$JustISO rootfstype=auto root=live:CDLABEL=$ISONameDotLess ro rd.live.image$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd (loop)/isolinux/$Initrd$\r$\n}$\r$\n#] $JustISOName" $R0  
 !insertmacro ReplaceInFile "CDLABEL=Fedora-Live-Workstation" "CDLABEL=Fedora-Live-WS" "all" "all" "$BootDir\multiboot\menu\linux.cfg"   
 !insertmacro ReplaceInFile "CDLABEL=Fedora-Workstation-Live" "CDLABEL=Fedora-WS-Live" "all" "all" "$BootDir\multiboot\menu\linux.cfg" 
 !insertmacro ReplaceInFile "CDLABEL=Fedora-WS-Live-x86_64" "CDLABEL=Fedora-WS-Live" "all" "all" "$BootDir\multiboot\menu\linux.cfg" 
 
; Linpus Lite (New Method) 
 ${ElseIf} $DistroName == "Linpus Lite" 
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -ir!*nitrd* -ir!*mlinu* -o"$BootDir\multiboot\$JustISOName\" -y'  
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nloopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux (loop)/isolinux/vmlinuz0 iso-scan/filename=/multiboot/$JustISOName/$JustISO rootfstype=auto root=live:LABEL=$JustISOName ro rd.live.image$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd (loop)/isolinux/initrd0.img$\r$\n}$\r$\n#] $JustISOName" $R0  

; GRML 
 ${ElseIf} $DistroName == "GRML (system rescue)" 
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y' 
 CopyFiles "$PLUGINSDIR\grubslug.cfg" "$BootDir\multiboot\$JustISOName\grub.cfg" 
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nconfigfile /multiboot/$JustISOName/grub.cfg$\r$\n}$\r$\n#] $JustISOName" $R0    
 !insertmacro ReplaceInFile "menuentry $\"BOOT$\"" "menuentry $\"$JustISOName$\"" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\grml64full\vmlinuz"
 !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/boot/grml64full/vmlinuz boot=live live-media-path=/multiboot/$JustISOName/live/grml64-full/ verbose noeject noprompt" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
 ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\grml64full\initrd.img"
 !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/boot/grml64full/initrd.img" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
 ${EndIf}

; Liberte
 ${ElseIf} $DistroName == "Liberte (Anonymous Browsing)" 
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y' 
 CopyFiles "$PLUGINSDIR\grubslug.cfg" "$BootDir\multiboot\$JustISOName\grub.cfg" 
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nconfigfile /multiboot/$JustISOName/grub.cfg$\r$\n}$\r$\n#] $JustISOName" $R0    
 !insertmacro ReplaceInFile "menuentry $\"BOOT$\"" "menuentry $\"$JustISOName$\"" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\liberte\boot\kernel-x86.zi"
 !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/liberte/boot/kernel-x86.zi loop=/multiboot/$JustISOName/liberte/boot/root-x86.sfs" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
 ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\liberte\boot\initrd-x86.xz"
 !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/liberte/boot/initrd-x86.xz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
 ${EndIf}
  
; Linux Mint (New Method) 
 ${ElseIf} $DistroName == "Linux Mint"
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory
 CopyFiles "$PLUGINSDIR\grubslug.cfg" "$BootDir\multiboot\$JustISOName\grub.cfg" 
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -ir!*nitrd.* -ir!*mlinuz -o"$BootDir\multiboot\$JustISOName\" -y'  
 Rename "$BootDir\multiboot\casper\$JustISOName\initrd.gz" "$BootDir\multiboot\$JustISOName\casper\initrd.lz"  
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nconfigfile /multiboot/$JustISOName/grub.cfg$\r$\n}$\r$\n#] $JustISOName" $R0 
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\casper\vmlinuz"
  ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$JustISO"  
 !insertmacro ReplaceInFile "menuentry $\"BOOT$\"" "menuentry $\"$JustISOName$\"" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
 !insertmacro ReplaceInFile "linux /SLUG" "loopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux /multiboot/$JustISOName/casper/vmlinuz iso-scan/filename=/multiboot/$JustISOName/$JustISO isofrom=/dev/disk/by-label/TA/multiboot/$JustISOName/$JustISO file=/cdrom/preseed/linuxmint.seed boot=casper noprompt floppy.allowed_drive_mask=0 ignore_uuid" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
  ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\casper\initrd.lz"
 !insertmacro ReplaceInFile "initrd /SLUG" "initrd (loop)/casper/initrd.lz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
 ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\live\vmlinuz"
 ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$JustISO"  
 !insertmacro ReplaceInFile "menuentry $\"BOOT$\"" "menuentry $\"$JustISOName$\"" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
 !insertmacro ReplaceInFile "linux /SLUG" "loopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux /multiboot/$JustISOName/live/vmlinuz iso-scan/filename=/multiboot/$JustISOName/$JustISO isofrom=/dev/disk/by-label/TA/multiboot/$JustISOName/$JustISO file=/cdrom/preseed/linuxmint.seed boot=live noprompt floppy.allowed_drive_mask=0 ignore_uuid" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
 ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\live\initrd.lz"
 !insertmacro ReplaceInFile "initrd /SLUG" "initrd (loop)/live/initrd.lz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
 ${EndIf}
 
 ; Linux Mint (New Method) 
 ${ElseIf} $DistroName == "Linux Mint Debian"
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory
 CopyFiles "$PLUGINSDIR\grubslug.cfg" "$BootDir\multiboot\$JustISOName\grub.cfg" 
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -ir!*nitrd.* -ir!*mlinuz -o"$BootDir\multiboot\$JustISOName\" -y'  
 Rename "$BootDir\multiboot\casper\$JustISOName\initrd.gz" "$BootDir\multiboot\$JustISOName\casper\initrd.lz"  
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nconfigfile /multiboot/$JustISOName/grub.cfg$\r$\n}$\r$\n#] $JustISOName" $R0 
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\casper\vmlinuz"
  ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$JustISO"  
 !insertmacro ReplaceInFile "menuentry $\"BOOT$\"" "menuentry $\"$JustISOName$\"" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
 !insertmacro ReplaceInFile "linux /SLUG" "loopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux /multiboot/$JustISOName/casper/vmlinuz iso-scan/filename=/multiboot/$JustISOName/$JustISO isofrom=/dev/disk/by-label/TA/multiboot/$JustISOName/$JustISO file=/cdrom/preseed/linuxmint.seed boot=casper noprompt floppy.allowed_drive_mask=0 ignore_uuid" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
  ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\casper\initrd.lz"
 !insertmacro ReplaceInFile "initrd /SLUG" "initrd (loop)/casper/initrd.lz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
 ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\live\vmlinuz"
 ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$JustISO"  
 !insertmacro ReplaceInFile "menuentry $\"BOOT$\"" "menuentry $\"$JustISOName$\"" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
 !insertmacro ReplaceInFile "linux /SLUG" "loopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux /multiboot/$JustISOName/live/vmlinuz iso-scan/filename=/multiboot/$JustISOName/$JustISO isofrom=/dev/disk/by-label/TA/multiboot/$JustISOName/$JustISO file=/cdrom/preseed/linuxmint.seed boot=live noprompt floppy.allowed_drive_mask=0 ignore_uuid" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
 ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\live\initrd.lz"
 !insertmacro ReplaceInFile "initrd /SLUG" "initrd (loop)/live/initrd.lz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
 ${EndIf}
 
 ; Recatux
 ${ElseIf} $DistroName == "Rescatux" 
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO"
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\niso_path='/multiboot/$JustISOName/$JustISO'$\r$\nexport iso_path$\r$\nsearch --set=root --file $$iso_path$\r$\nloopback loop $$iso_path$\r$\nroot=(loop)$\r$\nconfigfile /boot/grub/loopback.cfg$\r$\nloopback --delete loop$\r$\n}$\r$\n#] $JustISOName" $R0 
 
; Debian Live Based (New Method) 
 ${ElseIf} $DistroName == "Debian Live"
  ${OrIf} $DistroName == "Raspberry Pi Desktop"
  ${OrIf} $DistroName == "Deepin"
  ${OrIf} $DistroName == "Academix"

 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory
 CopyFiles "$PLUGINSDIR\grubslug.cfg" "$BootDir\multiboot\$JustISOName\grub.cfg" 
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -ir!*nitrd* -ir!*mlinu* -o"$BootDir\multiboot\$JustISOName\" -y'  
 
 FindFirst $0 $1 "$BootDir\multiboot\$JustISOName\live\initrd*" 
 Call FindInitrd
 FindFirst $0 $1 "$BootDir\multiboot\$JustISOName\live\*mlinu*"
 Call FindVmlinuz
 
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nconfigfile /multiboot/$JustISOName/grub.cfg$\r$\n}$\r$\n#] $JustISOName" $R0    
 !insertmacro ReplaceInFile "menuentry $\"BOOT$\"" "menuentry $\"$JustISOName$\"" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"   

 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\live\$Initrd"  ; likely 86_64
 ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$JustISO" 
 !insertmacro ReplaceInFile "linux /SLUG" "loopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux /multiboot/$JustISOName/live/$Vmlinuz iso-scan/filename=/multiboot/$JustISOName/$JustISO boot=live noprompt components config findiso=/multiboot/$JustISOName/$JustISO" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
 !insertmacro ReplaceInFile "initrd /SLUG" "initrd (loop)/live/$Initrd" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"     
 ${EndIf}
 
; Clonezilla (New Method) - Debian Based - TORAM
  ${ElseIf} $DistroName == "Clonezilla (Backup + Clone Tool)"
  CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory
  CopyFiles "$PLUGINSDIR\grubslug.cfg" "$BootDir\multiboot\$JustISOName\grub.cfg" 
  ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -ir!*nitrd* -ir!*mlinu* -o"$BootDir\multiboot\$JustISOName\" -y'  
 
  FindFirst $0 $1 "$BootDir\multiboot\$JustISOName\live\initrd*" 
  Call FindInitrd
  FindFirst $0 $1 "$BootDir\multiboot\$JustISOName\live\*mlinu*"
  Call FindVmlinuz
 
  ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nconfigfile /multiboot/$JustISOName/grub.cfg$\r$\n}$\r$\n#] $JustISOName" $R0    
  !insertmacro ReplaceInFile "menuentry $\"BOOT$\"" "menuentry $\"$JustISOName$\"" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"   

  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\live\$Initrd"  ; likely 86_64
  ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$JustISO" 
  !insertmacro ReplaceInFile "linux /SLUG" "loopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux /multiboot/$JustISOName/live/$Vmlinuz iso-scan/filename=/multiboot/$JustISOName/$JustISO boot=live noprompt components config toram=live,syslinux,EFI,boot,.disk,utils findiso=/multiboot/$JustISOName/$JustISO" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
  !insertmacro ReplaceInFile "initrd /SLUG" "initrd (loop)/live/$Initrd" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"     
  ${EndIf}
  
; Solus
 ${ElseIf} $DistroName == "Solus"
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" 
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nset isofile='/multiboot/$JustISOName/$JustISO'$\r$\nloopback loop $$isofile$\r$\nlinux (loop)/boot/kernel iso-scan/filename=/multiboot/$JustISOName/$JustISO root=live:CDLABEL=SolusLiveBudgie ro rd.luks=0 rd.md=0 rd.live.overlay.overlayfs=1 quiet splash$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd (loop)/boot/initrd.img$\r$\n}$\r$\n#] $JustISOName" $R0  
 
; Demon Linux 
 ${ElseIf} $DistroName == "Demon Linux (Penetration Testing)"
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory
 CopyFiles "$PLUGINSDIR\grubslug.cfg" "$BootDir\multiboot\$JustISOName\grub.cfg" 
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -ir!*nitrd* -ir!*mlinu* -o"$BootDir\multiboot\$JustISOName\" -y'  
 
 FindFirst $0 $1 "$BootDir\multiboot\$JustISOName\initrd*" 
 Call FindInitrd
 FindFirst $0 $1 "$BootDir\multiboot\$JustISOName\vmlinuz*"
 Call FindVmlinuz
 
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nconfigfile /multiboot/$JustISOName/grub.cfg$\r$\n}$\r$\n#] $JustISOName" $R0    
 !insertmacro ReplaceInFile "menuentry $\"BOOT$\"" "menuentry $\"$JustISOName$\"" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"   

 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\$Initrd"  ; likely 86_64
 ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$JustISO" 
 !insertmacro ReplaceInFile "linux /SLUG" "loopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux /multiboot/$JustISOName/$Vmlinuz iso-scan/filename=/multiboot/$JustISOName/$JustISO boot=live noprompt components config findiso=/multiboot/$JustISOName/$JustISO" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
 !insertmacro ReplaceInFile "initrd /SLUG" "initrd (loop)/$Initrd" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"     
 ${EndIf}
 
; Open Mandriva
 ${ElseIf} $DistroName == "OpenMandriva"
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory
 CopyFiles "$PLUGINSDIR\grubslug.cfg" "$BootDir\multiboot\$JustISOName\grub.cfg" 
 ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -ir!*nitrd* -ir!*mlinu* -o"$BootDir\multiboot\$JustISOName\" -y'  
 
 FindFirst $0 $1 "$BootDir\multiboot\$JustISOName\*initrd*" 
 Call FindInitrd
 FindFirst $0 $1 "$BootDir\multiboot\$JustISOName\*mlinu*"
 Call FindVmlinuz
 
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nconfigfile /multiboot/$JustISOName/grub.cfg$\r$\n}$\r$\n#] $JustISOName" $R0    
 !insertmacro ReplaceInFile "menuentry $\"BOOT$\"" "menuentry $\"$JustISOName$\"" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"   

 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\$Initrd"  ; likely 86_64
 ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$JustISO" 
 !insertmacro ReplaceInFile "linux /SLUG" "loopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux /multiboot/$JustISOName/$Vmlinuz iso-scan/filename=/multiboot/$JustISOName/$JustISO findiso=/multiboot/$JustISOName/$JustISO root=live:LABEL=OpenMandrivaLx_4.0 rd.live.image toram" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
 !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/$Initrd" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"     
 ${EndIf}
 
; Alpine Linux
 ${ElseIf} $DistroName == "Alpine Linux"
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory
 CopyFiles "$PLUGINSDIR\grubslug.cfg" "$BootDir\multiboot\$JustISOName\grub.cfg" 
 ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -ir!*nitr* -ir!*mlinu* -o"$BootDir\multiboot\$JustISOName\" -y'  
 
 FindFirst $0 $1 "$BootDir\multiboot\$JustISOName\*initr*" 
 Call FindInitrd
 FindFirst $0 $1 "$BootDir\multiboot\$JustISOName\*mlinu*"
 Call FindVmlinuz
 
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nconfigfile /multiboot/$JustISOName/grub.cfg$\r$\n}$\r$\n#] $JustISOName" $R0    
 !insertmacro ReplaceInFile "menuentry $\"BOOT$\"" "menuentry $\"$JustISOName$\"" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"   

 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\$Initrd"  ; likely 86_64
 ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$JustISO" 
 !insertmacro ReplaceInFile "linux /SLUG" "loopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux /multiboot/$JustISOName/$Vmlinuz iso-scan/filename=/multiboot/$JustISOName/$JustISO findiso=/multiboot/$JustISOName/$JustISO modules=loop,squashfs,sd-mod,usb-storage nomodeset" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
 !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/$Initrd" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"     
 ${EndIf}  
 
; Clear Linux
 ${ElseIf} $DistroName == "Clear Linux"
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory
 CopyFiles "$PLUGINSDIR\grubslug.cfg" "$BootDir\multiboot\$JustISOName\grub.cfg" 
 ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -ir!*nitrd* -ir!*mlinu* -o"$BootDir\multiboot\$JustISOName\" -y'  
 
 FindFirst $0 $1 "$BootDir\multiboot\$JustISOName\*initrd*" 
 Call FindInitrd
 FindFirst $0 $1 "$BootDir\multiboot\$JustISOName\*mlinu*"
 Call FindVmlinuz
 
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nconfigfile /multiboot/$JustISOName/grub.cfg$\r$\n}$\r$\n#] $JustISOName" $R0    
 !insertmacro ReplaceInFile "menuentry $\"BOOT$\"" "menuentry $\"$JustISOName$\"" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"   

 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\$Initrd"  ; likely 86_64
 ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$JustISO" 
 !insertmacro ReplaceInFile "linux /SLUG" "loopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux /multiboot/$JustISOName/$Vmlinuz iso-scan/filename=/multiboot/$JustISOName/$JustISO findiso=/multiboot/$JustISOName/$JustISO" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
 !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/$Initrd" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"     
 ${EndIf} 

; WIFISLAX (New Method) 
 ${ElseIf} $DistroName == "Wifislax (Wireless Penetration Testing)" 
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nloopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux (loop)/boot/vmlinuz from=/multiboot/$JustISOName/$JustISO autoexec=telinit~4$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd (loop)/boot/initrd.xz$\r$\n}$\r$\n#] $JustISOName" $R0  
 
; RIPLinux (New Method) 
 ${ElseIf} $DistroName == "Rip Linux (Recovery Distro) - BIOS ONLY" 
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory 
 ${WriteToFile} "#[ $JustISOName$\r$\nif [ $${grub_platform} == $\"pc$\" ]; then$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nset isofile=$\"/multiboot/$JustISOName/$JustISO$\"$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\nlinux16 /multiboot/menu/memdisk iso raw$\r$\ninitrd16 $$isofile$\r$\n}; fi$\r$\n#] $JustISOName" $R0  
 
; Finnix 
 ${ElseIf} $DistroName == "Finnix x86/64- BIOS ONLY" 
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory 
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName - 32bit$\" {$\r$\nset gfxpayload=keep$\r$\nset isofile=$\"/multiboot/$JustISOName/$JustISO$\"$\r$\nloopback loop $$isofile$\r$\nlinux (loop)/boot/x86/linux findiso=$$isofile vga=791 nomodeset quiet$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd (loop)/boot/x86/initrd.xz$\r$\n}$\r$\nmenuentry $\"$JustISOName - 64bit$\" {$\r$\nset gfxpayload=keep$\r$\nset isofile=$\"/multiboot/$JustISOName/$JustISO$\"$\r$\nloopback loop $$isofile$\r$\nlinux (loop)/boot/x86/linux64 findiso=$$isofile vga=791 nomodeset quiet$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd (loop)/boot/x86/initrd.xz$\r$\n}$\r$\n#] $JustISOName" $R0  
 
; Trinity Rescue Kit (New Method) 
 ${ElseIf} $DistroName == "Trinity Rescue Kit - BIOS ONLY" 
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y'  
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\kernel.trk"       
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\initrd.trk"  
   ${WriteToFile} "#[ $JustISOName$\r$\nif [ $${grub_platform} == $\"pc$\" ]; then$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nlinux /multiboot/$JustISOName/kernel.trk from=/multiboot/$JustISOName vollabel=TA ramdisk_size=65536 root=/dev/ram0 splash=verbose pci=conf1 trkmenu$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd /multiboot/$JustISOName/initrd.trk$\r$\n}; fi$\r$\n#] $JustISOName" $R0  
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\trk3\trkramfs" 
   CopyFiles "$BootDir\multiboot\$JustISOName\trk3\*.*" "$BootDir\trk3\" ; Move trk3 to root, so we can boot!
   RMDir /R "$BootDir\multiboot\$JustISOName\trk3"
   ${EndIf}    
 
; Ubuntu Server (New Method) 
 ;${ElseIf} $DistroName == "Ubuntu Server"
 ;CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory
 ;ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -ir!install\netboot\ubuntu-installer\*nitrd* -ir!*mlinuz -o"$BootDir\multiboot\$JustISOName\" -y'  
 ;${If} ${FileExists} "$BootDir\multiboot\$JustISOName\install\netboot\ubuntu-installer\amd64\*.*" 
 ;${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nloopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux (loop)/install/vmlinuz iso-scan/filename=/multiboot/$JustISOName/$JustISO findiso=/multiboot/$JustISOName/$JustISO file=/cdrom/preseed/ubuntu-server.seed$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd (loop)/install/netboot/ubuntu-installer/amd64/initrd.gz$\r$\n}$\r$\n#] $JustISOName" $R0  
 ;${EndIf}
 ;${If} ${FileExists} "$BootDir\multiboot\$JustISOName\install\netboot\ubuntu-installer\i386\*.*"
 ;${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nloopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux (loop)/install/vmlinuz iso-scan/filename=/multiboot/$JustISOName/$JustISO findiso=/multiboot/$JustISOName/$JustISO file=/cdrom/preseed/ubuntu-server.seed$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd (loop)/install/netboot/ubuntu-installer/i386/initrd.gz$\r$\n}$\r$\n#] $JustISOName" $R0  
 ;${EndIf}
 
; Ubuntu (New Method) 
 ${ElseIf} $DistroName == "Ubuntu"
  ${OrIf} $DistroName == "Ubuntu Budgie" 
  ${OrIf} $DistroName == "Ubuntu Gnome"
  ${OrIf} $DistroName == "Ubuntu Server"   
  ${OrIf} $DistroName == "Ubuntu Studio" 
  ${OrIf} $DistroName == "Xubuntu"
  ${OrIf} $DistroName == "Kubuntu"
  ${OrIf} $DistroName == "Tuxtrans"  
  ${OrIf} $DistroName == "Lubuntu"
  ${OrIf} $DistroName == "LinuxFX"  
  ${OrIf} $DistroName == "Edubuntu" 
  ${OrIf} $DistroName == "Cub Linux"
  ${OrIf} $DistroName == "Emmabuntus"  
  ${OrIf} $DistroName == "Q4OS"
  ${OrIf} $DistroName == "Rescuezilla"  
  ${OrIf} $DistroName == "KDE Neon"  
  ${OrIf} $DistroName == "Feren OS"   
  ${OrIf} $DistroName == "EasyPeasy (NetBook Distro)"  
  ${OrIf} $DistroName == "Kodachi (Anonymous Browsing)"
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -ir!*nitrd* -ir!*mlinu* -o"$BootDir\multiboot\$JustISOName\" -y'    
 CopyFiles "$PLUGINSDIR\grubslug.cfg" "$BootDir\multiboot\$JustISOName\grub.cfg" 
 !insertmacro ReplaceInFile "menuentry $\"BOOT$\"" "menuentry $\"$JustISOName$\"" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nconfigfile /multiboot/$JustISOName/grub.cfg$\r$\n}$\r$\n#] $JustISOName" $R0 
 
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\casper\vmlinuz.efi" 
 ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$JustISO"  
 !insertmacro ReplaceInFile "linux /SLUG" "loopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux /multiboot/$JustISOName/casper/vmlinuz.efi iso-scan/filename=/multiboot/$JustISOName/$JustISO boot=casper noprompt noeject fsck.mode=skip floppy.allowed_drive_mask=0 ignore_uuid" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
 ${EndIf}
  
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\casper\vmlinuz"
 ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$JustISO"
 !insertmacro ReplaceInFile "linux /SLUG" "loopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux /multiboot/$JustISOName/casper/vmlinuz iso-scan/filename=/multiboot/$JustISOName/$JustISO boot=casper noprompt noeject fsck.mode=skip floppy.allowed_drive_mask=0 ignore_uuid" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
 ${EndIf}
 
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\live\vmlinuz" 
 ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$JustISO" 
 !insertmacro ReplaceInFile "linux /SLUG" "loopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux /multiboot/$JustISOName/live/vmlinuz iso-scan/filename=/multiboot/$JustISOName/$JustISO boot=live noprompt noeject fsck.mode=skip components config findiso=/multiboot/$JustISOName/$JustISO" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
 ${EndIf}
 
 ; add method for initrd
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\live\initrd"
 ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$JustISO" 
 !insertmacro ReplaceInFile "initrd /SLUG" "initrd (loop)/live/initrd" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
 ${EndIf} 
 
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\casper\initrd" 
 ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$JustISO"   
 !insertmacro ReplaceInFile "initrd /SLUG" "initrd (loop)/casper/initrd" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
 ${EndIf} 
 ; end method for initrd
 
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\live\initrd.gz"
 ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$JustISO" 
 !insertmacro ReplaceInFile "initrd /SLUG" "initrd (loop)/live/initrd.gz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
 ${EndIf} 
 
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\casper\initrd.gz" 
 ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$JustISO"   
 !insertmacro ReplaceInFile "initrd /SLUG" "initrd (loop)/casper/initrd.gz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
 ${EndIf} 
 
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\casper\initrd.lz" 
 ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$JustISO"   
 !insertmacro ReplaceInFile "initrd /SLUG" "initrd (loop)/casper/initrd.lz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
 ${EndIf} 
 
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\live\initrd.lz" 
 ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$JustISO"   
 !insertmacro ReplaceInFile "initrd /SLUG" "initrd (loop)/live/initrd.lz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
 ${EndIf} 
 
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\live\initrd.img" ; For Distros such as Emmabuntus
 ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$JustISO"   
 !insertmacro ReplaceInFile "initrd /SLUG" "initrd (loop)/live/initrd.img" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
 ${EndIf} 
 
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\casper\initrd.img"
 ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$JustISO"   
 !insertmacro ReplaceInFile "initrd /SLUG" "initrd (loop)/casper/initrd.img" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
 ${EndIf} 
 
 ${If} $DistroName == "Ubuntu"  
 !insertmacro ReplaceInFile "SOMETHING.seed" "ubuntu.seed" "all" "all" "$BootDir\multiboot\menu\linux.cfg"  
 ${ElseIf} $DistroName == "Cub Linux"  
 !insertmacro ReplaceInFile "SOMETHING.seed" "ubuntu.seed" "all" "all" "$BootDir\multiboot\menu\linux.cfg"  
 ${ElseIf} $DistroName == "Ubuntu Gnome"
 !insertmacro ReplaceInFile "SOMETHING.seed" "ubuntu-gnome.seed" "all" "all" "$BootDir\multiboot\menu\linux.cfg"  
 ${ElseIf} $DistroName == "Ubuntu Studio"
 !insertmacro ReplaceInFile "SOMETHING.seed" "ubuntustudio.seed" "all" "all" "$BootDir\multiboot\menu\linux.cfg"  
 ${ElseIf} $DistroName == "Xubuntu"
 !insertmacro ReplaceInFile "SOMETHING.seed" "xubuntu.seed" "all" "all" "$BootDir\multiboot\menu\linux.cfg"  
 ${ElseIf} $DistroName == "Kubuntu"
 !insertmacro ReplaceInFile "SOMETHING.seed" "kubuntu.seed" "all" "all" "$BootDir\multiboot\menu\linux.cfg"  
 ${ElseIf} $DistroName == "Lubuntu"
 !insertmacro ReplaceInFile "SOMETHING.seed" "lubuntu.seed" "all" "all" "$BootDir\multiboot\menu\linux.cfg"  
 ${ElseIf} $DistroName == "Edubuntu"
 !insertmacro ReplaceInFile "SOMETHING.seed" "edubuntu.seed" "all" "all" "$BootDir\multiboot\menu\linux.cfg"  
 ${ElseIf} $DistroName == "Ubuntu Budgie"
 !insertmacro ReplaceInFile "SOMETHING.seed" "ubuntu-budgie.seed" "all" "all" "$BootDir\multiboot\menu\linux.cfg"
 ${ElseIf} $DistroName == "Feren OS"
 !insertmacro ReplaceInFile "SOMETHING.seed" "lubuntu.seed" "all" "all" "$BootDir\multiboot\menu\linux.cfg"
 ${EndIf}  
  
; OpenSUSE
 ${ElseIf} $DistroName == "OpenSUSE"
  ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y'  
  ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nlinux /multiboot/$JustISOName/boot/x86_64/loader/linux rd.live.image rd.live.overlay.persistent rd.live.overlay.cowfs=ext4 root=live:CDLABEL=TA live_dir=/multiboot/$JustISOName/LiveOS$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd /multiboot/$JustISOName/boot/x86_64/loader/initrd$\r$\n}$\r$\n#] $JustISOName" $R0  

 ;;CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory
; OpenSUSE 32bit  
 ;;${If} ${FileExists} "$BootDir\multiboot\$JustISOName\OpenSUSE*86.iso"
 ;;${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nloopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux (loop)/boot/i386/loader/linux ramdisk_size=512000 ramdisk_blocksize=4096 iso-scan/filename=/multiboot/$JustISOName/$JustISO isofrom=/dev/disk/by-label/TA:/multiboot/$JustISOName/$JustISO isofrom_device=/dev/disk/by-label/TA isofrom_system=/multiboot/$JustISOName/$JustISO$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd (loop)/boot/i386/loader/initrd$\r$\n}$\r$\n#] $JustISOName" $R0  
 ;;${EndIf} 
; OpenSUSE 64bit 
 ;;${If} ${FileExists} "$BootDir\multiboot\$JustISOName\OpenSUSE*64.iso"
 ;;${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nloopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux (loop)/boot/x86_64/loader/linux ramdisk_size=512000 ramdisk_blocksize=4096 iso-scan/filename=/multiboot/$JustISOName/$JustISO isofrom=/dev/disk/by-label/TA:/multiboot/$JustISOName/$JustISO isofrom_device=/dev/disk/by-label/TA isofrom_system=/multiboot/$JustISOName/$JustISO$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd (loop)/boot/x86_64/loader/initrd$\r$\n}$\r$\n#] $JustISOName" $R0  
 ;;${EndIf} 
 
 ;;${If} ${FileExists} "$BootDir\multiboot\$JustISOName\OpenSUSE*Live-x86_64*.iso"
 ;;${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nloopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux (loop)/boot/x86_64/loader/linux ramdisk_size=512000 ramdisk_blocksize=4096 iso-scan/filename=/multiboot/$JustISOName/$JustISO isofrom=/dev/disk/by-label/TA:/multiboot/$JustISOName/$JustISO isofrom_device=/dev/disk/by-label/TA isofrom_system=/multiboot/$JustISOName/$JustISO$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd (loop)/boot/x86_64/loader/initrd$\r$\n}$\r$\n#] $JustISOName" $R0  
 ;;${EndIf}
 
; FreeDOS (Balder img) 
 ${ElseIf} $DistroName == "FreeDOS (Balder img)"
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO"
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nlinux16 /multiboot/menu/memdisk$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd16 /multiboot/$JustISOName/$JustISO$\r$\n}$\r$\n#] $JustISOName" $R0  
 
 ; XPUD (New Method) 
 ${ElseIf} $DistroName == "xPUD (Netbook Distro)" 
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nloopback loop /multiboot/$JustISOName/$JustISO$\r$\nlinux (loop)/boot/bzImage noisapnp lang=en kmap=us fromiso=/multiboot/$JustISOName/$JustISO$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\ninitrd (loop)/opt/core$\r$\n}$\r$\n#] $JustISOName" $R0  
 
; Memtest86+ (Memory Testing Tool)
 ${ElseIf} $DistroName == "Memtest86+ (Memory Testing Tool) BIOS ONLY"
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y'  
 ${WriteToFile} "#[ $JustISOName$\r$\nif [ $${grub_platform} == $\"pc$\" ]; then$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nlinux16 /multiboot/$JustISOName/$JustISOName.bin$\r$\n}$\r$\nfi$\r$\n#] $JustISOName" $R0

; Windows 10
 ${ElseIf} $DistroName == "Windows 10 Installer"
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -xr!bootx64.efi -o"$BootDir\" -y' 
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -ir!bootx64.efi -aou -o"$BootDir\" -y'  
 ReadEnvStr $R0 COMSPEC ; grab commandline
 nsExec::Exec "$R0 /C Rename $BootDir\boot\ஐ-விரிவாக்கக்கூடிய_நிலைபொருள்_இடைமுகம்\bootx64_1.efi win10.efi" ; rename efi file  
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\nif [ $${grub_platform} == $\"pc$\" ]; then ntldr /bootmgr; fi$\r$\nif [ $${grub_platform} == $\"efi$\" ]; then chainloader /boot/ஐ-விரிவாக்கக்கூடிய_நிலைபொருள்_இடைமுகம்/win10.efi; fi$\r$\n}$\r$\n#] $JustISOName" $R0

 ; Windows Vista/7/8
 ${ElseIf} $DistroName == "Windows Vista/7/8 Installer"
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -o"$BootDir\" -y -x![BOOT]*' 
 ${WriteToFile} "#[ $JustISOName$\r$\ntitle Install $JustISOName$\r$\nchainloader /bootmgr$\r$\n#] $JustISOName" $R0  

; Windows XP
/*  ${ElseIf} $DistroName == "Windows XP Installer" 
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" ; Copy the ISO to Directory
 ${WriteToFile} "#[ $JustISOName$\r$\ntitle Begin Install of Windows XP from $JustISO (Stage 1)$\r$\nfind --set-root /multiboot/$JustISOName/$JustISO$\r$\nmap (hd0) (hd1)$\r$\nmap (hd1) (hd0)$\r$\nmap --mem /multiboot/$JustISOName/firadisk.img (fd0)$\r$\nmap --mem /multiboot/$JustISOName/firadisk.img (fd1)$\r$\nmap --mem /multiboot/$JustISOName/$JustISO (0xff)$\r$\nmap --hook$\r$\nchainloader (0xff)/I386/SETUPLDR.BIN$\r$\n$\r$\ntitle Continue Windows XP Install from $JustISO (Stage 2)$\r$\nfind --set-root /multiboot/$JustISOName/$JustISO$\r$\nmap (hd0) (hd1)$\r$\nmap (hd1) (hd0)$\r$\nmap --mem /multiboot/$JustISOName/$JustISO (0xff)$\r$\nmap --hook$\r$\nchainloader (hd0)+1$\r$\n$\r$\ntitle Boot Windows XP - If fails, reboot with USB removed (Stage 3)$\r$\nmap (hd1) (hd0)$\r$\nmap (hd0) (hd1)$\r$\nroot (hd1,0)$\r$\nfind --set-root /ntldr$\r$\nchainloader /ntldr$\r$\n#] $JustISOName" $R0  
 File /oname=$PLUGINSDIR\firadisk.img "firadisk.img"  
 CopyFiles "$PLUGINSDIR\firadisk.img" "$BootDir\multiboot\$JustISOName\firadisk.img"    */
 
; Hiren's BootCD PE
 ${ElseIf} $DistroName == "Hiren's BootCD PE"
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -xr!bootx64.efi -o"$BootDir\" -y' 
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -ir!bootx64.efi -aou -o"$BootDir\" -y'  
 ReadEnvStr $R0 COMSPEC ; grab commandline
 nsExec::Exec "$R0 /C Rename $BootDir\boot\ஐ-விரிவாக்கக்கூடிய_நிலைபொருள்_இடைமுகம்\bootx64_1.efi HBCDPE.efi" ; rename efi file  
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\nif [ $${grub_platform} == $\"pc$\" ]; then ntldr /bootmgr; fi$\r$\nif [ $${grub_platform} == $\"efi$\" ]; then chainloader /boot/ஐ-விரிவாக்கக்கூடிய_நிலைபொருள்_இடைமுகம்/HBCDPE.efi; fi$\r$\n}$\r$\n#] $JustISOName" $R0
 
; RemixOS  
 ${ElseIf} $DistroName == "RemixOS"
 CreateDirectory "$EXEDIR\TEMPI" ; Create the TEMPI directory
 ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -o"$EXEDIR\TEMPI" -y' 
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$EXEDIR\TEMPI\Remix_OS*.iso" -o"$BootDir\multiboot\$JustISOName\" -y'  
 RMDir /R "$EXEDIR\TEMPI"
 Call FindGrubConfig
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nconfigfile /multiboot/$JustISOName/$GrubConfigPath/$GrubConfigFile$\r$\n}$\r$\n#] $JustISOName" $R0   
  !insertmacro ReplaceInFile "linuxefi /kernel" "linux /multiboot/$JustISOName/kernel" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"  
  !insertmacro ReplaceInFile "initrdefi /initrd.img" "initrd /multiboot/$JustISOName/initrd.img" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"
  !insertmacro ReplaceInFile "--set=root /kernel" "--set=root /multiboot/$JustISOName/kernel" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile" 
  !insertmacro ReplaceInFile "quiet DATA= USB_DATA_PARTITION=1" "CREATE_DATA_IMG=1" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"   
  
; Pop!_OS  
 ${ElseIf} $DistroName == "POP!_OS"
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -o"$BootDir\multiboot\$JustISOName\" -y'    
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nconfigfile /multiboot/$JustISOName/boot/grub/grub.cfg$\r$\n}$\r$\n#] $JustISOName" $R0   
 !insertmacro ReplaceInFile "linux /casper_pop-os" "linux /multiboot/$JustISOName/casper_pop-os" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg"  
 !insertmacro ReplaceInFile "initrd /casper_pop-os" "initrd /multiboot/$JustISOName/casper_pop-os" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg" 
 !insertmacro ReplaceInFile "=/casper_pop-os" "=/multiboot/$JustISOName/casper_pop-os" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg" 
 !insertmacro ReplaceInFile "loadfont /boot" "loadfont /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg" 
 !insertmacro ReplaceInFile "theme=/boot" "theme=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg" 
 
; Memtest86 
 ${ElseIf} $DistroName == "Memtest86 (Memory Testing Tool)"  
 ;CreateDirectory "$EXEDIR\TEMPI" ; Create the TEMPI directory
 ;ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -o"$EXEDIR\TEMPI" -y' 
  ExecWait '"$PLUGINSDIR\new7z\7zG.exe" e "$ISOFile" -ir!memtest86-usb.img -o"$BootDir\multiboot\$JustISOName\" -y' 
  ;CopyFiles $EXEDIR\TEMPI\memtest86-usb.img "$BootDir\multiboot\$JustISOName\" 
  ExecWait '"$PLUGINSDIR\new7z\7zG.exe" x "$BootDir\multiboot\$JustISOName\memtest86-usb.img" -o"$BootDir\multiboot\$JustISOName\" -y'
  ExecWait '"$PLUGINSDIR\new7z\7zG.exe" x "$BootDir\multiboot\$JustISOName\EFI System Partition.img" -o"$BootDir\multiboot\$JustISOName\" -y'
 ;RMDir /R "$EXEDIR\TEMPI" 
 ${WriteToFile} "#[ $JustISOName$\r$\nif [ $${grub_platform} == $\"efi$\" ]; then$\r$\nmenuentry $\"$JustISOName X64$\" {$\r$\nset gfxpayload=keep$\r$\nloopback loop /multiboot/$JustISOName/memtest86-usb.img$\r$\nchainloader /multiboot/$JustISOName/EFI/BOOT/BOOTX64.efi$\r$\n}$\r$\n$\r$\nmenuentry $\"$JustISOName IA32$\" {$\r$\nloopback loop /multiboot/$JustISOName/memtest86-usb.img$\r$\nchainloader /multiboot/$JustISOName/EFI/BOOT/BOOTIA32.efi$\r$\n}$\r$\nfi$\r$\n#] $JustISOName" $R0 
 
; Slacko Puppy/BionicPup
 ${ElseIf} $DistroName == "Slacko Puppy"
  ${OrIf} $DistroName == "BionicPup"
    ${OrIf} $DistroName == "puppy Linux"
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y'  
 # Call FindGrubConfig
 ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nconfigfile /multiboot/$JustISOName/grub.cfg$\r$\n}$\r$\n#] $JustISOName" $R0   
  !insertmacro ReplaceInFile "linux /vmlinuz" "linux /multiboot/$JustISOName/vmlinuz psubdir=/multiboot/$JustISOName psubok=TRUE" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
  !insertmacro ReplaceInFile "initrd /initrd" "initrd /multiboot/$JustISOName/initrd" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"
 
; Ultimate Boot CD and Hirens Boot CD
 ${ElseIf} $DistroName == "Ultimate Boot CD (Diagnostics Tools) - BIOS ONLY"  
 ${OrIf} $DistroName == "Hiren's Boot CD - BIOS ONLY" 
 ${OrIf} $DistroName == "Falcon 4 Boot CD - BIOS ONLY"  
 CopyFiles $ISOFile "$BootDir\multiboot\$JustISOName\$JustISO" 
 ${WriteToFile} "#[ $JustISOName$\r$\nif [ $${grub_platform} == $\"pc$\" ]; then$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nset isofile=$\"/multiboot/$JustISOName/$JustISO$\"$\r$\necho $\"https://TamilNeram.github.io...$\"$\r$\nlinux16 /multiboot/menu/memdisk iso raw$\r$\ninitrd16 $$isofile$\r$\n}; fi$\r$\n#] $JustISOName" $R0  

 ${Else} ; Start Catch All Install Methods 
 ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -x![BOOT] -o"$BootDir\multiboot\$JustISOName\" -y'  
 Call FindConfig
 Call FindGrubConfig
 ${If} $GrubConfigFile != "NULL" ; If native Grub config file does exist... 
    ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=auto$\r$\nconfigfile /multiboot/$JustISOName/$GrubConfigPath/$GrubConfigFile$\r$\n}$\r$\n#] $JustISOName" $R0   
 ${ElseIf} $GrubConfigFile == "NULL" ; If Grub config file does not exist... 
 ${AndIfNot} ${FileExists} "$BootDir\multiboot\$JustISOName\grub.cfg"  
    CopyFiles "$PLUGINSDIR\grubslug.cfg" "$BootDir\multiboot\$JustISOName\grub.cfg"
    ${WriteToFile} "#[ $JustISOName$\r$\nmenuentry $\"$JustISOName$\" {$\r$\nset gfxpayload=keep$\r$\nconfigfile /multiboot/$JustISOName/grub.cfg$\r$\n}$\r$\n#] $JustISOName" $R0 
    !insertmacro ReplaceInFile "menuentry $\"BOOT$\"" "menuentry $\"$JustISOName$\"" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
 ${EndIf}

; Ubuntu derived
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\casper\vmlinuz.efi" 
  ${AndIf} $GrubConfigFile == "NULL" ; If Grub config file does not exist... 
  !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/casper/vmlinuz.efi boot=casper noprompt live-media-path=/multiboot/$JustISOName/casper floppy.allowed_drive_mask=0 ignore_uuid" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
 ${EndIf}
 
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\casper\vmlinuz"
  ${AndIf} $GrubConfigFile == "NULL" ; If Grub config file does not exist...  
  !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/casper/vmlinuz boot=casper noprompt live-media-path=/multiboot/$JustISOName/casper floppy.allowed_drive_mask=0 ignore_uuid" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
 ${EndIf}
 
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\casper\initrd.lz"  
  ${AndIf} $GrubConfigFile == "NULL" ; If Grub config file does not exist...  
  !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/casper/initrd.lz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
 ${EndIf}
 
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\casper\initrd.gz"  
  ${AndIf} $GrubConfigFile == "NULL" ; If Grub config file does not exist...  
  !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/casper/initrd.gz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
 ${EndIf}  
  
; For RemixOS - Android derived
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\android-x86.png" 
  !insertmacro ReplaceInFile "linuxefi /kernel" "linux /multiboot/$JustISOName/kernel" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"  
  !insertmacro ReplaceInFile "initrdefi /initrd.img" "initrd /multiboot/$JustISOName/initrd.img" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"
  !insertmacro ReplaceInFile "--set=root /kernel" "--set=root /multiboot/$JustISOName/kernel" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"
 ${EndIf}

; More Catch All Methods for Vmlinuz, Initrd, Livedir

; Vmlinuz check
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\vmlinu*"  
  ${AndIf} $GrubConfigFile != "NULL" ; If native Grub config file does exist...  
  !insertmacro ReplaceInFile "linux /boot" "linux /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"    
 ${EndIf} 
 
; Init check
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\initr*"  
  ${AndIf} $GrubConfigFile != "NULL" ; If native Grub config file does exist...  
  !insertmacro ReplaceInFile "initrd /boot" "initrd /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"    
 ${EndIf}  
 
 ; Live media path check
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\live\*.*"  
  ${AndIf} $GrubConfigFile != "NULL" ; If native Grub config file does exist...  
  !insertmacro ReplaceInFile "boot=live" "boot=NULL" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"  
  !insertmacro ReplaceInFile "boot=NULL" "boot=live live-media-path=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile" 
 ${EndIf}  
 
 ; Casper path check
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\casper\*.*"  
  ${AndIf} $GrubConfigFile != "NULL" ; If native Grub config file does exist...   
   !insertmacro ReplaceInFile "boot=casper" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid boot=NULL live-media-path=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"  
  !insertmacro ReplaceInFile "boot=NULL" "boot=casper" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"  
 ${EndIf}
 
 
; Mageia / Manjaro
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\grub\kernels.cfg"  
  ${AndIf} $GrubConfigFile != "NULL" ; If native Grub config file does exist...  
  !insertmacro ReplaceInFile " /boot" " /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile" 
  !insertmacro ReplaceInFile "$\"/boot/" "$\"/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile" 
  !insertmacro ReplaceInFile " /boot" " /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\kernels.cfg" 
  !insertmacro ReplaceInFile "misobasedir=manjaro" "misobasedir=/multiboot/$JustISOName/manjaro" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\kernels.cfg"
  !insertmacro ReplaceInFile "misolabel=MJ" "misolabel=TA NULL-" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\kernels.cfg"
  !insertmacro ReplaceInFile "misolabel=M1" "misolabel=TA NULL-" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\kernels.cfg"
  !insertmacro ReplaceInFile "misolabel=MANJ" "misolabel=TA NULL-" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\kernels.cfg"  
  !insertmacro ReplaceInFile "$\"/boot/" "$\"/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\kernels.cfg"
  !insertmacro ReplaceInFile " /boot/" " /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\loopback.cfg"
  !insertmacro ReplaceInFile "grub_theme=/boot" "grub_theme=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\variable.cfg"  
 ${EndIf} 

 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\cdrom\init*"  
  ${AndIf} $GrubConfigFile != "NULL" ; If native Grub config file does exist...  
  !insertmacro ReplaceInFile "initrd /boot" "initrd /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"    
 ${EndIf}  
 
; NetRunner
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\netrunner\boot\x86_64\netrunner"  
  !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/netrunner/boot/x86_64/netrunner misobasedir=/multiboot/$JustISOName/netrunner misolabel=TA nouveau.modeset=1 i915.modeset=1 radeon.modeset=1 logo.nologo overlay=free showopts" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
 ${EndIf} 
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\netrunner\boot\x86_64\netrunner.img"  
  !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/netrunner/boot/x86_64/netrunner.img" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
 ${EndIf}  
 
; PCLinuxOS
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\vmlinuz"  
   ${AndIf} $GrubConfigFile == "NULL" ; If native Grub config file does not exist... 
  !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/isolinux/vmlinuz fromusb livecd=/multiboot/$JustISOName/livecd root=/dev/rd/3 keyb=us" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
 ${EndIf} 
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\initrd.gz"
   ${AndIf} $GrubConfigFile == "NULL" ; If native Grub config file does not exist...  
  !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/isolinux/initrd.gz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
 ${EndIf}  
 
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\vmlinuz"  
   ${AndIf} $GrubConfigFile != "NULL" ; If native Grub config file does exist... 
  !insertmacro ReplaceInFile "linux /isolinux/vmlinuz" "linux /multiboot/$JustISOName/isolinux/vmlinuz fromusb livecd=/multiboot/$JustISOName/livecd root=/dev/rd/3 keyb=us" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"    
 ${EndIf} 
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\initrd.gz"
  ${AndIf} $GrubConfigFile != "NULL" ; If native Grub config file does exist...  
  !insertmacro ReplaceInFile "initrd /isolinux/initrd.gz" "initrd /multiboot/$JustISOName/isolinux/initrd.gz" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"    
  ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\EFI\BOOT\grub.cfg"
  !insertmacro ReplaceInFile "theme=($$root)/boot/ஐ-விரிவாக்கக்கூடிய_நிலைபொருள்_இடைமுகம்/" "theme=($$root)/multiboot/$JustISOName/EFI/BOOT/" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"    
 ${EndIf}    
 
; Partition Wizard 
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\BOOT\BZIMAGE3"
 ${AndIf} $GrubConfigFile != "NULL" 
 !insertmacro ReplaceInFile "linuxefi /boot/bzImage3" "linux /multiboot/$JustISOName/boot/bzImage3" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"  
 !insertmacro ReplaceInFile "initrdefi /boot/tinycore.gz" "initrd /multiboot/$JustISOName/boot/tinycore.gz" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"  
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
  !insertmacro ReplaceInFile "=/boot/grub/" "=/multiboot/$JustISOName/boot/grub/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg"  ; Rescuezilla
  ${EndIf}    
  
; SolydX
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\solydxk\filesystem.squashfs" 
  !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/solydxk/vmlinuz live-media-path=/multiboot/$JustISOName/solydxk boot=live config ignore_uuid" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
  !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/solydxk/initrd.lz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
  ${EndIf} 

; Sparky Linux, Subgraph, Clonezilla, etc
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\live\vmlinuz" 
  ${AndIf} $GrubConfigFile != "NULL" 
  !insertmacro ReplaceInFile "/live/vmlinuz" "VMLSLUG" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile" 
  !insertmacro ReplaceInFile "VMLSLUG" " /multiboot/$JustISOName/live/vmlinuz" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile" 
  !insertmacro ReplaceInFile "live-media-path=/live" "live-media-path=/multiboot/$JustISOName/live cdrom-detect/try-usb=true" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"   
  !insertmacro ReplaceInFile "boot=live" "BOOTSLUG" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile" 
  !insertmacro ReplaceInFile "BOOTSLUG" "boot=live noprompt live-media-path=/multiboot/$JustISOName/live cdrom-detect/try-usb=true" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"   
  ${EndIf} 
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\live\initrd.img" 
  ${AndIf} $GrubConfigFile != "NULL" 
  !insertmacro ReplaceInFile "/live/initrd.img" "INITSLUG" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"    
  !insertmacro ReplaceInFile "INITSLUG" " /multiboot/$JustISOName/live/initrd.img" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"     
  ${EndIf}  
  
; For Desinfect Distro 
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\os.cfg" ; Rename the following for isolinux os.cfg
  !insertmacro ReplaceInFile "file=/cdrom/preseed/" "file=/cdrom/multiboot/$JustISOName/preseed/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\os.cfg"  
  !insertmacro ReplaceInFile "initrd=/casper/" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid live-media-path=/multiboot/$JustISOName/casper/ initrd=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\os.cfg"  
  !insertmacro ReplaceInFile "kernel /casper/" "kernel /multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\os.cfg"    
  !insertmacro ReplaceInFile "BOOT_IMAGE=/casper/" "BOOT_IMAGE=/multiboot/$JustISOName/casper/" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\os.cfg"    
  ${EndIf} 
   
; For Fedora Based and derivatives
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\LiveOS\livecd-iso-to-disk"  ; Probably Fedora based
   !insertmacro ReplaceInFile "root=live:CDLABEL=" "root=live:LABEL=TA live_dir=/multiboot/$JustISOName/LiveOS NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"   
   !insertmacro ReplaceInFile "root=live:LABEL=Fedora" "root=live:LABEL=TA live_dir=/multiboot/$JustISOName/LiveOS NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"   
   !insertmacro ReplaceInFile "isolinux/vmlin" "multiboot/$JustISOName/isolinux/vmlin" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"   
   !insertmacro ReplaceInFile "isolinux/init" "multiboot/$JustISOName/isolinux/init" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"   
   !insertmacro ReplaceInFile "linuxefi" "linux" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"   
   !insertmacro ReplaceInFile "initrdefi" "initrd" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile" 
   ${AndIf} $GrubConfigFile == "NULL" ;It's likely not natively Grub supported... let's do this differently
    !insertmacro ReplaceInFile "menuentry $\"BOOT$\"" "menuentry $\"$JustISOName$\"" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
    !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/isolinux/vmlinuz0 live_dir=/multiboot/$JustISOName/LiveOS initrd=initrd0.img root=live:LABEL=TA live_dir=/multiboot/$JustISOName/LiveOS rootfstype=auto ro rd.live.image rhgb rd.luks=0 rd.md=0 rd.dm=0" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
    !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/isolinux/initrd0.img" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
  ${EndIf}   
  
; Offline NT and others 
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\initrd.cgz" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\scsi.cgz"  
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\vmlinuz" 
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/vmlinuz rw loglevel=1" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/initrd.cgz /multiboot/$JustISOName/scsi.cgz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   ${EndIf}   

; For Puppy Based and derivatives
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux.cfg" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\help2.msg"  ; Probably Puppy based 
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/vmlinuz psubdir=/multiboot/$JustISOName psubok=TRUE" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\initrd.gz"   
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/initrd.gz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\initrd"  
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/initrd" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"     
   ${EndIf}    
   
/* ; For Slacko Puppy Based and derivatives
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux.cfg" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\slacko.png"  ; Probably Slacko based
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\help\help.msg"  ; Probably Puppy based 
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/vmlinuz psubdir=/multiboot/$JustISOName psubok=TRUE" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\initrd.gz"   
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/initrd.gz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\initrd"  
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/initrd" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"     
   ${EndIf}    */
   
; Fatdog64  
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux.cfg" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\help\help.msg"  ; Probably Puppy based 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\fatdog.png"  ; Fatdog64
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/vmlinuz rootfstype=ramfs waitdev=5" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\initrd.gz" 
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/initrd" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\initrd" 
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/initrd" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   ${EndIf} 
   
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux.cfg" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\help\help.msg"  ; Probably Puppy based 
   ${AndIfNot} ${FileExists} "$BootDir\multiboot\$JustISOName\fatdog.png"  ; Fatdog64
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/vmlinuz psubdir=/multiboot/$JustISOName psubok=TRUE" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\initrd.gz"    
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/initrd.gz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\initrd" 
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/initrd" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   ${EndIf}   
   
; Dpup
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux.cfg" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\help.msg"  ; Probably Puppy based 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\dpup*"  ; Dpup
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/vmlinuz psubdir=/multiboot/$JustISOName psubok=TRUE" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\initrd.gz" 
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/initrd.gz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\initrd" 
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/initrd" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"   
   ${EndIf}    
  
; AntivirusLiveCD, Comodo
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\bzImage"  
  ${AndIf} $GrubConfigFile != "NULL"  
  !insertmacro ReplaceInFile "kernel /boot/bzImage" "kernel /multiboot/$JustISOName/boot/bzImage" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile" 
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\bzImage"  
  ${AndIf} $GrubConfigFile == "NULL"    
  !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/boot/bzImage" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
  ${EndIf}   
  
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\bzImage"   
  ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\initrd*" 
  ${AndIf} $GrubConfigFile != "NULL"    
  ${OrIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\rootfs*"  
  !insertmacro ReplaceInFile "append initrd=/boot" "append initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"  
  ${EndIf} 
  
  ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\*.jpg" ; Fix background Image Paths
  ${OrIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\*.png"   
  !insertmacro ReplaceInFile "MENU BACKGROUND /boot" "MENU BACKGROUND /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"   
  ${EndIf} 
  
; AOSS
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\system\stage1"  
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/system/stage1 root=/dev/ram0 rw rdinit=/linuxrc video=vesa:ywrap,mtrr vga=0x303 loglevel=0 boot=usb" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/system/stage2" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
   ;!insertmacro ReplaceInFile "boot=cdrom" "boot=usb" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"    
   ${EndIf} 
   
; AVG Rescue CD   
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\initrd.lzm"     
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/isolinux/initrd.lzm" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"     
   ${EndIf}  
   
; TinyCore, + REVISIT WifiWay, + REVISIT Dr.Web
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\vmlinuz"  
   ${AndIf} $GrubConfigFile == "NULL"   
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/boot/vmlinuz loglevel=3 cde waitusb=5" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\initrd"
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/boot/initrd" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   ${OrIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\initrd.gz"  
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/boot/initrd.gz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   ${OrIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\initrd.lz"     
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/boot/initrd.lz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   ${EndIf}
   
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\vmlinuz64"  
   ${AndIf} $GrubConfigFile == "NULL"    
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/boot/vmlinuz64 loglevel=3 cde waitusb=5" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"     
   ${ElseIf} $GrubConfigFile != "NULL"    
   !insertmacro ReplaceInFile "/boot/vmlinuz64" "KERNSLUG" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"       
   !insertmacro ReplaceInFile "KERNSLUG" "/multiboot/$JustISOName/boot/vmlinuz64" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"       
   ${EndIf} 

   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\corepure64.gz" ; TinyCore specific
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/boot/corepure64.gz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   ${ElseIf} $GrubConfigFile != "NULL" 
   !insertmacro ReplaceInFile "/boot/corepure64.gz" "INITSLUG" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"     
   !insertmacro ReplaceInFile "INITSLUG" "/multiboot/$JustISOName/boot/corepure64.gz" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"     
   ${EndIf}   
   
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\core.gz" ; TinyCore specific
   ${AndIf} $GrubConfigFile == "NULL"  
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/boot/core.gz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   !insertmacro ReplaceInFile "INITRD /SLUG" "INITRD /multiboot/$JustISOName/boot/core.gz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"     
   ${EndIf}
   
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\tinycore.gz" ; Partition Wizard, TinyCore specific
   ${AndIf} $GrubConfigFile == "NULL"  
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/boot/tinycore.gz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   !insertmacro ReplaceInFile "INITRD /SLUG" "INITRD /multiboot/$JustISOName/boot/tinycore.gz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"     
   ${EndIf}    
   
; F-Secure Rescue CD
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\isolinux\fsecure\linux"  
   ${AndIf} $GrubConfigFile == "NULL"    
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/boot/isolinux/fsecure/linux noprompt knoppix_dir=/multiboot/$JustISOName/KNOPPIX" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/boot/isolinux/fsecure/minirt.gz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${EndIf}   

; GData
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\linux17" 
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/boot/linux17 boot=live live-media-path=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\initrd17.xz"
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/boot/initrd17.xz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${EndIf} 
   
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\linux6" 
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/boot/linux6 boot=live live-media-path=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\initrd6.xz"
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/boot/initrd6.xz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${EndIf}    

; Liberte
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\liberte\boot\syslinux\syslinux.cfg"  
   ${AndIf} $GrubConfigFile == "NULL"    
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/liberte/boot/kernel-x86.zi loop=/multiboot/$JustISOName/liberte/boot/root-x86.sfs" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/liberte/boot/initrd-x86.xz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${EndIf}    

; Panda Safe CD 
   ${If} $DistroName == "Panda SafeCD" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\live\vmlinuz"     
   ${AndIf} $GrubConfigFile == "NULL"    
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/live/vmlinuz noprompt boot=live config union=aufs live-media-path=/multiboot/$JustISOName/live noacpi acpi=off" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/live/initrd.img" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${EndIf} 
   
   ${If} $DistroName == "Panda SafeCD" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\live\vmlinuz1"     
   ${AndIf} $GrubConfigFile == "NULL"    
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/live/vmlinuz1 noprompt boot=live config union=aufs live-media-path=/multiboot/$JustISOName/live noacpi acpi=off" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/live/initrd1.img" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${EndIf}    
   
; Ghost 4 Linux
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\bz3x12.59"     
   ${AndIf} $GrubConfigFile == "NULL"    
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/bz3x12.59 root=/dev/ram0 noapic noacpi pnpbios=off acpi=off pci=noacpi nosmp" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\ramdisk.lzma"          
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/ramdisk.lzma" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${EndIf}    
   
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\BZ4X14.134"     
   ${AndIf} $GrubConfigFile == "NULL"    
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/BZ4X14.134 root=/dev/ram0 noapic noacpi pnpbios=off acpi=off pci=noacpi nosmp" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\ramdisk.lzma"          
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/ramdisk.lzma" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${EndIf}    
   
; TAILS 
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\tails.cfg"  ; Tails Specific
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/live/vmlinuz live-media-path=/multiboot/$JustISOName/live boot=live config apparmor=1 security=apparmor nopersistence noprompt timezone=Etc/UTC block.events_dfl_poll_msecs=1000 noautologin module=Tails" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/live/initrd.img" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"
   ${ElseIf} $GrubConfigFile != "NULL"  
   !insertmacro ReplaceInFile "syslinux_configfile /efi" "syslinux_configfile /multiboot/$JustISOName/efi" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\efi\boot\live64.cfg"
   !insertmacro ReplaceInFile "kernel /live" "kernel /multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\efi\boot\live64.cfg" 
   !insertmacro ReplaceInFile "initrd=/live" "live-media-path=/multiboot/$JustISOName/live initrd=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\efi\boot\live64.cfg"
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\efi\boot\live.cfg"
   !insertmacro ReplaceInFile "kernel /live" "kernel /multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\efi\boot\live.cfg" 
   !insertmacro ReplaceInFile "initrd=/live" "live-media-path=/multiboot/$JustISOName/live initrd=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\efi\boot\live.cfg"
   ${EndIf}  
   
; AEOMI Backupper 
   ${If} $DistroName == "AEOMI Backupper"       
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/bzImage quiet root=/dev/ram0 rw" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/initrd.gz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${EndIf}    

; Matriux and extracted Live
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\live\vmlinuz" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\live\initrd.img"    
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/live/vmlinuz boot=live config live-media-path=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/live/initrd.img" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${EndIf} 
   
; Ping
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\kernel" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\initrd.gz"    
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/kernel devfs=nomount pxe ramdisk_size=60000 load_ramdisk=1 init=/linuxrc prompt_ramdisk=0 root=/dev/ram0 rw noapic nolapic lba combined_mode=libata ide0=noprobe nomce pci=nomsi irqpoll" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/initrd.gz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${EndIf}   
   
; Webconverger
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\live.cfg"  
   ${AndIf} $GrubConfigFile == "NULL"     
   ;!insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/live/vmlinuz noprompt boot=live live-media-path=/multiboot/$JustISOName/live skipconfig components=gitfs" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/live/vmlinuz noprompt boot=live live-media-path=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"     
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/live/initrd.img" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${EndIf}   
   
; Archlinux
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\archiso.cfg" 
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/arch/boot/x86_64/vmlinuz archisolabel=TA CONFIG /multiboot/$JustISOName/arch archisobasedir=/multiboot/$JustISOName/arch" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/arch/boot/x86_64/archiso.img" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
   ${EndIf}  
   
; Archbang
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\arch\boot\syslinux\syslinux.cfg" 
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/arch/boot/x86_64/vmlinuz archisolabel=TA CONFIG /multiboot/$JustISOName/arch archisobasedir=/multiboot/$JustISOName/arch cow_spacesize=8G copytoram=y" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/arch/boot/x86_64/archiso.img" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
   ${EndIf}     

; Manjaro i686
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\manjaro\boot\i686\manjaro" 
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/manjaro/boot/i686/manjaro misolabel=TA misobasedir=/multiboot/$JustISOName/manjaro" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\manjaro\boot\i686\manjaroiso"  
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/manjaro/boot/i686/manjaroiso misolabel=TA misobasedir=/multiboot/$JustISOName/manjaro" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   ${EndIf}   
   
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\manjaro\boot\i686\manjaro.img"  
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/manjaro/boot/i686/manjaro.img" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${EndIf}   
   
; Manjaro x86_64
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\manjaro\boot\x86_64\manjaro"  
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/manjaro/boot/x86_64/manjaro misolabel=TA misobasedir=/multiboot/$JustISOName/manjaro" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
   ${ElseIf} ${FileExists} "$BootDir\multiboot\$JustISOName\manjaro\boot\x86_64\manjaroiso"  
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/manjaro/boot/x86_64/manjaroiso misolabel=TA misobasedir=/multiboot/$JustISOName/manjaro" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   ${EndIf}      
   
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\manjaro\boot\x86_64\manjaro.img"    
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/manjaro/boot/x86_64/manjaro.img" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${EndIf}   
 
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\.miso"     
   CopyFiles "$BootDir\multiboot\$JustISOName\.miso" "$BootDir"
   ${EndIf}     

; Slax
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\slax\boot\syslinux.cfg"  
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/slax/boot/vmlinuz from=/multiboot/$JustISOName/slax changes=/multiboot/$JustISOName/slax load_ramdisk=1 prompt_ramdisk=0 rw printk.time=0 slax.flags=perch,xmode" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/slax/boot/initrfs.img" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"   
   ${EndIf}   
   
; Porteus
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\syslinux\porteus.cfg"  
   ${AndIf} $GrubConfigFile == "NULL"    
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/boot/syslinux/vmlinuz from=/multiboot/$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" ;eventually use changes=/multiboot/$JustISOName/changes.dat
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/boot/syslinux/initrd.xz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${EndIf}
   
; Rescutux   
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\live\vmlinuz1"     
   ${AndIf} $GrubConfigFile != "NULL"    
   !insertmacro ReplaceInFile "/live/vmlinuz1" "VMLSLUG" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile" 
   !insertmacro ReplaceInFile "VMLSLUG" "/multiboot/$JustISOName/live/vmlinuz1 live-media-path=/multiboot/$JustISOName/live" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\live\initrd1.img" 
   !insertmacro ReplaceInFile "/live/initrd1.img" "INITSLUG" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile" 
   !insertmacro ReplaceInFile "INITSLUG" "/multiboot/$JustISOName/live/initrd1.img" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile" 
   ${EndIf}   
   
; RIPLinux 
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\kernel32"     
   ${AndIf} $GrubConfigFile == "NULL"    
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/boot/kernel32 from=/multiboot/$JustISOName root=/dev/ram0 rw" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\rootfs.cgz"  
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/boot/rootfs.cgz$\r$\n}$\r$\n#MENUSLUG" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\kernel64"      
   !insertmacro ReplaceInFile "#MENUSLUG" "menuentry '64bit - $JustISOName' {$\r$\nlinux /multiboot/$JustISOName/boot/kernel64 from=/multiboot/$JustISOName root=/dev/ram0 rw$\r$\ninitrd /multiboot/$JustISOName/boot/rootfs.cgz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"
   !insertmacro ReplaceInFile "set timeout=0" "set timeout=20" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"
   !insertmacro ReplaceInFile "set TIMEOUT_STYLE=hidden" "#set TIMEOUT_STYLE=hidden" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"   
   ${EndIf}
   
/* ; Trinity Rescue Kit 
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\kernel.trk"     
   ${AndIf} $GrubConfigFile == "NULL"    
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/kernel.trk from=/multiboot/$JustISOName vollabel=TA ramdisk_size=65536 root=/dev/ram0 splash=verbose pci=conf1 trkmenu" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\initrd.trk"  
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/initrd.trk$\r$\n}$\r$\n#MENUSLUG" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\trk3\trkramfs" 
   CopyFiles "$BootDir\multiboot\$JustISOName\trk3\*.*" "$BootDir\trk3\" ; Move trk3 to root, so we can boot!
   RMDir /R "$BootDir\multiboot\$JustISOName\trk3"
   ${EndIf}    */
  
; Knoppix 
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\KNOPPIX\KNOPPIX" 
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/boot/isolinux/linux knoppix_dir=/multiboot/$JustISOName/KNOPPIX noprompt mem=800M" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/boot/isolinux/minirt.gz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"   
   ${EndIf}  
   
; DSL   
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\isolinux\linux24"   
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/boot/isolinux/linux24 noprompt ramdisk_size=100000 init=/etc/init lang=us apm=power-off nomce noapic BOOT_IMAGE=knoppix" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${EndIf}  

   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\isolinux\minirt24.gz"  
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/boot/isolinux/minirt24.gz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"   
   ${EndIf}      
   
; Mandriva/CentOS
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\LiveOS\*.*"   
   ${If} $GrubConfigFile == "NULL" 
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/isolinux/vmlinuz0 root=live:LABEL=TA live_dir=/multiboot/$JustISOName/LiveOS" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/isolinux/initrd0.img" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"    
   ${ElseIf} $GrubConfigFile != "NULL" 
   !insertmacro ReplaceInFile "root=live:LABEL=Cent" "root=live:LABEL=TA live_dir=/multiboot/$JustISOName/LiveOS NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"   
   !insertmacro ReplaceInFile "isolinux/vmlin" "multiboot/$JustISOName/isolinux/vmlin" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"   
   !insertmacro ReplaceInFile "isolinux/init" "multiboot/$JustISOName/isolinux/init" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"      
   !insertmacro ReplaceInFile "set default=$\"1$\"" "set default=$\"0$\"" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"      
   !insertmacro ReplaceInFile "linuxefi" "linux" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"   
   !insertmacro ReplaceInFile "initrdefi" "initrd" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"   
   ${EndIf} 
   ${EndIf}
   
; CentOS Installer
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\LiveOS\*.*"  
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\images\pxeboot\*.*"
   ${AndIf} $GrubConfigFile != "NULL" 
   !insertmacro ReplaceInFile "images/pxeboot/vmlin" "multiboot/$JustISOName/isolinux/vmlin" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"   
   !insertmacro ReplaceInFile "images/pxeboot/init" "multiboot/$JustISOName/isolinux/init" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"         
   !insertmacro ReplaceInFile "inst.stage2=hd:LABEL=Cent" "inst.stage2=hd:LABEL=TA root=live:LABEL=TA live_dir=/multiboot/$JustISOName/LiveOS NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"   
   ${EndIf}  

; Mageia
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\isolinux\isolinux.cfg"
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\loopbacks\distrib-lzma.sqfs"   
   !insertmacro ReplaceInFile "root=mgalive:LABEL=Mageia" "root=mgalive:LABEL=TA NULL=Mageia" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"  
   ${EndIf}        
   
; SlitaZ
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\bzImage"
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\*slitaz" 
   ${AndIfNot} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\isolinux\ophcrack.cfg"
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/boot/bzImage root=/dev/null rw autologin" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${EndIf}    
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\rootfs4.gz" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\rootfs3.gz"  
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\rootfs2.gz" 
   ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\rootfs1.gz"   
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/boot/rootfs4.gz /multiboot/$JustISOName/boot/rootfs3.gz /multiboot/$JustISOName/boot/rootfs2.gz /multiboot/$JustISOName/boot/rootfs1.gz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   ${EndIf}  
   
; Ophcrack
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\isolinux\ophcrack.cfg"
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/boot/bzImage root=/dev/null rw lang=en_US kmap=us autologin" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg" 
   ${EndIf}  
   
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\rootfs.gz" 
   ${AndIf} $GrubConfigFile == "NULL"     
   !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/boot/rootfs.gz" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"  
   ${EndIf}    

   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\bzImage"     
    ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\live.cfg" 
   ${AndIf} $GrubConfigFile == "NULL"  	
    !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/bzImage root=/dev/ram0 rw" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"
    !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/initrd.img" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"   
   ${EndIf} 
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\bzImage"     
    ${AndIf} ${FileExists} "$BootDir\multiboot\$JustISOName\$CopyPath\isolinux.cfg"  
   ${AndIf} $GrubConfigFile == "NULL"  	
    !insertmacro ReplaceInFile "linux /SLUG" "linux /multiboot/$JustISOName/bzImage root=/dev/ram0 rw" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"
    !insertmacro ReplaceInFile "initrd /SLUG" "initrd /multiboot/$JustISOName/initrd.img" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"   
   ${EndIf} 
 
; ESET SysRescue Live
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\eset-favicon.ico" 
   !insertmacro ReplaceInFile "live-media=/dev/disk/by-label/eSysRescueLiveCD" " " "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\txt.cfg"   
   !insertmacro ReplaceInFile "/dev/disk/by-label/eSysRescueLiveCD" "/dev/disk/by-label/TA" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg"   
   ${EndIf}  

; RIP Linux
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\BOOT\DOC\RIPLINUX.TXT" 
   !insertmacro ReplaceInFile "F1 /boot" "F1 /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"
   !insertmacro ReplaceInFile "F2 /boot" "F1 /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"
   !insertmacro ReplaceInFile "F3 /boot" "F1 /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"
   !insertmacro ReplaceInFile "KERNEL /boot" "KERNEL /multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"
   !insertmacro ReplaceInFile "initrd=/boot" "initrd=/multiboot/$JustISOName/boot" "all" "all" "$BootDir\multiboot\$JustISOName\$CopyPath\$ConfigFile"     
   ${EndIf}  
  
 ${EndIf} 
; End Catch All Install Methods
  
; Start Distro Specific 

; Parted Magic
 ${If} $DistroName == "Parted Magic (Partition Tools)" 
  !insertmacro ReplaceInFile "/EFI/boot/grub.cfg" "/multiboot/$JustISOName/EFI/boot/grub.cfg" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg"  
  !insertmacro ReplaceInFile "/pmagic/fu.img" "/multiboot/$JustISOName/pmagic/fu.img" "all" "all" "$BootDir\multiboot\$JustISOName\EFI\boot\grub.cfg" 
  !insertmacro ReplaceInFile "/pmagic/m32.img" "/multiboot/$JustISOName/pmagic/m32.img" "all" "all" "$BootDir\multiboot\$JustISOName\EFI\boot\grub.cfg"   
  !insertmacro ReplaceInFile "/pmagic/m64.img" "/multiboot/$JustISOName/pmagic/m64.img" "all" "all" "$BootDir\multiboot\$JustISOName\EFI\boot\grub.cfg"    
  !insertmacro ReplaceInFile "/pmagic/bzIma" "/multiboot/$JustISOName/pmagic/bzIma" "all" "all" "$BootDir\multiboot\$JustISOName\EFI\boot\grub.cfg" 
  !insertmacro ReplaceInFile "/pmagic/initrd.img" "/multiboot/$JustISOName/pmagic/initrd.img" "all" "all" "$BootDir\multiboot\$JustISOName\EFI\boot\grub.cfg" 
  !insertmacro ReplaceInFile "/EFI/boot/" "/multiboot/$JustISOName/EFI/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\EFI\boot\grub.cfg"
  !insertmacro ReplaceInFile "vga=normal" "directory=/multiboot/$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\EFI\boot\grub.cfg"
  
  !insertmacro ReplaceInFile "/pmagic/fu.img" "/multiboot/$JustISOName/pmagic/fu.img" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg" 
  !insertmacro ReplaceInFile "/pmagic/m32.img" "/multiboot/$JustISOName/pmagic/m32.img" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg"   
  !insertmacro ReplaceInFile "/pmagic/m64.img" "/multiboot/$JustISOName/pmagic/m64.img" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg"    
  !insertmacro ReplaceInFile "/pmagic/bzIma" "/multiboot/$JustISOName/pmagic/bzIma" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg" 
  !insertmacro ReplaceInFile "/pmagic/initrd.img" "/multiboot/$JustISOName/pmagic/initrd.img" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg" 
  !insertmacro ReplaceInFile "/EFI/boot/" "/multiboot/$JustISOName/EFI/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg"
  !insertmacro ReplaceInFile "vga=normal" "directory=/multiboot/$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg"

; System Rescue CD
 ${ElseIf} $DistroName == "System Rescue CD" 
  !insertmacro ReplaceInFile "/isolinux/rescue64" "/multiboot/$JustISOName/isolinux/SLUGrescue subdir=multiboot/$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"    
  !insertmacro ReplaceInFile "SLUGrescue" "rescue64" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"
  !insertmacro ReplaceInFile "/isolinux/altker64" "/multiboot/$JustISOName/isolinux/SLUGaltker subdir=multiboot/$JustISOName" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"    
  !insertmacro ReplaceInFile "SLUGaltker" "altker64" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"     
  !insertmacro ReplaceInFile "/isolinux/initram.igz" "/multiboot/$JustISOName/isolinux/initramSLUG" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile" 
  !insertmacro ReplaceInFile "initramSLUG" "initram.igz" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"  
  
  !insertmacro ReplaceInFile "/sysresccd/boot/" "/multiboot/$JustISOName/SLUGGER/boot/" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile" 
  !insertmacro ReplaceInFile "SLUGGER" "sysresccd" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile" 
  !insertmacro ReplaceInFile "archisolabel=SYSRCD" "archisolabel=TA NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile" 
  !insertmacro ReplaceInFile "archisobasedir=sys" "archisobasedir=/multiboot/$JustISOName/sysresccd NULL=" "all" "all" "$BootDir\multiboot\$JustISOName\$GrubCopyPath\$GrubConfigFile"
  
; Xiaopan 
  ${ElseIf} $DistroName == "Xiaopan (Penetration Testing)"   
  CopyFiles "$BootDir\multiboot\$JustISOName\cde\*.*" "$BootDir\cde\" ;(quick hack until a cde bootcode/cheatcode is made upstream from tinyCore)
  CopyFiles "$BootDir\multiboot\$JustISOName\mydata.tgz" "$BootDir\mydata.tgz"
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
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\grub\loopback.cfg" ; Rename the following for grub loopback.cfg
   !insertmacro ReplaceInFile "cdrom-detect/try-usb=true noprompt" "cdrom-detect/try-usb=true persistent persistent-path=/multiboot/$JustISOName noprompt" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\loopback.cfg"  
   ${EndIf}
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg" ; Rename the following for grub.cfg
   !insertmacro ReplaceInFile "cdrom-detect/try-usb=true noprompt" "cdrom-detect/try-usb=true persistent persistent-path=/multiboot/$JustISOName noprompt" "all" "all" "$BootDir\multiboot\$JustISOName\boot\grub\grub.cfg"   
   ${EndIf} 
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\grub.cfg" ; Rename the following for grub.cfg ubuntu based
   !insertmacro ReplaceInFile "boot=casper noprompt" "boot=casper persistent persistent-path=/multiboot/$JustISOName noprompt" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"   
   ${EndIf}   
   ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\grub.cfg" ; Rename the following for grub.cfg debian based
   !insertmacro ReplaceInFile "boot=live noprompt" "boot=live persistent persistent-path=/multiboot/$JustISOName noprompt" "all" "all" "$BootDir\multiboot\$JustISOName\grub.cfg"   
   ${EndIf}    
; Create Casper-rw file
   Call CasperScript  
  ${EndIf}
 
Call WriteStuff

!macroend