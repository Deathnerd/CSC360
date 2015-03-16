TITLE MASM Template						(main.asm)

; Assignment: Lab 2 - Problem 1

; Class: CSC 360

; Author: Wes Gilleland

; Date: March 13th, 2015

; Description: This program will ask the user to enter an integer test score between
; 0 and 100. It will display the appropriate letter grade as well. It will do so in
; an infinite loop that will break only when the user enters a negative number (but
; they are prompted for a -1)


INCLUDE Irvine32.inc
.data
promptMessage BYTE "Enter an integer score between 0 and 100 (-1 to exit): ", 0

; These are the messages that will be displayed when the grade is calculated
gradeAMessage BYTE "Congrats! You got an A!", 0
gradeBMessage BYTE "B! Not as good as an A, but damn good!", 0
gradeCMessage BYTE "C! Hey, how does it feel to be average, not B average?", 0
gradeDMessage BYTE "D! At least D's get degrees!", 0
gradeFMessage BYTE "F! Maybe this school thing isn't for you", 0

showGradeMessage BYTE "The letter grade is: ", 0

gradeInt SDWORD 0				; The variable to store the numeric value of the grade


.code
main PROC

	call Clrscr					; Clear the screen

	runLoop:					; Who says infinite loops are bad?
		call displayPrompt		; Call the prompt
		call getInput			; Get the input
		call handleInput		; Handle it. Here is where we'll do our checks for 
		call Crlf				; New line!
		jmp runLoop				; Let's loop again!
		
	exit
main ENDP

displayPrompt PROC
; Just displays the prompt
	mov edx, OFFSET promptMessage
	call WriteString

	ret
; POST: edx contains the offset of promptMessage
displayPrompt ENDP

getInput PROC
; Just gets the input from the user
	call ReadInt				; Call the procedure to get the integer
	mov gradeInt, eax			; Move the input into the grade

	ret
; POST: eax now contains the user input
getInput ENDP

handleInput PROC
; This will determine what kind of grade the user got and display the appropriate message
; PRE: gradeInt should be set to some numeric value
	cmp gradeInt, 90			
	jge printAGrade				; If >= 90, they have an A

	cmp gradeInt, 80			
	jge printBGrade				; If >= 80, but < 90, they have a B

	cmp gradeInt, 70
	jge printCGrade				; If >= 70, but < 80, they have a C

	cmp gradeInt, 60
	jge printDGrade				; If >= 60, but < 70, they have a D

	cmp gradeInt, 0
	jge printFGrade				; If >= 0, but < 60, they have an F

	exit						; The user is entering a negative number, so exit the program

	printAGrade:
		; Print the message showing they got an A
		mov edx, OFFSET showGradeMessage
		call WriteString
		mov edx, OFFSET gradeAMessage
		call WriteString
		jmp returnBlock			; Jump to the return statement

	printBGrade:
		; Print the message showing they got a B
		mov edx, OFFSET showGradeMessage
		call WriteString
		mov edx, OFFSET gradeBMessage
		call WriteString
		jmp returnBlock			; Jump to the return statement

	printCGrade:
		; Print the message showing they got a C
		mov edx, OFFSET showGradeMessage
		call WriteString
		mov edx, OFFSET gradeCMessage
		call WriteString
		jmp returnBlock			; Jump to the return statement

	printDGrade:
		; Print the message showing they got a D
		mov edx, OFFSET showGradeMessage
		call WriteString
		mov edx, OFFSET gradeDMessage
		call WriteString
		jmp returnBlock			; Jump to the return statement

	printFGrade:
		; Print the message showing they got an F
		mov edx, OFFSET showGradeMessage
		call WriteString
		mov edx, OFFSET gradeFMessage
		call WriteString
		jmp returnBlock			; Jump to the return statement

	returnBlock:
		; The return statement
		ret
; POST: edx contains the offset of the appropriate message variable
handleInput ENDP

END main