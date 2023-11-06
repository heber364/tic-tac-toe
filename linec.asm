; vers�o de 10/05/2007
; corrigido erro de arredondamento na rotina line.
; circle e full_circle disponibilizados por Jefferson Moro em 10/2009
;
segment code
..start:
  mov 		ax,data
  mov 		ds,ax
  mov 		ax,stack
  mov 		ss,ax
  mov 		sp,stacktop

;Salvar modo corrente de video(vendo como est� o modo de video da maquina)
  mov  		ah,0Fh
  int  		10h
  mov  		[modo_anterior],al   

;Alterar modo de video para gr�fico 640x480 16 cores
  mov     	al,12h
  mov     	ah,0
  int     	10h
		

;Desenhar jogo da velha
	print_terminal_text:
		mov     	bx,0
		mov     	cx,8			;n�mero de caracteres
		mov     	dh,7			;linha 0-29
		mov     	dl,1			;coluna 0-79
		mov		byte[cor], branco_intenso

		LTT:
			call		cursor
			mov     al,[bx+string_terminal]
			call		caracter
			inc     bx			;proximo caracter
			inc			dl			;avanca a coluna
			
			loop    LTT
	print_tic_tac_toe:
		mov		byte[cor],branco_intenso	;1 Reta vertical
		mov		ax,245
		push		ax
		mov		ax,91
		push		ax
		mov		ax,245
		push		ax
		mov		ax,469
		push		ax
		call		line

		mov		byte[cor],branco_intenso	;2 Reta vertical
		mov		ax,371
		push		ax
		mov		ax,91
		push		ax
		mov		ax,371
		push		ax
		mov		ax,469
		push		ax
		call		line

		mov		byte[cor],branco_intenso	;1 Reta horizontal
		mov		ax,119
		push		ax
		mov		ax,343
		push		ax
		mov		ax,497
		push		ax
		mov		ax,343
		push		ax
		call		line

		mov		byte[cor],branco_intenso	;2 Reta horizontal
		mov		ax,119
		push		ax
		mov		ax,217
		push		ax
		mov		ax,497
		push		ax
		mov		ax,217
		push		ax
		call		line

	print_command_field:
		mov		byte[cor],branco_intenso	;Reta horizontal superior
		mov		ax,5
		push		ax
		mov		ax,70
		push		ax
		mov		ax,635
		push		ax
		mov		ax,70
		push		ax
		call		line

		mov		byte[cor],branco_intenso	;Reta horizontal inferior
		mov		ax,5
		push		ax
		mov		ax,40
		push		ax
		mov		ax,635
		push		ax
		mov		ax,40
		push		ax
		call		line

		mov		byte[cor],branco_intenso	;Reta vertical da esquerda
		mov		ax,5
		push		ax
		mov		ax,70
		push		ax
		mov		ax,5
		push		ax
		mov		ax,40
		push		ax
		call		line

		mov		byte[cor],branco_intenso	;Reta vertical da direita
		mov		ax,635
		push		ax
		mov		ax,70
		push		ax
		mov		ax,635
		push		ax
		mov		ax,40
		push		ax
		call		line

	print_message_field:
		mov		byte[cor],branco_intenso	;Reta horizontal superior
		mov		ax,5
		push		ax
		mov		ax,35
		push		ax
		mov		ax,635
		push		ax
		mov		ax,35
		push		ax
		call		line

		mov		byte[cor],branco_intenso	;Reta horizontal inferior
		mov		ax,5
		push		ax
		mov		ax,5
		push		ax
		mov		ax,635
		push		ax
		mov		ax,5
		push		ax
		call		line

		mov		byte[cor],branco_intenso	;Reta vertical da esquerda
		mov		ax,5
		push		ax
		mov		ax,35
		push		ax
		mov		ax,5
		push		ax
		mov		ax,5
		push		ax
		call		line

		mov		byte[cor],branco_intenso	;Reta vertical da direita
		mov		ax,635
		push		ax
		mov		ax,35
		push		ax
		mov		ax,635
		push		ax
		mov		ax,5
		push		ax
		call		line	
	
	print_command_title:
		mov     	cx,16			;n�mero de caracteres
		mov     	bx,0
		mov     	dh,26			;linha 0-29
		mov     	dl,2			;coluna 0-79
		mov		byte[cor],branco_intenso
	
		LCC:
		call	cursor
		mov     al,[bx+string_last_move]
		call	caracter
		inc     bx			;proximo caracter
		inc		dl			;avanca a coluna

		loop    LCC
	
	
	print_message_title:
		mov     	cx,18			;n�mero de caracteres
		mov     	bx,0
		mov     	dh,28			;linha 0-29
		mov     	dl,2			;coluna 0-79
		mov		byte[cor],branco_intenso

		LCM:
			call	cursor
			mov     al,[bx+string_message]
			call	caracter
			inc     bx			;proximo caracter
			inc		dl			;avanca a coluna
			loop    LCM
	print_game_title:
		mov     	cx,13			;n�mero de caracteres
		mov     	bx,0
		mov     	dh,0			;linha 0-29
		mov     	dl,32			;coluna 0-79
		mov		byte[cor],branco_intenso

		L1GT:
			call	cursor
			mov     al,[bx+string_game]
			call	caracter
			inc     bx			;proximo caracter
			inc		dl			;avanca a coluna
			loop    L1GT

		;mov    	ah,08h


;Escrever numerações de ajuda 
	;N11
		mov     	cx,2			;n�mero de caracteres
		mov     	bx,0
		mov     	dh,1			;linha 0-29
		mov     	dl,15			;coluna 0-79
		mov		byte[cor],branco_intenso


		LN11:
			call	cursor
				mov     al,[bx+n11]
			call	caracter
				inc     bx			;proximo caracter
			inc		dl			;avanca a coluna
			;inc		byte [cor]		;mudar a cor para a seguinte
				loop    LN11
	;N12
		mov     	cx,2			;n�mero de caracteres
		mov     	bx,0
		mov     	dh,1			;linha 0-29
		mov     	dl,31			;coluna 0-79
		mov		byte[cor],branco_intenso


		LN12:
			call	cursor
				mov     al,[bx+n12]
			call	caracter
				inc     bx			;proximo caracter
			inc		dl			;avanca a coluna
			;inc		byte [cor]		;mudar a cor para a seguinte
				loop    LN12
	;N13
		mov     	cx,2			;n�mero de caracteres
		mov     	bx,0
		mov     	dh,1			;linha 0-29
		mov     	dl,47			;coluna 0-79
		mov		byte[cor],branco_intenso


		LN13:
			call	cursor
				mov     al,[bx+n13]
			call	caracter
				inc     bx			;proximo caracter
			inc		dl			;avanca a coluna
			;inc		byte [cor]		;mudar a cor para a seguinte
				loop    LN13
	;N21
		mov     	cx,2			;n�mero de caracteres
		mov     	bx,0
		mov     	dh,9			;linha 0-29
		mov     	dl,15			;coluna 0-79
		mov		byte[cor],branco_intenso


		LN21:
			call	cursor
				mov     al,[bx+n21]
			call	caracter
				inc     bx			;proximo caracter
			inc		dl			;avanca a coluna
			;inc		byte [cor]		;mudar a cor para a seguinte
				loop    LN21
	;N22
		mov     	cx,2			;n�mero de caracteres
		mov     	bx,0
		mov     	dh,9			;linha 0-29
		mov     	dl,31			;coluna 0-79
		mov		byte[cor],branco_intenso


		LN22:
			call	cursor
				mov     al,[bx+n22]
			call	caracter
				inc     bx			;proximo caracter
			inc		dl			;avanca a coluna
			;inc		byte [cor]		;mudar a cor para a seguinte
				loop    LN22
	;N23
		mov     	cx,2			;n�mero de caracteres
		mov     	bx,0
		mov     	dh,9			;linha 0-29
		mov     	dl,47			;coluna 0-79
		mov		byte[cor],branco_intenso


		LN23:
			call	cursor
				mov     al,[bx+n23]
			call	caracter
				inc     bx			;proximo caracter
			inc		dl			;avanca a coluna
			;inc		byte [cor]		;mudar a cor para a seguinte
				loop    LN23
	;N31
		mov     	cx,2			;n�mero de caracteres
		mov     	bx,0
		mov     	dh,17			;linha 0-29
		mov     	dl,15			;coluna 0-79
		mov		byte[cor],branco_intenso


		LN31:
			call	cursor
				mov     al,[bx+n31]
			call	caracter
				inc     bx			;proximo caracter
			inc		dl			;avanca a coluna
			;inc		byte [cor]		;mudar a cor para a seguinte
				loop    LN31
	;N32
		mov     	cx,2			;n�mero de caracteres
		mov     	bx,0
		mov     	dh,17			;linha 0-29
		mov     	dl,31			;coluna 0-79
		mov		byte[cor],branco_intenso


		LN32:
			call	cursor
				mov     al,[bx+n32]
			call	caracter
				inc     bx			;proximo caracter
			inc		dl			;avanca a coluna
			;inc		byte [cor]		;mudar a cor para a seguinte
				loop    LN32
	;N33
		mov     	cx,2			;n�mero de caracteres
		mov     	bx,0
		mov     	dh,17			;linha 0-29
		mov     	dl,47			;coluna 0-79
		mov		byte[cor],branco_intenso


		LN33:
			call	cursor
				mov     al,[bx+n33]
			call	caracter
				inc     bx			;proximo caracter
			inc		dl			;avanca a coluna
			;inc		byte [cor]		;mudar a cor para a seguinte
				loop    LN33
;Código principal
main_loop:

	mov dh, 8 ;linha 0-29
	mov dl, 1 ;coluna 0-79
	call cursor

	; Interrupção para capturar jogada
	mov ah, 0Ah
	mov dx, key_jogada
	int 21h
	
	;Limpa campo de mensagem
	call clear_message_field
	;Limpa terminal onde foi digitado o comando
	call clear_terminal

	;Imprime comanddo na barra de comando
	mov 			bx, 2
	mov			  cx, 3 ; Carrega o tamanho da string em CX
	mov     	dh,26								;linha 0-29
	mov     	dl,19								;coluna 0-79
	mov		byte[cor],branco_intenso
	
	loop_print_last_command:
		call		cursor
		mov     al,	[bx+key_jogada]
		call		caracter
		inc     bx			;proximo caracter
		inc			dl			;avanca a coluna
		
	loop    loop_print_last_command
	
	mov bx, 2
	mov al, 'C'
	cmp al, [key_jogada + bx] ; compara a primeira letra da string com 'C'
	je jmp_bridge_jogada_circulo ; caso seja igual a 'C' pule para a jogada_circulo
	
	mov al, 'X'
	cmp al, [key_jogada + bx] ; compara a primeira letra da string com X
	je jmp_bridge_jogada_x	 ; caso seja igual a 'X' pule para a jogada_circulo

 	mov al, 'c'
	cmp al, [key_jogada + bx] ; compara a primeira letra da string com 'c'
	je	novo_jogo ; caso seja igual a 'c' começa um novo jogo
	
	mov al, 's'
	cmp al, [key_jogada + bx] ; compara a primeira letra da string com 's'
	je	exit_game ; caso seja igual a 's', saia do programa

	jmp main_loop	; 
exit_game:
	int     21h
  mov  	ah,0   			; set video mode
  mov  	al,[modo_anterior]   	; modo anterior
  int  	10h
	mov     ax,4c00h
	int     21h
jmp_bridge_jogada_x:
	call jogada_x
jmp_bridge_jogada_circulo:
	call jogada_circulo

novo_jogo:
		mov		byte[cor],preto
		;LIMPA CIRCULOS
		call circle11
		call circle12
		call circle13
		call circle21
		call circle22
		call circle23
		call circle31
		call circle32
		call circle33

		;LIMPA X'S
		call x11
		call x12
		call x13
		call x21
		call x22
		call x23
		call x31
		call x32
		call x33

		;LIMPA LINHAS DE VITÓRIA
		call SVL1

		;LIMPA CELULAS 
		mov byte[cell11], 0
		mov byte[cell12], 0
		mov byte[cell13], 0
		mov byte[cell21], 0
		mov byte[cell22], 0
		mov byte[cell23], 0
		mov byte[cell31], 0
		mov byte[cell32], 0
		mov byte[cell33], 0

		;LIMPA REGISTROS DE ÚLTIMA JOGADA E GANHADOR
		mov byte[last_player], 0
		mov byte[victorious_player], 0	
		
		jmp print_tic_tac_toe;
		;;limpa jogas na tela

clear_message_field:
	;Limpa campo de mensagem
		mov 			bx, 0
		mov			  cx, 35 								;Carrega o tamanho da string em CX
		mov     	dh, 28								;linha 0-29
		mov     	dl, 21								;coluna 0-79
		mov		byte[cor],preto
		
		loop_print_clear_message_field:
			call		cursor
			mov     al,	[bx+string_empty_message]
			call		caracter
			inc     bx			;proximo caracter
			inc			dl			;avanca a coluna
			
		loop    loop_print_clear_message_field
	ret
jogada_circulo:
		mov al, [last_player]
		cmp al, 'C'
		je jogada_repetida

		mov		byte[cor],verde_claro	 ; seleciona a cord verde claro para círculo
		
		mov bx, 3
		mov al,[bx+key_jogada]
		sub al, '0'

		;compara linha da jogada com 1 
		cmp al, 1
		je jmp_intermediary_C1
		
		;compara linha da jogada com 2 
		cmp al, 2
		je jmp_bridge_c2

		; compara linha da jogada com 3 
		cmp al, 3
		je jmp_bridge_c3

		jmp main_loop	
		jmp_bridge_c2:
			call jmp_intermediary_C2
		jmp_bridge_c3:
			call jmp_intermediary_C3

jogada_x:	
		mov al, [last_player]
		cmp al, 'X'
		je jogada_repetida
		
		mov	byte[cor],rosa

		mov bx, 3
		mov al,[bx+key_jogada]
		sub al, '0'
		;compara linha da jogada com 1 
		cmp al, 1
		je jmp_bridge_x1
		
		;compara linha da jogada com 2 
		cmp al, 2
		je jmp_bridge_x2

		; compara linha da jogada com 3 
		cmp al, 3
		je jmp_bridge_x3

		jmp main_loop	

		jmp_bridge_x1:
			call jmp_intermediary_X1
		jmp_bridge_x2:
			call jmp_intermediary_X2
		jmp_bridge_x3:
			call jmp_intermediary_X3
jogada_repetida:
		;Imprime mensagem de jogada repetida na barra de mensagem
		mov 			bx, 0
		mov			  cx, 35 								;Carrega o tamanho da string em CX
		mov     	dh, 28								;linha 0-29
		mov     	dl, 21								;coluna 0-79
		mov		byte[cor],vermelho
		
	loop_print_jogada_repetida:
			call		cursor
			mov     al,	[bx+string_invalid_player]
			call		caracter
			inc     bx			;proximo caracter
			inc			dl			;avanca a coluna
			
	loop    loop_print_jogada_repetida
		jmp main_loop
jmp_intermediary_C1:
		mov bx, 4
		mov al,[bx+key_jogada]
		sub al, '0'

		;compara coluna da jogada com 1 
		cmp al, 1
		je jmp_intermediary_C11

		;compara coluna da jogada com 2
		cmp al, 2
		je jmp_intermediary_C12

		;compara coluna da jogada com 3
		cmp al, 3
		je jmp_intermediary_C13
		
		jmp main_loop
	jmp_intermediary_C11:
			cmp byte[cell11], 0	
			jne jmp_bridge_print_occupied_cell

			mov byte[last_player], 'C' ;Set como último jogador o 'C'
		  mov byte[cell11], 'C' ; Seta na celula 11 a jogada C

			call circle11
			call check_if_anyone_won
			jmp main_loop
		jmp_bridge_print_occupied_cell: ;ponte para a função principal
			call print_occupied_cell
	jmp_intermediary_C12:	
			cmp byte[cell12], 0	
			jne jmp_bridge_print_occupied_cell

			mov byte[last_player], 'C' ;Set como último jogador o 'C'
			mov byte[cell12], 'C' ; Seta na celula 12 a jogada C

			call circle12
			call check_if_anyone_won

			jmp main_loop
	jmp_intermediary_C13:
			cmp byte[cell13], 0
			jne jmp_bridge_print_occupied_cell

			mov byte[last_player], 'C' ;Set como último jogador o 'C'
			mov byte[cell13], 'C' ; Seta na celula 13 a jogada C

			call circle13
			call check_if_anyone_won
			jmp main_loop
jmp_intermediary_C2:
		mov bx, 4
		mov al,[bx+key_jogada]
		sub al, '0'

		;compara coluna da jogada com 1 
		cmp al, 1
		je jmp_intermediary_C21

		;compara coluna da jogada com 2
		cmp al, 2
		je jmp_intermediary_C22

		;compara coluna da jogada com 3
		cmp al, 3
		je jmp_intermediary_C23

		jmp main_loop
	jmp_intermediary_C21:
			cmp byte[cell21], 0	
			jne jmp_bridge_print_occupied_cell

			mov byte[last_player], 'C' ;Set como último jogador o 'C'
			mov byte[cell21], 'C' ; Seta na celula 21 a jogada C

			call circle21
			jmp main_loop
	jmp_intermediary_C22:
			cmp byte[cell22], 0	
			jne jmp_bridge_print_occupied_cell

			mov byte[last_player], 'C' ;Set como último jogador o 'C'
			mov byte[cell22], 'C' ; Seta na celula 22 a jogada C

			call circle22
			jmp main_loop
	jmp_intermediary_C23:
			cmp byte[cell23], 0	
			jne print_occupied_cell

			mov byte[last_player], 'C' ;Set como último jogador o 'C'
			mov byte[cell23], 'C' ; Seta na celula 23 a jogada C

			call circle23
			jmp main_loop

jmp_intermediary_C3:
		mov bx, 4
		mov al,[bx+key_jogada]
		sub al, '0'

		;compara coluna da jogada com 1 
		cmp al, 1
		je jmp_intermediary_C31

		;compara coluna da jogada com 2
		cmp al, 2
		je jmp_intermediary_C32

		;compara coluna da jogada com 3
		cmp al, 3
		je jmp_intermediary_C33

		jmp main_loop

	jmp_intermediary_C31:
			cmp byte[cell31], 0	
			jne print_occupied_cell

			mov byte[last_player], 'C' ;Set como último jogador o 'C'
			mov byte[cell31], 'C' ; Seta na celula 31 a jogada C

			call circle31
			jmp main_loop
	jmp_intermediary_C32:
			cmp byte[cell32], 0	
			jne print_occupied_cell

			mov byte[last_player], 'C' ;Set como último jogador o 'C'
			mov byte[cell32], 'C' ; Seta na celula 32 a jogada C

			call circle32
			jmp main_loop
	jmp_intermediary_C33:
			cmp byte[cell33], 0	
			jne print_occupied_cell

			mov byte[last_player], 'C' ;Set como último jogador o 'C'
			mov byte[cell33], 'C' ; Seta na celula 33 a jogada C

			call circle33
			jmp main_loop
print_occupied_cell:
	push ax
	push bx
	push cx
	push dx

		mov				bx, 0
		mov			  cx, 14 								;Carrega o tamanho da string em CX
		mov     	dh, 28								;linha 0-29
		mov     	dl, 21								;coluna 0-79
		mov		byte[cor],vermelho
		
		loop_teste:
			call		cursor
			mov     al,	[bx+string_occupied_cell]
			call		caracter
			inc     bx			;proximo caracter
			inc			dl			;avanca a coluna
			
		loop    loop_teste
	
	pop dx
	pop cx
	pop bx
	pop ax

	jmp main_loop
jmp_intermediary_X1:
		mov bx, 4
		mov al,[bx+key_jogada]
		sub al, '0'

		;compara coluna da jogada com 1 
		cmp al, 1
		je jmp_intermediary_X11

		;compara coluna da jogada com 2
		cmp al, 2
		je jmp_intermediary_X12

		;compara coluna da jogada com 3
		cmp al, 3
		je jmp_intermediary_X13

		jmp main_loop
	jmp_intermediary_X11:
			cmp byte[cell11], 0	
			jne print_occupied_cell

			mov byte[last_player], 'X' ;Set como último jogador o 'X'
			mov byte[cell11], 'X' ; Seta na celula 11 a jogada 'X'

			call x11
			jmp main_loop
	jmp_intermediary_X12:
			cmp byte[cell12], 0	
			jne print_occupied_cell

			mov byte[last_player], 'X' ;Set como último jogador o 'X'
			mov byte[cell12], 'X' ; Seta na celula 12 a jogada 'X'

			call x12
			jmp main_loop
	jmp_intermediary_X13:
			cmp byte[cell13], 0	
			jne print_occupied_cell

			mov byte[last_player], 'X' ;Set como último jogador o 'X'
			mov byte[cell13], 'X' ; Seta na celula 13 a jogada 'X'

			call x13
			jmp main_loop
jmp_intermediary_X2:
		mov bx, 4
		mov al,[bx+key_jogada]
		sub al, '0'

		;compara coluna da jogada com 1 
		cmp al, 1
		je jmp_intermediary_X21

		;compara coluna da jogada com 2
		cmp al, 2
		je jmp_intermediary_X22

		;compara coluna da jogada com 3
		cmp al, 3
		je jmp_intermediary_X23

		jmp main_loop
	jmp_intermediary_X21:
			cmp byte[cell21], 0	
			jne jmp_bridge_2_print_occupied_cell

			mov byte[last_player], 'X' ;Set como último jogador o 'X'
			mov byte[cell21], 'X' ; Seta na celula 21 a jogada 'X'
			
			call x21
			jmp main_loop
	jmp_bridge_2_print_occupied_cell:
		call print_occupied_cell
	jmp_intermediary_X22:
			cmp byte[cell22], 0	
			jne jmp_bridge_2_print_occupied_cell

			mov byte[last_player], 'X' ;Set como último jogador o 'X'
			mov byte[cell22], 'X' ; Seta na celula 22 a jogada 'X'

			call x22
			jmp main_loop
	jmp_intermediary_X23:
			cmp byte[cell23], 0	
			jne jmp_bridge_2_print_occupied_cell

			mov byte[last_player], 'X' ;Set como último jogador o 'X'
			mov byte[cell23], 'X' ; Seta na celula 23 a jogada 'X'

			call x23
			jmp main_loop

jmp_intermediary_X3:
		mov bx, 4
		mov al,[bx+key_jogada]
		sub al, '0'

		;compara coluna da jogada com 1 
		cmp al, 1
		je jmp_intermediary_X31

		;compara coluna da jogada com 2
		cmp al, 2
		je jmp_intermediary_X32

		;compara coluna da jogada com 3
		cmp al, 3
		je jmp_intermediary_X33

		jmp main_loop
	jmp_intermediary_X31:
			cmp byte[cell31], 0	
			jne jmp_bridge_2_print_occupied_cell

			mov byte[last_player], 'X' ;Set como último jogador o 'X'
			mov byte[cell31], 'X' ; Seta na celula 31 a jogada 'X'

			call x31
			jmp main_loop
	jmp_intermediary_X32:
			cmp byte[cell32], 0	
			jne jmp_bridge_2_print_occupied_cell

			mov byte[last_player], 'X' ;Set como último jogador o 'X'
			mov byte[cell32], 'X' ; Seta na celula 32 a jogada 'X'
			call x32
			jmp main_loop
	jmp_intermediary_X33:
			cmp byte[cell33], 0	
			jne jmp_bridge_2_print_occupied_cell

			mov byte[last_player], 'X' ;Set como último jogador o 'X'
			mov byte[cell33], 'X' ; Seta na celula 33 a jogada 'X'

			call x33
			jmp main_loop
;Desenhar circulos 
  circle11:
		pushf
		push 		ax

		mov		ax,182
		push		ax
		mov		ax,406
		push		ax
		mov		ax,35
		push		ax		
		call	circle
		
		pop		ax
		popf
		ret

  circle12:
		pushf
		push ax

		mov		ax,308
		push		ax
		mov		ax,406
		push		ax
		mov		ax,35
		push		ax
		call	circle

		pop ax
		popf
		ret 	

  circle13:
		pushf
		push ax

		mov		ax,434
		push		ax
		mov		ax,406
		push		ax
		mov		ax,35
		push		ax
		call	circle

		pop ax
		popf
		ret 
	circle21:
		pushf
		push ax

		mov		ax,182
		push		ax
		mov		ax,280
		push		ax
		mov		ax,35
		push		ax
		call	circle

		pop ax
		popf
		ret

  circle22:
		pushf
		push ax

		mov		ax,308
		push		ax
		mov		ax,280
		push		ax
		mov		ax,35
		push		ax
		call	circle

		pop ax
		popf
		ret

  circle23:
		pushf
		push ax

		mov		ax,434
		push		ax
		mov		ax,280
		push		ax
		mov		ax,35
		push		ax
		call	circle
		
		pop ax
		popf
		ret
	circle31:
		pushf
		push ax

		mov		ax,182
		push		ax
		mov		ax,153
		push		ax
		mov		ax,35
		push		ax
		call	circle
		
		pop ax
		popf
		ret 

  circle32:
		pushf
		push ax

		mov		ax,308
		push		ax
		mov		ax,153
		push		ax
		mov		ax,35
		push		ax
		call	circle

		pop ax
		popf
		ret

  circle33:
		pushf
		push ax

		mov		ax,434
		push		ax
		mov		ax,153
		push		ax
		mov		ax,35
		push		ax
		call	circle
		
		pop ax
		popf
		ret		

;Desenhar x's
  x11:
		mov		ax,159
		push		ax
		mov		ax,431
		push		ax
		mov		ax,206
		push		ax
		mov		ax,382
		push		ax
		call		line
		
		mov		ax,206
		push		ax
		mov		ax,431
		push		ax
		mov		ax,159
		push		ax
		mov		ax,382
		push		ax
		call		line
		ret

  x12:
		mov		ax,285
		push		ax
		mov		ax,431
		push		ax
		mov		ax,332
		push		ax
		mov		ax,382
		push		ax
		call		line
			
		mov		ax,332
		push		ax
		mov		ax,431
		push		ax
		mov		ax,285
		push		ax
		mov		ax,382
		push		ax
		call		line
		ret

  x13:
		mov		ax,411
		push		ax
		mov		ax,431
		push		ax
		mov		ax,458
		push		ax
		mov		ax,382
		push		ax
		call		line
	
		mov		ax,458
		push		ax
		mov		ax,431
		push		ax
		mov		ax,411
		push		ax
		mov		ax,382
		push		ax
		call		line
		ret
  
	x21:
		mov		ax,159
		push		ax
		mov		ax,304
		push		ax
		mov		ax,206
		push		ax
		mov		ax,255
		push		ax
		call		line

		mov		ax,206
		push		ax
		mov		ax,304
		push		ax
		mov		ax,159
		push		ax
		mov		ax,255
		push		ax
		call		line
		ret
  
	x22:
		mov		ax,285
		push		ax
		mov		ax,304
		push		ax
		mov		ax,332
		push		ax
		mov		ax,255
		push		ax
		call		line

		mov		ax,332
		push		ax
		mov		ax,304
		push		ax
		mov		ax,285
		push		ax
		mov		ax,255
		push		ax
		call		line
		ret
  
	x23:
		mov		ax,411
		push		ax
		mov		ax,304
		push		ax
		mov		ax,458
		push		ax
		mov		ax,255
		push		ax
		call		line
	
		mov		ax,458
		push		ax
		mov		ax,304
		push		ax
		mov		ax,411
		push		ax
		mov		ax,255
		push		ax
		call		line
		ret
  
	x31:	
		mov		ax,159
		push		ax
		mov		ax,129
		push		ax
		mov		ax,206
		push		ax
		mov		ax,178
		push		ax
		call		line
		
		mov		ax,206
		push		ax
		mov		ax,129
		push		ax
		mov		ax,159
		push		ax
		mov		ax,178
		push		ax
		call		line
		ret
  
	x32:
		mov		ax,285
		push		ax
		mov		ax,129
		push		ax
		mov		ax,332
		push		ax
		mov		ax,178
		push		ax
		call		line
	
		mov		ax,332
		push		ax
		mov		ax,129
		push		ax
		mov		ax,285
		push		ax
		mov		ax,178
		push		ax
		call		line
		ret
  
	x33:	
		mov		ax,411
		push		ax
		mov		ax,129
		push		ax
		mov		ax,458
		push		ax
		mov		ax,178
		push		ax
		call		line
	
		mov		ax,458
		push		ax
		mov		ax,129
		push		ax
		mov		ax,411
		push		ax
		mov		ax,178
		push		ax
		call		line
		ret

clear_terminal:
	push	bx
	push	ax

	mov 			bx, 0
	mov     	cx, 4			;n�mero de caracteres
	mov 			dh, 8 ;linha 0-29
	mov 			dl, 1 ;coluna 0-79
	mov		byte[cor],branco_intenso
		
	lclear_terminal:
		call	cursor
		mov     al,[bx+string_empty_terminal]
		call	caracter
		inc     bx			;proximo caracter
		inc			dl			;avanca a coluna
		loop    lclear_terminal

	pop	ax
	pop bx
	ret
		
check_if_anyone_won:
	; Checa para a linha 1
		cmp byte[cell11], 'C' ;Verifica se cell11 é igual a C
		je step_11

		return_12:

		cmp byte[cell12], 'C'; Verifica se a cell12 é igual a C
		je step_12

		return_13:

		cmp byte[cell13], 'C'; Verifica se a cell13 é igual a C
		je step_13  	

		jmp main_loop

		step_11:
			cmp byte[cell12], 'C'; Verifica se cell 12 é igual a C
			je step_11_12
			return_11_12:

			cmp byte[cell21], 'C'; Verifica se cell 21 é igual a C
			je step_11_21
			return_11_21:

			cmp byte[cell22], 'C'; Verifica se a cell 22 é igual a C
			je step_11_22
			return_11_22:

			jmp return_12

			step_11_12:
				cmp byte[cell13], 'C'			; Verifica se cell 13 também é igual a C
				je step_11_12_13					; Se for, chama a última etapa dessa sequencia
				jmp main_loop;

				step_11_12_13: 
					mov	 byte[cor],azul_claro 
					call SVL1													;Imprime a linha 1
					mov byte[victorious_player], 'C'	;Defini como vitorioso o jogador 'C'
					call print_victory_for_player_C
					jmp main_loop;										

			step_11_21:
				cmp byte[cell31], 'C'; Verifica se a cell 31 também é igual a C
				je jmp_bridge_SVC1   ; Se for, imprime a coluna 1
				jmp main_loop;
				jmp_bridge_SVC1:
					call SVC1
			step_11_22:
				cmp byte[cell33], 'C'; Verifica se a cell 33 também é igual a C
				je jmp_bridge_SVD1 				; Se for, imprime a primeira diagonal
				jmp main_loop;
			
				jmp_bridge_SVD1:
					call SVD1
		step_12:
			cmp byte[cell22], 'C'; Verifica se cell22 é igual a C
			je step_12_22
			jmp return_13

			step_12_22:
				cmp byte[cell32], 'C' ;Verifica se a cell32 tammbém é a igual 'C'
				je jmp_bridge_SVC2         ;Se for, imprime a coluna 2
				jmp main_loop;

				jmp_bridge_SVC2:
					call SVC2
		step_13:
			cmp byte[cell23], 'C'; Verifica se cell23 é igual a C
			je step_13_23

			cmp byte[cell22], 'C'; Verifica se a cell22 é igual a C
			je step_13_22  

			jmp return_3

			step_13_23:
				cmp byte[cell33], 'C' ;Verifica se a cell33 tammbém é a igual 'C'
				je  jmp_bridge_SVC3         ;Se for, imprime a coluna 3
				jmp main_loop

				jmp_bridge_SVC3:
					call SVC3				
			step_13_22:
				cmp byte[cell31], 'C' ;Verifica se a cell31 tammbém é a igual 'C'
				je  jmp_bridge_SVD2         ;Se for, imprime a diagonal 2
				jmp main_loop
				
				jmp_bridge_SVD2:
					call SVD2	
	;Checa para a linha 2
		return_3:

	jmp main_loop 
	; CHECA PARA X
;Desenhar linha da seguencia vencedora
  ;Sequencia linha 1
    SVL1:
      mov		ax,119
      push		ax
      mov		ax,406
      push		ax
      mov		ax,498
      push		ax
      mov		ax,406
      push		ax
      call		line
			ret 
  ;Sequencia linha 2
    SVL2:
        mov		byte[cor],azul_claro	
        mov		ax,119
        push		ax
        mov		ax,280
        push		ax
        mov		ax,498
        push		ax
        mov		ax,280
        push		ax
        call		line
				ret
  ;Sequencia linha 3
    SVL3:
        mov		byte[cor],azul_claro	
        mov		ax,119
        push		ax
        mov		ax,153
        push		ax
        mov		ax,498
        push		ax
        mov		ax,153
        push		ax
        call		line
				ret
  ;Sequencia coluna 1
	 SVC1:
      mov		byte[cor],azul_claro	
      mov		ax,182
      push		ax
      mov		ax,469
      push		ax
      mov		ax,182
      push		ax
      mov		ax,90
      push		ax
      call		line
			ret
	;Sequencia coluna 2
		SVC2:
      mov		byte[cor],azul_claro	
      mov		ax,308
      push		ax
      mov		ax,469
      push		ax
      mov		ax,308
      push		ax
      mov		ax,90
      push		ax
      call		line
			ret
  ;Sequencia coluna 3
		SVC3:
				mov		byte[cor],azul_claro	
				mov		ax,434
				push		ax
				mov		ax,469
				push		ax
				mov		ax,434
				push		ax
				mov		ax,90
				push		ax
				call		line
				ret
  ;Sequencia diagonal 1
		SVD1:
			mov		byte[cor],azul_claro	
			mov		ax,119
			push		ax
			mov		ax,469
			push		ax
			mov		ax,497
			push		ax
			mov		ax,91
			push		ax
			call		line
			ret
  ;Sequencia diagonal 2
		SVD2:
			mov		byte[cor],azul_claro	
			mov		ax,497
			push		ax
			mov		ax,469
			push		ax
			mov		ax,119
			push		ax
			mov		ax,91
			push		ax
			call		line
			ret
	;Imprime jogadores que venceu
		print_victory_for_player_C:
			mov 			bx, 0
			mov			  cx, 19 								;Carrega o tamanho da string em CX
			mov     	dh, 28								;linha 0-29
			mov     	dl, 21								;coluna 0-79
			mov		byte[cor],verde
			
			loop_print_victory_for_player_C:
				call		cursor
				mov     al,	[bx+string_player_C_victory]
				call		caracter
				inc     bx			;proximo caracter
				inc			dl			;avanca a coluna
				
			loop    loop_print_victory_for_player_C
			ret
	



;***************************************************************************
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
;
;escreve os nomes dos campos de comando e mensagem

;escreve numeros das cells do jogo da velha
_____________________________________________________________________________
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
;_____________________________________________________________________________
;
;   fun��o plot_xy
;
; push x; push y; call plot_xy;  (x<639, y<479)
; cor definida na variavel cor
plot_xy:
		push		bp
		mov		bp,sp
		pushf
		push 		ax
		push 		bx
		push		cx
		push		dx
		push		si
		push		di
	    mov     	ah,0ch
	    mov     	al,[cor]
	    mov     	bh,0
	    mov     	dx,479
		sub		dx,[bp+4]
	    mov     	cx,[bp+6]
	    int     	10h
		pop		di
		pop		si
		pop		dx
		pop		cx
		pop		bx
		pop		ax
		popf
		pop		bp
		ret		4
;_____________________________________________________________________________
;    fun��o circle
;	 push xc; push yc; push r; call circle;  (xc+r<639,yc+r<479)e(xc-r>0,yc-r>0)
; cor definida na variavel cor
circle:
	push 	bp
	mov	 	bp,sp
	pushf                        ;coloca os flags na pilha
	push 	ax
	push 	bx
	push	cx
	push	dx
	push	si
	push	di
	
	mov		ax,[bp+8]    ; resgata xc
	mov		bx,[bp+6]    ; resgata yc
	mov		cx,[bp+4]    ; resgata r
	
	mov 	dx,bx	
	add		dx,cx       ;ponto extremo superior
	push    ax			
	push	dx
	call plot_xy
	
	mov		dx,bx
	sub		dx,cx       ;ponto extremo inferior
	push    ax			
	push	dx
	call plot_xy
	
	mov 	dx,ax	
	add		dx,cx       ;ponto extremo direita
	push    dx			
	push	bx
	call plot_xy
	
	mov		dx,ax
	sub		dx,cx       ;ponto extremo esquerda
	push    dx			
	push	bx
	call plot_xy
		
	mov		di,cx
	sub		di,1	 ;di=r-1
	mov		dx,0  	;dx ser� a vari�vel x. cx � a variavel y
	
;aqui em cima a l�gica foi invertida, 1-r => r-1
;e as compara��es passaram a ser jl => jg, assim garante 
;valores positivos para d

stay:				;loop
	mov		si,di
	cmp		si,0
	jg		inf       ;caso d for menor que 0, seleciona pixel superior (n�o  salta)
	mov		si,dx		;o jl � importante porque trata-se de conta com sinal
	sal		si,1		;multiplica por doi (shift arithmetic left)
	add		si,3
	add		di,si     ;nesse ponto d=d+2*dx+3
	inc		dx		;incrementa dx
	jmp		plotar
inf:	
	mov		si,dx
	sub		si,cx  		;faz x - y (dx-cx), e salva em di 
	sal		si,1
	add		si,5
	add		di,si		;nesse ponto d=d+2*(dx-cx)+5
	inc		dx		;incrementa x (dx)
	dec		cx		;decrementa y (cx)
	
plotar:	
	mov		si,dx
	add		si,ax
	push    si			;coloca a abcisa x+xc na pilha
	mov		si,cx
	add		si,bx
	push    si			;coloca a ordenada y+yc na pilha
	call plot_xy		;toma conta do segundo octante
	mov		si,ax
	add		si,dx
	push    si			;coloca a abcisa xc+x na pilha
	mov		si,bx
	sub		si,cx
	push    si			;coloca a ordenada yc-y na pilha
	call plot_xy		;toma conta do s�timo octante
	mov		si,ax
	add		si,cx
	push    si			;coloca a abcisa xc+y na pilha
	mov		si,bx
	add		si,dx
	push    si			;coloca a ordenada yc+x na pilha
	call plot_xy		;toma conta do segundo octante
	mov		si,ax
	add		si,cx
	push    si			;coloca a abcisa xc+y na pilha
	mov		si,bx
	sub		si,dx
	push    si			;coloca a ordenada yc-x na pilha
	call plot_xy		;toma conta do oitavo octante
	mov		si,ax
	sub		si,dx
	push    si			;coloca a abcisa xc-x na pilha
	mov		si,bx
	add		si,cx
	push    si			;coloca a ordenada yc+y na pilha
	call plot_xy		;toma conta do terceiro octante
	mov		si,ax
	sub		si,dx
	push    si			;coloca a abcisa xc-x na pilha
	mov		si,bx
	sub		si,cx
	push    si			;coloca a ordenada yc-y na pilha
	call plot_xy		;toma conta do sexto octante
	mov		si,ax
	sub		si,cx
	push    si			;coloca a abcisa xc-y na pilha
	mov		si,bx
	sub		si,dx
	push    si			;coloca a ordenada yc-x na pilha
	call plot_xy		;toma conta do quinto octante
	mov		si,ax
	sub		si,cx
	push    si			;coloca a abcisa xc-y na pilha
	mov		si,bx
	add		si,dx
	push    si			;coloca a ordenada yc-x na pilha
	call plot_xy		;toma conta do quarto octante
	
	cmp		cx,dx
	jb		fim_circle  ;se cx (y) est� abaixo de dx (x), termina     
	jmp		stay		;se cx (y) est� acima de dx (x), continua no loop
	
	
fim_circle:
	pop		di
	pop		si
	pop		dx
	pop		cx
	pop		bx
	pop		ax
	popf
	pop		bp
	ret		6
;-----------------------------------------------------------------------------
;    fun��o full_circle
;	 push xc; push yc; push r; call full_circle;  (xc+r<639,yc+r<479)e(xc-r>0,yc-r>0)
; cor definida na variavel cor

full_circle:
	push 	bp
	mov	 	bp,sp
	pushf                        ;coloca os flags na pilha
	push 	ax
	push 	bx
	push	cx
	push	dx
	push	si
	push	di

	mov		ax,[bp+8]    ; resgata xc
	mov		bx,[bp+6]    ; resgata yc
	mov		cx,[bp+4]    ; resgata r
	
	mov		si,bx
	sub		si,cx
	push    ax			;coloca xc na pilha			
	push	si			;coloca yc-r na pilha
	mov		si,bx
	add		si,cx
	push	ax		;coloca xc na pilha
	push	si		;coloca yc+r na pilha
	call line
	
		
	mov		di,cx
	sub		di,1	 ;di=r-1
	mov		dx,0  	;dx ser� a vari�vel x. cx � a variavel y
	
;aqui em cima a l�gica foi invertida, 1-r => r-1
;e as compara��es passaram a ser jl => jg, assim garante 
;valores positivos para d

stay_full:				;loop
	mov		si,di
	cmp		si,0
	jg		inf_full       ;caso d for menor que 0, seleciona pixel superior (n�o  salta)
	mov		si,dx		;o jl � importante porque trata-se de conta com sinal
	sal		si,1		;multiplica por doi (shift arithmetic left)
	add		si,3
	add		di,si     ;nesse ponto d=d+2*dx+3
	inc		dx		;incrementa dx
	jmp		plotar_full
inf_full:	
	mov		si,dx
	sub		si,cx  		;faz x - y (dx-cx), e salva em di 
	sal		si,1
	add		si,5
	add		di,si		;nesse ponto d=d+2*(dx-cx)+5
	inc		dx		;incrementa x (dx)
	dec		cx		;decrementa y (cx)
	
plotar_full:	
	mov		si,ax
	add		si,cx
	push	si		;coloca a abcisa y+xc na pilha			
	mov		si,bx
	sub		si,dx
	push    si		;coloca a ordenada yc-x na pilha
	mov		si,ax
	add		si,cx
	push	si		;coloca a abcisa y+xc na pilha	
	mov		si,bx
	add		si,dx
	push    si		;coloca a ordenada yc+x na pilha	
	call 	line
	
	mov		si,ax
	add		si,dx
	push	si		;coloca a abcisa xc+x na pilha			
	mov		si,bx
	sub		si,cx
	push    si		;coloca a ordenada yc-y na pilha
	mov		si,ax
	add		si,dx
	push	si		;coloca a abcisa xc+x na pilha	
	mov		si,bx
	add		si,cx
	push    si		;coloca a ordenada yc+y na pilha	
	call	line
	
	mov		si,ax
	sub		si,dx
	push	si		;coloca a abcisa xc-x na pilha			
	mov		si,bx
	sub		si,cx
	push    si		;coloca a ordenada yc-y na pilha
	mov		si,ax
	sub		si,dx
	push	si		;coloca a abcisa xc-x na pilha	
	mov		si,bx
	add		si,cx
	push    si		;coloca a ordenada yc+y na pilha	
	call	line
	
	mov		si,ax
	sub		si,cx
	push	si		;coloca a abcisa xc-y na pilha			
	mov		si,bx
	sub		si,dx
	push    si		;coloca a ordenada yc-x na pilha
	mov		si,ax
	sub		si,cx
	push	si		;coloca a abcisa xc-y na pilha	
	mov		si,bx
	add		si,dx
	push    si		;coloca a ordenada yc+x na pilha	
	call	line
	
	cmp		cx,dx
	jb		fim_full_circle  ;se cx (y) est� abaixo de dx (x), termina     
	jmp		stay_full		;se cx (y) est� acima de dx (x), continua no loop
	
	
fim_full_circle:
	pop		di
	pop		si
	pop		dx
	pop		cx
	pop		bx
	pop		ax
	popf
	pop		bp
	ret		6
;-----------------------------------------------------------------------------
;
;   fun��o line
;
; push x1; push y1; push x2; push y2; call line;  (x<639, y<479)
line:
		push		bp
		mov		bp,sp
		pushf                        ;coloca os flags na pilha
		push 		ax
		push 		bx
		push		cx
		push		dx
		push		si
		push		di
		mov		ax,[bp+10]   ; resgata os valores das coordenadas
		mov		bx,[bp+8]    ; resgata os valores das coordenadas
		mov		cx,[bp+6]    ; resgata os valores das coordenadas
		mov		dx,[bp+4]    ; resgata os valores das coordenadas
		cmp		ax,cx
		je		line2
		jb		line1
		xchg		ax,cx
		xchg		bx,dx
		jmp		line1
line2:		; deltax=0
		cmp		bx,dx  ;subtrai dx de bx
		jb		line3
		xchg		bx,dx        ;troca os valores de bx e dx entre eles
line3:	; dx > bx
		push		ax
		push		bx
		call 		plot_xy
		cmp		bx,dx
		jne		line31
		jmp		fim_line
line31:		inc		bx
		jmp		line3
;deltax <>0
line1:
; comparar m�dulos de deltax e deltay sabendo que cx>ax
	; cx > ax
		push		cx
		sub		cx,ax
		mov		[deltax],cx
		pop		cx
		push		dx
		sub		dx,bx
		ja		line32
		neg		dx
line32:		
		mov		[deltay],dx
		pop		dx

		push		ax
		mov		ax,[deltax]
		cmp		ax,[deltay]
		pop		ax
		jb		line5

	; cx > ax e deltax>deltay
		push		cx
		sub		cx,ax
		mov		[deltax],cx
		pop		cx
		push		dx
		sub		dx,bx
		mov		[deltay],dx
		pop		dx

		mov		si,ax
line4:
		push		ax
		push		dx
		push		si
		sub		si,ax	;(x-x1)
		mov		ax,[deltay]
		imul		si
		mov		si,[deltax]		;arredondar
		shr		si,1
; se numerador (DX)>0 soma se <0 subtrai
		cmp		dx,0
		jl		ar1
		add		ax,si
		adc		dx,0
		jmp		arc1
ar1:		sub		ax,si
		sbb		dx,0
arc1:
		idiv		word [deltax]
		add		ax,bx
		pop		si
		push		si
		push		ax
		call		plot_xy
		pop		dx
		pop		ax
		cmp		si,cx
		je		fim_line
		inc		si
		jmp		line4

line5:		cmp		bx,dx
		jb 		line7
		xchg		ax,cx
		xchg		bx,dx
line7:
		push		cx
		sub		cx,ax
		mov		[deltax],cx
		pop		cx
		push		dx
		sub		dx,bx
		mov		[deltay],dx
		pop		dx



		mov		si,bx
line6:
		push		dx
		push		si
		push		ax
		sub		si,bx	;(y-y1)
		mov		ax,[deltax]
		imul		si
		mov		si,[deltay]		;arredondar
		shr		si,1
; se numerador (DX)>0 soma se <0 subtrai
		cmp		dx,0
		jl		ar2
		add		ax,si
		adc		dx,0
		jmp		arc2
ar2:		sub		ax,si
		sbb		dx,0
arc2:
		idiv		word [deltay]
		mov		di,ax
		pop		ax
		add		di,ax
		pop		si
		push		di
		push		si
		call		plot_xy
		pop		dx
		cmp		si,dx
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




;*******************************************************************
segment data

cor		db		branco_intenso

;	I R G B COR
;	0 0 0 0 preto
;	0 0 0 1 azul
;	0 0 1 0 verde
;	0 0 1 1 cyan
;	0 1 0 0 vermelho
;	0 1 0 1 magenta
;	0 1 1 0 marrom
;	0 1 1 1 branco
;	1 0 0 0 cinza
;	1 0 0 1 azul claro
;	1 0 1 0 verde claro
;	1 0 1 1 cyan claro
;	1 1 0 0 rosa
;	1 1 0 1 magenta claro
;	1 1 1 0 amarelo
;	1 1 1 1 branco intenso

;Colors
preto						equ		0
azul						equ		1
verde						equ		2
cyan						equ		3
vermelho				equ		4
magenta					equ		5
marrom					equ		6
branco					equ		7
cinza						equ		8
azul_claro			equ		9
verde_claro			equ		10
cyan_claro			equ		11
rosa						equ		12
magenta_claro		equ		13
amarelo					equ		14
branco_intenso	equ		15

modo_anterior	db	0
linha   	dw  		0
coluna  	dw  		0
deltax		dw			0
deltay		dw			0	

;keys			
key_new_game			db	  'c'
key_jogada				db		20
key_out_game			db		's'  

;Strings
string_terminal					db	'Terminal'
string_game    					db  'JOGO DA VELHA'
string_last_move 				db	'Campo de comando'
string_message   				db  'Campo de mensagens'
string_invalid_command	db 	'Comando Inválido'
string_invalid_play			db 	'Jogada Inválida'
string_occupied_cell    db  'Celula ocupada'
string_empty_terminal		db  '     '
string_invalid_player   db  'O jogador nao pode repetir a jogada'
string_empty_message    db 	'                                   '
string_player_C_victory db  'O jogador C venceu!'

n11 										db  '11'
n12 										db  '12'
n13 										db  '13'
n21 										db  '21'
n22 										db  '22'
n23 										db  '23'
n31 										db  '31'
n32 										db  '32'
n33 										db  '33'

;Variaveis que definem o preenchimento das cells, 0 vazio e 1 preenchido
cell11 db 0
cell12 db 0
cell13 db 0
cell21 db 0
cell22 db 0
cell23 db 0
cell31 db 0
cell32 db 0
cell33 db 0

last_player db 0 ;Última jogador a jogar: 'C' ou 'X'
victorious_player db 0 ;Jogador vencedor da rodada: 'C' ou 'X'

;*************************************************************************
segment stack stack
  resb 		512
				
stacktop:
;NAO PODE JOGAR NO MESMO LUGAR\;

