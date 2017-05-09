.data 
	prompt1: .asciiz "Welcome in power calculator! Enter your base number: \n"
	prompt2: .asciiz "Enter the exponent: \n"
	
	prompt: .asciiz 
	
	

# calculating the pow 
.text
	main:
	
	li $v0, 4
	la $a0, prompt1
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $v0, 4
	la $a0, prompt2
	syscall
	
	li $v0, 5
	syscall
	move $t2, $v0
	
	move $a1, $t0
	move $a2, $t2
	
	j pow
	
	
	# while (counter < power) {
	#    result *= base
	#    counter++
	#}
	pow:
	li $t0, 0 #counter
	li $t1, 1 #result
	addi $t2, $a2, 0 #power
	addi $t3, $a1, 0 #base
	addi $t4, $t2, -1 #poower - 1
	
	
	while:
	bgt $t0, $t4, end #(counter < power)
	mul $t1, $t1, $t3  #result = result * base
	
	add $t0, $t0, 1 #counter ++
	j while #}
	
	end:
	li $v0, 1
	move $a0, $t1
	syscall 
	
	li $v0, 10
	syscall
	
	
	
