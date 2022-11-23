.model tiny

.code
org 100h

start:
	mov DX,offset fio		;Выводи ФИО и номер группы
	call out_string

	mov AX,1				;Записываем цифры в регистры и выводим их
	mov BX,2	

	call print_number		; Выводим на экран
	xchg AX,BX				; Меняем местами
	call print_number		; Снова выводим
	
	mov AX,4C00h			; Функция завершения программы
	int 21h					; Прерывание

	out_string proc			; Выводим строку на экран
		mov AH,9
		int 21h
		ret
	out_string endp

	out_char proc
		mov AH,2
		int 21h
		ret
	out_char endp

	print_number proc		; Дополнительный функция для отображения сначала AX затем BX вместе с пробелом между
		push AX				; Сохраняем наши значения
		push BX

		add AX,30h			; Делаем символ
		mov DL,AL
		call out_char		; Первая цифра

		mov DL,0			; Добавляем пробел между
		call out_char

		add BX,30h			; Делаем символ
		mov DL,BL
		call out_char

		mov DL,10			; Перенос строки
		call out_char

		pop BX				; Достаем сохраненные значения из стека
		pop AX
		ret
	print_number endp

;===== Data =====
fio db 'Filippov Ivan 451',0Dh,0Ah,'$'

end start