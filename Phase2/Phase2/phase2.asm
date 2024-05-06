includelib ucrt.lib
includelib legacy_stdio_definitions.lib

ExitProcess PROTO
EXTERN printf: PROC

.data
rowSize			dq 3
colSize			dq 3
myMatrix		dq 1, 2, 3, 4, 5, 6, 7, 8, 9
myString		db "%d ", 0
originalPrompt	db "Original Matrix:", 10, 0
transposePrompt db "Transpose Matrix:", 10, 0
newLine			db 10, 0

.code
printMatrix PROC
	mov r12, 0							; r12 = Array counter
	mov r14, 0							; r14 = Row counter
	printOuter:
		mov r15, 0						; r15 = Column counter
		printInner:
			mov r13, offset myMatrix	; The address of the matrix in memory
			; printf(myString, rdx)
			mov rcx, offset myString	; 1st Parameter - string
			mov rdx, [r13 + 8*r12]		; 2nd Parameter - array value
			sub rsp, 32					; Shadow Space
			;sub rsp, 8					; If stack is not aligned
			call printf					; Print the matrix element
			add rsp, 32					; or 40; Clean up stack

			inc r12						; Increment array counter
			inc r15						; Increment column counter
			cmp r15, colSize			; Compare column counter to colSize
			jnz printInner				; If r15 is not 3, jump back to inner loop

		mov rcx, offset newLine			; 1st Parameter - new line character
		sub rsp, 32						; Shadow Space
		;sub rsp 8						; If stack is not aligned
		call printf						; Print a new line character
		add rsp, 32						; or 40; Clean up stack

		inc r14							; Increment row counter
		cmp r14, rowSize				; Compare row counter to rowSize
		jnz printOuter					; If r14 is not 3, jump back to outer loop
	ret									; Exit the procedure
printMatrix ENDP

flippyFlop PROC
	mov r13, offset myMatrix			; r13 = memory address of myMatrix
	mov r11, 3							; r11 = Array counter
	mov r12, 0							; r12 = Transpose counter
	mov r10, 8							; r10 = Subtraction value
	mov r14, 1							; r14 = Row counter
	flipOuter:
		mov r15, 0						; r15 = Column counter
		flipInner:
			mov rax, 3					; Prepares to multiply the array counter by 3
			mul r11						; Multiplies array counter by 3, result stored in rax
			mov r12, rax				; Mov multiplication result to r12, the transpose counter
			sub r12, r10				; Subtract r10 from r12 to get correct transpose index

			mov r8, [r13 + 8*r11]		; Swaps array elements
			mov r9, [r13 + 8*r12]
			mov [r13 + 8*r11], r9
			mov [r13 + 8*r12], r8

			inc r11						; Increment array counter
			inc r15						; Increments column counter
			cmp r15, r14				; Only loop as much as the row counter
			jnz flipInner

		inc r14							; Increments row counter
		mov rax, 3						; Prepares to multiply the row counter by 3
		mul r14							; Multiplies the row counter by 3
		mov r11, rax					; Updates array counter 
		add r10, 8						; Updates subtration value
		cmp r14, rowSize				; If r14 is not 3, jump back to outer loop
		jnz flipOuter
	ret									; Exit the procedure
flippyFlop ENDP

mainCRTStartup PROC
	mov rcx, offset originalPrompt		; 1st Parameter - Labeling the original matrix
	sub rsp, 32							; Shadow Space
	sub rsp, 8							; Stack is not aligned
	call printf							; Print the label
	add rsp, 40							; Clean up stack
	call printMatrix					; Print the matrix in a nice form
	
	call flippyFlop						; Flippyflop the matrix

	mov rcx, offset transposePrompt		; 1st Parameter - Labeling the transpose matrix
	sub rsp, 32							; Shadow Space
	sub rsp, 8							; Stack is not aligned
	call printf							; Print the label
	add rsp, 40							; Clean up stack
	call printMatrix					; Print the matrix in a nice form
	
	mov rcx, 0							; Exit code of 0
	call ExitProcess
mainCRTStartup ENDP

END