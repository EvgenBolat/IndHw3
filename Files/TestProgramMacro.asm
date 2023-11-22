.include "macrolib.s"

.data
firstIn: .asciz "InputFiles/Input1.txt"
secondIn: .asciz "InputFiles/Input2.txt"
thirdIn: .asciz "InputFiles/Input3.txt"
fourthIn: .asciz "InputFiles/Input4.txt"
fifthIn: .asciz "InputFiles/Input5.txt"

firstOut: .asciz "OutputFiles/Output1Macro.txt"
secondOut: .asciz "OutputFiles/Output2Macro.txt"
thirdOut: .asciz "OutputFiles/Output3Macro.txt"
fourthOut: .asciz "OutputFiles/Output4Macro.txt"
fifthOut: .asciz "OutputFiles/Output5Macro.txt"

.text
#First
	li	t0, 0
	la	t1, firstIn
	OpenFileAndReadMacro(t0, t1)
	mv	t0, a0
	ReadAndCount(t0)
	li	t0, 0
	la	t1, firstOut
	mv	t2, a0
	mv	t3, a1
	OpenAndWriteFileMacro(t0, t1, t2, t3)

#Second
	li	t0, 0
	la	t1, secondIn
	OpenFileAndReadMacro(t0, t1)
	mv	t0, a0
	ReadAndCount(t0)
	li	t0, 0
	la	t1, secondOut
	mv	t2, a0
	mv	t3, a1
	OpenAndWriteFileMacro(t0, t1, t2, t3)
	
#Third
	li	t0, 0
	la	t1, thirdIn
	OpenFileAndReadMacro(t0, t1)
	mv	t0, a0
	ReadAndCount(t0)
	li	t0, 0
	la	t1, thirdOut
	mv	t2, a0
	mv	t3, a1
	OpenAndWriteFileMacro(t0, t1, t2, t3)

#Fourth
	li	t0, 0
	la	t1, fourthIn
	OpenFileAndReadMacro(t0, t1)
	mv	t0, a0
	ReadAndCount(t0)
	li	t0, 0
	la	t1, fourthOut
	mv	t2, a0
	mv	t3, a1
	OpenAndWriteFileMacro(t0, t1, t2, t3)

#Fifth
	li	t0, 0
	la	t1, fifthIn
	OpenFileAndReadMacro(t0, t1)
	mv	t0, a0
	ReadAndCount(t0)
	li	t0, 0
	la	t1, fifthOut
	mv	t2, a0
	mv	t3, a1
	OpenAndWriteFileMacro(t0, t1, t2, t3)
li	a7, 10
ecall