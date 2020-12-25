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

; ------------ Uninstall Distros Macro -------------- 

!macro Uninstall_Distros  
   ;MessageBox MB_OK "$DistroName"
 ${If} $DistroName != ""  
   ${AndIf} ${FileExists} "$BootDir\multiboot\$DistroName\*.*"  ; $DistroName includes $DistroPath\$JustISOName
    RMDir /R "$BootDir\multiboot\$DistroName"
    ;Delete "$BootDir\multiboot\$DistroName.iso" 
    ${LineFind} "$BootDir\multiboot\Installed.txt" "$BootDir\multiboot\Installed.txt" "1:-1" "DeleteInstall" ; Remove the Installed entry
    ${LineFind} "$BootDir\multiboot\Installed.txt" "$BootDir\multiboot\Installed.txt" "1:-1" "DeleteEmptyLine" ; Remove any left over empty lines
    DetailPrint "$DistroName was Removed!"
 ${EndIf} 
!macroend