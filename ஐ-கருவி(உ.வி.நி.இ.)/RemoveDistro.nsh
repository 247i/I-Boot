; ------------ Uninstall Distros Macro -------------- 

!macro Uninstall_Distros  
; New Methods catch-all
 ${If} $DistroName != ""  
  ${DeleteMenuEntry} "$BootDir\multiboot\menu\$Config2Use" "#[ $DistroName" "#] $DistroName" ; Remove entry from config file... I.E. linux.cfg, system.cfg, etc
  ${DeleteMenuEntry} "$BootDir\EFI\BOOT\grub.cfg" "#[ $DistroName" "#] $DistroName" ; Remove entry from grub config file.
  ${LineFind} "$BootDir\multiboot\Installed.txt" "$BootDir\multiboot\Installed.txt" "1:-1" "DeleteInstall" ; Remove the Installed entry
  ${LineFind} "$BootDir\multiboot\Installed.txt" "$BootDir\multiboot\Installed.txt" "1:-1" "DeleteEmptyLine" ; Remove any left over empty lines
  ${LineFind} "$BootDir\multiboot\menu\$Config2Use" "$BootDir\multiboot\menu\$Config2Use" "1:-1" "DeleteEmptyLine" ; Remove any left over empty lines
  CopyFiles "$BootDir\multiboot\Installed.txt" "$BootDir\multiboot\BackupInstalled.txt" ; Make a backup of installed for safety
  RMDir /R "$BootDir\multiboot\$DistroName"  
   ${AndIf} ${FileExists} "$BootDir\multiboot\ISOS\$DistroName.iso"   
   Delete "$BootDir\multiboot\ISOS\$DistroName.iso" 
 ${EndIf}
 DetailPrint "$DistroName and its menu entry were Removed!" 
!macroend