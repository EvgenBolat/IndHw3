.include "macrolib.s"

.data 
ErrorName: .asciz "Error"

.text

.global OpenAndWriteFile
OpenAndWriteFile:
	addi	sp, sp, -16
	sw	ra, 12(sp)
	sw	a2, 8(sp)
	sw	a3, 4(sp)
	beq 	a0 , zero, JustOpenOrCreateFile
	li	t0, 1
	bne 	a0, t0, errorType
	
	JustOpenOrCreateFile:
	jal	OpenForWriteFile
	sw	a0, (sp)
	
	lw	t0, (sp)
	lw	t1, 8(sp)
	WriteInt(t0, t1) # first arg – file descriptor
			#second arg – number that should be written
			#Returns nothing
	
	lw	t0, (sp)
	WriteChar(t0, split) # first arg – file descriptor
			#second arg – Char that should be written
			#Returns nothing
	
	lw	t0, (sp)
	lw	t1, 4(sp)
	WriteInt(t0, t1)
	j	endOpenFile
errorType:
endOpenFile:
	# Close the file
    	li   a7, 57       # system call for close file
    	lw   a0, (sp)      # file descriptor to close
    	ecall             # close file
	lw	ra, 12(sp)
	addi sp, sp, 16
	ret
