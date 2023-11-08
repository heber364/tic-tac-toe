; Exercício de Programação 1 - 2023-2 - ELE8575 - Jogo da Velha
; Enzo Giacomin Santos - Turma 6.1 - PPC 2009
; funções para o plot das retas, círculo, posicionar o cursor e plot do carctere importadas do arquivo linec disponibilizado pelo professor no AVA

segment code
..start:
    mov 	ax, data
    mov 	ds, ax
    mov 	ax, stack
    mov 	ss, ax
    mov 	sp, stacktop
	; salvar modo corrente de video(vendo como est� o modo de video da maquina)
    mov  		ah, 0Fh
    int  		10h
    mov  		[modo_anterior], al   
	; alterar modo de video para gr�fico 640x480 16 cores
    mov     	al, 12h
   	mov     	ah, 0
    int     	10h

		
tabuleiro:
	; traçando as linhas verticais
	; linha 1
	;x1
	mov 	ax, 261 	; salva em ax a coordenada x de incio do tabuleiro + a dimensao de uma casa
	push 	ax
	;y1
	mov 	ax, 460 	; salva em ax a coordenada y de incio do tabuleiro
	push  	ax
	;x2
	mov 	ax, 261 	; salva em ax a coordenada x de incio do tabuleiro + a dimensao de uma casa
	push 	ax
	;y2
	mov 	ax, 157 	; salva em ax a coordenada y de incio do tabuleiro - a dimensão total de tabuleiro 
	push 	ax

	call 	line

	; linha 2	
	;x1
	mov 	ax, 362 	; salva em ax a dimensão de uma casa do tabuleiro * 2 + a coordenada x de incio do tabuleiro
	push 	ax
	;y1
	mov 	ax, 460 	; salva em ax a coordenada y de incio do tabuleiro
	push  	ax
	;x2
	mov 	ax, 362 	; salva em ax a dimensão de uma casa do tabuleiro *2 + a coordenada x de incio do tabuleiro
	push 	ax
	;y2
	mov 	ax, 157 	; salva em ax a coordenada y de incio do tabuleiro - a dimensão total de tabuleiro
	push 	ax

	call 	line

	; traçando as linhas horizontais
	; linha 1
	;x1
	mov 	ax, 160 	; salva em ax a coordenada x de incio do tabuleiro
	push 	ax
	;y1
	mov 	ax, 359 	; salva em ax a coordenada y de incio do tabuleiro - a dimensão de uma casa
	push  	ax
	;x2
	mov 	ax,	463 	; salva em ax a coordenada x de incio do tabuleiro + a dimensão do tabuleiro
	push 	ax
	;y2
	mov 	ax, 359 	; salva em ax a coordenada y de incio do tabuleiro - a dimensão de uma casa
	push  	ax

	call 	line

	; linha 2
	;x1
	mov 	ax, 160 	; salva em ax a coordenada x de incio do tabuleiro
	push 	ax
	;y1
	mov 	ax, 258 	; salva em ax a coordenada y de inciio do tabuleiro - a dimensão de uma casa *2
	push  	ax
	;x2
	mov 	ax,	463 	; salva em ax a coordenada x de incio do tabuleiro + a dimensão do tabuleiro
	push 	ax
	;y2
	mov 	ax, 258 	; salva em ax a coordenada y de inciio do tabuleiro - a dimensão de uma casa *2 		
	push  	ax

	call 	line

	;imprime numero da casa 1
	mov     cx, 2			;n�mero de caracteres
	mov     bx, 0
	mov     dh, 1			;linha 0-29
	mov     dl, 20			;coluna 0-79
	lc1:
	call	cursor
	mov     al,[bx+casa1]
	call	caracter
	inc     bx			;proximo caracter
	inc		dl			;avanca a coluna
	loop    lc1

	;imprime numero da casa 2
	mov     cx, 2			;n�mero de caracteres
	mov     bx, 0
	mov     dh, 1			;linha 0-29
	mov     dl, 33			;coluna 0-79
	lc2:
	call	cursor
	mov     al,[bx+casa2]
	call	caracter
	inc     bx			;proximo caracter
	inc		dl			;avanca a coluna
	loop    lc2

	;imprime numero da casa 3
	mov     cx, 2			;n�mero de caracteres
	mov     bx, 0
	mov     dh, 1			;linha 0-29
	mov     dl, 46			;coluna 0-79
	lc3:
	call	cursor
	mov     al,[bx+casa3]
	call	caracter
	inc     bx			;proximo caracter
	inc		dl			;avanca a coluna
	loop    lc3

	;imprime numero da casa 4
	mov     cx, 2			;n�mero de caracteres
	mov     bx, 0
	mov     dh, 8			;linha 0-29
	mov     dl, 20			;coluna 0-79
	lc4:
	call	cursor
	mov     al,[bx+casa4]
	call	caracter
	inc     bx			;proximo caracter
	inc		dl			;avanca a coluna
	loop    lc4

	;imprime numero da casa 5
	mov     cx, 2			;n�mero de caracteres
	mov     bx, 0
	mov     dh, 8			;linha 0-29
	mov     dl, 33			;coluna 0-79
	lc5:
	call	cursor
	mov     al,[bx+casa5]
	call	caracter
	inc     bx			;proximo caracter
	inc		dl			;avanca a coluna
	loop    lc5

	;imprime numero da casa 6
	mov     cx, 2			;n�mero de caracteres
	mov     bx, 0
	mov     dh, 8			;linha 0-29
	mov     dl, 46			;coluna 0-79
	lc6:
	call	cursor
	mov     al,[bx+casa6]
	call	caracter
	inc     bx			;proximo caracter
	inc		dl			;avanca a coluna
	loop    lc6

	;imprime numero da casa 7
	mov     cx, 2			;n�mero de caracteres
	mov     bx, 0
	mov     dh, 14			;linha 0-29
	mov     dl, 20			;coluna 0-79
	lc7:
	call	cursor
	mov     al,[bx+casa7]
	call	caracter
	inc     bx			;proximo caracter
	inc		dl			;avanca a coluna
	loop    lc7

	;imprime numero da casa 8
	mov     cx, 2			;n�mero de caracteres
	mov     bx, 0
	mov     dh, 14			;linha 0-29
	mov     dl, 33			;coluna 0-79
	lc8:
	call	cursor
	mov     al,[bx+casa8]
	call	caracter
	inc     bx			;proximo caracter
	inc		dl			;avanca a coluna
	loop    lc8

	;imprime numero da casa 9
	mov     cx, 2			;n�mero de caracteres
	mov     bx, 0
	mov     dh, 14			;linha 0-29
	mov     dl, 46			;coluna 0-79
	lc9:
	call	cursor
	mov     al,[bx+casa9]
	call	caracter
	inc     bx			;proximo caracter
	inc		dl			;avanca a coluna
	loop    lc9

menu:
	; traça uma linha que divide o tabuleiro do menu
		mov 	ax, 20
		push 	ax
		mov 	ax, 105
		push 	ax

		mov 	ax, 620
		push	ax
		mov 	ax, 105
		push 	ax
		
		call 	line	

continua:
	; imprime a jogada anterior
		;imprime a mensagem de jogada anterior
		mov     cx, 16			;n�mero de caracteres
    	mov     bx, 0
    	mov     dh, 24			;linha 0-29
    	mov     dl, 18			;coluna 0-79
		l1:
		call	cursor
    	mov     al,[bx+msg1]
		call	caracter
    	inc     bx			;proximo caracter
		inc		dl			;avanca a coluna
    	loop    l1

		; imprime a jogada anterior
		mov     cx, 3			;n�mero de caracteres
    	mov     bx, 2
    	mov     dh, 24			;linha 0-29
    	mov     dl, 35			;coluna 0-79
		l6:
		call	cursor
    	mov     al,[bx+entrada]
		call	caracter
    	inc     bx			;proximo caracter
		inc		dl			;avanca a coluna
    	loop    l6

	; imprime a solicitação da próxima ação
		mov     cx, 18			;n�mero de caracteres
    	mov     bx, 0
    	mov     dh, 26			;linha 0-29
    	mov     dl, 18			;coluna 0-79
		l2:
		call	cursor
    	mov     al,[bx+msg2]
		call	caracter
    	inc     bx			;proximo caracter
		inc		dl			;avanca a coluna
    	loop    l2
	

	; entrada do usuario
		; posiciona o cursor
		mov     dh, 26			; linha 0-29
    	mov     dl, 37			; coluna 0-79
		call 	cursor

		; leitura do usuario com 21h
		mov 	ah, 0Ah  ; entrada do usuario com eco
        mov 	dx, entrada   ; salva em entrada
        int 	21h

	; limpa o eco da entrada do usuario
		mov     cx, 18			;n�mero de caracteres
    	mov     bx, 0
    	mov     dh, 26			;linha 0-29
    	mov     dl, 37			;coluna 0-79
		l7:
		call	cursor
    	mov     al,[bx+limpa]
		call	caracter
    	inc     bx			;proximo caracter
		inc		dl			;avanca a coluna
    	loop    l7
	; limpa a mensagem de erro
		mov     cx, 18			;n�mero de caracteres
    	mov     bx, 0
    	mov     dh, 28			;linha 0-29
    	mov     dl, 18			;coluna 0-79
		l5:
		call	cursor
    	mov     al,[bx+limpa]
		call	caracter
    	inc     bx			;proximo caracter
		inc		dl			;avanca a coluna
    	loop    l5

	; interpretação da entrada
		cmp 	byte[entrada+2], 's'
		je 		atalho1

		cmp byte[entrada+2], 'c'
		je 		atalho2	
		
		; valida se a posição ja esta ocupada
			xor 	ax, ax
			mov 	al, byte[entrada+3]
			mov 	bx, ax
			sub 	bx,'0'		
			mov 	al, byte[entrada+4]
			sub		ax,'0'
			mov 	cx, 3
			mul 	cx
			add 	bx, ax
			cmp 	byte[posicao_ocupada+bx], ' '
			jne		atalho3
		
		; valida se a casa existe
			x_existente:
			cmp		byte[entrada+3], '1'
			je		y_existente
			cmp		byte[entrada+3], '2'
			je		y_existente
			cmp		byte[entrada+3], '3'
			je 		y_existente
			jmp 	atalho3

			y_existente:
			cmp		byte[entrada+4], '1'
			je		casa_existente
			cmp		byte[entrada+4], '2'
			je		casa_existente
			cmp		byte[entrada+4], '3'
			je 		casa_existente
			jmp 	atalho3

			casa_existente:
		; valida se a entrada foi um circulo
			cmp 	byte[entrada+2], 'C'
			je 		atalho4

		; valida se a entrada foi um X
			cmp byte[entrada+2], 'X'
			je 		atalho5
			
		jmp 	entrada_errada
; atalhos para os saltos condicionais
	atalho1:
	jmp 	END

	atalho2:
	jmp 	reinicia

	atalho3:
	jmp 	jogada_errada

	atalho4:
	jmp		entraC

	atalho5:
	jmp		entraX

;;; validar vitoria ou velha 
vitoriaC:
	comparaCLHS:								; compara se C venceu na linha horizontal superior
		cmp 	byte[posicao_ocupada+4], 'C'
		jne		comparaCLHM
		cmp 	byte[posicao_ocupada+7], 'C'
		jne		comparaCLHM
		cmp 	byte[posicao_ocupada+10], 'C'
		jne 	comparaCLHM
		jmp		linhaHS
	
	comparaCLHM:								; compara se C venceu na linha horizontal do meio
		cmp 	byte[posicao_ocupada+5], 'C'
		jne		comparaCLHI
		cmp 	byte[posicao_ocupada+8], 'C'
		jne		comparaCLHI
		cmp 	byte[posicao_ocupada+11], 'C'
		jne 	comparaCLHI
		jmp		linhaHM

	comparaCLHI:								; compara se C venceu na linha horizontal inferior
		cmp 	byte[posicao_ocupada+6], 'C'
		jne		comparaCLVE
		cmp 	byte[posicao_ocupada+9], 'C'
		jne		comparaCLVE
		cmp 	byte[posicao_ocupada+12], 'C'
		jne 	comparaCLVE
		jmp		linhaHI
	
	comparaCLVE:								; compara se C venceu na linha vertical esquerda
		cmp 	byte[posicao_ocupada+4], 'C'
		jne		comparaCLVM
		cmp 	byte[posicao_ocupada+5], 'C'
		jne		comparaCLVM
		cmp 	byte[posicao_ocupada+6], 'C'
		jne 	comparaCLVM
		jmp		linhaVE

	comparaCLVM:								; compara se C venceu na linha vertical do meio
		cmp 	byte[posicao_ocupada+7], 'C'
		jne		comparaCLVD
		cmp 	byte[posicao_ocupada+8], 'C'
		jne		comparaCLVD
		cmp 	byte[posicao_ocupada+9], 'C'
		jne 	comparaCLVD
		jmp		linhaVM

	comparaCLVD:								; compara se C venceu na linha vertical direita
		cmp 	byte[posicao_ocupada+10], 'C'
		jne		comparaCLD1
		cmp 	byte[posicao_ocupada+11], 'C'
		jne		comparaCLD1
		cmp 	byte[posicao_ocupada+12], 'C'
		jne 	comparaCLD1
		jmp		linhaVD
	
	comparaCLD1:								; compara se C venceu na linha diagonal 1
		cmp 	byte[posicao_ocupada+4], 'C'
		jne		comparaCLD2
		cmp 	byte[posicao_ocupada+8], 'C'
		jne		comparaCLD2
		cmp 	byte[posicao_ocupada+12], 'C'
		jne 	comparaCLD2
		jmp		linhaD1
	
	comparaCLD2:								; compara se C venceu na linha diagonal 2
		cmp 	byte[posicao_ocupada+6], 'C'
		jne		vitoriaX
		cmp 	byte[posicao_ocupada+8], 'C'
		jne		vitoriaX
		cmp 	byte[posicao_ocupada+10], 'C'
		jne 	vitoriaX
		jmp		linhaD2

vitoriaX:
	comparaXLHS:								; compara se X venceu na linha horizontal superior
		cmp 	byte[posicao_ocupada+4], 'X'
		jne		comparaXLHM
		cmp 	byte[posicao_ocupada+7], 'X'
		jne		comparaXLHM
		cmp 	byte[posicao_ocupada+10], 'X'
		jne 	comparaXLHM
		jmp		linhaHS
	
	comparaXLHM:								; compara se X venceu na linha horizontal do meio
		cmp 	byte[posicao_ocupada+5], 'X'
		jne		comparaXLHI
		cmp 	byte[posicao_ocupada+8], 'X'
		jne		comparaXLHI
		cmp 	byte[posicao_ocupada+11], 'X'
		jne 	comparaXLHI
		jmp		linhaHM

	comparaXLHI:								; compara se X venceu na linha horizontal inferior
		cmp 	byte[posicao_ocupada+6], 'X'
		jne		comparaXLVE
		cmp 	byte[posicao_ocupada+9], 'X'
		jne		comparaXLVE
		cmp 	byte[posicao_ocupada+12], 'X'
		jne 	comparaXLVE
		jmp		linhaHI
	
	comparaXLVE:								; compara se X venceu na linha vertical esquerda
		cmp 	byte[posicao_ocupada+4], 'X'
		jne		comparaXLVM
		cmp 	byte[posicao_ocupada+5], 'X'
		jne		comparaXLVM
		cmp 	byte[posicao_ocupada+6], 'X'
		jne 	comparaXLVM
		jmp		linhaVE

	comparaXLVM:								; compara se X venceu na linha vertical do meio
		cmp 	byte[posicao_ocupada+7], 'X'
		jne		comparaXLVD
		cmp 	byte[posicao_ocupada+8], 'X'
		jne		comparaXLVD
		cmp 	byte[posicao_ocupada+9], 'X'
		jne 	comparaXLVD
		jmp		linhaVM

	comparaXLVD:								; compara se X venceu na linha vertical direita
		cmp 	byte[posicao_ocupada+10], 'X'
		jne		comparaXLD1
		cmp 	byte[posicao_ocupada+11], 'X'
		jne		comparaXLD1
		cmp 	byte[posicao_ocupada+12], 'X'
		jne 	comparaXLD1
		jmp		linhaVD
	
	comparaXLD1:								; compara se X venceu na linha diagonal 1
		cmp 	byte[posicao_ocupada+4], 'X'
		jne		comparaXLD2
		cmp 	byte[posicao_ocupada+8], 'X'
		jne		comparaXLD2
		cmp 	byte[posicao_ocupada+12], 'X'
		jne 	comparaXLD2
		jmp		linhaD1
	
	comparaXLD2:								; compara se X venceu na linha diagonal 2
		cmp 	byte[posicao_ocupada+6], 'X'
		jne		verifica_empate
		cmp 	byte[posicao_ocupada+8], 'X'
		jne		verifica_empate
		cmp 	byte[posicao_ocupada+10], 'X'
		jne 	verifica_empate
		jmp		linhaD2

verifica_empate:
	cmp		byte[num_jogadas], 9
	jne 	ainda_jogadas
	; imprime a mensagem de empate
		mov     cx, 16			;n�mero de caracteres
    	mov     bx, 0
    	mov     dh, 28			;linha 0-29
    	mov     dl, 18			;coluna 0-79
		l10:
		call	cursor
    	mov     al,[bx+empate]
		call	caracter
    	inc     bx			;proximo caracter
		inc		dl			;avanca a coluna
    	loop    l10
		jmp 	continua
	ainda_jogadas:
		jmp 	continua

; linhas de vitoria
	linhaHS:
		; x1
		mov 	ax, 198
		push 	ax
		; y1
		mov		ax, 409
		push 	ax
		; x2
		mov		ax, 415
		push 	ax
		; y2
		mov		ax, 409
		push 	ax

		mov 	byte[cor], verde
		call 	line
		mov 	byte[cor], branco_intenso
		jmp 	msg_vitoria

	linhaHM:
		; x1
		mov 	ax, 198
		push 	ax
		; y1
		mov		ax, 308
		push 	ax
		; x2
		mov		ax, 415
		push 	ax
		; y2
		mov		ax, 308
		push 	ax

		mov 	byte[cor], verde
		call 	line
		mov 	byte[cor], branco_intenso
		jmp 	msg_vitoria

	linhaHI:
		; x1
		mov 	ax, 198
		push 	ax
		; y1
		mov		ax, 207
		push 	ax
		; x2
		mov		ax, 415
		push 	ax
		; y2
		mov		ax, 207
		push 	ax

		mov 	byte[cor], verde
		call 	line
		mov 	byte[cor], branco_intenso
		jmp 	msg_vitoria

	linhaVE:
		; x1
		mov 	ax, 211
		push 	ax
		; y1
		mov		ax, 416
		push 	ax
		; x2
		mov		ax, 211
		push 	ax
		; y2
		mov		ax, 198
		push 	ax

		mov 	byte[cor], verde
		call 	line
		mov 	byte[cor], branco_intenso
		jmp 	msg_vitoria

	linhaVM:
		; x1
		mov 	ax, 312
		push 	ax
		; y1
		mov		ax, 416
		push 	ax
		; x2
		mov		ax, 312
		push 	ax
		; y2
		mov		ax, 198
		push 	ax

		mov 	byte[cor], verde
		call 	line
		mov 	byte[cor], branco_intenso
		jmp 	msg_vitoria

	linhaVD:
		; x1
		mov 	ax, 413
		push 	ax
		; y1
		mov		ax, 416
		push 	ax
		; x2
		mov		ax, 413
		push 	ax
		; y2
		mov		ax, 198
		push 	ax

		mov 	byte[cor], verde
		call 	line
		mov 	byte[cor], branco_intenso
		jmp 	msg_vitoria

	linhaD1:
		; x1
		mov 	ax, 205
		push 	ax
		; y1
		mov		ax, 413
		push 	ax
		; x2
		mov		ax, 423
		push 	ax
		; y2
		mov		ax, 195
		push 	ax

		mov 	byte[cor], verde
		call 	line
		mov 	byte[cor], branco_intenso
		jmp 	msg_vitoria

	linhaD2:
		; x1
		mov 	ax, 419
		push 	ax
		; y1
		mov		ax, 413
		push 	ax
		; x2
		mov		ax, 201
		push 	ax
		; y2
		mov		ax, 195
		push 	ax

		mov 	byte[cor], verde
		call 	line
		mov 	byte[cor], branco_intenso
		jmp 	msg_vitoria

msg_vitoria:
	; imprime a mensagem de vitoria
		mov     cx, 16			;n�mero de caracteres
    	mov     bx, 0
    	mov     dh, 28			;linha 0-29
    	mov     dl, 18			;coluna 0-79
		l11:
		call	cursor
    	mov     al,[bx+vitoria]
		call	caracter
    	inc     bx			;proximo caracter
		inc		dl			;avanca a coluna
    	loop    l11
		jmp 	continua

entraC:
	xor 	ax, ax
	cmp 	byte[ultima_jogada], 'c'
	je 		jogada_errada
	mov 	al, byte[entrada+3]
	mov 	bx, ax
	push 	ax
	sub		bx,'0'
	mov 	al, byte[entrada+4]
	push 	ax
	sub		ax,'0'
	call 	circle
	mov 	cx, 3
	mul 	cx
	add 	bx, ax 							; soma os indices da casa para determinar a posição no vetor
	mov 	byte[posicao_ocupada+bx], 'C'
	mov 	byte[ultima_jogada], 'c'
	inc 	byte[num_jogadas]
	jmp 	vitoriaC

entraX:
	xor		ax, ax
	cmp 	byte[ultima_jogada], 'x'
	je 		jogada_errada
	mov 	al, byte[entrada+3]
	mov 	bx, ax
	push 	ax
	sub		bx,'0'
	mov 	al, byte[entrada+4]
	push 	ax
	sub		ax,'0'
	call 	desenha_x
	mov 	cx, 3
	mul 	cx
	add 	bx, ax							; soma os indices da casa para determinar a posição no vetor
	mov 	byte[posicao_ocupada+bx], 'X'
	mov 	byte[ultima_jogada], 'x'
	inc 	byte[num_jogadas]
	jmp 	vitoriaX

entrada_errada:
	; imprime a mensagem de erro
		mov     cx, 16			;n�mero de caracteres
    	mov     bx, 0
    	mov     dh, 28			;linha 0-29
    	mov     dl, 18			;coluna 0-79
		l3:
		call	cursor
    	mov     al,[bx+erro1]
		call	caracter
    	inc     bx			;proximo caracter
		inc		dl			;avanca a coluna
    	loop    l3
		jmp 	continua

jogada_errada:
		; imprime a mensagem de erro
		mov     cx, 16			;n�mero de caracteres
    	mov     bx, 0
    	mov     dh, 28			;linha 0-29
    	mov     dl, 18			;coluna 0-79
		l4:
		call	cursor
		mov     al,[bx+erro2]
		call	caracter
    	inc     bx			;proximo caracter
		inc		dl			;avanca a coluna
    	loop    l4
		jmp 	continua

reinicia:
	; limpa a entrada
	 	mov 	byte[entrada], ' ' 		
	 	mov 	byte[entrada+1], ' '	
	 	mov 	byte[entrada+2], ' '	
	 	mov 	byte[entrada+3], ' '	
	 	mov		byte[entrada+4], ' '	
	
	; limpa o numero de jogadas
		mov		byte[num_jogadas], 0
	
	; limpa as posições ocupadas
		mov		cx, 20
		mov 	bx, 0
		limpa_posicoes_ocupadas:
			mov 	byte[posicao_ocupada+bx], ' '
			inc bx
			loop	limpa_posicoes_ocupadas
	
	; limpa qual foi a ultima peça jogada
		mov 	byte[ultima_jogada], ' '
		
	; limpa a tela:
		mov     cx, 30          ; linha 0-29
		mov     bx, 0           
		mov     dh, 0           ; linha incial 
		mov     dl, 0           ; coluna incial
		l8:
			call    cursor          
			mov     al, ' '         
			call    caracter        
			inc     bx              
			inc     dl              
			cmp     dl, 80          ; verifica se passou por todas as colunas 
			jnz     l8              ; se não, continue o loop
			mov     dl, 0           ; se sim, volta pra primeira coluna
			inc     dh              
			loop    l8              
	
	; restaura os indices das casas
		mov		word[casa1], '11'
		mov		word[casa2], '12'
		mov		word[casa3], '13'
		mov		word[casa4], '21'
		mov		word[casa5], '22'
		mov		word[casa6], '23'
		mov		word[casa7], '31'
		mov		word[casa8], '32'
		mov		word[casa9], '33'
		
	jmp 	tabuleiro

END:
	mov     cx, 16			;n�mero de caracteres
	mov     bx, 0
	mov     dh, 28			;linha 0-29
	mov     dl, 18			;coluna 0-79
	l9:
	call	cursor
	mov     al,[bx+sair]
	call	caracter
	inc     bx			;proximo caracter
	inc		dl			;avanca a coluna
	loop    l9
	;retorno ao modo de video
	mov		ah,08h
	int		21h
	mov		ah,0				; set video mode
	mov		al,[modo_anterior]	; modo anterior
	int		10h
	mov		ax,4c00h
	int		21h

;_________________________________________________________________________________________
;
;   fun��o cursor
;
; dh = linha (0-29) e  dl=coluna  (0-79)
cursor:
		pushf
		push 		ax
		push 		bx
		push		cx
		push		dx
		push		si
		push		di
		push		bp
		mov     	ah,2
		mov     	bh,0
		int     	10h
		pop		bp
		pop		di
		pop		si
		pop		dx
		pop		cx
		pop		bx
		pop		ax
		popf
		ret

;_________________________________________________________________________________________
;
;   fun��o caracter escrito na posi��o do cursor
;
; al= caracter a ser escrito
; cor definida na variavel cor
caracter:
		pushf
		push 		ax
		push 		bx
		push		cx
		push		dx
		push		si
		push		di
		push		bp
    	mov     	ah,9
    	mov     	bh,0
    	mov     	cx,1
   		mov     	bl,[cor]
    	int     	10h
		pop		bp
		pop		di
		pop		si
		pop		dx
		pop		cx
		pop		bx
		pop		ax
		popf
		ret

;_________________________________________________________________________________________
;
;   fun��o plot_xy
;
; push x; push y; call plot_xy;  (x<639,  y<479)
; cor definida na variavel cor
plot_xy:
		push	bp
		mov		bp, sp
		pushf
		push 	ax
		push 	bx
		push	cx
		push	dx
		push	si
		push	di
	    mov     ah, 0ch
	    mov     al, [cor]
	    mov     bh, 0
	    mov     dx, 479
		sub		dx, [bp+4]
	    mov     cx, [bp+6]
	    int     10h
		pop		di
		pop		si
		pop		dx
		pop		cx
		pop		bx
		pop		ax
		popf
		pop		bp
		ret		4

;_________________________________________________________________________________________
;    fun��o X
;	 push x; push y; call desenha_x
; cor definida na variavel cor
desenha_x:
	push 	bp
	mov		bp, sp
	pushf                        ;coloca os flags na pilha
	push 	ax
	push 	bx
	push	cx
	push	dx
	push	si
	push	di

	;traçando uma das linhas de X
	mov		ax, [bp+4]    ; resgata x
	sub		ax, '0'		  ; converte para num
	mov		bx,	101	 	  ; salva a dimensao da casa em bx
	mul		bx		  	  ; salva em ax a dimensao do deslocamento
	add		ax, 110		  ; soma a coordenada de x0
	sub		ax, 36		  ; posiciona x do incio da linha
	push 	ax

	mov		ax, [bp+6]    ; resgata y 
	sub		ax, '0'		  ; converte para num
	mov		bx,	101		  ; salva a dimensao da casa em bx
	mul		bx		      ; salva em ax a dimensao do deslocamento
	mov 	bx, ax		  ; salva em bx o que tinha em ax
	mov		ax,	510		  ; salva em ax a coordenada de y0
	sub 	ax, bx
	add		ax, 36		  ; posiciona y do incio da linha
	push 	ax

	mov		ax, [bp+4]    ; resgata x 
	sub		ax, '0'
	mov		bx,	101
	mul		bx
	add		ax, 110		;coordenada de x0
	add 	ax, 36
	push 	ax

	mov		ax, [bp+6]    ; resgata y 
	sub		ax, '0'		  ; converte para num
	mov		bx,	101		  ; salva a dimensao da casa em bx
	mul		bx		      ; salva em ax a dimensao do deslocamento
	mov 	bx, ax		  ; salva em bx o que tinha em ax
	mov		ax,	510		  ; salva em ax a coordenada de y0
	sub 	ax, bx
	sub 	ax, 36
	push 	ax

	call line

	;traçando a outra linha de X
	mov		ax, [bp+4]    ; resgata x do meio de X
	sub		ax, '0'
	mov		bx,	101
	mul		bx
	add		ax, 110		;coordenada de x0
	add		ax, 36
	push 	ax

	mov		ax, [bp+6]    ; resgata y do meio de X
	sub		ax, '0'		  ; converte para num
	mov		bx,	101		  ; salva a dimensao da casa em bx
	mul		bx		      ; salva em ax a dimensao do deslocamento
	mov 	bx, ax		  ; salva em bx o que tinha em ax
	mov		ax,	510		  ; salva em ax a coordenada de y0
	sub 	ax, bx
	add		ax, 36
	push 	ax

	mov		ax, [bp+4]    ; resgata x do meio de X
	sub		ax, '0'
	mov		bx,	101
	mul		bx
	add		ax, 110		;coordenada de x0
	sub 	ax, 36
	push 	ax

	mov		ax, [bp+6]    ; resgata y do meio de X
	sub		ax, '0'		  ; converte para num
	mov		bx,	101		  ; salva a dimensao da casa em bx
	mul		bx		      ; salva em ax a dimensao do deslocamento
	mov 	bx, ax		  ; salva em bx o que tinha em ax
	mov		ax,	510		  ; salva em ax a coordenada de y0
	sub 	ax, bx
	sub 	ax, 36
	push 	ax

	call 	line

	;saindo da func
	pop		di
	pop		si
	pop		dx
	pop		cx
	pop		bx
	pop		ax
	popf
	pop		bp
	ret		6
	
;_________________________________________________________________________________________
;    fun��o circle
;	 push xc; push yc; r = 35; call circle;  (xc+r<639, yc+r<479)e(xc-r>0, yc-r>0)
; cor definida na variavel cor
circle:
	mov     byte[cor],vermelho   ; define a cor do circulo como vermelho
	push 	bp
	mov		bp, sp
	pushf                        ;coloca os flags na pilha
	push 	ax
	push 	bx
	push	cx
	push	dx
	push	si
	push	di
	
	mov		bx, [bp+6]    ; resgata yc
	sub		bx, '0'		  ; converte para num
	mov		ax,	101		  ; salva a dimensao da casa em bx
	mul		bx		      ; salva em ax a dimensao do deslocamento
	mov 	cx, ax		  ; salva em cx o deslocamento total
	mov 	ax, 510		  ; salva em ax a coordenada de y0
	sub		ax, cx		  ; soma a coordenada de y0
	mov 	bx, ax		  ; salva em bx o conteudo de ax

	mov		ax, [bp+4]    ; resgata xc
	sub		ax, '0'		  ; converte para num
	mov		cx,	101	 	  ; salva a dimensao da casa em bx
	mul		cx		      ; salva em ax a dimensao do deslocamento
	add		ax, 110		  ; soma a coordenada de x0

	mov		cx,  37       ; define diametro = 74
	
	mov 	dx, bx	
	add		dx, cx        ;ponto extremo superior
	push    ax			
	push	dx
	call	 plot_xy
	
	mov		dx, bx
	sub		dx, cx       ;ponto extremo inferior
	push    ax			
	push	dx
	call 	plot_xy

	mov 	dx, ax	
	add		dx, cx       ;ponto extremo direita
	push    dx			
	push	bx
	call	 plot_xy
	
	mov		dx, ax
	sub		dx, cx       ;ponto extremo esquerda
	push    dx			
	push	bx
	call	 plot_xy
		
	mov		di, cx
	sub		di, 1	 ;di=r-1
	mov		dx, 0  	;dx ser� a vari�vel x. cx � a variavel y
	
;aqui em cima a l�gica foi invertida,  1-r => r-1
;e as compara��es passaram a ser jl => jg,  assim garante 
;valores positivos para d

stay:				;loop
	mov		si, di
	cmp		si, 0
	jg		inf       ;caso d for menor que 0,  seleciona pixel superior (n�o  salta)
	mov		si, dx		;o jl � importante porque trata-se de conta com sinal
	sal		si, 1		;multiplica por doi (shift arithmetic left)
	add		si, 3
	add		di, si     ;nesse ponto d=d+2*dx+3
	inc		dx		;incrementa dx
	jmp		plotar
inf:	
	mov		si, dx
	sub		si, cx  		;faz x - y (dx-cx),  e salva em di 
	sal		si, 1
	add		si, 5
	add		di, si		;nesse ponto d=d+2*(dx-cx)+5
	inc		dx		;incrementa x (dx)
	dec		cx		;decrementa y (cx)
	
plotar:	
	mov		si, dx
	add		si, ax
	push    si			;coloca a abcisa x+xc na pilha
	mov		si, cx
	add		si, bx
	push    si			;coloca a ordenada y+yc na pilha
	call plot_xy		;toma conta do segundo octante
	mov		si, ax
	add		si, dx
	push    si			;coloca a abcisa xc+x na pilha
	mov		si, bx
	sub		si, cx
	push    si			;coloca a ordenada yc-y na pilha
	call plot_xy		;toma conta do s�timo octante
	mov		si, ax
	add		si, cx
	push    si			;coloca a abcisa xc+y na pilha
	mov		si, bx
	add		si, dx
	push    si			;coloca a ordenada yc+x na pilha
	call plot_xy		;toma conta do segundo octante
	mov		si, ax
	add		si, cx
	push    si			;coloca a abcisa xc+y na pilha
	mov		si, bx
	sub		si, dx
	push    si			;coloca a ordenada yc-x na pilha
	call plot_xy		;toma conta do oitavo octante
	mov		si, ax
	sub		si, dx
	push    si			;coloca a abcisa xc-x na pilha
	mov		si, bx
	add		si, cx
	push    si			;coloca a ordenada yc+y na pilha
	call plot_xy		;toma conta do terceiro octante
	mov		si, ax
	sub		si, dx
	push    si			;coloca a abcisa xc-x na pilha
	mov		si, bx
	sub		si, cx
	push    si			;coloca a ordenada yc-y na pilha
	call plot_xy		;toma conta do sexto octante
	mov		si, ax
	sub		si, cx
	push    si			;coloca a abcisa xc-y na pilha
	mov		si, bx
	sub		si, dx
	push    si			;coloca a ordenada yc-x na pilha
	call plot_xy		;toma conta do quinto octante
	mov		si, ax
	sub		si, cx
	push    si			;coloca a abcisa xc-y na pilha
	mov		si, bx
	add		si, dx
	push    si			;coloca a ordenada yc-x na pilha
	call plot_xy		;toma conta do quarto octante
	
	cmp		cx, dx
	jb		fim_circle  ;se cx (y) est� abaixo de dx (x),  termina     
	jmp		stay		;se cx (y) est� acima de dx (x),  continua no loop	
	
fim_circle:
	mov     byte[cor], branco_intenso ; volta a cor para o branco
	pop		di
	pop		si
	pop		dx
	pop		cx
	pop		bx
	pop		ax
	popf
	pop		bp
	ret		6

;_________________________________________________________________________________________
;
;   fun��o line
;
; push x1; push y1; push x2; push y2; call line;  (x<639,  y<479)

line:
        push	bp
        mov		bp, sp
        pushf                        ;coloca os flags na pilha
        push 	ax
        push 	bx
        push	cx
        push	dx
        push	si
        push	di
        mov		ax, [bp+10]   ; resgata os valores das coordenadas
        mov		bx, [bp+8]    ; resgata os valores das coordenadas
        mov		cx, [bp+6]    ; resgata os valores das coordenadas
        mov		dx, [bp+4]    ; resgata os valores das coordenadas
        cmp		ax, cx
        je		line2
        jb		line1
        xchg	ax, cx
        xchg	bx, dx
        jmp		line1
line2:		; deltax=0
        cmp		bx, dx  ;subtrai dx de bx
        jb		line3
        xchg	bx, dx        ;troca os valores de bx e dx entre eles
line3:	; dx > bx
        push	ax
        push	bx
        call 	plot_xy
        cmp		bx, dx
        jne		line31
        jmp		fim_line
line31:		
        inc		bx
        jmp		line3
;deltax <>0
line1:
; comparar m�dulos de deltax e deltay sabendo que cx>ax
; cx > ax
        push	cx
        sub		cx, ax
        mov		[deltax], cx
        pop		cx
        push	dx
        sub		dx, bx
        ja		line32
        neg		dx
line32:		
        mov		[deltay], dx
        pop		dx

        push	ax
        mov		ax, [deltax]
        cmp		ax, [deltay]
        pop		ax
        jb		line5

; cx > ax e deltax>deltay
        push	cx
        sub		cx, ax
        mov		[deltax], cx
        pop		cx
        push		dx
        sub		dx, bx
        mov		[deltay], dx
        pop		dx

        mov		si, ax
line4:
        push	ax
        push	dx
        push	si
        sub		si, ax	;(x-x1)
        mov		ax, [deltay]
        imul	si
        mov		si, [deltax]		;arredondar
        shr		si, 1
; se numerador (DX)>0 soma se <0 subtrai
        cmp		dx, 0
        jl		ar1
        add		ax, si
        adc		dx, 0
        jmp		arc1
ar1:		
		sub		ax, si
        sbb		dx, 0
arc1:
        idiv	word [deltax]
        add		ax, bx
        pop		si
        push	si
        push	ax
        call	plot_xy
        pop		dx
        pop		ax
        cmp		si, cx
        je		fim_line
        inc		si
        jmp		line4

line5:		
        cmp		bx, dx
        jb 		line7
        xchg	ax, cx
        xchg	bx, dx
line7:
        push	cx
        sub		cx, ax
        mov		[deltax], cx
        pop		cx
        push	dx
        sub		dx, bx
        mov		[deltay], dx
        pop		dx

        mov		si, bx
line6:
        push	dx
        push	si
        push	ax
        sub		si, bx	;(y-y1)
        mov		ax, [deltax]
        imul	si
        mov		si, [deltay]		;arredondar
        shr		si, 1
; se numerador (DX)>0 soma se <0 subtrai
        cmp		dx, 0
        jl		ar2
        add		ax, si
        adc		dx, 0
        jmp		arc2
ar2:		
        sub		ax, si
        sbb		dx, 0
arc2:
        idiv	word [deltay]
        mov		di, ax
        pop		ax
        add		di, ax
        pop		si
        push	di
        push	si
        call	plot_xy
        pop		dx
        cmp		si, dx
        je		fim_line
        inc		si
        jmp		line6

fim_line:
        pop		di
        pop		si
        pop		dx
        pop		cx
        pop		bx
        pop		ax
        popf
        pop		bp
        ret		8

segment data
	modo_anterior	db		0
	cor				db		branco_intenso
	msg1			db		'Jogada Anterior:'
	msg2			db		'Proximo Movimento:'
	sair 			db 		'Saindo do Jogo  '
	erro1			db		'Comando Invalido'
	erro2			db		'Jogada Invalida ' 	 ; o espaço no final é para deixar ambas as mensagens de erro com mesmo tamanho
	vitoria			db		'--- Parabens ---'
	empate			db 		'O jogo deu Velha'
	limpa			db 		'                  ' ; mensagem para limpar a exibição de texto
	entrada			db		'    '					 ; variavel que armazena a entrada
	posicao_ocupada	db		'             '
	; a cada 3 posições completamos 1 linha do tabuleiro
	ultima_jogada 	db		' '
	casa1			db		'11'
	casa2			db		'12'
	casa3			db		'13'
	casa4			db		'21'
	casa5			db		'22'
	casa6			db		'23'
	casa7			db		'31'
	casa8			db		'32'
	casa9			db		'33'
	linha 			db 		0
	coluna 			db 		0
	num_jogadas		db		0
	; dim_tab		db		303
	; dim_casa		db		101
	; raio 			db		35
	; inicioy_tab	db		460
	; iniciox_tab	db		160	
	

	preto			equ		0
	azul			equ		1
	verde			equ		2
	cyan			equ		3
	vermelho		equ		4
	magenta			equ		5
	marrom			equ		6
	branco			equ		7
	cinza			equ		8
	azul_claro		equ		9
	verde_claro		equ		10
	cyan_claro		equ		11
	rosa			equ		12
	magenta_claro	equ		13
	amarelo			equ		14
	branco_intenso	equ		15

	deltax		dw		0
	deltay		dw		0

segment stack stack
        resb 512
stacktop: