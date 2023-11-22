.include "macrolib.s"

.text
.global OpenForReadFileUni

OpenForReadFileUni:
	addi	sp, sp, -4
	sw	ra, (sp)
	beq 	a0 , zero, LoadLabel
	li	t0, 1
	bne 	a0, t0, errorType
	LoadLabel:
	JustOpenFile:
	jal	OpenForReadFile
	j	Finish
errorType:
print_str("Error")
Finish:
	lw	ra, (sp)
	addi	sp, sp, 4
	ret
