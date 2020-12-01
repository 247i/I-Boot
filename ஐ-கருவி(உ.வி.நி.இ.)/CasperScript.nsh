; ------------ Casper Script --------------
/* Function CasperScript
${If} $Casper != "0"
 Call GetCaspTools
  ${If} $DistroName == "Debian Live"
  nsExec::ExecToLog '"$PLUGINSDIR\dd.exe" if=/dev/zero of=$BootDir\multiboot\$JustISOName\persistence bs=1M count=$Casper --progress'
  nsExec::ExecToLog '"$PLUGINSDIR\mke2fs.exe" -L live-rw $BootDir\multiboot\$JustISOName\persistence'	; was using -b 1024
  ${Else}
  nsExec::ExecToLog '"$PLUGINSDIR\dd.exe" if=/dev/zero of=$BootDir\multiboot\$JustISOName\writable bs=1M count=$Casper --progress'
  nsExec::ExecToLog '"$PLUGINSDIR\mke2fs.exe" -L casper-rw $BootDir\multiboot\$JustISOName\writable'	; was using -b 1024
  ${EndIf}
${EndIf}
FunctionEnd */


Function CasperScript
${If} $Casper != "0"
${AndIf} $DistroName != "Windows to Go (Virtual Hard Disk)"
 Call GetCaspTools
 
  ${If} $DistroName == "Debian Live"
  StrCpy $CasperName "persistence"
  ${ElseIf} $DistroName == "Raspberry Pi Desktop"
  StrCpy $CasperName "persistence"
  ${Else}
  StrCpy $CasperName "writable"
  ${EndIf} 
  
 SetShellVarContext all
 InitPluginsDir
 ExpandEnvStrings $COMSPEC "%COMSPEC%"
 ExecShell "" '"$COMSPEC"' '/C if 1==1 "$PLUGINSDIR\dd.exe" if=/dev/zero of=$PLUGINSDIR\$CasperName bs=1M count=$Casper --progress 2>$PLUGINSDIR\ddlog.txt' SW_HIDE
 Banner::show /set 76 "Creating a Persistent File."
 Banner::getWindow
 Pop $1  
 DetailPrint "Creating a persistent file. Progress will not move until finished..."
 Call ddProgress
 Banner::destroy
 
  ${If} $DistroName == "Raspberry Pi Desktop"
   nsExec::ExecToLog '"$PLUGINSDIR\mke2fs.exe" -L Persistence $PLUGINSDIR\$CasperName'
  ${Else}
   nsExec::ExecToLog '"$PLUGINSDIR\mke2fs.exe" -L $CasperName $PLUGINSDIR\$CasperName'
  ${EndIf} 
 CopyFiles $PLUGINSDIR\$CasperName "$BootDir\multiboot\$JustISOName\$CasperName" ; Copy casper-rw to USB
 Delete "$PLUGINSDIR\$CasperName"
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
DetailPrint "Now Creating a Persistence or Writable File" 
DetailPrint "Creating the Persistent File: The progress bar will not move until finished. Please be patient..." 
FunctionEnd