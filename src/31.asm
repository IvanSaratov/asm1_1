.model small
            
.stack 100h 
.data 
FIO db 'Filippov Ivan 451',0Dh,0Ah,'$'
.code                       

start:                      
	mov AX, @data             
	mov DS,AX                 
	
	mov DX,offset FIO	; Выводи ФИО и номер группы
	mov AH,9		; Вывод из DX
	int 21h
	
			; AX - это 16 битный регистр, максимальное число которое можно задать это 65534
	mov AX,65535	; Заносим число
	call print_int
	
	mov AX,4C00h	; Функция завершения программы
	int 21h

	print_int proc
		push AX
		push BX
		push CX
		push DX
		mov BX,10	; Система счисления
		mov CX,0	; Колличество цифр
		@@div:
			xor DX,DX	; Делим DX:AX, тобишь на BX
			div BX
			add DL,'0'	; Преобразуем остаток от деления в цифры
			push DX		; И сохраняем его в стек
			inc CX		; Увеличиваем счетчик цифр
			test AX,AX	; Проверяем на логическое И, если цифр не осталось в AX то выходи из блока @@div
		jnz @@div
		@@show:
			mov AH,2	; Вывод из DL
			pop DX		; Извлекаем очередную цифру
			int 21h		; Выводим на экран
		loop @@show
		pop DX
		pop CX
		pop BX
		pop AX
		ret
	print_int endp
end start
