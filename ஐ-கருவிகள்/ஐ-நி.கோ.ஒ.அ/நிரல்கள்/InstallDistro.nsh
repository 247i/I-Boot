; ------------ Install Distros Macro -------------- 

!macro Install_Distros 

; If distro is already installed, delete it, so we don't make a mess.
 ${If} ${FileExists} "$BootDir\multiboot\$DistroPath\$JustISO"
  Delete "$BootDir\multiboot\$DistroPath\$JustISO" 
 ${EndIf}

; Create the Path (container for Distro and persistence if available).
 ${IfNot} ${FileExists} "$BootDir\multiboot\$DistroPath\*.*"
  CreateDirectory "$BootDir\multiboot\$DistroPath" ; Create the Directory so we can copy the file to it.
 ${EndIf}
 
; Copy the ISO to the Container
 ${If} $DistroName != "" 
  DetailPrint "Copying $JustISO to $BootDir\multiboot\$DistroPath\"
  CopyFiles $ISOFile "$BootDir\multiboot\$DistroPath\$JustISOName\$JustISO" ; Copy the ISO to Directory
 ${EndIf}
 
; Write the Path to Installed.txt
 ${நிறுவப்பட்டபட்டியல்} "$DistroPath\$JustISOName" $R0 ; Write the ISO path name to the Installed List "Installed.txt" file (so we can keep track of installs for removal)
 ${LineFind} "$BootDir\multiboot\Installed.txt" "$BootDir\multiboot\Installed.txt" "1:-1" "DeleteEmptyLine" ; Remove any left over empty lines 
 
 ; Enable and Create Casper if necessary
 ${If} $Persistence == "casper" ; Casper
 ${AndIf} $Casper != "0" ; Casper Slider (Size) was not Null
   Call CasperScript  
 ${EndIf}

!macroend