.include "macrolib.s"

.data 
FilePath: .asciz "InputFiles/Input2.txt"
.text
	addi 	sp, sp, -12
	sw	ra, 8(sp)
	li	t0, 1
	OpenFileAndReadMacro(t0, t1) #first arg – type Of FilePath Input (0 - from register, 1 - from the Console), 
					#second arg –any temporary register or line address with the file path
					#Returns the file descriptor in a0
	mv	t0, a0
	ReadAndCount(t0) #argument – file descriptor
			#Returns in a0 – number of high-case letters and in a1 – number of low-case letters
	
	mv	t2, a0
	mv	t3, a1
	sw	t2, 4(sp)
	sw	t3, (sp)
	
	WriteInConsole(t2, t3) #first arg – number of high-case letters
				#second arg – number of low-case letters
				#Returns nothing
	li	t0, 1
	lw	t2, 4(sp)
	lw	t3, (sp)
	OpenAndWriteFileMacro(t0, t1, t2, t3) #first arg – typeOfFilePathInput (0 - from register, 1 - from the Console)
				#second arg – any temporary register or line address with the file path
				#third arg – number of high-case letters
				#number of low-case letters
				#Returns nothing
	lw	ra, 8(sp)
	li 	a7, 10
	addi	sp, sp, 12
	ecall

