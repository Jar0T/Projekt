;--------------------------------------------------------------------------------------------------------------;
;rcx - wska�nik na tablic� z pikselami bitmapy
;rdx - wska�nik na tablic� zawieraj�c� kopi� pikseli bitmapy
;r8 - przesuni�cie adresu od kt�rego ma by� widziana bitmapa
;r9 - wielko�� bitmapy widziana w funkcji
;stos - szeroko�� wiersza bitmapy z wyr�wnaniem
;--------------------------------------------------------------------------------------------------------------;

.code
MyProc proc
	mov rbx, 3						;przemieszczanie si� po tablicy
	mov r12, -1						;warto�� z maski
	mov r13, 0008000800080008h		;warto�� z maski
	mov r15, rsp					;zapisanie wska�nika stosu
	;mov rsp, rbp					;ustawienie w�a�ciwego wska�nika stosu do pobrania pi�tego parametru funkcji
	add rsp, 28h
	pop r14							;pobranie szeroko�ci wiersza bitmapy
	mov rsp, r15					;przywrucenie wska�nika stosu
	add rcx, r8						;dodanie przesuni�cia do adresu oryginalnej tablicy zawarto�ci bitmapy
	add rdx, r8						;dodanie przesuni�cia do adresu kopii tablicy zawarto�ci bitmapy
	mov r15, 00000000ffffffffh
	and r14, r15					;wy�uskanie szeroko�ci wiersza bitmapy
	sub r9, 3

	;zapis warto�ci maski do rejestr�w xmm10 i xmm11
	movq xmm10, r12
	movlhps xmm10, xmm10

	movq xmm11, r13
	movlhps xmm11, xmm11
mainLoop:
	;reset rejestr�w xmm
	xorps xmm0, xmm0
	xorps xmm1, xmm1
	xorps xmm2, xmm2
	xorps xmm3, xmm3
	xorps xmm4, xmm4
	xorps xmm5, xmm5
	xorps xmm6, xmm6
	xorps xmm7, xmm7
	xorps xmm8, xmm8
	xorps xmm9, xmm9
	
	;odczyt danych w kom�rkach parzystych 0-14 na pozycji X
	;XOO
	;OOO
	;OOO
	mov r15, rdx
	add r15, rbx
	sub r15, r14
	sub r15, 3

	pinsrb xmm0, byte ptr [r15], 0
	pinsrb xmm0, byte ptr [r15 + 2], 2
	pinsrb xmm0, byte ptr [r15 + 4], 4
	pinsrb xmm0, byte ptr [r15 + 6], 6
	pinsrb xmm0, byte ptr [r15 + 8], 8
	pinsrb xmm0, byte ptr [r15 + 10], 10
	pinsrb xmm0, byte ptr [r15 + 12], 12
	pinsrb xmm0, byte ptr [r15 + 14], 14

	;odczyt danych w kom�rkach parzystych 0-14 na pozycji X
	;OXO
	;OOO
	;OOO
	add r15, 3

	pinsrb xmm1, byte ptr [r15], 0
	pinsrb xmm1, byte ptr [r15 + 2], 2
	pinsrb xmm1, byte ptr [r15 + 4], 4
	pinsrb xmm1, byte ptr [r15 + 6], 6
	pinsrb xmm1, byte ptr [r15 + 8], 8
	pinsrb xmm1, byte ptr [r15 + 10], 10
	pinsrb xmm1, byte ptr [r15 + 12], 12
	pinsrb xmm1, byte ptr [r15 + 14], 14

	;odczyt danych w kom�rkach parzystych 0-14 na pozycji X
	;OOX
	;OOO
	;OOO
	add r15, 3

	pinsrb xmm2, byte ptr [r15], 0
	pinsrb xmm2, byte ptr [r15 + 2], 2
	pinsrb xmm2, byte ptr [r15 + 4], 4
	pinsrb xmm2, byte ptr [r15 + 6], 6
	pinsrb xmm2, byte ptr [r15 + 8], 8
	pinsrb xmm2, byte ptr [r15 + 10], 10
	pinsrb xmm2, byte ptr [r15 + 12], 12
	pinsrb xmm2, byte ptr [r15 + 14], 14

	;odczyt danych w kom�rkach parzystych 0-14 na pozycji X
	;OOO
	;XOO
	;OOO
	sub r15, 6
	add r15, r14

	pinsrb xmm3, byte ptr [r15], 0
	pinsrb xmm3, byte ptr [r15 + 2], 2
	pinsrb xmm3, byte ptr [r15 + 4], 4
	pinsrb xmm3, byte ptr [r15 + 6], 6
	pinsrb xmm3, byte ptr [r15 + 8], 8
	pinsrb xmm3, byte ptr [r15 + 10], 10
	pinsrb xmm3, byte ptr [r15 + 12], 12
	pinsrb xmm3, byte ptr [r15 + 14], 14

	;odczyt danych w kom�rkach parzystych 0-14 na pozycji X
	;OOO
	;OXO
	;OOO
	add r15, 3

	pinsrb xmm4, byte ptr [r15], 0
	pinsrb xmm4, byte ptr [r15 + 2], 2
	pinsrb xmm4, byte ptr [r15 + 4], 4
	pinsrb xmm4, byte ptr [r15 + 6], 6
	pinsrb xmm4, byte ptr [r15 + 8], 8
	pinsrb xmm4, byte ptr [r15 + 10], 10
	pinsrb xmm4, byte ptr [r15 + 12], 12
	pinsrb xmm4, byte ptr [r15 + 14], 14

	;odczyt danych w kom�rkach parzystych 0-14 na pozycji X
	;OOO
	;OOX
	;OOO
	add r15, 3

	pinsrb xmm5, byte ptr [r15], 0
	pinsrb xmm5, byte ptr [r15 + 2], 2
	pinsrb xmm5, byte ptr [r15 + 4], 4
	pinsrb xmm5, byte ptr [r15 + 6], 6
	pinsrb xmm5, byte ptr [r15 + 8], 8
	pinsrb xmm5, byte ptr [r15 + 10], 10
	pinsrb xmm5, byte ptr [r15 + 12], 12
	pinsrb xmm5, byte ptr [r15 + 14], 14

	;odczyt danych w kom�rkach parzystych 0-14 na pozycji X
	;OOO
	;OOO
	;XOO
	sub r15, 6
	add r15, r14

	pinsrb xmm6, byte ptr [r15], 0
	pinsrb xmm6, byte ptr [r15 + 2], 2
	pinsrb xmm6, byte ptr [r15 + 4], 4
	pinsrb xmm6, byte ptr [r15 + 6], 6
	pinsrb xmm6, byte ptr [r15 + 8], 8
	pinsrb xmm6, byte ptr [r15 + 10], 10
	pinsrb xmm6, byte ptr [r15 + 12], 12
	pinsrb xmm6, byte ptr [r15 + 14], 14

	;odczyt danych w kom�rkach parzystych 0-14 na pozycji X
	;OOO
	;OOO
	;OXO
	add r15, 3

	pinsrb xmm7, byte ptr [r15], 0
	pinsrb xmm7, byte ptr [r15 + 2], 2
	pinsrb xmm7, byte ptr [r15 + 4], 4
	pinsrb xmm7, byte ptr [r15 + 6], 6
	pinsrb xmm7, byte ptr [r15 + 8], 8
	pinsrb xmm7, byte ptr [r15 + 10], 10
	pinsrb xmm7, byte ptr [r15 + 12], 12
	pinsrb xmm7, byte ptr [r15 + 14], 14

	;odczyt danych w kom�rkach parzystych 0-14 na pozycji X
	;OOO
	;OOO
	;OOX
	add r15, 3

	pinsrb xmm8, byte ptr [r15], 0
	pinsrb xmm8, byte ptr [r15 + 2], 2
	pinsrb xmm8, byte ptr [r15 + 4], 4
	pinsrb xmm8, byte ptr [r15 + 6], 6
	pinsrb xmm8, byte ptr [r15 + 8], 8
	pinsrb xmm8, byte ptr [r15 + 10], 10
	pinsrb xmm8, byte ptr [r15 + 12], 12
	pinsrb xmm8, byte ptr [r15 + 14], 14

	;mno�enie przez mask�
	vpmullw xmm0, xmm0, xmm10
	vpmullw xmm1, xmm1, xmm10
	vpmullw xmm2, xmm2, xmm10
	vpmullw xmm3, xmm3, xmm10
	vpmullw xmm4, xmm4, xmm11
	vpmullw xmm5, xmm5, xmm10
	vpmullw xmm6, xmm6, xmm10
	vpmullw xmm7, xmm7, xmm10
	vpmullw xmm8, xmm8, xmm10

	;sumowanie warto�ci
	vpaddsw xmm0, xmm0, xmm1
	vpaddsw xmm0, xmm0, xmm2
	vpaddsw xmm0, xmm0, xmm3
	vpaddsw xmm0, xmm0, xmm4
	vpaddsw xmm0, xmm0, xmm5
	vpaddsw xmm0, xmm0, xmm6
	vpaddsw xmm0, xmm0, xmm7
	vpaddsw xmm0, xmm0, xmm8

	;zamiana warto�ci <0 na 0
	mov r10, 00ff00ff00ff00ffh
	movq xmm1, r10
	movlhps xmm1, xmm1

	vpmaxuw xmm1, xmm1, xmm0
	vpcmpeqw xmm1, xmm1, xmm0

	pxor xmm2, xmm2
	vpcmpeqq xmm2, xmm2, xmm2
	pxor xmm1, xmm2
	vpand xmm0, xmm0, xmm1

	;odczyt danych w kom�rkach nieparzystych 1-15 na pozycji X
	;XOO
	;OOO
	;OOO
	mov r15, rdx
	add r15, rbx
	sub r15, r14
	sub r15, 3

	pinsrb xmm1, byte ptr [r15 + 1], 0
	pinsrb xmm1, byte ptr [r15 + 3], 2
	pinsrb xmm1, byte ptr [r15 + 5], 4
	pinsrb xmm1, byte ptr [r15 + 7], 6
	pinsrb xmm1, byte ptr [r15 + 9], 8
	pinsrb xmm1, byte ptr [r15 + 11], 10
	pinsrb xmm1, byte ptr [r15 + 13], 12
	pinsrb xmm1, byte ptr [r15 + 15], 14

	;odczyt danych w kom�rkach nieparzystych 1-15 na pozycji X
	;OXO
	;OOO
	;OOO
	add r15, 3

	pinsrb xmm2, byte ptr [r15 + 1], 0
	pinsrb xmm2, byte ptr [r15 + 3], 2
	pinsrb xmm2, byte ptr [r15 + 5], 4
	pinsrb xmm2, byte ptr [r15 + 7], 6
	pinsrb xmm2, byte ptr [r15 + 9], 8
	pinsrb xmm2, byte ptr [r15 + 11], 10
	pinsrb xmm2, byte ptr [r15 + 13], 12
	pinsrb xmm2, byte ptr [r15 + 15], 14

	;odczyt danych w kom�rkach nieparzystych 1-15 na pozycji X
	;OOX
	;OOO
	;OOO
	add r15, 3

	pinsrb xmm3, byte ptr [r15 + 1], 0
	pinsrb xmm3, byte ptr [r15 + 3], 2
	pinsrb xmm3, byte ptr [r15 + 5], 4
	pinsrb xmm3, byte ptr [r15 + 7], 6
	pinsrb xmm3, byte ptr [r15 + 9], 8
	pinsrb xmm3, byte ptr [r15 + 11], 10
	pinsrb xmm3, byte ptr [r15 + 13], 12
	pinsrb xmm3, byte ptr [r15 + 15], 14

	;odczyt danych w kom�rkach nieparzystych 1-15 na pozycji X
	;OOO
	;XOO
	;OOO
	sub r15, 6
	add r15, r14

	pinsrb xmm4, byte ptr [r15 + 1], 0
	pinsrb xmm4, byte ptr [r15 + 3], 2
	pinsrb xmm4, byte ptr [r15 + 5], 4
	pinsrb xmm4, byte ptr [r15 + 7], 6
	pinsrb xmm4, byte ptr [r15 + 9], 8
	pinsrb xmm4, byte ptr [r15 + 11], 10
	pinsrb xmm4, byte ptr [r15 + 13], 12
	pinsrb xmm4, byte ptr [r15 + 15], 14

	;odczyt danych w kom�rkach nieparzystych 1-15 na pozycji X
	;OOO
	;OXO
	;OOO
	add r15, 3

	pinsrb xmm5, byte ptr [r15 + 1], 0
	pinsrb xmm5, byte ptr [r15 + 3], 2
	pinsrb xmm5, byte ptr [r15 + 5], 4
	pinsrb xmm5, byte ptr [r15 + 7], 6
	pinsrb xmm5, byte ptr [r15 + 9], 8
	pinsrb xmm5, byte ptr [r15 + 11], 10
	pinsrb xmm5, byte ptr [r15 + 13], 12
	pinsrb xmm5, byte ptr [r15 + 15], 14

	;odczyt danych w kom�rkach nieparzystych 1-15 na pozycji X
	;OOO
	;OOX
	;OOO
	add r15, 3

	pinsrb xmm6, byte ptr [r15 + 1], 0
	pinsrb xmm6, byte ptr [r15 + 3], 2
	pinsrb xmm6, byte ptr [r15 + 5], 4
	pinsrb xmm6, byte ptr [r15 + 7], 6
	pinsrb xmm6, byte ptr [r15 + 9], 8
	pinsrb xmm6, byte ptr [r15 + 11], 10
	pinsrb xmm6, byte ptr [r15 + 13], 12
	pinsrb xmm6, byte ptr [r15 + 15], 14

	;odczyt danych w kom�rkach nieparzystych 1-15 na pozycji X
	;OOO
	;OOO
	;XOO
	sub r15, 6
	add r15, r14

	pinsrb xmm7, byte ptr [r15 + 1], 0
	pinsrb xmm7, byte ptr [r15 + 3], 2
	pinsrb xmm7, byte ptr [r15 + 5], 4
	pinsrb xmm7, byte ptr [r15 + 7], 6
	pinsrb xmm7, byte ptr [r15 + 9], 8
	pinsrb xmm7, byte ptr [r15 + 11], 10
	pinsrb xmm7, byte ptr [r15 + 13], 12
	pinsrb xmm7, byte ptr [r15 + 15], 14

	;odczyt danych w kom�rkach nieparzystych 1-15 na pozycji X
	;OOO
	;OOO
	;OXO
	add r15, 3

	pinsrb xmm8, byte ptr [r15 + 1], 0
	pinsrb xmm8, byte ptr [r15 + 3], 2
	pinsrb xmm8, byte ptr [r15 + 5], 4
	pinsrb xmm8, byte ptr [r15 + 7], 6
	pinsrb xmm8, byte ptr [r15 + 9], 8
	pinsrb xmm8, byte ptr [r15 + 11], 10
	pinsrb xmm8, byte ptr [r15 + 13], 12
	pinsrb xmm8, byte ptr [r15 + 15], 14

	;odczyt danych w kom�rkach nieparzystych 1-15 na pozycji X
	;OOO
	;OOO
	;OOX
	add r15, 3

	pinsrb xmm9, byte ptr [r15 + 1], 0
	pinsrb xmm9, byte ptr [r15 + 3], 2
	pinsrb xmm9, byte ptr [r15 + 5], 4
	pinsrb xmm9, byte ptr [r15 + 7], 6
	pinsrb xmm9, byte ptr [r15 + 9], 8
	pinsrb xmm9, byte ptr [r15 + 11], 10
	pinsrb xmm9, byte ptr [r15 + 13], 12
	pinsrb xmm9, byte ptr [r15 + 15], 14

	;mno�enie przez mask�
	vpmullw xmm1, xmm1, xmm10
	vpmullw xmm2, xmm2, xmm10
	vpmullw xmm3, xmm3, xmm10
	vpmullw xmm4, xmm4, xmm10
	vpmullw xmm5, xmm5, xmm11
	vpmullw xmm6, xmm6, xmm10
	vpmullw xmm7, xmm7, xmm10
	vpmullw xmm8, xmm8, xmm10
	vpmullw xmm9, xmm9, xmm10

	;sumowanie warto�ci
	vpaddsw xmm1, xmm1, xmm2
	vpaddsw xmm1, xmm1, xmm3
	vpaddsw xmm1, xmm1, xmm4
	vpaddsw xmm1, xmm1, xmm5
	vpaddsw xmm1, xmm1, xmm6
	vpaddsw xmm1, xmm1, xmm7
	vpaddsw xmm1, xmm1, xmm8
	vpaddsw xmm1, xmm1, xmm9

	;zamiana warto�ci <0 na 0
	movq xmm2, r10
	movlhps xmm2, xmm2

	vpmaxuw xmm2, xmm2, xmm1
	vpcmpeqw xmm2, xmm2, xmm1

	pxor xmm3, xmm3
	vpcmpeqq xmm3, xmm3, xmm3
	pxor xmm2, xmm3
	vpand xmm1, xmm1, xmm2

	;��czenie danych o adresach parzystych i nieparzystych
	psllw xmm1, 8

	por xmm0, xmm1

	;ustalenie adresu pod kt�rym maj� by� zapisane dane
	mov r15, rcx
	add r15, rbx

	;zapisanie danych w pami�ci
	movups [r15], xmm0
	
	;sprawdzenie, czy to ju� koniec p�tli i ewentualny skok
	add rbx, 16
	cmp r9, rbx
	jge mainLoop
	ret
MyProc endp
end