# Property of Mitchell Jonker

.data
	pr0: .asciiz "Enter Value for A\n"
	pr1: .asciiz "Enter Value for B\n"
	pr2: .asciiz "Enter Value for C\n"
	pr3: .asciiz "Enter Value for D\n"
	result: .asciiz "F = "
	negative: .asciiz "A negative value was entered. Please restart the program."

.text
	li $s0, 0 # a
	li $s1, 0 # b
	li $s2, 0 # c
	li $s3, 0 # d
	li $s4, 0 # 0
	
	# Prompt and store A, if negative, err and exit
	li $v0, 4
	la $a0, pr0
	syscall
	
	li $v0, 5
	syscall
		
	move $s0, $v0
	bltz $s0, negative_error
	
	# Prompt and store B, if negative, err and exit
	li $v0, 4
	la $a0, pr1
	syscall
	
	li $v0, 5
	syscall
	
	move $s1, $v0
	bltz $s1, negative_error
	
	# Prompt and store C, if negative, err and exit
	li $v0, 4
	la $a0, pr2
	syscall
	
	li $v0, 5
	syscall
	
	move $s2, $v0
	bltz $s2, negative_error
	
	# Prompt and store D, if negative, err and exit
	li $v0, 4
	la $a0, pr3
	syscall
	
	li $v0, 5
	syscall
	
	move $s3, $v0
	bltz $s3, negative_error
	
	
	
	# Calculate F
	add $t0, $s0, $s1 # p1
	add $t1, $s2, $s3 # p2
	addi $t2, $s1, 3  # p3
	
	sub $t3, $t0, $t1
	add $t4, $t3, $t2
	
	# Present user with answer F
	li $v0, 4
	la $a0, result
	syscall
	
	li $v0, 1
	move $a0, $t4
	syscall
	
	li $v0, 10
	syscall
	
	
	negative_error:
	li $v0, 4
	la $a0, negative
	syscall
		
	li $v0, 10
	syscall


