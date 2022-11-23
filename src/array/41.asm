.model small
            
.stack 100h 
.data 
FIO db 'Filippov Ivan 451',0Dh,0Ah,'$'
array db 0,1,2,3,4,5,6,7,8,9
len equ 10
result db 10 dup(?)
.code

start:                      
	mov AX, @data             
	mov DS,AX                 
	
	mov DX,offset FIO	; Выводи ФИО и номер группы
	mov AH,9		; Вывод из DX
	int 21h
	
	mov CX,len
	xor AL,AL
	xor SI,SI
	@@lp1:
		mov AL,array[SI]
		mov BL,array[SI]
		mul BL
		mov result[SI],BL
		aam
		
		add AX,3030h
		mov DL,AH
		mov DH,AL
		mov AH,2
		int 21h
		mov DL,DH
		int 21h
		mov AH,2
		mov DL,' '
		int 21h
		inc AL
		inc SI
	loop @@lp1

	mov AX,4C00h	; Функция завершения программы
	int 21h
end start
