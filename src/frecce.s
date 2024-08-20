.section .data

	str:											
		.ascii "\tNumero lampeggi: "
	str_len:
		.long . - str
	lampeggi:										
		.long 3

.section .text

	.global frecce
	.type frecce, @function

    
	frecce:
		movl %ecx, lampeggi						# sposto valore di ecx in lampeggi
    
    frecce2:								
        movl $4, %eax							# prime 5 righe di stampa
		movl $1, %ebx
		leal str, %ecx
		movl str_len, %edx
		int $0x80								
		movl lampeggi, %eax						# sposto lampeggi in eax
		call itoa		
        call lettura						    # call per leggere il comando da tastiera
		cmp $183, %ebx							# commando freccia SU tastiera confrontato con il valore di ebx
		je sottrai								
		cmp $184, %ebx							# commando freccia GIU tastiera	confrontato con il valore di ebx
		je aggiungi
		cmp $0, %ebx							# comando tasto ENTER confrontato con il valore di ebx
		je end

    sottrai:									# si occupa di sottrarre 1 fino ad un minimo di 2
        subl $1, lampeggi
        cmpl $2, lampeggi					
		jl min														
		jmp frecce2								

    aggiungi:									# si occupa di sommare 1 fino ad un minimo di 5
        addl $1, lampeggi
        cmpl $5, lampeggi
        jg max									
        jmp frecce2

    min:										# inserimento del lampeggio minimo 
		movl $2, lampeggi							
		jmp end									

	max:									
		movl $5, lampeggi						# inserimento dei lampeggi massimi 
		jmp end
    
    end:										# caricamento dei lampeggi in ecx e ritorno al menu	
		movl lampeggi, %ecx						
		ret   

