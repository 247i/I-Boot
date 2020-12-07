Unicode True ; தமிழ் எழுத்து அதரவு 
!define NAME "ஐ-கருவி(உ.வி.நி.இ.)"
!define FILENAME "ஐ-கருவி(உ.வி.நி.இ.)"
!define VERSION "0.0.3.2"
!define MUI_ICON "இருமங்கள்\வண்ணத்துப்பூச்சி.ico"

VIProductVersion "${VERSION}"
VIAddVersionKey CompanyName "ஐ"
VIAddVersionKey LegalCopyright "உரிமை ©2021 ஐ"
VIAddVersionKey FileVersion "${VERSION}"
VIAddVersionKey FileDescription "ஐ-கருவி"
VIAddVersionKey License "இலவசம்"

Name "${NAME} ${VERSION}"
OutFile "${FILENAME}.exe"
RequestExecutionLevel admin ;highest
SetCompressor LZMA
CRCCheck On
XPStyle on
ShowInstDetails show
BrandingText "${NAME} ${VERSION}"
CompletedText "அனைத்தும் முடிந்தது!"
InstallButtonText "உருவாக்கு"

!include WordFunc.nsh
!include nsDialogs.nsh
!include MUI2.nsh
!include FileFunc.nsh
!include LogicLib.nsh
!AddPluginDir "plugins"

; Variables
Var Capacity
Var VolName
Var Checker
;Var EFI
;Var EFICHECK
Var FileFormat
Var Format 
Var FormatMe
Var BlockSize
Var Dialog
Var LabelDrivePage
Var Distro
Var DistroName
Var ISOFileName
Var DestDriveTxt
Var JustDrive
Var DestDrive
Var BootDir
Var LinuxDistroSelection
Var LabelISOSelection
Var ISOFileTxt
Var TheISO
;Var isopath
Var IsoFile
Var ISOSelection
Var ISOTest
Var JustISO
Var JustISOName
Var JustISOPath
Var ConfigFile
Var ConfigPath
Var CopyPath
Var GrubConfigFile
Var GrubConfigPath
Var GrubCopyPath
Var Initrd
Var Vmlinuz
Var ISONameDotLess
; Var SearchDir
; Var SearchFile
Var DestDisk
Var DownloadISO
Var DownloadMe
Var Link
Var Link1
Var Link2
Var Links
Var Links1
Var Links2
Var Auth
Var DownLink
Var LocalSelection
Var Letters
Var Config2Use
Var SomeFileExt
;Var AllDriveOption
;Var DisplayAll
Var DistroLink
Var Homepage
Var OfficialSite
Var OfficialName
Var NameThatISO
Var OnlyVal
Var Uninstaller
Var Removal
Var InUnName
Var InUnStall
Var InUnStalling
Var InUnStalled
Var OnFrom
Var SUSEDIR
Var RepeatInstall
Var ShowAll
Var ForceShowAll
Var ShowingAll
Var SizeOfCasper 
Var Casper
Var CasperSlider
Var CasperSelection
Var SlideSpot
Var RemainingSpace
Var MaxPersist
Var Persistence
Var CasperName
Var COMSPEC
Var PERCENT
Var FSType
Var DiskNum

!include ReplaceInFile.nsh
!include DiskVoodoo.nsh

; Interface settings
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "இருமங்கள்\தலைப்பு.bmp" 
!define MUI_HEADERIMAGE_BITMAP_NOSTRETCH
!define MUI_HEADERIMAGE_RIGHT
; License Agreement Page
!define MUI_TEXT_LICENSE_SUBTITLE $(License_Subtitle)
!define MUI_LICENSEPAGE_TEXT_TOP $(License_Text_Top)
!define MUI_LICENSEPAGE_TEXT_BOTTOM $(License_Text_Bottom)
!define MUI_PAGE_CUSTOMFUNCTION_PRE License_PreFunction
!insertmacro MUI_PAGE_LICENSE "உரை\உரிமை.உரை"
; Distro Selection Page
Page custom SelectionsPage
; Install Files Page
!define MUI_INSTFILESPAGE_COLORS "00FF00 000000" ;Green and Black
!define MUI_INSTFILESPAGE_FINISHHEADER_TEXT $(Finish_Install)
!define MUI_TEXT_INSTALLING_TITLE $(Install_Title)
!define MUI_TEXT_INSTALLING_SUBTITLE $(Install_SubTitle)
!define MUI_TEXT_FINISH_SUBTITLE $(Install_Finish_Sucess)
!define MUI_PAGE_CUSTOMFUNCTION_PRE InstFiles_PreFunction
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_TITLE $(Finish_Title)
!define MUI_FINISHPAGE_TEXT $(Finish_Text)
!define MUI_FINISHPAGE_LINK $(Finish_Link)
!define MUI_FINISHPAGE_LINK_LOCATION "https://TamilNeram.github.io"
!define MUI_WELCOMEFINISHPAGE_BITMAP "இருமங்கள்\சரி.bmp"
!define MUI_PAGE_CUSTOMFUNCTION_PRE Finish_PreFunction
!insertmacro MUI_PAGE_FINISH

; தமிழ் மொழி உரைகள்
!insertmacro MUI_LANGUAGE "Tamil" ; தமிழே முதல் மொழி
LangString License_Subtitle ${LANG_TAMIL} "தொடர்வதற்கு முன் உரிம விதிமுறைகளை மதிப்பாய்வு செய்யவும்"
LangString License_Text_Top ${LANG_TAMIL} "இந்த நிரலில் உள்ள மென்பொருள் பின்வரும் உரிமங்களின் கீழ் வருகிறது."
LangString License_Text_Bottom ${LANG_TAMIL} "இந்த ${NAME} பயன்பாட்டை இயக்க இந்த உரிம ஒப்பந்தத்தின் விதிமுறைகளை நீங்கள் ஏற்க வேண்டும். நீங்கள் ஒப்புக்கொண்டால், தொடர நான் ஒப்புக்கொள்கிறேன் என்பதைக் சொடுக்கு."
LangString SelectDist_Title ${LANG_TAMIL} "இயக்கி தேர்வு மற்றும் விநியோக விருப்பங்கள் பக்கம்"
LangString SelectDist_Subtitle ${LANG_TAMIL} "மின்வெட்டொளி இயக்கி தேர்வுசெய்க, மற்றும் ஒரு விநியோகம், ஐஎஸ்ஓ/ஜிப் கோப்பு.$\r$\nஇந்த கருவி இயங்கும் ஒவ்வொரு முறையும் கூடுதல் விநியோகங்களைச் சேர்க்கலாம்."
LangString DrivePage_Text ${LANG_TAMIL} "படி 1:மின்வெட்டொளி இயக்கதைத் தேர்ந்தெடுக்கவும்"
LangString Distro_Text ${LANG_TAMIL} "படி 2: மின்வெட்டொளியில் வைக்க பட்டியலிலிருந்து ஒரு விநியோகத்தைத் தேர்ந்தெடுக்கவும்."
LangString IsoPage_Text ${LANG_TAMIL} "படி 3: $FileFormat தேர்ந்தெடுக்கவும் (பெயர் மேலே உள்ளதைப் போலவே இருக்க வேண்டும்)."
LangString IsoPage_Title ${LANG_TAMIL} "$FileFormat தேர்ந்தெடுக்கவும்"
LangString Casper_Text ${LANG_TAMIL} "படி 4: மாற்றங்களைச் சேமிக்க ஒரு நிலையான கோப்பு அளவை அமைக்கவும்."
LangString IsoFile ${LANG_TAMIL} "$FileFormat கோப்பு|$ISOFileName" 
LangString Extract ${LANG_TAMIL} "$FileFormat பிரித்தெடுத்தல்: முடியும் வரை முன்னேற்றம் பட்டி நகராது. தயவுசெய்து பொருமையாயிறு..."
LangString CreateSysConfig ${LANG_TAMIL} "$DestDisk இயக்ககத்திற்கான உள்ளமைவு கோப்புகளை உருவாக்குதல்"
LangString ExecuteSyslinux ${LANG_TAMIL} "கணிலினக்சை $BootDir மீது இயக்குகிறது"
LangString SkipSyslinux ${LANG_TAMIL} "நல்ல கணிலினக்சு உள்ளது..."
LangString WarningSyslinux ${LANG_TAMIL} "கணிலினக்சை இயக்கும் போது பிழை($R8) ஏற்பட்டது.$\r$\nமின்வெட்டொளி இயக்கி துவக்கப்படாது...$\r$\n$\r$\n$FSType கோப்பு முறைமை கண்டறியப்பட்டது. உங்கள் இயக்கி Fat32 அல்லது NTFS ஆக வடிவமைக்கப்பட வேண்டும்."
LangString WarningSyslinuxOLD ${LANG_TAMIL} "This ஐ-கருவி revision uses a newer கணிலினக்சு version that is not compatible with earlier revisions.$\r$\nPlease ensure your USB drive doesn't contain earlier revision installs."
LangString Install_Title ${LANG_TAMIL} "$InUnName $InUnStalling"
LangString Install_SubTitle ${LANG_TAMIL} "நாங்கள்   $JustDrive $OnFrom $InUnName $InUnStall போது காத்திருக்கவும்"
LangString Install_Finish_Sucess ${LANG_TAMIL} "${NAME} $InUnStalled $InUnName $OnFrom $JustDrive"
LangString Finish_Install ${LANG_TAMIL} "செயல்முறை முடிந்தது."
LangString Finish_Title ${LANG_TAMIL} "${NAME} பயன்படுத்தியதற்கு நன்றி"
LangString Finish_Text ${LANG_TAMIL} "உங்கள் தேர்வுகள் மின்வெட்டொளியில் $InUnStalled .$\r$\n$\r$\nமேலும் விநியோகங்களை $InUnStall இந்த கருவியை மீண்டும் இயக்கவும்.$\r$\n$\r$\nஐ-கருவி நீங்கள் ஏற்கனவே $InUnStalled தேர்வுகளை கண்காணிக்கும்."
LangString Finish_Link ${LANG_TAMIL} "TamilNeram.github.io பக்கம் பார்க்க"

!include FileManipulation.nsh ; Text File Manipulation
!include FileNames.nsh ; Macro for FileNames
!include DistroList.nsh ; List of Distributions
!include "CasperScript.nsh" ; For creation of Persistent Casper-rw files

Function License_PreFunction
  StrCpy $R8 1 ;This is the 1st page
FunctionEnd

Function SelectionsPage
  StrCpy $R8 2
 !insertmacro MUI_HEADER_TEXT $(SelectDist_Title) $(SelectDist_Subtitle) 
  nsDialogs::Create 1018
  Pop $Dialog 

 ${If} $RepeatInstall == "YES"   
 ${NSD_SetText} $DestDriveTxt "$DestDrive"

; To Install or Uninstall? That is the question!  
  ${NSD_CreateCheckBox} 60% 0 44% 15 "நிறுவப்பட்டது?"
  Pop $Uninstaller
  ${NSD_OnClick} $Uninstaller Uninstall  
 ; Distro Selection Starts
  ${NSD_CreateLabel} 0 50 50% 15 $(Distro_Text) 
  Pop $LinuxDistroSelection   

  ${NSD_CreateDroplist} 0 70 55% 95 "" ; was  ${NSD_CreateListBox} ; Enable For DropBox
  Pop $Distro
  ${NSD_OnChange} $Distro OnSelectDistro
  ${NSD_CB_SelectString} $Distro $DistroName ; Was ${NSD_LB_SelectString} $Distro $DistroName  ; Enable For DropBox 
  
; அனைத்து ஐஎஸ்ஓ விருப்பத்தையும் கட்டாயப்படுத்து
  ${NSD_CreateCheckBox} 80% 100 20% 15 "ஐஎஸ்ஓகள்?"
  Pop $ForceShowAll
  ${NSD_OnClick} $ForceShowAll ShowAllISOs   

; ஐஎஸ்ஓ Download Option
  ${NSD_CreateCheckBox} 60% 60 40% 15 "ஐஎஸ்ஓ பதிவிறக்கம்."
  Pop $DownloadISO
  ${NSD_OnClick} $DownloadISO DownloadIt  
  
; Clickable Link to Distribution Homepage  
  ${NSD_CreateLink} 60% 80 40% 15 "$OfficialName பக்கத்தைப் பார்!"
  Pop $DistroLink
  ${NSD_OnClick} $DistroLink onClickLinuxSite    

; ஐஎஸ்ஓ Selection Starts  
  ${NSD_CreateLabel} 0 100 100% 15 $(IsoPage_Text)
  Pop $LabelISOSelection
  ${NSD_CreateText} 0 120 78% 20 "உலாவி $FileFormat தேர்ந்தெடுக்கவும்"
  Pop $ISOFileTxt 
  ${NSD_CreateBrowseButton} 85% 120 60 20 "உலாவு"
  Pop $ISOSelection 
  ${NSD_OnClick} $ISOSelection ISOBrowse   
  
; Casper-RW Selection Starts
  ${NSD_CreateLabel} 0 150 75% 15 $(Casper_Text)
  Pop $CasperSelection  
 
  ${NSD_CreateLabel} 52% 178 25% 25 ""
  Pop $SlideSpot  

  nsDialogs::CreateControl "msctls_trackbar32" "0x50010000|0x00000018" "" 0 174 50% 25 ""
  Pop $CasperSlider
  SendMessage $CasperSlider ${TBM_SETRANGEMIN} 1 0 ; Min Range Value 0
  SendMessage $CasperSlider ${TBM_SETRANGEMAX} 1 $RemainingSpace ; Max Range Value $RemainingSpace
  ${NSD_OnNotify} $CasperSlider onNotify_CasperSlider    

; Drive Pre-Selection  
  ${NSD_CreateLabel} 0 0 58% 15 "" ;
  Pop $LabelDrivePage 
  ${NSD_SetText} $LabelDrivePage "படி 1: மின்வெட்டொளி இயக்கமாக $DestDisk வரவழைக்கப்பட்டது"  
; Droplist for Drive Selection  
  ${NSD_CreateDropList} 0 20 55% 15 "" ; was 0 20 15% 15 ; then was 28%
  Pop $DestDriveTxt 
   
  ${GetDrives} "FDD+HDD" DrivesList ; All Drives Listed
  
  ${NSD_CB_SelectString} $DestDriveTxt "$DestDrive"
  StrCpy $JustDrive $DestDrive 3
  StrCpy $BootDir $DestDrive 2 ;was -1 
  StrCpy $DestDisk $DestDrive 2 ;was -1
  SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; Clear all distro entries because a new drive may have been chosen ; Enable for DropBox
  StrCpy $Checker "Yes"  
  Call InstallorRemove
  Call SetSpace
  Call CheckSpace
  Call FormatIt 
  Call EnableNext 
  ${NSD_OnChange} $DestDriveTxt OnSelectDrive 

; Add Home Link
  ${NSD_CreateLink} 0 215 16% 15 "முகப்பு பக்கம்"
  Pop $Link
  ${NSD_OnClick} $LINK onClickMyLink    

; Add Help Link
  ${NSD_CreateLink} 16% 215 9% 15 "கேள்வி"
  Pop $Link1
  ${NSD_OnClick} $LINK1 onClickMyLinkFAQ 
  
; Add Giveback Link
  ${NSD_CreateLink} 25% 215 30% 15 "பரிந்துரை"
  Pop $Link2
  ${NSD_OnClick} $LINK2 onClickMyLinkUSB   
 
; Disable Next Button until a selection is made for all 
  GetDlgItem $6 $HWNDPARENT 1
  EnableWindow $6 0 
; Remove Back Button
  GetDlgItem $6 $HWNDPARENT 3
  ShowWindow $6 0 
; Hide or disable steps until we state to display them 
  EnableWindow $LabelISOSelection 0
  EnableWindow $ISOFileTxt 0
  ShowWindow $ISOSelection 0
  EnableWindow $DownloadISO 0
  ShowWindow $DistroLink 0
  StrCpy $JustISOName "NULL" ; Set to NULL until something is selected
  nsDialogs::Show  
  
 ${Else}
  
; To Install or Uninstall? That is the question!  
  ${NSD_CreateCheckBox} 60% 0 44% 15 "நிறுவப்பட்டது?"
  Pop $Uninstaller
  ${NSD_OnClick} $Uninstaller Uninstall  
  
; Drive Selection Starts  
  ${NSD_CreateLabel} 0 0 58% 15 ""    
  Pop $LabelDrivePage
  ${NSD_SetText} $LabelDrivePage "படி 1: மின்வெட்டொளி இயக்கக எழுத்து."    
  
; Droplist for Drive Selection
  ${NSD_CreateDropList} 0 20 55% 15 "" ; was 0 20 15% 15
  Pop $DestDriveTxt
  Call ListAllDrives
  ${NSD_OnChange} $DestDriveTxt OnSelectDrive
 
; All Drives Option
;  ${NSD_CreateCheckBox} 36% 23 22% 15 "Show All Drives" ; was 17% 23 41% 15
;  Pop $AllDriveOption
;  ${NSD_OnClick} $AllDriveOption ListAllDrives 
  
; Format Drive Option
  ${NSD_CreateCheckBox} 60% 23 100% 15 "துடைத்து Fat32 வடிவமை $DestDisk"
  Pop $Format
  ${NSD_OnClick} $Format FormatIt     

; Distro Selection Starts
  ${NSD_CreateLabel} 0 50 50% 15 $(Distro_Text) 
  Pop $LinuxDistroSelection   

  ${NSD_CreateDropList} 0 70 55% 95 "" ; was ${NSD_CreateListBox} ; Enable for Dropbox
  Pop $Distro
  ${NSD_OnChange} $Distro OnSelectDistro
  ${NSD_CB_SelectString} $Distro $DistroName ; Was ${NSD_LB_SelectString} $Distro $DistroName  ; Enable For DropBox
  
; Force Show All ஐஎஸ்ஓ Option
  ${NSD_CreateCheckBox} 80% 100 20% 15 "ஐஎஸ்ஓகள்?"
  Pop $ForceShowAll
  ${NSD_OnClick} $ForceShowAll ShowAllISOs    

; ஐஎஸ்ஓ Download Option
  ${NSD_CreateCheckBox} 60% 60 40% 15 "ஐஎஸ்ஓ பதிவிறக்கம்."
  Pop $DownloadISO
  ${NSD_OnClick} $DownloadISO DownloadIt  
  
; Clickable Link to Distribution Homepage  
  ${NSD_CreateLink} 60% 80 40% 15 "$OfficialName முகப்புப்பக்கத்தைப் பார்வையிடவும்"
  Pop $DistroLink
  ${NSD_OnClick} $DistroLink onClickLinuxSite    

; ஐஎஸ்ஓ Selection Starts  
  ${NSD_CreateLabel} 0 100 100% 15 $(IsoPage_Text)
  Pop $LabelISOSelection
  ${NSD_CreateText} 0 120 78% 20 "உலாவி  $FileFormat தேர்ந்தெடுக்கவும்"
  Pop $ISOFileTxt 
  ${NSD_CreateBrowseButton} 85% 120 60 20 "உலாவு"
  Pop $ISOSelection 
  ${NSD_OnClick} $ISOSelection ISOBrowse

; Casper-RW Selection Starts
  ${NSD_CreateLabel} 0 150 75% 15 $(Casper_Text)
  Pop $CasperSelection  
  ${NSD_CreateLabel} 52% 178 25% 25 ""
  Pop $SlideSpot  

  nsDialogs::CreateControl "msctls_trackbar32" "0x50010000|0x00000018" "" 0 174 50% 25 ""
  Pop $CasperSlider

  SendMessage $CasperSlider ${TBM_SETRANGEMIN} 1 0 ; Min Range Value 0
  SendMessage $CasperSlider ${TBM_SETRANGEMAX} 1 $RemainingSpace ; Max Range Value $RemainingSpace
  ${NSD_OnNotify} $CasperSlider onNotify_CasperSlider
  
; Add Home Link
  ${NSD_CreateLink} 0 215 16% 15 "முகப்பு பக்கம்"
  Pop $Link
  ${NSD_OnClick} $LINK onClickMyLink    
  
; Add Help Link
  ${NSD_CreateLink} 16% 215 9% 15 "கேள்வி"
  Pop $Link1
  ${NSD_OnClick} $LINK1 onClickMyLinkFAQ 
  
; Add Giveback Link
  ${NSD_CreateLink} 25% 215 30% 15 "பரிந்துரை"
  Pop $Link2
  ${NSD_OnClick} $LINK2 onClickMyLinkUSB
; Disable Next Button until a selection is made for all 
  GetDlgItem $6 $HWNDPARENT 1
  EnableWindow $6 0 
; Remove Back Button
  GetDlgItem $6 $HWNDPARENT 3
  ShowWindow $6 0 
; Hide or disable steps until we state to display them 
  EnableWindow $LabelISOSelection 0
  EnableWindow $ISOFileTxt 0
  ShowWindow $ISOSelection 0
  EnableWindow $LinuxDistroSelection 0
  EnableWindow $Distro 0
  EnableWindow $DownloadISO 0
  ShowWindow $DistroLink 0
  ShowWindow $CasperSelection 0 
  ShowWindow $CasperSlider 0 
  ShowWindow $SlideSpot 0  
  ShowWindow $Format 0
  ShowWindow $ForceShowAll 0
  ShowWindow $Uninstaller 0
  nsDialogs::Show 
 ${EndIf}
FunctionEnd

Function InstFiles_PreFunction
  StrCpy $R8 3
FunctionEnd

Function Finish_PreFunction
  StrCpy $R8 4
  Call NoQuit
FunctionEnd

Function ListAllDrives ; Set to Display All Drives
  SendMessage $DestDriveTxt ${CB_RESETCONTENT} 0 0 
   ${GetDrives} "FDD+HDD" DrivesList ; All Drives Listed  
FunctionEnd

Function onClickMyLink
  Pop $Links ; இணைப்பு திற
  ExecShell "open" "https://TamilNeram.github.io"
FunctionEnd

Function onClickMyLinkFAQ
  Pop $Links1 ; இணைப்பு திற
  ExecShell "open" "https://TamilNeram.github.io"
FunctionEnd

Function onClickMyLinkUSB
  Pop $Links2 ; இணைப்பு திற
  ExecShell "open" "https://TamilNeram.github.io"
FunctionEnd

Function onClickLinuxSite
  Pop $OfficialSite 
  ExecShell "open" "$Homepage"
FunctionEnd

Function DownloadIt ; பதிவிறக்க இணைப்பு அமை
  ${NSD_GetState} $DownloadISO $DownloadMe
  ${If} $DownloadMe == ${BST_CHECKED}
  ${NSD_Check} $DownloadISO
  ${NSD_SetText} $DownloadISO "பதிவிறக்க இணைப்பு திறக்கப்பட்டது"
  Call DownloadLinks
  ${ElseIf} $DownloadMe == ${BST_UNCHECKED}
  ${NSD_Uncheck} $DownloadISO 
  ${NSD_SetText} $DownloadISO "பதிவிறக்க இணைப்பு" 
  ${EndIf}  
FunctionEnd

Function EnableNext ; Enable Install Button
  ${If} $Blocksize >= 4 
  ${AndIf} $Removal != "Yes"
  ShowWindow $Format 1 
  ${Else}
  ShowWindow $Format 0
  ${EndIf}
  ${If} $Removal != "Yes"    
   ${AndIf} $ISOFileName != ""
    ${AndIf} $ISOFile != ""
     ${AndIf} $DestDrive != "" 
	  ${AndIf} $ISOTest != ""
  StrCpy $InUnStall "சேர்"	
   StrCpy $InUnStalling "சேர்த்து"	
    StrCpy $InUnStalled "சேர்க்கப்பட்டது"	
  StrCpy $OnFrom "இதற்கு"
  StrCpy $InUnName "$JustISOName"
  GetDlgItem $6 $HWNDPARENT 1 ; Get "Install" control handle
   SendMessage $6 ${WM_SETTEXT} 0 "STR:உருவாக்கு"
    EnableWindow $6 1 ; Enable "Install" control button

  ${ElseIf} $Removal == "Yes"
   ${AndIf} $ISOFileName != ""
     ${AndIf} $DestDrive != "" 
	  ${AndIf} $ISOTest != ""
  StrCpy $InUnStall "நீக்கு"	
   StrCpy $InUnStalling "நீக்குகிறது"	
    StrCpy $InUnStalled "நீக்கப்பட்டது"	  
  StrCpy $OnFrom "இருந்து"	
  StrCpy $InUnName "$DistroName"
  GetDlgItem $6 $HWNDPARENT 1 ; Get "Install" control handle
   SendMessage $6 ${WM_SETTEXT} 0 "STR:நீக்கு"
    EnableWindow $6 1 ; Enable "Install" control button
  ${EndIf}
  
; Test if ஐஎஸ்ஓ has been Selected. If not, disable Install Button
  ${If} $ISOTest == ""
  GetDlgItem $6 $HWNDPARENT 1
  EnableWindow $6 0 ; Disable "Install" if ஐஎஸ்ஓ not set 
  ${EndIf}
  
; Show Steps in progression
  ${If} $DestDrive != ""  
  EnableWindow $LinuxDistroSelection 1
  EnableWindow $Distro 1
  ${EndIf}  
  
  ${If} $ISOFileName != "" 
  ${AndIf} $Removal != "Yes"
  EnableWindow $LabelISOSelection 1 
  EnableWindow $ISOFileTxt 1  
  ShowWindow $ISOSelection 1
  
  ${AndIf} $Removal == "Yes"
  EnableWindow $LabelISOSelection 0  
  EnableWindow $ISOFileTxt 0 
  ShowWindow $ISOSelection 0
  ${EndIf}  
  
; Disable Window if ஐஎஸ்ஓ was downloaded
  ${If} $TheISO == "$EXEDIR\$ISOFileName"
  ${AndIf} $ISOTest != ""  
  EnableWindow $ISOSelection 0
  SetCtlColors $ISOFileTxt 009900 FFFFFF  
  ${EndIf}

; If using Casper Persistence...  
  ${If} $Persistence == "casper" ; If can use Casper Persistence... 
  ${AndIf} $TheISO != ""
  ${AndIf} $BootDir != "" 
  ShowWindow $CasperSelection 1
  ShowWindow $CasperSlider 1
  ShowWindow $SlideSpot 1
  ${ElseIf} $Persistence != "casper" ; Eventually change to "NULL"
  ${OrIf} $Removal == "Yes"  
  ShowWindow $CasperSelection 0
  ShowWindow $CasperSlider 0 
  ShowWindow $SlideSpot 0
  ${EndIf}    
FunctionEnd

Function DownloadLinks
MessageBox MB_YESNO|MB_ICONQUESTION "பதிவிறக்க இணைப்பைத் தொடங்கவா?$\r$\nபடி 2 க்குச் செல்வதற்கு முன் பதிவிறக்கம் முடிக்கட்டும்." IDYES DownloadIt IDNO Skip
  Skip: ; Reset Download Checkbox Options 
  ${NSD_Uncheck} $DownloadISO 
  ${NSD_SetText} $DownloadISO "பதிவிறக்க இணைப்பு"  
  EnableWindow $DownloadISO 1
  Goto end
  DownloadIt:
  ${NSD_SetText} $LabelISOSelection "படி 3: பதிவிறக்கம் முடிந்ததும், உலாவி ஐஎஸ்ஓவைத் தேர்ந்தெடுக்கவும்."  
  EnableWindow $DownloadISO 0
  ExecShell "open" "$DownLink"    
  end:
FunctionEnd

Function LocalISODetected ; The script autodetected the ISO, so let's do the following
 ${If} $DownloadMe != ${BST_CHECKED}
 ${AndIf} $LocalSelection != "Yes"
 StrCpy $ISOFile "$EXEDIR\$ISOFileName"
 ${EndIf}
FunctionEnd

; get only the filename
Function GrabNameOnly
  Exch $4 ; count to get part
  Exch
  Exch $0 ; input string
  Push $1
  Push $2
  Push $3
  StrCpy $1 0
  StrCpy $3 1
  loop:
    IntOp $1 $1 - 1
    StrCpy $2 $0 1 $1
    StrCmp $2 "" exit2
    StrCmp $2 "\" next ; grab text to the right of "\"
    Goto loop
  next:
    StrCmp $3 $4 exit
    IntOp $3 $3 + 1
  Goto loop
  exit2:
    IntOp $1 $1 - 1
  exit:
    IntOp $1 $1 + 1
    StrCpy $0 $0 "" $1
    Pop $3
    Pop $2
    Pop $1
    Exch $0 ; output string
FunctionEnd

!include StrContains.nsh ; Let's check if a * wildcard exists
; On Selection of Linux Distro
Function OnSelectDistro
  Pop $Distro
  
  ${If} $Removal == "Yes"
   ShowWindow $ForceShowAll 0
  ${Else}
   ShowWindow $ForceShowAll 1
  ${EndIf}
  
  ${NSD_GetText} $Distro $DistroName ; Was ${NSD_LB_GetSelection} $Distro $DistroName 
  StrCpy $DistroName "$DistroName"   
  StrCpy $Checker "No" 
  ${If} $Removal == "Yes"
  StrCpy $ISOFileName "$DistroName" 
  StrCpy $ISOTest "$DistroName"  
  ${Else} 
  Call SetISOFileName
  StrCpy $ISOFileName "$ISOFileName" 
  StrCpy $SomeFileExt "$ISOFileName" "" -3 ; Grabs the last 3 characters of the file name... zip or ஐஎஸ்ஓ?
  StrCpy $FileFormat "$SomeFileExt" ; Set file type to look for zip, tar, ஐஎஸ்ஓ etc...
  ${NSD_SetText} $LabelISOSelection "படி 3: உலாவி $ISOFileName தேர்ந்தெடுக்கவும்"
  ${NSD_SetText} $ISOFileTxt "$ISOFile கோப்பிற்கு உலாவுக  -->"
  SetCtlColors $ISOFileTxt FF0000 FFFFFF  
  StrCpy $ISOTest "" ; Set to null until a new ஐஎஸ்ஓ selection is made
  ${EndIf}
  
; Redraw முகப்பு பக்கம் Links as necessary
  ${NSD_SetText} $DistroLink "$OfficialName முகப்புப்பக்கத்தைப் பார்வையிடவும்" 
  ShowWindow $DistroLink 0
  ${If} $OfficialName == ""
   ${OrIf} $Removal == "Yes"
  ShowWindow $DistroLink 0
  ${Else}
  ShowWindow $DistroLink 1
  ${EndIf}    
; Autodetect ஐஎஸ்ஓ's in same folder and select if they exist  
 ${If} ${FileExists} "$EXEDIR\$ISOFileName"
 ${AndIf} $Removal != "Yes"
 ${StrContains} $WILD "*" "$ISOFileName" ; Check for Wildcard and force Browse if * exists.
 ${AndIf} $WILD != "*"  
  StrCpy $TheISO "$EXEDIR\$ISOFileName"
  StrCpy $ISOFile "$TheISO"  
  ${GetFileName} "$TheISO" $JustISO
										   
  ${GetBaseName} "$JustISO" $JustISOName
  ${StrRep} '$JustISOName' '$JustISOName' ' ' '-'
							   
  ${GetParent} "$TheISO" $JustISOPath  
  EnableWindow $DownloadISO 0
  ${NSD_SetText} $DownloadISO "நாங்கள் கண்டுபிடித்து $SomeFileExt தேர்ந்தெடுத்தோம்."    
  EnableWindow $ISOSelection 0 
  SetCtlColors $ISOFileTxt 009900 FFFFFF  
  ${NSD_SetText} $ISOFileTxt $ISOFile 
  ${NSD_SetText} $LabelISOSelection "படி 3 முடிந்தது: $ISOFileName கண்டுபிடிக்கப்பட்டு தேர்ந்தெடுக்கப்பட்டது! "  
  StrCpy $ISOTest "$TheISO" ; Populate ISOTest so we can enable Next    
  Call EnableNext  
  
 ${ElseIf} ${FileExists} "$EXEDIR\$ISOFileName"
 ${AndIf} $Removal != "Yes"
 ${AndIf} $WILD == "*" 
  EnableWindow $DownloadISO 1
  EnableWindow $ISOSelection 1
  ${NSD_Uncheck} $DownloadISO  
  ${NSD_SetText} $DownloadISO "பதிவிறக்க இணைப்பு"       
  SetCtlColors $ISOFileTxt FF9B00 FFFFFF  
  ${NSD_SetText} $ISOFileTxt "உலாவி $ISOFileName தேர்ந்தெடுக்கவும்" 
  ${NSD_SetText} $LabelISOSelection "படி 3 நிலுவையில்:$ISOFile கோப்பிற்கு உலாவுக"    
  Call EnableNext  
  
 ${Else}
  Call EnableNext
  EnableWindow $DownloadISO 1
  EnableWindow $ISOSelection 1
  ${NSD_Uncheck} $DownloadISO  
  ${NSD_SetText} $DownloadISO "பதிவிறக்க இணைப்பு"   
 ${EndIf}  
 
 ${If} $DownLink == "NONE"
  ${OrIf} $Removal == "Yes"
  ShowWindow $DownloadISO 0
 ${Else}
  ShowWindow $DownloadISO 1
 ${EndIf}
FunctionEnd 

; On Selection of ஐஎஸ்ஓ File
Function ISOBrowse
 ${If} $ShowingAll == "Yes"
  StrCpy $ISOFileName "*.iso" 
 ${ElseIf} $ShowingAll != "Yes"
  Call SetISOFileName
 ${EndIf}
 
 nsDialogs::SelectFileDialog open "" $(IsoFile)
 Pop $TheISO  
 ${NSD_SetText} $ISOFileTxt $TheISO
 SetCtlColors $ISOFileTxt 009900 FFFFFF
 EnableWindow $DownloadISO 0
 ${NSD_SetText} $DownloadISO "கணினியில் உள்ள $SomeFileExt தேர்ந்தெடுக்கப்பட்டது." 
 StrCpy $ISOTest "$TheISO" ; Populate ISOTest so we can enable Next 
 StrCpy $ISOFile "$TheISO" 
 ${GetFileName} "$TheISO" $JustISO
 ${StrRep} '$JustISO' '$JustISO' ' ' '-'
 ${GetBaseName} "$JustISO" $JustISOName
 ${StrRep} '$JustISOName' '$JustISOName' ' ' '-'
 ${GetParent} "$TheISO" $JustISOPath
 StrCpy $LocalSelection "Yes"
  Call SetISOSize
  Call SetSpace
  Call CheckSpace
  Call HaveSpacePre
 ${If} $JustISOName == "" 
 StrCpy $JustISOName "NULL" ; Set to NULL until something is selected
 ${EndIf}
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\*.*"
 ${AndIf} $JustISOName != ""
 ${AndIf} $FormatMe != "Yes"
 MessageBox MB_OK "$JustISOName is already on $DestDisk$\r$\nPlease Remove it first!"
 ${Else}
 ${EndIf}
 Call EnableNext
 ; Uncomment for Testing --> MessageBox MB_ICONQUESTION|MB_OK 'Removal: "$Removal"  ISOFileName: "$ISOFileName" ISOFile "$ISOFile" BootDir: "$BootDir" DestDisk: "$DestDisk" DestDrive: "$DestDrive" ISOTest: "$ISOTest"'
 FunctionEnd

Function ClearAll
StrCpy $ISOTest ""
StrCpy $DistroName "" ; Clear Distro Name
StrCpy $ISOFileName "" ; Clear ஐஎஸ்ஓ Selection
StrCpy $SomeFileExt ""
StrCpy $FileFormat ""
FunctionEnd

Function InstallorRemove ; Populate DistroName based on Install/Removal option
  ${If} $Removal == "Yes" 
  Call RemovalList
  ${Else}
   ${NSD_SetText} $LinuxDistroSelection "படி 2: $DestDiskஇல் நிறுவ ஒரு விநியோகம்" 
  Call SetISOFileName
  ${EndIf}
FunctionEnd  

; On Selection of Uninstaller Option
Function Uninstall
  ${NSD_GetState} $Uninstaller $Removal
  ${If} $Removal == ${BST_CHECKED}
  ShowWindow $Format 0
    ShowWindow $LabelISOSelection 0 
	Call ClearAll	
    EnableWindow $ISOFileTxt 0
	ShowWindow $ISOFileTxt 0
	ShowWindow $ISOSelection 0
    ShowWindow $ForceShowAll 0	
    ShowWindow $CasperSelection 0
    ShowWindow $CasperSlider 0 
    ShowWindow $SlideSpot 0	
	StrCpy $Persistence "NULL" 
	
  ${NSD_Check} $Uninstaller 
  StrCpy $Removal "Yes"
  ShowWindow $DistroLink 0
  ShowWindow $DownloadISO 0
   GetDlgItem $6 $HWNDPARENT 1 ; Get "Install" control handle
	SendMessage $6 ${WM_SETTEXT} 0 "STR:நீக்கு"
	EnableWindow $6 0 ; Disable "Install" control button
  ${NSD_SetText} $Uninstaller "நிறுவல் நீக்குதல்"
   ${NSD_SetText} $LinuxDistroSelection "படி 2: $DestDisk இலிருந்து அகற்ற ஒரு விநியோகத்தைத் தேர்ந்தெடுக்கவும் "  
    SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; Clear all distro entries because a new option may have been chosen ; Enable for DropBox
     StrCpy $Checker "Yes"   
	 Call RemovalList

  ${ElseIf} $Removal == ${BST_UNCHECKED}
   ShowWindow $Format 1  
    ShowWindow $LabelISOSelection 1 
    ShowWindow $ISOFileTxt 1
	ShowWindow $ISOSelection 0
	Call ClearAll
    ${NSD_SetText} $LabelISOSelection "படி 3: $ISOFileName கோப்பைத் தேர்ந்தெடுக்கவும்"
	${NSD_SetText} $ISOFileTxt "படி 2 முடியும் வரை மறைக்கப்படும்"
     GetDlgItem $6 $HWNDPARENT 1 ; Get "Install" control handle
	  SendMessage $6 ${WM_SETTEXT} 0 "STR:உருவாக்கு"
	  EnableWindow $6 0 ; Disable "Install" control button
  ${NSD_Uncheck} $Uninstaller  
  StrCpy $Removal "No"  
  ${NSD_SetText} $Uninstaller "நிறுவப்பட்டது?" 
   ${NSD_SetText} $LinuxDistroSelection "படி 2: $DestDiskவைக்க ஒரு விநியோகம்" 
     SendMessage $Distro ${CB_RESETCONTENT} 0 0  ; Clear all distro entries because a new option may have been chosen ; Enable for DropBox
     StrCpy $Checker "Yes"         
     Call SetISOFileName
  ${EndIf}  
FunctionEnd

; On Selection of USB Drive
Function OnSelectDrive
  Pop $DestDriveTxt
  ${NSD_GetText} $DestDriveTxt $Letters
  StrCpy $DestDrive "$Letters"
  StrCpy $JustDrive $DestDrive 3  
  StrCpy $BootDir $DestDrive 2 ;was -1 
  StrCpy $DestDisk $DestDrive 2 ;was -1

  Call PhysDrive
  Call GetFSType
  ${If} $FSType == "exFAT"
   ${OrIf} $FSType == "NTFS"
   MessageBox MB_ICONSTOP|MB_OK "$FSType வடிவமைக்கப்பட்ட சாதனங்களில் கணிலினக்சு செயல்படாது. $JustDriveஐ Fat32 ஆக வடிவமைக்க நீங்கள் தேர்வு செய்யலாம்."
  ${EndIf}   
  SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; Clear all distro entries because a new drive may have been chosen ; Enable for DropBox
  StrCpy $Checker "Yes" 
  Call InstallorRemove
  Call SetSpace
  Call CheckSpace
  Call FormatIt  
  Call EnableNext
  ${NSD_SetText} $LabelDrivePage "படி 1: மின்வெட்டொளி $DestDisk (தட்டு $DiskNum) தேர்ந்தெடுத்துள்ளீர்கள்"   
FunctionEnd

Function GetDiskVolumeName
;Pop $1 ; get parameter
System::Alloc 1024 ; Allocate string body
Pop $0 ; Get the allocated string's address

!define GetVolumeInformation "Kernel32::GetVolumeInformation(t,t,i,*i,*i,*i,t,i) i"
System::Call '${GetVolumeInformation}("$9",.r0,1024,,,,,1024)' ;

;Push $0 ; Push result
${If} $0 != ""
 StrCpy $VolName "$0"
${Else}
 StrCpy $VolName ""
${EndIf}
FunctionEnd ; GetDiskVolumeName

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
 Call PhysDrive
 Call GetDiskVolumeName
 Call DiskSpace
 Call GetFSType
;Prevent System Drive from being selected
 StrCpy $7 $WINDIR 3
 ${If} $9 != "$7" 
 SendMessage $DestDriveTxt ${CB_ADDSTRING} 0 "STR:$9 (Disk $DiskNum) $VolName $Capacity $FSType" ;$8
 ${EndIf}
 Push 1 ; must push something - see GetDrives documentation
FunctionEnd
 
Function FormatYes ; If Format is checked, do something
  SetShellVarContext all
  InitPluginsDir
  File /oname=$PLUGINSDIR\fat32format.exe "இருமங்கள்\fat32format.exe"
  ${If} $FormatMe == "Yes"
   Call Lock_Only ; Just get a lock on the Volume 
   Sleep 3000
   nsExec::ExecToLog '"cmd" /c "echo y|$PLUGINSDIR\fat32format $DestDisk"' ;/Q /y
   Call UnLockVol ; Unlock to allow Access   
  ${EndIf} 
FunctionEnd

Function FormatIt ; Set Format Option
  ${NSD_GetState} $Format $FormatMe
  ${If} $FormatMe == ${BST_CHECKED}
  ${NSD_Check} $Format
    StrCpy $FormatMe "Yes"
  ${NSD_SetText} $Format "துடைத்து Fat32 வடிவமை $DestDisk!"
    SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; Clear all distro entries because a new format option may have been chosen ; Enable for DropBox
	ShowWindow $Uninstaller 0 ; Disable Uninstaller option because we will be formatting the drive.
    StrCpy $Checker "Yes"	
  
  ${ElseIf} $FormatMe == ${BST_UNCHECKED}
  ${NSD_Uncheck} $Format 
  ${NSD_SetText} $Format "துடைத்து Fat32 வடிவமை $DestDisk"  
    SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; Clear all distro entries because a new format option may have been chosen ; Enable for DropBox

    ShowWindow $Uninstaller 1 ; Re-enable Uninstaller option.
	StrCpy $Checker "Yes" 
	Call SetSpace
  ${EndIf}  
  
    Call InstallorRemove
FunctionEnd

Function ShowAllISOs ; Set Show All ISOs Option
  ${NSD_GetState} $ForceShowAll $ShowingAll
  ${If} $ShowingAll == ${BST_CHECKED}
  ${NSD_Check} $ForceShowAll
  StrCpy $ShowingAll "Yes"
  ${NSD_SetText} $ForceShowAll "ஐஎஸ்ஓகள்!"
    SendMessage $ISOSelection ${CB_RESETCONTENT} 0 0 
 
  ${ElseIf} $ShowingAll == ${BST_UNCHECKED}
  ${NSD_Uncheck} $ForceShowAll
  ${NSD_SetText} $ForceShowAll "ஐஎஸ்ஓகள்?"  
    SendMessage $ISOSelection ${CB_RESETCONTENT} 0 0 
  ${EndIf}  
FunctionEnd

Function CheckSpace ; Check total available space so we can set block size
  Call TotalSpace
  ${If} $1 <= 511
  StrCpy $BlockSize 1
  ${ElseIf} $1 >= 512
  ${AndIf} $1 <= 8191
  StrCpy $BlockSize 4
  ${ElseIf} $1 >= 8192 
  ${AndIf} $1 <= 16383
  StrCpy $BlockSize 8
  ${ElseIf} $1 >= 16384
  ${AndIf} $1 <= 32767
  StrCpy $BlockSize 16
  ${ElseIf} $1 > 32768
  StrCpy $BlockSize 32
  ${EndIf}
 ; MessageBox MB_ICONSTOP|MB_OK "$0 Drive is $1 MB in size, blocksize = $BlockSize KB."  
FunctionEnd

Function TotalSpace
${DriveSpace} "$JustDrive" "/D=T /S=M" $1 ; used to find total space of select disk
 StrCpy $Capacity "$1"
FunctionEnd

Function FreeDiskSpace
${If} $FormatMe == "Yes"
							 
${DriveSpace} "$JustDrive" "/D=T /S=M" $1
${Else}
${DriveSpace} "$JustDrive" "/D=F /S=M" $1
${EndIf}
FunctionEnd

Function SetSpace ; Set space available for persistence
  ;StrCpy $0 '$0'
  Call FreeDiskSpace
  IntOp $MaxPersist 4090 + $CasperSize ; Space required for distro and 4GB max persistent file
  ${If} $1 > $MaxPersist ; Check if more space is available than we need for distro + 4GB persistent file
  StrCpy $RemainingSpace 4090 ; Set maximum possible value to 4090 MB (any larger wont work on fat32 Filesystem)
 ${Else}
  StrCpy $RemainingSpace "$1"
  IntOp $RemainingSpace $RemainingSpace - $SizeOfCasper ; Remaining space minus distro size
 ${EndIf}
  IntOp $RemainingSpace $RemainingSpace - 1 ; Subtract 1MB so that we don't error for not having enough space
  SendMessage $CasperSlider ${TBM_SETRANGEMAX} 1 $RemainingSpace ; Re-Setting Max Value
FunctionEnd

Function HaveSpacePre ; Check space required
  Call CasperSize
  Call FreeDiskSpace
  System::Int64Op $1 > $SizeOfCasper ; Compare the space available > space required
  Pop $3 ; Get the result ...
  IntCmp $3 1 okay ; ... and compare it
  MessageBox MB_ICONSTOP|MB_OK "அச்சச்சோ: போதுமான வட்டு இடம் இல்லை!  $JustDriveஇயக்ககத்தில் $1 எம்பி உள்ளது, $SizeOfCasper எம்பி தேவை."
  okay: ; Proceed to execute...
		 
FunctionEnd

Function HaveSpace ; Check space required
  Call CasperSize
  Call FreeDiskSpace
  System::Int64Op $1 > $SizeOfCasper ; Compare the space available > space required
  Pop $3 ; Get the result ...
  IntCmp $3 1 okay ; ... and compare it
  MessageBox MB_ICONSTOP|MB_OK "போதுமான காலி இடம் இல்லை. ஐ-கருவி நிறுத்தம்!"
  quit ; போதுமான காலி இடம் இல்லை. ஐ-கருவி நிறுத்தம்...
  okay: ; Proceed to execute...

FunctionEnd

!macro DeleteMenuEntry file start stop
Push "${FILE}" ; File to search in
Push "${START}$\r$\n" ; text to start deleting from 
Push "${STOP}$\r$\n" ; text to stop at
Call DeleteMenuEntry
!macroend
!define DeleteMenuEntry "!insertmacro DeleteMenuEntry"

Function DeleteMenuEntry
 Exch $1 ;end string
 Exch
 Exch $2 ;begin string
 Exch 2
 Exch $3 ;file
 Exch 2
 Push $R0
 Push $R1
 Push $R2
 Push $R3
  GetTempFileName $R2
  FileOpen $R1 $R2 w
  FileOpen $R0 $3 r
  ClearErrors
  FileRead $R0 $R3
  IfErrors Done
  StrCmp $R3 $2 +3
  FileWrite $R1 $R3
  Goto -5
  ClearErrors
  FileRead $R0 $R3
  IfErrors Done
  StrCmp $R3 $1 +4 -3 
  FileRead $R0 $R3
  IfErrors Done
  FileWrite $R1 $R3
  ClearErrors
  Goto -4
Done:
   FileClose $R0
   FileClose $R1
   SetDetailsPrint none
   Delete $3
   Rename $R2 $3
   SetDetailsPrint both
 Pop $R3
 Pop $R2
 Pop $R1
 Pop $R0
 Pop $3
 Pop $2
 Pop $1
FunctionEnd

; Custom Distros Installer - Uninstaller 
!include "InstallDistro.nsh" ; #ADD NEW DISTRO#
!include "RemoveDistro.nsh" ; # REM DISTRO#

Function DoSyslinux ; Install Syslinux on USB
  ${IfNot} ${FileExists} "$BootDir\multiboot\libcom32.c32" 
  ${AndIf} ${FileExists} "$BootDir\multiboot\ldlinux.sys"   
  MessageBox MB_ICONEXCLAMATION|MB_OK $(WarningSyslinuxOLD)
  Quit
  ${EndIf}
  
  ;IfFileExists "$BootDir\multiboot\libcom32.c32" SkipSyslinux CreateSyslinux ; checking for newer syslinux
  IfFileExists "$BootDir\multiboot\menu\ldlinux.sys" SkipSyslinux CreateSyslinux ; checking for syslinux
  CreateSyslinux:
  CreateDirectory $BootDir\multiboot\menu ; recursively create the directory structure if it doesn't exist
  ;CreateDirectory $BootDir\multiboot\ISOS ; create ISOS folder  
  DetailPrint $(ExecuteSyslinux)
  ExecWait '$PLUGINSDIR\syslinux.exe -maf -d /multiboot/menu $BootDir' $R8
  DetailPrint "Syslinux Errors $R8"
  Banner::destroy
  ${If} $R8 != 0
  MessageBox MB_ICONEXCLAMATION|MB_OK $(WarningSyslinux)
  ${EndIf} 
  DetailPrint "$DestDisk மேல் TA சிட்டை உருவாக்குகிறது"
  nsExec::ExecToLog '"cmd" /c "LABEL $DestDiskTA"'
  
  SkipSyslinux: 
  DetailPrint $(SkipSyslinux)
  
  ${If} ${FileExists} $BootDir\multiboot\menu\syslinux.cfg   
  ${AndIf} ${FileExists} $BootDir\multiboot\menu\memdisk
   DetailPrint "முந்தைய பலதுவக்க நிறுவல் கண்டறியப்பட்டது."
   ; Call AddDir
  ${Else}
; Create and Copy files to your destination
  DetailPrint "தேவையான கோப்புகள் $BootDir\multiboot இதற்கு சேர்கப்பட்டன..." 
  CopyFiles "$PLUGINSDIR\உரிமை.உரை" "$BootDir\multiboot\உரிமை.உரை"
  
; Copy these files to multiboot\menu
  DetailPrint "தேவையான கோப்புகள் $BootDir\multiboot\menu directory இதற்கு சேர்கப்பட்டன..." 
  CopyFiles "$PLUGINSDIR\syslinux.cfg" "$BootDir\multiboot\menu\syslinux.cfg"  
  CopyFiles "$PLUGINSDIR\memdisk" "$BootDir\multiboot\menu\memdisk"      
  ${EndIf}  

; boot\ஐ-விரிவாக்கக்கூடிய_நிலைபொருள்_இடைமுகம் அடைவு மற்றும் கோப்புகள் இருப்பதை உறுதிப்படுத்தவும்.  
  ${If} ${FileExists} $BootDir\boot\ஐ-விரிவாக்கக்கூடிய_நிலைபொருள்_இடைமுகம்\BOOTX64.EFI 
  ${AndIf} ${FileExists} $BootDir\boot\ஐ-விரிவாக்கக்கூடிய_நிலைபொருள்_இடைமுகம்\துவக்கஏற்றி.வடிவு
  
  ${Else}  
; Copy GRUB2 EFI files 
  DetailPrint "GRUB2 EFI கோப்புகளை நகலெடுக்க தொடர்கிறது..."
																
  ExecWait '"$PLUGINSDIR\7zG.exe" x "$PLUGINSDIR\EFIGRUBX64.zip" -o"$BootDir" -y' 
  ${EndIf}   
FunctionEnd


; ---- Let's Do This Stuff ----
Section  ; This is the only section that exists
; Get just the name of the ஐஎஸ்ஓ file 
Push "$ISOFile"
Push 1
Call GrabNameOnly
Pop $NameThatISO

 ${If} ${FileExists} "$BootDir\windows\system32" ; Safeguard windows Installation.
 MessageBox MB_ICONSTOP|MB_OK "கைவிடுகிறது! ($DestDisk) ஒரு WINDOWS/SYSTEM32 கோப்பகத்தைக் கொண்டுள்ளது."
 Quit
 ${EndIf}
 
 Call GetFSType
 ${If} $FSType == "exFAT"
  ${OrIf} $FSType == "NTFS"
   ${AndIf} $FormatMe != "Yes" 
   MessageBox MB_ICONSTOP|MB_OK "$FSType வடிவமைக்கப்பட்ட சாதனங்களில் கணிலினக்சு செயல்படாது. ஐ-கருவி வெளியேறும்!" 
   Quit
 ${EndIf}  
 
;checkpoint:
 ${If} $FormatMe == "Yes" 
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "எச்சரிக்கை: தொடர்வதற்கு முன் ($DestDisk)உடன் இணைக்கப்பட்ட அனைத்து பகிர்வுகளிலிருந்தும் உங்கள் தரவை காப்புப் பிரதி எடுக்கவும்!$\r$\n$\r$\n${NAME}  பின்வரும் செயல்களைச் செய்ய தயாராக உள்ளது:$\r$\n$\r$\n1. துடைத்து Fat32 வடிவமை ($DestDisk) -  தரவு மீளமுடியாமல் நீக்கப்படு!$\r$\n$\r$\n2. ($DestDisk)இல் ஒரு கணிலினக்சு முதன்மை துவக்க பதிவு உருவாக்கும் - இருக்கும் முதன்மை துவக்க பதிவு மேலெழுதப்படும்!$\r$\n$\r$\n3.($DestDisk)இல் TA சிட்டை உருவாக்கவும் - இருக்கும் சிட்டை மேலெழுதப்படும்!$\r$\n$\r$\n4. ($DestDisk)இல் ($DistroName)வை நிறுவு$\r$\n$\r$\n($DestDisk) இல் (வட்டு $DiskNum) சரியான யூ.எஸ்.பி சாதனம் என்பது உங்களுக்குத் தெரியுமா?$\r$\nஉறுதிப்படுத்த விண்டோஸ் வட்டு நிர்வாகத்துடன் இருமுறை சரிபார்க்கவும்!$\r$\n$\r$\nஇந்த செயல்களைச் செய்ய ஆம் என்பதை சொடுக்கவும் அல்லது கைவிட இல்லை சொடுக்கவும்!" IDYES proceed
 Quit
 ${ElseIf} $FormatMe != "Yes" 
								
 ${AndIfNot} ${FileExists} $BootDir\multiboot\menu\syslinux.cfg
 MessageBox MB_YESNO|MB_ICONEXCLAMATION "${NAME} பின்வரும் செயல்களைச் செய்ய தயாராக உள்ளது:$\r$\n$\r$\n1. ($DestDisk)இல் ஒரு கணிலினக்சு முதன்மை துவக்க பதிவு உருவாக்கும் - இருக்கும் முதன்மை துவக்க பதிவு மேலெழுதப்படும்!$\r$\n$\r$\n2.$DestDisk இல் TA சிட்டை உருவாக்கவும் - இருக்கும் சிட்டை மேலெழுதப்படும்!$\r$\n$\r$\n3. ($DestDisk)இல் ($DistroName)வை நிறுவு$\r$\n$\r$\nசரியான யூ.எஸ்.பி சாதனம் என்பது உங்களுக்குத் தெரியுமா?$\r$\nஉறுதிப்படுத்த விண்டோஸ் வட்டு நிர்வாகத்துடன் இருமுறை சரிபார்க்கவும்!$\r$\n$\r$\nஇந்த செயல்களைச் செய்ய ஆம் என்பதை சொடுக்கவும் அல்லது கைவிட இல்லை சொடுக்கவும்!" IDYES proceed
 Quit
 ${EndIf}

proceed: 
 ${IfThen} $Removal == "Yes" ${|} Goto removeonly ${|}
 Call HaveSpace ; Got enough Space? Lets Check!
 Call FormatYes ; Format the Drive?
 Call DoSyslinux ; Run Syslinux on the Drive to make it bootable
 Call LocalISODetected
 
; Copy the config file if it doesn't exist and create the entry in syslinux.cfg 
 ${IfNot} ${FileExists} "$BootDir\multiboot\menu\$Config2Use" 
 CopyFiles "$PLUGINSDIR\$Config2Use" "$BootDir\multiboot\menu\$Config2Use"
 Call Config2Write
 ${EndIf} 
 
removeonly:
 ${If} $Removal != "Yes"
 !insertmacro Install_Distros ; Install those distros
 ${ElseIf} $Removal == "Yes"
  Call ConfigRemove
 !insertmacro Uninstall_Distros ; Remove those distros
 ${EndIf}
 
SectionEnd

Function ConfigRemove ; Find and Set Removal Configuration file
  ${If} ${FileExists} "$BootDir\multiboot\$DistroName\I\linux.cfg"
  StrCpy $Config2Use "linux.cfg"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\I\anon.cfg"
  StrCpy $Config2Use "anon.cfg"  
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\I\system.cfg"
  StrCpy $Config2Use "system.cfg"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\I\antivirus.cfg"
  StrCpy $Config2Use "antivirus.cfg"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\I\netbook.cfg"
  StrCpy $Config2Use "netbook.cfg"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\I\other.cfg"
  StrCpy $Config2Use "other.cfg"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\I\unlisted.cfg"
  StrCpy $Config2Use "unlisted.cfg"  
;  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\I\menu.lst"
;  StrCpy $Config2Use "menu.lst"
  ${EndIf}
  ; MessageBox MB_OK "$Config2Use"
FunctionEnd

Function Config2Write
 ${If} $Config2Use == "anon.cfg"
  ${WriteToSysFile} "menuentry $\">AB$\"{configfile /multiboot/menu/anon.cfg}" $R0  
 ${ElseIf} $Config2Use == "antivirus.cfg"
  ${WriteToSysFile} "menuentry $\">AV$\"{configfile /multiboot/menu/antivirus.cfg}" $R0 
 ${ElseIf} $Config2Use == "system.cfg"
  ${WriteToSysFile} "menuentry $\">SL$\"{configfile /multiboot/menu/system.cfg}" $R0
 ${ElseIf} $Config2Use == "linux.cfg"
  ${WriteToSysFile} "menuentry $\">I$\"{configfile /multiboot/menu/linux.cfg}" $R0 
 ${ElseIf} $Config2Use == "netbook.cfg"
  ${WriteToSysFile} "menuentry $\">NB$\"{configfile /multiboot/menu/netbook.cfg}" $R0 
 ${ElseIf} $Config2Use == "other.cfg"
  ${WriteToSysFile} "menuentry $\">O$\"{configfile /multiboot/menu/other.cfg}" $R0 
 ${ElseIf} $Config2Use == "unlisted.cfg"
  ${WriteToSysFile} "menuentry $\">UL$\"{configfile /multiboot/menu/unlisted.cfg}" $R0  
; ${ElseIf} $Config2Use == "menu.lst"
;  ${WriteToSysFile} "label GRUB Bootable ISOs$\r$\nmenu label GRUB Bootable ISOs and Windows XP/7/8 ->$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/menu/menu.lst" $R0 
 ${EndIf} 
;always write data to அகர.வடிவு not required
 
FunctionEnd

Function NoQuit
MessageBox MB_YESNO "$DestDisk இயக்ககத்தில் இப்போது மேலும் ஐஎஸ்ஓக்கள் / விநியோகங்களை சேர்க்க விரும்புகிறீர்களா?" IDYES noskip
    StrCmp $R8 3 0 End ;Compare $R8 variable with current page #
    StrCpy $R9 1 ; Goes to finish page
    Call RelGotoPage
    Abort
noskip:
StrCpy $ShowAll "$ShowAll" ; Retain Display All Drives
StrCpy $DestDrive "$DestDrive" ; Retain previously selected Drive Letter
StrCpy $RepeatInstall "YES" ; Set Repeat Install Option to YES
StrCpy $ISOTest "" ; Reset
StrCpy $ISOFile "" ; Reset
StrCpy $Removal "" ; Reset
StrCpy $Persistence "NULL" ; Reset
StrCpy $NameThatISO "" ; Reset NameThatISO ஐஎஸ்ஓ Name
StrCpy $Config2Use "" ; Clear Config File to create and write to
StrCpy $DistroName "" ; Clear Distro Name
StrCpy $ISOFileName "" ; Clear ஐஎஸ்ஓ Selection
StrCpy $FileFormat "" ; Clear File Format
StrCpy $DownloadMe 0 ; Ensure Uncheck of Download Option
StrCpy $LocalSelection "" ; Reset Local Selection
StrCpy $ShowingAll ""
StrCpy $FormatMe "" ; Reset Format Option
    StrCmp $R8 4 0 End ;Compare $R8 variable with current page #
    StrCpy $R9 -3 ; Goes back to selections page
    Call RelGotoPage ; change pages
    Abort
End:
FunctionEnd

Function RelGotoPage
  IntCmp $R9 0 0 Move Move
    StrCmp $R9 "X" 0 Move
      StrCpy $R9 "120"
Move:
  SendMessage $HWNDPARENT "0x408" "$R9" ""
FunctionEnd

; --- Stuff to do at startup of script ---
Function .onInit
StrCpy $R9 0 ; we start on page 0
;StrCpy $InstallButton ""
 StrCpy $FileFormat "ISO"
 userInfo::getAccountType
 Pop $Auth
 strCmp $Auth "Admin" done
 Messagebox MB_OK|MB_ICONINFORMATION "தற்போது நீங்கள் இந்த நிரலை $Authஆக இயக்க முயற்சிக்கிறீர்கள் $\r$\n$\r$\nநீங்கள் நிர்வாக உரிமைகளுடன் இந்த நிரலை இயக்க வேண்டும்...$\r$\n$\r$\nகோப்பில் வலது கிளிக் செய்து, நிர்வாகியாக இயக்கவும் அல்லது இயக்கவும் என்பதைத் தேர்ந்தெடுக்கவும் (மற்றும் நிர்வாகக் கணக்கைத் தேர்ந்தெடுக்கவும்)!"
 Abort
 done:
 SetShellVarContext all
 InitPluginsDir   
  CreateDirectory "$PLUGINSDIR\new7z\"
  File /oname=$PLUGINSDIR\syslinux.exe "இருமங்கள்\கணிலினக்சு.exe"  
  File /oname=$PLUGINSDIR\syslinux.cfg "உரை\கணிலினக்சு.வடிவு"
  File /oname=$PLUGINSDIR\grubslug.cfg "உரை\மந்தமான.வடிவு"   
  File /oname=$PLUGINSDIR\antivirus.cfg "உரை\நோய்க்கிருமிதடுப்பு.வடிவு" 
  File /oname=$PLUGINSDIR\system.cfg "உரை\கருவிகள்.வடிவு" 
  File /oname=$PLUGINSDIR\netbook.cfg "உரை\இணையபுத்தகம்.வடிவு"
  File /oname=$PLUGINSDIR\anon.cfg "உரை\அறியப்படாத.வடிவு"
  File /oname=$PLUGINSDIR\linux.cfg "உரை\லினக்சு.வடிவு" 
  File /oname=$PLUGINSDIR\unlisted.cfg "உரை\பட்டியலிடாத.வடிவு"
  File /oname=$PLUGINSDIR\liveusb "உரை\liveusb"
  File /oname=$PLUGINSDIR\7zG.exe "இருமங்கள்\7zG.exe"
  File /oname=$PLUGINSDIR\7z.dll "இருமங்கள்\7z.dll"  
  File /oname=$PLUGINSDIR\new7z\7zG.exe "இருமங்கள்\new7z\7zG.exe"
  File /oname=$PLUGINSDIR\new7z\7z.dll "இருமங்கள்\new7z\7z.dll"  
  File /oname=$PLUGINSDIR\உரிமை.உரை "உரை\உரிமை.உரை" 
  File /oname=$PLUGINSDIR\memdisk "இருமங்கள்\memdisk"  
  File /oname=$PLUGINSDIR\EFIGRUBX64.zip "EFIGRUB\EFIGRUBX64.zip"   
; File /oname=$PLUGINSDIR\அகர.வடிவு "உரை\அகர.வடிவு"
; File /oname=$PLUGINSDIR\other.cfg "உரை\மற்றவை.வடிவு"   
; File /oname=$PLUGINSDIR\mbrid "உரை\முதன்மை_துவக்க_பதிவெண்"  
FunctionEnd

Function onNotify_CasperSlider
 Pop $Casper
 SendMessage $CasperSlider ${TBM_GETPOS} 0 0 $Casper ; Get Trackbar position
 ${NSD_SetText} $SlideSpot "$Casper MB"
FunctionEnd

Function SetISOSize ; Get size of ஐஎஸ்ஓ
 System::Call 'kernel32::CreateFile(t "$TheISO", i 0x80000000, i 1, i 0, i 3, i 0, i 0) i .r0'
 System::Call "kernel32::GetFileSizeEx(i r0, *l .r1) i .r2"
 System::Alloc $1
 System::Int64Op $1 / 1048576 ; convert to MB
 Pop $1
 StrCpy $SizeOfCasper "$1"
 # MessageBox MB_OK|MB_ICONINFORMATION "ஐஎஸ்ஓ அளவு: $SizeOfCasper"
 System::Call 'kernel32::CloseHandle(i r0)'
FunctionEnd

Function FindInitrd
; FindFirst $0 $1 "$FindInitPath"
 loop:
  StrCmp $1 "" done
  ;DetailPrint Found $1
  StrCpy $Initrd $1 
  FindNext $0 $1
  Goto loop
 done:
 FindClose $0
 FunctionEnd
 
 Function FindVmlinuz
; FindFirst $0 $1 "$FindVmlinuzPath"
 loop:
  StrCmp $1 "" done
  ;DetailPrint Found $1
  StrCpy $Vmlinuz $1 
  FindNext $0 $1
  Goto loop
 done:
 FindClose $0
FunctionEnd

Function GetFSType
System::Call 'Kernel32::GetVolumeInformation(t "$JustDrive",t,i ${NSIS_MAX_STRLEN},*i,*i,*i,t .r1" ,i ${NSIS_MAX_STRLEN}) i.r0'
 StrCpy $FSType "$1"
FunctionEnd
