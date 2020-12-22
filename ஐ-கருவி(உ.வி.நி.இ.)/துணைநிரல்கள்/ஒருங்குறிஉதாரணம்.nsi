Unicode	True
!include துணைநிரல்கள்\ஒருங்குறிஉரை.நிரல்

Section ""
;wrapper before write. Assumption UTF-8 file. 
;${FileRecode} "$EXEDIR\Settings.ini" "ToUTF16LE"
;Convert file from UTF-8 to UTF16LE
	
	; Write Settings.ini:
    FileOpen $0 "$EXEDIR\Settings.ini" a ; operate on the converted file. 
    FileSeek $0 0 END ; go to the end of file
    StrCpy $R0 "Folder1=セちさ vazhaga valamudan1$\r$\n வாழ்க வளமுடன்1$\r$\n" ; Sample unicode string with 3 Japanese characters
;   FileWriteWord $0 0xFEFF ; write the BOM ; commentting this line as the data is in file already.
	FileWriteUTF16LE $0 $R0
    FileClose $0
	;Content Appended
	
; Convert file back to UTF-8
;${FileRecode} "$EXEDIR\Settings.ini" "ToUTF8"
; Convert file UTF16LE to UTF-8

	
SectionEnd  
