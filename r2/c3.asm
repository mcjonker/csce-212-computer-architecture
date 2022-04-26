# Property of Mitchell Jonker

.data
	welc: .asciiz "Welcome to Total Work Time Calculator!\n"
	pHW: .asciiz "How many homeworks did you complete?\n"
	pAvgHWTime: .asciiz "On average, how long did it take to complete one homework (in hours)?\n"
	pEx: .asciiz "How many exercises did you complete?\n"
	pAvgExTime: .asciiz "On average, how long did it take you to complete one exercise (in hours)?\n"
	ans: .asciiz "The total work time in hours: "
	
.text
	# $t0 = hw count
	# $t1 = hw avg hours
	# $t2 = ex count
	# $t3 = ex avg hours
	
	# Welcome
	li $v0, 4
	la $a0, welc
	syscall
	
	# HW Count Prompt
	li $v0, 4
	la $a0, pHW
	syscall
	
	# Accept HW Count
	li $v0, 5
	syscall
	move $t0, $v0
	
	# HW Avg Hours Prompt
	li $v0, 4
	la $a0, pAvgHWTime
	syscall
	
	# Accept HW Avg Hours
	li $v0, 5
	syscall
	move $t1, $v0
	
	# Ex Count Prompt
	li $v0, 4
	la $a0, pEx
	syscall
	
	# Accept Ex Count
	li $v0, 5
	syscall
	move $t2, $v0
	
	# Ex Avg Hours Prompt
	li $v0, 4
	la $a0, pAvgExTime
	syscall
	
	# Accept Ex Avg Hours
	li $v0, 5
	syscall
	move $t3, $v0

	## Calculate work hours
	
	# Init t4(total hw hours) & t5(total ex hours).
	li $t4, 0
	li $t5, 0
	
	jal calc
	
	
	j print
	
calc:
	addi $sp, $sp, -8
	sw $t4, 0($sp)
	sw $t5, 4($sp)
	
	mul $v0, $t0, $t1
	move $t4, $v0
	sw $t4, 0($sp)
	
	mul $v0, $t2, $t3
	move $t5, $v0
	sw $t5, 4($sp)
	
	lw $t4, 0($sp)
	lw $t5, 4($sp)
	
	addi $sp, $sp, -4
	
	add $v0, $t4, $t5
	move $t6, $v0
	sw $t6, 8($sp)
	
	lw $s0, 8($sp)
	
	addi $sp, $sp, 12
	
	jr $ra
	
	
	
print:	

	li $v0, 4
	la $a0, ans
	syscall
	
	li $v0, 1
	la $a0, ($s0)
	syscall
	
	#li $v0, 1
	#la $a0, ($s0)
	#syscall
	#la $a0, ($s1)
	#syscall
	#la $a0, ($s2)
	#syscall
	#la $a0, ($s3)
	#syscall
	
	