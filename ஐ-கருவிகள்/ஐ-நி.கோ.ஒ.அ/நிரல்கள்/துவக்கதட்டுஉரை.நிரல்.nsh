; ------------- DriveStuff -------------

 Function PhysDrive
 StrCpy $1 "$JustDrive"
 Push $1
 Call HDDNumber  
 StrCpy $DiskNum $0
 FunctionEnd
 
; Might need this again sometime
;Function Lock_Only
; StrCpy $1 "\\.\$JustDrive" -1
; Push $1
; Call Create
; Call LockVol 
;FunctionEnd		
		  
; The following code was found here: http://forums.winamp.com/showthread.php?t=317579
; File Access Modes
!define GENERIC_READ         0x80000000
!define GENERIC_WRITE        0x40000000

; File Sharing Modes
!define FILE_SHARE_READ      0x00000001
!define FILE_SHARE_WRITE     0x00000002

; File Creation Flags
!define OPEN_EXISTING        3
!define INVALID_HANDLE_VALUE -1

; Maximum length of volume GUID (including terminating zero)
!define MAXLEN_VOLUME_GUID   51

; I/O control command
!define IOCTL_VOLUME_GET_VOLUME_DISK_EXTENTS   0x00560000
!define EXTENTS_BUFFER_SIZE  512
; Dismount_Volume
!define FSCTL_DISMOUNT_VOLUME 0x00090020

; Lock_Volume
!define FSCTL_LOCK_VOLUME 0x00090018

; Unlock_Volume
!define FSCTL_UNLOCK_VOLUME 0x0009001c										
; Get hard disk number from drive letter
; provided as a parameter to this function.
; The hard disk number is returned in $0.

Function HDDNumber
  ; Save registers
  Exch $1
  Push $2
  Push $3
  Push $4
  Push $5
  Push $6
  Push $7
  ; Get volume name associated with drive letter
  System::Call "kernel32::GetVolumeNameForVolumeMountPoint(t r1, t r3r3, i ${MAXLEN_VOLUME_GUID}) i.r2"
  ${If} $2 != 0
     ; Get handle of volume
     StrCpy $3 $3 -1
     System::Call "kernel32::CreateFile(t r3, \\
       i ${GENERIC_READ}|${GENERIC_WRITE}, \\
       i ${FILE_SHARE_READ}|${FILE_SHARE_WRITE}, \\
       i 0, i ${OPEN_EXISTING}, i 0, i 0) i.r2"
     ${If} $2 != ${INVALID_HANDLE_VALUE}
        ; Allocate output buffer
        System::Alloc ${EXTENTS_BUFFER_SIZE}
        Pop $4
        IntOp $5 0 + 0
        ; Send IOCTL_VOLUME_GET_VOLUME_DISK_EXTENTS command
        System::Call "kernel32::DeviceIoControl(i r2, \\
            i ${IOCTL_VOLUME_GET_VOLUME_DISK_EXTENTS}, \\
            i 0, i 0, \\
            i r4, i ${EXTENTS_BUFFER_SIZE}, \\
            *i r5r5, i 0) i.r3"
        ${If} $3 != 0
           ; Extract HDD number
           System::Call "*$4(i .r5, i, i .r0)"
           ${If} $5 == 0
               StrCpy $0 "Error: Invalid DISK_EXTENT data"
           ${EndIf}
        ${Else}
           StrCpy $0 "Error: DeviceIoControl failed"
        ${EndIf}
        System::Free $4
        System::Call "kernel32::CloseHandle(i r2) i.r3"
     ${Else}
        StrCpy $0 "Error: CreateFile failed for $3"
     ${EndIf}
  ${Else}
    StrCpy $0 "Error: GetVolumeNameForVolumeMountPoint failed for $1"
  ${EndIf}
  ; Restore registers
  Pop $7
  Pop $6
  Pop $5
  Pop $4
  Pop $3
  Pop $2
  Pop $1
FunctionEnd

; Might need this again sometime
/* Function Create
  Push $8
  
     System::Call "kernel32::CreateFile(t r1, \\ 
     i ${GENERIC_READ}|${GENERIC_WRITE}, \\ 
     i ${FILE_SHARE_READ}|${FILE_SHARE_WRITE}, \\ 
     i 0, i ${OPEN_EXISTING}, i 0, i 0) i.r8" 
     ${If} $8 != ${INVALID_HANDLE_VALUE} 
	  DetailPrint "CreateFile Successful"
	  System::Call "kernel32::FlushFileBuffers(i r8)"
	  System::Call "kernel32::CloseHandle(i r8)"
	 ${Else} 
	  DetailPrint "CreateFile Failed"	 
	  System::Call "kernel32::CloseHandle(i r8)" 
	 ${EndIf}

  Pop $8  
FunctionEnd	  */	

; Might need this again sometime
/* Function LockVol
  Push $7 
  Push $8  
  
     System::Call "kernel32::CreateFile(t r1, \\ 
     i ${GENERIC_READ}, \\ 
     i ${FILE_SHARE_READ}|${FILE_SHARE_WRITE}, \\ 
     i 0, i ${OPEN_EXISTING}, i 0, i 0) i.r8" 
    ${If} $8 != ${INVALID_HANDLE_VALUE} 
	
	 ; Send FSCTL_LOCK_VOLUME command		   
      System::Call "kernel32::DeviceIoControl(i r8, \\
      i ${FSCTL_LOCK_VOLUME}, \\
      i 0, i 0, \\
      i 0, i 0, \\
      i &bytesReturned, i 0) i.r7"
	   ${If} $7 != 0
	    DetailPrint "Volume $1 Locked"
		System::Call "kernel32::CloseHandle(i r8) i.r7"
	   ${Else}	
		DetailPrint "Volume $1 Not Locked"
		System::Call "kernel32::CloseHandle(i r8) i.r7"
	   ${EndIf} 
	   
	 ${Else}	
		DetailPrint "Read Pre-Lock Failed"
		System::Call "kernel32::CloseHandle(i r8) i.r7"
	${EndIf} 	

  Pop $7 
  Pop $8
FunctionEnd  */

; Might need this again sometime
/* Function UnLockVol	
  Push $6 
  Push $8
  
	; Send FSCTL_UNLOCK_VOLUME command		   
     System::Call "kernel32::DeviceIoControl(i r8, \\
     i ${FSCTL_UNLOCK_VOLUME}, \\
     i 0, i 0, \\
     i 0, i 0, \\
     i &bytesReturned, i 0) i.r6" ;was i.r7
	${If} $7 != 0
	 DetailPrint "Volume $1 UnLocked"
     System::Call "kernel32::CloseHandle(i r8) i.r6"
	${Else}	
	 DetailPrint "Volume $1 NOT UnLocked"
     System::Call "kernel32::CloseHandle(i r8) i.r6"
    ${EndIf} 
	
  Pop $8  
  Pop $6	
FunctionEnd  */	   