.data

.text

main:
	li $t0, 1
	li $t1, 2
	li $t2, 3
	li $t3, 4
	
	move $a1, $t0
	jal push
	move $a1, $t1
	jal push
	move $a1, $t2
	jal push
	move $a1, $t3
	jal push
	
	jal pop
	move $a0, $v1
	jal printInt
	jal pop
	move $a0, $v1
	jal printInt
	jal pop
	move $a0, $v1
	jal printInt
	jal pop
	move $a0, $v1
	jal printInt
	
	j exit
	
	
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
	
printInt:
	li $v0, 1
	syscall
	jr $ra
	
exit:
	li $v0, 10
	syscall