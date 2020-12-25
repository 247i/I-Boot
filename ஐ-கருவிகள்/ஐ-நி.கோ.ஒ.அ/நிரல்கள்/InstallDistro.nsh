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
 ${InstalledList} "$DistroPath\$JustISOName" $R0 ; Write the ISO path name to the Installed List "Installed.txt" file (so we can keep track of installs for removal)
 ${LineFind} "$BootDir\multiboot\Installed.txt" "$BootDir\multiboot\Installed.txt" "1:-1" "DeleteEmptyLine" ; Remove any left over empty lines 
 
 ; Enable and Create Casper if necessary
 ${If} $Persistence == "casper" ; Casper
 ${AndIf} $Casper != "0" ; Casper Slider (Size) was not Null
   Call CasperScript  
 ${EndIf}

!macroend