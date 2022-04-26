# Property of Mitchell Jonker

.data 
	prompt: .asciiz "Welcome to Program 1!\nEnter three numerical values, each separated by an Enter key.\n"
	return: .asciiz "The lowest non-zero number is: "
	NL: .asciiz "\n"
	errtext: .asciiz "There is no non-zero value in the entered list of integers.\nTerminating program."
	
.text
	la $a0, prompt
	li $v0, 4
	syscall
	
	# store three inputted values
	li $v0, 5
	syscall
	move $s0, $v0
	
	li $v0, 5
	syscall
	move $s1, $v0
	
	li $v0, 5
	syscall
	move $s2, $v0
	
	# sort through inputted values
	j sort
	
sort:		
	bgt $s0, $s1, swap
	bgt $s1, $s2, swap2
	bgt $s0, $s1, swap
	bgt $s1, $s2, swap2
	j confirm

swap:
	move $t0, $s0
	move $s0, $s1
	move $s1, $t0
	j sort
	
swap2:
	move $t0, $s1
	move $s1, $s2
	move $s2, $t0
	j sort

confirm:
	addi $t2, $t2, 1
	beq $t2, 51, err
	beqz $s0, retrack
	j print

retrack:
	# Shift values by one if the first is 0
	move $s0, $s1
	move $s1, $s2
	addi $t2, $t2, 1
	j confirm

print:
	li $v0, 4
	la $a0, return
	syscall
	
	li $v0, 1
	la $a0, ($s0)
	syscall
	
	li $v0, 10
	syscall
	
err:
	li $v0, 4
	la $a0, errtext
	syscall
	
	li $v0, 10
	syscall