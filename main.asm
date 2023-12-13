;Aluno: Héber Lima Silva  Turma: 6.1
segment code
..start:
  mov 		ax,data
  mov 		ds,ax
  mov 		ax,stack
  mov 		ss,ax
  mov 		sp,stacktop

;;;;;;;;;;;;;;;Criando tabela de interrupção;;;;;;;;;;;;;;;
  XOR     AX, AX
  MOV     ES, AX
	MOV     AX, [ES:int9*4]           ;carregou AX com offset anterior
  MOV     [offset_dos], AX        ; offset_dos guarda o end. para qual ip de int 9 estava apontando anteriormente
  MOV     AX, [ES:int9*4+2]     ; cs_dos guarda o end. anterior de CS
  MOV     [cs_dos], AX
  CLI     
  MOV     [ES:int9*4+2], CS
  MOV     WORD [ES:int9*4],keyint
  STI
	XOR DI, DI
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

		lopp_print_game_title:
			call	cursor
			mov     al,[bx+string_game]
			call	caracter
			inc     bx			;proximo caracter
			inc		dl			;avanca a coluna
			loop   lopp_print_game_title

	print_shift_status:

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
	call check_is_tied
	return_check_is_tied:
	
	mov dh, 8 ;linha 0-29
	mov dl, 1 ;coluna 0-79
	mov		byte[cor],branco_intenso

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Interrupção acoplada;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	aguarda_teclado:
    mov     ax, [p_i]
    CMP     ax, [p_t]
    JE      aguarda_teclado
    inc     word [p_t]
    and     word [p_t], 7
    mov     bx, [p_t]
    XOR     AX, AX
    MOV     AL, [bx+tecla]
    mov     [tecla_u], al
	;;;;;;;;;;;;;;;;;;;;;Comparações com teclas utéis o jogo;;;;;;;;;;;;;;;;;;;;;;;;
	compare_keys:
		cmp byte[tecla_u], 3AH; CAPSLOCK ON
		je capslock_on

		cmp byte[tecla_u], 0xBA; CAPSLOCK OFF
		je capslock_off

		;cmp byte[tecla_u], 2AH; Compara com a tecla shift
		;je shift_key

    cmp byte[tecla_u], 1CH ; Compara com a tecla 'ENTER'
    je enter_key

    cmp byte[tecla_u], 0EH ; Compara com a tecla 'BACKSPACE'
    je backspace_key

		cmp byte[tecla_u], 39H; Compara com a tecla 'SPACE
  	je space_key
	 	
		jmp compare_numbers
		capslock_on:
			MOV byte[shift_is_on], 1
			JMP     aguarda_teclado
		capslock_off:
			MOV byte[shift_is_on], 0
			JMP     aguarda_teclado

		; shift_key:
		; 	MOV al, byte[shift_is_on]
		; 	XOR al, 1								
		; 	MOV byte[shift_is_on], al
		; 	call check_if_shift_was_pressed
		;   JMP     aguarda_teclado
    enter_key:
      MOV BYTE[ultimo_caracter], 0DH ; 
			MOV DI, 0
      JMP exit_interrupacao
    backspace_key:
      CMP DI, 0
      JNE decrementa_di
      JMP aguarda_teclado
      decrementa_di:
        DEC 		DI
        MOV     byte[key_jogada + DI], ''
        DEC     dl 
        CALL    cursor
        MOV     al,' '
        CALL    caracter

        JMP aguarda_teclado
		space_key:
      MOV BYTE[ultimo_caracter],' '
      JMP salva_tecla_array  
			 	;;;;;;;;;Comparação com números 0 - 9;;;;;;;;;;;;;;;;;;;;;;;;
	compare_numbers:
		cmp byte[tecla_u], 02H
		je one_key

		cmp byte [tecla_u], 4FH
		je one_key 

		cmp byte[tecla_u], 03H
		je two_key

		cmp byte [tecla_u], 50H
		je two_key 

		cmp byte[tecla_u], 04H
		je three_key

		cmp byte [tecla_u], 51H
		je three_key 

		JMP compare_others_keys_1

		one_key:
		  MOV BYTE[ultimo_caracter],'1'
      JMP salva_tecla_array
		two_key:
		  MOV BYTE[ultimo_caracter],'2'
      JMP salva_tecla_array
		three_key:
		  MOV BYTE[ultimo_caracter],'3'
      JMP salva_tecla_array
	;;;;;;;;;;;;;;;;;;;;;;;;Comparações com demais teclas;;;;;;;;;;;;;;;;;;;;;;;;;;
	compare_others_keys_1:
		cmp byte[tecla_u], 29H; Compara com a tecla aspas simples / duplas
		je quotes_key
		
		cmp byte [tecla_u], 0BH; Compara com a tecla 0 
		je zero_key

		cmp byte[tecla_u], 05H; Compara com a tecla 4 
		je four_key

		cmp byte [tecla_u], 06H; Compara com a tecla 5 
		je five_key

		cmp byte [tecla_u], 07H; Compara com a tecla 6 
		je six_key

		cmp byte [tecla_u], 08H; Compara com a tecla 7 
		je seven_key

		cmp byte [tecla_u], 09H; Compara com a tecla 8 
		je eight_key
		
		cmp byte [tecla_u], 0AH; Compara com a tecla 9 
		je nine_key


		cmp byte [tecla_u], 0CH; Compara com a tecla - 
		je jmp_bridge_less_or_underlined_key

		cmp byte [tecla_u], 0DH; Compara com a tecla + 
		je jmp_bridge_equal_or_plus_key

		jmp compare_others_keys_2
		jmp_bridge_less_or_underlined_key:
			call less_or_underlined_key
		jmp_bridge_equal_or_plus_key:
		 	call equal_or_plus_key
		quotes_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE double_quotes_key
      MOV BYTE[ultimo_caracter],'"'
      JMP salva_tecla_array
			double_quotes_key:
				MOV BYTE[ultimo_caracter],'"'
      	JMP salva_tecla_array
		zero_key:
      MOV BYTE[ultimo_caracter],'0'
      JMP salva_tecla_array
		four_key:
      MOV BYTE[ultimo_caracter],'4'
      JMP salva_tecla_array
		five_key:
      MOV BYTE[ultimo_caracter],'5'
      JMP salva_tecla_array

		six_key:
      MOV BYTE[ultimo_caracter],'6'
      JMP salva_tecla_array
		seven_key:
      MOV BYTE[ultimo_caracter],'7'
      JMP salva_tecla_array
	
		eight_key:
      MOV BYTE[ultimo_caracter],'8'
      JMP salva_tecla_array
		nine_key:
      MOV BYTE[ultimo_caracter],'9'
     	JMP salva_tecla_array

		less_or_underlined_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE underlined_key
      MOV BYTE[ultimo_caracter],'-'
      JMP salva_tecla_array
			underlined_key:
				MOV BYTE[ultimo_caracter],'_'
      	JMP salva_tecla_array
		equal_or_plus_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE plus_key
      MOV BYTE[ultimo_caracter],'='
      JMP salva_tecla_array
			plus_key:
				MOV BYTE[ultimo_caracter],'+'
      	JMP salva_tecla_array
	compare_others_keys_2:
		cmp byte[tecla_u], 10H; Compara com a tecla q / Q
		je q_key
		
		cmp byte[tecla_u], 11H; Compara com a tecla w / W
		je w_key

		cmp byte [tecla_u], 12H; Compara com a tecla e / E
		je jmp_bridge_e_key

		cmp byte [tecla_u], 13H; Compara com a tecla r / R
		je jmp_bridge_r_key

		cmp byte [tecla_u], 14H; Compara com a tecla t / T
		je jmp_bridge_t_key

		cmp byte [tecla_u], 15H; Compara com a tecla y / Y
		je jmp_bridge_y_key
		
		cmp byte [tecla_u], 16H; Compara com a tecla u / U
		je jmp_bridge_u_key

		cmp byte [tecla_u], 17H; Compara com a tecla i / I
		je jmp_bridge_i_key

		cmp byte [tecla_u], 18H; Compara com a tecla o / O
		je jmp_bridge_o_key

		cmp byte [tecla_u], 19H; Compara com a tecla p / P
		je jmp_bridge_p_key

		cmp byte [tecla_u], 1AH; Compara com a tecla ´ / `
		je jmp_bridge_crasis_or_acute_accent_key

		cmp byte [tecla_u], 1BH; Compara com a tecla [ / }
		je jmp_bridge_braket_or_keys_key


		
		jmp compare_others_keys_3
		jmp_bridge_e_key:
			call e_key
		jmp_bridge_r_key:
			call r_key
		jmp_bridge_t_key:
			call t_key
		jmp_bridge_y_key:
			call y_key
		jmp_bridge_u_key:
			call u_key
		jmp_bridge_i_key:
			call i_key
		jmp_bridge_o_key:
			call o_key
		jmp_bridge_p_key:
			call p_key
		jmp_bridge_crasis_or_acute_accent_key:
			call crasis_or_acute_accent_key
		jmp_bridge_braket_or_keys_key:
			call braket_or_keys_key
		q_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_q_key
      MOV BYTE[ultimo_caracter],'q'
      JMP salva_tecla_array
			capital_q_key:
				MOV BYTE[ultimo_caracter],'Q'
      	JMP salva_tecla_array
		w_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_w_key
      MOV BYTE[ultimo_caracter],'w'
      JMP salva_tecla_array
			capital_w_key:
				MOV BYTE[ultimo_caracter],'W'
      	JMP salva_tecla_array
		e_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_e_key
      MOV BYTE[ultimo_caracter],'e'
      JMP salva_tecla_array
			capital_e_key:
				MOV BYTE[ultimo_caracter],'E'
      	JMP salva_tecla_array
		r_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_r_key
      MOV BYTE[ultimo_caracter],'r'
      JMP salva_tecla_array
		 capital_r_key:
				MOV BYTE[ultimo_caracter],'R'
      	JMP salva_tecla_array
		t_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_t_key
      MOV BYTE[ultimo_caracter],'t'
      JMP salva_tecla_array
			capital_t_key:
				MOV BYTE[ultimo_caracter],'T'
      	JMP salva_tecla_array
		y_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_y_key
      MOV BYTE[ultimo_caracter],'y'
      JMP salva_tecla_array
			capital_y_key:
				MOV BYTE[ultimo_caracter],'Y'
      	JMP salva_tecla_array
		u_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_u_key
      MOV BYTE[ultimo_caracter],'u'
      JMP salva_tecla_array
			capital_u_key:
				MOV BYTE[ultimo_caracter],'U'
      	JMP salva_tecla_array
		i_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_i_key
      MOV BYTE[ultimo_caracter],'i'
      JMP salva_tecla_array
			capital_i_key:
				MOV BYTE[ultimo_caracter],'I'
      	JMP salva_tecla_array
		o_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_o_key
      MOV BYTE[ultimo_caracter],'o'
      JMP salva_tecla_array
			capital_o_key:
				MOV BYTE[ultimo_caracter],'O'
      	JMP salva_tecla_array
		p_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_p_key
      MOV BYTE[ultimo_caracter],'p'
      JMP salva_tecla_array
			capital_p_key:
				MOV BYTE[ultimo_caracter],'P'
      	JMP salva_tecla_array
		crasis_or_acute_accent_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE acute_accent_key
      MOV BYTE[ultimo_caracter],'`'
      JMP salva_tecla_array
			acute_accent_key:
				MOV BYTE[ultimo_caracter],'`'
      	JMP salva_tecla_array
		braket_or_keys_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE keys_key
      MOV BYTE[ultimo_caracter],'['
      JMP salva_tecla_array
			keys_key:
				MOV BYTE[ultimo_caracter],'{'
      	JMP salva_tecla_array
	compare_others_keys_3:
		cmp byte[tecla_u], 1EH; Compara com a tecla q / Q
		je a_key
		
		cmp byte[tecla_u], 1FH; Compara com a tecla w / W
		je s_key

		cmp byte [tecla_u], 20H; Compara com a tecla e / E
		je jmp_bridge_d_key

		cmp byte [tecla_u], 21H; Compara com a tecla r / R
		je jmp_bridge_f_key

		cmp byte [tecla_u], 22H; Compara com a tecla t / T
		je jmp_bridge_g_key

		cmp byte [tecla_u], 23H; Compara com a tecla y / Y
		je jmp_bridge_h_key
		
		cmp byte [tecla_u], 24H; Compara com a tecla u / U
		je jmp_bridge_j_key

		cmp byte [tecla_u], 25H; Compara com a tecla i / I
		je jmp_bridge_k_key

		cmp byte [tecla_u], 26H; Compara com a tecla o / O
		je jmp_bridge_l_key

		cmp byte [tecla_u], 27H; Compara com a tecla p / P
		je jmp_bridge_ç_key


		;jmp aguarda_teclado
		jmp compare_others_keys_4
		jmp_bridge_d_key:
			call d_key
		jmp_bridge_f_key:
			call f_key
		jmp_bridge_g_key:
			call g_key
		jmp_bridge_h_key:
			call h_key
		jmp_bridge_j_key:
			call j_key
		jmp_bridge_k_key:
			call k_key
		jmp_bridge_l_key:
			call l_key
		jmp_bridge_ç_key:
			call ç_key
		a_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_a_key
      MOV BYTE[ultimo_caracter],'a'
      JMP salva_tecla_array
			capital_a_key:
				MOV BYTE[ultimo_caracter],'A'
      	JMP salva_tecla_array
		s_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_s_key
      MOV BYTE[ultimo_caracter],'s'
      JMP salva_tecla_array
			capital_s_key:
				MOV BYTE[ultimo_caracter],'S'
      	JMP salva_tecla_array
		d_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_d_key
      MOV BYTE[ultimo_caracter],'d'
      JMP salva_tecla_array
			capital_d_key:
				MOV BYTE[ultimo_caracter],'D'
      	JMP salva_tecla_array
		f_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_f_key
      MOV BYTE[ultimo_caracter],'f'
      JMP salva_tecla_array
		 capital_f_key:
				MOV BYTE[ultimo_caracter],'F'
      	JMP salva_tecla_array
		g_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_g_key
      MOV BYTE[ultimo_caracter],'g'
      JMP salva_tecla_array
			capital_g_key:
				MOV BYTE[ultimo_caracter],'G'
      	JMP salva_tecla_array
		h_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_h_key
      MOV BYTE[ultimo_caracter],'h'
      JMP salva_tecla_array
			capital_h_key:
				MOV BYTE[ultimo_caracter],'H'
      	JMP salva_tecla_array
		j_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_j_key
      MOV BYTE[ultimo_caracter],'j'
      JMP salva_tecla_array
			capital_j_key:
				MOV BYTE[ultimo_caracter],'J'
      	JMP salva_tecla_array
		k_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_k_key
      MOV BYTE[ultimo_caracter],'k'
      JMP salva_tecla_array
			capital_k_key:
				MOV BYTE[ultimo_caracter],'K'
      	JMP salva_tecla_array
		l_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_l_key
      MOV BYTE[ultimo_caracter],'l'
      JMP salva_tecla_array
			capital_l_key:
				MOV BYTE[ultimo_caracter],'L'
      	JMP salva_tecla_array
		ç_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_ç_key
      MOV BYTE[ultimo_caracter],'c'
      JMP salva_tecla_array
			capital_ç_key:
				MOV BYTE[ultimo_caracter],'C'
      	JMP salva_tecla_array
	compare_others_keys_4:
		cmp byte[tecla_u], 2CH; Compara com a tecla q / Q
		je z_key
		
		cmp byte[tecla_u], 2DH; Compara com a tecla w / W
		je x_key

		cmp byte [tecla_u], 2EH; Compara com a tecla e / E
		je jmp_bridge_c_key

		cmp byte [tecla_u], 2FH; Compara com a tecla r / R
		je jmp_bridge_v_key

		cmp byte [tecla_u], 30H; Compara com a tecla t / T
		je jmp_bridge_b_key

		cmp byte [tecla_u], 31H; Compara com a tecla y / Y
		je jmp_bridge_n_key
		
		cmp byte [tecla_u], 32H; Compara com a tecla u / U
		je jmp_bridge_m_key

		;jmp aguarda_teclado
		jmp compare_others_keys_5
		jmp_bridge_c_key:
			call c_key
		jmp_bridge_v_key:
			call v_key
		jmp_bridge_b_key:
			call b_key
		jmp_bridge_n_key:
			call n_key
		jmp_bridge_m_key:
			call m_key

		z_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_z_key
      MOV BYTE[ultimo_caracter],'z'
      JMP salva_tecla_array
			capital_z_key:
				MOV BYTE[ultimo_caracter],'Z'
      	JMP salva_tecla_array
		x_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_x_key
      MOV BYTE[ultimo_caracter],'x'
      JMP salva_tecla_array
			capital_x_key:
				MOV BYTE[ultimo_caracter],'X'
      	JMP salva_tecla_array
		c_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_c_key
      MOV BYTE[ultimo_caracter],'c'
      JMP salva_tecla_array
			capital_c_key:
				MOV BYTE[ultimo_caracter],'C'
      	JMP salva_tecla_array
		v_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_v_key
      MOV BYTE[ultimo_caracter],'v'
      JMP salva_tecla_array
		 capital_v_key:
				MOV BYTE[ultimo_caracter],'V'
      	JMP salva_tecla_array
		b_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_b_key
      MOV BYTE[ultimo_caracter],'b'
      JMP salva_tecla_array
			capital_b_key:
				MOV BYTE[ultimo_caracter],'B'
      	JMP salva_tecla_array
		n_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_n_key
      MOV BYTE[ultimo_caracter],'n'
      JMP salva_tecla_array
			capital_n_key:
				MOV BYTE[ultimo_caracter],'N'
      	JMP salva_tecla_array
		m_key:
			CMP BYTE[shift_is_on], 1 ;Verifica se o shift foi clicado
			JE capital_m_key
      MOV BYTE[ultimo_caracter],'m'
      JMP salva_tecla_array
			capital_m_key:
				MOV BYTE[ultimo_caracter],'M'
      	JMP salva_tecla_array
	compare_others_keys_5:
		cmp byte[tecla_u], 52h; Compara com a tecla q / Q
		je zero_numeric_key

		cmp byte[tecla_u], 4fH; Compara com a tecla q / Q
		je one_numeric_key
		
		cmp byte[tecla_u], 50H; Compara com a tecla w / W
		je two_numeric_key

		cmp byte [tecla_u], 51H; Compara com a tecla e / E
		je three_numeric_key

		cmp byte [tecla_u], 4BH; Compara com a tecla r / R
		je four_numeric_key

		cmp byte [tecla_u], 4CH; Compara com a tecla t / T
		je five_numeric_key

		cmp byte [tecla_u], 4DH; Compara com a tecla e / E
		je six_numeric_key

		cmp byte [tecla_u], 47H; Compara com a tecla r / R
		je seven_numeric_key

		cmp byte [tecla_u], 48H; Compara com a tecla t / T
		je eight_numeric_key

		cmp byte [tecla_u], 49H; Compara com a tecla t / T
		je nine_numeric_key

		jmp aguarda_teclado
		zero_numeric_key:
      MOV BYTE[ultimo_caracter],'0'
      JMP salva_tecla_array
		one_numeric_key:
      MOV BYTE[ultimo_caracter],'1'
      JMP salva_tecla_array
		two_numeric_key:
      MOV BYTE[ultimo_caracter],'2'
      JMP salva_tecla_array
		three_numeric_key:
      MOV BYTE[ultimo_caracter],'3'
      JMP salva_tecla_array
		four_numeric_key:
      MOV BYTE[ultimo_caracter],'4'
      JMP salva_tecla_array
		five_numeric_key:
      MOV BYTE[ultimo_caracter],'5'
      JMP salva_tecla_array
		six_numeric_key:
      MOV BYTE[ultimo_caracter],'6'
      JMP salva_tecla_array
		seven_numeric_key:
      MOV BYTE[ultimo_caracter],'7'
      JMP salva_tecla_array
		eight_numeric_key:
      MOV BYTE[ultimo_caracter],'8'
      JMP salva_tecla_array
		nine_numeric_key:
      MOV BYTE[ultimo_caracter],'9'
      JMP salva_tecla_array

	salva_tecla_array:
  ;Se não for menor que 4 volta até pressinar backspace para permitir o enter
  CMP DI, 4
  JGE jmp_bridge_aguarda_teclado 
	
  ;Salva caracter no array de jogadas
	MOV AL, BYTE[ultimo_caracter]
  MOV [key_jogada + DI], AL ; Salva ultima tecla no vetor de jogadas
	
	;Imprime caracter
	call    cursor
  call    caracter

	;Incrementa índice da jogada e coluna do terminal
	INC DI
	INC DL
  jmp_bridge_aguarda_teclado: 
  	JMP aguarda_teclado; Volta para receber mais jogadas
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	exit_interrupacao:
	;Limpa campo de mensagem
	call clear_message_field
	;Limpa terminal onde foi digitado o comando
	call clear_terminal

	; cmp byte[victorious_player], 0
	; jne jmp_bridge_novo_jogo

	call print_last_command
	
	mov bx, 0 ;2
	mov al, 'c'
	cmp al, [key_jogada + bx] ; compara a primeira letra da string com 'c'
	je	jmp_bridge_novo_jogo ; caso seja igual a 'c' começa um novo jogo
		
	mov al, 's'
	cmp al, [key_jogada] ; compara a primeira letra da string com 's'
	je	jmp_bridge_exit_game ; caso seja igual a 's', saia do programa

	cmp byte[victorious_player], 0
	jne jogo_encerrado
	
	cmp byte[is_tied], 1
	je jogo_encerrado

	mov al, 'C'
	cmp al, [key_jogada + bx] ; compara a primeira letra da string com 'C'
	je jmp_bridge_jogada_circulo ; caso seja igual a 'C' pule para a jogada_circulo
	
	mov al, 'X'
	cmp al, [key_jogada + bx] ; compara a primeira letra da string com X
	je jmp_bridge_2_jogada_x	 ; caso seja igual a 'X' pule para a jogada_circulo




	jmp command_invalid
	jmp_bridge_2_jogada_x:
		call jogada_x
	jmp_bridge_exit_game:
		call exit_game
jmp_bridge_jogada_circulo:
	call jogada_circulo
jogo_encerrado:
	call clear_command_field ; Apaga comando

	mov 			bx, 0
	mov			  cx, 51 								;Carrega o tamanho da string em CX
	mov     	dh, 28								;linha 0-29
	mov     	dl, 21								;coluna 0-79
	mov		byte[cor],amarelo
		
	loop_jogo_encerrado:
		call		cursor
		mov     al,	[bx+string_final_message]
		call		caracter
		inc     bx			;proximo caracter
		inc			dl			;avanca a coluna
			
	loop    loop_jogo_encerrado
	jmp main_loop

jmp_bridge_novo_jogo:
	call novo_jogo
print_last_command:
	push dx
	mov 			bx, 0
	mov			  cx, 3 ; Carrega o tamanho da string em CX
	mov     	dh,26								;linha 0-29
	mov     	dl,19								;coluna 0-79
	mov		byte[cor],branco_intenso
	
	loop_print_last_command:
		call		cursor
		mov     al,	[key_jogada+bx]
		call		caracter
		inc     bx			;proximo caracter
		inc			dl			;avanca a coluna
		
	loop    loop_print_last_command
	pop dx
	ret
check_if_shift_was_pressed:
	push dx
	mov 			bx, 0
	mov			  cx, 17 ; Carrega o tamanho da string em CX
	mov     	dh, 0								;linha 0-29
	mov     	dl, 62								;coluna 0-79
	mov		byte[cor],branco_intenso
		
	MOV al, byte[shift_is_on]
	CMP AL, 1
	JE loop_print_shift_is_on

	loop_print_shift_is_off:
		call		cursor
		mov     al,	[string_shift_off + bx]
		call		caracter
		inc     bx			;proximo caracter
		inc			dl			;avanca a coluna

	loop loop_print_shift_is_off
	pop dx
	ret

	loop_print_shift_is_on:
		call		cursor
		mov     al,	[string_shift_on + bx]
		call		caracter
		inc     bx			;proximo caracter
		inc			dl			;avanca a coluna
		
	loop    loop_print_shift_is_on
	pop dx
	ret

	
exit_game:
  CLI
  XOR     AX, AX
	MOV     ES, AX
  MOV     AX, [cs_dos]
  MOV     [ES:int9*4+2], AX
  MOV     AX, [offset_dos]
  MOV     [ES:int9*4], AX 
	;call clear_command_field  ;Limpa campo de comando
	;int     21h
  mov  		ah,0   			; set video mode
  mov  		al,[modo_anterior]   	; modo anterior
  int  		10h
	mov     ax,4c00h
	int     21h
command_invalid:
	push dx
	call clear_command_field ; Apaga comando

	mov 			bx, 0
	mov			  cx, 16 								;Carrega o tamanho da string em CX
	mov     	dh, 28								;linha 0-29
	mov     	dl, 21								;coluna 0-79
	mov		byte[cor],vermelho
		
	loop_command_invalid:
		call		cursor
		mov     al,	[bx+string_invalid_command]
		call		caracter
		inc     bx			;proximo caracter
		inc			dl			;avanca a coluna
			
	loop    loop_command_invalid
	pop dx
	jmp main_loop

jmp_bridge_jogada_x:
	call jogada_x


check_is_tied:
		cmp byte[is_tied], 1 
		je jmp_bridge_return_check_is_tied

		cmp byte[cell11], 0
		je jmp_bridge_return_check_is_tied

		cmp byte[cell12], 0
		je jmp_bridge_return_check_is_tied

		cmp byte[cell13], 0
		je jmp_bridge_return_check_is_tied

		cmp byte[cell21], 0
		je jmp_bridge_return_check_is_tied

		cmp byte[cell22], 0
		je jmp_bridge_return_check_is_tied

		cmp byte[cell23], 0
		je jmp_bridge_return_check_is_tied

		cmp byte[cell31], 0
		je jmp_bridge_return_check_is_tied

		cmp byte[cell32], 0
		je jmp_bridge_return_check_is_tied

		cmp byte[cell33], 0
		je jmp_bridge_return_check_is_tied

		cmp byte[victorious_player], 0
		jne jmp_bridge_return_check_is_tied

		mov byte[is_tied], 1
		call print_tied

		jmp return_check_is_tied
jmp_bridge_return_check_is_tied:
	jmp return_check_is_tied
novo_jogo:
		call clear_command_field ;Limpa o campo de comando

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
		call SVL2
		call SVL3
		call SVC1
		call SVC2
		call SVC3
		call SVD1
		call SVD2
		
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

		;LIMPA REGISTROS DE ÚLTIMA JOGADA 
		mov byte[last_player], 0
		mov byte[victorious_player], 0	
		mov byte[is_tied], 0
		
		jmp print_tic_tac_toe;
		;;limpa jogas na tela

clear_message_field:
	push dx
	;Limpa campo de mensagem
		mov 			bx, 0
		mov			  cx, 51 								;Carrega o tamanho da string em CX
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
		pop dx
	ret
clear_command_field:
	push dx
	mov 			bx, 0
	mov			  cx, 3 							;carrega o tamanho da string em CX
	mov     	dh,26								;linha 0-29
	mov     	dl,19								;coluna 0-79
	mov		byte[cor],preto
	
	loop_clear_command_field:
		call		cursor
		mov     al,	[bx+string_empty_command]
		call		caracter
		inc     bx			;proximo caracter
		inc			dl			;avanca a coluna
		
	loop    loop_clear_command_field
	pop dx
	ret
jogada_circulo:
		mov al, [last_player]
		cmp al, 'C'
		je jogada_repetida

		mov		byte[cor],verde_claro	 ; seleciona a cord verde claro para círculo
		
		mov bx, 1
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

		jmp command_invalid	
		jmp_bridge_c2:
			call jmp_intermediary_C2
		jmp_bridge_c3:
			call jmp_intermediary_C3

jogada_x:	
		mov al, [last_player]
		cmp al, 'X'
		je jogada_repetida
		
		mov	byte[cor],rosa

		mov bx, 1
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

		jmp command_invalid	

		jmp_bridge_x1:
			call jmp_intermediary_X1
		jmp_bridge_x2:
			call jmp_intermediary_X2
		jmp_bridge_x3:
			call jmp_intermediary_X3
jogada_repetida:
	;Imprime mensagem de jogada repetida na barra de mensagem
	mov 			bx, 0
	mov			  cx, 15 								;Carrega o tamanho da string em CX
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
		mov bx, 2
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
		
		jmp command_invalid
	jmp_intermediary_C11:
			cmp byte[cell11], 0	
			jne jmp_bridge_print_occupied_cell

			mov byte[last_player], 'C' 			;Set como último jogador o 'C'
		  mov byte[cell11], 'C' 					;Seta na celula 11 a jogada C

			call circle11
			call check_if_C_won 				;Checa se alguém ganhou
			jmp main_loop
		jmp_bridge_print_occupied_cell: ;ponte para a função principal
			call print_occupied_cell
	jmp_intermediary_C12:	
			cmp byte[cell12], 0	
			jne jmp_bridge_print_occupied_cell

			mov byte[last_player], 'C' 			;Set como último jogador o 'C'
			mov byte[cell12], 'C' 					;Seta na celula 12 a jogada C

			call circle12
			call check_if_C_won 				;Checa se alguém ganhou

			jmp main_loop
	jmp_intermediary_C13:
			cmp byte[cell13], 0
			jne jmp_bridge_print_occupied_cell

			mov byte[last_player], 'C' 			;Set como último jogador o 'C'
			mov byte[cell13], 'C' 					;Seta na celula 13 a jogada C

			call circle13
			call check_if_C_won 				;Checa se alguém ganhou
			jmp main_loop
jmp_intermediary_C2:
		mov bx, 2
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

	  jmp command_invalid
	jmp_intermediary_C21:
			cmp byte[cell21], 0	
			jne jmp_bridge_print_occupied_cell

			mov byte[last_player], 'C' 			;Set como último jogador o 'C'
			mov byte[cell21], 'C' 					;Seta na celula 21 a jogada C

			call circle21
			call check_if_C_won 				;Checa se alguém ganhou
			jmp main_loop
	jmp_intermediary_C22:
			cmp byte[cell22], 0	
			jne jmp_bridge_print_occupied_cell

			mov byte[last_player], 'C' 			;Set como último jogador o 'C'
			mov byte[cell22], 'C' 					;Seta na celula 22 a jogada C

			call circle22
			call check_if_C_won 				;Checa se alguém ganhou
			jmp main_loop
	jmp_intermediary_C23:
			cmp byte[cell23], 0	
			jne jmp_bridge_3_print_occupied_cell

			mov byte[last_player], 'C' 			;Set como último jogador o 'C'
			mov byte[cell23], 'C' 					;Seta na celula 23 a jogada C

			call circle23
	  ganhou								
			call check_if_C_won 				;Checa se alguém ganhou
			jmp main_loop

			jmp_bridge_3_print_occupied_cell:
				call print_occupied_cell
jmp_intermediary_C3:
		mov bx, 2
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

	 jmp command_invalid

	jmp_intermediary_C31:
			cmp byte[cell31], 0	
			jne print_occupied_cell

			mov byte[last_player], 'C' 			;Set como último jogador o 'C'
			mov byte[cell31], 'C' 					;Seta na celula 31 a jogada C

			call circle31
			call check_if_C_won 				;Checa se alguém ganhou
			jmp main_loop
	jmp_intermediary_C32:
			cmp byte[cell32], 0	
			jne print_occupied_cell

			mov byte[last_player], 'C' 			;Set como último jogador o 'C'
			mov byte[cell32], 'C' 					;Seta na celula 32 a jogada C

			call circle32
			call check_if_C_won 				;Checa se alguém ganhou
			jmp main_loop
	jmp_intermediary_C33:
			cmp byte[cell33], 0	
			jne print_occupied_cell

			mov byte[last_player], 'C' 			;Set como último jogador o 'C'
			mov byte[cell33], 'C' 					;Seta na celula 33 a jogada C

			call circle33
			call check_if_C_won 				;Checa se alguém ganhou
			jmp main_loop
print_occupied_cell:
	push ax
	push bx
	push cx
	push dx

		mov				bx, 0
		mov			  cx, 15 								;Carrega o tamanho da string em CX
		mov     	dh, 28								;linha 0-29
		mov     	dl, 21								;coluna 0-79
		mov		byte[cor],vermelho
		
		loop_print_occupied_cell:
			call		cursor
			mov     al,	[bx+string_occupied_cell]
			call		caracter
			inc     bx			;proximo caracter
			inc			dl			;avanca a colunaS
			
		loop    loop_print_occupied_cell
	
	pop dx
	pop cx
	pop bx
	pop ax

	jmp main_loop
jmp_intermediary_X1:
		mov bx, 2
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

		jmp command_invalid
	jmp_intermediary_X11:
			cmp byte[cell11], 0	
			jne print_occupied_cell

			mov byte[last_player], 'X' ;Set como último jogador o 'X'
			mov byte[cell11], 'X' ; Seta na celula 11 a jogada 'X'

			call x11
			call check_if_X_won
			jmp main_loop
	jmp_intermediary_X12:
			cmp byte[cell12], 0	
			jne print_occupied_cell

			mov byte[last_player], 'X' ;Set como último jogador o 'X'
			mov byte[cell12], 'X' ; Seta na celula 12 a jogada 'X'

			call x12
			call check_if_X_won
			jmp main_loop
	jmp_intermediary_X13:
			cmp byte[cell13], 0	
			jne print_occupied_cell

			mov byte[last_player], 'X' ;Set como último jogador o 'X'
			mov byte[cell13], 'X' ; Seta na celula 13 a jogada 'X'

			call x13
			call check_if_X_won
			jmp main_loop
jmp_intermediary_X2:
		mov bx, 2
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

		jmp command_invalid
	jmp_intermediary_X21:
			cmp byte[cell21], 0	
			jne jmp_bridge_2_print_occupied_cell

			mov byte[last_player], 'X' ;Set como último jogador o 'X'
			mov byte[cell21], 'X' ; Seta na celula 21 a jogada 'X'
			
			call x21
			call check_if_X_won
			jmp main_loop
	jmp_bridge_2_print_occupied_cell:
		call print_occupied_cell
	jmp_intermediary_X22:
			cmp byte[cell22], 0	
			jne jmp_bridge_2_print_occupied_cell

			mov byte[last_player], 'X' ;Set como último jogador o 'X'
			mov byte[cell22], 'X' ; Seta na celula 22 a jogada 'X'

			call x22
			call check_if_X_won
			jmp main_loop
	jmp_intermediary_X23:
			cmp byte[cell23], 0	
			jne jmp_bridge_2_print_occupied_cell

			mov byte[last_player], 'X' ;Set como último jogador o 'X'
			mov byte[cell23], 'X' ; Seta na celula 23 a jogada 'X'

			call x23
			call check_if_X_won
			jmp main_loop

jmp_intermediary_X3:
		mov bx, 2
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

		jmp command_invalid
	jmp_intermediary_X31:
			cmp byte[cell31], 0	
			jne jmp_bridge_2_print_occupied_cell

			mov byte[last_player], 'X' ;Set como último jogador o 'X'
			mov byte[cell31], 'X' ; Seta na celula 31 a jogada 'X'

			call x31
			call check_if_X_won
			jmp main_loop
	jmp_intermediary_X32:
			cmp byte[cell32], 0	
			jne jmp_bridge_2_print_occupied_cell

			mov byte[last_player], 'X' ;Set como último jogador o 'X'
			mov byte[cell32], 'X' ; Seta na celula 32 a jogada 'X'
			
			call x32
			call check_if_X_won
			jmp main_loop
	jmp_intermediary_X33:
			cmp byte[cell33], 0	
			jne jmp_bridge_4_print_occupied_cell

			mov byte[last_player], 'X' ;Set como último jogador o 'X'
			mov byte[cell33], 'X' ; Seta na celula 33 a jogada 'X'

			call x33
			call check_if_X_won
			jmp main_loop
			jmp_bridge_4_print_occupied_cell:
				call print_occupied_cell
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
		
check_if_C_won:
	; Checa para a linha 1
		cmp byte[cell11], 'C' 										;Verifica se cell11 é igual a C
		je step_11												
		return_11:

		cmp byte[cell12], 'C'											;Verifica se a cell12 é igual a C
		je jmp_bridge_step_12
		return_12:

		cmp byte[cell13], 'C'											;Verifica se a cell13 é igual a C
		je jmp_bridge_step_13 
		return_13:

		cmp byte[cell21], 'C'											;Verifica se a cell13 é igual a C
		je jmp_bridge_step_21 
		return_21:

		cmp byte[cell31], 'C'											;Verifica se a cell13 é igual a C
		je jmp_bridge_step_31 
		return_31:

		jmp main_loop
		jmp_bridge_step_12:
			call step_12

		jmp_bridge_step_13:
			call step_13

		jmp_bridge_step_21:
			call step_21

		jmp_bridge_step_31:
			call step_31
		
		step_11:
			cmp byte[cell12], 'C'										;Verifica se cell 12 é igual a C
			je step_11_12
			return_11_12:

			cmp byte[cell21], 'C'										;Verifica se cell 21 é igual a C
			je step_11_21
			return_11_21:

			cmp byte[cell22], 'C'										;Verifica se a cell 22 é igual a C
			je step_11_22
			return_11_22:

			jmp return_11

			step_11_12:
				cmp byte[cell13], 'C'									; Verifica se cell 13 também é igual a C
				je step_11_12_13											; Se for, chama a última etapa dessa sequencia
				jmp return_11_12    									; Se não, retorna para o endereço após a função

				step_11_12_13: 
					mov	 byte[cor],azul_claro 
					call SVL1															;Imprime a linha 1
					mov byte[victorious_player], 'C'			;Defini como vitorioso o jogador 'C'
					call print_victory_for_player_C
					jmp main_loop										

			step_11_21:
				cmp byte[cell31], 'C'										; Verifica se a cell 31 também é igual a C
				je step_11_21_31   											; Se for, imprime a coluna 1
				jmp return_11_21	

				step_11_21_31:
					mov	 byte[cor],azul_claro
					call SVC1															;Imprime a coluna 1
					mov byte[victorious_player], 'C'			;Defini como vitorioso o jogador 'C'
					call print_victory_for_player_C				;Imprime quem venceu
					jmp main_loop;
			step_11_22:
				cmp byte[cell33], 'C'										; Verifica se a cell 33 também é igual a C
				je step_11_22_33 												; Se for, imprime a primeira diagonal
				jmp return_11_22;

				step_11_22_33:
					mov	 byte[cor],azul_claro
					call SVD1															;Imprime a diagonal 1
					mov byte[victorious_player], 'C'			;Defini como vitorioso o jogador 'C'
					call print_victory_for_player_C				;Imprime quem venceu
					jmp main_loop;

		step_12:
			cmp byte[cell22], 'C'											;Verifica se cell22 é igual a C
			je step_12_22
			return_12_22:

			jmp return_12

			step_12_22:
				cmp byte[cell32], 'C' 		 							;Verifica se a cell32 tammbém é a igual 'C'
				je step_12_22_32        	 							

				jmp return_12_22;

				step_12_22_32:
					mov	 byte[cor],azul_claro 
					call SVC2															;Imprime a coluna 2
					mov byte[victorious_player], 'C'			;Defini como vitorioso o jogador 'C'
					call print_victory_for_player_C
					jmp main_loop;						
		step_13:
			cmp byte[cell23], 'C'											;Verifica se cell23 é igual a C
			je step_13_23
			return_11_23:

			cmp byte[cell22], 'C'											;Verifica se a cell22 é igual a C
			je step_13_22  
			return_13_22:

			jmp return_13

			step_13_23:
				cmp byte[cell33], 'C'     							;Verifica se a cell33 tammbém é a igual 'C'
				je  step_13_23_33         							;Se for, imprime a coluna 3
				jmp return_11_23

				step_13_23_33: 
					mov	 byte[cor],azul_claro 
					call SVC3															;Imprime a coluna 3
					mov byte[victorious_player], 'C'			;Defini como vitorioso o jogador 'C'
					call print_victory_for_player_C
					jmp main_loop
			
			step_13_22:
				cmp byte[cell31], 'C' 									;Verifica se a cell31 tammbém é a igual 'C'
				je  step_13_22_31         							;Se for, imprime a diagonal 2
				jmp return_13_22
				
				step_13_22_31: 
					mov	 byte[cor],azul_claro 
					call SVD2															;Imprime a diagonal 2
					mov byte[victorious_player], 'C'			;Defini como vitorioso o jogador 'C'
					call print_victory_for_player_C
					jmp main_loop;	

		step_21:
			cmp byte[cell22], 'C'										;Verifica se cell 12 é igual a C
			je step_21_22
			return_21_22:

			jmp return_21
			step_21_22:
				cmp byte[cell23], 'C'
				je step_21_22_23

				jmp return_21_22
				step_21_22_23:
					mov	 byte[cor],azul_claro 
					call SVL2															;Imprime a linha 2
					mov byte[victorious_player], 'C'			;Defini como vitorioso o jogador 'C'
					call print_victory_for_player_C
					jmp main_loop			
		step_31:
			cmp byte[cell32], 'C'										;Verifica se cell 12 é igual a C
			je step_31_32
			return_31_32:

			jmp return_31
			step_31_32:
				cmp byte[cell33], 'C'
				je step_31_32_33

				jmp return_31_32
				step_31_32_33:
					mov	 byte[cor],azul_claro 
					call SVL3															;Imprime a linha 2
					mov byte[victorious_player], 'C'			;Defini como vitorioso o jogador 'C'
					call print_victory_for_player_C
					jmp main_loop
	jmp main_loop
check_if_X_won:
	; Checa para a linha 1
		cmp byte[cell11], 'X' 										;Verifica se cell11 é igual a C
		je step_X_11												
		return_X_11:

		cmp byte[cell12], 'X'											;Verifica se a cell12 é igual a C
		je jmp_bridge_step_X_12
		return_X_12:

		cmp byte[cell13], 'X'											;Verifica se a cell13 é igual a C
		je jmp_bridge_step_X_13 
		return_X_13:

		cmp byte[cell21], 'X'											;Verifica se a cell13 é igual a C
		je jmp_bridge_step_X_21 
		return_X_21:

		cmp byte[cell31], 'X'											;Verifica se a cell13 é igual a C
		je jmp_bridge_step_X_31 
		return_X_31:

		jmp main_loop
		jmp_bridge_step_X_12:
			call step_X_12

		jmp_bridge_step_X_13:
			call step_X_13

		jmp_bridge_step_X_21:
			call step_X_21

		jmp_bridge_step_X_31:
			call step_X_31
		
		step_X_11:
			cmp byte[cell12], 'X'										;Verifica se cell 12 é igual a C
			je step_X_11_12
			return_X_11_12:

			cmp byte[cell21], 'X'										;Verifica se cell 21 é igual a C
			je step_X_11_21
			return_X_11_21:

			cmp byte[cell22], 'X'										;Verifica se a cell 22 é igual a C
			je step_X_11_22
			return_X_11_22:

			jmp return_X_11

			step_X_11_12:
				cmp byte[cell13], 'X'									; Verifica se cell 13 também é igual a C
				je step_X_11_12_13											; Se for, chama a última etapa dessa sequencia
				jmp return_X_11_12    									; Se não, retorna para o endereço após a função

				step_X_11_12_13: 
					mov	 byte[cor],azul_claro 
					call SVL1															;Imprime a linha 1
					mov byte[victorious_player], 'X'			;Defini como vitorioso o jogador 'C'
					call print_victory_for_player_X
					jmp main_loop										

			step_X_11_21:
				cmp byte[cell31], 'X'										; Verifica se a cell 31 também é igual a C
				je step_X_11_21_31   											; Se for, imprime a coluna 1
				jmp return_X_11_21	

				step_X_11_21_31:
					mov	 byte[cor],azul_claro
					call SVC1															;Imprime a coluna 1
					mov byte[victorious_player], 'X'			;Defini como vitorioso o jogador 'C'
					call print_victory_for_player_X				;Imprime quem venceu
					jmp main_loop;
			step_X_11_22:
				cmp byte[cell33], 'X'										; Verifica se a cell 33 também é igual a C
				je step_X_11_22_33 												; Se for, imprime a primeira diagonal
				jmp return_X_11_22;

				step_X_11_22_33:
					mov	 byte[cor],azul_claro
					call SVD1															;Imprime a diagonal 1
					mov byte[victorious_player], 'X'			;Defini como vitorioso o jogador 'C'
					call print_victory_for_player_X				;Imprime quem venceu
					jmp main_loop;

		step_X_12:
			cmp byte[cell22], 'X'											;Verifica se cell22 é igual a C
			je step_X_12_22
			return_X_12_22:

			jmp return_X_12

			step_X_12_22:
				cmp byte[cell32], 'X' 		 							;Verifica se a cell32 tammbém é a igual 'C'
				je step_X_12_22_32        	 							

				jmp return_X_12_22;

				step_X_12_22_32:
					mov	 byte[cor],azul_claro 
					call SVC2															;Imprime a coluna 2
					mov byte[victorious_player], 'X'			;Defini como vitorioso o jogador 'C'
					call print_victory_for_player_X
					jmp main_loop;						
		step_X_13:
			cmp byte[cell23], 'X'											;Verifica se cell23 é igual a C
			je step_X_13_23
			return_X_11_23:

			cmp byte[cell22], 'X'											;Verifica se a cell22 é igual a C
			je step_X_13_22  
			return_X_13_22:

			jmp return_X_13

			step_X_13_23:
				cmp byte[cell33], 'X'     							;Verifica se a cell33 tammbém é a igual 'C'
				je  step_X_13_23_33         							;Se for, imprime a coluna 3
				jmp return_X_11_23

				step_X_13_23_33: 
					mov	 byte[cor],azul_claro 
					call SVC3															;Imprime a coluna 3
					mov byte[victorious_player], 'X'			;Defini como vitorioso o jogador 'C'
					call print_victory_for_player_X
					jmp main_loop
			
			step_X_13_22:
				cmp byte[cell31], 'X' 									;Verifica se a cell31 tammbém é a igual 'C'
				je  step_X_13_22_31         							;Se for, imprime a diagonal 2
				jmp return_X_13_22
				
				step_X_13_22_31: 
					mov	 byte[cor],azul_claro 
					call SVD2															;Imprime a diagonal 2
					mov byte[victorious_player], 'X'			;Defini como vitorioso o jogador 'C'
					call print_victory_for_player_X
					jmp main_loop;	

		step_X_21:
			cmp byte[cell22], 'X'										;Verifica se cell 12 é igual a C
			je step_X_21_22
			return_X_21_22:

			jmp return_X_21
			step_X_21_22:
				cmp byte[cell23], 'X'
				je step_X_21_22_23

				jmp return_X_21_22
				step_X_21_22_23:
					mov	 byte[cor],azul_claro 
					call SVL2															;Imprime a linha 2
					mov byte[victorious_player], 'X'			;Defini como vitorioso o jogador 'C'
					call print_victory_for_player_X
					jmp main_loop			
		step_X_31:
			cmp byte[cell32], 'X'										;Verifica se cell 12 é igual a C
			je step_X_31_32
			return_X_31_32:

			jmp return_X_31
			step_X_31_32:
				cmp byte[cell33], 'X'
				je step_X_31_32_33

				jmp return_X_31_32
				step_X_31_32_33:
					mov	 byte[cor],azul_claro 
					call SVL3															;Imprime a linha 2
					mov byte[victorious_player], 'X'			;Defini como vitorioso o jogador 'C'
					call print_victory_for_player_X
					jmp main_loop
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
	;Imprime jogador que venceu ou empate
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
		print_victory_for_player_X:
			mov 			bx, 0
			mov			  cx, 19 								;Carrega o tamanho da string em CX
			mov     	dh, 28								;linha 0-29
			mov     	dl, 21								;coluna 0-79
			mov		byte[cor],verde
			
			loop_print_victory_for_player_X:
				call		cursor
				mov     al,	[bx+string_player_X_victory]
				call		caracter
				inc     bx			;proximo caracter
				inc			dl			;avanca a coluna
				
			loop    loop_print_victory_for_player_X
			ret
		print_tied:
			mov 			bx, 0
			mov			  cx, 13 								;Carrega o tamanho da string em CX
			mov     	dh, 28								;linha 0-29
			mov     	dl, 21								;coluna 0-79
			mov		byte[cor],amarelo
			
			loop_print_tied:
				call		cursor
				mov     al,	[bx+string_tied]
				call		caracter
				inc     bx			;proximo caracter
				inc			dl			;avanca a coluna
				
			loop    loop_print_tied
			ret
keyint:
    PUSH    AX
    push    bx
    push    ds
		push 		dx
    mov     ax, data
    mov     ds, ax
    IN      AL, kb_data
    inc     WORD [p_i]
    and     WORD [p_i], 7
    mov     bx, [p_i]
    mov     [bx+tecla], al
    IN      AL, kb_ctl
    OR      AL, 80h
    OUT     kb_ctl, AL
    AND     AL, 7Fh
    OUT     kb_ctl, AL
    MOV     AL, eoi
    OUT     pictrl, AL
		pop 		dx
    pop     ds
    pop     bx
    POP     AX
    IRET
	



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
key_jogada				db		4
key_out_game			db		's'  

;Strings
string_terminal					db	'Terminal'
string_game    					db  'JOGO DA VELHA'
string_last_move 				db	'Campo de comando'
string_message   				db  'Campo de mensagens'
string_invalid_command	db 	'Comando Invalido'
string_invalid_play			db 	'Jogada Inválida'
string_occupied_cell    db  'Jogada Invalida'
string_empty_terminal		db  '     '
string_invalid_player   db  'Jogada Invalida'
string_empty_message    db 	'                                                   '
string_empty_command    db  '   '
string_player_C_victory db  'O jogador C venceu!'
string_player_X_victory db  'O jogador X venceu!'
string_tied 						db  'Houve empate!'
string_final_message    db  'Favor, iniciar um novo jogo ou encerrar o programa!' ;;66

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
is_tied db 0

; TRABALHO
kb_data          EQU 60h  ; PORTA DE LEITURA DE TECLADO
kb_ctl           EQU 61h  ; PORTA DE RESET PARA PEDIR NOVA INTERRUPCAO
pictrl           EQU 20h
eoi              EQU 20h
int9             EQU 9h
cs_dos           DW 1
offset_dos       DW 1
tecla_u          db 0
tecla            resb 8
p_i              dw 0   ; Ponteiro para interrupção (quando pressiona tecla)
p_t              dw 0   ; Ponteiro para interrupção (quando solta tecla)
teclasc          DB 0, 0, 13, 10, '$'
ultimo_caracter  DB 0
shift_is_on      DB 0   ;Boolean para saber se é maiuscula ou minúscula. 
string_shift_on  DB 'Caixa alta ligada'
string_shift_off DB '                 '
;*************************************************************************
segment stack stack
  resb 		512
				
stacktop:
;NAO PODE JOGAR NO MESMO LUGAR\;

