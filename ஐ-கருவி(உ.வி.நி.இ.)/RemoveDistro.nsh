
; ------------ Uninstall Distros Macro -------------- 

!macro Uninstall_Distros  
; New Methods catch-all
 ${If} $DistroName != ""  
  ${DeleteMenuEntry} "$BootDir\multiboot\menu\$Config2Use" "#[ $DistroName" "#] $DistroName" ; கட்டமைப்பு கோப்பிலிருந்து உள்ளீட்டை அகற்று... I.E. linux.cfg, system.cfg, etc
  ${DeleteMenuEntry} "$BootDir\boot\MEFI\grub.cfg" "#[ $DistroName" "#] $DistroName" ; Grub config கோப்பிலிருந்து உள்ளீட்டை அகற்று..
  ${LineFind} "$BootDir\multiboot\நிறுவப்பட்டது.txt" "$BootDir\multiboot\நிறுவப்பட்டது.txt" "1:-1" "DeleteInstall" ; நிறுவப்பட்ட உள்ளீட்டை அகற்று
  ${LineFind} "$BootDir\multiboot\நிறுவப்பட்டது.txt" "$BootDir\multiboot\நிறுவப்பட்டது.txt" "1:-1" "DeleteEmptyLine" ; வெற்று வரிகளில் எஞ்சியவற்றை அகற்று
  ${LineFind} "$BootDir\multiboot\menu\$Config2Use" "$BootDir\multiboot\menu\$Config2Use" "1:-1" "DeleteEmptyLine" ; வெற்று வரிகளில் எஞ்சியவற்றை அகற்று
  CopyFiles "$BootDir\multiboot\நிறுவப்பட்டது.txt" "$BootDir\multiboot\நிறுவப்பட்டது-நகல்.txt" ; பாதுகாப்பிற்காக நிறுவப்பட்டது காப்புப்பிரதியை உருவாக்கவும்
  RMDir /R "$BootDir\multiboot\$DistroName"  
   ${AndIf} ${FileExists} "$BootDir\multiboot\ISOS\$DistroName.iso"   
   Delete "$BootDir\multiboot\ISOS\$DistroName.iso" 
 ${EndIf}
 DetailPrint "$DistroName மற்றும் அதன் மெனு நுழைவு அகற்றப்பட்டது!" 
!macroend