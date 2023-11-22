.eqv    NAME_SIZE 256	# Размер буфера для имени файла
.data
prompt:         .asciz "\nInput file path to write the numbers: "     # Путь до читаемого файла
er_name_mes:    .asciz "Incorrect file name\n"
file_name:      .space	NAME_SIZE		# Имячитаемого файла
.text
.global OpenForWriteFile

OpenForWriteFile:
addi 	sp, sp, -4
	sw	ra, (sp)
    	###############################################################
    	# Вывод подсказки
    	beq 	a0, zero, ReadLabel
    	la	a0 prompt #if we get the path from the Console
    	li	a7 4
    	ecall
    	# Ввод имени файла с консоли эмулятора
    	la	a0 file_name
    	li      a1 NAME_SIZE
    	li      a7 8
    	ecall
    	j bodyOfOpen
    	ReadLabel:
    	mv	a0, a1 #if we get the path from the register
    	li      a1 NAME_SIZE
    	j replaceWithLabel
    	bodyOfOpen:
    	# Убрать перевод строки
    	li	t4 '\n'
    	la	t5	file_name
	loop:
	    lb		t6, (t5)
	    beq 	t4, t6, replace
	    addi 	t5, t5, 1
	    b		loop
replace:
    sb	zero (t5)
    ###############################################################
    li   	a7 1024     	# Системный вызов открытия файла
    la      a0 file_name    # Имя открываемого файла
    li   	a1 9        	# Открыть для чтения (флаг = 0)
    ecall             		# Дескриптор файла в a0 или -1)
    li		t0 -1			# Проверка на корректное открытие
    beq		a0 t0 er_name	# Ошибка открытия файла
    ###############################################################
    lw		ra, (sp)
    addi	sp, sp, 4
    ret
    
replaceWithLabel:
    ###############################################################
    li   	a7 1024     	# Системный вызов открытия файла
    li   	a1 9        	# Открыть для записи (флаг = 9)
    ecall             		# Дескриптор файла в a0 или -1)
    li		t0 -1			# Проверка на корректное открытие
    beq		a0 t0 er_name	# Ошибка открытия файла
    ###############################################################
    lw		ra, (sp)
    addi	sp, sp, 4
    ret

er_name:
    # Сообщение об ошибочном имени файла
    la		a0 er_name_mes
    li		a7 4
    ecall
    # И завершение программы
    addi	sp, sp, 4
    li		a7 10
    ecall
