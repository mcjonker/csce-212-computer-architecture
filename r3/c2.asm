# Property of Mitchell Jonker

.data
	prompt: .asciiz "Welcome to Program 2!\nEnter the value for variable a\n"
	getb: .asciiz "Enter the value for variable b\n"
	getc: .asciiz "Enter the value for variable c\n"
	return: .asciiz "\nResult of the function: "
	zero_err: .asciiz "\nDivide by zero error"
	nooverflow_msg: .asciiz "\nNo Overflow"
	overflow_msg: .asciiz "\nOverflow exception error"

.text
	# Get variables t0 = a, t1 = b, t2 = c
	la $a0, prompt
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	la $a0, getb
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0
	
	la $a0, getc
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t2, $v0
	
	
	
	# Calculate F
	li $t3, 1 # temp counter
	move $t4, $t1 # t4 is original b
	
	j exp_loop
	
	
exp_loop:

	bge $t3, $t2, fxa
	mul $t1, $t1, $t4 # B*B
	addiu $t3, $t3, 1 # Increment counter
	
	j exp_loop
fxa:
	# Fxa = $s0
	add $s0, $t0, $t1
	
	j fxb
	
fxb:
	
	# Fxb = $s1
	mulu $s6, $t0, $t0 # A*A
	subu $s1 $t2, $s6
	beqz $s1, div_zero


fxc:
	# fxc = $s2
	mulu $s2, $t4, 3
	
	# load logical counter
	li $t9, 0
	j conj

	
conj:
	
	beq $t9, 0, test_a
	beq $t9, 1, test_b
	beq $t9, 2, test_c
	bge $t9, 3, combine
	
	
	

test_a:
	addi $t9, $t9, 1 # increment logical filter
	move $t5, $t0 # a
	move $t6, $t1 # b^c
	move $t8, $s0 # fxa
	
	j test_overflow
	
test_b:
	addi $t9, $t9, 1 # increment logical filter
	move $t5, $t2 # c
	move $t6, $s6 # a^2
	move $t8, $s1 # fxb
	
	j test_overflow

test_c:
	addi $t9, $t9, 1 # increment logical filter
	li $t5, 3     # 3 
	move $t6, $t4 # b
	move $t8, $s2 # fxc
	
	j test_overflow
	
test_overflow:
	
	# Set test vals to $t5, $t6, $t8. test is stored into $t7
	xor $t7, $t5, $t6
	slt $t7, $t7, $zero
	#bne $t7, $zero, no_overflow
	xor $t7, $t8, $t5
	slt $t7, $t7, $zero
	bne $t3, $zero, no_overflow
	
	
no_overflow:

	la $a0, nooverflow_msg
	j conj

overflow:

	la $a0, overflow_msg
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall

div_zero:

	la $a0 zero_err
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall

combine:

	div $s3, $s0, $s1
	add $s3, $s3, $s2

	j print

	
print: 

	# print output
	li $v0, 4
	syscall
	
	la $a0, return
	li $v0, 4
	syscall
	
	la $a0, ($s3)
	li $v0, 1
	syscall
	
	


