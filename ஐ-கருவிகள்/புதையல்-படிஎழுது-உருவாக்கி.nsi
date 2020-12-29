Unicode	True ; தமிழ் எழுத்து அதரவு 
!define பெயர் "புதையல்-படிஎழுது-உருவாக்கி"
!define DISTRO "persistent file"
!define PTYPE "$CasperName"
!define பதிப்பு "0.5"
!define MUI_ICON "..\அகர\ஐ-காண்\யானை.ico"
RequestExecutionLevel highest
Name "${பெயர்} ${பதிப்பு}"
OutFile "..\${பெயர்}-${பதிப்பு}.exe"

SetCompressor LZMA
CRCCheck On
XPStyle on
ShowInstDetails show
BrandingText "    ⮜⮘  https://TamilNeram.github.io/${பெயர்}   ⮞⮚"
CompletedText "$CasperName persistent file creation done, Process is Complete!"
InstallButtonText Create

!include "MUI2.nsh"
!include "Sections.nsh"
!include "FileFunc.nsh"

; Interface settings
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "..\அகர\அணிகலன்\யாதும் ஊரே-தலைப்பு.bmp" 
!define MUI_HEADERIMAGE_BITMAP_NOSTRETCH
!define MUI_HEADERIMAGE_RIGHT

; License page
!define MUI_TEXT_LICENSE_SUBTITLE $(License_Subtitle)
!define MUI_LICENSEPAGE_TEXT_TOP $(License_Top)
!define MUI_LICENSEPAGE_TEXT_BOTTOM $(License_Bottom)
!insertmacro MUI_PAGE_LICENSE "..\அகர\பகவன்\உரிமை.உரை"

; Variables
Var PageDescr
Var DriveSelect
Var DestDriveTxt
Var DestDrive
Var Casper
Var CasperSelection
Var CasperSlider
Var SlideSpot

Var casper_rw
Var writable
Var checkpt
Var RemainingSpace
Var MaxPersist
Var FSType

Var CasperNameSelect
Var CasperName
Var COMSPEC
Var PERCENT
Var VolName
Var Capacity 
Var JustDrive
Var Letters
Var BDir
Var DestDisk

; USB Drive and Casper Slider Selections Page
Page custom SelectionsPage

; Install Files Page
!define MUI_INSTFILESPAGE_COLORS "00FF00 000000" ;Green and Black
!define MUI_TEXT_INSTALLING_TITLE $(Install_Title)
!define MUI_TEXT_INSTALLING_SUBTITLE $(Install_SubTitle)
!define MUI_TEXT_FINISH_SUBTITLE $(Install_Finish_Sucess)
!insertmacro MUI_PAGE_INSTFILES

; தமிழ் மொழி உரைகள்
!insertmacro MUI_LANGUAGE "Tamil" ; தமிழே முதல் மொழி
LangString License_Subtitle ${LANG_TAMIL} "${பெயர்} தொடர்வதற்கு முன் உரிம விதிமுறைகளை மதிப்பாய்வு செய்யவும் ."
LangString License_Top ${LANG_TAMIL} "இந்த நிரலில் உள்ள மென்பொருள் பின்வரும் உரிமங்களின் கீழ் வருகிறது."
LangString License_Bottom ${LANG_TAMIL} "இந்த ${பெயர்} பயன்பாட்டை இயக்க இந்த உரிம ஒப்பந்தத்தின் விதிமுறைகளை நீங்கள் ஏற்க வேண்டும். நீங்கள் ஒப்புக்கொண்டால், ஒப்புதல் என்பதைக் சொடுக்கு."
LangString DrivePage_Title ${LANG_TAMIL} "மின்வெட்டொளி இயக்கதைத் தேர்ந்தெடுக்கவும்"
LangString DrivePage_Title2 ${LANG_TAMIL} "மின்வெட்டொளி இயக்கதைத் தேர்ந்தெடுக்கவும் in which to install a ${DISTRO}."
LangString DrivePage_Text ${LANG_TAMIL} "This simple tool can be used to create a ${DISTRO} on your select USB drive, enabling you to save and restore changes on Live Ubuntu based Distributions and Remixes."
LangString CasperName_Input ${LANG_TAMIL} "படி 2: Select Your Persistence File பெயர்"
LangString DrivePage_Input ${LANG_TAMIL} "படி 1: மின்வெட்டொளி இயக்கதைத் தேர்ந்தெடுக்கவும்"
LangString Casper_Text ${LANG_TAMIL} "படி 3: Drag the Slider to Set a File Size to use for storing changes."
LangString Install_Title ${LANG_TAMIL} "Installing a ${PTYPE} ${DISTRO}"
LangString Install_SubTitle ${LANG_TAMIL} "Please wait while ${பெயர்} creates and installs a ${PTYPE} ${DISTRO} on $DestDrive"
LangString Install_Finish_Sucess ${LANG_TAMIL} "${பெயர்} sucessfully created and installed a ${PTYPE} ${DISTRO} on $DestDrive"

Function SelectionsPage
  !insertmacro MUI_HEADER_TEXT $(DrivePage_Title) $(DrivePage_Title2)
  nsDialogs::Create 1018
  
  ${If} $DestDrive == ""
   GetDlgItem $6 $HWNDPARENT 1 ; Get "Next" control handle
   EnableWindow $6 0 ; disable "Next" control
  ${EndIf}
  
  ${NSD_CreateLabel} 0 0 100% 40 $(DrivePage_Text)
  Pop $PageDescr
  
  ${NSD_CreateLabel} 0 45 40% 15 $(DrivePage_Input)
  Pop $DriveSelect  

; Droplist for Drive Selection
  ${NSD_CreateDroplist} 0 65 35% 20 ""
  Pop $DestDriveTxt
  ${NSD_OnChange} $DestDriveTxt OnSelectDrive
  ${GetDrives} "FDD+HDD" DrivesList
  ${If} $DestDrive != ""
  ${NSD_CB_SelectString} $DestDriveTxt $DestDrive
  ${EndIf}
  
  ${NSD_CreateLabel} 0 95 100% 15 $(CasperName_Input)
  Pop $CasperNameSelect   
  
    ${NSD_CreateRadioButton} 0 115 20% 20 "casper-rw"
    Pop $casper_rw
	${NSD_Check} $casper_rw
	${NSD_OnClick} $casper_rw CaspChecker
  ${NSD_CreateRadioButton} 25% 115 20% 20 "writable"
    Pop $writable
	${NSD_OnClick} $writable CaspChecker   
  
; Casper-RW Selection Starts
  ${NSD_CreateLabel} 0 145 100% 15 $(Casper_Text)
  Pop $CasperSelection  
  
; CasperSlider - TrackBar
;  !define TBM_SETPOS 0x0405
;  !define TBM_GETPOS 0x0400
; !define TBM_SETRANGEMIN 0x0407
; !define TBM_SETRANGEMAX 0x0408

  nsDialogs::CreateControl "msctls_trackbar32" "0x50010000|0x00000018" "" 0 165 50% 25 ""
  Pop $CasperSlider
  
  ${NSD_CreateLabel} 52% 170 30% 25 ""
  Pop $SlideSpot    

  SendMessage $CasperSlider ${TBM_SETRANGEMIN} 1 256 ; Min Range Value 256
  SendMessage $CasperSlider ${TBM_SETRANGEMAX} 1 $RemainingSpace ; Max Range Value 4090
  ${NSD_OnNotify} $CasperSlider onNotify_CasperSlider      
  
  nsDialogs::Show
FunctionEnd

Function CaspChecker
    Pop $checkpt
 	${If} $checkpt == $casper_rw
	${NSD_Check} $casper_rw
	StrCpy $CasperName "casper-rw" ; casper-rw persistence label	 
	${ElseIf} $checkpt == $writable
	${NSD_Check} $writable
	StrCpy $CasperName "writable" ; writable persistence label	 
	${EndIf}
	;MessageBox MB_OK "$CasperName"
FunctionEnd	

Function GetDiskVolumeName
System::Alloc 1024 ; Allocate string body
Pop $0 ; Get the allocated string's address

!define GetVolumeInformation "Kernel32::GetVolumeInformation(t,t,i,*i,*i,*i,t,i) i"
System::Call '${GetVolumeInformation}("$JustDrive",.r0,1024,,,,,1024)' ;

${If} $0 != ""
 StrCpy $VolName "$0"
${Else}
 StrCpy $VolName ""
${EndIf}
FunctionEnd 

Function DiskSpace
${DriveSpace} "$9" "/D=T /S=G" $1 ; used to find total space of each drive
${If} $1 > "0"
 StrCpy $Capacity "$1GB"
${Else}
 StrCpy $Capacity ""
${EndIf}
FunctionEnd

Function DrivesList
  StrCpy $JustDrive $9
  Call GetDiskVolumeName
  Call DiskSpace
  Call GetFSType
  SendMessage $DestDriveTxt ${CB_ADDSTRING} 0 "STR:$9 $VolName $Capacity $FSType"
  Push 1
FunctionEnd

Function GetFSType
System::Call 'Kernel32::GetVolumeInformation(t "$9",t,i ${NSIS_MAX_STRLEN},*i,*i,*i,t .r1" ,i ${NSIS_MAX_STRLEN}) i.r0'
 StrCpy $FSType "$1"
FunctionEnd

; On Selection of USB Drive
Function OnSelectDrive
  Pop $DestDriveTxt
  ${NSD_GetText} $DestDriveTxt $Letters
  StrCpy $DestDrive "$Letters"
  StrCpy $JustDrive $DestDrive 3  
  StrCpy $BDir $DestDrive 2 ;was -1 
  StrCpy $DestDisk $DestDrive 2 ;was -1 
  ; MessageBox MB_ICONSTOP|MB_OK "$JustDrive - $DestDrive"  
  GetDlgItem $6 $HWNDPARENT 1 ; Get "Next" control handle
  EnableWindow $6 1 ; enable "Next" control
  Call SetSpace
FunctionEnd

Function HaveSpace ; Check space required before installing
  ;StrCpy $0 '$0' ; check how much free space is left
  Call FreeDiskSpace
  StrCpy $2 $Casper ; Free space required by you (in MB)
  System::Int64Op $1 > $2 ; Compare the space required and the space available
  Pop $3 ; Get the result ...
  IntCmp $3 1 okay ; ... and compare it
  MessageBox MB_ICONSTOP|MB_OK "Oops: There is not enough Free disk space! $1 MB of $2 MB Needed on $JustDrive Drive."
  quit ; Close the program if the disk space was too small...
  okay: ; Proceed to execute...
FunctionEnd

Function SetSpace ; Set space available for persistence
 ${If} $FSType != "NTFS"
 ${AndIf} $FSType != "exFAT"
  Call FreeDiskSpace
  StrCpy $MaxPersist 4090 ; Space required for a 4GB max persistent file
   ${If} $1 > $MaxPersist ; Check if more space is available than we need for 4GB persistent file
   StrCpy $RemainingSpace 4090 ; Set maximum possible value to 4090 MB (any larger wont work on fat32 Filesystem)
   ${Else}
   StrCpy $RemainingSpace "$1"
   ${EndIf}
 ${Else}  
  Call FreeDiskSpace
  StrCpy $MaxPersist 20450 ; Space required for 20GB max persistent file
   ${If} $1 > $MaxPersist ; Check if more space is available than we need for a 20GB persistent file
   StrCpy $RemainingSpace 20450 ; Set maximum possible value to 20450 MB
   ${Else}
   StrCpy $RemainingSpace "$1"
   ${EndIf}

 ${EndIf} 
   IntOp $RemainingSpace $RemainingSpace - 1 ; Subtract 1MB so that we don't error for not having enough space
   SendMessage $CasperSlider ${TBM_SETRANGEMAX} 1 $RemainingSpace ; Re-Setting Max Value 
FunctionEnd

Function FreeDiskSpace
${DriveSpace} "$JustDrive" "/D=F /S=M" $1
FunctionEnd

!include துணை\தவமுன்னேற்றம்.நிரல் ; 
Function CasperScript
${If} $Casper != "0"
 Sleep 1000
 DetailPrint "Sleeping for 1 second..."
 ExpandEnvStrings $COMSPEC "%COMSPEC%"
 ExecShell "" '"$COMSPEC"' '/C if 1==1 "$PLUGINSDIR\தரவுவரையறை.exe" if=/dev/zero of=$BDir\$CasperName bs=1M count=$Casper --progress 2>$PLUGINSDIR\ddlog.txt' SW_HIDE
 Banner::show /set 76 "Creating a $CasperName file."
 Banner::getWindow
 Pop $1  
 DetailPrint "Creating a $CasperName file. Progress will not move until finished..."
 Call தவமுன்னேற்றம்
 Banner::destroy
 
 DetailPrint "Now Formatting $CasperName" 
 DetailPrint "Formatting the $CasperName file: The progress bar will not move until finished. Please be patient..." 
 
 Sleep 3000 ; Give the dd.exe time to exit.
 DetailPrint "Sleeping for 3 seconds..."
 nsExec::ExecToLog '"$PLUGINSDIR\நீட்2கோமுவடிவஉரு.exe" -L $CasperName $BDir\$CasperName'
${EndIf}
  CopyFiles "$PLUGINSDIR\உரிமை.உரை" "$BDir\உரிமை.உரை" ; நகர்த்து 
FunctionEnd


Function onNotify_CasperSlider
Pop $Casper
SendMessage $CasperSlider ${TBM_GETPOS} 0 0 $Casper ; Get Trackbar position
${NSD_SetText} $SlideSpot "$Casper MB"
FunctionEnd

; ---- Let's Do This Stuff ----
Section  
Call HaveSpace ; Got enough Space? Lets Check!
Call CasperScript
SectionEnd

Function .onInit
StrCpy $CasperName "casper-rw" ; default to newer persistence label
SetShellVarContext all
InitPluginsDir
  File /oname=$PLUGINSDIR\தரவுவரையறை.exe "இருமங்கள்\தரவுவரையறை.exe"
  File /oname=$PLUGINSDIR\நீட்2கோமுவடிவஉரு.exe "இருமங்கள்\நீட்2கோமுவடிவஉரு.exe"
  File /oname=$PLUGINSDIR\உரிமை.உரை "..\அகர\பகவன்\உரிமை.உரை"
FunctionEnd 