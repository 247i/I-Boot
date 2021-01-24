/*   
  This file is part of YUMI
 
  YUMI is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 2 of the License, or
  any later version.
 
  YUMI is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.
 
  You should have received a copy of the GNU General Public License
  along with YUMI.  If not, see <http://www.gnu.org/licenses/>.
  
  YUMI Copyright © https://www.pendrivelinux.com (See YUMI-Copying.txt and YUMI-Readme.txt for more information, and additional Credits)
 */
 
!define NAME "YUMI"
!define FILENAME "YUMI"
!define VERSION "2.0.8.3"
!define MUI_ICON "images\usbicon.ico" ; "${NSISDIR}\Contrib\Graphics\Icons\nsis1-install.ico"

; MoreInfo Plugin - Adds Version Tab fields to Properties. Plugin created by onad http://nsis.sourceforge.net/MoreInfo_plug-in
VIProductVersion "${VERSION}"
VIAddVersionKey CompanyName "pendrivelinux.com"
VIAddVersionKey LegalCopyright "Copyright ©2021 Pendrivelinux.com"
VIAddVersionKey FileVersion "${VERSION}"
VIAddVersionKey FileDescription "YUMI"
VIAddVersionKey License "GPL Version 2"

Name "${NAME} ${VERSION}"
OutFile "${FILENAME}-${VERSION}.exe"
RequestExecutionLevel admin ;highest
SetCompressor /SOLID lzma
CRCCheck On
XPStyle on
ShowInstDetails show
BrandingText "${NAME} ${VERSION}"
CompletedText "All Finished, Process is Complete!"
InstallButtonText "Create"
Unicode True

!include WordFunc.nsh
!include nsDialogs.nsh
!include MUI2.nsh
!include FileFunc.nsh
!include LogicLib.nsh
;!include TextFunc.nsh
!AddPluginDir "plugins"

; Variables
;Var HDDUSB
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
Var AllDriveOption
Var DisplayAll
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
!define MUI_HEADERIMAGE_BITMAP "images\usb-logo-nsis.bmp" 
!define MUI_HEADERIMAGE_BITMAP_NOSTRETCH
!define MUI_HEADERIMAGE_RIGHT

; License Agreement Page
!define MUI_TEXT_LICENSE_SUBTITLE $(License_Subtitle)
!define MUI_LICENSEPAGE_TEXT_TOP $(License_Text_Top)
!define MUI_LICENSEPAGE_TEXT_BOTTOM $(License_Text_Bottom)
!define MUI_PAGE_CUSTOMFUNCTION_PRE License_PreFunction
!insertmacro MUI_PAGE_LICENSE "YUMI-Copying.txt"

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
!define MUI_FINISHPAGE_LINK_LOCATION "https://www.pendrivelinux.com/yumi-multiboot-usb-creator/"
!define MUI_WELCOMEFINISHPAGE_BITMAP "images\finish.bmp"
!define MUI_PAGE_CUSTOMFUNCTION_PRE Finish_PreFunction
!insertmacro MUI_PAGE_FINISH

; English Language files
!insertmacro MUI_LANGUAGE "English" ; first language is the default language
LangString License_Subtitle ${LANG_ENGLISH} "Please review the license terms before proceeding"
LangString License_Text_Top ${LANG_ENGLISH} "The software within this program falls under the following Licenses."
LangString License_Text_Bottom ${LANG_ENGLISH} "You must accept the terms of this License agreement to run this ${NAME}. If you agree, Click I Agree to Continue."
LangString SelectDist_Title ${LANG_ENGLISH} "Drive Selection and Distro Options Page"
LangString SelectDist_Subtitle ${LANG_ENGLISH} "Choose your Flash Drive, and a Distro, ISO/ZIP file.$\r$\nAdditional Distributions can be added each time this tool is run."
LangString DrivePage_Text ${LANG_ENGLISH} "Step 1: Select the drive letter of your USB device."
LangString Distro_Text ${LANG_ENGLISH} "Step 2: Select a Distribution from the list to put on your USB."
LangString IsoPage_Text ${LANG_ENGLISH} "Step 3: Select the $FileFormat (Name must be the same as above)."
LangString IsoPage_Title ${LANG_ENGLISH} "Select Your $FileFormat"
LangString Casper_Text ${LANG_ENGLISH} "Step 4: Set a Persistent file size for storing changes (Optional)."
LangString IsoFile ${LANG_ENGLISH} "$FileFormat file|$ISOFileName" ;$ISOFileName variable previously *.iso
LangString Extract ${LANG_ENGLISH} "Extracting the $FileFormat: The progress bar will not move until finished. Please be patient..."
LangString CreateSysConfig ${LANG_ENGLISH} "Creating configuration files for $DestDisk"
LangString ExecuteSyslinux ${LANG_ENGLISH} "Executing syslinux on $BootDir"
LangString SkipSyslinux ${LANG_ENGLISH} "Good Syslinux Exists..."
LangString WarningSyslinux ${LANG_ENGLISH} "An error ($R8) occurred while executing syslinux.$\r$\nYour USB drive won't be bootable...$\r$\n$\r$\n$FSType filesystem detected. Your drive must be formatted as Fat32 or NTFS."
LangString WarningSyslinuxOLD ${LANG_ENGLISH} "This YUMI revision uses a newer Syslinux version that is not compatible with earlier revisions.$\r$\nPlease ensure your USB drive doesn't contain earlier revision installs."
LangString Install_Title ${LANG_ENGLISH} "$InUnStalling $InUnName"
LangString Install_SubTitle ${LANG_ENGLISH} "Please wait while we $InUnStall $InUnName $OnFrom $JustDrive"
LangString Install_Finish_Sucess ${LANG_ENGLISH} "${NAME} $InUnStalled $InUnName $OnFrom $JustDrive"
LangString Finish_Install ${LANG_ENGLISH} "Process Complete."
LangString Finish_Title ${LANG_ENGLISH} "Thanks for using ${NAME}"
LangString Finish_Text ${LANG_ENGLISH} "Your Selections have been $InUnStalled on your USB drive.$\r$\n$\r$\nFeel Free to run this tool again to $InUnStall more Distros.$\r$\n$\r$\nYUMI will keep track of selections you have already $InUnStalled."
LangString Finish_Link ${LANG_ENGLISH} "Visit the YUMI Home Page"

!include FileManipulation.nsh ; Text File Manipulation
!include FileNames.nsh ; Macro for FileNames
!include DistroList.nsh ; List of Distributions
!include StrContains.nsh
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
  ${NSD_CreateCheckBox} 60% 0 44% 15 "View or Remove Installed Distros?"
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
  
; Force Show All ISO Option
  ${NSD_CreateCheckBox} 80% 100 20% 9u "Show All ISOs?"
  Pop $ForceShowAll
  ${NSD_OnClick} $ForceShowAll ShowAllISOs   

; ISO Download Option
  ${NSD_CreateCheckBox} 60% 60 40% 15 "Download the ISO (Optional)."
  Pop $DownloadISO
  ${NSD_OnClick} $DownloadISO DownloadIt  
  
; Clickable Link to Distribution Homepage  
  ${NSD_CreateLink} 60% 80 40% 15 "Visit the $OfficialName HomePage"
  Pop $DistroLink
  ${NSD_OnClick} $DistroLink onClickLinuxSite    

; ISO Selection Starts  
  ${NSD_CreateLabel} 0 100 100% 15 $(IsoPage_Text)
  Pop $LabelISOSelection
  ${NSD_CreateText} 0 120 78% 20 "Browse to and select the $FileFormat"
  Pop $ISOFileTxt 
  ${NSD_CreateBrowseButton} 85% 120 60 20 "Browse"
  Pop $ISOSelection 
  ${NSD_OnClick} $ISOSelection ISOBrowse   
  
; Casper-RW Selection Starts
  ${NSD_CreateLabel} 0 150 75% 15 ""
  Pop $CasperSelection  

  ${NSD_CreateLabel} 52% 178 25% 25 ""
  Pop $SlideSpot  

  nsDialogs::CreateControl "msctls_trackbar32" "0x50010000|0x00000018" "" 0 174 50% 25 ""
  Pop $CasperSlider
  SendMessage $CasperSlider ${TBM_SETRANGEMIN} 1 0 ; Min Range Value 0
  SendMessage $CasperSlider ${TBM_SETRANGEMAX} 1 $RemainingSpace ; Max Range Value
  ${NSD_OnNotify} $CasperSlider onNotify_CasperSlider    

; Drive Pre-Selection  
  ${NSD_CreateLabel} 0 0 58% 15 ""
  Pop $LabelDrivePage 
  ${NSD_SetText} $LabelDrivePage "Step 1: YUMI Summoned $DestDisk as your USB Device"  
; Droplist for Drive Selection  
  ${NSD_CreateDropList} 0 20 42% 15 "" ; was 0 20 55% 15
  Pop $DestDriveTxt 
  
   ${If} $ShowAll == "YES"
   ${GetDrives} "FDD+HDD" DrivesList ; All Drives Listed
   ${ElseIf} $ShowAll == "NO"
   ${GetDrives} "FDD" DrivesList ; FDD+HDD reduced to FDD for removable media only
   ${EndIf}
  
  ${NSD_CB_SelectString} $DestDriveTxt "$DestDrive"
  ${NSD_GetText} $DestDriveTxt $Letters
  StrCpy $JustDrive $DestDrive 3  
  StrCpy $BootDir $DestDrive 2  
  StrCpy $DestDisk $DestDrive 2
  StrCpy $9 $JustDrive
  Call GetFSType
  Call PhysDrive
  SendMessage $Distro ${CB_RESETCONTENT} 0 0 ; was ${NSD_LB_Clear} $Distro "" ; Clear all distro entries because a new drive may have been chosen ; Enable for DropBox
  StrCpy $Checker "Yes"  
  Call InstallorRemove
  Call SetSpace
  Call CheckSpace
  Call FormatIt 
  Call EnableNext 
  
  ${NSD_OnChange} $DestDriveTxt OnSelectDrive  

; All Drives Option
  ${NSD_CreateCheckBox} 43% 23 16% 15 "Refresh?" 
  Pop $AllDriveOption
  ${NSD_OnClick} $AllDriveOption ListAllDrives    				   
  
; Add Home Link
  ${NSD_CreateLink} 0 215 16% 15 "Home Page"
  Pop $Link
  ${NSD_OnClick} $LINK onClickMyLink    
  
; Add Help Link
  ${NSD_CreateLink} 16% 215 9% 15 "FAQ"
  Pop $Link1
  ${NSD_OnClick} $LINK1 onClickMyLinkFAQ 
  
; Add Giveback Link
  ${NSD_CreateLink} 25% 215 30% 15 "Recommended Flash Drives"
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
  ShowWindow $ForceShowAll 0
  ShowWindow $CasperSelection 0 
  ShowWindow $CasperSlider 0 
  ShowWindow $SlideSpot 0   
  StrCpy $JustISOName "NULL" ; Set to NULL until something is selected
  nsDialogs::Show  
  
 ${Else}
  
; To Install or Uninstall? That is the question!  
  ${NSD_CreateCheckBox} 60% 0 44% 15 "View or Remove Installed Distros?"
  Pop $Uninstaller
  ${NSD_OnClick} $Uninstaller Uninstall  
  
; Alt Wipe Disk and all Partitions, Volumes.
  ${NSD_CreateCheckBox} 60% 0 44% 15 "Wipe Entire (Disk $DiskNum)"
  Pop $Wipe
  ${NSD_OnClick} $Wipe WipeIt     
  
; Drive Selection Starts  
  ${NSD_CreateLabel} 0 0 58% 15 ""    
  Pop $LabelDrivePage
  ${NSD_SetText} $LabelDrivePage "Step 1: Select the Drive Letter of your USB Device."    
  
; Droplist for Drive Selection
  ${NSD_CreateDropList} 0 20 42% 15 "" ; was 0 20 55% 15
  Pop $DestDriveTxt
  Call ListAllDrives
  ${NSD_OnChange} $DestDriveTxt OnSelectDrive 
; All Drives Option
  ${NSD_CreateCheckBox} 43% 23 16% 15 "Refresh?"
  Pop $AllDriveOption
  ${NSD_OnClick} $AllDriveOption ListAllDrives 				   				  
  
; Format Drive Option
  ${NSD_CreateCheckBox} 60% 23 100% 15 "NTFS Format $DestDisk"
  Pop $Format
  ${NSD_OnClick} $Format FormatIt  

; Format Fat32 Option
  ${NSD_CreateCheckBox} 60% 40 100% 15 "Fat32 Format $DestDisk"
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
  ${NSD_CreateCheckBox} 80% 100 20% 9u "Show All ISOs?"
  Pop $ForceShowAll
  ${NSD_OnClick} $ForceShowAll ShowAllISOs    

; ISO Download Option
  ${NSD_CreateCheckBox} 60% 60 40% 15 "Download the ISO (Optional)."
  Pop $DownloadISO
  ${NSD_OnClick} $DownloadISO DownloadIt  
  
; Clickable Link to Distribution Homepage  
  ${NSD_CreateLink} 60% 80 40% 15 "Visit the $OfficialName HomePage"
  Pop $DistroLink
  ${NSD_OnClick} $DistroLink onClickLinuxSite    

; ISO Selection Starts  
  ${NSD_CreateLabel} 0 100 100% 15 $(IsoPage_Text)
  Pop $LabelISOSelection
  ${NSD_CreateText} 0 120 78% 20 "Browse to and select the $FileFormat"
  Pop $ISOFileTxt 
  ${NSD_CreateBrowseButton} 85% 120 60 20 "Browse"
  Pop $ISOSelection 
  ${NSD_OnClick} $ISOSelection ISOBrowse

; Casper-RW Selection Starts
  ${NSD_CreateLabel} 0 150 75% 15 "" ;$(Casper_Text)
  Pop $CasperSelection  

  ${NSD_CreateLabel} 52% 178 25% 25 ""
  Pop $SlideSpot  

  nsDialogs::CreateControl "msctls_trackbar32" "0x50010000|0x00000018" "" 0 174 50% 25 ""
  Pop $CasperSlider

  SendMessage $CasperSlider ${TBM_SETRANGEMIN} 1 0 ; Min Range Value 0
  SendMessage $CasperSlider ${TBM_SETRANGEMAX} 1 $RemainingSpace ; Max Range Value
  ${NSD_OnNotify} $CasperSlider onNotify_CasperSlider  

; Add Home Link
  ${NSD_CreateLink} 0 215 16% 15 "Home Page"
  Pop $Link
  ${NSD_OnClick} $LINK onClickMyLink    
  
; Add Help Link
  ${NSD_CreateLink} 16% 215 9% 15 "FAQ"
  Pop $Link1
  ${NSD_OnClick} $LINK1 onClickMyLinkFAQ 
  
; Add Giveback Link
  ${NSD_CreateLink} 25% 215 30% 15 "Recommended Flash Drives"
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
  ${NSD_GetState} $AllDriveOption $DisplayAll
  ${If} $DisplayAll == ${BST_CHECKED}
  ${NSD_Check} $AllDriveOption
  ${NSD_SetText} $AllDriveOption "Refreshed" 
   StrCpy $ShowAll "YES"
   ${GetDrives} "FDD+HDD" DrivesList
  ${ElseIf} $DisplayAll == ${BST_UNCHECKED}
  ${NSD_Uncheck} $AllDriveOption
  ${NSD_SetText} $AllDriveOption "Refresh?"  
   ${GetDrives} "FDD+HDD" DrivesList
   StrCpy $ShowAll "NO"
  ${EndIf}										  
FunctionEnd

Function onClickMyLink
  Pop $Links ; pop something to prevent corruption
  ExecShell "open" "https://www.pendrivelinux.com/yumi-multiboot-usb-creator/"
FunctionEnd

Function onClickMyLinkFAQ
  Pop $Links1 ; pop something to prevent corruption
  ExecShell "open" "https://www.pendrivelinux.com/yumi-multiboot-usb-creator/#FAQ"
FunctionEnd

Function onClickMyLinkUSB
  Pop $Links2 ; pop something to prevent corruption
  ExecShell "open" "https://www.pendrivelinux.com/recommended-usb-flash-drives/"
FunctionEnd

Function onClickLinuxSite
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
  ;${If} $Blocksize >= 4 
  ${If} $Removal != "Yes"
  ;${AndIf} $HDDUSB != "HDD"
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
  StrCpy $InUnStall "Add"	
   StrCpy $InUnStalling "Adding"	
    StrCpy $InUnStalled "Added"	
  StrCpy $OnFrom "to"
  StrCpy $InUnName "$JustISOName"
  GetDlgItem $6 $HWNDPARENT 1 ; Get "Install" control handle
   SendMessage $6 ${WM_SETTEXT} 0 "STR:Create"
    EnableWindow $6 1 ; Enable "Install" control button

  ${ElseIf} $Removal == "Yes"
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

; !include StrContains.nsh ; Let's check if a * wildcard exists
 
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
  ${NSD_SetText} $LabelISOSelection "Step 3: Browse and Select your $ISOFileName"
  ${NSD_SetText} $ISOFileTxt "Browse to your $ISOFileName  -->"
  SetCtlColors $ISOFileTxt FF0000 FFFFFF  
  StrCpy $ISOTest "" ; Set to null until a new ISO selection is made
  ${EndIf}
  
; Redraw Home page Links as necessary
  ${NSD_SetText} $DistroLink "Visit the $OfficialName Home Page" 
  ShowWindow $DistroLink 0
  ${If} $OfficialName == ""
   ${OrIf} $Removal == "Yes"
  ShowWindow $DistroLink 0
  ${Else}
  ShowWindow $DistroLink 1
  ${EndIf}    
  
  ${If} $DistroName != ""
  ${NSD_SetText} $LinuxDistroSelection "Step 2: $DistroName Selected"
  ${Else}
  ${NSD_SetText} $LinuxDistroSelection "Step 2: Select a Distribution to put on $DestDisk"
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
  ${NSD_SetText} $LabelISOSelection "Step 3 DONE: $ISOFileName Found and Selected!"  
  StrCpy $ISOTest "$TheISO" ; Populate ISOTest so we can enable Next    
  Call EnableNext  
  
 ${ElseIf} ${FileExists} "$EXEDIR\$ISOFileName"
 ${AndIf} $Removal != "Yes"
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
 MessageBox MB_OK "$JustISOName is already on $DestDisk$\r$\nPlease Remove it first!$\r$\n$\r$\nNOTE: If you have already removed it using YUMI,$\r$\nmanually delete the $BootDir\multiboot\$JustISOName\ folder."
 ${Else}
 ${EndIf}
 Call EnableNext
 ; Uncomment for Testing --> MessageBox MB_ICONQUESTION|MB_OK 'Removal: "$Removal"  ISOFileName: "$ISOFileName" ISOFile "$ISOFile" BootDir: "$BootDir" DestDisk: "$DestDisk" DestDrive: "$DestDrive" ISOTest: "$ISOTest"'
  ${If} $FSType != "NTFS"
  ${AndIf} $FormatMe != "Yes"
  ${AndIf} $DistroName == "Windows to Go (Virtual Hard Disk)"
  MessageBox MB_ICONSTOP|MB_OK "WARNING! ($DestDisk) is not NTFS formatted. NTFS is required for the Windows to Go option to work."
 
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
    ${NSD_SetText} $LinuxDistroSelection "Step 2: Select a Distribution to put on $DestDisk" 
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
	SendMessage $6 ${WM_SETTEXT} 0 "STR:Remove"
	EnableWindow $6 0 ; Disable "Install" control button
  ${NSD_SetText} $Uninstaller "You're in Uninstaller Mode!"
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
     StrCpy $Checker "Yes"         
     Call SetISOFileName
  ${EndIf}  
FunctionEnd

;Function TEST
;  MessageBox MB_ICONSTOP|MB_OK "Triggered" 
;FunctionEnd

; On Selection of USB Drive
Function OnSelectDrive
  Pop $DestDriveTxt
  ${NSD_GetText} $DestDriveTxt $Letters
  StrCpy $DestDrive "$Letters"
  StrCpy $JustDrive $DestDrive 3  
  StrCpy $BootDir $DestDrive 2 ;was -1 
  StrCpy $DestDisk $DestDrive 2 ;was -1
  ;StrCpy $HDDUSB $Letters "" -3 
  
  StrCpy $9 $JustDrive
  Call GetFSType
  Call PhysDrive
  ${NSD_SetText} $LabelDrivePage "Step 1: You Selected $DestDisk on (Disk $DiskNum) as your USB Device"   
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
  MessageBox MB_ICONSTOP|MB_OK "WARNING! Syslinux won't work on exFAT formatted devices. Please format $DestDisk Fat32 or NTFS."
  ${EndIf} 
  
  ${If} ${FileExists} "$BootDir\boot\grub\yumi.png"  
   ${AndIf} ${FileExists} "$BootDir\boot\grub\lnxboot.img"
    ${AndIf} ${FileExists} "$BootDir\boot\grub\core.img" 
     ${AndIf} ${FileExists} "$BootDir\boot\grub\grub.cfg"  
     MessageBox MB_ICONSTOP|MB_OK "WARNING! ($DestDisk) contains a UEFI YUMI or GRUB2 based Installation which is not compatible with this version.$\r$\n$\r$\nYou'll need to format this drive if you plan to use this version of YUMI."
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
  ${AndIf} $DiskNum != "0" ; prevent (Disk 0) from being added... it's most likely the Booted system drive?
  ${AndIf} $Capacity >= "1" ; Prevent capacity lower than 1GB from being displayed.
  SendMessage $DestDriveTxt ${CB_ADDSTRING} 0 "STR:$9 (Disk $DiskNum) $VolName $Capacity $FSType" ;$8
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

  File /oname=$PLUGINSDIR\diskpartformat.txt "diskpartformat.txt"     
  File /oname=$PLUGINSDIR\diskpartwipe1.txt "diskpartwipe1.txt"  
  File /oname=$PLUGINSDIR\diskpartwipe2.txt "diskpartwipe2.txt"    
  
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
  ${NSD_SetText} $ForceShowAll "Show All ISOs!"
    SendMessage $ISOSelection ${CB_RESETCONTENT} 0 0 
 
  ${ElseIf} $ShowingAll == ${BST_UNCHECKED}
  ${NSD_Uncheck} $ForceShowAll
  ${NSD_SetText} $ForceShowAll "Show All ISOs?"  
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
  ;MessageBox MB_ICONSTOP|MB_OK "$Casper - - $FormatMeFat"
  Call FreeDiskSpace
  IntOp $MaxPersist 4090 + $CasperSize ; Space required for distro and 4GB max persistent file
   ${If} $1 > $MaxPersist ; Check if more space is available than we need for distro + 4GB persistent file
   StrCpy $RemainingSpace 4090 ; Set maximum possible value to 4090 MB (any larger wont work on fat32 Filesystem)
   ${Else}
   StrCpy $RemainingSpace "$1"
   IntOp $RemainingSpace $RemainingSpace - $SizeOfCasper ; Remaining space minus distro size
   ${EndIf}

 ${Else}  
  Call FreeDiskSpace
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

Function HaveSpacePre ; Check space required
 ${If} $FormatMe != "Yes" ; FIXME: Need to find a better method to check disk space when the drive appears unformatted (I.E. after it's been dd'd, etc).
 ${AndIf} $FormatMeFat != "Yes"
  Call CasperSize
  Call FreeDiskSpace
  System::Int64Op $1 > $SizeOfCasper ; Compare the space available > space required
  Pop $3 ; Get the result ...
  IntCmp $3 1 okay ; ... and compare it
  MessageBox MB_ICONSTOP|MB_OK "Oops: There is not enough disk space! $1 MB Free, $SizeOfCasper MB Needed on $JustDrive Drive. Do you need to format it?"
  okay: ; Proceed to execute...
 ${EndIf}
FunctionEnd

Function HaveSpace ; Check space required
  Call CasperSize
  Call FreeDiskSpace
  System::Int64Op $1 > $SizeOfCasper ; Compare the space available > space required
  Pop $3 ; Get the result ...
  IntCmp $3 1 okay ; ... and compare it
  MessageBox MB_ICONSTOP|MB_OK "Not enough free space remains. Closing YUMI!"
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

; DeleteMenuEntry function is based on RemoveAfterLine function, by Afrow UK http://nsis.sourceforge.net/Delete_lines_from_one_line_to_another_line_inclusive.
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

Function DoSyslinux ; Install Syslinux on USB
  ${IfNot} ${FileExists} "$BootDir\multiboot\libcom32.c32" 
  ${AndIf} ${FileExists} "$BootDir\multiboot\ldlinux.sys"   
  MessageBox MB_ICONEXCLAMATION|MB_OK $(WarningSyslinuxOLD)
  Quit
  ${EndIf}
  
  IfFileExists "$BootDir\multiboot\libcom32.c32" SkipSyslinux CreateSyslinux ; checking for newer syslinux
  CreateSyslinux:
  CreateDirectory $BootDir\multiboot\menu ; recursively create the directory structure if it doesn't exist
  CreateDirectory $BootDir\multiboot\ISOS ; create ISOS folder  
  DetailPrint $(ExecuteSyslinux)
  ;ExecWait '$PLUGINSDIR\syslinux.exe -maf -d /multiboot $BootDir' $R8
  ;DetailPrint "Syslinux Errors $R8"
  nsExec::Exec '"$PLUGINSDIR\syslinux.exe" -maf -d /multiboot $BootDir'
  ;nsExec::Exec '"$PLUGINSDIR\syslinux.exe" -maf -d /multiboot $BootDir $BootDir\multiboot\syslinux.bin'
  Pop $R8
  DetailPrint "Syslinux Errors $R8"
  
  ${If} $R8 != 0
  MessageBox MB_ICONEXCLAMATION|MB_OK $(WarningSyslinux)
  ${EndIf} 
  DetailPrint "Creating Label MULTIBOOT on $DestDisk"
  nsExec::ExecToLog '"cmd" /c "LABEL $DestDiskMULTIBOOT"'
  
  SkipSyslinux: 
  DetailPrint $(SkipSyslinux)
  
   ${IfNot} ${FileExists} $BootDir\multiboot\linux.c32 ; need linux.c32 to launch wimboot from syslinux.  
    DetailPrint "Adding wimboot and linux.c32."   
    CopyFiles "$PLUGINSDIR\wimboot" "$BootDir\multiboot\wimboot"
    CopyFiles "$PLUGINSDIR\linux.c32" "$BootDir\multiboot\linux.c32"  
   ${EndIf}     

   ${IfNot} ${FileExists} $BootDir\multiboot\legacy-yumi ; legacy-yumi test file.  
    DetailPrint "Adding legacy-yumi test file."   
    CopyFiles "$PLUGINSDIR\legacy-yumi" "$BootDir\multiboot\legacy-yumi"  
   ${EndIf}
  
  ${If} ${FileExists} $BootDir\multiboot\syslinux.cfg    
   DetailPrint "A Previous MultiBoot Installation was detected... proceeding to add your new selections."
   Call AddDir
  ${Else}
; Create and Copy files to your destination
  DetailPrint "Adding required files to the $BootDir\multiboot directory..." 
  CopyFiles "$PLUGINSDIR\syslinux.cfg" "$BootDir\multiboot\syslinux.cfg"
  CopyFiles "$PLUGINSDIR\yumi.png" "$BootDir\multiboot\yumi.png"
  CopyFiles "$PLUGINSDIR\YUMI-Copying.txt" "$BootDir\multiboot\YUMI-Copying.txt" 
  CopyFiles "$PLUGINSDIR\YUMI-Readme.txt" "$BootDir\multiboot\YUMI-Readme.txt" 
  CopyFiles "$PLUGINSDIR\license.txt" "$BootDir\multiboot\license.txt"   
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
  CopyFiles "$PLUGINSDIR\yumi.png" "$BootDir\multiboot\yumi.png"
  CopyFiles "$PLUGINSDIR\YUMI-Copying.txt" "$BootDir\multiboot\YUMI-Copying.txt" 
  CopyFiles "$PLUGINSDIR\YUMI-Readme.txt" "$BootDir\multiboot\YUMI-Readme.txt" 
  CopyFiles "$PLUGINSDIR\license.txt" "$BootDir\multiboot\license.txt"   
  CopyFiles "$PLUGINSDIR\vesamenu.c32" "$BootDir\multiboot\vesamenu.c32"
  CopyFiles "$PLUGINSDIR\menu.c32" "$BootDir\multiboot\menu.c32"  
  CopyFiles "$PLUGINSDIR\chain.c32" "$BootDir\multiboot\chain.c32"
  CopyFiles "$PLUGINSDIR\libcom32.c32" "$BootDir\multiboot\libcom32.c32"  
  CopyFiles "$PLUGINSDIR\libutil.c32" "$BootDir\multiboot\libutil.c32"   
  CopyFiles "$PLUGINSDIR\memdisk" "$BootDir\multiboot\memdisk"
 ${EndIf}    

; Check to ensure menu.c32 exists... now required for YUMI V2
  ${IfNot} ${FileExists} $BootDir\multiboot\menu.c32
   DetailPrint "Adding menu.c32. Required for YUMI V2"
   CopyFiles "$PLUGINSDIR\menu.c32" "$BootDir\multiboot\menu.c32" 
  ${EndIf}	   
FunctionEnd

Function AddDir ; changes to check if user had a version prior to 0.0.0.3. Newer YUMI includes grub.exe 
 ${IfNotThen} ${FileExists} "$BootDir\multiboot\grub.exe" 'CopyFiles "$PLUGINSDIR\grub.exe" "$BootDir\multiboot\grub.exe"' 
FunctionEnd

; ---- Let's Do This Stuff ----
Section  ; This is the only section that exists
; Get just the name of the ISO file 
Push "$ISOFile"
Push 1
Call GrabNameOnly
Pop $NameThatISO

 ${If} ${FileExists} "$BootDir\windows\system32" ; Additional safeguard to prevent installation to a Windows partition.
 MessageBox MB_ICONSTOP|MB_OK "ABORTING! ($DestDisk) contains a WINDOWS/SYSTEM32 Directory."
 Quit
 ${EndIf}

; Wipe and Format ---
 ${If} $FormatMe == "Yes" 
  ${AndIf} $WipeMe == "Yes" 
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "WARNING: Backup any data you want to keep before proceeding! All Data on (Disk $DiskNum) including any attached drive letters, partitions and volumes, even if hidden, will be wiped.$\r$\n$\r$\n${NAME} is ready to perform the following actions:$\r$\n$\r$\n1.) Wipe (Disk $DiskNum) - Data will be Irrecoverably Deleted!$\r$\n$\r$\n2.) Recreate Drive Letter ($DestDisk) with a single NTFS partition.$\r$\n$\r$\n3.) Create a Syslinux MBR on ($DestDisk) - Existing MBR will be Overwritten!$\r$\n$\r$\n4.) Create MULTIBOOT Label on ($DestDisk) - Existing Label will be Overwritten!$\r$\n$\r$\n5.) Install ($DistroName) on ($DestDisk)$\r$\n$\r$\nAre you absolutely positive (Disk $DiskNum) is the correct Disk?$\r$\nDouble Check with Windows diskmgmt to make sure!$\r$\n$\r$\nClick YES to perform these actions or NO to Abort!" IDYES proceed
  Quit
 ${ElseIf} $FormatMeFat == "Yes" 
  ${AndIf} $WipeMe == "Yes" 
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "WARNING: Backup any data you want to keep before proceeding! All Data on (Disk $DiskNum) including any attached drive letters, partitions and volumes, even if hidden, will be wiped.$\r$\n$\r$\n${NAME} is ready to perform the following actions:$\r$\n$\r$\n1.) Wipe (Disk $DiskNum) - Data will be Irrecoverably Deleted!$\r$\n$\r$\n2.) Recreate Drive Letter ($DestDisk) with a single Fat32 partition.$\r$\n$\r$\n3.) Create a Syslinux MBR on ($DestDisk) - Existing MBR will be Overwritten!$\r$\n$\r$\n4.) Create MULTIBOOT Label on ($DestDisk) - Existing Label will be Overwritten!$\r$\n$\r$\n5.) Install ($DistroName) on ($DestDisk)$\r$\n$\r$\nAre you absolutely positive (Disk $DiskNum) is the correct USB Device?$\r$\nDouble Check with Windows diskmgmt to make sure!$\r$\n$\r$\nClick YES to perform these actions or NO to Abort!" IDYES proceed
  Quit
  
; Format Only ---
 ${ElseIf} $FormatMe == "Yes" 
  ${AndIf} $WipeMe == "No" 
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "WARNING: Backup any data you want to keep before proceeding! All Data on Drive Letter ($DestDisk) will be deleted.$\r$\n$\r$\n${NAME} is ready to perform the following actions:$\r$\n$\r$\n1.) Lock and Dismount Drive Letter ($DestDisk).$\r$\n$\r$\n2.) NTFS Format ($DestDisk) - Data on ($DestDisk) will be Irrecoverably Deleted!$\r$\n$\r$\n3.) Create a Syslinux MBR on ($DestDisk) - Existing MBR will be Overwritten!$\r$\n$\r$\n4.) Create MULTIBOOT Label on ($DestDisk) - Existing Label will be Overwritten!$\r$\n$\r$\n5.) Install ($DistroName) on ($DestDisk)$\r$\n$\r$\nAre you absolutely positive ($DestDisk) on (Disk $DiskNum) is your USB Device?$\r$\nDouble Check with Windows and diskmgmt to make sure!$\r$\n$\r$\nClick YES to perform these actions or NO to Abort!" IDYES proceed
  Quit
 ${ElseIf} $FormatMeFat == "Yes" 
  ${AndIf} $WipeMe == "No" 
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "WARNING: Backup any data you want to keep before proceeding! All Data on Drive Letter ($DestDisk) will be deleted.$\r$\n$\r$\n${NAME} is ready to perform the following actions:$\r$\n$\r$\n1.) Lock and Dismount Drive Letter ($DestDisk).$\r$\n$\r$\n2.) Fat32 Format ($DestDisk) - Data on ($DestDisk) will be Irrecoverably Deleted!$\r$\n$\r$\n3.) Create a Syslinux MBR on ($DestDisk) - Existing MBR will be Overwritten!$\r$\n$\r$\n4.) Create MULTIBOOT Label on ($DestDisk) - Existing Label will be Overwritten!$\r$\n$\r$\n5.) Install ($DistroName) on ($DestDisk)$\r$\n$\r$\nAre you absolutely positive ($DestDisk) on (Disk $DiskNum) is your USB Device?$\r$\nDouble Check with Windows and diskmgmt to make sure!$\r$\n$\r$\nClick YES to perform these actions or NO to Abort!" IDYES proceed
  Quit  
  
; Don't Wipe or Format ---
 ${ElseIf} $FormatMe != "Yes" 
  ${AndIf} $FormatMeFat != "Yes"
  ${AndIfNot} ${FileExists} $BootDir\multiboot\syslinux.cfg
  MessageBox MB_YESNO|MB_ICONEXCLAMATION "${NAME} is Ready to perform the following actions:$\r$\n$\r$\n1. Create a Syslinux MBR on ($DestDisk) - Existing MBR will be Overwritten!$\r$\n$\r$\n2. Create MULTIBOOT Label on ($DestDisk) - Existing Label will be Overwritten!$\r$\n$\r$\n3. Install ($DistroName) on ($DestDisk)$\r$\n$\r$\nAre you absolutely positive Drive Letter ($DestDisk) on (Disk $DiskNum) is your USB Device?$\r$\nDouble Check with Windows to make sure!$\r$\n$\r$\nClick YES to perform these actions on ($DestDisk) or NO to Go Back!" IDYES proceed
  Quit
 ${EndIf}

proceed: 
 ${IfThen} $Removal == "Yes" ${|} Goto removeonly ${|}
  ${If} $DiskNum != "0"
   Call FormatYes ; Format the Drive?
   Call HaveSpace ; Got enough Space? Lets Check! 
   Call DoSyslinux ; Run Syslinux on the Drive to make it bootable
   Call LocalISODetected
  ${EndIf}
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
  ${If} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\linux.cfg"
  StrCpy $Config2Use "linux.cfg"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\anon.cfg"
  StrCpy $Config2Use "anon.cfg"  
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\system.cfg"
  StrCpy $Config2Use "system.cfg"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\antivirus.cfg"
  StrCpy $Config2Use "antivirus.cfg"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\netbook.cfg"
  StrCpy $Config2Use "netbook.cfg"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\other.cfg"
  StrCpy $Config2Use "other.cfg"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\pe.cfg"
  StrCpy $Config2Use "pe.cfg"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\unlisted.cfg"
  StrCpy $Config2Use "unlisted.cfg"  
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\menu.lst"
  StrCpy $Config2Use "menu.lst"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\vhd.lst"
  StrCpy $Config2Use "vhd.lst"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\grubpart4.lst"
  StrCpy $Config2Use "grubpart4.lst"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\grubram.lst"
  StrCpy $Config2Use "grubram.lst"
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\win.lst"
  StrCpy $Config2Use "win.lst"  
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\win2go.lst"
  StrCpy $Config2Use "win2go.lst"   
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\pe.lst"
  StrCpy $Config2Use "pe.lst"  
  ${ElseIf} ${FileExists} "$BootDir\multiboot\$DistroName\YUMI\hirens.lst"
  StrCpy $Config2Use "hirens.lst"    
  ${EndIf}
  ; MessageBox MB_OK "$Config2Use"
FunctionEnd

Function Config2Write
 ${If} $Config2Use == "linux.cfg"
  ${WriteToSysFile} "label Linux Distributions$\r$\nmenu label Linux Distributions ->$\r$\nMENU INDENT 1$\r$\nCONFIG /multiboot/menu/linux.cfg" $R0 
 ${ElseIf} $Config2Use == "anon.cfg"
  ${WriteToSysFile} "label System Tools$\r$\nmenu label Anonymous Browsers ->$\r$\nMENU INDENT 1$\r$\nCONFIG /multiboot/menu/anon.cfg" $R0  
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
MessageBox MB_YESNO "Would you like to add more ISOs/Distros Now on $DestDisk?" IDYES noskip
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
 Messagebox MB_OK|MB_ICONINFORMATION "Currently you're trying to run this program as: $Auth$\r$\n$\r$\nYou must run this program with administrative rights...$\r$\n$\r$\nRight click the file and select Run As Administrator or Run As (and select an administrative account)!"
 Abort
 done:
 SetShellVarContext all
 InitPluginsDir
;  File /oname=$PLUGINSDIR\paypal.bmp "paypal.bmp" 
  File /oname=$PLUGINSDIR\dskvol.txt "dskvol.txt" 
  File /oname=$PLUGINSDIR\diskpart.txt "diskpart.txt" 
  File /oname=$PLUGINSDIR\w2gdiskpart.txt "w2gdiskpart.txt"   
  File /oname=$PLUGINSDIR\dd-diskpart.txt "dd-diskpart.txt" 
  File /oname=$PLUGINSDIR\diskpartdetach.txt "diskpartdetach.txt"  
  File /oname=$PLUGINSDIR\autounattend.xml "autounattend.xml"   
  File /oname=$PLUGINSDIR\syslinux.exe "syslinux.exe"  
  File /oname=$PLUGINSDIR\syslinux.cfg "syslinux.cfg"
  File /oname=$PLUGINSDIR\legacy-yumi "menu\legacy-yumi"  
  File /oname=$PLUGINSDIR\menu.lst "menu\menu.lst"  
  File /oname=$PLUGINSDIR\vhd.lst "menu\vhd.lst" 
  File /oname=$PLUGINSDIR\grubpart4.lst "menu\grubpart4.lst"  
  File /oname=$PLUGINSDIR\grubram.lst "menu\grubram.lst"    
  File /oname=$PLUGINSDIR\win.lst "menu\win.lst"  
  File /oname=$PLUGINSDIR\win2go.lst "menu\win2go.lst"  
  File /oname=$PLUGINSDIR\grub.exe "grub.exe"  
  File /oname=$PLUGINSDIR\info "menu\info"   
  File /oname=$PLUGINSDIR\antivirus.cfg "menu\antivirus.cfg" 
  File /oname=$PLUGINSDIR\system.cfg "menu\system.cfg" 
  File /oname=$PLUGINSDIR\netbook.cfg "menu\netbook.cfg"
  File /oname=$PLUGINSDIR\linux.cfg "menu\linux.cfg" 
  File /oname=$PLUGINSDIR\anon.cfg "menu\anon.cfg"  
  File /oname=$PLUGINSDIR\other.cfg "menu\other.cfg"   
  File /oname=$PLUGINSDIR\pe.cfg "menu\pe.cfg"    
  File /oname=$PLUGINSDIR\pe.lst "menu\pe.lst"  
  File /oname=$PLUGINSDIR\unlisted.cfg "menu\unlisted.cfg"   
  File /oname=$PLUGINSDIR\liveusb "liveusb"   
  File /oname=$PLUGINSDIR\7zG.exe "7zG.exe"
  File /oname=$PLUGINSDIR\7z.dll "7z.dll"  
  File /oname=$PLUGINSDIR\yumi.png "images\yumi.png"
  File /oname=$PLUGINSDIR\YUMI-Copying.txt "YUMI-Copying.txt" 
  File /oname=$PLUGINSDIR\YUMI-Readme.txt "YUMI-Readme.txt" 
  File /oname=$PLUGINSDIR\license.txt "license.txt"   
  File /oname=$PLUGINSDIR\vesamenu.c32 "vesamenu.c32" 
  File /oname=$PLUGINSDIR\menu.c32 "menu.c32"    
  File /oname=$PLUGINSDIR\memdisk "memdisk" 
  File /oname=$PLUGINSDIR\chain.c32 "chain.c32" 
  File /oname=$PLUGINSDIR\libcom32.c32 "libcom32.c32"  
  File /oname=$PLUGINSDIR\libutil.c32 "libutil.c32"   
  File /oname=$PLUGINSDIR\linux.c32 "linux.c32"  
  File /oname=$PLUGINSDIR\wimboot "wimboot"   
  File /oname=$PLUGINSDIR\ifcpu64.c32 "ifcpu64.c32" 
  File /oname=$PLUGINSDIR\remount.cmd "remount.cmd"  
  File /oname=$PLUGINSDIR\boot.cmd "boot.cmd"    
  File /oname=$PLUGINSDIR\vhdremount.cmd "vhdremount.cmd"    
  File /oname=$PLUGINSDIR\ei.cfg "ei.cfg"
  File /oname=$PLUGINSDIR\dd.exe "dd.exe"
  File /oname=$PLUGINSDIR\fat32format.exe "fat32format.exe"    
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