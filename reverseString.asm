.data
	prompt: .asciiz "Enter a word (max 128 chars): "
	message1: .asciiz  "Your word is: "
	message2: .asciiz "Has length: "
	message3: .asciiz "\nYour word reversed is: "
	
	input: .space 128
.text

main:
	la $a0, prompt
	jal printString 
	
	li $v0, 8
	la $a0, input
	li $a1, 128
	syscall
	
	la $a0, message1
	jal printString
	
	la $a0, input
	jal printString
	
	la $a1, input
	jal stringLength
	move $s1, $v1
	
	la $a0, message2
	jal printString
	
	add $a0, $zero, $s1
	jal printInt
	
	la $t1, input

reverseString:
	lbu $t6, 0, ($t1) #load char to t6 
	addi $t1, $t1, 1 
	move $a1, $t6

	jal push
	
	bnez $t6, reverseString
	la $t1, input
	li $t0, -2 #counter
	la $a0, message3
	jal printString
	
printReversed:
	jal pop
	move $a0, $v1
	jal printChar
	
	addi $t0, $t0, 1
	addi $t1, $t1, 1
	blt $t0, $s1, printReversed
	
	j exit



#calculate the length of the string passed in a1 and return result in v1
stringLength:
	li $v1, -2 #counter  (1 byte for special character?)
stringLengthLoop:
	addi $v1, $v1, 1 #counter++
	
	lbu $t6, 0, ($a1) #load char to t6 
	addi $a1, $a1, 1 
	
	bnez $t6, stringLengthLoop
	jr $ra

#add argument passed in a1 to the stack
push:
	sub $sp, $sp, 4 #decrement stack pointer
	sw $a1, 0($sp)
	jr $ra

#get argument from stack and store in v1	
pop:
	lw $v1, 0($sp)
	addi $sp, $sp, 4 #increment stack pointer
	jr $ra
	
printString:
	li $v0, 4
	syscall
	jr $ra
	

printInt:
	li $v0, 1
	syscall
	jr $ra
	
	
printChar:
	li $v0, 11
	syscall
	jr $ra
	
	
exit:
	li $v0, 10
	syscall
