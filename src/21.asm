.model small
            
.stack 100h 
.data 
FIO db 'Filippov Ivan 451',0Dh,0Ah,'$'
Number1 db '1$'
Number2 db '2$'
Space db ' $'
Enter db '',0Dh,0Ah,'$'
.code                       

start:                      
	mov AX, @data             
	mov DS,AX                 
	
	mov DX,offset FIO	;Выводи ФИО и номер группы
	call Out_string

	mov AX,offset Number1	;Записываем числа в регистры и выводим их
	mov BX,offset Number2

	call Print_number
	xchg AX,BX
	call Print_number

	
	mov AX,4C00h	; Функция завершения программы
	int 21h

	Out_string proc
		mov AH,9
		int 21h
		ret
	Out_string endp

	Print_number proc	; Дополнительный функция для отображения сначала AX затем BX вместе с пробелом между
		push AX
		push BX
		mov DX,AX
		call Out_string
		mov DX,offset Space
		call Out_string
		mov DX,BX
		call Out_string

		mov DX,offset Enter
		call Out_string

		pop BX
		pop AX
		ret
	Print_number endp

end start

