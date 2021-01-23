!define பெயர் "ஐ-நி.கோ.ஒ.அ"
!define பதிப்பு "0.0.3.3"
!include துணை\தலைப்பு.நிரல்
;!execute 'ஐ-நி.கோ.ஒ.அ\இருமங்கள்\அகர.bat' ; zip if required.
;!execute '"$%WINDIR%\notepad.exe" /P "${NSISDIR}\COPYING"' ; Enable this to debug previous line. 
; பொதுவாக பயன்படுத்தும் நிரல்கள்
!include துணை\பக்கங்கள்.நிரல்
!include துணை\தகவல்.நிரல்
!include துணை\ஒழுங்கமை.நிரல்
!include துணை\ஒருங்குறிஉரை.நிரல்
!include துணை\கோப்பில்மாற்று.நிரல்
!include துணை\வட்டுபொதுஉரை.நிரல்
!include துணை\தவமுன்னேற்றம்.நிரல் ; நிலைத்தன்மை கோப்பை உருவாக்குதல் முன்னேற்றம்
!include துணை\சரம்மாற்று.நிரல் 
!include துணை\சரம்கொண்டுள்ளது.நிரல் ; Let's check if a * wildcard exists
!include துணை\உதநிகோப்புபெயர்கள்அமை.நிரல் ; Macro for கோப்புபெயர்கள்
!include துணை\புதையல்பொதுஉரை.நிரல் ; தொடர்ச்சியான புதையல் கோப்புகளை உருவாக்க

!include ஐ-நி.கோ.ஒ.அ\நிரல்கள்\விநியோகபட்டியல்.நிரல் ; List of Distributions
!include ஐ-நி.கோ.ஒ.அ\நிரல்கள்\புதையல்உரை.நிரல் ; For creation of Persistent Casper-rw files

Function தேர்வுகள்பக்கம்
  StrCpy $R8 2
 !insertmacro MUI_HEADER_TEXT $(SelectDist_Title) $(SelectDist_Subtitle) 
  nsDialogs::Create 1018
  Pop $Dialog 

 ${If} $RepeatInstall == "YES"   
 ${NSD_SetText} $DestDriveTxt "$DestDrive"

; நிறுவ அல்லது நீக்க? அது தான் கேள்வி!
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
  
; அனைத்து உதநி விருப்பத்தையும் கட்டாயப்படுத்து
  ${NSD_CreateCheckBox} 80% 100 20% 15 "உதநிகள்?"
  Pop $ForceShowAll
  ${NSD_OnClick} $ForceShowAll அனைத்துஉதநிகள்காட்டு 

; உதநி பதிவிறக்க விருப்பம்
  ${NSD_CreateCheckBox} 60% 60 40% 15 "உதநி பதிவிறக்கம்."
  Pop $DownloadISO
  ${NSD_OnClick} $DownloadISO இதைபதிவிறக்கு  
  
; Clickable Link to Distribution Homepage  
  ${NSD_CreateLink} 60% 80 40% 15 "$OfficialName பக்கத்தைப் பார்!"
  Pop $DistroLink
  ${NSD_OnClick} $DistroLink லினக்சுதளசொடுக்த்தில்    

; உதநி Selection Starts  
  ${NSD_CreateLabel} 0 100 100% 15 $(IsoPage_Text)
  Pop $LabelISOSelection
  ${NSD_CreateText} 0 120 78% 20 "உலாவி $FileFormat தேர்ந்தெடுக்கவும்"
  Pop $ISOFileTxt 
  ${NSD_CreateBrowseButton} 85% 120 60 20 "உலாவு"
  Pop $ISOSelection 
  ${NSD_OnClick} $ISOSelection உதநிஉலாவு   
  
; Casper-RW Selection Starts
  ${NSD_CreateLabel} 0 150 75% 15 $(Casper_Text)
  Pop $CasperSelection  

  ${NSD_CreateLabel} 52% 178 25% 25 ""
  Pop $SlideSpot  

  nsDialogs::CreateControl "msctls_trackbar32" "0x50010000|0x00000018" "" 0 174 50% 25 ""
  Pop $CasperSlider
  SendMessage $CasperSlider ${TBM_SETRANGEMIN} 1 0 ; Min Range Value 0
  SendMessage $CasperSlider ${TBM_SETRANGEMAX} 1 $RemainingSpace ; Max Range Value
  ${NSD_OnNotify} $CasperSlider புதையல்நிலைமாற்றிஅறிவிப்பதில்    

; Drive Pre-Selection  
  ${NSD_CreateLabel} 0 0 58% 15 ""
  Pop $LabelDrivePage 
  ${NSD_SetText} $LabelDrivePage "படி 1: மின்வெட்டொளி இயக்கமாக $DestDisk வரவழைக்கப்பட்டது"  
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
  Call நிறுவுஅல்லதுநீக்கு
  Call இடத்தைஅமை
  Call இடத்தைசரிபார்
  Call இதைவடிவமை 
  Call அடுத்துஇயக்கு 
  ${NSD_OnChange} $DestDriveTxt இயக்கிதேர்வில் 

; Add Home Link
  ${NSD_CreateLink} 0 215 16% 15 "முகப்பு பக்கம்"
  Pop $Link
  ${NSD_OnClick} $LINK என்தளசொடுக்த்தில்    

; Add Help Link
  ${NSD_CreateLink} 16% 215 9% 15 "கேள்வி"
  Pop $Link1
  ${NSD_OnClick} $LINK1 அகேகேதளசொடுக்த்தில் 
  
; Add Giveback Link
  ${NSD_CreateLink} 25% 215 30% 15 "பரிந்துரை"
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
  ${NSD_CreateCheckBox} 60% 0 44% 15 "நிறுவப்பட்டது?"
  Pop $Uninstaller
  ${NSD_OnClick} $Uninstaller நிறுவல்நீக்கு  
  
; Drive Selection Starts  
  ${NSD_CreateLabel} 0 0 58% 15 ""    
  Pop $LabelDrivePage
  ${NSD_SetText} $LabelDrivePage "படி 1: மின்வெட்டொளி இயக்கக எழுத்து."    
  
; Droplist for Drive Selection
  ${NSD_CreateDropList} 0 20 55% 15 "" ; was 0 20 15% 15
  Pop $DestDriveTxt
  Call இயக்கிகளைபட்டியலிடு
  ${NSD_OnChange} $DestDriveTxt இயக்கிதேர்வில்

; அனைத்து இயக்கி காட்டு விருப்பம்
;  ${NSD_CreateCheckBox} 36% 23 22% 15 "அனைத்தும்?" ; was 17% 23 41% 15
;  Pop $AllDriveOption
;  ${NSD_OnClick} $AllDriveOption இயக்கிகளைபட்டியலிடு 
  
; Format Drive விருப்பம்
  ${NSD_CreateCheckBox} 60% 23 100% 15 "Prepare and format (Drive $DiskNum)"
  Pop $Format
  ${NSD_OnClick} $Format இதைவடிவமை 
; Distro Selection Starts
  ${NSD_CreateLabel} 0 50 50% 15 $(Distro_Text) 
  Pop $LinuxDistroSelection   

  ${NSD_CreateDropList} 0 70 55% 95 "" ; was ${NSD_CreateListBox} ; Enable for Dropbox
  Pop $Distro
  ${NSD_OnChange} $Distro விநியோகதேர்வில்
  ${NSD_CB_SelectString} $Distro $DistroName ; Was ${NSD_LB_SelectString} $Distro $DistroName  ; Enable For DropBox
  
; அனைத்து உதநி காட்டு விருப்பம்
  ${NSD_CreateCheckBox} 80% 100 20% 15 "உதநிகள்?"
  Pop $ForceShowAll
  ${NSD_OnClick} $ForceShowAll அனைத்துஉதநிகள்காட்டு

; உதநி பதிவிறக்கம் விருப்பம்
  ${NSD_CreateCheckBox} 60% 60 40% 15 "உதநி பதிவிறக்கம்."
  Pop $DownloadISO
  ${NSD_OnClick} $DownloadISO இதைபதிவிறக்கு  
  
; Clickable Link to Distribution Homepage  
  ${NSD_CreateLink} 60% 80 40% 15 "$OfficialName முகப்புப்பக்கத்தைப் பார்வையிடவும்"
  Pop $DistroLink
  ${NSD_OnClick} $DistroLink லினக்சுதளசொடுக்த்தில்    

; உதநி Selection Starts  
  ${NSD_CreateLabel} 0 100 100% 15 $(IsoPage_Text)
  Pop $LabelISOSelection
  ${NSD_CreateText} 0 120 78% 20 "உலாவி $FileFormat தேர்ந்தெடுக்கவும்"
  Pop $ISOFileTxt 
  ${NSD_CreateBrowseButton} 85% 120 60 20 "உலாவு"
  Pop $ISOSelection 
  ${NSD_OnClick} $ISOSelection உதநிஉலாவு

; Casper-RW Selection Starts
  ${NSD_CreateLabel} 0 150 75% 15 $(Casper_Text)
  Pop $CasperSelection
  ${NSD_CreateLabel} 52% 178 25% 25 ""
  Pop $SlideSpot  

  nsDialogs::CreateControl "msctls_trackbar32" "0x50010000|0x00000018" "" 0 174 50% 25 ""
  Pop $CasperSlider

  SendMessage $CasperSlider ${TBM_SETRANGEMIN} 1 0 ; Min Range Value 0
  SendMessage $CasperSlider ${TBM_SETRANGEMAX} 1 $RemainingSpace ; Max Range Value
  ${NSD_OnNotify} $CasperSlider புதையல்நிலைமாற்றிஅறிவிப்பதில்

; Add Home Link
  ${NSD_CreateLink} 0 215 16% 15 "முகப்பு பக்கம்"
  Pop $Link
  ${NSD_OnClick} $LINK என்தளசொடுக்த்தில்    
  
; Add Help Link
  ${NSD_CreateLink} 16% 215 9% 15 "கேள்வி"
  Pop $Link1
  ${NSD_OnClick} $LINK1 அகேகேதளசொடுக்த்தில் 
  
; Add Giveback Link
  ${NSD_CreateLink} 25% 215 30% 15 "பரிந்துரை"
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

Function இயக்கிகளைபட்டியலிடு ; Set to Display All Drives
  SendMessage $DestDriveTxt ${CB_RESETCONTENT} 0 0 
   ${GetDrives} "FDD+HDD" இயக்கிபட்டியல் ; All Drives Listed  
FunctionEnd

!include  துணை\இணைப்பு.நிரல்

Function அடுத்துஇயக்கு ; Enable Install Button
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
  StrCpy $InUnStall "சேர்"	
   StrCpy $InUnStalling "சேர்த்து"	
    StrCpy $InUnStalled "சேர்க்கப்பட்டது"	
  StrCpy $OnFrom "இதற்கு"
  StrCpy $InUnName "$JustISOName"
  GetDlgItem $6 $HWNDPARENT 1 ; Get "Install" control handle
   SendMessage $6 ${WM_SETTEXT} 0 "STR:உருவாக்கு"
    EnableWindow $6 1 ; Enable "Install" control button

  ${ElseIf} $Removal == "YES"
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
  
; Test if உதநி has been Selected. If not, disable Install Button
  ${If} $ISOTest == ""
  GetDlgItem $6 $HWNDPARENT 1
  EnableWindow $6 0 ; Disable "Install" if உதநி not set 
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
  
; Disable Window if உதநி was downloaded
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
  ${ElseIf} $Persistence != "casper" ; Eventually change to "NULL"
  ${OrIf} $Removal == "YES"  
  ShowWindow $CasperSelection 0
  ShowWindow $CasperSlider 0 
  ShowWindow $SlideSpot 0
  ${EndIf}    
FunctionEnd
!include துணை\பதிவிறக்கஇணைப்பு.நிரல்
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
  StrCpy $SomeFileExt "$ISOFileName" "" -3 ; Grabs the last 3 characters of the file name... zip or உதநி?
  StrCpy $FileFormat "$SomeFileExt" ; Set file type to look for zip, tar, உதநி etc...
  ${NSD_SetText} $LabelISOSelection "படி 3: உலாவி $ISOFileName தேர்ந்தெடுக்கவும்"
  ${NSD_SetText} $ISOFileTxt "$ISOFileName கோப்பிற்கு உலாவுக  -->"
  SetCtlColors $ISOFileTxt FF0000 FFFFFF  
  StrCpy $ISOTest "" ; Set to null until a new உதநி selection is made
  ${EndIf}
  
; முகப்பு பக்க இணைப்புகளை மீண்டும் வரையவும்
  ${NSD_SetText} $DistroLink "$OfficialName முகப்புப்பக்கத்தைப் பார்வையிடவும்" 
  ShowWindow $DistroLink 0
  ${If} $OfficialName == ""
   ${OrIf} $Removal == "YES"
  ShowWindow $DistroLink 0
  ${Else}
  ShowWindow $DistroLink 1
  ${EndIf}    
; Autodetect உதநி's in same folder and select if they exist  
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
  ${NSD_SetText} $DownloadISO "நாங்கள் கண்டுபிடித்து $SomeFileExt தேர்ந்தெடுத்தோம்."    
  EnableWindow $ISOSelection 0 
  SetCtlColors $ISOFileTxt 009900 FFFFFF  
  ${NSD_SetText} $ISOFileTxt $ISOFile 
  ${NSD_SetText} $LabelISOSelection "படி 3 முடிந்தது: $ISOFileName கண்டுபிடிக்கப்பட்டு தேர்ந்தெடுக்கப்பட்டது!"  
  StrCpy $ISOTest "$TheISO" ; Populate ISOTest so we can enable Next    
  Call அடுத்துஇயக்கு  
  
 ${ElseIf} ${FileExists} "$EXEDIR\$ISOFileName"
 ${AndIf} $Removal != "YES"
 ${AndIf} $WILD == "*" 
  EnableWindow $DownloadISO 1
  EnableWindow $ISOSelection 1
  ${NSD_Uncheck} $DownloadISO  
  ${NSD_SetText} $DownloadISO "பதிவிறக்க இணைப்பு"       
  SetCtlColors $ISOFileTxt FF9B00 FFFFFF  
  ${NSD_SetText} $ISOFileTxt "உலாவி $ISOFileName தேர்ந்தெடுக்கவும்" 
  ${NSD_SetText} $LabelISOSelection "படி 3 நிலுவையில்:$ISOFileName கோப்பிற்கு உலாவுக"    
  Call அடுத்துஇயக்கு  
  
 ${Else}
  Call அடுத்துஇயக்கு
  EnableWindow $DownloadISO 1
  EnableWindow $ISOSelection 1
  ${NSD_Uncheck} $DownloadISO  
  ${NSD_SetText} $DownloadISO "பதிவிறக்க இணைப்பு"   
 ${EndIf}  
 
 ${If} $DownLink == "NONE"
  ${OrIf} $Removal == "YES"
  ShowWindow $DownloadISO 0
 ${Else}
  ShowWindow $DownloadISO 1
 ${EndIf}
FunctionEnd 

; On Selection of உதநி File
Function உதநிஉலாவு
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
 ${NSD_SetText} $DownloadISO "கணினியில் உள்ள $SomeFileExt தேர்ந்தெடுக்கப்பட்டது." 
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
 ${AndIf} ${FileExists} "$BDir\!\menu\ஐ-நிகோஒஅ.உரை"
 MessageBox MB_OK "$JustISOName is already on $DestDisk$\r$\nPlease Remove it first!"
 ${Else}
 ${EndIf}
 Call அடுத்துஇயக்கு
 ; Uncomment for Testing --> MessageBox MB_ICONQUESTION|MB_OK 'Removal: "$Removal"  ISOFileName: "$ISOFileName" ISOFile "$ISOFile" BDir: "$BDir" DestDisk: "$DestDisk" DestDrive: "$DestDrive" ISOTest: "$ISOTest"'
 FunctionEnd

Function நிறுவுஅல்லதுநீக்கு ; Populate DistroName based on Install/Removal option
  ${If} $Removal == "YES" 
  Call அகற்றும்பட்டியல்
  ${Else}
   ${NSD_SetText} $LinuxDistroSelection "படி 2: $DestDiskஇல் நிறுவ ஒரு விநியோகம்" 
  Call உதநிகோப்புபெயர்அமை
  ${EndIf}
FunctionEnd  

; On Selection of Uninstaller Option
Function நிறுவல்நீக்கு
  ${NSD_GetState} $Uninstaller $Removal
  ${If} $Removal == ${BST_CHECKED}
  ShowWindow $Format 0
    ShowWindow $LabelISOSelection 0 
	Call அனைத்தும்அழி	
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
	SendMessage $6 ${WM_SETTEXT} 0 "STR:நீக்கு"
	EnableWindow $6 0 ; Disable "Install" control button
  ${NSD_SetText} $Uninstaller "நிறுவல் நீக்குதல்!"
   ${NSD_SetText} $LinuxDistroSelection "படி 2: $DestDisk இலிருந்து அகற்ற ஒரு விநியோகத்தைத் தேர்ந்தெடுக்கவும்"  
    SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; Clear all distro entries because a new option may have been chosen ; Enable for DropBox
     StrCpy $Checker "YES"   
	 Call அகற்றும்பட்டியல்

  ${ElseIf} $Removal == ${BST_UNCHECKED}
   ShowWindow $Format 1  
    ShowWindow $LabelISOSelection 1 
    ShowWindow $ISOFileTxt 1
	ShowWindow $ISOSelection 0
	Call அனைத்தும்அழி
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
     StrCpy $Checker "YES"         
     Call உதநிகோப்புபெயர்அமை
  ${EndIf}  
FunctionEnd

; On Selection of USB Drive
Function இயக்கிதேர்வில்
  Pop $DestDriveTxt
  ${NSD_GetText} $DestDriveTxt $Letters
  StrCpy $DestDrive "$Letters"
  StrCpy $JustDrive $DestDrive 3  
  StrCpy $BDir $DestDrive 2 ;was -1 
  StrCpy $DestDisk $DestDrive 2 ;was -1

  Call இயற்பியக்கி
  StrCpy $INST_DISK "$DiskNum" ; save Install Disk Number in case we need it again later
  Call கோமுவகைபெறு

; Check if drive is already setup for ஐ-நிகோஒஅ.உரை
 ${IfNot} ${FileExists} "$BDir\!\ஐ-நிகோஒஅ.உரை"
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
  Call நிறுவுஅல்லதுநீக்கு
  Call இடத்தைஅமை
  Call இடத்தைசரிபார்
  Call இதைவடிவமை  
  Call அடுத்துஇயக்கு
  ${NSD_SetText} $LabelDrivePage "படி 1: மின்வெட்டொளி $DestDisk (தட்டு $DiskNum) தேர்ந்தெடுத்துள்ளீர்கள்"   
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

Function இயக்கிபட்டியல்
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
   ${சரம்கொண்டுள்ளது} $BOOT "TEMPI" "$VolName" ; does the string contain the TEMPI Label? - This label is only set during initial 2nd partition creation.
   ${If} $BOOT == "TEMPI" ; if so do something
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
   ${சரம்கொண்டுள்ளது} $IDR "I" "$VolName" ; does the string contain the I Label?
   ${If} $IDR == "I" ; if so add string
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
   ${If} "$VolName" == "TEMPI" ; does $VolName contain the TEMPI Label? - This label is only set during initial 2nd partition creation.
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
	
	; call and use a new DrivesListBoot function... only show drives with the TEMPI label that match disk
   ${GetDrives} "FDD+HDD" DrivesListBoot ; probe for the BOOT disk number and letter... since we just wiped and recreated partitions on the disk.
	;MessageBox MB_ICONSTOP|MB_OK "BOOT --> $BOOT_LETTER (Disk $BOOT_DISK) | I --> $DestDisk (Disk $INST_DISK)" ; checkpoint
	
 ${Endif}	 
  ;${If} $FormatMe == "YES"
   ;Call பூட்டு_மட்டும் ; Just get a lock on the Volume 
   ;Sleep 3000
   ;nsExec::ExecToLog '"cmd" /c "echo y|$PLUGINSDIR\fat32format $DestDisk"' ;/Q /y
   ;Call தொகுதிதிற ; Unlock to allow Access   
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
	${If} ${FileExists} "$BDir\!\ஐ-நிகோஒஅ.உரை"
    ShowWindow $Uninstaller 1 ; Re-enable Uninstaller option.
	${EndIf}
	StrCpy $Checker "YES" 
	Call இடத்தைஅமை
  ${EndIf}  
    Call நிறுவுஅல்லதுநீக்கு
FunctionEnd

!include துணை\அனைத்துஉதநிகள்காட்டு.நிரல்

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
  MessageBox MB_ICONSTOP|MB_OK "அச்சச்சோ: போதுமான வட்டு இடம் இல்லை! $JustDrive இயக்ககத்தில் $1 எம்பி உள்ளது, $SizeOfCasper எம்பி தேவை."
  okay: ; Proceed to execute...
FunctionEnd

Function இடமிருக்கு ; Check space required
  Call புதையல்அளவு
  Call மீதமுள்ளவட்டுஇடம்
  System::Int64Op $1 > $SizeOfCasper ; Compare the space available > space required
  Pop $3 ; Get the result ...
  IntCmp $3 1 okay ; ... and compare it
  MessageBox MB_ICONSTOP|MB_OK "போதுமான இடவசதி இல்லை. ஐ-கருவி வெளியேறு!"
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
    ${AndIf} ${FileExists} $BOOT_LETTER\ஐ-நிகோஒஅ.உரை 
    DetailPrint "A Previous ஐ-நிகோஒஅ Installation was detected."
											
		 
																						  
																								
									 
																										 
																		  

			
						 
			   
					  
						 
			   
						  
			 
		 
	 
				
				
							
						  
							
							   
					   
			
				
					   
		
		
		
		
	   
	   
	   
		   

											
								 
											  

																				  
																										 
																		  

			

											
								 
											  

																				  
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
Call பெயரைமட்டும்பெறு
Pop $NameThatISO

; Make sure drive doesn't contain Windows... (secondary check - the droplist shouldn't be displaying Windows System drives).
 ${If} ${FileExists} "$BDir\windows\system32" ; additional safeguard to help protect from mishap. 
  MessageBox MB_ICONSTOP|MB_OK "ABORTING! ($DestDisk) contains a WINDOWS/SYSTEM32 Directory."
  Quit
 ${EndIf}
 
; Check if drive is already setup for ஐ-நிகோஒஅ.உரை or if format and prep checked.
 ${IfNot} ${FileExists} "$BDir\!\ஐ-நிகோஒஅ.உரை"
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
  Call உள்உதநிகண்டறியப்பட்டது

; If ஐ_EXFAT doesn't exist make it so
 ${IfNot} ${FileExists} "$BDir\!\ஐ-நிகோஒஅ.உரை"
  CopyFiles "$PLUGINSDIR\ஐ-நிகோஒஅ.உரை" "$BDir\!\ஐ-நிகோஒஅ.உரை"
 ${EndIf}

; If path doesn't exist create the directory
 ${IfNot} ${FileExists} "$BDir\!\$DistroPath\*.*"
  CreateDirectory "$BDir\!\$DistroPath"
 ${EndIf} 
 
removeonly:
 ${If} $Removal != "YES"
 !insertmacro விநியோகநிறுவல் ; Install those distros
 ${ElseIf} $Removal == "YES"
  ;Call கட்டமைப்புநீக்க
 !insertmacro விநியோகநீக்கம் ; Remove those distros
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
StrCpy $NameThatISO "" ; Reset NameThatISO உதநி Name
StrCpy $DistroPath "" ; Clear Path to create
StrCpy $DistroName "" ; Clear Distro Name
StrCpy $ISOFileName "" ; Clear உதநி Selection
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

; --- Stuff to do at startup of script ---
Function .onInit
StrCpy $TASupport "YES" 
StrCpy $R9 0 ; உரிமை உரை தவிர், பக்கம் 0க்கு செல்
 StrCpy $FileFormat "ISO"
 userInfo::getAccountType
 Pop $Auth
 strCmp $Auth "Admin" done
 Messagebox MB_OK|MB_ICONINFORMATION "தற்போது நீங்கள் இந்த நிரலை $Authஆக இயக்க முயற்சிக்கிறீர்கள் $\r$\n$\r$\nநீங்கள் நிர்வாக உரிமைகளுடன் இந்த நிரலை இயக்க வேண்டும்...$\r$\n$\r$\nகோப்பில் வலது கிளிக் செய்து, நிர்வாகியாக இயக்கவும் அல்லது இயக்கவும் என்பதைத் தேர்ந்தெடுக்கவும் (மற்றும் நிர்வாகக் கணக்கைத் தேர்ந்தெடுக்கவும்)!"
 Abort
 done:
 SetShellVarContext all
 InitPluginsDir   
  File /oname=$PLUGINSDIR\ஐ-நிகோஒஅ.உரை "..\அகர\பகவன்\ஐ-நிகோஒஅ.உரை"
  ;File /oname=$PLUGINSDIR\7za.exe "இருமங்கள்\நி\7za.exe"
  ;File /oname=$PLUGINSDIR\7za.dll "இருமங்கள்\நி\7za.dll"   
  ;File /oname=$PLUGINSDIR\7zxa.dll "இருமங்கள்\நி\7zxa.dll"  
  File /oname=$PLUGINSDIR\உரிமை.உரை "..\அகர\பகவன்\உரிமை.உரை"    
  File /oname=$PLUGINSDIR\EFIGRUBX64.7z "ஐ-நி.கோ.ஒ.அ\EFIGRUB\EFIGRUBX64.7z"  
  File /oname=$PLUGINSDIR\GRUBINST.7z "ஐ-நி.கோ.ஒ.அ\EFIGRUB\GRUBINST.7z" 
FunctionEnd

!include துணை\புதையல்நிலை.நிரல்
