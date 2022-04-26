# Property of Mitchell Jonker

.data
	prompt: .asciiz "Welcome to Program 1!\nEnter the first integer.\n"
	getnext: .asciiz "Enter the second integer.\n"
	return: .asciiz "\nThe resulting value:\n"
	
.text
	la $a0, prompt
	li $v0, 4
	syscall
	
	# Store inputted values as integers.
	li $v0, 5
	syscall
	move $t0, $v0
	
	la $a0, getnext
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0
	
	# Multiplication procedure
	# t0 = first val
	# t1 = second val
	# t2 = loop counter
	# t4 = reference of largest value
	
	# load temp value and reference value
	li $t2, 1
	move $t4, $t0
	
	# if in order, branch
	bgt $t0, $t1, mproc
	
	# else, sort, set reference, then jump
	move $t3, $t0
	move $t0, $t1
	move $t1, $t3
	move $t4, $t0
	j mproc
	
mproc:
	# test for exceptions
	ble $t1, 1, one
	
	add $t0, $t0, $t4
	addi $t2, $t2, 1
	bge $t2, $t1, end
	j mproc
	
one:
	# value is zero, return 0
	beq $t1, 0, zero
	j end
	
zero:
	move $t0, $t1
	j end

end:
	# print output
	la $a0, return
	li $v0, 4
	syscall
	
	# print t0
	mtc1 $t0, $f0
	cvt.s.w $f0, $f0
	mov.s $f12, $f0
	li $v0, 2
	syscall	
	
	# terminate
	li $v0, 10
	syscall