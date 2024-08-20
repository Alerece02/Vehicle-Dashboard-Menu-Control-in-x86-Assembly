.section .data

lol:
  .byte 0   

.section .text
.global atoi

.type atoi, @function 

atoi:
  pushl %ebx          
  pushl %ecx          
  pushl %edx          
  movl %eax, %ecx
  xorl %eax, %eax
  xorl %edx, %edx

start:
  xorl %ebx, %ebx
  mov (%ecx,%edx), %bl
  testb  %bl, %bl      
  jz end
  movb %bl, lol
  subb  $48, lol     
  movl  $10, %ebx
  pushl %edx	        
  mull  %ebx          
  popl %edx
  xorl  %ebx, %ebx
  movb  lol, %bl                                 
  addl  %ebx, %eax                                
  incl  %edx
  jmp   start

end:		                        
  popl %edx                
  popl %ecx              
  popl %ebx               
  ret                
                      
                     
                  