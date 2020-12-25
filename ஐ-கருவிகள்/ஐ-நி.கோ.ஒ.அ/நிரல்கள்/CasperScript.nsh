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

; ------------ Casper Script --------------

Function CasperScript
${If} $Casper != "0"
${AndIf} $DistroName != "Windows to Go (Virtual Hard Disk)"
 Call GetCaspTools
 
    ${If} $DistroName == "Ubuntu"
		 ${StrContains} $0 "buntu-19" "$JustISO"   
		 ${StrContains} $1 "buntu-18" "$JustISO"
		 ${StrContains} $2 "buntu-17" "$JustISO" 
		 ${StrContains} $3 "buntu-16" "$JustISO" 		
		 
		 ${If} $0 != "buntu-19" 
		 ${AndIf} $1 != "buntu-18"  
		 ${AndIf} $2 != "buntu-17"  
		 ${AndIf} $3 != "buntu-16" 	 
		  StrCpy $CasperName "writable"
         ${Else}
		  StrCpy $CasperName "casper-rw" 
		 ${EndIf}
		 
    ${ElseIf} $DistroName == "Linux Mint"
		 ${StrContains} $0 "mint-19" "$JustISO"   
		 ${StrContains} $1 "mint-18" "$JustISO"
		 ${StrContains} $2 "mint-17" "$JustISO" 
		 ${StrContains} $3 "mint-16" "$JustISO" 		
		 
		 ${If} $0 != "mint-19" 
		 ${AndIf} $1 != "mint-18"  
		 ${AndIf} $2 != "mint-17"  
		 ${AndIf} $3 != "mint-16" 	 
		  StrCpy $CasperName "writable" 
         ${Else}
		  StrCpy $CasperName "casper-rw" 
		 ${EndIf}
		 
    ${ElseIf} $DistroName == "Debian Live"
    ${OrIf} $DistroName == "Raspberry Pi Desktop"
          StrCpy $CasperName "persistence"		 
	${Else}
	StrCpy $CasperName "writable" ; default to newer persistence label
   ${EndIf}  
    ;MessageBox MB_OK "$CasperName"  
 Sleep 1000
 DetailPrint "Sleeping for 1 second..."
 ExpandEnvStrings $COMSPEC "%COMSPEC%"
 ExecShell "" '"$COMSPEC"' '/C if 1==1 "$PLUGINSDIR\dd.exe" if=/dev/zero of="$BootDir\multiboot\$DistroPath\$JustISOName\$CasperName" bs=1M count=$Casper --progress 2>$PLUGINSDIR\ddlog.txt' SW_HIDE
 Banner::show /set 76 "Creating a $CasperName file."
 Banner::getWindow
 Pop $1  
 DetailPrint "Creating a $CasperName file. Progress will not move until finished..."
 Call ddProgress
 Banner::destroy
 
 DetailPrint "Now Formatting $CasperName" 
 DetailPrint "Formatting the $CasperName file: The progress bar will not move until finished. Please be patient..." 
 
 Sleep 3000 ; Give the dd.exe time to exit.
 DetailPrint "Sleeping for 3 seconds..."
 nsExec::ExecToLog '"$PLUGINSDIR\mke2fs.exe" -L $CasperName "$BootDir\multiboot\$DistroPath\$JustISOName\$CasperName"'
${EndIf}
FunctionEnd

Function CasperSize
 IntOp $SizeOfCasper $SizeOfCasper + $Casper
FunctionEnd

Function GetCaspTools
SetShellVarContext all
InitPluginsDir
File /oname=$PLUGINSDIR\dd.exe "tools\dd.exe"
File /oname=$PLUGINSDIR\mke2fs.exe "tools\mke2fs.exe"
FunctionEnd