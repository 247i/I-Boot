; ------------ Uninstall Distros Macro -------------- 

!macro Uninstall_Distros  
   ;MessageBox MB_OK "$DistroName"
 ${If} $DistroName != ""  
   ${AndIf} ${FileExists} "$BDir\multiboot\$DistroName\*.*"  ; $DistroName includes $DistroPath\$JustISOName
    RMDir /R "$BDir\multiboot\$DistroName"
    ;Delete "$BDir\multiboot\$DistroName.iso" 
    ${LineFind} "$BDir\multiboot\Installed.txt" "$BDir\multiboot\Installed.txt" "1:-1" "DeleteInstall" ; Remove the Installed entry
    ${LineFind} "$BDir\multiboot\Installed.txt" "$BDir\multiboot\Installed.txt" "1:-1" "DeleteEmptyLine" ; Remove any left over empty lines
    DetailPrint "$DistroName was Removed!"
 ${EndIf} 
!macroend