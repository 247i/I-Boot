Unicode True 
!define NAME "ஐ-கருவி"
!define FILENAME "ஐ-கருவி"
!define VERSION "2.0.7.10"
!define MUI_ICON "படங்கள்\வண்ணத்துப்பூச்சி.ico"

; MoreInfo Plugin - Adds Version Tab fields to Properties.
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
;!include TextFunc.nsh
!AddPluginDir "plugins"

; Variables
Var HDDUSB
Var Capacity
Var VolName
Var Checker
Var FileFormat
Var Format 
Var FormatMe
Var FormatFat 
Var FormatMeFat
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
Var IsoFile
Var ISOSelection
Var ISOTest
Var JustISO
Var JustISOName
Var InUnName
Var JustISOPath
Var ConfigFile
Var ConfigPath
Var CopyPath
Var SearchDir
Var SearchFile
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
Var InUnStall
Var InUnStalling
Var InUnStalled
Var OnFrom
Var SUSEDIR
Var RepeatInstall
;Var ShowAll
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
;Var VolMountPoint
;Var DismountAction
Var VHDDisk
Var VHDSize
Var VHDLBL
Var FSType
Var CasperName
Var COMSPEC
Var PERCENT
Var DiskNum

Var Wipe
Var WipeIt
Var WipeMe
;Var DisMounted

!include DiskVoodoo.nsh

; Interface settings
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "படங்கள்\தலைப்பு.bmp" 
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
!define MUI_WELCOMEFINISHPAGE_BITMAP "படங்கள்\சரி.bmp"
!define MUI_PAGE_CUSTOMFUNCTION_PRE Finish_PreFunction
!insertmacro MUI_PAGE_FINISH

; தமிழ் மொழி கோப்புகள்
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
!include ReplaceInFile.nsh

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
  
; Alt Wipe Disk and all Partitions, Volumes.
  ${NSD_CreateCheckBox} 60% 0 44% 15 "Wipe Entire (Disk $DiskNum)"
  Pop $Wipe
  ${NSD_OnClick} $Wipe WipeIt  

; Distro Selection Starts
  ${NSD_CreateLabel} 0 50 50% 15 $(Distro_Text) 
  Pop $LinuxDistroSelection   

  ${NSD_CreateDroplist} 0 70 58% 95 "" ; was  ${NSD_CreateListBox} ; Enable For DropBox
  Pop $Distro
  ${NSD_OnChange} $Distro OnSelectDistro
  ${NSD_CB_SelectString} $Distro $DistroName ; Was ${NSD_LB_SelectString} $Distro $DistroName  ; Enable For DropBox 
  
; அனைத்து ஐஎஸ்ஓ விருப்பத்தையும் கட்டாயப்படுத்து
  ${NSD_CreateCheckBox} 80% 100 20% 9u "அனைத்து ஐஎஸ்ஓக்களையும் காண்பிக்கவா?"
  Pop $ForceShowAll
  ${NSD_OnClick} $ForceShowAll ShowAllISOs   

; ISO Download Option
  ${NSD_CreateCheckBox} 60% 60 40% 15 "ஐஎஸ்ஓ பதிவிறக்கம்."
  Pop $DownloadISO
  ${NSD_OnClick} $DownloadISO DownloadIt  
  
; Clickable Link to Distribution Homepage  
  ${NSD_CreateLink} 60% 80 40% 15 "$OfficialName பக்கத்தைப் பார்!"
  Pop $DistroLink
  ${NSD_OnClick} $DistroLink onClickLinuxSite    

; ISO Selection Starts  
  ${NSD_CreateLabel} 0 100 100% 15 $(IsoPage_Text)
  Pop $LabelISOSelection
  ${NSD_CreateText} 0 120 78% 20 "உலாவி $FileFormat தேர்ந்தெடுக்கவும்"
  Pop $ISOFileTxt 
  ${NSD_CreateBrowseButton} 85% 120 60 20 "Browse"
  Pop $ISOSelection 
  ${NSD_OnClick} $ISOSelection ISOBrowse   
  
; Casper-RW Selection Starts
  ${NSD_CreateLabel} 0 150 75% 15 ""
  Pop $CasperSelection  
  
; CasperSlider - TrackBar
  ;!define TBM_SETPOS 0x0405
  ;!define TBM_GETPOS 0x0400
  ;!define TBM_SETRANGEMIN 0x0407
  ;!define TBM_SETRANGEMAX 0x0408

  ${NSD_CreateLabel} 52% 178 25% 25 ""
  Pop $SlideSpot  

  nsDialogs::CreateControl "msctls_trackbar32" "0x50010000|0x00000018" "" 0 174 50% 25 ""
  Pop $CasperSlider
  SendMessage $CasperSlider ${TBM_SETRANGEMIN} 1 0 ; Min Range Value 0
  SendMessage $CasperSlider ${TBM_SETRANGEMAX} 1 $RemainingSpace ; Max Range Value $RemainingSpace
  ${NSD_OnNotify} $CasperSlider onNotify_CasperSlider    

; Drive Pre-Selection  
  ${NSD_CreateLabel} 0 0 58% 15 ""
  Pop $LabelDrivePage 
  ${NSD_SetText} $LabelDrivePage "படி 1: மின்வெட்டொளி இயக்கமாக $DestDisk வரவழைக்கப்பட்டது"  
; Droplist for Drive Selection  
  ${NSD_CreateDropList} 0 20 55% 15 "" ; was 0 20 28% 15
  Pop $DestDriveTxt 
  ${GetDrives} "FDD+HDD" DrivesList ; All Drives Listed
  
  ${NSD_CB_SelectString} $DestDriveTxt "$DestDrive"
  StrCpy $JustDrive $DestDrive 3
  StrCpy $BootDir $DestDrive 2 ;was -1 
  StrCpy $DestDisk $DestDrive 2 ;was -1
  SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; was ${NSD_LB_Clear} $Distro "" ; Clear all distro entries because a new drive may have been chosen ; Enable for DropBox
  StrCpy $Checker "Yes"  
  Call InstallorRemove
  Call CheckSpace
  Call FormatIt 
  Call EnableNext 
  ${NSD_OnChange} $DestDriveTxt OnSelectDrive 
  
; Format Drive Option
;;  ${NSD_CreateCheckBox} 60% 23 100% 15 "NTFS Format $DestDisk"
;;  Pop $Format
;;  ${NSD_OnClick} $Format FormatIt  

; Format Fat32 Option
;;  ${NSD_CreateCheckBox} 60% 40 100% 15 "Fat32 Format $DestDisk"
;;  Pop $FormatFat
;;  ${NSD_OnClick} $FormatFat FormatIt    
  
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
  
; Alt Wipe Disk and all Partitions, Volumes.
  ${NSD_CreateCheckBox} 60% 0 44% 15 "Wipe Entire (Disk $DiskNum)"
  Pop $Wipe
  ${NSD_OnClick} $Wipe WipeIt     
  
; Drive Selection Starts  
  ${NSD_CreateLabel} 0 0 58% 15 ""    
  Pop $LabelDrivePage
  ${NSD_SetText} $LabelDrivePage "படி 1: மின்வெட்டொளி இயக்கக எழுத்து."    
  
; Droplist for Drive Selection
  ${NSD_CreateDropList} 0 20 55% 15 "" ; was 0 20 28% 15
  Pop $DestDriveTxt
  Call ListAllDrives
  ${NSD_OnChange} $DestDriveTxt OnSelectDrive
  
; Format Drive Option
  ${NSD_CreateCheckBox} 60% 23 100% 15 "NTFS வடிவமை $DestDisk"
  Pop $Format
  ${NSD_OnClick} $Format FormatIt  

; Format Fat32 Option
  ${NSD_CreateCheckBox} 60% 40 100% 15 "Fat32 வடிவமை $DestDisk"
  Pop $FormatFat
  ${NSD_OnClick} $FormatFat FormatIt  
 
; Distro Selection Starts
  ${NSD_CreateLabel} 0 50 50% 15 $(Distro_Text) 
  Pop $LinuxDistroSelection   

  ${NSD_CreateDropList} 0 70 58% 95 "" ; was ${NSD_CreateListBox} ; Enable for Dropbox
  Pop $Distro
  ${NSD_OnChange} $Distro OnSelectDistro
  ${NSD_CB_SelectString} $Distro $DistroName ; Was ${NSD_LB_SelectString} $Distro $DistroName  ; Enable For DropBox
  
; Force Show All ISO Option
  ${NSD_CreateCheckBox} 80% 100 20% 9u "அனைத்து ஐஎஸ்ஓக்களையும் காண்பிக்கவா?"
  Pop $ForceShowAll
  ${NSD_OnClick} $ForceShowAll ShowAllISOs    

; ISO Download Option
  ${NSD_CreateCheckBox} 60% 60 40% 15 "ஐஎஸ்ஓ பதிவிறக்கம்."
  Pop $DownloadISO
  ${NSD_OnClick} $DownloadISO DownloadIt  
  
; Clickable Link to Distribution Homepage  
  ${NSD_CreateLink} 60% 80 40% 15 "$OfficialName முகப்புப்பக்கத்தைப் பார்வையிடவும்"
  Pop $DistroLink
  ${NSD_OnClick} $DistroLink onClickLinuxSite    

; ISO Selection Starts  
  ${NSD_CreateLabel} 0 100 100% 15 $(IsoPage_Text)
  Pop $LabelISOSelection
  ${NSD_CreateText} 0 120 78% 20 "உலாவி $FileFormat தேர்ந்தெடுக்கவும்"
  Pop $ISOFileTxt 
  ${NSD_CreateBrowseButton} 85% 120 60 20 "Browse"
  Pop $ISOSelection 
  ${NSD_OnClick} $ISOSelection ISOBrowse

; Casper-RW Selection Starts
  ${NSD_CreateLabel} 0 150 75% 15 "" ;$(Casper_Text)
  Pop $CasperSelection  
  
; CasperSlider - TrackBar
  ; !define TBM_SETPOS 0x0405
  ; !define TBM_GETPOS 0x0400
  ; !define TBM_SETRANGEMIN 0x0407
  ; !define TBM_SETRANGEMAX 0x0408

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

;; Add a custom donate button
;   ${NSD_CreateBitmap} 80% 125 20% 50 "PayPal Donation"
;   Var /Global Donate
;   Var /Global DonateHandle  
;   Pop $Donate
;   ${NSD_SetImage} $Donate $PLUGINSDIR\paypal.bmp $DonateHandle 
;  GetFunctionAddress $DonateHandle OnClickDonate
;  nsDialogs::OnClick $Donate $DonateHandle  
  
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
  ShowWindow $FormatFat 0
  ShowWindow $ForceShowAll 0
  ShowWindow $Uninstaller 0
  ShowWindow $Wipe 0
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
; ${NSD_GetState} $AllDriveOption $DisplayAll
; ${If} $DisplayAll == ${BST_CHECKED}
; ${NSD_Check} $AllDriveOption
; ${NSD_SetText} $AllDriveOption "Showing All!" 
;  StrCpy $ShowAll "YES"
   ${GetDrives} "FDD+HDD" DrivesList ; All Drives Listed  
;  ${ElseIf} $DisplayAll == ${BST_UNCHECKED}
;  ${NSD_Uncheck} $AllDriveOption
;  ${NSD_SetText} $AllDriveOption "Show All Drives?"  
;  ${GetDrives} "FDD" DrivesList ; FDD+HDD reduced to FDD for removable media only
;  StrCpy $ShowAll "NO"
;  ${EndIf}
FunctionEnd

						 
Function onClickMyLink
  Pop $Links ; pop something to prevent corruption
  ExecShell "open" "https://TamilNeram.github.io"
FunctionEnd

Function onClickMyLinkFAQ
  Pop $Links1 ; pop something to prevent corruption
  ExecShell "open" "https://TamilNeram.github.io"
FunctionEnd

Function onClickMyLinkUSB
  Pop $Links2 ; pop something to prevent corruption
  ExecShell "open" "https://TamilNeram.github.io"
FunctionEnd

Function onClickLinuxSite
  Pop $OfficialSite 
  ExecShell "open" "$Homepage"
FunctionEnd

Function DownloadIt ; Set Download Option
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
  ;${If} $Blocksize >= 4 
  ${If} $Removal != "Yes"
  ${AndIf} $HDDUSB != "HDD"
    ${If} $FormatMe == "YES" 
    ShowWindow $Format 1 
    ${EndIf}
    ${If} $FormatMeFat == "YES" 
    ShowWindow $FormatFat 1 
    ${EndIf}
  ${Else}
  ShowWindow $Format 0
  ShowWindow $FormatFat 0
  ${NSD_UnCheck} $Format
  StrCpy $FormatMe ""  
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
  
; Test if ISO has been Selected. If not, disable Install Button
  ${If} $ISOTest == ""
  GetDlgItem $6 $HWNDPARENT 1
  EnableWindow $6 0 ; Disable "Install" if ISO not set 
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
  
; Disable Window if ISO was downloaded
  ${If} $TheISO == "$EXEDIR\$ISOFileName"
  ${AndIf} $ISOTest != ""  
  EnableWindow $ISOSelection 0
  SetCtlColors $ISOFileTxt 009900 FFFFFF  
  ${EndIf}

; If using Casper Persistence...  
  ${If} $Persistence == "casper" ; If can use Casper Persistence... 
  ${AndIf} $TheISO != ""
  ${AndIf} $BootDir != "" 
  ;${AndIf} $FSType != "NTFS" ; prevent casper if NTFS... implement fix for this later.
  ShowWindow $CasperSelection 1
  ShowWindow $CasperSlider 1
  ShowWindow $SlideSpot 1
   ${If} $DistroName == "Windows to Go (Virtual Hard Disk)"
     SendMessage $CasperSlider ${TBM_SETRANGEMIN} 1 20000 ; Min Range Value
    ${NSD_SetText} $CasperSelection "Step 4: Set the Size of the Win2Go VHD file. Minimum 20,000 MB"  
	${Else} 
	 SendMessage $CasperSlider ${TBM_SETRANGEMIN} 1 0 ; Min Range Value 0
	${NSD_SetText} $CasperSelection "Step 4: Set a Persistent file size for storing changes (Optional)."  
   ${EndIf}
  ;${NSD_SetText} $Format "Format $JustDrive Drive (Erases Content)"  
	
; Else If not using Casper Persistence...  
  ${ElseIf} $Persistence != "casper" ; Eventually change to "NULL"
  ${OrIf} $Removal == "Yes"  
  ShowWindow $CasperSelection 0
  ShowWindow $CasperSlider 0 
  ShowWindow $SlideSpot 0
  ;${NSD_SetText} $Format "Format $JustDrive Drive (Erases Content)" 
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
  StrCpy $SomeFileExt "$ISOFileName" "" -3 ; Grabs the last 3 characters of the file name... zip or iso?
  StrCpy $FileFormat "$SomeFileExt" ; Set file type to look for zip, tar, iso etc...
  ${NSD_SetText} $LabelISOSelection "படி 3: உலாவி $ISOFileName தேர்ந்தெடுக்கவும்"
  ${NSD_SetText} $ISOFileTxt "$ISOFile கோப்பிற்கு உலாவுக  -->"
  SetCtlColors $ISOFileTxt FF0000 FFFFFF  
  StrCpy $ISOTest "" ; Set to null until a new ISO selection is made
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
  
  ${If} $DistroName != ""
  ${NSD_SetText} $LinuxDistroSelection "படி 2: $DistroName தேர்ந்தெடுக்கப்பட்டது"
  ${Else}
  ${NSD_SetText} $LinuxDistroSelection "படி 2: $DestDiskவைக்க ஒரு விநியோகம்"
  ${EndIf}    
  
; Autodetect ISO's in same folder and select if they exist  
 ${If} ${FileExists} "$EXEDIR\$ISOFileName"
 ${AndIf} $Removal != "Yes"
 ${StrContains} $WILD "*" "$ISOFileName" ; Check for Wildcard and force Browse if * exists.
 ${AndIf} $WILD != "*"  
  StrCpy $TheISO "$EXEDIR\$ISOFileName"
  StrCpy $ISOFile "$TheISO"  
  ${GetFileName} "$TheISO" $JustISO
  ${StrRep} '$JustISO' '$JustISO' ' ' '-'  
  ${GetBaseName} "$JustISO" $JustISOName
  ${StrRep} '$JustISOName' '$JustISOName' ' ' '-'
;MessageBox MB_OK $JustISOName 
  ${GetParent} "$TheISO" $JustISOPath  
  EnableWindow $DownloadISO 0
  ${NSD_SetText} $DownloadISO "We Found and Selected the $SomeFileExt."    
  EnableWindow $ISOSelection 0 
  SetCtlColors $ISOFileTxt 009900 FFFFFF  
  ${NSD_SetText} $ISOFileTxt $ISOFile 
  ${NSD_SetText} $LabelISOSelection "படி 3 முடிந்தது: $ISOFileName கண்டுபிடிக்கப்பட்டு தேர்ந்தெடுக்கப்பட்டது!"  
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

; On Selection of ISO File
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
 ${NSD_SetText} $DownloadISO "Local $SomeFileExt Selected." 
 StrCpy $ISOTest "$TheISO" ; Populate ISOTest so we can enable Next 
 StrCpy $ISOFile "$TheISO" 
 ${GetFileName} "$TheISO" $JustISO
 ${StrRep} '$JustISO' '$JustISO' ' ' '-'
 ${GetBaseName} "$JustISO" $JustISOName
 ${StrRep} '$JustISOName' '$JustISOName' ' ' '-'
;MessageBox MB_OK $JustISOName 
 ${GetParent} "$TheISO" $JustISOPath
 StrCpy $LocalSelection "Yes"
  Call SetISOSize
  Call SetSpace
  Call CheckSpace
  Call HaveSpacePre
 ${If} $JustISOName == "" 
 StrCpy $JustISOName "NULL" ; Set to NULL until something is selected
 ${EndIf}
 
 ${If} $JustISO != ""
 ${NSD_SetText} $LabelISOSelection "Step 3: $JustISO Selected"
 ${Else}
 ${NSD_SetText} $LabelISOSelection "Step 3: Select your $ISOFileName"
 ${EndIf} 
 
 ${If} ${FileExists} "$BootDir\multiboot\$JustISOName\*.*"
 ${AndIf} $JustISOName != ""
 ${AndIf} $FormatMe != "Yes"
 ${AndIf} $FormatMeFat != "Yes"
 MessageBox MB_OK "$JustISOName is already on $DestDisk$\r$\nPlease Remove it first!$\r$\n$\r$\nNOTE: If you have already removed it using I,$\r$\nmanually delete the $BootDir\multiboot\$JustISOName\ folder."
 ${Else}
 ${EndIf}
 Call EnableNext
 ; Uncomment for Testing --> MessageBox MB_ICONQUESTION|MB_OK 'Removal: "$Removal"  ISOFileName: "$ISOFileName" ISOFile "$ISOFile" BootDir: "$BootDir" DestDisk: "$DestDisk" DestDrive: "$DestDrive" ISOTest: "$ISOTest"'
  ${If} $FSType != "NTFS"
  ${AndIf} $FormatMe != "Yes"
  ${AndIf} $DistroName == "Windows to Go (Virtual Hard Disk)"
  MessageBox MB_ICONSTOP|MB_OK "எச்சரிக்கை! ($DestDisk) என்.டி.எஃப்.எஸ் வடிவமைக்கப்படவில்லை. விண்டோஸ் டூ கோ விருப்பம் வேலை செய்ய என்.டி.எஃப்.எஸ் தேவை."
 
   ${ElseIf} $FSType != "NTFS"
   ${AndIf} $FormatMe != "Yes"
   
   ${If} $DistroName == "Sergei Strelec"
   ${OrIf} $DistroName == "Try Unlisted ISO (GRUB Partition 4)"
   ${OrIf} $DistroName == "Try Unlisted ISO (GRUB)"
     ${If} $SizeOfCasper > "4096"
     MessageBox MB_OK|MB_ICONINFORMATION "The ISO is greater than 4GB. You must use NTFS format."
     ${EndIf}
	${EndIf}
	 
  ${EndIf}  
 FunctionEnd

Function ClearAll
StrCpy $ISOTest ""
StrCpy $DistroName "" ; Clear Distro Name
StrCpy $ISOFileName "" ; Clear ISO Selection
StrCpy $SomeFileExt ""
StrCpy $FileFormat ""
FunctionEnd

Function InstallorRemove ; Populate DistroName based on Install/Removal option
  ${If} $Removal == "Yes" 
  Call RemovalList
  ${Else}
    ${If} $DistroName == ""
    ${NSD_SetText} $LinuxDistroSelection "படி 2: $DestDiskவைக்க ஒரு விநியோகம்" 
	${EndIf}
  SendMessage $Distro ${CB_RESETCONTENT} 0 0
  Call SetISOFileName
  ${EndIf}
FunctionEnd  

; On Selection of Uninstaller Option
Function Uninstall
  ${NSD_GetState} $Uninstaller $Removal
  ${If} $Removal == ${BST_CHECKED}
  ShowWindow $Format 0
  ShowWindow $FormatFat 0
  ShowWindow $Wipe 0
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
    SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; Clear all distro entries because a new option may have been chosen ; Enable for DropBox
     StrCpy $Checker "Yes"   
	 Call RemovalList

  ${ElseIf} $Removal == ${BST_UNCHECKED}
   ShowWindow $Format 1  
   ShowWindow $FormatFat 1
    ShowWindow $LabelISOSelection 1 
    ShowWindow $ISOFileTxt 1
	ShowWindow $ISOSelection 0
	ShowWindow $Wipe 1  
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
  StrCpy $HDDUSB $Letters "" -3 
  
  StrCpy $9 $JustDrive
  Call GetFSType
  Call PhysDrive
  ${NSD_SetText} $LabelDrivePage "படி 1: $DestDisk (தட்டு $DiskNum) தேர்ந்தெடுத்துள்ளீர்கள்"   
  ;MessageBox MB_ICONSTOP|MB_OK " $9 $FSType" 
  
  ${NSD_GetState} $Wipe $WipeIt
  ${If} $WipeIt == ${BST_CHECKED}
  ${NSD_Check} $Wipe
   StrCpy $WipeMe "Yes" 
  ${NSD_SetText} $Wipe "We Will Wipe (Disk $DiskNum)"
  ${ElseIf} $WipeIt == ${BST_UNCHECKED}
  ${NSD_Uncheck} $Wipe
   StrCpy $WipeMe "No"
  ${NSD_SetText} $Wipe "Wipe Entire (Disk $DiskNum)"  
  ; ShowWindow $Uninstaller 1 ; Re-enable Uninstaller option.
  ${EndIf}      
  
  
  SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; Clear all distro entries because a new drive may have been chosen ; Enable for DropBox
  StrCpy $Checker "Yes" 
  Call InstallorRemove
  Call SetSpace
  Call CheckSpace
  Call FormatIt  
  Call EnableNext

  ${If} $FSType == "exFAT"
  MessageBox MB_ICONSTOP|MB_OK "எச்சரிக்கை! கணிலினக்சு exFAT வடிவமைக்கப்பட்ட சாதனங்களில் இயங்காது. $DestDiskஐ Fat32 அல்லது என்.டி.எஃப்.எஸ் ஆக வடிவமைக்கவும்.."
  ${EndIf} 
  
  ${If} ${FileExists} "$BootDir\boot\grub\i.png"  
   ${AndIf} ${FileExists} "$BootDir\boot\grub\lnxboot.img"
    ${AndIf} ${FileExists} "$BootDir\boot\grub\core.img" 
     ${AndIf} ${FileExists} "$BootDir\boot\grub\grub.cfg"  
     MessageBox MB_ICONSTOP|MB_OK "எச்சரிக்கை! ($DestDisk) இந்த பதிப்போடு பொருந்தாத உ.வி.நி.இ. அடிப்படையிலான நிறுவலைக் கொண்டிருக்கிறது.$\r$\n$\r$\n ஐ-கருவியின் இந்த பதிப்பைப் பயன்படுத்த நீங்கள் திட்டமிட்டால், இந்த இயக்ககத்தை வடிவமைக்க வேண்டும்."
  ${EndIf} 
FunctionEnd

Function GetDiskVolumeName
;Pop $1 ; get parameter
System::Alloc 1024 ; Allocate string body
Pop $0 ; Get the allocated string's address

!define GetVolumeInformation "Kernel32::GetVolumeInformation(t,t,i,*i,*i,*i,t,i) i"
System::Call '${GetVolumeInformation}("$9",.r0,1024,,,,.r2,1024)' ;

;Sort drive types and display only fixed and removable
!define GetDriveType "Kernel32::GetDriveType(t) i"
System::Call '${GetDriveType}("$8")' ; 1024

;Push $0 ; Push result
${If} $0 != ""
 StrCpy $VolName "$0"
${Else}
 StrCpy $VolName ""
${EndIf}

StrCpy $2 "$2"
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
 Call PhysDrive
 Call GetDiskVolumeName
 Call DiskSpace
 Call GetFSType
 
;Prevent System Drive from being selected
 StrCpy $7 $WINDIR 3
 ${If} $9 != "$7" 
 SendMessage $DestDriveTxt ${CB_ADDSTRING} 0 "STR:$9 (Disk $DiskNum) $VolName $Capacity $FSType" $8
 ;SendMessage $DestDriveTxt ${CB_ADDSTRING} 0 "STR:$9 $VolName $Capacity $2 $8" 
 ${EndIf}
 Push 1 ; must push something - see GetDrives documentation
FunctionEnd

Function WipeIt ; Set Wipe Disk Option
  ${NSD_GetState} $Wipe $WipeIt
  ${If} $WipeIt == ${BST_CHECKED}
  ${NSD_Check} $Wipe
   StrCpy $WipeMe "Yes" 
  ${NSD_SetText} $Wipe "We Will Wipe (Disk $DiskNum)"
  ${ElseIf} $WipeIt == ${BST_UNCHECKED}
  ${NSD_Uncheck} $Wipe
   StrCpy $WipeMe "No"
  ${NSD_SetText} $Wipe "Wipe Entire (Disk $DiskNum)"  
  ; ShowWindow $Uninstaller 1 ; Re-enable Uninstaller option.
  ${EndIf}    
FunctionEnd
  
Function FormatYes ; If Format is checked, do something

  File /oname=$PLUGINSDIR\diskpartformat.txt "உரை\diskpartformat.txt"     
  File /oname=$PLUGINSDIR\diskpartwipe1.txt "உரை\diskpartwipe1.txt"  
  File /oname=$PLUGINSDIR\diskpartwipe2.txt "உரை\diskpartwipe2.txt"    
  
  !insertmacro ReplaceInFile "DISKNUM" "$DiskNum" "all" "all" "$PLUGINSDIR\diskpartwipe1.txt"  
  !insertmacro ReplaceInFile "DSK" "$DestDisk" "all" "all" "$PLUGINSDIR\diskpartwipe2.txt" 
  !insertmacro ReplaceInFile "DISKNUM" "$DiskNum" "all" "all" "$PLUGINSDIR\diskpartwipe2.txt"   
  !insertmacro ReplaceInFile "DSK" "$DestDisk" "all" "all" "$PLUGINSDIR\diskpartformat.txt" 

; For NTFS Format ---  
  ${If} $FormatMe == "Yes"
   ${AndIf} $WipeMe == "Yes"
; Wipes the Entire Disk and reformats it with one NTFS Partition
    ;ToDO - Need to make a checkpoint here to test if is greater than Win XP (Vista or later OS?). XP doesn't support Diskpart on removable disks.
    nsExec::ExecToLog '"DiskPart" /S $PLUGINSDIR\diskpartwipe1.txt' 
	Sleep 3000
	nsExec::ExecToLog '"DiskPart" /S $PLUGINSDIR\diskpartwipe2.txt'  
	
   ${ElseIf} $FormatMe == "Yes"
	${AndIf} $WipeMe != "Yes"
; Just format the selected Drive Letter (Volume or Partition) NTFS
    ;ToDO - Need to make a checkpoint here to test if is greater than Win XP (Vista or later OS?). XP doesn't support Diskpart on removable disks.
    nsExec::ExecToLog '"DiskPart" /S $PLUGINSDIR\diskpartformat.txt' 

; For Fat32 Format ---  
  ${ElseIf} $FormatMeFat == "Yes"  
   ${AndIf} $WipeMe == "Yes"
; Wipes the Entire Disk and reformats it with one Fat32 Partition  
   ;ToDO - Need to make a checkpoint here to test if is greater than Win XP (Vista or later OS?). XP doesn't support Diskpart on removable disks.
   nsExec::ExecToLog '"DiskPart" /S $PLUGINSDIR\diskpartwipe1.txt' 
   Sleep 3000
   nsExec::ExecToLog '"DiskPart" /S $PLUGINSDIR\diskpartwipe2.txt' 
   Sleep 3000
   DetailPrint "Formatting $DestDisk as Fat32. This may take a while, please be patient..."
   nsExec::ExecToLog '"cmd" /c "echo y|$PLUGINSDIR\fat32format $DestDisk"' ;/Q /y    
   
  ${ElseIf} $FormatMeFat == "Yes"  
   ${AndIf} $WipeMe != "Yes"   
; Just Fat32 format the selected Drive Letter (Volume or Partition)	 
   Call Lock_Only ; Just get a lock on the Volume 
   Sleep 3000
   nsExec::ExecToLog '"cmd" /c "echo y|$PLUGINSDIR\fat32format $DestDisk"' ;/Q /y
   Call UnLockVol ; Unlock to allow Access
  ${EndIf}   
FunctionEnd

Function FormatIt ; Set Format Option

  ${NSD_GetState} $FormatFat $FormatMeFat
  ${If} $FormatMeFat == ${BST_CHECKED}
  ${NSD_Check} $FormatFat
  ${NSD_SetText} $FormatFat "We Will Fat32 Format $DestDisk"
   ShowWindow $Format 0
   StrCpy $FormatMeFat "Yes" 
  ${ElseIf} $FormatMeFat == ${BST_UNCHECKED}
  ${NSD_Uncheck} $FormatFat
  ${NSD_SetText} $FormatFat "Fat32 Format $DestDisk"  
   ShowWindow $Format 1
   StrCpy $FormatMeFat "No"

   ShowWindow $Uninstaller 1 ; Re-enable Uninstaller option.
   StrCpy $Checker "Yes" 
   ;Call SetSpace
  ${EndIf}    

  ${NSD_GetState} $Format $FormatMe
  ${If} $FormatMe == ${BST_CHECKED}
  ${NSD_Check} $Format
  ${NSD_SetText} $Format "We Will NTFS Format $DestDisk"
   ShowWindow $FormatFat 0
   StrCpy $FormatMe "Yes"
  ${ElseIf} $FormatMe == ${BST_UNCHECKED}
  ${NSD_Uncheck} $Format
  ${NSD_SetText} $Format "NTFS Format $DestDisk"  
   ShowWindow $FormatFat 1
   StrCpy $FormatMe "No"

    ShowWindow $Uninstaller 1 ; Re-enable Uninstaller option.
	StrCpy $Checker "Yes" 
	;Call SetSpace
  ${EndIf}  
  
  ${If} $FormatMe == "Yes" 
   ${OrIf} $FormatMeFat == "Yes"
    ShowWindow $Wipe 1
	ShowWindow $Uninstaller 0 ; Disable Uninstaller option because we will be formatting the drive.
    StrCpy $Checker "Yes"	
	;Call SetSpace      
  ${Else}
   ${NSD_Uncheck} $Wipe
   ${NSD_SetText} $Wipe "Wipe Entire (Disk $DiskNum)"  
    StrCpy $WipeMe "No" 
  
	ShowWindow $Wipe 0
  ${EndIf}
  
    Call SetSpace
    Call InstallorRemove
FunctionEnd

Function ShowAllISOs ; Set Show All ISOs Option
  ${NSD_GetState} $ForceShowAll $ShowingAll
  ${If} $ShowingAll == ${BST_CHECKED}
  ${NSD_Check} $ForceShowAll
  StrCpy $ShowingAll "Yes"
  ${NSD_SetText} $ForceShowAll "அனைத்து ஐஎஸ்ஓக்களையும் காண்பி!"
    SendMessage $ISOSelection ${CB_RESETCONTENT} 0 0 
 
  ${ElseIf} $ShowingAll == ${BST_UNCHECKED}
  ${NSD_Uncheck} $ForceShowAll
  ${NSD_SetText} $ForceShowAll "அனைத்து ஐஎஸ்ஓக்களையும் காண்பிக்கவா?"  
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
${OrIf} $FormatMeFat == "Yes"
${DriveSpace} "$JustDrive" "/D=T /S=M" $1
${Else}
${DriveSpace} "$JustDrive" "/D=F /S=M" $1
${EndIf}
FunctionEnd

Function SetSpace ; Set space available for persistence
 ${If} $FSType != "NTFS"
 ${OrIf} $FormatMeFat == "Yes"
 ${AndIf} $FormatMe != "Yes"
 
  ;MessageBox MB_ICONSTOP|MB_OK "$Casper - $FormatMeFat"
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
  
 ${Else}  
  Call FreeDiskSpace
  StrCpy $RemainingSpace "$1"
  IntOp $RemainingSpace $RemainingSpace - $SizeOfCasper ; Remaining space minus distro size
  IntOp $RemainingSpace $RemainingSpace - 1 ; Subtract 1MB so that we don't error for not having enough space
  SendMessage $CasperSlider ${TBM_SETRANGEMAX} 1 $RemainingSpace ; Re-Setting Max Value 
 ${EndIf} 
FunctionEnd

Function HaveSpacePre ; Check space required
 ${If} $FormatMe != "Yes" ; FIXME: Need to find a better method to check disk space when the drive appears unformatted (I.E. after it's been dd'd, etc).
 ${AndIf} $FormatMeFat != "Yes"
  Call CasperSize
  Call FreeDiskSpace
  System::Int64Op $1 > $SizeOfCasper ; Compare the space available > space required
  Pop $3 ; Get the result ...
  IntCmp $3 1 okay ; ... and compare it
  MessageBox MB_ICONSTOP|MB_OK "Oops: There is not enough disk space! $1 MB Free, $SizeOfCasper MB Needed on $JustDrive Drive."
  okay: ; Proceed to execute...
 ${EndIf}
FunctionEnd

Function HaveSpace ; Check space required
  Call CasperSize
  Call FreeDiskSpace
  System::Int64Op $1 > $SizeOfCasper ; Compare the space available > space required
  Pop $3 ; Get the result ...
  IntCmp $3 1 okay ; ... and compare it
  MessageBox MB_ICONSTOP|MB_OK "Not enough free space remains. Quitting ஐ-கருவி!"
  quit ; Close the program if the disk space was too small...
  okay: ; Proceed to execute...
  ;MessageBox MB_OK "ISO + Persistence will use $SizeOfCasper MB of the $1 MB Free disk space on $JustDrive Drive."  
  ;quit ; enable for testing message above
FunctionEnd

!macro DeleteMenuEntry file start stop
Push "${FILE}" ; File to search in
Push "${START}$\r$\n" ; text to start deleting from 
Push "${STOP}$\r$\n" ; text to stop at
Call DeleteMenuEntry
!macroend
!define DeleteMenuEntry "!insertmacro DeleteMenuEntry"

; DeleteMenuEntry function based on http://nsis.sourceforge.net/Delete_lines_from_one_line_to_another_line_inclusive.
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

; Custom Distros Installer - Uninstaller Include
!include "InstallDistro.nsh" ; ##################################### ADD NEW DISTRO ########################################
!include "RemoveDistro.nsh" ; ##################################### REM DISTRO ########################################

Function DoSyslinux ; Install கணிலினக்சு on USB
  ${IfNot} ${FileExists} "$BootDir\multiboot\libcom32.c32" 
  ${AndIf} ${FileExists} "$BootDir\multiboot\ldlinux.sys"   
  MessageBox MB_ICONEXCLAMATION|MB_OK $(WarningSyslinuxOLD)
  Quit
  ${EndIf}
  
  IfFileExists "$BootDir\multiboot\libcom32.c32" SkipSyslinux CreateSyslinux ; checking for newer கணிலினக்சு
  CreateSyslinux:
  CreateDirectory $BootDir\multiboot\menu ; recursively create the directory structure if it doesn't exist
  CreateDirectory $BootDir\multiboot\ISOS ; create ISOS folder  
  DetailPrint $(ExecuteSyslinux)
  ;ExecWait '$PLUGINSDIR\syslinux.exe -maf -d /multiboot $BootDir' $R8
  ;DetailPrint "கணிலினக்சு Errors $R8"
  nsExec::Exec '"$PLUGINSDIR\syslinux.exe" -maf -d /multiboot $BootDir'
  ;nsExec::Exec '"$PLUGINSDIR\syslinux.exe" -maf -d /multiboot $BootDir $BootDir\multiboot\syslinux.bin'
  Pop $R8
  DetailPrint "Syslinux Errors $R8"
  
  ${If} $R8 != 0
  MessageBox MB_ICONEXCLAMATION|MB_OK $(WarningSyslinux)
  ${EndIf} 
  DetailPrint "Creating Label TA on $DestDisk"
  nsExec::ExecToLog '"cmd" /c "LABEL $DestDiskTA"'
  
  SkipSyslinux: 
  DetailPrint $(SkipSyslinux)
  
   ${IfNot} ${FileExists} $BootDir\multiboot\linux.c32 ; need linux.c32 to launch wimboot from syslinux.  
    DetailPrint "Adding wimboot and linux.c32."   
    CopyFiles "$PLUGINSDIR\wimboot" "$BootDir\multiboot\wimboot"
    CopyFiles "$PLUGINSDIR\linux.c32" "$BootDir\multiboot\linux.c32"  
   ${EndIf}     

   ${IfNot} ${FileExists} $BootDir\multiboot\legacy-i ; legacy-i test file.  
    DetailPrint "Adding legacy-i test file."   
    CopyFiles "$PLUGINSDIR\legacy-i" "$BootDir\multiboot\legacy-i"  
   ${EndIf}
  
  ${If} ${FileExists} $BootDir\multiboot\syslinux.cfg    
   DetailPrint "A Previous MultiBoot Installation was detected."
   Call AddDir
  ${Else}
; Create and Copy files to your destination
  DetailPrint "Adding required files to the $BootDir\multiboot directory..." 
  CopyFiles "$PLUGINSDIR\syslinux.cfg" "$BootDir\multiboot\syslinux.cfg"
  CopyFiles "$PLUGINSDIR\உரிமை.உரை" "$BootDir\multiboot\உரிமை.உரை"
  CopyFiles "$PLUGINSDIR\vesamenu.c32" "$BootDir\multiboot\vesamenu.c32"
  CopyFiles "$PLUGINSDIR\menu.c32" "$BootDir\multiboot\menu.c32"  
  CopyFiles "$PLUGINSDIR\chain.c32" "$BootDir\multiboot\chain.c32"
  CopyFiles "$PLUGINSDIR\libcom32.c32" "$BootDir\multiboot\libcom32.c32"  
  CopyFiles "$PLUGINSDIR\libutil.c32" "$BootDir\multiboot\libutil.c32"      
  CopyFiles "$PLUGINSDIR\memdisk" "$BootDir\multiboot\memdisk"
  
  Call AddDir    
  ${EndIf}  
  
  ${IfNot} ${FileExists} $BootDir\multiboot\libutil.c32 ; Old Syslinux files need to be replaced
  DetailPrint "Adding required files to the $BootDir\multiboot directory..." 
  CopyFiles "$PLUGINSDIR\உரிமை.உரை" "$BootDir\multiboot\உரிமை.உரை"   
  CopyFiles "$PLUGINSDIR\vesamenu.c32" "$BootDir\multiboot\vesamenu.c32"
  CopyFiles "$PLUGINSDIR\menu.c32" "$BootDir\multiboot\menu.c32"  
  CopyFiles "$PLUGINSDIR\chain.c32" "$BootDir\multiboot\chain.c32"
  CopyFiles "$PLUGINSDIR\libcom32.c32" "$BootDir\multiboot\libcom32.c32"  
  CopyFiles "$PLUGINSDIR\libutil.c32" "$BootDir\multiboot\libutil.c32"   
  CopyFiles "$PLUGINSDIR\memdisk" "$BootDir\multiboot\memdisk"
 ${EndIf}    

; Check to ensure menu.c32 exists... now required for I V2
  ${IfNot} ${FileExists} $BootDir\multiboot\menu.c32
   DetailPrint "Adding menu.c32. Required for I V2"
   CopyFiles "$PLUGINSDIR\menu.c32" "$BootDir\multiboot\menu.c32" 
  ${EndIf}	  
FunctionEnd

Function AddDir ; changes to check if user had a version prior to 0.0.0.3. Newer I includes grub.exe 
 ${IfNotThen} ${FileExists} "$BootDir\multiboot\grub.exe" 'CopyFiles "$PLUGINSDIR\grub.exe" "$BootDir\multiboot\grub.exe"' 
									 
											 
								 
													
		  
FunctionEnd

; ---- Let's Do This Stuff ----
Section  ; This is the only section that exists
; Get just the name of the ISO file 
Push "$ISOFile"
Push 1
Call GrabNameOnly
Pop $NameThatISO

 ${If} ${FileExists} "$BootDir\windows\system32" ; Safeguard windows Installation.
 MessageBox MB_ICONSTOP|MB_OK "ABORTING! ($DestDisk) contains a WINDOWS/SYSTEM32 Directory."
 Quit
 ${EndIf}

; Wipe and Format ---
 ${If} $FormatMe == "Yes" 
  ${AndIf} $WipeMe == "Yes" 
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "எச்சரிக்கை: தொடர்வதற்கு முன் ($DestDisk)உடன் இணைக்கப்பட்ட அனைத்து பகிர்வுகளிலிருந்தும் உங்கள் தரவை காப்புப் பிரதி எடுக்கவும்! இணைக்கப்பட்ட இயக்கி எழுத்துக்கள், பகிர்வுகள் மற்றும் தொகுதிகள் உட்பட (வட்டு $DiskNum) உள்ள அனைத்து தரவும் மறைக்கப்பட்டிருந்தாலும் அழிக்கப்படும்.$\r$\n$\r$\n${NAME} பின்வரும் செயல்களைச் செய்ய தயாராக உள்ளது:$\r$\n$\r$\n1.) துடை (வட்டு $DiskNum) - தரவு மீளமுடியாமல் நீக்கப்படும்!$\r$\n$\r$\n2.) Recreate Drive Letter ($DestDisk) with a single NTFS partition.$\r$\n$\r$\n3.) ($DestDisk)இல் ஒரு கணிலினக்சு முதன்மை துவக்க பதிவு உருவாக்கும் - இருக்கும் முதன்மை துவக்க பதிவு மேலெழுதப்படும்!$\r$\n$\r$\n4.) ($DestDisk)இல் TA சிட்டை உருவாக்கவும் - இருக்கும் சிட்டை மேலெழுதப்படும்!$\r$\n$\r$\n5.) Install ($DistroName) on ($DestDisk)$\r$\n$\r$\n(வட்டு $DiskNum) சரியான யூ.எஸ்.பி சாதனம் என்பது உங்களுக்குத் தெரியுமா??$\r$\nஉறுதிப்படுத்த விண்டோஸ் வட்டு நிர்வாகத்துடன் இருமுறை சரிபார்க்கவும்!$\r$\n$\r$\nஇந்த செயல்களைச் செய்ய ஆம் என்பதை சொடுக்கவும் அல்லது கைவிட இல்லை சொடுக்கவும்!" IDYES proceed
  Quit
 ${ElseIf} $FormatMeFat == "Yes" 
  ${AndIf} $WipeMe == "Yes" 
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "எச்சரிக்கை: தொடர்வதற்கு முன் ($DestDisk)உடன் இணைக்கப்பட்ட அனைத்து பகிர்வுகளிலிருந்தும் உங்கள் தரவை காப்புப் பிரதி எடுக்கவும்! இணைக்கப்பட்ட இயக்கி எழுத்துக்கள், பகிர்வுகள் மற்றும் தொகுதிகள் உட்பட (வட்டு $DiskNum) உள்ள அனைத்து தரவும் மறைக்கப்பட்டிருந்தாலும் அழிக்கப்படும்.$\r$\n$\r$\n${NAME} பின்வரும் செயல்களைச் செய்ய தயாராக உள்ளது:$\r$\n$\r$\n1.) துடை (வட்டு $DiskNum) - தரவு மீளமுடியாமல் நீக்கப்படும்!$\r$\n$\r$\n2.) Recreate Drive Letter ($DestDisk) with a single Fat32 partition.$\r$\n$\r$\n3.) ($DestDisk)இல் ஒரு கணிலினக்சு முதன்மை துவக்க பதிவு உருவாக்கும் - இருக்கும் முதன்மை துவக்க பதிவு மேலெழுதப்படும்!$\r$\n$\r$\n4.) ($DestDisk)இல் TA சிட்டை உருவாக்கவும் - இருக்கும் சிட்டை மேலெழுதப்படும்!$\r$\n$\r$\n5.) Install ($DistroName) on ($DestDisk)$\r$\n$\r$\n(வட்டு $DiskNum) சரியான யூ.எஸ்.பி சாதனம் என்பது உங்களுக்குத் தெரியுமா?$\r$\nஉறுதிப்படுத்த விண்டோஸ் வட்டு நிர்வாகத்துடன் இருமுறை சரிபார்க்கவும்!$\r$\n$\r$\nஇந்த செயல்களைச் செய்ய ஆம் என்பதை சொடுக்கவும் அல்லது கைவிட இல்லை சொடுக்கவும்!" IDYES proceed
  Quit
  
; Format Only ---
 ${ElseIf} $FormatMe == "Yes" 
  ${AndIf} $WipeMe == "No" 
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "எச்சரிக்கை: தொடர்வதற்கு முன் ($DestDisk)உடன் இணைக்கப்பட்ட அனைத்து பகிர்வுகளிலிருந்தும் உங்கள் தரவை காப்புப் பிரதி எடுக்கவும்! ($DestDisk)உள்ள அனைத்து தரவும் மறைக்கப்பட்டிருந்தாலும் அழிக்கப்படும்.$\r$\n$\r$\n${NAME} பின்வரும் செயல்களைச் செய்ய தயாராக உள்ளது:$\r$\n$\r$\n1.) இயக்கி எழுத்து ($DestDisk)பூட்டு மற்றும் இறக்கு.$\r$\n$\r$\n2.) NTFS வடிவமை ($DestDisk) - ($DestDisk)கொண்டிருக்கும் தரவு மீளமுடியாமல் நீக்கப்படும்!$\r$\n$\r$\n3.) ($DestDisk)இல் ஒரு கணிலினக்சு முதன்மை துவக்க பதிவு உருவாக்கும் - இருக்கும் முதன்மை துவக்க பதிவு மேலெழுதப்படும்!$\r$\n$\r$\n4.) ($DestDisk)இல் TA சிட்டை உருவாக்கவும் - இருக்கும் சிட்டை மேலெழுதப்படும்!$\r$\n$\r$\n5.) Install ($DistroName) on ($DestDisk)$\r$\n$\r$\n ($DestDisk)(வட்டு $DiskNum) சரியான யூ.எஸ்.பி சாதனம் என்பது உங்களுக்குத் தெரியுமா?$\r$\nஉறுதிப்படுத்த விண்டோஸ் வட்டு நிர்வாகத்துடன் இருமுறை சரிபார்க்கவும்!$\r$\n$\r$\nஇந்த செயல்களைச் செய்ய ஆம் என்பதை சொடுக்கவும் அல்லது கைவிட இல்லை சொடுக்கவும்!" IDYES proceed
  Quit
 ${ElseIf} $FormatMeFat == "Yes" 
  ${AndIf} $WipeMe == "No" 
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "எச்சரிக்கை: தொடர்வதற்கு முன் ($DestDisk)உடன் இணைக்கப்பட்ட அனைத்து பகிர்வுகளிலிருந்தும் உங்கள் தரவை காப்புப் பிரதி எடுக்கவும்!$\r$\n$\r$\n${NAME} பின்வரும் செயல்களைச் செய்ய தயாராக உள்ளது:$\r$\n$\r$\n1.)இயக்கி எழுத்து ($DestDisk)பூட்டு மற்றும் இறக்கு.$\r$\n$\r$\n2.) Fat32 வடிவமை ($DestDisk) - ($DestDisk)கொண்டிருக்கும் தரவு மீளமுடியாமல் நீக்கப்படும்!$\r$\n$\r$\n3.) ($DestDisk)இல் ஒரு கணிலினக்சு முதன்மை துவக்க பதிவு உருவாக்கும் - இருக்கும் முதன்மை துவக்க பதிவு மேலெழுதப்படும்!$\r$\n$\r$\n4.) ($DestDisk)இல் TA சிட்டை உருவாக்கவும் - இருக்கும் சிட்டை மேலெழுதப்படும்!$\r$\n$\r$\n5.) Install ($DistroName) on ($DestDisk)$\r$\n$\r$\n($DestDisk)(வட்டு $DiskNum) சரியான யூ.எஸ்.பி சாதனம் என்பது உங்களுக்குத் தெரியுமா?$\r$\nஉறுதிப்படுத்த விண்டோஸ் வட்டு நிர்வாகத்துடன் இருமுறை சரிபார்க்கவும்!$\r$\n$\r$\nஇந்த செயல்களைச் செய்ய ஆம் என்பதை சொடுக்கவும் அல்லது கைவிட இல்லை சொடுக்கவும்!" IDYES proceed
   
		 
		 
																																																				
  Quit  
  
; Don't Wipe or Format ---
 ${ElseIf} $FormatMe != "Yes" 
  ${AndIf} $FormatMeFat != "Yes"
  ${AndIfNot} ${FileExists} $BootDir\multiboot\syslinux.cfg
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "${NAME} பின்வரும் செயல்களைச் செய்ய தயாராக உள்ளது:$\r$\n$\r$\n1. ($DestDisk)இல் ஒரு கணிலினக்சு முதன்மை துவக்க பதிவு உருவாக்கும் - இருக்கும் முதன்மை துவக்க பதிவு மேலெழுதப்படும்!$\r$\n$\r$\n2. ($DestDisk)இல் TA சிட்டை உருவாக்கவும் - இருக்கும் சிட்டை மேலெழுதப்படும்!$\r$\n$\r$\n3. Install ($DistroName) on ($DestDisk)$\r$\n$\r$\n($DestDisk)(வட்டு $DiskNum) சரியான யூ.எஸ்.பி சாதனம் என்பது உங்களுக்குத் தெரியுமா?$\r$\nஉறுதிப்படுத்த விண்டோஸ் வட்டு நிர்வாகத்துடன் இருமுறை சரிபார்க்கவும்!$\r$\n$\r$\nஇந்த செயல்களைச் செய்ய ஆம் என்பதை சொடுக்கவும் அல்லது கைவிட இல்லை சொடுக்கவும்!" IDYES proceed
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
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\I\pe.cfg"
  StrCpy $Config2Use "pe.cfg"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\I\unlisted.cfg"
  StrCpy $Config2Use "unlisted.cfg"  
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\I\menu.lst"
  StrCpy $Config2Use "menu.lst"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\I\vhd.lst"
  StrCpy $Config2Use "vhd.lst"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\I\grubpart4.lst"
  StrCpy $Config2Use "grubpart4.lst"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\I\grubram.lst"
  StrCpy $Config2Use "grubram.lst"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\I\win.lst"
  StrCpy $Config2Use "win.lst"  
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\I\win2go.lst"
  StrCpy $Config2Use "win2go.lst"   
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\I\pe.lst"
  StrCpy $Config2Use "pe.lst"  
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\I\hirens.lst"
  StrCpy $Config2Use "hirens.lst"    
  ${EndIf}
  ; MessageBox MB_OK "$Config2Use"
FunctionEnd

Function Config2Write
 ${If} $Config2Use == "linux.cfg"
  ${WriteToSysFile} "label Linux Distributions$\r$\nmenu label ஐ ->$\r$\nMENU INDENT 1$\r$\nCONFIG /multiboot/menu/linux.cfg" $R0 
 ${ElseIf} $Config2Use == "anon.cfg"
  ${WriteToSysFile} "label Anon $\r$\nmenu label அ ->$\r$\nMENU INDENT 1$\r$\nCONFIG /multiboot/menu/anon.cfg" $R0  
 ${ElseIf} $Config2Use == "system.cfg"
  ${WriteToSysFile} "label System Tools$\r$\nmenu label System Tools ->$\r$\nMENU INDENT 1$\r$\nCONFIG /multiboot/menu/system.cfg" $R0
 ${ElseIf} $Config2Use == "antivirus.cfg"
  ${WriteToSysFile} "label Antivirus Tools$\r$\nmenu label Antivirus Tools ->$\r$\nMENU INDENT 1$\r$\nCONFIG /multiboot/menu/antivirus.cfg" $R0 
 ${ElseIf} $Config2Use == "netbook.cfg"
  ${WriteToSysFile} "label Netbook Distributions$\r$\nmenu label Netbook Distributions ->$\r$\nMENU INDENT 1$\r$\nCONFIG /multiboot/menu/netbook.cfg" $R0 
 ${ElseIf} $Config2Use == "other.cfg"
  ${WriteToSysFile} "label Other OS and Tools$\r$\nmenu label Other OS and Tools ->$\r$\nMENU INDENT 1$\r$\nCONFIG /multiboot/menu/other.cfg" $R0 
 ${ElseIf} $Config2Use == "pe.cfg"
  ${WriteToSysFile} "label Windows PE$\r$\nmenu label Windows PE ->$\r$\nMENU INDENT 1$\r$\nCONFIG /multiboot/menu/pe.cfg" $R0   
 ${ElseIf} $Config2Use == "pe.lst"
  ${WriteToSysFile} "label Windows PE$\r$\nmenu label Windows PE ->$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/menu/pe.lst" $R0   
 ${ElseIf} $Config2Use == "hirens.lst"
  ${WriteToSysFile} "label Hiren's Boot CD PE$\r$\nmenu label Hiren's Boot CD PE ->$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/menu/hirens.lst" $R0    
 ${ElseIf} $Config2Use == "unlisted.cfg"
  ${WriteToSysFile} "label Unlisted ISOs (via SYSLINUX)$\r$\nmenu label  Unlisted ISOs (via SYSLINUX) ->$\r$\nMENU INDENT 1$\r$\nCONFIG /multiboot/menu/unlisted.cfg" $R0  
 ${ElseIf} $Config2Use == "menu.lst"
  ${WriteToSysFile} "label Unlisted ISOs (via GRUB)$\r$\nmenu label Unlisted ISOs (via GRUB) ->$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/menu/menu.lst" $R0 
 ${ElseIf} $Config2Use == "vhd.lst"
  ${WriteToSysFile} "label Unlisted ISOs (via Virtual Hard Disk)$\r$\nmenu label Unlisted ISOs (via Virtual Hard Disk) ->$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/menu/vhd.lst" $R0 
 ${ElseIf} $Config2Use == "grubpart4.lst"
  ${WriteToSysFile} "label Unlisted ISOs (via GRUB Partition 4)$\r$\nmenu label Unlisted ISOs (via GRUB Partition 4) ->$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/menu/grubpart4.lst" $R0
 ${ElseIf} $Config2Use == "grubram.lst"
  ${WriteToSysFile} "label Unlisted ISOs (via GRUB from RAM)$\r$\nmenu label Unlisted ISOs (via GRUB from RAM) ->$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/menu/grubram.lst" $R0   
 ${ElseIf} $Config2Use == "win.lst" 
  ${WriteToSysFile} "label Windows Installers$\r$\nmenu label Windows Installers ->$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/menu/win.lst" $R0  
 ${ElseIf} $Config2Use == "win2go.lst"
  ${WriteToSysFile} "label Windows to Go$\r$\nmenu label Windows to Go ->$\r$\nMENU INDENT 1$\r$\nKERNEL /multiboot/grub.exe$\r$\nAPPEND --config-file=/multiboot/menu/win2go.lst" $R0     
 ${EndIf} 
FunctionEnd

Function NoQuit
MessageBox MB_YESNO "$DestDisk இயக்ககத்தில் இப்போது மேலும் ஐஎஸ்ஓக்கள் / விநியோகங்களை சேர்க்க விரும்புகிறீர்களா?" IDYES noskip
    StrCmp $R8 3 0 End ;Compare $R8 variable with current page #
    StrCpy $R9 1 ; Goes to finish page
    Call RelGotoPage
    Abort
noskip:
;StrCpy $ShowAll "$ShowAll" ; Retain Display All Drives
StrCpy $DestDrive "$DestDrive" ; Retain previously selected Drive Letter
StrCpy $RepeatInstall "YES" ; Set Repeat Install Option to YES
StrCpy $ISOTest "" ; Reset
StrCpy $ISOFile "" ; Reset
StrCpy $Removal "" ; Reset
StrCpy $Persistence "NULL" ; Reset
StrCpy $NameThatISO "" ; Reset NameThatISO ISO Name
StrCpy $ConfigFile "" ; Clear ConfigFile 
StrCpy $Config2Use "" ; Clear Config File to create and write to
StrCpy $DistroName "" ; Clear Distro Name
StrCpy $ISOFileName "" ; Clear ISO Selection
StrCpy $FileFormat "" ; Clear File Format
StrCpy $DownloadMe 0 ; Ensure Uncheck of Download Option
StrCpy $LocalSelection "" ; Reset Local Selection
StrCpy $ShowingAll ""
StrCpy $FormatMe "" ; Reset Format Option
StrCpy $FormatMeFat "" ; Reset FormatMeFat Option
StrCpy $WipeMe "" ; Reset WipeMe Option
;StrCpy $DisMounted ""
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
 Messagebox MB_OK|MB_ICONINFORMATION "தற்போது நீங்கள் இந்த நிரலை $Authஆக இயக்க முயற்சிக்கிறீர்கள்$\r$\n$\r$\nநீங்கள் நிர்வாக உரிமைகளுடன் இந்த நிரலை இயக்க வேண்டும்...$\r$\n$\r$\nகோப்பில் வலது கிளிக் செய்து, நிர்வாகியாக இயக்கவும் அல்லது இயக்கவும் என்பதைத் தேர்ந்தெடுக்கவும் (மற்றும் நிர்வாகக் கணக்கைத் தேர்ந்தெடுக்கவும்)!"
 Abort
 done:
 SetShellVarContext all
 InitPluginsDir
  File /oname=$PLUGINSDIR\dskvol.txt "உரை\dskvol.txt" 
  File /oname=$PLUGINSDIR\diskpart.txt "உரை\diskpart.txt" 
  File /oname=$PLUGINSDIR\w2gdiskpart.txt "உரை\w2gdiskpart.txt"   
  File /oname=$PLUGINSDIR\dd-diskpart.txt "உரை\dd-diskpart.txt" 
  File /oname=$PLUGINSDIR\diskpartdetach.txt "உரை\diskpartdetach.txt"  
  File /oname=$PLUGINSDIR\autounattend.xml "உரை\autounattend.xml"   
  File /oname=$PLUGINSDIR\syslinux.exe "இருமங்கள்\syslinux.exe"  
  File /oname=$PLUGINSDIR\syslinux.cfg "பட்டியல்\syslinux.cfg"
  File /oname=$PLUGINSDIR\legacy-i "பட்டியல்\legacy-i"  
  File /oname=$PLUGINSDIR\menu.lst "பட்டியல்\menu.lst"  
  File /oname=$PLUGINSDIR\vhd.lst "பட்டியல்\vhd.lst" 
  File /oname=$PLUGINSDIR\grubpart4.lst "பட்டியல்\grubpart4.lst"  
  File /oname=$PLUGINSDIR\grubram.lst "பட்டியல்\grubram.lst"    
  File /oname=$PLUGINSDIR\win.lst "பட்டியல்\win.lst"  
  File /oname=$PLUGINSDIR\win2go.lst "பட்டியல்\win2go.lst"  
  File /oname=$PLUGINSDIR\grub.exe "இருமங்கள்\grub.exe"  
  File /oname=$PLUGINSDIR\info "பட்டியல்\info"   
  File /oname=$PLUGINSDIR\antivirus.cfg "பட்டியல்\antivirus.cfg" 
  File /oname=$PLUGINSDIR\system.cfg "பட்டியல்\system.cfg" 
  File /oname=$PLUGINSDIR\netbook.cfg "பட்டியல்\netbook.cfg"
  File /oname=$PLUGINSDIR\anon.cfg "பட்டியல்\anon.cfg"
  File /oname=$PLUGINSDIR\linux.cfg "பட்டியல்\linux.cfg" 
  File /oname=$PLUGINSDIR\unlisted.cfg "பட்டியல்\unlisted.cfg"
  File /oname=$PLUGINSDIR\other.cfg "பட்டியல்\other.cfg"   
  File /oname=$PLUGINSDIR\pe.cfg "பட்டியல்\pe.cfg"    
  File /oname=$PLUGINSDIR\pe.lst "பட்டியல்\pe.lst"  
  File /oname=$PLUGINSDIR\liveusb "இருமங்கள்\liveusb"
  File /oname=$PLUGINSDIR\7zG.exe "இருமங்கள்\7zG.exe"
  File /oname=$PLUGINSDIR\7z.dll "இருமங்கள்\7z.dll"  
  File /oname=$PLUGINSDIR\ஐ.png "படங்கள்\ஐ.png"
  File /oname=$PLUGINSDIR\உரிமை.உரை "உரை\உரிமை.உரை" 
  File /oname=$PLUGINSDIR\vesamenu.c32 "இருமங்கள்\vesamenu.c32" 
  File /oname=$PLUGINSDIR\menu.c32 "இருமங்கள்\menu.c32"    
  File /oname=$PLUGINSDIR\memdisk "இருமங்கள்\memdisk" 
  File /oname=$PLUGINSDIR\chain.c32 "இருமங்கள்\chain.c32" 
  File /oname=$PLUGINSDIR\libcom32.c32 "இருமங்கள்\libcom32.c32"  
  File /oname=$PLUGINSDIR\libutil.c32 "இருமங்கள்\libutil.c32"   
  File /oname=$PLUGINSDIR\linux.c32 "இருமங்கள்\linux.c32"  
  File /oname=$PLUGINSDIR\wimboot "இருமங்கள்\wimboot"   
  File /oname=$PLUGINSDIR\ifcpu64.c32 "இருமங்கள்\ifcpu64.c32" 
  File /oname=$PLUGINSDIR\remount.cmd "உரை\remount.cmd"  
  File /oname=$PLUGINSDIR\boot.cmd "உரை\boot.cmd"    
  File /oname=$PLUGINSDIR\vhdremount.cmd "உரை\vhdremount.cmd"    
  File /oname=$PLUGINSDIR\ei.cfg "பட்டியல்\ei.cfg"
  File /oname=$PLUGINSDIR\dd.exe "இருமங்கள்\dd.exe"
  File /oname=$PLUGINSDIR\fat32format.exe "இருமங்கள்\fat32format.exe"    
  SetOutPath "$PLUGINSDIR"  
  File /r "wimlib" 
  SetOutPath ""  
FunctionEnd

Function onNotify_CasperSlider
 Pop $Casper
 SendMessage $CasperSlider ${TBM_GETPOS} 0 0 $Casper ; Get Trackbar position
 ${NSD_SetText} $SlideSpot "$Casper MB"
FunctionEnd

Function SetISOSize ; Get size of ISO
 System::Call 'kernel32::CreateFile(t "$TheISO", i 0x80000000, i 1, i 0, i 3, i 0, i 0) i .r0'
 System::Call "kernel32::GetFileSizeEx(i r0, *l .r1) i .r2"
 System::Alloc $1
 System::Int64Op $1 / 1048576 ; convert to MB
 Pop $1
 StrCpy $SizeOfCasper "$1"
; MessageBox MB_OK|MB_ICONINFORMATION "ISO Size: $SizeOfCasper"
 System::Call 'kernel32::CloseHandle(i r0)'
FunctionEnd

Function GetFSType
System::Call 'Kernel32::GetVolumeInformation(t "$9",t,i ${NSIS_MAX_STRLEN},*i,*i,*i,t .r1" ,i ${NSIS_MAX_STRLEN}) i.r0'
 StrCpy $FSType "$1"
FunctionEnd