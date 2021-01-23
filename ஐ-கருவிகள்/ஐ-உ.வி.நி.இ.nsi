!define பெயர் "ஐ-உ.வி.நி.இ"
!define பதிப்பு "0.0.3.2"
!include துணை\தலைப்பு.நிரல்
;!execute 'ஐ-உ.வி.நி.இ\இருமங்கள்\அகர.bat' ; zip if required.
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
!include துணை\புதையல்பொதுஉரை.நிரல் ; For creation of Persistent Casper-rw files

!include ஐ-உ.வி.நி.இ\நிரல்கள்\விநியோகபட்டியல்.நிரல் ; List of Distributions
!include ஐ-உ.வி.நி.இ\நிரல்கள்\கோப்புதிருத்தி.நிரல் ; Text File Manipulation
!include ஐ-உ.வி.நி.இ\நிரல்கள்\துவக்கதட்டுஉரை.நிரல்
!include ஐ-உ.வி.நி.இ\நிரல்கள்\புதையல்உரை.நிரல் ; For creation of Persistent Casper-rw files

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
  ${NSD_CreateDropList} 0 20 40% 15 "" ;
  Pop $DestDriveTxt
  ${If} $ShowAll == "YES"
  ${GetDrives} "FDD+HDD" இயக்கிபட்டியல் ; All Drives Listed
  ${ElseIf} $ShowAll == "NO"
  ${GetDrives} "FDD" இயக்கிபட்டியல் ; FDD+HDD reduced to FDD for removable media only
  ${EndIf}
  ${NSD_CB_SelectString} $DestDriveTxt "$DestDrive"
  StrCpy $JustDrive $DestDrive 3
  StrCpy $BDir $DestDrive 2
  StrCpy $DestDisk $DestDrive 2
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
  ${NSD_SetText} $LabelDrivePage "படி 1: மின்வெட்டொளி இயக்கக எழுத்து தேர்ந்தெடுக்கவும்."    
  
; Droplist for Drive Selection
  ${NSD_CreateDropList} 0 20 40% 15 "" ; was 0 20 15% 15
  Pop $DestDriveTxt
  Call இயக்கிகளைபட்டியலிடு
  ${NSD_OnChange} $DestDriveTxt இயக்கிதேர்வில்
; அனைத்து இயக்கி காட்டு விருப்பம்
  ${NSD_CreateCheckBox} 41% 23 17% 15 "அனைத்தும்?" ; was 17% 23 41% 15
  Pop $AllDriveOption
  ${NSD_OnClick} $AllDriveOption இயக்கிகளைபட்டியலிடு 
  
; Format Drive விருப்பம்
  ${NSD_CreateCheckBox} 60% 23 100% 15 "துடைத்து Fat32 வடிவமை $DestDisk"
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
  ${NSD_GetState} $AllDriveOption $DisplayAll
  ${If} $DisplayAll == ${BST_CHECKED}
  ${NSD_Check} $AllDriveOption
  ${NSD_SetText} $AllDriveOption "அனைத்தும்!"
   StrCpy $ShowAll "YES"
   ${GetDrives} "FDD+HDD" இயக்கிபட்டியல் ; All Drives Listed  
  ${ElseIf} $DisplayAll == ${BST_UNCHECKED}
  ${NSD_Uncheck} $AllDriveOption
  ${NSD_SetText} $AllDriveOption "அனைத்தும்?"
   ${GetDrives} "FDD" இயக்கிபட்டியல் ; FDD+HDD reduced to FDD for removable media only
   StrCpy $ShowAll "NO"
  ${EndIf}
FunctionEnd

!include  துணை\இணைப்பு.நிரல்

Function அடுத்துஇயக்கு ; Enable Install Button
  ;${If} $Blocksize >= 4 
  ${If} $Removal != "YES"
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
   ${NSD_SetText} $LinuxDistroSelection "படி 2: $DestDisk இல் நிறுவ ஒரு விநியோகம்" 
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
  ${NSD_SetText} $LinuxDistroSelection "படி 2: $DestDisk இல் வைக்க ஒரு விநியோகம்" 
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
  Call கோமுவகைபெறு
  ${If} $FSType == "exFAT"
   ${OrIf} $FSType == "NTFS"
   MessageBox MB_ICONSTOP|MB_OK "$FSType வடிவமைக்கப்பட்ட சாதனங்களில் கணிலினக்சு செயல்படாது. $JustDriveஐ Fat32 ஆக வடிவமைக்க நீங்கள் தேர்வு செய்யலாம்."
  ${EndIf}

  ${If} ${FileExists} "$BDir\!\ஐ.மரபு"
  MessageBox MB_ICONSTOP|MB_OK "($DestDisk) ஒரு ஐ-மரபு நிறுவலைக் கொண்டுள்ளது. ஐ-உ.வி.நி.இ ஐப் பயன்படுத்த நீங்கள் மறுவடிவமைக்க வேண்டும்."
  ${EndIf}   
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
 SendMessage $DestDriveTxt ${CB_ADDSTRING} 0 "STR:$9 (வட்டு $DiskNum) $VolName $Capacity $FSType" ;$8
 ${EndIf}
 Push 1 ; must push something - see GetDrives documentation
FunctionEnd

Function ஆம்வடிவமை ; If Format is checked, do something
  SetShellVarContext all
  InitPluginsDir
  File /oname=$PLUGINSDIR\கோஒஅ32வடிவம்.exe "இருமங்கள்\கோஒஅ32வடிவம்.exe"
 ${If} $FormatMe == "YES"
   Call பூட்டு_மட்டும் ; Just get a lock on the Volume 
   Sleep 3000
   nsExec::ExecToLog '"cmd" /c "echo y|$PLUGINSDIR\கோஒஅ32வடிவம் $DestDisk"' ;/Q /y
   Call தொகுதிதிற ; Unlock to allow Access   
  ${EndIf} 
FunctionEnd

Function இதைவடிவமை ; Set Format Option
  ${NSD_GetState} $Format $FormatMe
  ${If} $FormatMe == ${BST_CHECKED}
  ${NSD_Check} $Format
    StrCpy $FormatMe "YES"
  ${NSD_SetText} $Format "துடைத்து Fat32 வடிவமை $DestDisk!"
    SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; Clear all distro entries because a new format option may have been chosen ; Enable for DropBox
	ShowWindow $Uninstaller 0 ; Disable Uninstaller option because we will be formatting the drive.
    StrCpy $Checker "YES"	
  
  ${ElseIf} $FormatMe == ${BST_UNCHECKED}
  ${NSD_Uncheck} $Format
  ${NSD_SetText} $Format "துடைத்து Fat32 வடிவமை $DestDisk"  
    SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; Clear all distro entries because a new format option may have been chosen ; Enable for DropBox

    ShowWindow $Uninstaller 1 ; Re-enable Uninstaller option.
	StrCpy $Checker "YES" 
	Call இடத்தைஅமை
  ${EndIf}  
    Call நிறுவுஅல்லதுநீக்கு
FunctionEnd

!include துணை\அனைத்துஉதநிகள்காட்டு.நிரல்

Function இடத்தைஅமை ; Set space available for persistence
  ;StrCpy $0 '$0'
  Call மீதமுள்ளவட்டுஇடம்
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

Function இடமிருக்குமுன் ; Check space required
 ${If} $FormatMe != "YES" 
  Call புதையல்அளவு
  Call மீதமுள்ளவட்டுஇடம்
  System::Int64Op $1 > $SizeOfCasper ; Compare the space available > space required
  Pop $3 ; Get the result ...
  IntCmp $3 1 okay ; ... and compare it
  MessageBox MB_ICONSTOP|MB_OK "அச்சச்சோ: போதுமான வட்டு இடம் இல்லை! $JustDrive இயக்ககத்தில் $1 எம்பி உள்ளது, $SizeOfCasper எம்பி தேவை."
 ${EndIf}		 
  okay: ; Proceed to execute...
		 
FunctionEnd

Function இடமிருக்கு ; Check space required
 ${If} $FormatMe != "YES"
  Call புதையல்அளவு
  Call மீதமுள்ளவட்டுஇடம்
  System::Int64Op $1 > $SizeOfCasper ; Compare the space available > space required
  Pop $3 ; Get the result ...
  IntCmp $3 1 okay ; ... and compare it
  MessageBox MB_ICONSTOP|MB_OK "போதுமான காலி இடம் இல்லை. ஐ-கருவி நிறுத்தம்!"
  quit ; போதுமான காலி இடம் இல்லை. ஐ-கருவி நிறுத்தம்...
  okay: ; Proceed to execute...
 ${EndIf}
FunctionEnd

!macro பட்டிஉள்ளீட்டைநீக்கு file start stop
Push "${FILE}" ; File to search in
Push "${START}$\r$\n" ; text to start deleting from 
Push "${STOP}$\r$\n" ; text to stop at
Call பட்டிஉள்ளீட்டைநீக்கு
!macroend
!define பட்டிஉள்ளீட்டைநீக்கு "!insertmacro பட்டிஉள்ளீட்டைநீக்கு"

Function பட்டிஉள்ளீட்டைநீக்கு
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


;wrapper before write. Assumption UTF-8 file. 
${FileRecode} $R2 "ToUTF16LE"
${FileRecode} $3 "ToUTF16LE"
;Convert file from UTF-8 to UTF16LE
  FileOpen $R1 $R2 w
  FileOpen $R0 $3 r
  ClearErrors
  FileReadUTF16LE $R0 $R3
  IfErrors Done
  StrCmp $R3 $2 +3
  FileWriteUTF16LE $R1 $R3
  Goto -5
  ClearErrors
  FileReadUTF16LE $R0 $R3
  IfErrors Done
  StrCmp $R3 $1 +4 -3 
  FileReadUTF16LE $R0 $R3
  IfErrors Done
  FileWriteUTF16LE $R1 $R3
  ClearErrors
  Goto -4
Done:
   FileClose $R0
   FileClose $R1
; Convert file back to UTF-8
${FileRecode} $R2 "ToUTF8"
${FileRecode} $3 "ToUTF16LE"
; Convert file UTF16LE to UTF-8
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

; தனிப்பயன் விநியோகம் நிறுவி - நிறுவல் நீக்கி சேர்க்கவும்
!include ஐ-உ.வி.நி.இ\நிரல்கள்\விநியோகநிறுவல்.நிரல் ; புதிய  விநியோக நிறுவல்
!include ஐ-உ.வி.நி.இ\நிரல்கள்\விநியோகநீக்கம்.நிரல் ; # விநியோக நீக்கம்

Function கணிலினக்சுசெய் ; கணிலினக்சு நிறுவவும்
  ${IfNot} ${FileExists} "$BDir\!\libcom32.c32" 
  ${AndIf} ${FileExists} "$BDir\!\ldlinux.sys"   
  MessageBox MB_ICONEXCLAMATION|MB_OK $(WarningSyslinuxOLD)
  Quit
  ${EndIf}
						
		  
						   
					


  IfFileExists "$BDir\!\%\ldlinux.sys" SkipSyslinux CreateSyslinux ; checking for syslinux
CreateSyslinux:
  CreateDirectory $BDir\!\% ; recursively create the directory structure if it doesn't exist
  ;CreateDirectory $BDir\!\ISOS ; create ISOS folder  
  DetailPrint $(ExecuteSyslinux)
  ExecWait '$PLUGINSDIR\கணிலினக்சு.exe -maf -d /!/% $BDir' $R8
  DetailPrint "கணிலினக்சு பிழைகள் $R8"
  Banner::destroy
  ${If} $R8 != 0
  MessageBox MB_ICONEXCLAMATION|MB_OK $(WarningSyslinux)
  ${EndIf} 
  DetailPrint "$DestDisk மேல் TA சிட்டை உருவாக்குகிறது"
  nsExec::ExecToLog '"cmd" /c "LABEL $DestDiskTA"'

SkipSyslinux: 
DetailPrint $(SkipSyslinux)

${If} ${FileExists} $BDir\!\%\syslinux.cfg   
${AndIf} ${FileExists} $BDir\!\%\memdisk
DetailPrint "முந்தைய பலதுவக்க நிறுவல் கண்டறியப்பட்டது."
  ${Else}
  DetailPrint "தேவையான கோப்புகள் $BDir\!\% இதற்கு சேர்கப்பட்டன..." 
  CopyFiles "$PLUGINSDIR\கணிலினக்சு.உலகு" "$BDir\!\%\syslinux.cfg"  
  CopyFiles "$PLUGINSDIR\நினைவட்டு" "$BDir\!\%\memdisk"
  DetailPrint "தேவையான கோப்புகள் $BDir\அகர\பகவன் இதற்கு சேர்கப்பட்டன..." 
  CopyFiles "$PLUGINSDIR\உரிமை.உரை" "$BDir\அகர\பகவன்\உரிமை.உரை"

  ${EndIf}  
															 

; அகர\பகவன் அடைவு மற்றும் கோப்புகள் இருப்பதை உறுதிப்படுத்தவும்.  
  ${If} ${FileExists} $BDir\அகர\பகவன்\BOOTX64.EFI 
  ${AndIf} ${FileExists} $BDir\அகர\பகவன்\முதற்றே.உலகு

																 
  ${Else}  
; அகர முதல கோப்புகளை நகலெடுக்கிறது 
  DetailPrint "அகர முதல கோப்புகளை நகலெடுக்க தொடர்கிறது..."
  ExecWait '"$PLUGINSDIR\7zG.exe" x "$PLUGINSDIR\அகர.zip" -o"$BDir" -y' 
  ${EndIf}   
FunctionEnd

; ---- Let's Do This Stuff ----
Section  ; This is the only section that exists
; Get just the name of the உதநி file 
Push "$ISOFile"
Push 1
Call பெயரைமட்டும்பெறு
Pop $NameThatISO

																															
 ${If} ${FileExists} "$BDir\windows\system32" ; Safeguard windows Installation.
 MessageBox MB_ICONSTOP|MB_OK "கைவிடுகிறது! ($DestDisk) ஒரு WINDOWS/SYSTEM32 கோப்பகத்தைக் கொண்டுள்ளது."
 Quit
 ${EndIf}
 
 Call கோமுவகைபெறு
 ${If} $FSType == "exFAT"
  ${OrIf} $FSType == "NTFS"
   ${AndIf} $FormatMe != "YES" 
   MessageBox MB_ICONSTOP|MB_OK "$FSType வடிவமைக்கப்பட்ட சாதனங்களில் கணிலினக்சு செயல்படாது. ஐ-கருவி வெளியேறும்!" 
   Quit
 ${EndIf}  
 
;checkpoint:
 ${If} $FormatMe == "YES" 
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "எச்சரிக்கை: தொடர்வதற்கு முன் ($DestDisk)உடன் இணைக்கப்பட்ட அனைத்து பகிர்வுகளிலிருந்தும் உங்கள் தரவை காப்புப் பிரதி எடுக்கவும்!$\r$\n$\r$\n${பெயர்}  பின்வரும் செயல்களைச் செய்ய தயாராக உள்ளது:$\r$\n$\r$\n1. துடைத்து Fat32 வடிவமை ($DestDisk) -  தரவு மீளமுடியாமல் நீக்கப்படு!$\r$\n$\r$\n2. ($DestDisk)இல் ஒரு கணிலினக்சு முதன்மை துவக்க பதிவு உருவாக்கும் - இருக்கும் முதன்மை துவக்க பதிவு மேலெழுதப்படும்!$\r$\n$\r$\n3.($DestDisk)இல் TA சிட்டை உருவாக்கவும் - இருக்கும் சிட்டை மேலெழுதப்படும்!$\r$\n$\r$\n4. ($DestDisk)இல் ($DistroName)வை நிறுவு$\r$\n$\r$\n($DestDisk) இல் (வட்டு $DiskNum) சரியான யூ.எஸ்.பி சாதனம் என்பது உங்களுக்குத் தெரியுமா?$\r$\nஉறுதிப்படுத்த விண்டோஸ் வட்டு நிர்வாகத்துடன் இருமுறை சரிபார்க்கவும்!$\r$\n$\r$\nஇந்த செயல்களைச் செய்ய ஆம் என்பதை சொடுக்கவும் அல்லது கைவிட இல்லை சொடுக்கவும்!" IDYES proceed
 Quit
 ${ElseIf} $FormatMe != "YES" 
								
 ${AndIfNot} ${FileExists} $BDir\!\%\syslinux.cfg
 MessageBox MB_YESNO|MB_ICONEXCLAMATION "${பெயர்} பின்வரும் செயல்களைச் செய்ய தயாராக உள்ளது:$\r$\n$\r$\n1. ($DestDisk)இல் ஒரு கணிலினக்சு முதன்மை துவக்க பதிவு உருவாக்கும் - இருக்கும் முதன்மை துவக்க பதிவு மேலெழுதப்படும்!$\r$\n$\r$\n2.$DestDisk இல் TA சிட்டை உருவாக்கவும் - இருக்கும் சிட்டை மேலெழுதப்படும்!$\r$\n$\r$\n3. ($DestDisk)இல் ($DistroName)வை நிறுவு$\r$\n$\r$\nசரியான யூ.எஸ்.பி சாதனம் என்பது உங்களுக்குத் தெரியுமா?$\r$\nஉறுதிப்படுத்த விண்டோஸ் வட்டு நிர்வாகத்துடன் இருமுறை சரிபார்க்கவும்!$\r$\n$\r$\nஇந்த செயல்களைச் செய்ய ஆம் என்பதை சொடுக்கவும் அல்லது கைவிட இல்லை சொடுக்கவும்!" IDYES proceed
								 
	  
 Quit
 ${EndIf}

proceed: 
 ${IfThen} $Removal == "YES" ${|} Goto removeonly ${|}
 Call இடமிருக்கு ; போதுமான இடம் கிடைத்ததா? சரிபார்க்கலாம்!
 Call ஆம்வடிவமை ; இயக்ககத்தை வடிவமைக்கவா?
 Call கணிலினக்சுசெய் ; துவக்கக்கூடியதாக மாற்ற இயக்ககத்தில் கணிலினக்சை இயக்கவும்
 Call உள்உதநிகண்டறியப்பட்டது
 
; Copy the config file if it doesn't exist and create the entry in கணிலினக்சு.உலகு 
 ${IfNot} ${FileExists} "$BDir\அகர\பகவன்\$DistroPath" 
 CopyFiles "$PLUGINSDIR\$DistroPath" "$BDir\அகர\பகவன்\$DistroPath"
 Call கட்டமைப்புஎழுது

											
												 
									   
 ${EndIf} 
 
removeonly:
 ${If} $Removal != "YES"
 !insertmacro விநியோகநிறுவல் ; Install those distros
 ${ElseIf} $Removal == "YES"
  Call கட்டமைப்புநீக்க
 !insertmacro விநியோகநீக்கம் ; Remove those distros
 ${EndIf}
 
SectionEnd

Function கட்டமைப்புநீக்க ; Find and Set Removal Configuration file
  ${If} ${FileExists} "$BDir\!\$DistroName\ஐ\லினக்சு.உலகு"
  StrCpy $DistroPath "லினக்சு.உலகு"
  ${ElseIf} ${FileExists} "$BDir\!\$DistroName\ஐ\உலாவி.உலகு"
  StrCpy $DistroPath "உலாவி.உலகு"  
  ${ElseIf} ${FileExists} "$BDir\!\$DistroName\ஐ\கருவிகள்.உலகு"
  StrCpy $DistroPath "கருவிகள்.உலகு"
  ${ElseIf} ${FileExists} "$BDir\!\$DistroName\ஐ\நோய்தடுப்பு.உலகு"
  StrCpy $DistroPath "நோய்தடுப்பு.உலகு"
  ${ElseIf} ${FileExists} "$BDir\!\$DistroName\ஐ\இணையபுத்தகம்.உலகு"
  StrCpy $DistroPath "இணையபுத்தகம்.உலகு"
  ${ElseIf} ${FileExists} "$BDir\!\$DistroName\ஐ\மற்ற.உலகு"
  StrCpy $DistroPath "மற்ற.உலகு"
  ${ElseIf} ${FileExists} "$BDir\!\$DistroName\ஐ\பட்டியலிடாத.உலகு"
  StrCpy $DistroPath "பட்டியலிடாத.உலகு"  
;  ${ElseIf} ${FileExists} "$BDir\!\$DistroName\ஐ\menu.lst"
;  StrCpy $DistroPath "menu.lst"
  ${EndIf}
  ;MessageBox MB_OK "$DistroPath"
FunctionEnd

Function கட்டமைப்புஎழுது
 ${If} $DistroPath == "கருவிகள்.உலகு"
  ${கணினிகோப்பில்எழுது} "menuentry $\">அகர$\"{configfile /அகர/பகவன்/கருவிகள்.உலகு}" $R0
 ${ElseIf} $DistroPath == "இணையபுத்தகம்.உலகு"
  ${கணினிகோப்பில்எழுது} "menuentry $\">இ$\"{configfile /அகர/பகவன்/இணையபுத்தகம்.உலகு}" $R0 
 ${ElseIf} $DistroPath == "லினக்சு.உலகு"
  ${கணினிகோப்பில்எழுது} "menuentry $\">ஐ$\"{configfile /அகர/பகவன்/லினக்சு.உலகு}" $R0 
 ${ElseIf} $DistroPath == "மற்ற.உலகு"
  ${கணினிகோப்பில்எழுது} "menuentry $\">ஒ$\"{configfile /அகர/பகவன்/மற்ற.உலகு}" $R0 
 ${ElseIf} $DistroPath == "நோய்தடுப்பு.உலகு"
  ${கணினிகோப்பில்எழுது} "menuentry $\">தட$\"{configfile /அகர/பகவன்/நோய்தடுப்பு.உலகு}" $R0 
 ${ElseIf} $DistroPath == "உலாவி.உலகு"
  ${கணினிகோப்பில்எழுது} "menuentry $\">பற$\"{configfile /அகர/பகவன்/உலாவி.உலகு}" $R0  
 ${ElseIf} $DistroPath == "பட்டியலிடாத.உலகு"
  ${கணினிகோப்பில்எழுது} "menuentry $\">மற$\"{configfile /அகர/பகவன்/பட்டியலிடாத.உலகு}" $R0  
; ${ElseIf} $DistroPath == "menu.lst"
 ;${கணினிகோப்பில்எழுது} "label GRUB Bootable ISOs$\r$\nmenu label GRUB Bootable ISOs and Windows XP/7/8 ->$\r$\nMENU INDENT 1$\r$\nKERNEL /!/grub.exe$\r$\nAPPEND --config-file=/அகர/பகவன்/menu.lst" $R0 
 ${EndIf} 
FunctionEnd

Function வெளியேறாதே
MessageBox MB_YESNO "$DestDisk இயக்ககத்தில் இப்போது மேலும் உதநிகள் / விநியோகங்களை சேர்க்க விரும்புகிறீர்களா?" IDYES noskip
    StrCmp $R8 3 0 End ;Compare $R8 variable with current page #
    StrCpy $R9 1 ; Goes to finish page
    Call உறவுபக்கத்திற்குச்செல்
    Abort
noskip:
StrCpy $ShowAll "$ShowAll" ; Retain Display All Drives
StrCpy $DestDrive "$DestDrive" ; Retain previously selected Drive Letter
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
 File /oname=$PLUGINSDIR\கணிலினக்சு.exe "இருமங்கள்\கணிலினக்சு6.04.32.exe"  
 File /oname=$PLUGINSDIR\கணிலினக்சு.உலகு "ஐ-உ.வி.நி.இ\உரைகள்\கணிலினக்சு.உலகு"
 File /oname=$PLUGINSDIR\மந்தமான.உலகு "ஐ-உ.வி.நி.இ\உரைகள்\மந்தமான.உலகு"   
 File /oname=$PLUGINSDIR\நோய்தடுப்பு.உலகு "ஐ-உ.வி.நி.இ\உரைகள்\நோய்தடுப்பு.உலகு" 
 File /oname=$PLUGINSDIR\கருவிகள்.உலகு "ஐ-உ.வி.நி.இ\உரைகள்\கருவிகள்.உலகு" 
 File /oname=$PLUGINSDIR\இணையபுத்தகம்.உலகு "ஐ-உ.வி.நி.இ\உரைகள்\இணையபுத்தகம்.உலகு"
 File /oname=$PLUGINSDIR\உலாவி.உலகு "ஐ-உ.வி.நி.இ\உரைகள்\உலாவி.உலகு"
 File /oname=$PLUGINSDIR\லினக்சு.உலகு "ஐ-உ.வி.நி.இ\உரைகள்\லினக்சு.உலகு" 
 File /oname=$PLUGINSDIR\பட்டியலிடாத.உலகு "ஐ-உ.வி.நி.இ\உரைகள்\பட்டியலிடாத.உலகு"
  File /oname=$PLUGINSDIR\liveusb "இருமங்கள்\வாழ்உதொபே"
  File /oname=$PLUGINSDIR\7zG.exe "இருமங்கள்\உ\7zG.exe"
  File /oname=$PLUGINSDIR\7z.dll "இருமங்கள்\உ\7z.dll"  
  File /oname=$PLUGINSDIR\உரிமை.உரை "..\அகர\பகவன்\உரிமை.உரை" 
  File /oname=$PLUGINSDIR\நினைவட்டு "இருமங்கள்\நினைவட்டு"
  File /oname=$PLUGINSDIR\அகர.zip "இருமங்கள்\அகர.zip"   
FunctionEnd

!include துணை\புதையல்நிலை.நிரல்

Function ஆரம்பசீவ_கண்டுபிடி
; FindFirst $0 $1 "$FindInitPath"
 loop:
  StrCmp $1 "" done
  ;DetailPrint கண்டறியப்பட்டது $1
  StrCpy $Initrd $1 
  FindNext $0 $1
  Goto loop
 done:
 FindClose $0
 FunctionEnd
 
 Function லினக்சுஉட்கரு_கண்டுபிடி ; find the path location of  
; FindFirst $0 $1 "$FindVmlinuzPath"
 loop:
  StrCmp $1 "" done
  ;DetailPrint கண்டறியப்பட்டது $1
  StrCpy $Vmlinuz $1 
  FindNext $0 $1
  Goto loop
 done:
 FindClose $0
FunctionEnd
