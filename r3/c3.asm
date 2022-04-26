# Property of Mitchell Jonker

.data
	prompt: .asciiz "Welcome to Program 3!\n"
	p1_msg: .asciiz "Enter the information for Processor A"
	p2_msg: .asciiz "\nEnter the information for Processor B"
	ic: .asciiz "\nEnter the instruction count\n"
	cpi: .asciiz "\nEnter the Clocks per Instruction (CPI)\n"
	cr: .asciiz "\nEnter the Clock Rate (in GHz)\n"
	one_greater: .asciiz "\nProcessor A is "
	two_greater: .asciiz "\nProcessor B is "
	one_greater_tag: .asciiz " times as fast as B."
	two_greater_tag: .asciiz " times as fast as A."
	equal_performance: .asciiz "\nProcessors A and B are equal in performance."
	
.text
	# Welcome Prompt
	la $a0, prompt
	li $v0, 4
	syscall

	## Store information of P1
	## P1: IC = f1, CPI = f2, CR = f3
	
	# P1 Prompt
	la $a0, p1_msg
	li $v0, 4
	syscall
	
	# IC
	la $a0, ic
	li $v0, 4
	syscall 
	
	# Accept IC
	li $v0, 6
	syscall
	mov.s $f1, $f0
	
	# CPI
	la $a0, cpi
	li $v0, 4
	syscall
	
	# Accept CPI
	li $v0, 6
	syscall
	mov.s $f2, $f0
	
	# CR
	la $a0, cr
	li $v0, 4
	syscall
	
	# Accept CR
	li $v0, 6
	syscall
	mov.s $f3, $f0
	
	## Store information of P2
	## P2: IC = f4, CPI = f5, CR = f6
		
	# P2 Prompt
	la $a0, p2_msg
	li $v0, 4
	syscall 
	# IC
	la $a0, ic
	li $v0, 4
	syscall
	
	# Accept IC
	li $v0, 6
	syscall
	mov.s $f4, $f0
	
	# CPI
	la $a0, cpi
	li $v0, 4
	syscall
	
	# Accept CPI
	li $v0, 6
	syscall
	mov.s $f5, $f0
	
	# CR
	la $a0, cr
	li $v0, 4
	syscall
	
	# Accept CR
	li $v0, 6
	syscall
	mov.s $f6, $f0
	
	## Calculate CPU-1 Time - Stored in f7
	mul.s $f7, $f1, $f2
	div.s $f7, $f7, $f3
	
	## Calculate CPU-2 Time - stored in f8
	mul.s $f8, $f4, $f5
	div.s $f8, $f8, $f6

	## Compare Times
	cvt.w.s $f9, $f7
	cvt.w.s $f10, $f8
	mfc1 $t0, $f9
	mfc1 $t1, $f10
	bgt $t0, $t1, one_is_greater
	bgt $t1, $t0, two_is_greater
	beq $t0, $t1, equal
	
one_is_greater:
	
	# Report performace difference
	la $a0, two_greater
	li $v0, 4
	syscall
	
	div.s $f11, $f7, $f8
	
	mov.s $f12, $f11
	li $v0, 2
	syscall
	
	la $a0, two_greater_tag
	li $v0, 4
	syscall
	
	j end

two_is_greater:

	# Report performance difference
	la $a0, one_greater
	li $v0, 4
	syscall

	div.s $f11, $f8, $f7
	mov.s $f12, $f11
	li $v0, 2
	syscall
	
	la $a0, one_greater_tag
	li $v0, 4
	syscall
	
	j end
equal:

	# Report equal performance
	la $a0, equal_performance
	li $v0, 4
	syscall

	j end
end:

	# End Program
	li $v0, 10
	syscall