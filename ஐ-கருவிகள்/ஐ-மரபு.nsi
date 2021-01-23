!define பெயர் "ஐ-மரபு"
!define பதிப்பு "2.0.8.2"
!include துணை\தலைப்பு.நிரல்


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

!include ஐ-மரபு\நிரல்கள்\கோப்புதிருத்தி.நிரல் ; Text File Manipulation
!include ஐ-மரபு\நிரல்கள்\துவக்கதட்டுஉரை.நிரல்
!include ஐ-மரபு\நிரல்கள்\விநியோகபட்டியல்.நிரல் ; List of Distributions

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

; நிறுவ அல்லது நீக்க? அது தான் கேள்வி!
  ${NSD_CreateCheckBox} 60% 0 44% 15 "நிறுவப்பட்டது?"
  Pop $Uninstaller
  ${NSD_OnClick} $Uninstaller நிறுவல்நீக்கு  
  
; Alt Wipe Disk and all Partitions, Volumes.
  ${NSD_CreateCheckBox} 60% 0 44% 15 "முழுவதும் துடை (வட்டு $DiskNum)"
  Pop $Wipe
  ${NSD_OnClick} $Wipe WipeIt  

; Distro Selection Starts
  ${NSD_CreateLabel} 0 50 50% 15 $(Distro_Text) 
  Pop $LinuxDistroSelection   

  ${NSD_CreateDroplist} 0 70 58% 95 "" ; was  ${NSD_CreateListBox} ; Enable For DropBox
  Pop $Distro
  ${NSD_OnChange} $Distro விநியோகதேர்வில்
  ${NSD_CB_SelectString} $Distro $DistroName ; Was ${NSD_LB_SelectString} $Distro $DistroName  ; Enable For DropBox 
  
; அனைத்து உதநி விருப்பத்தையும் கட்டாயப்படுத்து
  ${NSD_CreateCheckBox} 80% 100 20% 9u "உதநிகள்?"
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
  ${NSD_CreateLabel} 0 150 75% 15 ""
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
  ${NSD_CreateDropList} 0 20 42% 15 "" ;
  Pop $DestDriveTxt
  ${If} $ShowAll == "YES"
  ${GetDrives} "FDD+HDD" இயக்கிபட்டியல் ; All Drives Listed
  ${ElseIf} $ShowAll == "NO"
  ${GetDrives} "FDD" இயக்கிபட்டியல் ; FDD+HDD reduced to FDD for removable media only
  ${EndIf}
  ${NSD_CB_SelectString} $DestDriveTxt "$DestDrive"
  ${NSD_GetText} $DestDriveTxt $Letters
  StrCpy $JustDrive $DestDrive 3
  StrCpy $BDir $DestDrive 2
  StrCpy $DestDisk $DestDrive 2
  Call கோமுவகைபெறு
  Call இயற்பியக்கி
  SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; Clear all distro entries because a new drive may have been chosen ; Enable for DropBox
  StrCpy $Checker "YES"  
  Call நிறுவுஅல்லதுநீக்கு
  Call இடத்தைஅமை
  Call இடத்தைசரிபார்
  Call இதைவடிவமை 
  Call அடுத்துஇயக்கு 
  ${NSD_OnChange} $DestDriveTxt இயக்கிதேர்வில்
; All Drives Option
  ${NSD_CreateCheckBox} 43% 23 16% 15 "புதுப்பி?"
  Pop $AllDriveOption
  ${NSD_OnClick} $AllDriveOption இயக்கிகளைபட்டியலிடு
  
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
  ShowWindow $ForceShowAll 0
  ShowWindow $CasperSelection 0 
  ShowWindow $CasperSlider 0 
  ShowWindow $SlideSpot 0   
  StrCpy $JustISOName "NULL" ; Set to NULL until something is selected
  nsDialogs::Show  
  
 ${Else}
  
; To Install or நிறுவல்நீக்கு? That is the question!  
  ${NSD_CreateCheckBox} 60% 0 44% 15 "நிறுவப்பட்டது?"
  Pop $Uninstaller
  ${NSD_OnClick} $Uninstaller நிறுவல்நீக்கு  
  
; Alt Wipe Disk and all Partitions, Volumes.
  ${NSD_CreateCheckBox} 60% 0 44% 15 "முழுவதும் துடை (வட்டு $DiskNum)"
  Pop $Wipe
  ${NSD_OnClick} $Wipe WipeIt     
  
; Drive Selection Starts  
  ${NSD_CreateLabel} 0 0 58% 15 ""    
  Pop $LabelDrivePage
  ${NSD_SetText} $LabelDrivePage "படி 1: மின்வெட்டொளி இயக்கக எழுத்து தேர்ந்தெடுக்கவும்."    
  
; Droplist for Drive Selection
  ${NSD_CreateDropList} 0 20 42% 15 "" ; was 0 20 55% 15
  Pop $DestDriveTxt
  Call இயக்கிகளைபட்டியலிடு
  ${NSD_OnChange} $DestDriveTxt இயக்கிதேர்வில்
; அனைத்து இயக்கி காட்டு விருப்பம்
  ${NSD_CreateCheckBox} 43% 23 16% 15 "புதுப்பி?"
  Pop $AllDriveOption
  ${NSD_OnClick} $AllDriveOption இயக்கிகளைபட்டியலிடு
; Format Drive விருப்பம்
  ${NSD_CreateCheckBox} 60% 23 100% 15 "NTFS வடிவமை $DestDisk"
  Pop $Format
  ${NSD_OnClick} $Format இதைவடிவமை 

; Format Fat32 Option
  ${NSD_CreateCheckBox} 60% 40 100% 15 "Fat32 வடிவமை $DestDisk"
  Pop $FormatFat
  ${NSD_OnClick} $FormatFat இதைவடிவமை  
 
; Distro Selection Starts
  ${NSD_CreateLabel} 0 50 50% 15 $(Distro_Text) 
  Pop $LinuxDistroSelection   

  ${NSD_CreateDropList} 0 70 58% 95 "" ; was ${NSD_CreateListBox} ; Enable for Dropbox
  Pop $Distro
  ${NSD_OnChange} $Distro விநியோகதேர்வில்
  ${NSD_CB_SelectString} $Distro $DistroName ; Was ${NSD_LB_SelectString} $Distro $DistroName  ; Enable For DropBox
  
; Force Show All ISO Option
  ${NSD_CreateCheckBox} 80% 100 20% 9u "உதநிகள்?"
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
  ${NSD_CreateLabel} 0 150 75% 15 "" ;$(Casper_Text)
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
  ShowWindow $FormatFat 0
  ShowWindow $ForceShowAll 0
  ShowWindow $Uninstaller 0
  ShowWindow $Wipe 0
  nsDialogs::Show 
 ${EndIf}
FunctionEnd

Function இயக்கிகளைபட்டியலிடு ; Set to Display All Drives
  SendMessage $DestDriveTxt ${CB_RESETCONTENT} 0 0 
  ${NSD_GetState} $AllDriveOption $DisplayAll
  ${If} $DisplayAll == ${BST_CHECKED}
  ${NSD_Check} $AllDriveOption
  ${NSD_SetText} $AllDriveOption "Refreshed"
  StrCpy $ShowAll "YES"
  ${GetDrives} "FDD+HDD" இயக்கிபட்டியல் ; All Drives Listed  
  ${ElseIf} $DisplayAll == ${BST_UNCHECKED}
  ${NSD_Uncheck} $AllDriveOption
  ${NSD_SetText} $AllDriveOption "Refresh?"  
  ${GetDrives} "FDD+HDD" இயக்கிபட்டியல் ; FDD+HDD reduced to FDD for removable media only
   StrCpy $ShowAll "NO"
  ${EndIf}
FunctionEnd

!include  துணை\இணைப்பு.நிரல்

Function அடுத்துஇயக்கு ; Enable Install Button
  ;${If} $Blocksize >= 4 
  ${If} $Removal != "YES"
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
   ${If} $DistroName == "Windows to Go (Virtual Hard Disk)"
     SendMessage $CasperSlider ${TBM_SETRANGEMIN} 1 20000 ; Min Range Value
    ${NSD_SetText} $CasperSelection "Step 4: Set the Size of the Win2Go VHD file. Minimum 20,000 MB"  
	${Else} 
	 SendMessage $CasperSlider ${TBM_SETRANGEMIN} 1 0 ; Min Range Value 0
	${NSD_SetText} $CasperSelection "Step 4: Set a Persistent file size for storing changes (Optional)."  
   ${EndIf}
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
  
  ${If} $DistroName != ""
  ${NSD_SetText} $LinuxDistroSelection "படி 2: $DistroName தேர்ந்தெடுக்கப்பட்டது"
  ${Else}
  ${NSD_SetText} $LinuxDistroSelection "படி 2: $DestDiskவைக்க ஒரு விநியோகம்"
  ${EndIf}    
  
; Autodetect உதநி's in same folder and select if they exist  
 ${If} ${FileExists} "$EXEDIR\$ISOFileName"
 ${AndIf} $Removal != "YES"
 ${சரம்கொண்டுள்ளது} $WILD "*" "$ISOFileName" ; Check for Wildcard and force Browse if * exists.
 ${AndIf} $WILD != "*"  
  StrCpy $TheISO "$EXEDIR\$ISOFileName"
  StrCpy $ISOFile "$TheISO"  
  ${GetFileName} "$TheISO" $JustISO
 ${சரம்மாற்று} '$JustISO' '$JustISO' ' ' '-'
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
 
 ${If} $JustISO != ""
 ${NSD_SetText} $LabelISOSelection "Step 3: $JustISO Selected"
 ${Else}
 ${NSD_SetText} $LabelISOSelection "Step 3: Select your $ISOFileName"
 ${EndIf} 
 
 ${If} ${FileExists} "$BDir\!\$JustISOName\*.*"
 ${AndIf} $JustISOName != ""
 ${AndIf} $FormatMe != "YES"
 ${AndIf} $FormatMeFat != "YES"
 MessageBox MB_OK "$JustISOName ஏற்கனவே $DestDisk இல் உள்ளது$\r$\nஇதை முதலில் அகற்று!$\r$\n$\r$\nகுறிப்பு: நீங்கள் ஏற்கனவே ஐ பயன்படுத்தி நீக்கியிருந்தால்,$\r$\n $BDir\!\$JustISOName\ கோப்புறையை கைமுறையாக நீக்கவும்."
 ${Else}
 ${EndIf}
 Call அடுத்துஇயக்கு
 ; Uncomment for Testing --> MessageBox MB_ICONQUESTION|MB_OK 'Removal: "$Removal"  ISOFileName: "$ISOFileName" ISOFile "$ISOFile" BootDir: "$BDir" DestDisk: "$DestDisk" DestDrive: "$DestDrive" ISOTest: "$ISOTest"'
  ${If} $FSType != "NTFS"
  ${AndIf} $FormatMe != "YES"
  ${AndIf} $DistroName == "Windows to Go (Virtual Hard Disk)"
  MessageBox MB_ICONSTOP|MB_OK "எச்சரிக்கை! ($DestDisk) என்.டி.எஃப்.எஸ் வடிவமைக்கப்படவில்லை. விண்டோஸ் டூ கோ விருப்பம் வேலை செய்ய என்.டி.எஃப்.எஸ் தேவை."
 
   ${ElseIf} $FSType != "NTFS"
   ${AndIf} $FormatMe != "YES"
   
   ${If} $DistroName == "Sergei Strelec"
   ${OrIf} $DistroName == "Try Unlisted ISO (GRUB Partition 4)"
   ${OrIf} $DistroName == "Try Unlisted ISO (GRUB)"
     ${If} $SizeOfCasper > "4096"
     MessageBox MB_OK|MB_ICONINFORMATION "The ISO is greater than 4GB. You must use NTFS format."
     ${EndIf}
	${EndIf}
	 
  ${EndIf}  
 FunctionEnd

Function அனைத்தும்அழி
StrCpy $ISOTest ""
StrCpy $DistroName "" ; Clear Distro Name
StrCpy $ISOFileName "" ; Clear உதநி Selection
StrCpy $SomeFileExt ""
StrCpy $FileFormat ""
FunctionEnd

Function நிறுவுஅல்லதுநீக்கு ; Populate DistroName based on Install/Removal option
  ${If} $Removal == "YES" 
  Call அகற்றும்பட்டியல்
  ${Else}
   ${If} $DistroName == ""
   ${NSD_SetText} $LinuxDistroSelection "படி 2: $DestDisk இல் நிறுவ ஒரு விநியோகம்" 
   ${EndIf}
 SendMessage $Distro ${CB_RESETCONTENT} 0 0
  Call உதநிகோப்புபெயர்அமை
  ${EndIf}
FunctionEnd  

; On Selection of Uninstaller Option
Function நிறுவல்நீக்கு
  ${NSD_GetState} $Uninstaller $Removal
  ${If} $Removal == ${BST_CHECKED}
  ShowWindow $Format 0
  ShowWindow $FormatFat 0
  ShowWindow $Wipe 0
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
																																																					
    SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; Clear all distro entries because a new option may have been chosen ; Enable for DropBox
     StrCpy $Checker "YES"   
	 Call அகற்றும்பட்டியல்

  ${ElseIf} $Removal == ${BST_UNCHECKED}
   ShowWindow $Format 1  
   ShowWindow $FormatFat 1
    ShowWindow $LabelISOSelection 1 
    ShowWindow $ISOFileTxt 1
	ShowWindow $ISOSelection 0
	ShowWindow $Wipe 1  
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

  Call கோமுவகைபெறு
  Call இயற்பியக்கி
  ${NSD_SetText} $LabelDrivePage "படி 1: $DestDisk (வட்டு $DiskNum) தேர்ந்தெடுத்துள்ளீர்கள்"   
  ${NSD_GetState} $Wipe $WipeIt
  ${If} $WipeIt == ${BST_CHECKED}
  ${NSD_Check} $Wipe
   StrCpy $WipeMe "YES" 
  ${NSD_SetText} $Wipe "முழுவதும் துடைக்கப்படும் (வட்டு $DiskNum)"
  ${ElseIf} $WipeIt == ${BST_UNCHECKED}
  ${NSD_Uncheck} $Wipe
   StrCpy $WipeMe "No"
  ${NSD_SetText} $Wipe "முழுவதும் துடை (வட்டு $DiskNum)"  
  ${EndIf}
  SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; Clear all distro entries because a new drive may have been chosen ; Enable for DropBox
  StrCpy $Checker "YES" 
  Call நிறுவுஅல்லதுநீக்கு
  Call இடத்தைஅமை
  Call இடத்தைசரிபார்
  Call இதைவடிவமை  
  Call அடுத்துஇயக்கு

  ${If} $FSType == "exFAT"
  MessageBox MB_ICONSTOP|MB_OK "எச்சரிக்கை! கணிலினக்சு exFAT வடிவமைக்கப்பட்ட சாதனங்களில் இயங்காது. $DestDiskஐ Fat32 அல்லது என்.டி.எஃப்.எஸ் ஆக வடிவமைக்கவும்."
  ${EndIf} 
  
  ${If} ${FileExists} "$BDir\boot\grub\grub.cfg"  
   ${AndIf} ${FileExists} "$BDir\!\grub\lnxboot.img"
    ${AndIf} ${FileExists} "$BDir\!\grub\core.img"
     MessageBox MB_ICONSTOP|MB_OK "எச்சரிக்கை! ($DestDisk) இந்த பதிப்போடு பொருந்தாத உ.வி.நி.இ. அடிப்படையிலான நிறுவலைக் கொண்டிருக்கிறது.$\r$\n$\r$\n ஐ-கருவியின் இந்த பதிப்பைப் பயன்படுத்த நீங்கள் திட்டமிட்டால், இந்த இயக்ககத்தை வடிவமைக்க வேண்டும்."
  ${EndIf} 
FunctionEnd

Function வட்டுதொகுதிபெயர்பெறு
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

Function வட்டிடம்
${DriveSpace} "$9" "/D=T /S=G" $1 ; used to find total space of each drive
${If} $1 > "0"
 StrCpy $Capacity "$1GB"
${Else}
 StrCpy $Capacity ""
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

Function WipeIt ; Set Wipe Disk Option
  ${NSD_GetState} $Wipe $WipeIt
  ${If} $WipeIt == ${BST_CHECKED}
  ${NSD_Check} $Wipe
   StrCpy $WipeMe "YES" 
  ${NSD_SetText} $Wipe "முழுவதும் துடைக்கப்படும் (வட்டு $DiskNum)"
  ${ElseIf} $WipeIt == ${BST_UNCHECKED}
  ${NSD_Uncheck} $Wipe
   StrCpy $WipeMe "No"
  ${NSD_SetText} $Wipe "முழுவதும் துடை (வட்டு $DiskNum)"  
  ; ShowWindow $Uninstaller 1 ; Re-enable Uninstaller option.
  ${EndIf}    
FunctionEnd

Function ஆம்வடிவமை ; If Format is checked, do something

  File /oname=$PLUGINSDIR\diskpartformat.txt "ஐ-மரபு\உரைகள்\diskpartformat.txt"     
  File /oname=$PLUGINSDIR\diskpartwipe1.txt "ஐ-மரபு\உரைகள்\diskpartwipe1.txt"  
  File /oname=$PLUGINSDIR\diskpartwipe2.txt "ஐ-மரபு\உரைகள்\diskpartwipe2.txt"    
  
  !insertmacro கோப்பில்மாற்று "DISKNUM" "$DiskNum" "all" "all" "$PLUGINSDIR\diskpartwipe1.txt"  
  !insertmacro கோப்பில்மாற்று "DSK" "$DestDisk" "all" "all" "$PLUGINSDIR\diskpartwipe2.txt" 
  !insertmacro கோப்பில்மாற்று "DISKNUM" "$DiskNum" "all" "all" "$PLUGINSDIR\diskpartwipe2.txt"   
  !insertmacro கோப்பில்மாற்று "DSK" "$DestDisk" "all" "all" "$PLUGINSDIR\diskpartformat.txt" 

; For NTFS Format ---  
  ${If} $FormatMe == "YES"
   ${AndIf} $WipeMe == "YES"
; Wipes the Entire Disk and reformats it with one NTFS Partition
    ;ToDO - Need to make a checkpoint here to test if is greater than Win XP (Vista or later OS?). XP doesn't support Diskpart on removable disks.
    nsExec::ExecToLog '"DiskPart" /S $PLUGINSDIR\diskpartwipe1.txt' 
	Sleep 3000
	nsExec::ExecToLog '"DiskPart" /S $PLUGINSDIR\diskpartwipe2.txt'  
	
   ${ElseIf} $FormatMe == "YES"
	${AndIf} $WipeMe != "YES"
; Just format the selected Drive Letter (Volume or Partition) NTFS
    ;ToDO - Need to make a checkpoint here to test if is greater than Win XP (Vista or later OS?). XP doesn't support Diskpart on removable disks.
    nsExec::ExecToLog '"DiskPart" /S $PLUGINSDIR\diskpartformat.txt' 

; For Fat32 Format ---  
  ${ElseIf} $FormatMeFat == "YES"  
   ${AndIf} $WipeMe == "YES"
; Wipes the Entire Disk and reformats it with one Fat32 Partition  
   ;ToDO - Need to make a checkpoint here to test if is greater than Win XP (Vista or later OS?). XP doesn't support Diskpart on removable disks.
   nsExec::ExecToLog '"DiskPart" /S $PLUGINSDIR\diskpartwipe1.txt' 
   Sleep 3000
   nsExec::ExecToLog '"DiskPart" /S $PLUGINSDIR\diskpartwipe2.txt' 
   Sleep 3000
   DetailPrint "Formatting $DestDisk as Fat32. This may take a while, please be patient..."
   nsExec::ExecToLog '"cmd" /c "echo y|$PLUGINSDIR\fat32format $DestDisk"' ;/Q /y    
   
  ${ElseIf} $FormatMeFat == "YES"  
   ${AndIf} $WipeMe != "YES"   
; Just Fat32 format the selected Drive Letter (Volume or Partition)	 
   Call பூட்டு_மட்டும் ; Just get a lock on the Volume 
   Sleep 3000
   nsExec::ExecToLog '"cmd" /c "echo y|$PLUGINSDIR\fat32format $DestDisk"' ;/Q /y
   Call தொகுதிதிற ; Unlock to allow Access
  ${EndIf}   
FunctionEnd

Function இதைவடிவமை ; Set Format Option

  ${NSD_GetState} $FormatFat $FormatMeFat
  ${If} $FormatMeFat == ${BST_CHECKED}
  ${NSD_Check} $FormatFat
  ${NSD_SetText} $FormatFat "We Will Fat32 Format $DestDisk"
   ShowWindow $Format 0
   StrCpy $FormatMeFat "YES" 
  ${ElseIf} $FormatMeFat == ${BST_UNCHECKED}
  ${NSD_Uncheck} $FormatFat
  ${NSD_SetText} $FormatFat "Fat32 Format $DestDisk"  
   ShowWindow $Format 1
   StrCpy $FormatMeFat "No"

   ShowWindow $Uninstaller 1 ; Re-enable Uninstaller option.
   StrCpy $Checker "YES" 
   ;Call இடத்தைஅமை
  ${EndIf}    

  ${NSD_GetState} $Format $FormatMe
  ${If} $FormatMe == ${BST_CHECKED}
  ${NSD_Check} $Format
						  
  ${NSD_SetText} $Format "We Will NTFS Format $DestDisk"
   ShowWindow $FormatFat 0
   StrCpy $FormatMe "YES"
						  
  
  ${ElseIf} $FormatMe == ${BST_UNCHECKED}
  ${NSD_Uncheck} $Format
  ${NSD_SetText} $Format "NTFS Format $DestDisk"  
   ShowWindow $FormatFat 1
   StrCpy $FormatMe "No"

    ShowWindow $Uninstaller 1 ; Re-enable Uninstaller option.
	StrCpy $Checker "YES" 
	;Call இடத்தைஅமை
  ${EndIf}  
  
  ${If} $FormatMe == "YES" 
   ${OrIf} $FormatMeFat == "YES"
    ShowWindow $Wipe 1
	ShowWindow $Uninstaller 0 ; Disable Uninstaller option because we will be formatting the drive.
    StrCpy $Checker "YES"	
	;Call இடத்தைஅமை      
  ${Else}
   ${NSD_Uncheck} $Wipe
   ${NSD_SetText} $Wipe "முழுவதும் துடை (வட்டு $DiskNum)"  
    StrCpy $WipeMe "No" 
  
	ShowWindow $Wipe 0
  ${EndIf}
  
    Call இடத்தைஅமை
    Call நிறுவுஅல்லதுநீக்கு
FunctionEnd

!include துணை\அனைத்துஉதநிகள்காட்டு.நிரல்

Function இடத்தைஅமை ; Set space available for persistence
 ${If} $FSType != "NTFS"
 ${OrIf} $FormatMeFat == "YES"
 ${AndIf} $FormatMe != "YES"
 
  ;MessageBox MB_ICONSTOP|MB_OK "$Casper - $FormatMeFat"
  Call மீதமுள்ளவட்டுஇடம்
  IntOp $MaxPersist 4090 + $CasperSize ; Space required for distro and 4GB max persistent file
  ${If} $1 > $MaxPersist ; Check if more space is available than we need for distro + 4GB persistent file
  StrCpy $RemainingSpace 4090 ; Set maximum possible value to 4090 MB (any larger wont work on fat32 Filesystem)
  ${Else}
  StrCpy $RemainingSpace "$1"
  IntOp $RemainingSpace $RemainingSpace - $SizeOfCasper ; Remaining space minus distro size
  ${EndIf}

 ${Else}  
  Call மீதமுள்ளவட்டுஇடம்
  IntOp $MaxPersist 20450 + $CasperSize ; Space required for distro and 20GB max persistent file
   ${If} $1 > $MaxPersist ; Check if more space is available than we need for distro + 4GB persistent file
   StrCpy $RemainingSpace 20450 ; Set maximum possible value to 20450 MB
   ${Else}
  StrCpy $RemainingSpace "$1"
  IntOp $RemainingSpace $RemainingSpace - $SizeOfCasper ; Remaining space minus distro size
  ${EndIf}

 ${EndIf} 
   IntOp $RemainingSpace $RemainingSpace - 1 ; Subtract 1MB so that we don't error for not having enough space
   SendMessage $CasperSlider ${TBM_SETRANGEMAX} 1 $RemainingSpace ; Re-Setting Max Value
FunctionEnd

Function இடமிருக்குமுன் ; Check space required
 ${If} $FormatMe != "YES" ; FIXME: Need to find a better method to check disk space when the drive appears unformatted (I.E. after it's been dd'd, etc).
 ${AndIf} $FormatMeFat != "YES"
  Call புதையல்அளவு
  Call மீதமுள்ளவட்டுஇடம்
  System::Int64Op $1 > $SizeOfCasper ; Compare the space available > space required
  Pop $3 ; Get the result ...
  IntCmp $3 1 okay ; ... and compare it
  MessageBox MB_ICONSTOP|MB_OK "அச்சச்சோ: போதுமான வட்டு இடம் இல்லை! $JustDrive இயக்ககத்தில் $1 எம்பி உள்ளது, $SizeOfCasper எம்பி தேவை. Do you need to format it?"
  okay: ; Proceed to execute...
 ${EndIf}
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

!macro பட்டிஉள்ளீட்டைநீக்கு file start stop
Push "${FILE}" ; File to search in
Push "${START}$\r$\n" ; text to start deleting from 
Push "${STOP}$\r$\n" ; text to stop at
Call பட்டிஉள்ளீட்டைநீக்கு
!macroend
!define பட்டிஉள்ளீட்டைநீக்கு "!insertmacro பட்டிஉள்ளீட்டைநீக்கு"

; பட்டிஉள்ளீட்டைநீக்கு function based on http://nsis.sourceforge.net/Delete_lines_from_one_line_to_another_line_inclusive.
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

; தனிப்பயன் விநியோகம் நிறுவி - நிறுவல் நீக்கி சேர்க்கவும்
!include "ஐ-மரபு\நிரல்கள்\விநியோகநிறுவல்.நிரல்" ; புதிய  விநியோக நிறுவல்
!include "ஐ-மரபு\நிரல்கள்\விநியோகநீக்கம்.நிரல்" ; விநியோக நீக்கம்

Function கணிலினக்சுசெய் ; கணிலினக்சு நிறுவவும்
  ${IfNot} ${FileExists} "$BDir\!\libcom32.c32" 
  ${AndIf} ${FileExists} "$BDir\!\ldlinux.sys"   
  MessageBox MB_ICONEXCLAMATION|MB_OK $(WarningSyslinuxOLD)
  Quit
  ${EndIf}
  
  IfFileExists "$BDir\!\libcom32.c32" SkipSyslinux CreateSyslinux ; checking for newer கணிலினக்சு

  CreateSyslinux:
  CreateDirectory $BDir\!\menu ; recursively create the directory structure if it doesn't exist
  CreateDirectory $BDir\!\ISOS ; create ISOS folder  
  DetailPrint $(ExecuteSyslinux)
  nsExec::Exec '"$PLUGINSDIR\syslinux.exe" -maf -d /! $BDir'
  Pop $R8
DetailPrint "Syslinux Errors $R8"
														
		   

${If} $R8 != 0
MessageBox MB_ICONEXCLAMATION|MB_OK $(WarningSyslinux)
${EndIf} 
DetailPrint "Creating Label TA on $DestDisk"
nsExec::ExecToLog '"cmd" /c "LABEL $DestDiskTA"'
SkipSyslinux: 
DetailPrint $(SkipSyslinux)

${IfNot} ${FileExists} $BDir\!\linux.c32 ; need linux.c32 to launch wimboot from syslinux.  
DetailPrint "Adding wimboot and linux.c32."   
CopyFiles "$PLUGINSDIR\wimboot" "$BDir\!\wimboot"
CopyFiles "$PLUGINSDIR\linux.c32" "$BDir\!\linux.c32"  
${EndIf}
${IfNot} ${FileExists} $BDir\!\ஐ-மரபு ; ஐ-மரபு test file.  
DetailPrint "Adding ஐ-மரபு test file."   
CopyFiles "$PLUGINSDIR\ஐ.மரபு" "$BDir\!\ஐ.மரபு"  
${EndIf}
${If} ${FileExists} $BDir\!\syslinux.cfg    
DetailPrint "முந்தைய பலதுவக்க நிறுவல் கண்டறியப்பட்டது. உங்கள் புதிய தேர்வுகளைச் சேர்க்க தொடர்கிறது...."
Call AddDir
${Else}
; Create and Copy files to your destination
DetailPrint "Adding required files to the $BDir\! directory..." 
CopyFiles "$PLUGINSDIR\syslinux.cfg" "$BDir\!\syslinux.cfg"
CopyFiles "$PLUGINSDIR\ஐ.png" "$BDir\!\I.png"
CopyFiles "$PLUGINSDIR\உரிமை.உரை" "$BDir\!\உரிமை.உரை"
CopyFiles "$PLUGINSDIR\vesamenu.c32" "$BDir\!\vesamenu.c32"
CopyFiles "$PLUGINSDIR\menu.c32" "$BDir\!\menu.c32"  
CopyFiles "$PLUGINSDIR\chain.c32" "$BDir\!\chain.c32"
CopyFiles "$PLUGINSDIR\libcom32.c32" "$BDir\!\libcom32.c32"  
CopyFiles "$PLUGINSDIR\libutil.c32" "$BDir\!\libutil.c32"      
CopyFiles "$PLUGINSDIR\memdisk" "$BDir\!\memdisk"
Call AddDir    
${EndIf}
${IfNot} ${FileExists} $BDir\!\libutil.c32 ; Old Syslinux files need to be replaced
DetailPrint "Adding required files to the $BDir\! directory..." 
CopyFiles "$PLUGINSDIR\ஐ.png" "$BDir\!\I.png"
CopyFiles "$PLUGINSDIR\உரிமை.உரை" "$BDir\!\உரிமை.உரை"   
CopyFiles "$PLUGINSDIR\vesamenu.c32" "$BDir\!\vesamenu.c32"
CopyFiles "$PLUGINSDIR\menu.c32" "$BDir\!\menu.c32"  
CopyFiles "$PLUGINSDIR\chain.c32" "$BDir\!\chain.c32"
CopyFiles "$PLUGINSDIR\libcom32.c32" "$BDir\!\libcom32.c32"  
CopyFiles "$PLUGINSDIR\libutil.c32" "$BDir\!\libutil.c32"   
CopyFiles "$PLUGINSDIR\memdisk" "$BDir\!\memdisk"
${EndIf}

; Check to ensure menu.c32 exists... now required for ஐ V2
${IfNot} ${FileExists} $BDir\!\menu.c32
DetailPrint "Adding menu.c32. Required for ஐ V2"
CopyFiles "$PLUGINSDIR\menu.c32" "$BDir\!\menu.c32" 
${EndIf}
FunctionEnd

Function AddDir ;
 ${IfNotThen} ${FileExists} "$BDir\!\grub.exe" 'CopyFiles "$PLUGINSDIR\grub.exe" "$BDir\!\grub.exe"' 
FunctionEnd

; ---- Let's Do This Stuff ----
Section  ; This is the only section that exists
; Get just the name of the ISO file 
Push "$ISOFile"
Push 1
Call பெயரைமட்டும்பெறு
Pop $NameThatISO

 ${If} ${FileExists} "$BDir\windows\system32" ; Safeguard windows Installation.
 MessageBox MB_ICONSTOP|MB_OK "ABORTING! ($DestDisk) contains a WINDOWS/SYSTEM32 Directory."
 Quit
 ${EndIf}

; Wipe and Format ---
																																																											 
	   
		   
 
			
 ${If} $FormatMe == "YES" 
  ${AndIf} $WipeMe == "YES" 
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "எச்சரிக்கை: தொடர்வதற்கு முன் ($DestDisk)உடன் இணைக்கப்பட்ட அனைத்து பகிர்வுகளிலிருந்தும் உங்கள் தரவை காப்புப் பிரதி எடுக்கவும்! இணைக்கப்பட்ட இயக்கி எழுத்துக்கள், பகிர்வுகள் மற்றும் தொகுதிகள் உட்பட (வட்டு $DiskNum) உள்ள அனைத்து தரவும் மறைக்கப்பட்டிருந்தாலும் அழிக்கப்படும்.$\r$\n$\r$\n${பெயர்} பின்வரும் செயல்களைச் செய்ய தயாராக உள்ளது:$\r$\n$\r$\n1.) துடை (வட்டு $DiskNum) - தரவு மீளமுடியாமல் நீக்கப்படும்!$\r$\n$\r$\n2.) ஒற்றை NTFS பகிர்வுடன் இயக்கத்தை ($DestDisk) மீண்டும் உருவாக்கவும்.$\r$\n$\r$\n3.) ($DestDisk)இல் ஒரு கணிலினக்சு முதன்மை துவக்க பதிவு உருவாக்கும் - இருக்கும் முதன்மை துவக்க பதிவு மேலெழுதப்படும்!$\r$\n$\r$\n4.) ($DestDisk)இல் TA சிட்டை உருவாக்கவும் - இருக்கும் சிட்டை மேலெழுதப்படும்!$\r$\n$\r$\n5.) ($DestDisk) இல் ($DistroName) நிறுவவும்$\r$\n$\r$\n(வட்டு $DiskNum) சரியான யூ.எஸ்.பி சாதனம் என்பது உங்களுக்குத் தெரியுமா?$\r$\nஉறுதிப்படுத்த விண்டோஸ் வட்டு நிர்வாகத்துடன் இருமுறை சரிபார்க்கவும்!$\r$\n$\r$\nஇந்த செயல்களைச் செய்ய ஆம் என்பதை சொடுக்கவும் அல்லது கைவிட இல்லை சொடுக்கவும்!" IDYES proceed
  Quit
 ${ElseIf} $FormatMeFat == "YES" 
  ${AndIf} $WipeMe == "YES" 
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "எச்சரிக்கை: தொடர்வதற்கு முன் ($DestDisk)உடன் இணைக்கப்பட்ட அனைத்து பகிர்வுகளிலிருந்தும் உங்கள் தரவை காப்புப் பிரதி எடுக்கவும்! இணைக்கப்பட்ட இயக்கி எழுத்துக்கள், பகிர்வுகள் மற்றும் தொகுதிகள் உட்பட (வட்டு $DiskNum) உள்ள அனைத்து தரவும் மறைக்கப்பட்டிருந்தாலும் அழிக்கப்படும்.$\r$\n$\r$\n${பெயர்} பின்வரும் செயல்களைச் செய்ய தயாராக உள்ளது:$\r$\n$\r$\n1.) துடை (வட்டு $DiskNum) - தரவு மீளமுடியாமல் நீக்கப்படும்!$\r$\n$\r$\n2.)ஒற்றை Fat32 பகிர்வுடன் இயக்கத்தை ($DestDisk) மீண்டும் உருவாக்கவும்.$\r$\n$\r$\n3.) ($DestDisk)இல் ஒரு கணிலினக்சு முதன்மை துவக்க பதிவு உருவாக்கும் - இருக்கும் முதன்மை துவக்க பதிவு மேலெழுதப்படும்!$\r$\n$\r$\n4.) ($DestDisk)இல் TA சிட்டை உருவாக்கவும் - இருக்கும் சிட்டை மேலெழுதப்படும்!$\r$\n$\r$\n5.) ($DestDisk) இல் ($DistroName) நிறுவவும்$\r$\n$\r$\n(வட்டு $DiskNum) சரியான யூ.எஸ்.பி சாதனம் என்பது உங்களுக்குத் தெரியுமா?$\r$\nஉறுதிப்படுத்த விண்டோஸ் வட்டு நிர்வாகத்துடன் இருமுறை சரிபார்க்கவும்!$\r$\n$\r$\nஇந்த செயல்களைச் செய்ய ஆம் என்பதை சொடுக்கவும் அல்லது கைவிட இல்லை சொடுக்கவும்!" IDYES proceed
  Quit

; Format Only ---
 ${ElseIf} $FormatMe == "YES" 
  ${AndIf} $WipeMe == "No" 
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "எச்சரிக்கை: தொடர்வதற்கு முன் ($DestDisk)உடன் இணைக்கப்பட்ட அனைத்து பகிர்வுகளிலிருந்தும் உங்கள் தரவை காப்புப் பிரதி எடுக்கவும்! ($DestDisk)உள்ள அனைத்து தரவும் மறைக்கப்பட்டிருந்தாலும் அழிக்கப்படும்.$\r$\n$\r$\n${பெயர்} பின்வரும் செயல்களைச் செய்ய தயாராக உள்ளது:$\r$\n$\r$\n1.) இயக்கி எழுத்து ($DestDisk)பூட்டு மற்றும் இறக்கு.$\r$\n$\r$\n2.) NTFS வடிவமை ($DestDisk) - ($DestDisk)கொண்டிருக்கும் தரவு மீளமுடியாமல் நீக்கப்படும்!$\r$\n$\r$\n3.) ($DestDisk)இல் ஒரு கணிலினக்சு முதன்மை துவக்க பதிவு உருவாக்கும் - இருக்கும் முதன்மை துவக்க பதிவு மேலெழுதப்படும்!$\r$\n$\r$\n4.) ($DestDisk)இல் TA சிட்டை உருவாக்கவும் - இருக்கும் சிட்டை மேலெழுதப்படும்!$\r$\n$\r$\n5.) ($DestDisk) இல் ($DistroName) நிறுவவும்$\r$\n$\r$\n($DestDisk)(வட்டு $DiskNum) சரியான யூ.எஸ்.பி சாதனம் என்பது உங்களுக்குத் தெரியுமா?$\r$\nஉறுதிப்படுத்த விண்டோஸ் வட்டு நிர்வாகத்துடன் இருமுறை சரிபார்க்கவும்!$\r$\n$\r$\nஇந்த செயல்களைச் செய்ய ஆம் என்பதை சொடுக்கவும் அல்லது கைவிட இல்லை சொடுக்கவும்!" IDYES proceed
  Quit
 ${ElseIf} $FormatMeFat == "YES" 
  ${AndIf} $WipeMe == "No" 
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "எச்சரிக்கை: தொடர்வதற்கு முன் ($DestDisk)உடன் இணைக்கப்பட்ட அனைத்து பகிர்வுகளிலிருந்தும் உங்கள் தரவை காப்புப் பிரதி எடுக்கவும்!$\r$\n$\r$\n${பெயர்} பின்வரும் செயல்களைச் செய்ய தயாராக உள்ளது:$\r$\n$\r$\n1.)இயக்கி எழுத்து ($DestDisk)பூட்டு மற்றும் இறக்கு.$\r$\n$\r$\n2.) Fat32 வடிவமை ($DestDisk) - ($DestDisk)கொண்டிருக்கும் தரவு மீளமுடியாமல் நீக்கப்படும்!$\r$\n$\r$\n3.) ($DestDisk)இல் ஒரு கணிலினக்சு முதன்மை துவக்க பதிவு உருவாக்கும் - இருக்கும் முதன்மை துவக்க பதிவு மேலெழுதப்படும்!$\r$\n$\r$\n4.) ($DestDisk)இல் TA சிட்டை உருவாக்கவும் - இருக்கும் சிட்டை மேலெழுதப்படும்!$\r$\n$\r$\n5.) ($DestDisk) இல் ($DistroName) நிறுவவும்$\r$\n$\r$\n($DestDisk)(வட்டு $DiskNum) சரியான யூ.எஸ்.பி சாதனம் என்பது உங்களுக்குத் தெரியுமா?$\r$\nஉறுதிப்படுத்த விண்டோஸ் வட்டு நிர்வாகத்துடன் இருமுறை சரிபார்க்கவும்!$\r$\n$\r$\nஇந்த செயல்களைச் செய்ய ஆம் என்பதை சொடுக்கவும் அல்லது கைவிட இல்லை சொடுக்கவும்!" IDYES proceed

 Quit  
  
; Don't Wipe or Format ---
 ${ElseIf} $FormatMe != "YES" 
  ${AndIf} $FormatMeFat != "YES"
 ${AndIfNot} ${FileExists} $BDir\!\syslinux.cfg
 MessageBox MB_YESNO|MB_ICONEXCLAMATION "${பெயர்} பின்வரும் செயல்களைச் செய்ய தயாராக உள்ளது:$\r$\n$\r$\n1. ($DestDisk)இல் ஒரு கணிலினக்சு முதன்மை துவக்க பதிவு உருவாக்கும் - இருக்கும் முதன்மை துவக்க பதிவு மேலெழுதப்படும்!$\r$\n$\r$\n2. ($DestDisk)இல் TA சிட்டை உருவாக்கவும் - இருக்கும் சிட்டை மேலெழுதப்படும்!$\r$\n$\r$\n3. Install ($DistroName) on ($DestDisk)$\r$\n$\r$\n($DestDisk)(வட்டு $DiskNum) சரியான யூ.எஸ்.பி சாதனம் என்பது உங்களுக்குத் தெரியுமா?$\r$\nஉறுதிப்படுத்த விண்டோஸ் வட்டு நிர்வாகத்துடன் இருமுறை சரிபார்க்கவும்!$\r$\n$\r$\nஇந்த செயல்களைச் செய்ய ஆம் என்பதை சொடுக்கவும் அல்லது கைவிட இல்லை சொடுக்கவும்!" IDYES proceed
  Quit
 ${EndIf}

proceed: 
 ${IfThen} $Removal == "YES" ${|} Goto removeonly ${|}
 Call ஆம்வடிவமை ; Format the Drive?
 Call இடமிருக்கு ; Got enough Space? Lets Check!
 Call கணிலினக்சுசெய் ; Run Syslinux on the Drive to make it bootable
 Call உள்உதநிகண்டறியப்பட்டது
 
; Copy the config file if it doesn't exist and create the entry in syslinux.cfg 
 ${IfNot} ${FileExists} "$BDir\!\menu\$DistroPath" 
 CopyFiles "$PLUGINSDIR\$DistroPath" "$BDir\!\menu\$DistroPath"
 Call கட்டமைப்புஎழுது
 ${EndIf} 
 
removeonly:
 ${If} $Removal != "YES"
 !insertmacro Install_Distros ; Install those distros
 ${ElseIf} $Removal == "YES"
  Call கட்டமைப்புநீக்க
 !insertmacro Uninstall_Distros ; Remove those distros
 ${EndIf}
 
SectionEnd

Function கட்டமைப்புநீக்க ; Find and Set Removal Configuration file
  ${If} ${FileExists} "$BDir\!\$DistroName\%\linux.cfg"
  StrCpy $DistroPath "linux.cfg"
  ${ElseIf} ${FileExists} "$BDir\!\$DistroName\%\anon.cfg"
  StrCpy $DistroPath "anon.cfg"  
  ${ElseIf} ${FileExists} "$BDir\!\$DistroName\%\system.cfg"
  StrCpy $DistroPath "system.cfg"
  ${ElseIf} ${FileExists} "$BDir\!\$DistroName\%\antivirus.cfg"
  StrCpy $DistroPath "antivirus.cfg"
  ${ElseIf} ${FileExists} "$BDir\!\$DistroName\%\netbook.cfg"
  StrCpy $DistroPath "netbook.cfg"
  ${ElseIf} ${FileExists} "$BDir\!\$DistroName\%\other.cfg"
  StrCpy $DistroPath "other.cfg"
  ${ElseIf} ${FileExists} "$BDir\!\$DistroName\%\pe.cfg"
  StrCpy $DistroPath "pe.cfg"
  ${ElseIf} ${FileExists} "$BDir\!\$DistroName\%\unlisted.cfg"
  StrCpy $DistroPath "unlisted.cfg"  
  ${ElseIf} ${FileExists} "$BDir\!\$DistroName\%\menu.lst"
  StrCpy $DistroPath "menu.lst"
  ${ElseIf} ${FileExists} "$BDir\!\$DistroName\%\vhd.lst"
  StrCpy $DistroPath "vhd.lst"
  ${ElseIf} ${FileExists} "$BDir\!\$DistroName\%\grubpart4.lst"
  StrCpy $DistroPath "grubpart4.lst"
  ${ElseIf} ${FileExists} "$BDir\!\$DistroName\%\grubram.lst"
  StrCpy $DistroPath "grubram.lst"
  ${ElseIf} ${FileExists} "$BDir\!\$DistroName\%\win.lst"
  StrCpy $DistroPath "win.lst"  
  ${ElseIf} ${FileExists} "$BDir\!\$DistroName\%\win2go.lst"
  StrCpy $DistroPath "win2go.lst"   
  ${ElseIf} ${FileExists} "$BDir\!\$DistroName\%\pe.lst"
  StrCpy $DistroPath "pe.lst"  
  ${ElseIf} ${FileExists} "$BDir\!\$DistroName\%\hirens.lst"
  StrCpy $DistroPath "hirens.lst"    
  ${EndIf}
  ; MessageBox MB_OK "$DistroPath"
FunctionEnd

Function கட்டமைப்புஎழுது
 ${If} $DistroPath == "linux.cfg"
  ${கணினிகோப்பில்எழுது} "label Linux Distributions$\r$\nmenu label Linux Distributions ->$\r$\nMENU INDENT 1$\r$\nCONFIG /!/menu/linux.cfg" $R0 
 ${ElseIf} $DistroPath == "anon.cfg"
  ${கணினிகோப்பில்எழுது} "label Anon $\r$\nmenu label Anonymous Browsers ->$\r$\nMENU INDENT 1$\r$\nCONFIG /!/menu/anon.cfg" $R0  
 ${ElseIf} $DistroPath == "system.cfg"
  ${கணினிகோப்பில்எழுது} "label System Tools$\r$\nmenu label System Tools ->$\r$\nMENU INDENT 1$\r$\nCONFIG /!/menu/system.cfg" $R0
 ${ElseIf} $DistroPath == "antivirus.cfg"
  ${கணினிகோப்பில்எழுது} "label Antivirus Tools$\r$\nmenu label Antivirus Tools ->$\r$\nMENU INDENT 1$\r$\nCONFIG /!/menu/antivirus.cfg" $R0 
 ${ElseIf} $DistroPath == "netbook.cfg"
  ${கணினிகோப்பில்எழுது} "label Netbook Distributions$\r$\nmenu label Netbook Distributions ->$\r$\nMENU INDENT 1$\r$\nCONFIG /!/menu/netbook.cfg" $R0 
 ${ElseIf} $DistroPath == "other.cfg"
  ${கணினிகோப்பில்எழுது} "label Other OS and Tools$\r$\nmenu label Other OS and Tools ->$\r$\nMENU INDENT 1$\r$\nCONFIG /!/menu/other.cfg" $R0 
 ${ElseIf} $DistroPath == "pe.cfg"
  ${கணினிகோப்பில்எழுது} "label Windows PE$\r$\nmenu label Windows PE ->$\r$\nMENU INDENT 1$\r$\nCONFIG /!/menu/pe.cfg" $R0   
 ${ElseIf} $DistroPath == "pe.lst"
  ${கணினிகோப்பில்எழுது} "label Windows PE$\r$\nmenu label Windows PE ->$\r$\nMENU INDENT 1$\r$\nKERNEL /!/grub.exe$\r$\nAPPEND --config-file=/!/menu/pe.lst" $R0   
 ${ElseIf} $DistroPath == "hirens.lst"
  ${கணினிகோப்பில்எழுது} "label Hiren's Boot CD PE$\r$\nmenu label Hiren's Boot CD PE ->$\r$\nMENU INDENT 1$\r$\nKERNEL /!/grub.exe$\r$\nAPPEND --config-file=/!/menu/hirens.lst" $R0    
 ${ElseIf} $DistroPath == "unlisted.cfg"
  ${கணினிகோப்பில்எழுது} "label Unlisted ISOs (via SYSLINUX)$\r$\nmenu label  Unlisted ISOs (via SYSLINUX) ->$\r$\nMENU INDENT 1$\r$\nCONFIG /!/menu/unlisted.cfg" $R0  
 ${ElseIf} $DistroPath == "menu.lst"
  ${கணினிகோப்பில்எழுது} "label Unlisted ISOs (via GRUB)$\r$\nmenu label Unlisted ISOs (via GRUB) ->$\r$\nMENU INDENT 1$\r$\nKERNEL /!/grub.exe$\r$\nAPPEND --config-file=/!/menu/menu.lst" $R0 
 ${ElseIf} $DistroPath == "vhd.lst"
  ${கணினிகோப்பில்எழுது} "label Unlisted ISOs (via Virtual Hard Disk)$\r$\nmenu label Unlisted ISOs (via Virtual Hard Disk) ->$\r$\nMENU INDENT 1$\r$\nKERNEL /!/grub.exe$\r$\nAPPEND --config-file=/!/menu/vhd.lst" $R0 
 ${ElseIf} $DistroPath == "grubpart4.lst"
  ${கணினிகோப்பில்எழுது} "label Unlisted ISOs (via GRUB Partition 4)$\r$\nmenu label Unlisted ISOs (via GRUB Partition 4) ->$\r$\nMENU INDENT 1$\r$\nKERNEL /!/grub.exe$\r$\nAPPEND --config-file=/!/menu/grubpart4.lst" $R0
 ${ElseIf} $DistroPath == "grubram.lst"
  ${கணினிகோப்பில்எழுது} "label Unlisted ISOs (via GRUB from RAM)$\r$\nmenu label Unlisted ISOs (via GRUB from RAM) ->$\r$\nMENU INDENT 1$\r$\nKERNEL /!/grub.exe$\r$\nAPPEND --config-file=/!/menu/grubram.lst" $R0   
 ${ElseIf} $DistroPath == "win.lst" 
  ${கணினிகோப்பில்எழுது} "label Windows Installers$\r$\nmenu label Windows Installers ->$\r$\nMENU INDENT 1$\r$\nKERNEL /!/grub.exe$\r$\nAPPEND --config-file=/!/menu/win.lst" $R0  
 ${ElseIf} $DistroPath == "win2go.lst"
  ${கணினிகோப்பில்எழுது} "label Windows to Go$\r$\nmenu label Windows to Go ->$\r$\nMENU INDENT 1$\r$\nKERNEL /!/grub.exe$\r$\nAPPEND --config-file=/!/menu/win2go.lst" $R0     
 ${EndIf} 
FunctionEnd

Function வெளியேறாதே
MessageBox MB_YESNO "$DestDisk இயக்ககத்தில் இப்போது மேலும் உதநிக்கள் / விநியோகங்களை சேர்க்க விரும்புகிறீர்களா?" IDYES noskip
    StrCmp $R8 3 0 End ;Compare $R8 variable with current page #
    StrCpy $R9 1 ; Goes to finish page
    Call உறவுபக்கத்திற்குச்செல்
    Abort
noskip:
;StrCpy $ShowAll "$ShowAll" ; Retain Display All Drives
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
StrCpy $ConfigFile "" ; Clear ConfigFile 
StrCpy $FormatMeFat "" ; Reset FormatMeFat Option
StrCpy $WipeMe "" ; Reset WipeMe Option
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
StrCpy $TASupport "NO" 
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
File /oname=$PLUGINSDIR\dskvol.txt "ஐ-மரபு\உரைகள்\dskvol.txt" 
File /oname=$PLUGINSDIR\diskpart.txt "ஐ-மரபு\உரைகள்\diskpart.txt" 
File /oname=$PLUGINSDIR\w2gdiskpart.txt "ஐ-மரபு\உரைகள்\w2gdiskpart.txt"   
File /oname=$PLUGINSDIR\dd-diskpart.txt "ஐ-மரபு\உரைகள்\dd-diskpart.txt" 
File /oname=$PLUGINSDIR\diskpartdetach.txt "ஐ-மரபு\உரைகள்\diskpartdetach.txt"  
File /oname=$PLUGINSDIR\autounattend.xml "ஐ-மரபு\உரைகள்\autounattend.xml"   
File /oname=$PLUGINSDIR\syslinux.exe "இருமங்கள்\கணிலினக்சு6.04.32.exe"  
File /oname=$PLUGINSDIR\syslinux.cfg "ஐ-மரபு\பட்டியல்\syslinux.cfg"
File /oname=$PLUGINSDIR\ஐ.மரபு "ஐ-மரபு\பட்டியல்\ஐ.மரபு"
File /oname=$PLUGINSDIR\menu.lst "ஐ-மரபு\பட்டியல்\menu.lst"
File /oname=$PLUGINSDIR\vhd.lst "ஐ-மரபு\பட்டியல்\vhd.lst" 
File /oname=$PLUGINSDIR\grubpart4.lst "ஐ-மரபு\பட்டியல்\grubpart4.lst"  
File /oname=$PLUGINSDIR\grubram.lst "ஐ-மரபு\பட்டியல்\grubram.lst"    
File /oname=$PLUGINSDIR\win.lst "ஐ-மரபு\பட்டியல்\win.lst"
File /oname=$PLUGINSDIR\win2go.lst "ஐ-மரபு\பட்டியல்\win2go.lst"  
File /oname=$PLUGINSDIR\grub.exe "இருமங்கள்\மாஒது_2.04.exe"
File /oname=$PLUGINSDIR\info "ஐ-மரபு\பட்டியல்\info"   
File /oname=$PLUGINSDIR\antivirus.cfg "ஐ-மரபு\பட்டியல்\antivirus.cfg" 
File /oname=$PLUGINSDIR\system.cfg "ஐ-மரபு\பட்டியல்\system.cfg" 
File /oname=$PLUGINSDIR\netbook.cfg "ஐ-மரபு\பட்டியல்\netbook.cfg"
File /oname=$PLUGINSDIR\linux.cfg "ஐ-மரபு\பட்டியல்\linux.cfg" 
File /oname=$PLUGINSDIR\anon.cfg "ஐ-மரபு\பட்டியல்\anon.cfg"
File /oname=$PLUGINSDIR\other.cfg "ஐ-மரபு\பட்டியல்\other.cfg"   
File /oname=$PLUGINSDIR\pe.cfg "ஐ-மரபு\பட்டியல்\pe.cfg"    
File /oname=$PLUGINSDIR\pe.lst "ஐ-மரபு\பட்டியல்\pe.lst"  
File /oname=$PLUGINSDIR\unlisted.cfg "ஐ-மரபு\பட்டியல்\unlisted.cfg"
File /oname=$PLUGINSDIR\liveusb "இருமங்கள்\வாழ்உதொபே"
File /oname=$PLUGINSDIR\7zG.exe "இருமங்கள்\7zG.exe"
File /oname=$PLUGINSDIR\7z.dll "இருமங்கள்\7z.dll"  
File /oname=$PLUGINSDIR\ஐ.png "..\அகர\அணிகலன்\ஐ.png"
File /oname=$PLUGINSDIR\உரிமை.உரை "..\அகர\பகவன்\உரிமை.உரை"
File /oname=$PLUGINSDIR\vesamenu.c32 "இருமங்கள்\vesamenu.c32" 
File /oname=$PLUGINSDIR\menu.c32 "இருமங்கள்\menu.c32"    
File /oname=$PLUGINSDIR\memdisk "இருமங்கள்\நினைவட்டு" 
File /oname=$PLUGINSDIR\chain.c32 "இருமங்கள்\chain.c32" 
File /oname=$PLUGINSDIR\libcom32.c32 "இருமங்கள்\libcom32.c32"  
File /oname=$PLUGINSDIR\libutil.c32 "இருமங்கள்\libutil.c32"   
File /oname=$PLUGINSDIR\linux.c32 "இருமங்கள்\linux.c32"  
File /oname=$PLUGINSDIR\wimboot "இருமங்கள்\wimboot"   
File /oname=$PLUGINSDIR\ifcpu64.c32 "இருமங்கள்\ifcpu64.c32" 
File /oname=$PLUGINSDIR\remount.cmd "ஐ-மரபு\உரைகள்\remount.cmd"
File /oname=$PLUGINSDIR\boot.cmd "ஐ-மரபு\உரைகள்\boot.cmd"
File /oname=$PLUGINSDIR\vhdremount.cmd "ஐ-மரபு\உரைகள்\vhdremount.cmd"
File /oname=$PLUGINSDIR\ei.cfg "ஐ-மரபு\பட்டியல்\ei.cfg"
File /oname=$PLUGINSDIR\dd.exe "இருமங்கள்\தரவுவரையறை.exe"
File /oname=$PLUGINSDIR\fat32format.exe "இருமங்கள்\கோஒஅ32வடிவம்.exe"
SetOutPath "$PLUGINSDIR"  
File /r "இருமங்கள்\wimlib" 
SetOutPath ""  
FunctionEnd

!include துணை\புதையல்நிலை.நிரல்
/*
Function கோமுவகைபெறு
System::Call 'Kernel32::GetVolumeInformation(t "$9",t,i ${NSIS_MAX_STRLEN},*i,*i,*i,t .r1" ,i ${NSIS_MAX_STRLEN}) i.r0'
 StrCpy $FSType "$1"
FunctionEnd
/*
