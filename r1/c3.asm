# Property of Mitchell Jonker

.data
	init: .asciiz "Program starts\n"
	end: .asciiz "Program ends\n"
	result: .asciiz "f = "
	nl: .asciiz "\n"
.text
	# initialize variables
	li $s0, 0 # i
	li $s1, 3 # j
	li $s2, 5 # k
	
	la $a0, init
	li $v0, 4
	syscall
	
	loop:
		bge $s0, 5, exit
		
		add $t0, $s0, $s1
		sub $t1, $t0, $s2
		
		la $a0, result
		li $v0, 4
		syscall
		
		move $a0, $t1
		li $v0, 1
		syscall
		
		la $a0, nl
		li $v0, 4
		syscall
		
		# increment i
		addi $s0, $s0, 1
		
		j loop
		
	exit:
		la $a0, end
		li $v0, 4
		syscall
		