.model smALl
.stack 100h
.386 ;Разрешение трансляции команд процессора 386
.data
array dw 20 dup (0) ;исходный массив
startNum equ 2
len equ 10
.code
 
start:
	mov AX, @data
	mov DS, AX
	mov AX, 0 			; Обнуление AX
	mov CX, len			; Значение счетчика цикла
	mov AL, startNum	; Первый элемент
	mov SI, 0 			; Индекс первого элемента
	
	init: 						; Заполняем первые len-элементов значениями
		mov array[SI], AX 		; Заносим в массив элемент AL
		push AX
		mul AX					; Вычисляем квадрат
		mov array[SI+len+len], AX	; Так же сразу заносим его квадрат
		pop AX
		add AX, 2 				; увеличение значения следуещего элемента массива на 2, так как нам нужны четные числа
		add SI, 2				; Переход к следующему элементу массива
	loop init 					; Повторить цикл len-раз

	mov SI, 0 					; Возвращаемся к первому элементу
	mov CX, 2					; Колличество строк для вывода
	
	; Выводим массив на экран
	show1: 			
		push CX
		mov CX, len					; Колличество элементов на строке
		
		show2:
			mov AX, array[SI] 		; Значение элемента массива помещается в AL
		;	mov AH, 0 				; Функция вывода
			
			call print 				; Вызываем функцию, которая выводит число в AX на экране
			add SI, 2				; Переход к следующему элементу массива
		loop show2

		pop CX
		
		mov DL, 0DAh	; Делаем отступ
		call to_char	; Выводим на экран
	loop show1

	mov AX,4C00h 		; Завершение программы
	int 21h				; Прерывание


	print proc 			; Функция для вывода элеманта массива на экран
		pusha 			; Вывод пробелов перед каждым числом
		pusha

		mov BX, 0		; Обнуляем BX
		
		label0:			; Считаем колличество символов в числе
			inc BX
			mov DX, 0
			mov CX, 10
			div CX
			cmp AX, 1
		jnc label0

		neg BX			; Переворачиваем число на отрицательное
		add BX, 6		; Вычитаем как бы из общего буфера лишние пробелы
		mov CX, BX		; Заносим его как новый счетчик вывода
		
		lab:
			mov DL, 0D0h	; Добавляем пробелов на экран
			call to_char
		loop lab
		popa
		
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