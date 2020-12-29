; -------- Configuration and Text File Manipulation Stuff! --------

!include "TextFunc.nsh" ; TextFunc.nsh required for the following DeleteInstall function
Function DeleteInstall  ; Deletes Select Entry from Installed.txt          
	StrLen $0 "$DistroName"
	StrCpy $1 "$R9" $0
	StrCmp $1 "$DistroName" 0 End
	StrCpy $R9 ""
	End:
	Push $0
FunctionEnd

Function DeleteEmptyLine ; Deletes empty lines    
	StrLen $0 "$\r$\n"
	StrCpy $1 "$R9" $0
	StrCmp $1 "$\r$\n" 0 End
	StrCpy $R9 ""
	End:
	Push $0
FunctionEnd

Function நிறுவப்பட்டபட்டியல் ; Creates a list of installed distros in the multiboot folder on the USB drive (So we can uninstall the distros later)
 ${IfNot} ${FileExists} "$BDir\multiboot\$JustISOName\*.*" ; If the installation directory exists user must be reinstalling the same distro, so we won't add a removal entry. 
   Exch $R0 ;file to write to
   Exch
   Exch $1 ;text to write
   ${If} ${FileExists} "$BDir\multiboot\Installed.txt" 
    FileOpen $R0 '$BDir\multiboot\Installed.txt' a 
    FileSeek $R0 0 END
	FileWrite $R0 '$\r$\n$1' ; add subsequent entry on a new line
   ${Else}
    FileOpen $R0 '$BDir\multiboot\Installed.txt' a 
    FileSeek $R0 0 END
    FileWrite $R0 '$1'  ; add first entry without a new line
   ${EndIf}
    FileClose $R0
    Pop $1
    Pop $R0
 ${EndIf}
FunctionEnd

!macro நிறுவப்பட்டபட்டியல் String File
  Push "${String}"
  Push "${File}"
  Call நிறுவப்பட்டபட்டியல்
!macroend  
!define நிறுவப்பட்டபட்டியல் "!insertmacro நிறுவப்பட்டபட்டியல்"

Function ஒழுங்கமை ; ஐ உடன் பயன்படுத்த திருத்தப்பட்ட முன்னணி மற்றும் பின்னால் உள்ள இடைவெளியை அகற்று
	Exch $R1 ; Original string
	Push $R2
Loop:
	StrCpy $R2 "$R1" 1
	StrCmp "$R2" " " TrimLeft
	StrCmp "$R2" "$\r" TrimLeft
	StrCmp "$R2" "$\n" TrimLeft
	StrCmp "$R2" "$\t" TrimLeft
	GoTo Loop2
TrimLeft:	
	StrCpy $R1 "$R1" "" 1
	Goto Loop
Loop2:
	StrCpy $R2 "$R1" 1 -1
	StrCmp "$R2" " " TrimRight
	StrCmp "$R2" "$\r" TrimRight
	StrCmp "$R2" "$\n" TrimRight
	StrCmp "$R2" "$\t" TrimRight
	GoTo Done
TrimRight:	
	StrCpy $R1 "$R1" -1
	Goto Loop2
Done:
	Pop $R2
	Exch $R1
FunctionEnd
!macro ஒழுங்கமை TrimmedString OriginalString
  Push "${OriginalString}"
  Call ஒழுங்கமை
  Pop "${TrimmedString}"
!macroend
!define ஒழுங்கமை "!insertmacro ஒழுங்கமை" 

Function அகற்றும்பட்டியல் ; Lists the distros installed on the select drive.
 ${NSD_SetText} $LinuxDistroSelection "Step 2: Select a Distro from the list to remove"  
 ${If} ${FileExists} "$BDir\multiboot\Installed.txt" ; Are there distributions on the select drive? 
 ClearErrors
 FileOpen $0 $BDir\multiboot\Installed.txt r
  loop:
   FileRead $0 $1
    IfErrors done
    StrCpy $DistroName $1
	${ஒழுங்கமை} "$DistroName" "$DistroName" ; Remove spaces, newlines, and carriage return
    ${NSD_CB_AddString} $Distro "$DistroName" ; Add DistroName to the listbox of removable distros ; was ${NSD_LB_AddString} $Distro "$DistroName" ; Enable for DropBox
   Goto loop
  done:  
 FileClose $0
 ${Else}
     ;Call SetISOFileName
 ${EndIf}
FunctionEnd

!include "TextFunc.nsh" ; TextFunc.nsh required for the following DeleteInstall function

!define StrRep "!insertmacro StrRep"
 
!macro StrRep ResultVar String SubString RepString
  Push "${String}"
  Push "${SubString}"
  Push "${RepString}"
  Call StrRep
  Pop "${ResultVar}"
!macroend
 
Function StrRep ;http://nsis.sourceforge.net/mediawiki/index.php?title=StrRep&direction=next&oldid=4565
/*After this point:
  ------------------------------------------
  $R0 = RepString (input)
  $R1 = SubString (input)
  $R2 = String (input)
  $R3 = RepStrLen (temp)
  $R4 = SubStrLen (temp)
  $R5 = StrLen (temp)
  $R6 = StartCharPos (temp)
  $R7 = TempStrL (temp)
  $R8 = TempStrR (temp)*/
 
  ;Get input from user
  Exch $R0
  Exch
  Exch $R1
  Exch
  Exch 2
  Exch $R2
  Push $R3
  Push $R4
  Push $R5
  Push $R6
  Push $R7
  Push $R8
 
  ;Return "String" if "SubString" is ""
  ${IfThen} $R1 == "" ${|} Goto Done ${|}
 
  ;Get "RepString", "String" and "SubString" length
  StrLen $R3 $R0
  StrLen $R4 $R1
  StrLen $R5 $R2
  ;Start "StartCharPos" counter
  StrCpy $R6 0
 
  ;Loop until "SubString" is found or "String" reaches its end
  ${Do}
    ;Remove everything before and after the searched part ("TempStrL")
    StrCpy $R7 $R2 $R4 $R6
 
    ;Compare "TempStrL" with "SubString"
    ${If} $R7 == $R1
      ;Split "String" to replace the string wanted
      StrCpy $R7 $R2 $R6 ;TempStrL
 
      ;Calc: "StartCharPos" + "SubStrLen" = EndCharPos
      IntOp $R8 $R6 + $R4
 
      StrCpy $R8 $R2 "" $R8 ;TempStrR
 
      ;Insert the new string between the two separated parts of "String"
      StrCpy $R2 $R7$R0$R8
      ;Now calculate the new "StrLen" and "StartCharPos"
      StrLen $R5 $R2
      IntOp $R6 $R6 + $R3
      ${Continue}
    ${EndIf}
 
    ;If not "SubString", this could be "String" end
    ${IfThen} $R6 >= $R5 ${|} ${ExitDo} ${|}
    ;If not, continue the loop
    IntOp $R6 $R6 + 1
  ${Loop}
 
  Done:
 
  ;Return output to user
  StrCpy $R0 $R2
 
/*After this point:
  ------------------------------------------
  $R0 = ResultVar (output)*/
 
  Pop $R8
  Pop $R7
  Pop $R6
  Pop $R5
  Pop $R4
  Pop $R3
  Pop $R2
  Pop $R1
  Exch $R0
FunctionEnd
; Persistent File Creation Progress
Function தவமுன்னேற்றம்
 ${Do}
 Sleep 1
 ReadEnvStr $COMSPEC COMSPEC
 nsExec::Exec '"$COMSPEC" /C "copy" $PLUGINSDIR\ddlog.txt $PLUGINSDIR\ddlog2.txt'
 Push "$PLUGINSDIR\ddlog2.txt"
 Call வரிஎண்ணிக்கை
 Pop $R0
 
 Push $R0 ;line number to read from
 Push "$PLUGINSDIR\ddlog2.txt" ;text file to read
 Call கோப்புவரியைப்படி
 Pop $0 ;output string (read from file.txt)
 StrCpy $PERCENT "$0"
 GetDlgItem $2 $1 1030
 SendMessage $2 ${WM_SETTEXT} 0 "STR:$PERCENT"  
 ${LoopUntil} $R0 >= "$Casper"
FunctionEnd

Function வரிஎண்ணிக்கை
Exch $R0
Push $R1
Push $R2
 FileOpen $R0 $R0 r
loop:
 ClearErrors
 FileRead $R0 $R1
 IfErrors +3
 IntOp $R2 $R2 + 1
Goto loop
 FileClose $R0
 StrCpy $R0 $R2
Pop $R2
Pop $R1
Exch $R0
FunctionEnd

Function கோப்புவரியைப்படி 
Exch $0 ;கோப்பு
Exch
Exch $1 ;வரிஎண்
Push $2
Push $3
 
 FileOpen $2 $0 r
 StrCpy $3 0
 
Loop:
 IntOp $3 $3 + 1
  ClearErrors
  FileRead $2 $0
  IfErrors +2
  StrCmp $3 $1 0 loop
  FileClose $2
 
Pop $3
Pop $2
Pop $1
Exch $0
FunctionEnd