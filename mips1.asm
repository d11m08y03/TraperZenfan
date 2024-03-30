.data
	prompt: .asciiz "Enter number (-69 to finish): "
	newline: .asciiz "\n"
	maxNumbers: .word 10
	array: .space 40 
	maximum: .word 0
	minimum: .word 0
	sum: .word 0
	maximumStr: .asciiz "Maximum is: "
	minimumStr: .asciiz "Minimum is: "
	sumStr: .asciiz "Sum is: "
	
.text 
  # Mari ggt sa bout la flmmm
	main:
		# Load address of array into $t0
		la $t0, array
		# Initialise input counter to 0
		li $t1, 0
		lw $t4, maxNumbers
		
		loop:
			# Prompt user
			li $v0, 4
			la $a0, prompt
			syscall
			
			# Read input from user and move it to $t2
			li $v0, 5
			syscall
			move $t2, $v0
			
			# Check if user wants to finish
			li $t3, -69
			beq $t2, $t3, exitLoop
			
			# Update the maximum number
			lw $t5, maximum
			bgt $t2, $t5, updateMaximum
			j checkMinimum
			
		updateMaximum:
			sw $t2, maximum
			j checkMinimum
			
		checkMinimum:
			lw $t5, minimum
			blt $t2, $t5, updateMinimum
			j sumAndLoop
			
		updateMinimum:
			sw $t2, minimum
			
		sumAndLoop:
			lw $t6, sum
			add $t6, $t6, $t2
			sw $t6, sum
			
			# Store input into array
			sw $t2, ($t0)
			 
			# Increment array pointer
			addi $t0, $t0, 4 
			 
			# Increment input counter
			addi $t1, $t1, 1
			 
			# Check if all 10 numbers have been read
			bge $t1, $t4, exitLoop
			
			# We go again
			j loop
			
		exitLoop:
			# Ouptut new line
			li $v0, 4
			la $a0, newline
			syscall 
			
			# Output maximum
			li $v0, 4
			la $a0, maximumStr
			syscall
			
			li $v0, 1
			lw $a0, maximum
			syscall
			
			li $v0, 4
			la $a0, newline
			syscall
			
			# Output minimum
			li $v0, 4
			la $a0, minimumStr
			syscall
			
			li $v0, 1
			lw $a0, minimum
			syscall
			
			li $v0, 4
			la $a0, newline
			syscall
			
			# Output sum
			li $v0, 4
			la $a0, sumStr
			syscall
			
			li $v0, 1
			lw $a0, sum
			syscall
			
			li $v0, 4
			la $a0, newline
			syscall
			
			# Exit program
			li $v0, 10
        syscall	 
