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
; New Methods catch-all
 ${If} $DistroName != ""  
  ${DeleteMenuEntry} "$BootDir\multiboot\menu\$Config2Use" "#start $DistroName" "#end $DistroName" ; Remove entry from config file... I.E. linux.cfg, system.cfg, etc
  ${LineFind} "$BootDir\multiboot\Installed.txt" "$BootDir\multiboot\Installed.txt" "1:-1" "DeleteInstall" ; Remove the Installed entry
  ${LineFind} "$BootDir\multiboot\Installed.txt" "$BootDir\multiboot\Installed.txt" "1:-1" "DeleteEmptyLine" ; Remove any left over empty lines
  ${LineFind} "$BootDir\multiboot\menu\$Config2Use" "$BootDir\multiboot\menu\$Config2Use" "1:-1" "DeleteEmptyLine" ; Remove any left over empty lines
  Delete "$BootDir\multiboot\$DistroName\*.*" 
  
  ReadEnvStr $R0 COMSPEC
  nsExec::Exec '"$R0" /C rmdir /Q /S "$BootDir\multiboot\$DistroName"' 
  
  RMDir /R "$BootDir\multiboot\$DistroName"   ; make another pass using NSIS built in RMDir
  
   ${AndIf} ${FileExists} "$BootDir\multiboot\ISOS\$DistroName.iso"   
   Delete "$BootDir\multiboot\ISOS\$DistroName.iso" 
 ${EndIf}
 DetailPrint "$DistroName and its menu entry were Removed!" 
!macroend