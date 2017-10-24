.data
	msgInsertNumber:.asciiz"\nDigite um No."
	msgPalindromo:.asciiz" eh Palindromo"
.text
	main:
						# $t0 = n
						# $t1 = aux 
						# $t2 = reverse
						# $t3 recebe o resto divisão de aux % 10
						# $t4 = recebe valor 0 ou 1, para teste lógico  

		while1: 			# while1 se n <= 0 e se n > 10000
		
		li $v0, 4
		la $a0, msgInsertNumber
		syscall
	
		li $v0, 5
		syscall
		add $t0, $v0, $zero

		ble $t0, $zero, while1		# verifica se n <= 0
		bgt $t0, 10000, while1		# verifica se n > 10000

		add $t1, $t0, $zero 		# aux = n
		add $t2, $zero, $zero		# reverse = 0

		jal palindromo			# chamada de subrotina palindromo()
		
		beq $t4, 1, if2			# se igual a 1 "if2", senão "else2"
		j else2

		if2:
		
		li $v0, 1
		la $a0, ($t0)
		syscall
		
		li $v0, 4
		la $a0, msgPalindromo
		syscall
		
		j endif2

		else2:
		
		add $t0, $t0, 1			# n += 1
		add $t1, $t0, $zero		# aux = n
		add $t2, $zero, $zero		# reverse = 0
		
		jal palindromo			# chamada de subrotina palindromo() 
		
		beq $t4, 1, if2			# se $t4 igual a 1 "if2", senão "else2"
		j else2						
		
		palindromo:			# subrotina palindromo() 

		while2:				# while2 enquanto aux != 0

		mul $t2, $t2, 10		# $t2 recebe reverse / 10
		rem $t3, $t1, 10 		# $t3 recebe o resto divisão de aux % 10
		add $t2, $t2, $t3		# $t2 recebe reverse + o resto divisão de aux % 10

		div $t1, $t1, 10		# $t1 recebe aux / 10

		bne $t1, $zero, while2		# while2 enquanto aux != 0

		beq $t0, $t2, if1		# se n $t0 == reverse $t2
		j else1

		if1:				# se n $t0 == reverse $t2
		
		add $t4, $t4, 1			# $t4 = 1
		j endif1

		else1:				# se n $t0 != reverse $t2

		add $t4, $t4, $zero		# $t4 = 0
		
		endif1:
		
		jr $ra				# retorno subrotina palindromo()

		endif2:
