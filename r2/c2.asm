# Property of Mitchell Jonker

.data
	prompt: .asciiz "Welcome to the BMI calculator!\n"
	weight: .asciiz "Enter the weight (in pounds).\n"
	height: .asciiz "Enter the height (in feet).\n"
	underw: .asciiz "BMI Index is Underweight.\n\n"
	normalw: .asciiz "BMI Index is Normal.\n\n"
	overw: .asciiz "BMI Index is Overweight.\n\n"
	bmi: .asciiz "BMI #: "
	nl: .asciiz "\n"
	w: .float 0.0
	h: .float 0.0
	fti: .float 12.0
	bmic: .float 703.0
	buw: .float 18.5
	bnw: .float 24.9
	bow: .float 25.0
	
.text
	# Initialize SFPVs
	l.s $f1, w
	l.s $f2, h

	# Prompt Welcome
	li $v0, 4
	la $a0, prompt
	syscall
	
	j process
	
process:
	# Prompt to enter weight	
	li $v0, 4
	la $a0, weight
	syscall
	
	# Accept weight value
	li $v0, 6
	syscall
	mov.s $f1, $f0
	
	# Prompt to enter height
	li $v0, 4
	la $a0, height
	syscall
	
	# Accept height value
	li $v0, 6
	syscall
	mov.s $f2, $f0
	
	## Calculate the BMI
	
	# Feet to Inches
	l.s $f4, fti
	mul.s $f2, $f2, $f4
	
	# Inches squared
	mul.s $f2, $f2, $f2
	
	# Pounds per Inches squared
	div.s $f3, $f1, $f2
	
	# Multiply by BMI metric constant
	l.s $f4, bmic
	mul.s $f3, $f3, $f4
	# BMI is stored in $f3
	
	## Print BMI
	li $v0, 4
	la $a0, bmi
	syscall
	
	li $v0, 2
	mov.s $f12, $f3
	syscall
	
	li $v0, 4
	la $a0, nl
	syscall
	
	## Read BMI and find status.
	
	# Underweight?
	l.s $f4, buw
	c.lt.s $f3, $f4
	bc1t underweight
	
	# Overweight?
	l.s $f4, bow
	c.le.s $f4, $f3
	bc1t overweight
	
	# If not uw or ow, normal
	j normalweight
	
	
underweight:
	li $v0, 4
	la $a0, underw
	syscall
	la $a0, nl
	syscall
	j process

normalweight:
	li $v0, 4
	la $a0, normalw
	syscall
	la $a0, nl
	syscall
	j process

overweight:
	li $v0, 4
	la $a0, overw
	syscall
	la $a0, nl
	syscall
	j process