; ------------ Casper Script --------------

Function CasperScriptAlt1
${If} $Casper != "0"
${AndIf} $DistroName != "Windows to Go (Virtual Hard Disk)"
 Call GetCaspTools  
 Sleep 1000 
 DetailPrint "Sleeping for 1 second..."
 ExpandEnvStrings $COMSPEC "%COMSPEC%"
 ExecShell "" '"$COMSPEC"' '/C if 1==1 "$PLUGINSDIR\dd.exe" if=/dev/zero of=$BootDir\!\$JustISOName\$CasperName bs=1M count=$Casper --progress 2>$PLUGINSDIR\ddlog.txt' SW_HIDE
 Banner::show /set 76 "Creating a $CasperName File."
 Banner::getWindow
 Pop $1  
 DetailPrint "Creating a $CasperName file. Progress will not move until finished..."
 Call ddProgress
 Banner::destroy
 
 DetailPrint "Now Formatting a $CasperName File" 
 DetailPrint "Formatting the $CasperName File: The progress bar will not move until finished. Please be patient..." 
 
 Sleep 3000 ; Give the previous dd.exe program time to exit.
 DetailPrint "Sleeping for 3 seconds..."
 nsExec::ExecToLog '"$PLUGINSDIR\mke2fs.exe" -L $CasperName $BootDir\!\$JustISOName\$CasperName'
${EndIf}
FunctionEnd

Function CasperSize
 IntOp $SizeOfCasper $SizeOfCasper + $Casper
FunctionEnd

Function GetCaspTools
SetShellVarContext all
InitPluginsDir
File /oname=$PLUGINSDIR\dd.exe "இருமங்கள்\தரவுவரையறை.exe"
File /oname=$PLUGINSDIR\mke2fs.exe "இருமங்கள்\நீட்2கோமுவடிவஉரு.exe"
FunctionEnd