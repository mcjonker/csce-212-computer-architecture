# Property of Mitchell Jonker

.data
	prompt: .asciiz "Hello, may I have your name, please?\n"
	welcome: .asciiz "Welcome, "
	name: .space 50
	

.text
	la $a0, prompt
	li $v0, 4
	syscall
	
	la $a0, name
	la $a1, 50
	li $v0, 8
	syscall
	
	la $a0, welcome
	li $v0, 4
	syscall
	
	la $a0, name
	li $v0, 4
	syscall
	
	
	
