.data
arrayLength: .word 4
myArray: .space 16
prompt1: .asciiz "Podaj wartosci przy potegach wielomianu 3. stopnia: (Po kazdej wcisnij 'enter'): \n"
prompt2: .asciiz "Podaj wartosc funkcji: \n"
message: .asciiz "Wartosc funkcji dla podanego argumentu to: "

.text 

main:
	la $a0, prompt1
	jal printString
	
	
loadArray:
	li $t0, 0 #counter
	addi $t1, $zero, 0 #arrayIndex
	lw $t2, arrayLength #number of iterations
	
whileLoadingArray:
	#Load input from user
	li $v0, 5  
	syscall
	sw $v0, myArray($t1) #add input to array to position t1
	
	addi $t1, $t1, 4 #arrayIndex = arrayIndex + 4
	addi $t0, $t0, 1 #counter++
	blt $t0, $t2, whileLoadingArray   #if counter < number of iterations repeat; otherwise - go down
	
getFunctionArgument:
	la $a0, prompt2
	jal printString
	
	li $v0, 5
	syscall
	move $t4, $v0 #user's input
	
	#Funtion looks like f(x) = ax^3 + bx^2 + cx + d, where a,b,c,d are taken from user and stored in array
	#(and a is on 0 index, b on 4 etc) 
	li $t0, 0 #counter
	li $t1, 0 #arrayIndex
	lw $t2, arrayLength #array length
	li $t3, 0 #result
	
calculateFunctionForArgument:
	add $a1, $t4, 0  #we pass base for power in a1
	sub $a2, $t2, $t0 #a2 = arrayLength - counter
	sub $a2, $a2, 1 #a2 = arrayLength - counter
	
	jal power  #v1 = argument ^ (arrayLength - counter)
	
	lw $a1, myArray($t1) #store user's input (polymonial constants) in a1
	mul $a1, $a1, $v1 #monomial = input * (argument ^ (arrayLength - counter))
	add $t3, $t3, $a1 #result += monomial
	
	addi $t0, $t0, 1 #counter++
	addi $t1, $t1, 4 #arrayIndex += 4
	
	blt $t0, $t2, calculateFunctionForArgument  #if counter < array length repeat; otherwise - go down
	
publishResult:
	la $a0, message
	jal printString
	
	move $a0, $t3
	jal printInt
	
	
#a1 - base
#a2 - exponent
#fe calling power with a1=2 and a2=10 will result in v1 with 1024
power:
	li $v1, 1 #result
calculatePower:	
	beqz $a2, endPower #return 1 if exponent is 0
	mul $v1, $v1, $a1  #result *= base
	
	add $a2, $a2, -1  #power--
	bgtz $a2, calculatePower #while power > 0 repeat 
	
endPower:
	jr $ra
	
exit: 
	li $v0, 10
	syscall
	
	
	
	
printString:
	li $v0, 4
	syscall
	jr $ra
	
printInt:
	li $v0, 1
	syscall
	jr $ra
	
