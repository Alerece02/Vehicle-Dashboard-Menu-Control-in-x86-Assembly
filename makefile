EXE= executable
AS= as
LD= ld
FLAGS= --32 -gstabs
FLAGS2= -melf_i386
OBJ= obj/main.o obj/atoi.o obj/itoa.o obj/menu2.o obj/menu1.o obj/lettura.o obj/on_off_riga5.o obj/on_off_riga4.o obj/frecce.o 

$(EXE): $(OBJ)
	$(LD) $(FLAGS2) -o bin/$(EXE) $(OBJ)
obj/main.o: src/main.s
	$(AS) $(FLAGS) -o obj/main.o src/main.s
obj/atoi.o: src/atoi.s
	$(AS) $(FLAGS) -o obj/atoi.o src/atoi.s
obj/menu2.o: src/menu2.s
	$(AS) $(FLAGS) -o obj/menu2.o src/menu2.s
obj/menu1.o: src/menu1.s
	$(AS) $(FLAGS) -o obj/menu1.o src/menu1.s
obj/lettura.o: src/lettura.s
	$(AS) $(FLAGS) -o obj/lettura.o src/lettura.s
obj/on_off_riga4.o: src/on_off_riga4.s
	$(AS) $(FLAGS) -o obj/on_off_riga4.o src/on_off_riga4.s
obj/on_off_riga5.o: src/on_off_riga5.s
	$(AS) $(FLAGS) -o obj/on_off_riga5.o src/on_off_riga5.s
obj/frecce.o: src/frecce.s
	$(AS) $(FLAGS) -o obj/frecce.o src/frecce.s
obj/itoa.o: src/itoa.s
	$(AS) $(FLAGS) -o obj/itoa.o src/itoa.s
clean:
	rm -f *.o $(EXE) core
	
	

	
	