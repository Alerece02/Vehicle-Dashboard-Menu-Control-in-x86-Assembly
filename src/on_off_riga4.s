.section .data

    row4n:										
		.ascii "\tBlocco porte automatico: OFF "
	row4n_len:								
		.long . - row4n

    
    row4s:										
		.ascii "\tBlocco porte automatico: ON "
	row4s_len:								
		.long . - row4s

	state:								# qui salvo lo stato 
		.long 1

.section .text

	.global on_off_riga4
	.type on_off_riga4, @function


    on_off_riga4:
		movl %ebx, state				# metto lo stato attuale di ebx in state
    
    start:
        cmpl $1, state
        je print_on
        jne print_off

    print_off:									
		movl $4, %eax					# Le prime 5 righe si occupano della stampa
		movl $1, %ebx
		leal row4n, %ecx
		movl row4n_len, %edx
		int $0x80								
		jmp movimento    								

	print_on:									
		movl $4, %eax					# righe che si occupano della stampa
		movl $1, %ebx
		leal row4s, %ecx
		movl row4s_len, %edx
		int $0x80	
        jmp movimento

    movimento:									 
		call lettura					# chiamata alla funzione lettura per verificare quale comando inserito da tastiera
		cmp $183, %ebx					# commando freccia SU tastiera
		je switch								
		cmp $184, %ebx					# commando freccia GIU tastiera
		je switch
		cmp $0, %ebx					# comando tasto ENTER
		je end
		jmp start

	switch:
		cmpl $1, state					# si occupa di confrontare il valore di state con 1 		
		je off							

	on:									
		movl $1, state					
		jmp start						

	off:								 
		movl $0, state					
		jmp start						

	end:								# carico la variabile state in ebx e ritorno al file chiamante		
		movl state, %ebx					
		ret
    						