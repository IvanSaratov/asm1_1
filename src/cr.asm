.model small
            
.stack 100h 
.data 
FIO db 'Filippov Ivan 451',0Dh,0Ah,'$'
len equ 10
array db len dup (?)
startNum equ 1
.code

start:                      
	mov AX, @data             
	mov DS,AX                 
	
	mov DX,offset FIO	; Выводи ФИО и номер группы
	mov AH,9		; Вывод из DX
	int 21h
	
	mov SI,startNum
	mov CX,len
	mov BX,offset array
	
	xor AX,AX		; Максимально хитрим

	@@lp1:
		mov [BX],SI	; Заносим первое число
		add AX,SI
		inc SI		; Увеличиваем число на 2
		inc SI
		add BX,2	; Смещаем указатель в массиве на 2
	loop @@lp1		; Пока не кончится CX

	mov DX,AX
	mov AH,9
	int 21h

	mov AX,4C00h	; Функция завершения программы
	int 21h
end start
