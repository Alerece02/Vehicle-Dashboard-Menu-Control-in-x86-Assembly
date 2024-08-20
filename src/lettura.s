.section .data

	var:											
		.long 0

.section .text

	.global lettura
	.type lettura, @function

	lettura:									
		pushl %eax								# salvo eax in cima allo stack
		xorl %ebx, %ebx							# azzeramento di ebx

	start:
		pushl %ebx								# memorizzo sullo stack %bx	
		movl $3, %eax							# lettura
		movl $0, %ebx
		leal var, %ecx							# carico in %ecx indirizzo di var dove salvo il carattere letto
		mov $1, %edx							
		int $0x80								
		cmpl $10, var							# cotrollo del carattere '\n'
		je end									# se è uguale salto all'etichetta end
		popl %ebx								
		addl var, %ebx							
		jmp start								

	end:										# ripristino dei registri e ritorno al file chiamante
		popl %ebx								
		popl %eax								
		ret
											
		