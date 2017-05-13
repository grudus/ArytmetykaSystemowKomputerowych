# Dany jest uklad wspolrzednych. Tworzymy okrag z srodkiem w punkcie (0,0)
# 1) Zapytaj uzytkownika o promien okregu
# 2) Zapytaj uzytkownika o wspolrzedne nowego punktu (+ numeracja danego punktu)
# 3) Wyswietl komunikat o tym, czy punkt jest wewnatrz, na czy poza okregiem
# 4) Powtorz dopoki uzytkownik tego chce
# 5) Jesli nie chce, wyswietl informacje o liczbie podanych punkow + liczbie punktow NA okregu
# 6) Powtorzr calosc jesli uzytkownik chce
# Wzor na okrag to w tym przypadku x^2 + y^2 = r^2 -> Je¿eli L < P to punkt wewnatrz, jezeli L = P to na, inaczej na zewnatrz kola

.data
	podajPromien: .asciiz "Podaj promien okregu: "
	numeracja: .asciiz "Utworz punkt nr "
	podajX: .asciiz "\nPodaj wspolrzedna X: "
	podajY: .asciiz "Podaj wspolrzedna Y: "
	czyNowyPunkt: .asciiz "\n\nCzy chcesz podac nowy punkt (0 - nie)? "
	iloscWszystkich: .asciiz "Ilosc wszystkich punktow: "
	iloscNaOkregu: .asciiz "\nIlosc punktow na okregu: "
	czyOdNowa: .asciiz "\n\nCzy chcesz zaczac od nowa (0 - nie)? "
	
	wOkregu: .asciiz "Punkt lezy wewnatrz okregu"
	naOkregu: .asciiz "Punkt lezy na okregu"
	pozaOkregiem: .asciiz "Punkt lezy poza okregiem"
	
.text

main:
	li $v0, 4
	la $a0, podajPromien
	syscall
	
	li $v0, 5
	syscall
	mul $t0, $v0, $v0 # t0 = r*r (tak naprawde nie potrzebujemy promienia, tylko jego kwadrat)

	li $t6, 0 #licznik punktow
	li $t7, 0 #licznik punktow na okregu
	
wczytajPunkt:
	add $t6, $t6, 1 # licznik punktow += 1
	
	li $v0, 4
	la $a0, numeracja
	syscall
	li $v0, 1
	move $a0, $t6
	syscall
	
	li $v0, 4
	la $a0, podajX
	syscall
	
	li $v0, 5
	syscall
	mul $t1, $v0, $v0 # t1 = X*X (podobnie jak w promienu - interesuje nas tylko kwadrat wspolrzednej)
	
	li $v0, 4
	la $a0, podajY
	syscall
	
	li $v0, 5
	syscall
	mul $t2, $v0, $v0 # t2 = Y*Y (jak wyzej)
	
	add $t3, $t1, $t2 #t3 = x^2 + y^2 (lewa strona rownania)
	
	blt $t3, $t0, mniejsze  #Jezeli x^2 + y^2 < r^2 skocz do 'mniejsze'
	bgt $t3, $t0, wieksze   #Jezeli x^2 + y^2 > r^2 skocz do 'wieksze'
	
rowne:
	li $v0, 4
	la $a0, naOkregu
	syscall
	add $t7, $t7, 1 #licznik na okregu += 1
	j poKomunikacie

mniejsze: 
	li $v0, 4
	la $a0, wOkregu
	syscall
	j poKomunikacie
	
wieksze:
	li $v0, 4
	la $a0, pozaOkregiem
	syscall
	# nie trzeba skakac, bo jest bezposrednio pod

poKomunikacie:
	li $v0, 4
	la $a0, czyNowyPunkt
	syscall
	
	li $v0, 5
	syscall
	bnez $v0, wczytajPunkt #Jezeli uzytkownik NIE odpowiedzial 0 - skocz do 'wczytajPunkt'

#Wyswietl statystyki
	li $v0, 4
	la $a0, iloscWszystkich
	syscall
	li $v0, 1
	move $a0, $t6
	syscall
	
	li $v0, 4
	la $a0, iloscNaOkregu
	syscall
	li $v0, 1
	move $a0, $t7
	syscall
	
#Zapytaj o powtorzenie czwiczenia
	li $v0, 4
	la $a0, czyOdNowa
	syscall
	
	li $v0, 5
	syscall
	bnez $v0, main #Jezeli uzytkownik NIE odpowiedzial 0 - skocz do 'main'
	
#Koniec programu
	li $v0, 10
	syscall