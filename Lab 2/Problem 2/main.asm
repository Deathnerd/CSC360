TITLE MASM Template						(main.asm)

; Author: Wes Gilleland

; Class: CSC 360

; Date: March 13th, 2015

; Description: This program will ask the user for a positive integer to define the size of an array. It is
; very specific about what it wants, an intger between 0 and 20, inclusive. It will ask generically at first,
; then if the first input is not what is expected, will clarify and continue asking until the input is valid.
; It will ask the user n number of times for an integer to store into the array. After that it will sum the elements
; in the array and display the sum. Currently there is a bug where it does not fetch the individual values in the array
; but fetches the entire array.

INCLUDE Irvine32.inc
.data
prompt1 	BYTE "Enter an integer: ", 0
sumPrompt1 	BYTE "The sum is: ", 0
prompt2 	BYTE "Please enter a positive number that fits the following criteria: 0 < n <= 20: ", 0
theArray	SDWORD 20 DUP(?)								; Initialize an array with a max length of 20 4 byte signed integers
arraySize 	SDWORD ?										; Initialize the array size with an unknown value of signed double word

.code
main PROC

	call Clrscr
	; Get the input
	call getArraySizeFromUser
	; Get the integers for the array
	call getArrayValues
	; Print out the result
	call sumArray
	mov edx, OFFSET sumPrompt1
	call WriteString
	call WriteInt
	call Crlf
	call WaitMsg							; Wait for the user to exit the program
	exit
main ENDP

getArraySizeFromUser PROC
; PRE: Doesn't really modify anything. Messes with EAX
	; Ask nicely the first time
	mov edx, OFFSET prompt1
	call WriteString						; Display the first prompt: "Enter an integer"
	call ReadInt							; Read the input, storing it in eax
	mov arraySize, eax						; Store the value
	; Check to see if within acceptable range
	; If so, move to return
	cmp arraySize, 20 						; Check that we're within the upper limit
	jg 	askAgain
	cmp arraySize, 0						; Check that we're within the lower limit
	jle	askAgain
	jmp returnOut1							; Everything's good, jump to the return

	askAgain:								; The user didn't enter a valid input. Ask again but clarify this time
		call Crlf							; Clear the screen
		mov edx, OFFSET prompt2				; Display the prompt
		call WriteString					; Display the prompt
		call ReadInt						; Read input
		mov arraySize, eax					; Store the input

		; Check to see if within acceptable range
		; If so, move to return
		cmp arraySize, 20 						; Check that we're within the upper limit
		jg 	askAgain
		cmp arraySize, 0						; Check that we're within the lower limit
		jle	askAgain

	returnOut1:
		ret
; POST: EAX now contains the value input by the user, as does arraySize
getArraySizeFromUser ENDP

getArrayValues PROC
; PRE: reset esi and move the value from arraySize into ecx
	; set up the loop
	mov esi, 0								; Set up the index
	mov ecx, arraySize 						; We're going to be looping arraySize times
	tehLoop:
		call Crlf 							; Run the 
		mov edx, OFFSET prompt1
		call WriteString					; Display the prompt
		call ReadInt
		mov theArray[esi], eax				; Move the value into the array at the current index
		inc esi								; Increment the index
		loop tehLoop

	ret
; POST: theArray now has a number of N integers contained in it, where N is arraySize
getArrayValues ENDP

sumArray PROC
; BUG: Doesn't grab individual values from the array, but rather a whole bunch of them at once. Don't know why...
	; set up the loop
	mov ecx, LENGTHOF theArray 						; We're looping arraySize times
	mov ebx, OFFSET theArray				; Get the address of the first array element
	mov eax, 0
	top:
		add eax, [ebx]						; Get the value and add it to eax
		add edx, TYPE theArray				; Increment the pointer to the next value
		loop top 							; Here we go loop de loop!

	ret
; POST: EAX should contain the sum of all elements of theArray
sumArray ENDP

END main