.section .data
	# dichiarazione delle variabili di riga 1 e la loro lunghezza
	row1:											
		.ascii "Setting automobile: "
	row1_len:										
		.long . - row1
    
    # dichiarazione delle variabili di riga 2 e la loro lunghezza
    row2:											
		.ascii "Data: 15/06/2014"
	row2_len:										
		.long . - row2

    # dichiarazione delle variabili di riga 3 e la loro lunghezza
    row3:											
		.ascii "Ora: 15:32"	
	row3_len:										
		.long . - row3
  
    # dichiarazione delle variabili di riga 4 e la loro lunghezza
    row4:											
		.ascii "Blocco porte automatico: "
	row4_len:										
		.long . - row4

	row4_state:									
		.long 1

    # dichiarazione delle variabili di riga 5 e la loro lunghezza
    row5:											
		.ascii "Back-Home: "
	row5_len:										
		.long . - row5

	row5_state:									
		.long 1

	# variabili per salvare ON OFF
	on:											
		.ascii "ON"
	on_len:										
		.long . - on

	off:											
		.ascii "OFF"
	off_len:										
		.long . - off

    # dichiarazione delle variabili di riga 6 e la loro lunghezza
    row6:											
		.ascii "Check olio"	
	row6_len:										
		.long . - row6


.section .text

	.global menu1
	.type menu1, @function

 
# confronto il valore costante con il valore presente su %eax e con una jump equal salto all'etichetta che contiene quel valore.		

	menu1:									
		cmp $1, %eax							
		je riga1
		cmp $2, %eax
		je riga2
		cmp $3, %eax
		je riga3
		cmp $4, %eax
		je riga4
		cmp $5, %eax
		je riga5
		cmp $6, %eax
		je riga6

    riga1:								
		movl $4, %eax					# Le prime 5 righe si occupano della stampa
		movl $1, %ebx
		leal row1, %ecx
		movl row1_len, %edx
		int $0x80						
		movl $1, %eax					# Associo il valore costante $1 ad %eax per indicare che siamo nella riga 1
        jmp leggere						# salto incondizionato all'etichetta leggere

    riga2:											
		movl $4, %eax					# Le prime 5 righe si occupano della stampa		
		movl $1, %ebx
		leal row2, %ecx
		movl row2_len, %edx
		int $0x80								
		movl $2, %eax					# Associo il valore costante $2 ad %eax per indicare che siamo nella riga 2		
        jmp leggere						# salto incondizionato all'etichetta leggere
		
    riga3:	
        movl $4, %eax					# Le prime 5 righe si occupano della stampa		
		movl $1, %ebx
		leal row3, %ecx
		movl row3_len, %edx
		int $0x80								
		movl $3, %eax					# Associo il valore costante $3 ad %eax per indicare che siamo nella riga 3
        jmp leggere						# salto incondizionato all'etichetta leggere

	riga4:										
		movl $4, %eax					# Le prime 5 righe si occupano della stampa
		movl $1, %ebx
		leal row4, %ecx
		movl row4_len, %edx
		int $0x80							

	print_state:								
		cmpl $1, row4_state				# confronto $1 con il contenuto della variabile row4_state
		je print_on						# se uguale allora salto a print_on

	print_off:									
		movl $4, %eax					# Le prime 5 righe si occupano della stampa
		movl $1, %ebx
		leal off, %ecx
		movl off_len, %edx
		int $0x80								
		jmp end4								

	print_on:									
		movl $4, %eax					# righe che si occupano della stampa
		movl $1, %ebx
		leal on, %ecx
		movl on_len, %edx
		int $0x80								

    end4:
		movl $4, %eax					# Associo il valore costante $4 ad %eax per indicare che siamo nella riga 4
        jmp leggere						# salto incondizionato all'etichetta leggere
   
    riga5:
		movl $4, %eax					# righe che si occupano della stampa
		movl $1, %ebx
		leal row5, %ecx
		movl row5_len, %edx
		int $0x80
					
	print_state5:								
		cmpl $1, row5_state				# confronto $1 con il contenuto della variabile row5_state
		je print_on5					# se uguale allora salto a print_on5

	print_off5:									
		movl $4, %eax					# Le prime 5 righe si occupano della stampa di off
		movl $1, %ebx
		leal off, %ecx
		movl off_len, %edx
		int $0x80						
		jmp end5						# salto incondizionato all'etichetta end5				

	print_on5:									
		movl $4, %eax					# righe che si occupano della stampa di on
		movl $1, %ebx
		leal on, %ecx
		movl on_len, %edx
		int $0x80					
    
    end5:
		movl $5, %eax					# Associo il valore costante $5 ad %eax per indicare che siamo nella riga 5
        jmp leggere						# salto incondizionato all'etichetta leggere

    riga6:
        movl $4, %eax					# Le prime 5 righe si occupano della stampa
		movl $1, %ebx
		leal row6, %ecx
		movl row6_len, %edx
		int $0x80							
		movl $6, %eax					# Associo il valore costante $6 ad %eax per indicare che siamo nella riga 6
        jmp leggere						# salto incondizionato all'etichetta leggere
	 
		
	leggere:										
		call lettura					# chiamo la funzione lettura per leggere il comando inserito dall'utente

	movimento:							 
		cmp $183, %ebx					# comando freccia SU tastiera confrontato con il valore di ebx
		je riga_precedente				# se uguale salto a riga_precedente
		cmp $184, %ebx					# comando freccia GIU tastiera	confrontato con il valore di ebx
		je riga_successiva				# se uguale salto a riga_successiva
		cmp $185, %ebx					# comando freccia DESTRA tastiera confrontato con il valore di ebx
		je sottomenu						# salto all'etichetta sottomenu 
		cmp $0, %ebx					# comando tasto ENTER confrontato con il valore di ebx
		je end							# salto incondizionato all'etichetta end
		jmp home						# ristampa la riga se viene inserito un comando non valido

	riga_precedente:									 
		decl %eax						# decremento eax
		cmp $0, %eax					# confronto eax con la prima riga
		je riga6						# se uguale salto all'etichetta riga6
		jmp menu1						# salto incondizionato a menu1

	riga_successiva:									
		incl %eax						# incremento eax
		cmp $7, %eax					# confronto eax l'ultima riga
		je riga1						# se uguale salto all'etichetta riga1
		jmp menu1						# salto incondizionato a menu2

	sottomenu:										 
		cmp $4, %eax					# confronto $4 con eax
		je sottomenu4						# se uguale salto a sottomenu4
		cmp $5, %eax					# confronto $5 con eax
		je sottomenu5						# se uguale salto a sottomenu5
		jmp home						# salto incondizionato ad home

	sottomenu4:									
		movl row4_state, %ebx			# sposto il valore dello stato iniziale in ebx
		call on_off_riga4				# chiamata alla funzione on_off_riga4
		movl %ebx, row4_state			# metto lo stato aggiornato in ebx nella variabile row4_state
		jmp riga4						# salto incondizionato a riga4

	sottomenu5:									
		movl row5_state, %ebx			# sposto il valore dello stato iniziale in ebx
		call on_off_riga5				# chiamata alla funzione on_off_riga5
		movl %ebx, row5_state			# metto lo stato aggiornato in ebx nella variabile row5_state
		jmp riga5						# salto incondizionato a riga5	
						    
	home:								
		jmp menu1						# salto incodinzionato all'etichetta home
      
    end:												
		ret								# ritorno al file chiamante
        