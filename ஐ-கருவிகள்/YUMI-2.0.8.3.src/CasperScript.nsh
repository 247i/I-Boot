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

Function CasperScriptAlt1
${If} $Casper != "0"
${AndIf} $DistroName != "Windows to Go (Virtual Hard Disk)"
 Call GetCaspTools  
 Sleep 1000 
 DetailPrint "Sleeping for 1 second..."
 ExpandEnvStrings $COMSPEC "%COMSPEC%"
 
 StrCpy $9 $JustDrive
 Call GetFSType
 ;MessageBox MB_ICONSTOP|MB_OK " $9 $FSType"
 
 ${If} $FSType == "NTFS" ; Already is NTFS
 ${OrIf} $FormatMe == "Yes" ; Chose to Format as NTFS
  ExecShell "" '"$COMSPEC"' '/C if 1==1 "$PLUGINSDIR\dd.exe" if=/dev/zero of=$PLUGINSDIR\$CasperName bs=1M count=$Casper --progress 2>$PLUGINSDIR\ddlog.txt' SW_HIDE
 ${Else} 
  ExecShell "" '"$COMSPEC"' '/C if 1==1 "$PLUGINSDIR\dd.exe" if=/dev/zero of=$BootDir\multiboot\$JustISOName\$CasperName bs=1M count=$Casper --progress 2>$PLUGINSDIR\ddlog.txt' SW_HIDE
 ${EndIf} 
 Banner::show /set 76 "Creating a $CasperName File."
 Banner::getWindow
 Pop $1  
 DetailPrint "Creating a $CasperName file. Progress will not move until finished..."
 Call ddProgress
 Banner::destroy
 
 DetailPrint "Now Formatting a $CasperName File" 
 DetailPrint "Formatting the $CasperName File: The progress bar will not move until finished. Please be patient..." 
 
 ${If} $FSType == "NTFS"
 ${OrIf} $FormatMe == "Yes"
  Sleep 1000
  nsExec::ExecToLog '"$PLUGINSDIR\mke2fs.exe" -L $CasperName $PLUGINSDIR\$CasperName' 
  CopyFiles $PLUGINSDIR\$CasperName "$BootDir\multiboot\$JustISOName\$CasperName" ; Copy casper-rw to USB
  Delete "$PLUGINSDIR\$CasperName"
 ${Else}
  Sleep 3000 ; Give the previous dd.exe program time to exit.
  DetailPrint "Sleeping for 3 seconds..." 
  nsExec::ExecToLog '"$PLUGINSDIR\mke2fs.exe" -L $CasperName $BootDir\multiboot\$JustISOName\$CasperName'
 ${EndIf} 
${EndIf}
FunctionEnd

Function CasperSize
 IntOp $SizeOfCasper $SizeOfCasper + $Casper
FunctionEnd

Function GetCaspTools
SetShellVarContext all
InitPluginsDir
File /oname=$PLUGINSDIR\dd.exe "dd.exe"
File /oname=$PLUGINSDIR\mke2fs.exe "mke2fs.exe"
FunctionEnd