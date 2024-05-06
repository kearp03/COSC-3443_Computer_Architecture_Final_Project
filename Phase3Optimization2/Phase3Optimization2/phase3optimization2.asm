includelib ucrt.lib
includelib legacy_stdio_definitions.lib

ExitProcess PROTO
EXTERN printf: PROC
EXTERN malloc: PROC
EXTERN rand: PROC

.data
rowSize			dq 256
colSize			dq 256
myMatrix		dq 0
myString		db "%d", 9, 0			; Format null-terminated string to print an integer and a tab character
originalPrompt	db "Original Matrix:", 10, 0
transposePrompt db "Transpose Matrix:", 10, 0
newLine			db 10, 0

.code
flippyFlop PROC
	mov r13, myMatrix					; r13 = memory address of myMatrix
	mov r11, rowSize					; r11 = Array counter
	mov r12, 0							; r12 = Transpose counter
	mov r14, 1							; r14 = Row counter
	flipOuter:
		mov r15, 0						; r15 = Column counter
		flipInner:
			mov rax, colSize			; Prepares to multiply the array counter by the size of the columns
			mul r15						; Multiplies column counter by the column size, result stored in rax
			mov r12, rax				; Move multiplication result to r12, the transpose counter
			add r12, r14				; Add r14 to r12 to get correct transpose index

			mov r8, [r13 + 8*r11]		; Swaps array elements
			mov r9, [r13 + 8*r12]
			mov [r13 + 8*r11], r9
			mov [r13 + 8*r12], r8

			inc r11						; Increment array counter
			inc r15						; Increments column counter
			cmp r15, r14				; Only loop as much as the row counter
			jnz flipInner

		inc r14							; Increments row counter
		mov rax, rowSize				; Prepares to multiply the row counter by size of the row
		mul r14							; Multiplies the row counter by the size of the row
		mov r11, rax					; Updates array counter 
		cmp r14, rowSize				; If r14 is not 3, jump back to outer loop
		jnz flipOuter
	ret									; Exit the procedure
flippyFlop ENDP

mainCRTStartup PROC
	; Generate the matrix with size 256 (2^8) x 256 (2^8) = 65536 (2^16)
	mov rcx, 65536
	call generateRandomNumbers
	mov myMatrix, rax

	mov rcx, offset originalPrompt		; 1st Parameter - Labeling the original matrix
	sub rsp, 32							; Shadow Space
	sub rsp, 8							; Stack is not aligned
	call printf							; Print the label
	add rsp, 40							; Clean up stack
	
	; Print the matrix in a nice form
	mov r12, 0							; r12 = Array counter
	mov r14, 0							; r14 = Row counter
	; Assumes the row size is divisible by 4
	printOuter1:
		mov r15, 0						; r15 = Column counter
		; Assumes the column size is divisible by 4
		printInner1:
			mov r13, myMatrix			; The address of the matrix in memory
			; 1st print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 2nd print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 3rd print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 4th print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter
			add r15, 4					; Increment column counter
			cmp r15, colSize			; Compare column counter to colSize
			jnz printInner1				; If r15 is not colSize, jump back to inner loop

		mov rcx, offset newLine			; 1st Parameter - new line character
		sub rsp, 32						; Shadow Space
		sub rsp, 8						; If stack is not aligned
		call printf						; Print a new line character
		add rsp, 40						; Clean up stack

		inc r14							; Increment row counter

		; 2nd row
		mov r15, 0						; r15 = Column counter
		; Assumes the column size is divisible by 4
		printInner2:
			mov r13, myMatrix			; The address of the matrix in memory
			; 1st print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 2nd print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 3rd print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 4th print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter
			add r15, 4					; Increment column counter
			cmp r15, colSize			; Compare column counter to colSize
			jnz printInner2				; If r15 is not colSize, jump back to inner loop

		mov rcx, offset newLine			; 1st Parameter - new line character
		sub rsp, 32						; Shadow Space
		sub rsp, 8						; If stack is not aligned
		call printf						; Print a new line character
		add rsp, 40						; Clean up stack

		inc r14							; Increment row counter

		; 3rd row
		mov r15, 0						; r15 = Column counter
		; Assumes the column size is divisible by 4
		printInner3:
			mov r13, myMatrix			; The address of the matrix in memory
			; 1st print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 2nd print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 3rd print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 4th print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter
			add r15, 4					; Increment column counter
			cmp r15, colSize			; Compare column counter to colSize
			jnz printInner3				; If r15 is not colSize, jump back to inner loop

		mov rcx, offset newLine			; 1st Parameter - new line character
		sub rsp, 32						; Shadow Space
		sub rsp, 8						; If stack is not aligned
		call printf						; Print a new line character
		add rsp, 40						; Clean up stack

		inc r14							; Increment row counter

		; 4th row
		mov r15, 0						; r15 = Column counter
		; Assumes the column size is divisible by 4
		printInner4:
			mov r13, myMatrix			; The address of the matrix in memory
			; 1st print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 2nd print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 3rd print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 4th print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter
			add r15, 4					; Increment column counter
			cmp r15, colSize			; Compare column counter to colSize
			jnz printInner4				; If r15 is not colSize, jump back to inner loop

		mov rcx, offset newLine			; 1st Parameter - new line character
		sub rsp, 32						; Shadow Space
		sub rsp, 8						; If stack is not aligned
		call printf						; Print a new line character
		add rsp, 40						; Clean up stack

		inc r14							; Increment row counter
		cmp r14, rowSize				; Compare row counter to rowSize
		jnz printOuter1					; If r14 is not rowSize, jump back to outer loop
	
	call flippyFlop						; Flippyflop the matrix

	mov rcx, offset transposePrompt		; 1st Parameter - Labeling the transpose matrix
	sub rsp, 32							; Shadow Space
	sub rsp, 8							; Stack is not aligned
	call printf							; Print the label
	add rsp, 40							; Clean up stack
	
	; Print the matrix in a nice form
	mov r12, 0							; r12 = Array counter
	mov r14, 0							; r14 = Row counter
	; Assumes the row size is divisible by 4
	printOuter2:
		mov r15, 0						; r15 = Column counter
		; Assumes the column size is divisible by 4
		printInner5:
			mov r13, myMatrix			; The address of the matrix in memory
			; 1st print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 2nd print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 3rd print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 4th print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter
			add r15, 4					; Increment column counter
			cmp r15, colSize			; Compare column counter to colSize
			jnz printInner5				; If r15 is not colSize, jump back to inner loop

		mov rcx, offset newLine			; 1st Parameter - new line character
		sub rsp, 32						; Shadow Space
		sub rsp, 8						; If stack is not aligned
		call printf						; Print a new line character
		add rsp, 40						; Clean up stack

		inc r14							; Increment row counter

		; 2nd row
		mov r15, 0						; r15 = Column counter
		; Assumes the column size is divisible by 4
		printInner6:
			mov r13, myMatrix			; The address of the matrix in memory
			; 1st print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 2nd print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 3rd print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 4th print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter
			add r15, 4					; Increment column counter
			cmp r15, colSize			; Compare column counter to colSize
			jnz printInner6				; If r15 is not colSize, jump back to inner loop

		mov rcx, offset newLine			; 1st Parameter - new line character
		sub rsp, 32						; Shadow Space
		sub rsp, 8						; If stack is not aligned
		call printf						; Print a new line character
		add rsp, 40						; Clean up stack

		inc r14							; Increment row counter

		; 3rd row
		mov r15, 0						; r15 = Column counter
		; Assumes the column size is divisible by 4
		printInner7:
			mov r13, myMatrix			; The address of the matrix in memory
			; 1st print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 2nd print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 3rd print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 4th print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter
			add r15, 4					; Increment column counter
			cmp r15, colSize			; Compare column counter to colSize
			jnz printInner7				; If r15 is not colSize, jump back to inner loop

		mov rcx, offset newLine			; 1st Parameter - new line character
		sub rsp, 32						; Shadow Space
		sub rsp, 8						; If stack is not aligned
		call printf						; Print a new line character
		add rsp, 40						; Clean up stack

		inc r14							; Increment row counter

		; 4th row
		mov r15, 0						; r15 = Column counter
		; Assumes the column size is divisible by 4
		printInner8:
			mov r13, myMatrix			; The address of the matrix in memory
			; 1st print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 2nd print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 3rd print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter

			; 4th print
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 40					; Clean up stack

			inc r12						; Increment array counter
			add r15, 4					; Increment column counter
			cmp r15, colSize			; Compare column counter to colSize
			jnz printInner8				; If r15 is not colSize, jump back to inner loop

		mov rcx, offset newLine			; 1st Parameter - new line character
		sub rsp, 32						; Shadow Space
		sub rsp, 8						; If stack is not aligned
		call printf						; Print a new line character
		add rsp, 40						; Clean up stack

		inc r14							; Increment row counter
		cmp r14, rowSize				; Compare row counter to rowSize
		jnz printOuter2					; If r14 is not rowSize, jump back to outer loop
	
	mov rcx, 0							; Exit code of 0
	call ExitProcess
mainCRTStartup ENDP

; generateRandomNumbers uses a custom calling convention (i.e. NOT x64 Windows):
;	rcx is the length of the array (how many 64 bit numbers you need to generate)
; We will return the pointer to the array in rax
generateRandomNumbers PROC
	mov r15, rcx

	; Multiply the length of the array by 8 to get the total number
	;	of bytes required for our 64 bit numbers
	shl rcx, 3

	sub rsp, 40
	call malloc

	; This is the address of our new block in memory
	mov r14, rax

randomNumberLoop:
	; NOTE: Could use rand() from C, but we choose to use rdrand instead, as it
	;	gives us "more random" numbers from the CPU's thermal noise.
	; call rand

	rdrand rax

	; Split into 8 1-byte numbers and move them into the array
	;	This optimization speeds up the function 4x on my machine.
	;	Generating 268435456 numbers went from almost 5 seconds to less than 1 second.
	;	The numbers are smaller, but we don't need huge numbers anyways.
	dec r15
	cmp r15, 0
	jl randomNumberLoop_SKIP

	mov rbx, rax
	mov rcx, 0FF00000000000000h
	and rbx, rcx
	shr rbx, 56 
	mov [r14 + r15 * 8], bl

	dec r15
	cmp r15, 0
	jl randomNumberLoop_SKIP

	mov rbx, rax
	mov rcx, 0FF000000000000h
	and rbx, rcx
	shr rbx, 48 
	mov [r14 + r15 * 8], bl

	dec r15
	cmp r15, 0
	jl randomNumberLoop_SKIP

	mov rbx, rax
	mov rcx, 0FF0000000000h
	and rbx, rcx
	shr rbx, 40 
	mov [r14 + r15 * 8], bl

	dec r15
	cmp r15, 0
	jl randomNumberLoop_SKIP

	mov rbx, rax
	mov rcx, 0FF00000000h
	and rbx, rcx
	shr rbx, 32 
	mov [r14 + r15 * 8], bl

	dec r15
	cmp r15, 0
	jl randomNumberLoop_SKIP

	mov rbx, rax
	mov rcx, 0FF000000h
	and rbx, rcx
	shr rbx, 24 
	mov [r14 + r15 * 8], bl

	dec r15
	cmp r15, 0
	jl randomNumberLoop_SKIP

	mov rbx, rax
	mov rcx, 0FF0000h
	and rbx, rcx
	shr rbx, 16 
	mov [r14 + r15 * 8], bl

	dec r15
	cmp r15, 0
	jl randomNumberLoop_SKIP

	mov rbx, rax
	mov rcx, 0FF00h
	and rbx, rcx
	shr rbx, 8 
	mov [r14 + r15 * 8], bl

	dec r15
	cmp r15, 0
	jl randomNumberLoop_SKIP

	mov rbx, rax
	mov rcx, 0FFh
	and rbx, rcx
	mov [r14 + r15 * 8], bl

	cmp r15, 0
	jne randomNumberLoop

randomNumberLoop_SKIP:
	mov rax, r14
	add rsp, 40
	ret
generateRandomNumbers ENDP

END