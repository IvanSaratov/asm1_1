.model small

.stack 100h
.data
fio db 'Filippov Ivan 451',0Dh,0Ah,'$'
.code

start:
.386						; 32-битные регистры
	mov AX, @data
	mov DS,AX
	mov ES,AX

	mov DX,offset fio		; Выводи ФИО и номер группы
	mov AH,9				; Вывод из DX
	int 21h
	
					; AX - это 16 битный регистр, максимальное число которое можно задать это 65535
	mov EAX,6525354	; Заносим число
	call print_int
	
	mov AX,4C00h	; Функция завершения программы
	int 21h

	print_int proc
		push EAX
		push EBX
		push CX
		push EDX

		mov BX,10			; Система счисления
		mov ECX,0			; Колличество цифр
		@@div:
			xor EDX,EDX		; Делим AX, тобишь на BX
			div EBX
			add DL,'0'			; Преобразуем остаток от деления в цифры (30h)
			push EDX			; И сохраняем его в стек
			inc CX				; Увеличиваем счетчик цифр
			test EAX,EAX		; Проверяем на логическое И, если цифр не осталось в AX то выходи из блока @@div
		jnz @@div
		@@show:
			mov AH,2		; Вывод из DL
			pop EDX			; Извлекаем очередную цифру
			int 21h			; Выводим на экран
		loop @@show

		pop EDX
		pop CX
		pop EBX
		pop EAX
		ret
	print_int endp

end start
