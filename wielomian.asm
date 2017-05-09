.data
myArray: .space 16
prompt1: .asciiz "Podaj wartosci przy potegach wielomianu 3. stopnia: \n"
prompt2: .asciiz "Podaj wartosc funkcji: \n"

	
.text 

#NA RAZIE NIE LICZY DOBRZE XD ALE S¥ PÊTLE WARUNKI TABLICE ITD.

main:
	la $a1, prompt1
	jal printString
	
	addi $a1, $zero, 4
	jal loadArray  #load user's input to RAM's myArray 
	
	la $a1, prompt2
	jal printString
	
	li $v0, 5
	syscall
	move $a1, $v0
	addi $a0, $a1, 0
	
	la $a2, 4
	jal calculateResult

	li $v0, 1
	move $a0, $v1
	syscall
	
	li $v0, 10
	syscall


loadArray:
	li $t0, 1 #counter
	addi $t1, $zero, 0 #arrayIndex
	move $t2, $a1 #number of iterations
	
	sw $ra, 0($sp)
	jal whileLoadingArray
	lw $ra, 0($sp)
	
	
	jr $ra
	
whileLoadingArray:
	bgt $t0, $t2, endLoadingArray #(counter < number)

	li $v0, 5  #load input from user
	syscall
	sw $v0, myArray($t1)
	
	addi $t1, $t1, 4 #arrayIndex = index + 4
	addi $t0, $t0, 1 #counter++
	j whileLoadingArray #}

endLoadingArray:
	jr $ra

printString:
	li $v0, 4
	move $a0, $a1
	syscall
	jr $ra
	
	
calculateResult:
	li $t4, 1 #counter
	li $t5, 0 #result
	li $t6, 0 #array index
	move $t7, $a1 #len of array
	move $s1, $a0 #function argument
	
	addi $sp $sp, -12
	sw $ra, 0($sp)
	jal whileCalculating
	lw $ra, 0($sp)
	
	jr $ra

whileCalculating:
	bgt $t4 $t7 endCalculating

	move $a1, $s1 #argument
	move $a2, $t4 #counter
	sw $ra, 4($sp)
	jal pow  
	lw $ra, 4($sp)  #v1 = argument ^ counter
	
	lw $a1, myArray($t6) 
	mul $v1, $v1, $a1 #v1 = (argument*^counter) * wielomianu liczba wprowadzona
	addi $t5, $v1, 0
	
	addi $t6, $t6, 4 #arrayIndex += 4
	addi $t4, $t4, 1 #counter ++
	j whileCalculating
	
endCalculating:
	move $v1, $t5
	jr $ra


#returns the pow
pow:
	li $t0, 1 #counter
	li $t1, 1 #result
	addi $t2, $a2, 0 #power
	addi $t3, $a1, 0 #base
	
	sw $ra, 8($sp)
	jal while
	lw $ra, 8($sp)
	jr $ra
	 
	
	
while:
	bgt $t0, $t2, end #(counter < power)
	mul $t1, $t1, $t3  #result = result * base
	
	add $t0, $t0, 1 #counter ++
	j while #}
end:
	move $v1, $t1
	jr $ra
