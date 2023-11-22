#
# Example library of macros.
# 

   .macro print_int (%x)
   li a7, 1
   mv a0, %x
   ecall
   .end_macro

   .macro print_imm_int (%x)
   li a7, 1
   li a0, %x
   ecall
   .end_macro
   
   .macro print_double(%x)
   	li	a7, 3
	fmv.d 	fa0, %x
	ecall
   .end_macro 

   .macro read_int(%x)
   li a7, 5
   ecall
   mv %x, a0
   .end_macro
   
   .macro read_double(%answer)
	li a7, 7
	ecall
	fmv.d %answer, fa0
   .end_macro 

   .macro print_str (%x)
   .data
str:
   .asciz %x
   .text
   li a7, 4
   la a0, str
   ecall
   .end_macro

   .macro print_char(%x)
   li a7, 11
   li a0, %x
   ecall
   .end_macro

   .macro newline
   print_char('\n')
   .end_macro

.data 
answer: .space 2  
.macro WriteInConsole(%upper, %lower)
	addi	sp, sp, -8
	sw	%upper, 4(sp) #high-case letters
	sw	%lower, (sp) #low-case letters
	repeatTheAsk:
	print_str("\nDo you want to write the answer in the Console: write 'Y' if you want, 'N' otherwise: ")
	li	a7, 8
	la	a0, answer
	li	a1, 2
	ecall
	
	lb	t0, answer
	li	t1, 89
	
	bne 	t0, t1, NotYes
	lw	t0, 4(sp) # if output to the console
	print_int(t0)
	print_str(" ")
	lw	t0, (sp)
	print_int(t0)
	j 	FinishForWrite
	
	NotYes:
	li	t1, 78
	bne 	t0, t1, ErrorInput
	j	FinishForWrite	 
	ErrorInput:
	print_str("\nIncorrect answer!") #if an invalid character is entered, return back to the input
	j	repeatTheAsk
	FinishForWrite:
	addi	sp, sp, 8
.end_macro 	

.macro OpenFileAndReadMacro(%typeOfInput, %LinkOrTemprRegister)
	addi	sp, sp , -8
	sw	%typeOfInput, 4(sp)
	sw	%LinkOrTemprRegister, (sp)
	
	lw 	a0, 4(sp)
	lw	a1, (sp)
	addi	sp, sp, 8
	jal	OpenForReadFileUni
.end_macro

.macro CountLetters(%size, %str, %upCase, %lowCase)
	addi	sp, sp, -8
	sw	%size, 4(sp)
	sw	%str, (sp)
	lw	t0, 4(sp)
	lw	t1, (sp)
	
	li	t5, 0 #count of high-case letters
	li	t6, 0 #count of low-case letters
	loopCount:
		lb	t2, (t1)
		li	t3, 64 # code of symbol before A
		li	t4, 91 #code of letter after Z
		ble  	t2, t3, endCount
		bge 	t2, t4, NextTry
		addi	t5, t5, 1 # if it's symbol from A to Z
		j	endCount
		
		NextTry:
		li	t3, 96 # code of symbol before a
		li	t4, 123  #code of letter after z
		ble  	t2, t3, endCount
		bge 	t2, t4, endCount
		addi	t6, t6, 1 # if it's symbol from a to z
		endCount:
		addi 	t0, t0, -1
		addi	t1, t1, 1
		
		bnez 	t0, loopCount
		
	mv	%upCase, t5
	mv	%lowCase, t6
	addi	sp, sp, 8
.end_macro

.macro ReadAndCount(%filedescrip)
	mv	a0, %filedescrip
	jal	ReadAndCount
.end_macro

.data
numberString: .space 10240
.macro WriteInt(%descriptor, %number)
	addi	sp, sp, -8
	sw	%descriptor, 4(sp)
	sw	%number, (sp)
	
	lw	t0, (sp)
	li	t1, 10000
	li	t2, 0
	la	t3, numberString
	loopWriteString:
	div	t4, t0, t1 #get the digit
	beqz	t4, IsZero
	addi	t2, t2, 1 #length of number
	mul 	t5, t1, t4 
	sub	t0, t0, t5 #get the next radixes
	j 	AddDigit
	IsZero:
	beqz 	t2, DontAdd
	addi	t2, t2, 1
	AddDigit:
	addi	t5, t4, 48 #to get the digit as a ASCII symbol
	sb	t5, (t3)
	addi	t3, t3, 1
	DontAdd:
	li	t4, 10
	div	t1, t1, t4
	li	t4, 1
	bne  	t1, t4, loopWriteString
	addi	t5, t0, 48
	sb	t5, (t3) #add \n
	addi	t2, t2, 1
	
	li   	a7 64	
    	lw   a0, 4(sp)
    	la   a1, numberString   # address of buffer from which to write
    	mv   a2, t2       # hardcoded buffer length
    	ecall             # write to file
    	addi sp, sp, 8
.end_macro

.macro WriteChar(%descriptor, %str)
	li   	a7, 64       # system call for write to file
    	mv   	a0, %descriptor
    	la   	a1, %str   # address of buffer from which to write
    	li	a2, 1	
    	ecall             # write to file
.end_macro 

.data
split: .asciz " "
.macro OpenAndWriteFileMacro(%typeOfInput, %LinkOrTemprRegister, %UpCaseCount, %LowCaseCount)
	addi	sp, sp, -16
	sw	%typeOfInput, 12(sp)
	sw	%LinkOrTemprRegister, 8(sp)
	sw	%UpCaseCount, 4(sp)
	sw	%LowCaseCount, (sp)
	
	lw	a0, 12(sp)
	lw	a1, 8(sp)
	lw	a2, 4(sp)
	lw	a3, (sp)
	addi	sp, sp, 16
	jal	OpenAndWriteFile
.end_macro
	 
