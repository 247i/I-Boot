Unicode True ; தமிழ் எழுத்து அதரவு 
;!execute 'ஐ-நி.கோ.ஒ.அ\இருமங்கள்\அகர.bat' ; zip if required.
;!execute '"$%WINDIR%\notepad.exe" /P "${NSISDIR}\COPYING"' ; Enable this to debug previous line. 
!define பெயர் "ஐ-நி.கோ.ஒ.அ"
!define பதிப்பு "0.0.3.3"
!define MUI_ICON "..\அகர\ஐ-காண்\வண்ணத்துப்பூச்சி.ico"

VIProductVersion "${பதிப்பு}"
VIAddVersionKey CompanyName "ஐ"
VIAddVersionKey LegalCopyright "உரிமை ©2021 ஐ"
VIAddVersionKey FileVersion "${பதிப்பு}"
VIAddVersionKey FileDescription "ஐ-உ.வி.நி.இ"
VIAddVersionKey License "இலவசம்"

Name "${பெயர்} ${பதிப்பு}"
OutFile "..\${பெயர்}-${பதிப்பு}.exe"
RequestExecutionLevel admin ;highest
SetCompressor /SOLID lzma
CRCCheck On
XPStyle on
ShowInstDetails show
BrandingText "${பெயர்} ${பதிப்பு}"
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
Var BDir
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
Var DistroPath
Var SomeFileExt
; Var AllDriveOption
; Var DisplayAll
Var DistroLink
Var Homepage
Var OfficialSite
Var OfficialName
Var NameThatISO
Var Uninstaller
Var Removal
Var InUnName
Var InUnStall
Var InUnStalling
Var InUnStalled
Var OnFrom
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
Var BOOT
Var BOOT_DISK
Var BOOT_LETTER
Var INST_DISK
Var IDR



!include துணை\ஒருங்குறிஉரை.நிரல்
!include துணை\கோப்பில்மாற்று.நிரல்
!include ஐ-நி.கோ.ஒ.அ\நிரல்கள்\துவக்கதட்டுஉரை.நிரல்

; இடைமுக அமைப்புகள்
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "..\அகர\அணிகலன்\யாதும் ஊரே-தலைப்பு.bmp" 
!define MUI_HEADERIMAGE_BITMAP_NOSTRETCH
!define MUI_HEADERIMAGE_RIGHT
; உரிம ஒப்பந்த ஒப்பந்தம் பக்கம்
!define MUI_TEXT_LICENSE_SUBTITLE $(License_Subtitle)
!define MUI_LICENSEPAGE_TEXT_TOP $(License_Text_Top)
!define MUI_LICENSEPAGE_TEXT_BOTTOM $(License_Text_Bottom)
!define MUI_PAGE_CUSTOMFUNCTION_PRE உரிமம்_முன்செயல்பாடு
!insertmacro MUI_PAGE_LICENSE "..\அகர\பகவன்\உரிமை.உரை"
; விநியோக தேர்வு பக்கம்
Page custom தேர்வுகள்பக்கம்
; கோப்புகளை நிறுவுக பக்கம்
!define MUI_INSTFILESPAGE_COLORS "00FF00 000000" ;Green and Black
!define MUI_INSTFILESPAGE_FINISHHEADER_TEXT $(Finish_Install)
!define MUI_TEXT_INSTALLING_TITLE $(Install_Title)
!define MUI_TEXT_INSTALLING_SUBTITLE $(Install_SubTitle)
!define MUI_TEXT_FINISH_SUBTITLE $(Install_Finish_Sucess)
!define MUI_PAGE_CUSTOMFUNCTION_PRE நிறுவும்கோப்புகள்_முன்செயல்பாடு
!insertmacro MUI_PAGE_INSTFILES
; முடிவு பக்கம்
!define MUI_FINISHPAGE_TITLE $(Finish_Title)
!define MUI_FINISHPAGE_TEXT $(Finish_Text)
!define MUI_FINISHPAGE_LINK $(Finish_Link)
!define MUI_FINISHPAGE_LINK_LOCATION "https://TamilNeram.github.io"
!define MUI_WELCOMEFINISHPAGE_BITMAP "..\அகர\அணிகலன்\சரி.bmp"
!define MUI_PAGE_CUSTOMFUNCTION_PRE முடித்தல்_முன்செயல்பாடு
!insertmacro MUI_PAGE_FINISH

; தமிழ் மொழி உரைகள்
!insertmacro MUI_LANGUAGE "Tamil" ; தமிழே முதல் மொழி
LangString License_Subtitle ${LANG_TAMIL} "தொடர்வதற்கு முன் உரிம விதிமுறைகளை மதிப்பாய்வு செய்யவும்"
LangString License_Text_Top ${LANG_TAMIL} "இந்த நிரலில் உள்ள மென்பொருள் பின்வரும் உரிமங்களின் கீழ் வருகிறது."
LangString License_Text_Bottom ${LANG_TAMIL} "இந்த ${பெயர்} பயன்பாட்டை இயக்க இந்த உரிம ஒப்பந்தத்தின் விதிமுறைகளை நீங்கள் ஏற்க வேண்டும். நீங்கள் ஒப்புக்கொண்டால், தொடர நான் ஒப்புக்கொள்கிறேன் என்பதைக் சொடுக்கு."
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
LangString ExecuteSyslinux ${LANG_TAMIL} "கணிலினக்சை $BDir மீது இயக்குகிறது"
LangString SkipSyslinux ${LANG_TAMIL} "நல்ல கணிலினக்சு உள்ளது..."
LangString WarningSyslinux ${LANG_TAMIL} "கணிலினக்சை இயக்கும் போது பிழை($R8) ஏற்பட்டது.$\r$\nமின்வெட்டொளி இயக்கி துவக்கப்படாது...$\r$\n$\r$\n$FSType கோப்பு முறைமை கண்டறியப்பட்டது. உங்கள் இயக்கி Fat32 அல்லது NTFS ஆக வடிவமைக்கப்பட வேண்டும்."
LangString WarningSyslinuxOLD ${LANG_TAMIL} "இந்த ஐ-கருவி திருத்தம் முந்தைய திருத்தங்களுடன் பொருந்தாத புதிய கணிலினக்சு பதிப்பைப் பயன்படுத்துகிறது.$\r$\nஉங்கள் யூ.எஸ்.பி டிரைவில் முந்தைய திருத்த நிறுவல்கள் இல்லை என்பதை உறுதிப்படுத்தவும்."
LangString Install_Title ${LANG_TAMIL} "$InUnName $InUnStalling"
LangString Install_SubTitle ${LANG_TAMIL} "நாங்கள்   $JustDrive $OnFrom $InUnName $InUnStall போது காத்திருக்கவும்"
LangString Install_Finish_Sucess ${LANG_TAMIL} "${பெயர்} $InUnStalled $InUnName $OnFrom $JustDrive"
LangString Finish_Install ${LANG_TAMIL} "செயல்முறை முடிந்தது."
LangString Finish_Title ${LANG_TAMIL} "${பெயர்} பயன்படுத்தியதற்கு நன்றி"
LangString Finish_Text ${LANG_TAMIL} "உங்கள் தேர்வுகள் மின்வெட்டொளியில் $InUnStalled .$\r$\n$\r$\nமேலும் விநியோகங்களை $InUnStall இந்த கருவியை மீண்டும் இயக்கவும்.$\r$\n$\r$\nஐ-கருவி நீங்கள் ஏற்கனவே $InUnStalled தேர்வுகளை கண்காணிக்கும்."
LangString Finish_Link ${LANG_TAMIL} "TamilNeram.github.io பக்கம் பார்க்க"

!include துணை\தவமுன்னேற்றம்.நிரல் ; நிலைத்தன்மை கோப்பை உருவாக்குதல் முன்னேற்றம்
!include துணை\ஒழுங்கமை.நிரல் ; பொதுவாக பயன்படுத்தும் நிரல்
!include துணை\சரம்மாற்று.நிரல் ; பொதுவாக பயன்படுத்தும் நிரல்
!include துணை\சரம்கொண்டுள்ளது.நிரல் ; Let's check if a * wildcard exists
!include துணை\உதநிகோப்புபெயர்கள்அமை.நிரல் ; Macro for FileNames
!include ஐ-நி.கோ.ஒ.அ\நிரல்கள்\கோப்புதிருத்தி.நிரல் ; Text File Manipulation
!include ஐ-நி.கோ.ஒ.அ\நிரல்கள்\விநியோகபட்டியல்.நிரல் ; List of Distributions
!include ஐ-நி.கோ.ஒ.அ\நிரல்கள்\புதையல்உரை.நிரல் ; For creation of Persistent Casper-rw files

Function உரிமம்_முன்செயல்பாடு
  StrCpy $R8 1 ;This is the 1st page
FunctionEnd

Function தேர்வுகள்பக்கம்
  StrCpy $R8 2
 !insertmacro MUI_HEADER_TEXT $(SelectDist_Title) $(SelectDist_Subtitle) 
  nsDialogs::Create 1018
  Pop $Dialog 

 ${If} $RepeatInstall == "YES"   
 ${NSD_SetText} $DestDriveTxt "$DestDrive"

; To Install or நிறுவல்நீக்கு? That is the question!  
  ${NSD_CreateCheckBox} 60% 0 44% 15 "நிறுவப்பட்டது?"
  Pop $Uninstaller
  ${NSD_OnClick} $Uninstaller நிறுவல்நீக்கு  
 ; Distro Selection Starts
  ${NSD_CreateLabel} 0 50 50% 15 $(Distro_Text) 
  Pop $LinuxDistroSelection   

  ${NSD_CreateDroplist} 0 70 55% 95 "" ; was  ${NSD_CreateListBox} ; Enable For DropBox
  Pop $Distro
  ${NSD_OnChange} $Distro விநியோகதேர்வில்
  ${NSD_CB_SelectString} $Distro $DistroName ; Was ${NSD_LB_SelectString} $Distro $DistroName  ; Enable For DropBox 
  
; Force Show All ISO Option
  ${NSD_CreateCheckBox} 80% 100 20% 15 "Show All ISOs?"
  Pop $ForceShowAll
  ${NSD_OnClick} $ForceShowAll அனைத்துஉதநிகாட்டு   

; ISO Download Option
  ${NSD_CreateCheckBox} 60% 60 40% 15 "Download the ISO (Optional)."
  Pop $DownloadISO
  ${NSD_OnClick} $DownloadISO DownloadIt  
  
; Clickable Link to Distribution Homepage  
  ${NSD_CreateLink} 60% 80 40% 15 "Visit the $OfficialName HomePage"
  Pop $DistroLink
  ${NSD_OnClick} $DistroLink லினக்சுதளசொடுக்த்தில்    

; ISO Selection Starts  
  ${NSD_CreateLabel} 0 100 100% 15 $(IsoPage_Text)
  Pop $LabelISOSelection
  ${NSD_CreateText} 0 120 78% 20 "Browse to and select the $FileFormat"
  Pop $ISOFileTxt 
  ${NSD_CreateBrowseButton} 85% 120 60 20 "Browse"
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
  ${NSD_OnNotify} $CasperSlider புதையல்நிலைமாற்றிஅறிவிப்பதில்    

; Drive Pre-Selection  
  ${NSD_CreateLabel} 0 0 58% 15 "" ; was 58%
  Pop $LabelDrivePage 
  ${NSD_SetText} $LabelDrivePage "Step 1: ஐ Summoned $DestDisk as your USB Device"  
; Droplist for Drive Selection  
  ${NSD_CreateDropList} 0 20 55% 15 "" ; was 0 20 15% 15 ; then was 28%
  Pop $DestDriveTxt
  
  ${GetDrives} "FDD+HDD" DrivesListRep ; All Drives Listed
  ${NSD_CB_SelectString} $DestDriveTxt "$DestDrive"
  StrCpy $9 $DestDrive 3
  StrCpy $JustDrive $9
  Call இயற்பியக்கி
  Call வட்டுதொகுதிபெயர்பெறு
  Call வட்டிடம்
  Call கோமுவகைபெறு
  StrCpy $JustDrive $DestDrive 3
  StrCpy $BDir $DestDrive 2 ;was -1 
  StrCpy $DestDisk $DestDrive 2 ;was -1
  SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; Clear all distro entries because a new drive may have been chosen ; Enable for DropBox
  StrCpy $Checker "YES"  
  Call InstallorRemove
  Call இடத்தைஅமை
  Call இடத்தைசரிபார்
  Call இதைவடிவமை 
  Call EnableNext 
  ${NSD_OnChange} $DestDriveTxt OnSelectDrive 
 ; MessageBox MB_ICONSTOP|MB_OK "$9 is on (Disk $DiskNum) or (Disk $INST_DISK) and $VolName with $Capacity and a $FSType filesystem" 


; Add Home Link
  ${NSD_CreateLink} 0 215 16% 15 "Home Page"
  Pop $Link
  ${NSD_OnClick} $LINK என்தளசொடுக்த்தில்    
  
; Add Help Link
  ${NSD_CreateLink} 16% 215 9% 15 "FAQ"
  Pop $Link1
  ${NSD_OnClick} $LINK1 அகேகேதளசொடுக்த்தில் 
  
; Add Giveback Link
  ${NSD_CreateLink} 25% 215 30% 15 "Recommended Flash Drives"
  Pop $Link2
  ${NSD_OnClick} $LINK2 என்உதொபேதளசொடுக்த்தில்   
 
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
  
; To Install or நிறுவல்நீக்கு? That is the question!  
  ${NSD_CreateCheckBox} 60% 0 44% 15 "View or Remove Installed Distros?"
  Pop $Uninstaller
  ${NSD_OnClick} $Uninstaller நிறுவல்நீக்கு  
  
; Drive Selection Starts  
  ${NSD_CreateLabel} 0 0 58% 15 ""    
  Pop $LabelDrivePage
  ${NSD_SetText} $LabelDrivePage "Step 1: Select the Drive Letter of your USB Device."    
  
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
  ${NSD_CreateCheckBox} 60% 23 100% 15 "Prepare and format (Drive $DiskNum)"
  Pop $Format
  ${NSD_OnClick} $Format இதைவடிவமை 

; EFI IOS
;  ${NSD_CreateCheckBox} 60% 43 100% 15 "Install EFI Bootable ISOs"
;  Pop $EFI
;  ${NSD_OnClick} $EFI ISOEFI  
 
; Distro Selection Starts
  ${NSD_CreateLabel} 0 50 50% 15 $(Distro_Text) 
  Pop $LinuxDistroSelection   

  ${NSD_CreateDropList} 0 70 55% 95 "" ; was ${NSD_CreateListBox} ; Enable for Dropbox
  Pop $Distro
  ${NSD_OnChange} $Distro விநியோகதேர்வில்
  ${NSD_CB_SelectString} $Distro $DistroName ; Was ${NSD_LB_SelectString} $Distro $DistroName  ; Enable For DropBox
  
; Force Show All ISO Option
  ${NSD_CreateCheckBox} 80% 100 20% 15 "Show All ISOs?"
  Pop $ForceShowAll
  ${NSD_OnClick} $ForceShowAll அனைத்துஉதநிகாட்டு    

; ISO Download Option
  ${NSD_CreateCheckBox} 60% 60 40% 15 "Download the ISO (Optional)."
  Pop $DownloadISO
  ${NSD_OnClick} $DownloadISO DownloadIt  
  
; Clickable Link to Distribution Homepage  
  ${NSD_CreateLink} 60% 80 40% 15 "Visit the $OfficialName HomePage"
  Pop $DistroLink
  ${NSD_OnClick} $DistroLink லினக்சுதளசொடுக்த்தில்    

; ISO Selection Starts  
  ${NSD_CreateLabel} 0 100 100% 15 $(IsoPage_Text)
  Pop $LabelISOSelection
  ${NSD_CreateText} 0 120 78% 20 "Browse to and select the $FileFormat"
  Pop $ISOFileTxt 
  ${NSD_CreateBrowseButton} 85% 120 60 20 "Browse"
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
  ${NSD_OnNotify} $CasperSlider புதையல்நிலைமாற்றிஅறிவிப்பதில்    
  
;; Add Help Link
;  ${NSD_CreateLink} 0 215 65% 15 "Click HERE to visit the ஐ page for additional info!"
;  Pop $Link
;  ${NSD_OnClick} $LINK என்தளசொடுக்த்தில்  

; Add Home Link
  ${NSD_CreateLink} 0 215 16% 15 "Home Page"
  Pop $Link
  ${NSD_OnClick} $LINK என்தளசொடுக்த்தில்    
  
; Add Help Link
  ${NSD_CreateLink} 16% 215 9% 15 "FAQ"
  Pop $Link1
  ${NSD_OnClick} $LINK1 அகேகேதளசொடுக்த்தில் 
  
; Add Giveback Link
  ${NSD_CreateLink} 25% 215 30% 15 "Recommended Flash Drives"
  Pop $Link2
  ${NSD_OnClick} $LINK2 என்உதொபேதளசொடுக்த்தில் 

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
  ShowWindow $ForceShowAll 0
  ShowWindow $Uninstaller 0
  nsDialogs::Show 
 ${EndIf}
FunctionEnd

Function நிறுவும்கோப்புகள்_முன்செயல்பாடு
  StrCpy $R8 3
FunctionEnd

Function முடித்தல்_முன்செயல்பாடு
  StrCpy $R8 4
  Call வெளியேறாதே
FunctionEnd

Function ListAllDrives ; Set to Display All Drives
  SendMessage $DestDriveTxt ${CB_RESETCONTENT} 0 0 
   ${GetDrives} "FDD+HDD" DrivesList ; All Drives Listed  
FunctionEnd

Function என்தளசொடுக்த்தில்
  Pop $Links ; pop something to prevent corruption
  ExecShell "open" "https://TamilNeram.github.io"
FunctionEnd

Function அகேகேதளசொடுக்த்தில்
  Pop $Links1 ; pop something to prevent corruption
  ExecShell "open" "https://TamilNeram.github.io"
FunctionEnd

Function என்உதொபேதளசொடுக்த்தில்
  Pop $Links2 ; pop something to prevent corruption
  ExecShell "open" "https://TamilNeram.github.io"
FunctionEnd

Function லினக்சுதளசொடுக்த்தில்
  Pop $OfficialSite 
  ExecShell "open" "$Homepage"
FunctionEnd

Function DownloadIt ; Set Download Option
  ${NSD_GetState} $DownloadISO $DownloadMe
  ${If} $DownloadMe == ${BST_CHECKED}
  ${NSD_Check} $DownloadISO
  ${NSD_SetText} $DownloadISO "Opened Download Link"
  Call DownloadLinks
  ${ElseIf} $DownloadMe == ${BST_UNCHECKED}
  ${NSD_Uncheck} $DownloadISO 
  ${NSD_SetText} $DownloadISO "Download Link" 
  ${EndIf}  
FunctionEnd

Function EnableNext ; Enable Install Button
  ${If} $Blocksize >= 4 
  ${AndIf} $Removal != "YES"
  ShowWindow $Format 1 
  ${Else}
  ShowWindow $Format 0
  ${EndIf}
  ${If} $Removal != "YES"    
   ${AndIf} $ISOFileName != ""
    ${AndIf} $ISOFile != ""
     ${AndIf} $DestDrive != "" 
	  ${AndIf} $ISOTest != ""
  StrCpy $InUnStall "Add"	
   StrCpy $InUnStalling "Adding"	
    StrCpy $InUnStalled "Added"	
  StrCpy $OnFrom "to"
  StrCpy $InUnName "$JustISOName"  
  GetDlgItem $6 $HWNDPARENT 1 ; Get "Install" control handle
   SendMessage $6 ${WM_SETTEXT} 0 "STR:Create"
    EnableWindow $6 1 ; Enable "Install" control button

  ${ElseIf} $Removal == "YES"
   ${AndIf} $ISOFileName != ""
     ${AndIf} $DestDrive != "" 
	  ${AndIf} $ISOTest != ""
  StrCpy $InUnStall "Remove"	
   StrCpy $InUnStalling "Removing"	
    StrCpy $InUnStalled "Removed"	  
  StrCpy $OnFrom "from"	
  StrCpy $InUnName "$DistroName"
  GetDlgItem $6 $HWNDPARENT 1 ; Get "Install" control handle
   SendMessage $6 ${WM_SETTEXT} 0 "STR:Remove"
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
  ${AndIf} $Removal != "YES"
  EnableWindow $LabelISOSelection 1 
  EnableWindow $ISOFileTxt 1  
  ShowWindow $ISOSelection 1
  
  ${AndIf} $Removal == "YES"
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
  ${AndIf} $BDir != "" 
  ShowWindow $CasperSelection 1
  ShowWindow $CasperSlider 1
  ShowWindow $SlideSpot 1
  ;${NSD_SetText} $Format "Format $JustDrive Drive (Erases Content)"  
	
; Else If not using Casper Persistence...  
  ${ElseIf} $Persistence != "casper" ; Eventually change to "NULL"
  ${OrIf} $Removal == "YES"  
  ShowWindow $CasperSelection 0
  ShowWindow $CasperSlider 0 
  ShowWindow $SlideSpot 0
  ;${NSD_SetText} $Format "Format $JustDrive Drive (Erases Content)" 
  ${EndIf}    
FunctionEnd

Function DownloadLinks
MessageBox MB_YESNO|MB_ICONQUESTION "Launch the Download Link?$\r$\nLet the download finish before moving to step 2." IDYES DownloadIt IDNO Skip
  Skip: ; Reset Download Checkbox Options 
  ${NSD_Uncheck} $DownloadISO 
  ${NSD_SetText} $DownloadISO "Download Link"  
  EnableWindow $DownloadISO 1
  Goto end
  DownloadIt:
  ${NSD_SetText} $LabelISOSelection "Step 3: Once your download has finished, Browse and select the ISO."  
  EnableWindow $DownloadISO 0
  ExecShell "open" "$DownLink"    
  end:
FunctionEnd

Function LocalISODetected ; The script autodetected the ISO, so let's do the following
 ${If} $DownloadMe != ${BST_CHECKED}
 ${AndIf} $LocalSelection != "YES"
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

; On Selection of Linux Distro
Function விநியோகதேர்வில்
  Pop $Distro
  
  ${If} $Removal == "YES"
   ShowWindow $ForceShowAll 0
  ${Else}
   ShowWindow $ForceShowAll 1
  ${EndIf}
  
  ${NSD_GetText} $Distro $DistroName ; Was ${NSD_LB_GetSelection} $Distro $DistroName 
  StrCpy $DistroName "$DistroName"   
  StrCpy $Checker "No" 
  ${If} $Removal == "YES"
  StrCpy $ISOFileName "$DistroName" 
  StrCpy $ISOTest "$DistroName"  
  ${Else} 
  Call உதநிகோப்புபெயர்அமை
  StrCpy $ISOFileName "$ISOFileName" 
  StrCpy $SomeFileExt "$ISOFileName" "" -3 ; Grabs the last 3 characters of the file name... zip or iso?
  StrCpy $FileFormat "$SomeFileExt" ; Set file type to look for zip, tar, iso etc...
  ${NSD_SetText} $LabelISOSelection "Step 3: Browse and Select your $ISOFileName"
  ${NSD_SetText} $ISOFileTxt "Browse to your $ISOFileName  -->"
  SetCtlColors $ISOFileTxt FF0000 FFFFFF  
  StrCpy $ISOTest "" ; Set to null until a new ISO selection is made
  ${EndIf}
  
; Redraw Home page Links as necessary
  ${NSD_SetText} $DistroLink "Visit the $OfficialName Home Page" 
  ShowWindow $DistroLink 0
  ${If} $OfficialName == ""
   ${OrIf} $Removal == "YES"
  ShowWindow $DistroLink 0
  ${Else}
  ShowWindow $DistroLink 1
  ${EndIf}    
  
; Autodetect ISO's in same folder and select if they exist  
 ${If} ${FileExists} "$EXEDIR\$ISOFileName"
 ${AndIf} $Removal != "YES"
 ${சரம்கொண்டுள்ளது} $WILD "*" "$ISOFileName" ; Check for Wildcard and force Browse if * exists.
 ${AndIf} $WILD != "*"  
  StrCpy $TheISO "$EXEDIR\$ISOFileName"
  StrCpy $ISOFile "$TheISO"  
  ${GetFileName} "$TheISO" $JustISO
  ${GetBaseName} "$JustISO" $JustISOName
 ${சரம்மாற்று} '$JustISOName' '$JustISOName' ' ' '-'  
  ${GetParent} "$TheISO" $JustISOPath  
  EnableWindow $DownloadISO 0
  ${NSD_SetText} $DownloadISO "We Found and Selected the $SomeFileExt."    
  EnableWindow $ISOSelection 0 
  SetCtlColors $ISOFileTxt 009900 FFFFFF  
  ${NSD_SetText} $ISOFileTxt $ISOFile 
  ${NSD_SetText} $LabelISOSelection "Step 3 DONE: $ISOFileName Found and Selected!"  
  StrCpy $ISOTest "$TheISO" ; Populate ISOTest so we can enable Next    
  Call EnableNext  
  
 ${ElseIf} ${FileExists} "$EXEDIR\$ISOFileName"
 ${AndIf} $Removal != "YES"
 ${AndIf} $WILD == "*" 
  EnableWindow $DownloadISO 1
  EnableWindow $ISOSelection 1
  ${NSD_Uncheck} $DownloadISO  
  ${NSD_SetText} $DownloadISO "Download Link"       
  SetCtlColors $ISOFileTxt FF9B00 FFFFFF  
  ${NSD_SetText} $ISOFileTxt "Browse to and select the $ISOFileName" 
  ${NSD_SetText} $LabelISOSelection "Step 3 PENDING: Browse to your $ISOFileName"    
  Call EnableNext  
  
 ${Else}
  Call EnableNext
  EnableWindow $DownloadISO 1
  EnableWindow $ISOSelection 1
  ${NSD_Uncheck} $DownloadISO  
  ${NSD_SetText} $DownloadISO "Download Link"   
 ${EndIf}  
 
 ${If} $DownLink == "NONE"
  ${OrIf} $Removal == "YES"
  ShowWindow $DownloadISO 0
 ${Else}
  ShowWindow $DownloadISO 1
 ${EndIf}
  
FunctionEnd 

; On Selection of ISO File
Function ISOBrowse
 ${If} $ShowingAll == "YES"
  StrCpy $ISOFileName "*.iso" 
 ${ElseIf} $ShowingAll != "YES"
  Call உதநிகோப்புபெயர்அமை
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
  ${சரம்மாற்று} '$JustISO' '$JustISO' ' ' '-'
 ${GetBaseName} "$JustISO" $JustISOName
 ${சரம்மாற்று} '$JustISOName' '$JustISOName' ' ' '-'
 ${GetParent} "$TheISO" $JustISOPath
 StrCpy $LocalSelection "YES"
  Call உதநிஅளவைஅமை
  Call இடத்தைஅமை
  Call இடத்தைசரிபார்
  Call இடமிருக்குமுன்
 ${If} $JustISOName == "" 
 StrCpy $JustISOName "NULL" ; Set to NULL until something is selected
 ${EndIf}
 
 ${If} ${FileExists} "$BDir\!\$JustISOName\*.*"
 ${AndIf} $JustISOName != ""
 ${AndIf} $FormatMe != "YES"
 ${AndIf} ${FileExists} "$BDir\!\menu\ஐ-EXFAT"
  MessageBox MB_OK "$JustISOName is already on $DestDisk$\r$\nPlease Remove it first!"
 ${Else}
 ${EndIf}
 Call EnableNext
 ; Uncomment for Testing --> MessageBox MB_ICONQUESTION|MB_OK 'Removal: "$Removal"  ISOFileName: "$ISOFileName" ISOFile "$ISOFile" BDir: "$BDir" DestDisk: "$DestDisk" DestDrive: "$DestDrive" ISOTest: "$ISOTest"'
 FunctionEnd

Function ClearAll
StrCpy $ISOTest ""
StrCpy $DistroName "" ; Clear Distro Name
StrCpy $ISOFileName "" ; Clear ISO Selection
StrCpy $SomeFileExt ""
StrCpy $FileFormat ""
FunctionEnd

Function InstallorRemove ; Populate DistroName based on Install/Removal option
  ${If} $Removal == "YES" 
  Call அகற்றும்பட்டியல்
  ${Else}
   ${NSD_SetText} $LinuxDistroSelection "Step 2: Select a Distribution to put on $DestDisk" 
  Call உதநிகோப்புபெயர்அமை
  ${EndIf}
FunctionEnd  

; On Selection of Uninstaller Option
Function நிறுவல்நீக்கு
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
  StrCpy $Removal "YES"
  ShowWindow $DistroLink 0
  ShowWindow $DownloadISO 0
   GetDlgItem $6 $HWNDPARENT 1 ; Get "Install" control handle
	SendMessage $6 ${WM_SETTEXT} 0 "STR:Remove"
	EnableWindow $6 0 ; Disable "Install" control button
   ${NSD_SetText} $Uninstaller "You're in Uninstaller Mode!"
   ${NSD_SetText} $LinuxDistroSelection "Step 2: Select a Distribution to remove from $DestDisk"  
    SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; Clear all distro entries because a new option may have been chosen ; Enable for DropBox
     StrCpy $Checker "YES"   
	 Call அகற்றும்பட்டியல்

  ${ElseIf} $Removal == ${BST_UNCHECKED}
   ShowWindow $Format 1  
    ShowWindow $LabelISOSelection 1 
    ShowWindow $ISOFileTxt 1
	ShowWindow $ISOSelection 0
	Call ClearAll
    ${NSD_SetText} $LabelISOSelection "Step 3: Select your $ISOFileName"
	${NSD_SetText} $ISOFileTxt "Disabled until step 2 is complete"
     GetDlgItem $6 $HWNDPARENT 1 ; Get "Install" control handle
	  SendMessage $6 ${WM_SETTEXT} 0 "STR:Create"
	  EnableWindow $6 0 ; Disable "Install" control button
    ${NSD_Uncheck} $Uninstaller  
     StrCpy $Removal "No"  
    ${NSD_SetText} $Uninstaller "View or Remove Installed Distros?" 
    ${NSD_SetText} $LinuxDistroSelection "Step 2: Select a Distribution to put on $DestDisk" 
     SendMessage $Distro ${CB_RESETCONTENT} 0 0  ; Clear all distro entries because a new option may have been chosen ; Enable for DropBox
     StrCpy $Checker "YES"         
     Call உதநிகோப்புபெயர்அமை
  ${EndIf}  
FunctionEnd

; On Selection of USB Drive
Function OnSelectDrive
  Pop $DestDriveTxt
  ${NSD_GetText} $DestDriveTxt $Letters
  StrCpy $DestDrive "$Letters"
  StrCpy $JustDrive $DestDrive 3  
  StrCpy $BDir $DestDrive 2 ;was -1 
  StrCpy $DestDisk $DestDrive 2 ;was -1

  Call இயற்பியக்கி
  StrCpy $INST_DISK "$DiskNum" ; save Install Disk Number in case we need it again later
  Call கோமுவகைபெறு

; Check if drive is already setup for ஐ-EXFAT
 ${IfNot} ${FileExists} "$BDir\!\ஐ-EXFAT"
  ${If} $RepeatInstall != "YES"
   MessageBox MB_YESNO|MB_ICONQUESTION "$BDir has not been prepared for this version of ஐ UEFI.$\r$\n$\r$\nDo you want ஐ to Prepare and format (Disk $INST_DISK)?" IDYES checkit
   StrCpy $FormatMe ""
   ${NSD_SetState} $FormatMe ${BST_UNCHECKED}
   ${NSD_Uncheck} $Format
   ;MessageBox MB_ICONSTOP|MB_OK "UNCHECKED"
   Goto skipper
   checkit:
   StrCpy $FormatMe ""
   ${NSD_SetState} $FormatMe ${BST_CHECKED} 
   ${NSD_Check} $Format
   ;MessageBox MB_ICONSTOP|MB_OK "CHECKED"
   skipper:
  ${Endif}
 ${Endif}
 
  SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; Clear all distro entries because a new drive may have been chosen ; Enable for DropBox
  StrCpy $Checker "YES" 
  Call InstallorRemove
  Call இடத்தைஅமை
  Call இடத்தைசரிபார்
  Call இதைவடிவமை  
  Call EnableNext
 
  ${NSD_SetText} $LabelDrivePage "Step 1: You Selected $DestDisk (Disk $DiskNum) as your USB Device"   
FunctionEnd

Function வட்டுதொகுதிபெயர்பெறு
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
FunctionEnd 

Function வட்டிடம்
${DriveSpace} "$9" "/D=T /S=G" $1 ; used to find total space of each drive
${If} $1 > "0"
 StrCpy $Capacity "$1GB"
${Else}
 StrCpy $Capacity ""
${EndIf}
FunctionEnd

Function DrivesList
 StrCpy $JustDrive $9
 Call இயற்பியக்கி
 Call வட்டுதொகுதிபெயர்பெறு
 Call வட்டிடம்
 Call கோமுவகைபெறு
;Prevent System Drive from being selected
 StrCpy $7 $WINDIR 3
 ${If} $9 != "$7" 
 ${AndIf} $Capacity != ""
 SendMessage $DestDriveTxt ${CB_ADDSTRING} 0 "STR:$9 (Disk $DiskNum) $VolName $Capacity $FSType" ;$8
   ${சரம்கொண்டுள்ளது} $BOOT "TEMPஐ" "$VolName" ; does the string contain the TEMPஐ Label? - This label is only set during initial 2nd partition creation.
   ${If} $BOOT == "TEMPஐ" ; if so do something
   StrCpy $BOOT_LETTER "$9" -1 ; copy the Drive Letter for later use in locating and writing to the BOOT partition
   StrCpy $BOOT_DISK "$DiskNum" ; copy the Disk Number for later use in locating the right BOOT partition
   ;MessageBox MB_ICONSTOP|MB_OK "$9 - (Disk $DiskNum) - $VolName |$BOOT|"
   ${EndIf}
 ${EndIf}
 Push 1 ; must push something - see GetDrives documentation   
FunctionEnd

Function DrivesListRep
Var /Global DiskYum
 StrCpy $JustDrive $9
 Call இயற்பியக்கி
 Call வட்டுதொகுதிபெயர்பெறு
 Call வட்டிடம்
 Call கோமுவகைபெறு
;Prevent System Drive from being selected
 StrCpy $7 $WINDIR 3
 ${If} $9 != "$7" 
 ${AndIf} $Capacity != ""
   ${சரம்கொண்டுள்ளது} $IDR "ஐ" "$VolName" ; does the string contain the ஐ Label?
   ${If} $IDR == "ஐ" ; if so add string
   ${சரம்கொண்டுள்ளது} $DiskYum "$INST_DISK" "$DiskNum" ; does the string contain the right Disk Number?
   ${AndIf} $DiskYum == "$INST_DISK" ; if so add string
    SendMessage $DestDriveTxt ${CB_ADDSTRING} 0 "STR:$9 (Disk $DiskNum) $VolName $Capacity $FSType" ;$8
	; MessageBox MB_ICONSTOP|MB_OK "$9 - (Disk $DiskNum) - $VolName - $Capacity - $FSType ||||$BOOT - (Disk $BOOT_DISK)||||"
	${Else}
	; MessageBox MB_ICONSTOP|MB_OK "NOT ADDING STRING"
   ${EndIf}
 ${EndIf}
 Push 1 ; must push something - see GetDrives documentation  
FunctionEnd

Function DrivesListBoot
 StrCpy $JustDrive $9
 Call இயற்பியக்கி
 Call வட்டுதொகுதிபெயர்பெறு
 Call வட்டிடம்
 Call கோமுவகைபெறு
;Prevent System Drive from being selected
 StrCpy $7 $WINDIR 3
 ${If} $9 != "$7" 
   ${If} "$VolName" == "TEMPஐ" ; does $VolName contain the TEMPஐ Label? - This label is only set during initial 2nd partition creation.
   ${AndIf} $DiskNum == "$INST_DISK" ; if so add string
    ;StrCpy $BOOT_LETTER_FULL "$9" #The letter and :/   
    StrCpy $BOOT_LETTER "$9" 2 #Just the letter and :
    ;SendMessage $DestDriveTxt ${CB_ADDSTRING} 0 "STR:$9 (Disk $DiskNum) $VolName $Capacity $FSType" ;$8
    ;MessageBox MB_ICONSTOP|MB_OK "$9 - (Disk $DiskNum) - $VolName - $Capacity - $FSType ||||$BOOT - (Drive Letter: $BOOT_LETTER)||||  --> $INST_DISK" 
  ; Do Stuff here for Boot partition. copy over boot files.... create MBR
    Call DoMBR ; make it bootable
    DetailPrint "Creating the Label BOOT on $BOOT_LETTER"
    nsExec::ExecToLog '"cmd" /c "LABEL $BOOT_LETTERBOOT"' ; set the second fat partition label to BOOT
    nsExec::ExecToLog '"DiskPart" /S $PLUGINSDIR\unassign.txt' ; unassign the BOOT partition so it doesn't get in the way  
      
   ${Else}
	; MessageBox MB_ICONSTOP|MB_OK "NOT ADDING STRING"
   ${EndIf}
 ${EndIf}
 Push 1 ; must push something - see GetDrives documentation  
FunctionEnd


Function ஆம்வடிவமை ; If Format is checked, do something
  SetShellVarContext all
  InitPluginsDir
  File /oname=$PLUGINSDIR\diskpartwipe1.txt "இருமங்கள்\நி\diskpartwipe1.txt"  
  File /oname=$PLUGINSDIR\diskpartwipe2.txt "இருமங்கள்\நி\diskpartwipe2.txt" 
  File /oname=$PLUGINSDIR\unassign.txt "இருமங்கள்\நி\unassign.txt"     
  
  !insertmacro கோப்பில்மாற்று "DISKNUM" "$DiskNum" "all" "all" "$PLUGINSDIR\diskpartwipe1.txt"  
  !insertmacro கோப்பில்மாற்று "DSK" "$DestDisk" "all" "all" "$PLUGINSDIR\diskpartwipe2.txt" 
  !insertmacro கோப்பில்மாற்று "DISKNUM" "$DiskNum" "all" "all" "$PLUGINSDIR\diskpartwipe2.txt"   
  !insertmacro கோப்பில்மாற்று "DISKNUM" "$DiskNum" "all" "all" "$PLUGINSDIR\unassign.txt"  

 ${If} $FormatMe == "YES"
 ; MessageBox MB_ICONSTOP|MB_OK "Prepare and format (Disk $DiskNum) is checked."

; Wipes the Disk # and reformats it with two partitions (1st exFAT and 2nd fat)
    nsExec::ExecToLog '"DiskPart" /S $PLUGINSDIR\diskpartwipe1.txt' 
	Sleep 1000
	nsExec::ExecToLog '"DiskPart" /S $PLUGINSDIR\diskpartwipe2.txt'
	
	; call and use a new DrivesListBoot function... only show drives with the TEMPஐ label that match disk
   ${GetDrives} "FDD+HDD" DrivesListBoot ; probe for the BOOT disk number and letter... since we just wiped and recreated partitions on the disk.
	;MessageBox MB_ICONSTOP|MB_OK "BOOT --> $BOOT_LETTER (Disk $BOOT_DISK) | ஐ --> $DestDisk (Disk $INST_DISK)" ; checkpoint
	
 ${Endif}	 
  ;${If} $FormatMe == "YES"
   ;Call Lock_Only ; Just get a lock on the Volume 
   ;Sleep 3000
   ;nsExec::ExecToLog '"cmd" /c "echo y|$PLUGINSDIR\fat32format $DestDisk"' ;/Q /y
   ;Call UnLockVol ; Unlock to allow Access   
  ;${EndIf} 
FunctionEnd

Function இதைவடிவமை ; Set Format Option
  ${NSD_GetState} $Format $FormatMe
  ${If} $FormatMe == ${BST_CHECKED}
  ${NSD_Check} $Format
    StrCpy $FormatMe "YES"
  ${NSD_SetText} $Format "Prepare and Format (Disk $DiskNum)!"
    SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; Clear all distro entries because a new format option may have been chosen ; Enable for DropBox
	ShowWindow $Uninstaller 0 ; Disable Uninstaller option because we will be formatting the drive.
    StrCpy $Checker "YES"	
  
  ${ElseIf} $FormatMe == ${BST_UNCHECKED}
  ${NSD_Uncheck} $Format
  StrCpy $FormatMe "NO"
  ${NSD_SetText} $Format "Prepare and Format (Disk $DiskNum)?"  
    SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; Clear all distro entries because a new format option may have been chosen ; Enable for DropBox
	${If} ${FileExists} "$BDir\!\ஐ-EXFAT"
     ShowWindow $Uninstaller 1 ; Re-enable Uninstaller option.
	${EndIf}
	StrCpy $Checker "YES" 
	Call இடத்தைஅமை
  ${EndIf}  
    Call InstallorRemove
FunctionEnd

Function அனைத்துஉதநிகாட்டு ; Set Show All ISOs Option
  ${NSD_GetState} $ForceShowAll $ShowingAll
  ${If} $ShowingAll == ${BST_CHECKED}
  ${NSD_Check} $ForceShowAll
  StrCpy $ShowingAll "YES"
  ${NSD_SetText} $ForceShowAll "உதநிகள்!"
    SendMessage $ISOSelection ${CB_RESETCONTENT} 0 0 
 
  ${ElseIf} $ShowingAll == ${BST_UNCHECKED}
  ${NSD_Uncheck} $ForceShowAll
  ${NSD_SetText} $ForceShowAll "உதநிகள்?"  
    SendMessage $ISOSelection ${CB_RESETCONTENT} 0 0 
  ${EndIf}  
FunctionEnd

Function இடத்தைசரிபார் ; Check total available space so we can set block size
  Call மொத்தஇடம்
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

Function மொத்தஇடம்
${DriveSpace} "$JustDrive" "/D=T /S=M" $1 ; used to find total space of select disk
 StrCpy $Capacity "$1"
FunctionEnd

Function மீதமுள்ளவட்டுஇடம்
${If} $FormatMe == "YES"
${DriveSpace} "$JustDrive" "/D=T /S=M" $1
${Else}
${DriveSpace} "$JustDrive" "/D=F /S=M" $1
${EndIf}
FunctionEnd

Function இடத்தைஅமை ; Set space available for persistence
 ${If} $FSType != "NTFS"
 ${AndIf} $FSType != "exFAT"
  Call மீதமுள்ளவட்டுஇடம்
  StrCpy $MaxPersist 4090 ; Space required for a 4GB max persistent file
   ${If} $1 > $MaxPersist ; Check if more space is available than we need for 4GB persistent file
   StrCpy $RemainingSpace 4090 ; Set maximum possible value to 4090 MB (any larger wont work on fat32 Filesystem)
   ${Else}
   StrCpy $RemainingSpace "$1"
   ${EndIf}
 ${Else}  
  Call மீதமுள்ளவட்டுஇடம்
  StrCpy $MaxPersist 10240 ; Space required for 10GB max persistent file
   ${If} $1 > $MaxPersist ; Check if more space is available than we need for a 20GB persistent file
   StrCpy $RemainingSpace 10240 ; Set maximum possible value to 10240 MB (10GB)
   ${Else}
   StrCpy $RemainingSpace "$1"
   ${EndIf}
 ${EndIf} 
   IntOp $RemainingSpace $RemainingSpace - 1 ; Subtract 1MB so that we don't error for not having enough space
   SendMessage $CasperSlider ${TBM_SETRANGEMAX} 1 $RemainingSpace ; Re-Setting Max Value 
FunctionEnd

Function இடமிருக்குமுன் ; Check space required
  Call புதையல்அளவு
  Call மீதமுள்ளவட்டுஇடம்
  System::Int64Op $1 > $SizeOfCasper ; Compare the space available > space required
  Pop $3 ; Get the result ...
  IntCmp $3 1 okay ; ... and compare it
  MessageBox MB_ICONSTOP|MB_OK "Oops: There is not enough disk space! $1 MB Free, $SizeOfCasper MB Needed on $JustDrive Drive."
  okay: ; Proceed to execute...
FunctionEnd

Function இடமிருக்கு ; Check space required
  Call புதையல்அளவு
  Call மீதமுள்ளவட்டுஇடம்
  System::Int64Op $1 > $SizeOfCasper ; Compare the space available > space required
  Pop $3 ; Get the result ...
  IntCmp $3 1 okay ; ... and compare it
  MessageBox MB_ICONSTOP|MB_OK "Not enough free space remains. Quitting ஐ!"
  quit ; Close the program if the disk space was too small...
  okay: ; Proceed to execute...
  ;MessageBox MB_OK "ISO + Persistence will use $SizeOfCasper MB of the $1 MB Free disk space on $JustDrive Drive."  
  ;quit ; enable for testing message above
FunctionEnd

; Custom Distros Installer - Uninstaller Include
!include "ஐ-நி.கோ.ஒ.அ\நிரல்கள்\விநியோகநிறுவல்.நிரல்" ; ## ADD NEW DISTRO ##
!include "ஐ-நி.கோ.ஒ.அ\நிரல்கள்\விநியோகநீக்கம்.நிரல்" ; ## ADD NEW DISTRO ##

Function DoMBR ; Install MBR and Boot files on Fat Boot Partition
  
; Make sure EFI\Boot directory and files exist.  
  ${If} ${FileExists} $BOOT_LETTER\EFI\BOOT\BOOTX64.EFI 
    ${AndIf} ${FileExists} $BOOT_LETTER\ஐ-EXFAT 
    DetailPrint "A Previous ஐ EXFAT Installation was detected."
  ${Else}  
  ; CreateDirectory $BOOT_LETTER\!\menu ; recursively create the directory structure if it doesn't exist 
    CopyFiles "$PLUGINSDIR\உரிமை.உரை" "$BOOT_LETTER\உரிமை.உரை" 
  ; Copy GRUB2 EFI files 
  DetailPrint "Proceeding to extract GRUB2 EFI and BIOS files..."
  SetOutPath $PLUGINSDIR
  Nsis7z::ExtractWithDetails "$PLUGINSDIR\GRUBINST.7z" "Extracting package GRUBINST %s..."
  SetOutPath $BOOT_LETTER
  Nsis7z::ExtractWithDetails "$PLUGINSDIR\EFIGRUBX64.7z" "Extracting package EFIGRUBX64 %s..."
  # Use the following as a backup if the NSIS 7z dll breaks
    ;nsExec::ExecToLog '"$PLUGINSDIR\7za.exe" x "$PLUGINSDIR\EFIGRUBX64.7z" -o"$BOOT_LETTER" -y' 
    ;nsExec::ExecToLog '"$PLUGINSDIR\7za.exe" x "$PLUGINSDIR\GRUBINST.7z" -o"$PLUGINSDIR" -y' 
    
    ;ExecWait '"$PLUGINSDIR\7za.exe" x "$PLUGINSDIR\EFIGRUBX64.7z" -o"$BOOT_LETTER" -y' 
    ;ExecWait '"$PLUGINSDIR\7za.exe" x "$PLUGINSDIR\GRUBINST.7z" -o"$PLUGINSDIR" -y' 
    ;MessageBox MB_ICONEXCLAMATION|MB_OK "ஐ will now install a Grub2 MBR on (Disk $INST_DISK) - $BOOT_LETTER!"
    DetailPrint "Installing a Master Boot Record and adding i386-pc modules..."
    DetailPrint "Writing MBR. Please wait, this may take several seconds..."
    nsExec::ExecToLog '"$PLUGINSDIR\grub-install.exe" --force --no-floppy --target=i386-pc --boot-directory="$BOOT_LETTER\boot" //./PHYSICALDRIVE"$INST_DISK"' 
  ${EndIf}    
FunctionEnd

; ---- Let's Do This Stuff ----
Section  ; This is the only section that exists
; Get just the name of the ISO file 
Push "$ISOFile"
Push 1
Call GrabNameOnly
Pop $NameThatISO

; Make sure drive doesn't contain Windows... (secondary check - the droplist shouldn't be displaying Windows System drives).
 ${If} ${FileExists} "$BDir\windows\system32" ; additional safeguard to help protect from mishap. 
  MessageBox MB_ICONSTOP|MB_OK "ABORTING! ($DestDisk) contains a WINDOWS/SYSTEM32 Directory."
  Quit
 ${EndIf}
 
; Check if drive is already setup for ஐ-EXFAT or if format and prep checked.
 ${IfNot} ${FileExists} "$BDir\!\ஐ-EXFAT"
  ${If} $RepeatInstall != "YES"
   ${AndIf} $FormatMe != "YES"
    MessageBox MB_ICONSTOP|MB_OK "$BDir has not been prepared for this version of ஐ UEFI.$\r$\n$\r$\nGo back and tick the box to Prepare and format (Disk $INST_DISK)"
    StrCmp $R8 3 0 ;Compare $R8 variable with current page #
    StrCpy $R9 -1 ; Goes back to selections page
    Call உறவுபக்கத்திற்குச்செல் ; change pages
	Abort
  ${Endif}
 ${Endif}
 
 Call கோமுவகைபெறு
 ;${If} $FSType == "exFAT"
 ;${OrIf} $FSType == "NTFS"
 ;${AndIf} $FormatMe != "YES" 
 ;MessageBox MB_ICONSTOP|MB_OK "Syslinux won't work on $FSType formatted devices. ஐ will now Exit!" 
 ;Quit
 ;${EndIf}  
 
;checkpoint:
 ${If} $FormatMe == "YES" 
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "WARNING: To prevent any loss of data, you must backup your data from all partitions tied to (Disk $DiskNum) before proceeding!$\r$\n$\r$\n${பெயர்} is Ready to perform the following actions:$\r$\n$\r$\n1. Wipe and prepare (Disk $DiskNum) with multiple partitions. All exisiting Data will be Irrecoverably Deleted!$\r$\n$\r$\n2. Create an MBR on (Disk $DiskNum) - Existing MBR will be Overwritten!$\r$\n$\r$\n3. Create a ஐ Label on ($DestDisk) - existing Label will be Overwritten!$\r$\n$\r$\n4. Install ($DistroName) on ($DestDisk)$\r$\n$\r$\nAre you positive (Disk $DiskNum) is your USB Device?$\r$\nDouble Check with Windows diskmgmt.msc to make sure!$\r$\n$\r$\nClick YES to perform these actions or NO to Go Back!" IDYES proceed
  Quit
 ${ElseIf} $FormatMe != "YES" 
 ;${AndIfNot} ${FileExists} $BDir\!\menu\syslinux.cfg
 ${AndIf} $Removal != "YES"
 ${AndIf} $RepeatInstall != "YES"
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "${பெயர்} is Ready to perform the following actions:$\r$\n$\r$\nInstall ($DistroName) on (Disk $DiskNum) $DestDisk$\r$\n$\r$\nAre you absolutely positive (Disk $DiskNum) is your USB Device?$\r$\nDouble Check with Windows diskmgmt.msc to make sure!$\r$\n$\r$\nClick YES to perform these actions on (Disk $DiskNum) or NO to Exit!" IDYES proceed
  Quit
 ${EndIf}

proceed: 
 ${IfThen} $Removal == "YES" ${|} Goto removeonly ${|}
  Call இடமிருக்கு ; Got enough Space? Lets Check!
  Call ஆம்வடிவமை ; Format the Drive?
 
  ;Goto theend ; Temporary test stop here.
  Call LocalISODetected

; If ஐ_EXFAT doesn't exist make it so
 ${IfNot} ${FileExists} "$BDir\!\ஐ-EXFAT"
  CopyFiles "$PLUGINSDIR\ஐ-EXFAT" "$BDir\!\ஐ-EXFAT"
 ${EndIf}

; If path doesn't exist create the directory
 ${IfNot} ${FileExists} "$BDir\!\$DistroPath\*.*"
  CreateDirectory "$BDir\!\$DistroPath"
 ${EndIf} 
 
removeonly:
 ${If} $Removal != "YES"
  !insertmacro Install_Distros ; Install those distros
 ${ElseIf} $Removal == "YES"
  ;Call ConfigRemove
 !insertmacro Uninstall_Distros ; Remove those distros
 ${EndIf}
 
;theend:
SectionEnd

Function வெளியேறாதே
MessageBox MB_YESNO "Would you like to add more ISOs/Distros Now on $DestDisk?" IDYES noskip
    StrCmp $R8 3 0 End ;Compare $R8 variable with current page #
    StrCpy $R9 1 ; Goes to finish page
    Call உறவுபக்கத்திற்குச்செல்
    Abort
noskip:
StrCpy $ShowAll "$ShowAll" ; Retain Display All Drives
StrCpy $DestDrive "$DestDrive" ; Retain previously selected Drive Letter
StrCpy $DiskNum "$DiskNum" ; Retain previously selected Disk

	StrCpy $VolName $VolName
	StrCpy $FSType $FSType

StrCpy $BOOT_DISK "$BOOT_DISK" ; Retain previously selected Disk
;StrCpy $DiskNum "$BOOT_DISK" ; Retain previously selected Disk
StrCpy $RepeatInstall "YES" ; Set Repeat Install Option to YES
StrCpy $ISOTest "" ; Reset
StrCpy $ISOFile "" ; Reset
StrCpy $Removal "" ; Reset
StrCpy $Persistence "NULL" ; Reset
StrCpy $NameThatISO "" ; Reset NameThatISO ISO Name
StrCpy $DistroPath "" ; Clear Path to create
StrCpy $DistroName "" ; Clear Distro Name
StrCpy $ISOFileName "" ; Clear ISO Selection
StrCpy $FileFormat "" ; Clear File Format
StrCpy $DownloadMe 0 ; Ensure Uncheck of Download Option
StrCpy $LocalSelection "" ; Reset Local Selection
StrCpy $ShowingAll ""
StrCpy $FormatMe "" ; Reset Format Option
    StrCmp $R8 4 0 End ;Compare $R8 variable with current page #
    StrCpy $R9 -3 ; Goes back to selections page
    Call உறவுபக்கத்திற்குச்செல் ; change pages
    Abort
End:
FunctionEnd

Function உறவுபக்கத்திற்குச்செல்
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
 Messagebox MB_OK|MB_ICONINFORMATION "Currently you're trying to run this program as: $Auth$\r$\n$\r$\nYou must run this program with administrative rights...$\r$\n$\r$\nRight click the file and select Run As Administrator or Run As (and select an administrative account)!"
 Abort
 done:
 SetShellVarContext all
 InitPluginsDir   
  File /oname=$PLUGINSDIR\ஐ-EXFAT "இருமங்கள்\நி\ஐ-EXFAT"
  ;File /oname=$PLUGINSDIR\7za.exe "இருமங்கள்\நி\7za.exe"
  ;File /oname=$PLUGINSDIR\7za.dll "இருமங்கள்\நி\7za.dll"   
  ;File /oname=$PLUGINSDIR\7zxa.dll "இருமங்கள்\நி\7zxa.dll"  
  File /oname=$PLUGINSDIR\உரிமை.உரை "..\அகர\பகவன்\உரிமை.உரை"    
  File /oname=$PLUGINSDIR\EFIGRUBX64.7z "ஐ-நி.கோ.ஒ.அ\EFIGRUB\EFIGRUBX64.7z"  
  File /oname=$PLUGINSDIR\GRUBINST.7z "ஐ-நி.கோ.ஒ.அ\EFIGRUB\GRUBINST.7z" 
FunctionEnd

Function புதையல்நிலைமாற்றிஅறிவிப்பதில்
 Pop $Casper
 SendMessage $CasperSlider ${TBM_GETPOS} 0 0 $Casper ; Get Trackbar position
 ${NSD_SetText} $SlideSpot "$Casper MB"
FunctionEnd

Function உதநிஅளவைஅமை ; Get size of ISO
 System::Call 'kernel32::CreateFile(t "$TheISO", i 0x80000000, i 1, i 0, i 3, i 0, i 0) i .r0'
 System::Call "kernel32::GetFileSizeEx(i r0, *l .r1) i .r2"
 System::Alloc $1
 System::Int64Op $1 / 1048576 ; convert to MB
 Pop $1
 StrCpy $SizeOfCasper "$1"
 ; MessageBox MB_OK|MB_ICONINFORMATION "ISO Size: $SizeOfCasper"
 System::Call 'kernel32::CloseHandle(i r0)'
FunctionEnd

Function கோமுவகைபெறு
System::Call 'Kernel32::GetVolumeInformation(t "$JustDrive",t,i ${NSIS_MAX_STRLEN},*i,*i,*i,t .r1" ,i ${NSIS_MAX_STRLEN}) i.r0'
 StrCpy $FSType "$1"
FunctionEnd
