Unicode	True
!include துணை\ஒருங்குறிஉரை.நிரல்
!define பெயர் "ஒருங்குறிஉதாரணம்"
!define MUI_ICON "..\அகர\ஐ-காண்\பூச்சி.ico"

OutFile "..\${பெயர்}.exe"
Section ""
;wrapper before write. Assumption UTF-8 file. 
;${FileRecode} "$EXEDIR\உதாரணம்.ini" "ToUTF16LE"
;Convert file from UTF-8 to UTF16LE

; Write உதாரணம்.ini:
FileOpen $0 "$EXEDIR\உதாரணம்.ini" a ; operate on the converted file. 
FileSeek $0 0 END ; go to the end of file
StrCpy $R0 "Folder1=セちさ vazhaga valamudan$\r$\n வாழ்க வளமுடன்$\r$\n" ; Sample unicode string with 3 Japanese characters
;FileWriteWord $0 0xFEFF ; write the BOM ; commentting this line as the data is in file already.
FileWriteUTF16LE /BOM $0 $R0
FileClose $0
;Content Appended

; Convert file back to UTF-8
;${FileRecode} "$EXEDIR\உதாரணம்.ini" "ToUTF8"
; Convert file UTF16LE to UTF-8

SectionEnd  
