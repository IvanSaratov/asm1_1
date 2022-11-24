.model small
            
.stack 100h
.386
.data 
fio db 'Filippov Ivan 451',0Dh,0Ah,'$'
len equ 10
array db len dup (?)
startNum equ 1
.code

start:
	mov AX, @data
	mov DS, AX
	
	mov DX, offset fio	; Выводи ФИО и номер группы
	mov AH, 9			; Вывод из DX
	int 21h

	mov AH, 2			; Функция вывода символа
	mov DL, 40h			; Выводим собачку
	int 21h

	mov AH, 2
	mov DL, 10			; Сделаем отступ
	int 21h

	mov AX, 0			; Обнулим AX
	mov CX, len			; Счетчик элементов массива
	mov AL, startNum	; Начальное значение массива
	mov SI, 0			; Первый элемент массива

	init:
		mov array[SI], AL		; Заносим первый элемент
		add AL, 2				; Увеличиваем элемент на 2, что бы получился следующий нечетный элемент
		inc SI					; Идем к следующему элементу
	loop init

	mov CX, len		; Выведем на экран наш массив
	mov SI, 0		; Опять обнулим счетчик и индекс
	show:
		mov AL, array[SI]
		mov AH, 0

		call print

		mov DL, 0D0h
		call to_char

		inc SI
	loop show

	mov AH, 2
	mov DL, 10		; Сделаем отступ
	int 21h

	mov AX, 0		; Обнулим счетчик
	mov CX, len		; Пройдемся ещё раз по массиву и посчитаем сумму элементов
	mov SI, 0

	get_sum:
		add AL, array[SI]
		inc SI
	loop get_sum

	mov AH, 0		; TODO: Где то тут проблема
	call print		; Выведем нашу сумму

	mov AX,4C00h	; Функция завершения программы
	int 21h

	print proc
		pusha

		mov CX, 0
		label1:
			mov DX, 0
			mov BX, 10 		; Система счисления
			div BX 			; Деленим AX на BX
			mov BX, 0		; Обнуляем
			push DX			; Сохраняем цифру
			inc CX			; Увеличиваем счетчик, сколько цифр было в числе
			cmp AX, 0 		; Сравниваем, стали ли AX равен нулю
		jnz label1 			; Если условие выполняется, то конец цикла
	
		label2:
			pop DX			; Достаем цифры
			call to_char 	; Отправляем в функцию конвертации в число и выводим на экран
		loop label2 		; Повторяем пока не выведем все
		popa
		ret
	print endp

	to_char proc 	; Доп функция, которая выводит символ на экран
		mov AH, 2
		add DL, 30h
		int 21h
		ret
	to_char endp
end start