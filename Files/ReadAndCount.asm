.include "macrolib.s"

.text 
.global ReadAndCount

ReadAndCount:
	addi	sp, sp, -24
	sw	ra, 20(sp)
	sw	a0, 16(sp)
	sw	a0, 12(sp)
	li	t0, 0
	sw	t0, 8(sp) #count of readings
	sw	t0, 4(sp) #count of high-case letters
	sw	t0, (sp) #count of low-case letters
	loop:
		lw	a0, 12(sp)
		jal	ReadFile #a0 – file descriptor
				#Returns in a0 the  length of readed
				#in a1 – the pointer of the readed
		beqz 	a0, endReadAndCount
		
		lw	t0, 8(sp)
		addi	t0, t0, 1
		
		sw	t0, 8(sp)
		CountLetters (a0, a1, t0, t1) # first arg– length of the string
						#second arg –the string pointer
						#third arg – where we should save the number of high-case letters
						#fourth arg – where we should save the number of low-case letters
						#Returns in the third argument the number of high-case letters and 
						#in the fourth argument the number of low-case letters
		lw	t3, 4(sp)
		add	t3, t3, t0
		sw	t3, 4(sp)
		lw	t3, (sp)
		add	t3, t3, t1
		sw	t3, (sp)
		li	t1, 20 #the max number of reading – 10 KB
		lw	t0, 8(sp)
		bne 	t0, t1, loop
	endReadAndCount:
	lw	a0, 16(sp)
	li   	a7, 57       # Системный вызов закрытия файла replace
   	ecall             # Закрытие файла
   	lw	a0, 4(sp)
   	lw	a1, (sp)
   	lw	ra, 20(sp) 	
	addi	sp, sp, 24
	ret
