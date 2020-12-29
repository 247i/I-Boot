
!macro உதநிகோப்புபெயர்அமை Distro2Check ISO2Check2 Download2Get Persistent Write2File Homepage OfficialName
 ${If} $Checker == "No" 
 ${AndIf} $DistroName == "${Distro2Check}" 
 StrCpy $ISOFileName "${ISO2Check2}"
 StrCpy $DownLink "${Download2Get}"   
 StrCpy $Persistence "${Persistent}"
 StrCpy $DistroPath "${Write2File}" ; was Config2Use
 StrCpy $Homepage "${Homepage}" ; Linux Distro Homepage
 StrCpy $OfficialName "${OfficialName}" ; Linux Distro Name for Home Page Anchor

 ${ElseIf} $Checker == "YES"  
 ${AndIf} $Removal != "YES" 
 ${AndIf} $FormatMe != "YES"
 ;${AndIfNot} ${FileExists} $BDir\${File2Check}  ; If Distro File exists, don't show Distro because it must already be installed.
 ${NSD_CB_AddString} $Distro "${Distro2Check}" ; was ${NSD_LB_AddString} $Distro "${Distro2Check}" ; Enable for Dropbox
  
 ${ElseIf} $Checker == "YES"   
 ${AndIf} $Removal != "YES"  
 ${AndIf} $FormatMe == "YES" 
 ${NSD_CB_AddString} $Distro "${Distro2Check}" ; was ${NSD_LB_AddString} $Distro "${Distro2Check}" ; Enable for Dropbox
 ${EndIf}
!macroend