.section .text

	.global _start
	
	_start:
		popl %eax								# prendo il numero di parametri che ci sono nello stack
		cmp $2, %eax							# lo comparo alla costante $2
		je verifica_supervisor					# se ci sono due valori devo verifico se è supervisor																				
		movl $1, %eax							# metto $1 in eax per la prima riga
		call menu1								# chiamata a menu1
		jmp end									# salto incondizionato ad end

	verifica_supervisor:								
		pop %eax								# prendo il nome del file dallo stack
		pop %eax								# prendo il primo parametro
        call atoi								# chiamata alla funzione atoi per convertirlo 
        cmp $2244, %eax							# confronto il secondo valore se è uguale a 2244
		je supervisor							# se è uguale allora salto all'etichetta supervisor
		jne _start								# se non è uguale riparto da start in modo da farmi entrare direttamente nel menu user

	supervisor:						
		movl $1, %eax							# mettere 1 in eax mi permette di partire dalla prima riga del menu
		call menu2								# chiamata alla funzione menu2 che sarebbe il menu supervisor
		jmp end									

	end:											
		movl $1, %eax
		movl $0, %ebx
		int $0x80

		
		
        

