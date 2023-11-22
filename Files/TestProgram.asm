.include "macrolib.s"

.data
firstIn: .asciz "InputFiles/Input1.txt"
secondIn: .asciz "InputFiles/Input2.txt"
thirdIn: .asciz "InputFiles/Input3.txt"
fourthIn: .asciz "InputFiles/Input4.txt"
fifthIn: .asciz "InputFiles/Input5.txt"

firstOut: .asciz "OutputFiles/Output1.txt"
secondOut: .asciz "OutputFiles/Output2.txt"
thirdOut: .asciz "OutputFiles/Output3.txt"
fourthOut: .asciz "OutputFiles/Output4.txt"
fifthOut: .asciz "OutputFiles/Output5.txt"

.text
#First
	addi 	sp, sp, -4
	sw	ra, (sp)
	li	a0, 0
	la	a1, firstIn
	jal OpenForReadFileUni # a0 – type Of FilePath Input (0 - from register, 1 - from the Console)
				#a1 – any temporary register or line address with the file path
				#Returns the file descriptor in a0
	jal ReadAndCount #a0 – file descriptor
			#Returns in a0 – number of high-case letters and 
			#in a1 – number of low-case letters
	mv	a2, a0
	mv	a3, a1
	li	a0, 0
	la	a1, firstOut
	
	jal OpenAndWriteFile # a0 – type Of FilePath Input (0 - from register, 1 - from the Console)
				#a1 – any temporary register or line address with the file path
	lw	ra, (sp)
	addi	sp, sp, 4

#Second
	addi 	sp, sp, -4
	sw	ra, (sp)
	li	a0, 0
	la	a1, secondIn
	jal OpenForReadFileUni
	jal ReadAndCount
	mv	a2, a0
	mv	a3, a1
	li	a0, 0
	la	a1, secondOut
	jal OpenAndWriteFile
	lw	ra, (sp)
	addi	sp, sp, 4
	
#Third
	addi 	sp, sp, -4
	sw	ra, (sp)
	li	a0, 0
	la	a1, thirdIn
	jal OpenForReadFileUni
	jal ReadAndCount
	mv	a2, a0
	mv	a3, a1
	li	a0, 0
	la	a1, thirdOut
	jal OpenAndWriteFile
	lw	ra, (sp)
	addi	sp, sp, 4

#Fourth
	addi 	sp, sp, -4
	sw	ra, (sp)
	li	a0, 0
	la	a1, fourthIn
	jal OpenForReadFileUni
	jal ReadAndCount
	mv	a2, a0
	mv	a3, a1
	li	a0, 0
	la	a1, fourthOut
	jal OpenAndWriteFile
	lw	ra, (sp)
	addi	sp, sp, 4

#Fifth
	addi 	sp, sp, -4
	sw	ra, (sp)
	li	a0, 0
	la	a1, fifthIn
	jal OpenForReadFileUni
	jal ReadAndCount
	mv	a2, a0
	mv	a3, a1
	li	a0, 0
	la	a1, fifthOut
	jal OpenAndWriteFile
	lw	ra, (sp)
	addi	sp, sp, 4
li	a7, 10
ecall
