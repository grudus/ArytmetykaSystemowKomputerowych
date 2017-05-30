.data
	list: .word 4, -5, 2, 5, -41, 11, 123, -513, 11, -10
	array: .space 40
	newLine: .asciiz "\n"

.text

main:
	li $t0, 0 #list index
	li $t1, 0 #array index
	la $t3, list
	
readList:
	lw $t2, 0($t3) #read from list
	move $a1, $t2 
	bgtz $a1, addToArray  #add to array if > 0

afterAdded:
	
	add $t3, $t3, 4 #listPointner += 4
	add $t0, $t0, 4 #listIndex += 4
	
	blt $t0, 40, readList  #while listIndex < 40 do read
	
	jal readArray
	li $v0, 10
	syscall

addToArray:
	sw $a1, array($t1)
	add $t1, $t1, 4 #t1 += 4
	j afterAdded


println:
	li $v0, 4
	la $a0, newLine
	syscall
	jr $ra
	
readArray:
	li $t0, 0 #new array index
doRead:
	lw $a0, array($t0)
	
	li $v0, 1
	syscall
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal println
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	add $t0, $t0, 4
	blt $t0, $t1, doRead

	jr $ra
	
