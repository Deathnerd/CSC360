TITLE MASM Template						(main.asm)

; Description:
; 
; Revision date:

INCLUDE Irvine32.inc
.data
myMessage BYTE "MASM program example",0dh,0ah,0
promptMessage BYTE "Enter an integer score between 0 and 100 (-1 to exit): ", 0


.code
main PROC
	call Clrscr

	mov	 edx,OFFSET myMessage
	call WriteString

	call func1
	exit
main ENDP

func1 PROC
	call Clrscr
	; Call the prompt
	mov edx, OFFSET promptMessage
	call WriteString
func1 ENDP

END main