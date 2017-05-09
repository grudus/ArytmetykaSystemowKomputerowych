.data
	dajLiczbe: .asciiz "Podaj liczbe: "
	dodatnia: .asciiz "Liczba jest dodatnia"
	ujemna: .asciiz "Liczba jest ujemna"
	zero: .asciiz "Liczba jest rowna zero"
	powtarzasz: .asciiz "\nPowtarzasz? (tak - 1, nie - 0): "
	sumaDodatnich: .asciiz "Suma dodatnich to: "
	iloczynUjemnych: .asciiz "\nIloczyn ujemnych to: "
	powtorzCalosc: .asciiz "\n\nCzy powtorzyc calosc? (tak - 1, nie - 0): "
	
.text
	main:
		li $t1, 0 #suma dodatnich
		li $t2, 1 #iloczyn ujemnych
		
	wyswietlIWczytaj:
		#Wyswietl wiadomosc o podaniu liczby
		li $v0, 4
		la $a0, dajLiczbe
		syscall
		
		#Wczytaj odpowiedz uzytkownika do t0
		li $v0, 5
		syscall
		move $t0, $v0
	
		
		bltz $t0, jestUjemna #Jesli t0 jest <less than zero> skocz do 'jestUjemna' 
		bgtz $t0, jestDodatnia #Jezeli t0 jest <greater than zero> skocz do 'jestDodatnia'
		j jestZero #Jezeli zadne z powyzszych skocz do 'jestZero'
		
	jestDodatnia:
		#Wyswietl wiadomosc
		li $v0, 4
		la $a0, dodatnia
		syscall
		
		#Dodaj do sumy liczb dodatnich
		add $t1, $t1, $t0 # t1 = t1 + t0 --> suma += input
		j poOdpowiedzi #skocz do 'poOdpowiedzi'
	
	jestUjemna:
		#Wyswietl wiadomosc
		li $v0, 4
		la $a0, ujemna
		syscall
		
		#Domnoz do iloczynu liczb ujemnych 
		mul $t2, $t2, $t0 #t2 = t2 * t0  --> iloczyn *= input
		j poOdpowiedzi #skocz do 'poOdpowiedzi'
		
	jestZero:
		#Wyswietl wiadomosc
		li $v0, 4
		la $a0, zero
		syscall	
		j poOdpowiedzi #skocz do 'poOdpowiedzi'
		
	poOdpowiedzi:
		#Zapytaj uzytkownika czy powtarza podanie liczby
		li $v0, 4
		la $a0, powtarzasz 
		syscall
		
		#Wczytaj jego odpowiedz - 1 to potwierdzenie, 0 - zanegowanie
		li $v0, 5 
		syscall
		
		#Jezeli <not equal zero> skocz do 'wyswietlWczytaj', w przeciwnym wypadku zejdz normalnie nizej
		bnez $v0, wyswietlIWczytaj  
		
	podliczanie:
		#Wyswietl komunikat o sumie liczb dodatnich
		li $v0, 4
		la $a0, sumaDodatnich
		syscall
		
		#Wyswietl wlasciwa sume
		li $v0, 1
		move $a0, $t1
		syscall
		
		#Wyswietl komunikat o iloczynie liczb ujemnych
		li $v0, 4
		la $a0, iloczynUjemnych
		syscall
		
		#Wyswietl wlasciwy iloczyn
		li $v0, 1
		move $a0, $t2
		syscall
		
		#Zapytaj uzytkownika czy powtorzyc calosc
		li $v0, 4
		la $a0, powtorzCalosc
		syscall
		
		#Wczytaj odpowiedz - 1 to potwierdzenie, 0 - negacja
		li $v0, 5
		syscall
		
		#Jezeli odpowiedz <not equal zero> skocz do 'main' (poczatek programu). W przeciwnym wypadku zejdz normalnie na dol
		bnez $v0, main  
		
		
		#Koniec dzialania programu
		li $v0, 10
		syscall
		
	
	