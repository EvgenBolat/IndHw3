# Чтение текста из файла, задаваемого в диалоге, в буфер фиксированного размера
.eqv    TEXT_SIZE 512	# Размер буфера для текста

.data
er_read_mes:    .asciz "Incorrect read operation\n"

strbuf:	.space TEXT_SIZE			# Буфер для читаемого текста

.text

.globl ReadFile
ReadFile:
	addi 	sp, sp, -4
	sw	ra, (sp)
    ###############################################################
    # Чтение информации из открытого файла
    li   a7, 63       # Системный вызов для чтения из файла
    la   a1, strbuf   # Адрес буфера для читаемого текста
    li   a2, TEXT_SIZE # Размер читаемой порции
    ecall             # Чтение
    # Проверка на корректное чтение
    li		t0, -1
    beq		a0 t0 er_read	# Ошибка чтения
    la	a1, strbuf
    lw		ra, (sp)
    addi	sp, sp, 4
    endRead:
    ret
er_read:
    # Сообщение об ошибочном чтении
    la		a0 er_read_mes
    li		a7 4
    ecall
    # И завершение программы
    li		a7 10
    ecall
