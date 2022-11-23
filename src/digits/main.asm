.model tiny

.code
org 100h

start:
	mov DX,offset fio	;Выводи ФИО и номер группы
	call Out_string

	mov AX,offset Number1	;Записываем цифры в регистры и выводим их
	mov BX,offset Number2	

	call Print_number		; Выводим на экран
	xchg AX,BX				; Меняем местами
	call Print_number		; Снова выводим
	
	mov AX,4C00h	; Функция завершения программы
	int 21h			; Прерывание

	Out_string proc		; Выводим строку на экран
		mov AH,9
		int 21h
		ret
	Out_string endp

	Print_number proc	; Дополнительный функция для отображения сначала AX затем BX вместе с пробелом между
		push AX			; Сохраняем наши значения
		push BX

		mov DX,AX
		call Out_string		; Первая цифра

		mov DX,offset space		; Добавляем пробел между
		call Out_string

		mov DX,BX			; Вторая цифра
		call Out_string

		mov DX,offset endline	; Перенос строки
		call Out_string

		pop BX		; Достаем сохраненные значения из стека
		pop AX
		ret
	Print_number endp

;===== Data =====
fio db 'Filippov Ivan 451',0Dh,0Ah,'$' 	; 
number1 db '1$'
number2 db '2$'
space db ' $'
endline db '',0Dh,0Ah,'$'

end start