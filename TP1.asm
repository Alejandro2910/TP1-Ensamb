;suma,resta,multiplicacion y divide numeros
;Autor original Alexander H. Quispe Mamani
;Modificado por Sergio Tijerino ?vila el 21/4/2018
;Modificado por Alejandro Benavides 30/05/2018
;Alexander Hilario Quispe Mamani, Universidad Mayor Real Pontificia de San Francisco Xavier Chuquisaca Bolivia
.model small
.stack 2000
.data
  ms    db         10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,13,'          ---> s para salir',10,13,'          ---> c para borrar',10,10,13,'         ------------CALC-------------$'
  lin1  db      10,13,'         +---------------------------+$'
  lin2  db      10,13,'         | +---+ +---+ +---+   +---+ |$' ;Se define la interfaz grafica
  lin3  db      10,13,'         | | 1 | | 2 | | 3 |   | + | |$'
  lin4  db      10,13,'         | +---+ +---+ +---+   +---+ |$'
  lin5  db      10,13,'         | +---+ +---+ +---+   +---+ |$'
  lin6  db      10,13,'         | | 4 | | 5 | | 6 |   | - | |$'
  lin7  db      10,13,'         | +---+ +---+ +---+   +---+ |$'
  lin8  db      10,13,'         | +---+ +---+ +---+   +---+ |$'
  lin9  db      10,13,'         | | 7 | | 8 | | 9 |   | c | |$'
  lin10 db      10,13,'         | +---+ +---+ +---+   +---+ |$'
  lin11 db      10,13,'         | +---+ +---+ +---+   +---+ |$'
  lin12 db      10,13,'         | | * | | 0 | | / |   | s | |$'       ;Cada uno de los supuestos botones realiza algo
  lin13 db      10,13,'         | +---+ +---+ +---+   +---+ |$'       ;Al presionar 'c' --> "limpia pantalla" y vuelve a iniciar
  lin14 db      10,13,'         +---------------------------+$'        ;Al presionar 's' --> Sale del programa
  lin15 db      10,13,'         Expresion: $'
  msg1  db      10,13,'         Resultado: $'
  resi  db        ' residuo> $'   ;Si hay residuo imprimimos el mensaje
  msg3  db        10,13,'****ERROR EN LA EXPRESION... LA MANERA CORRECTA: <NUMERO><OPERADOR><NUMERO>',10,13,'Presiona una tecla para continuar...$'
  b     db   ?    ;Variable bandera
  b2    db   ?
  barra db  '/$'  ;Guarda el caracter de la barra divisoria para imprimirlo a la hora de correr el programa
  e     db   ?    ;Variable utilizada para error o borrar
  debug db  'Llegue$'
  c     db  100   ;Usado para obtener las centenas del dato
  d     db  10    ;Usado para obtener las decenas del dato
  v1    dw   ?    ;variable que almacena el primer numero
  v2    dw   ?    ;variable que almacena el segundo numero
  v3    dw   ?    ;variable que almacena el primer numero
  v4    dw   ?    ;variable que almacena el segundo numero
  op    db   ?    ;variable que almacena el operador

.code
   main proc
        mov ax,@data
        mov ds,ax
menu1:  call menu  ;Mandamos llamar al procedimiento menu

        mov b,0   ;Inicializamos nuestras variables
        mov e,0   
        mov b2, 0 ;Bandera de que numero se lee
        mov cx, 3
        mov ax, 0
        
PrimerNum:
        call leecar          ;Mandamos llamar al procedimiento leecar el cual lee un caracter
        cmp al,'s'           ;Comparamos el caracter leido con 's'
        je prepreprefin            ;Si es igual salimos del programa
        cmp e,1              ;Comparamos la variable e con 1
        je menu1             ;Si es igual quiere decir que hay error y saltamos a menu1
        cmp b2, 0
        je centenas
        cmp b2, 1
        je decenas
        jmp unidades
centenas:
        sub al, 30h
        mul c
        jmp termine
decenas:
        sub al, 30h
        mul d
        jmp termine
unidades:
        sub al, 30h
termine:
        add v1, ax           ;Almacenamos el numero leido en la variable v1
        inc b2
        loop PrimerNum
        
        mov b2, 0
        mov cx, 3
        call barraDiv
        jmp SegundoNum
        
prepreprefin:
        jmp preprefin
        
SegundoNum:
        call leecar          ;Mandamos llamar al procedimiento leecar el cual lee un caracter
        cmp al,'s'           ;Comparamos el caracter leido con 's'
        je preprefin            ;Si es igual salimos del programa
        cmp e,1              ;Comparamos la variable e con 1
        je menu1             ;Si es igual quiere decir que hay error y saltamos a menu1
        cmp b2, 0
        je centenas1
        cmp b2, 1
        je decenas1
        jmp unidades1
centenas1:
        sub al, 30h
        mul c
        jmp termine1
decenas1:
        sub al, 30h
        mul d
        jmp termine1
unidades1:
        sub al, 30h
        mov ah, 0
termine1:
        add v2, ax           ;Almacenamos el numero leido en la variable v1
        inc b2
        loop SegundoNum
        jmp leeoper
        
preprefin:
    jmp prefin
    
leeoper:
        mov b,1              ;Cambiamos el estado de nuestra bandera
        call leecar          ;Mandamos llamar al procedimiento leecar el cual lee un caracter
        cmp al,'s'           ;Comparamos el caracter leido con 's'
        je preprefin         ;Si es igual salimos del programa
        cmp e,1              ;Comparamos la variable e con 1
        je prepremenu1       ;Si es igual quiere decir que hay error y saltamos a menu1
        mov op,al            ;Almacenamos el operador leido en la variable op

        mov b,0   ;Cambiamos el estado de nuestra bandera
        mov cx, 3
        mov b2, 0
        jmp PrimerNum2
        
prepremenu1:
        jmp premenu1
        
PrimerNum2:
        call leecar          ;Mandamos llamar al procedimiento leecar el cual lee un caracter
        cmp al,'s'           ;Comparamos el caracter leido con 's'
        je preprefin            ;Si es igual salimos del programa
        cmp e,1              ;Comparamos la variable e con 1
        je premenu1             ;Si es igual quiere decir que hay error y saltamos a menu1
        cmp b2, 0
        je centenas2
        cmp b2, 1
        je decenas2
        jmp unidades2
centenas2:
        sub al, 30h
        mul c
        jmp termine2
decenas2:
        sub al, 30h
        mul d
        jmp termine2
unidades2:
        sub al, 30h
termine2:
        add v3, ax           ;Almacenamos el numero leido en la variable v1
        inc b2
        loop PrimerNum2
        
        mov b2, 0
        call barraDiv
        mov cx, 3
        
SegundoNum2:
        call leecar          ;Mandamos llamar al procedimiento leecar el cual lee un caracter
        cmp al,'s'           ;Comparamos el caracter leido con 's'
        je preprefin            ;Si es igual salimos del programa
        cmp e,1              ;Comparamos la variable e con 1
        je premenu1             ;Si es igual quiere decir que hay error y saltamos a menu1
        cmp b2, 0
        je centenas3
        cmp b2, 1
        je decenas3
        jmp unidades3
centenas3:
        sub al, 30h
        mul c
        jmp termine3
decenas3:
        sub al, 30h
        mul d
        jmp termine3
unidades3:
        sub al, 30h
        mov ah, 0
termine3:
        add v4, ax           ;Almacenamos el numero leido en la variable v1
        inc b2
        loop SegundoNum2
        jmp siga
        
premenu1:
        jmp menu1
prefin:            ;Esta etiqueta se pone porque las demas lineas de codigo pasan de los 40bytes
        jmp fin   ;Esto se hace para poder llegar a fin
        
siga:
        call calcNum1
        call calcNum2
        cmp op,'+'            ;Comparamos el operador con '+'
        je funcsuma          ;Si es igual saltamos a funcsuma
        cmp op,'-'            ;Y asi con las demas comparaciones
        je funcresta
        cmp op,'*'
        je funcmulti
        cmp op,'/'
        je funcdivi
        mov ah,9                ;Si no es igual a ningun operador entonces
        lea dx,msg3
        int 21h   ;Imprimimos el mensaje de error de expresion
        mov ah,8                ;Servicio 8 lee un caracter sin eco(no se imprime en pantalla), crea el efecto de presiona una tecla para continuar...
        int 21h
        jmp menu1


funcsuma:
        call sumaproc      ;Mandamos llamar el procedimiento sumaproc
        jmp menu1              ;Al finalizar el procedimiento saltamos a menu1 que esta al inicio
funcresta:
        call restaproc    ;Mandamos llamar el procedimiento restaproc
        jmp menu1              ;Al finalizar el procedimiento saltamos a menu1 que esta al inicio
funcmulti:
        call multiproc    ;Mandamos llamar el procedimiento multiproc
        jmp menu1              ;Al finalizar el procedimiento saltamos a menu1 que esta al inicio
funcdivi:
        call diviproc      ;Mandamos llamar el procedimiento diviproc
        jmp menu1              ;Al finalizar el procedimiento saltamos a menu1 que esta al inicio

fin:
        mov ah,4ch
        int 21h
   main endp

;***********************************EscribeBarraDiv
   barraDiv proc near
   mov ah, 9
   lea dx, barra
   int 21h
   mov ah, 0
   mov dx, 0
   RET
   barraDiv endp
   
;**********************************Calcula el primer numero
    calcNum1 proc near
    mov ax, 0
    mov bx, 0
    mov ax, v1
    mov bx, v2
    div bx
    mov v1, ax
    RET
    calcNum1 endp
    
;**********************************Calcula el segundo numero
    calcNum2 proc near
    mov ax, 0
    mov bx, 0
    mov ax, v3
    mov bx, v4
    div bx
    mov v1, ax
    RET
    calcNum2 endp

;***********************************LEER
   leecar proc near
        mov ah,1                ;Servicio 1 para leer un caracter
        int 21h   ;El caracter leido se almacena en al

        cmp b,0   ;Comparamos nuestra variable bandera
        je numero              ;Si es igual a '0' cero entonces queremos capturar numero
        jmp operador        ;Sino entonces queremos capturar un operador
        
   numero:
        cmp al,'c'            ;Comparamos el caracter leido con 'c'
        je borra                ;Si el caracter leido es igual al caracter 'c' borramos todo y volvemos a iniciar
        cmp al,'+'            ;Comparamos el caracter leido con '+'
        je error                ;Si es igual hay un error en la expresion ya que debe de ser <NUMERO><OPERADOR><NUMERO> == 2+5
        cmp al,'-'            ;E igual para las siguientes lineas
        je error
        cmp al,'*'
        je error
        cmp al,'/'
        je error
        jmp sleecar          ;Si no es igual a las demas saltamos a la salida

   operador:
        cmp al,'c'            ;Comparamos el caracter leido con 'c'
        je borra                ;Si el caracter leido es igual al caracter 'c' borramos todo y volvemos a iniciar
        cmp al,'0'            ;Comparamos el caracter leido con '0'
        je error                ;Si es igual hay un error en la expresion ya que debe de ser <NUMERO><OPERADOR><NUMERO> == 2+5
        cmp al,'1'            ;E igual para las siguientes lineas
        je error
        cmp al,'2'
        je error
        cmp al,'3'
        je error
        cmp al,'4'
        je error
        cmp al,'5'
        je error
        cmp al,'6'
        je error
        cmp al,'7'
        je error
        cmp al,'8'
        je error
        cmp al,'9'
        je error
        jmp sleecar          ;Si no es igual a las demas saltamos a la salida

   borra:
        mov e,1   ;Cambiamos a nuestra variable e a 1 para limpiar pantalla
        jmp sleecar

   error:
        mov ah,9
        lea dx,msg3
        int 21h   ;Imprimimos el mensaje de error de expresion
        mov ah,8                ;Servicio 8 lee un caracter sin eco(no se imprime en pantalla), crea el efecto de presiona una tecla para continuar...
        int 21h
        mov e,1   ;Y hacemos a nuestra variable e a 1 para limpiar pantalla

        sleecar:
        mov ah, 0
     RET
   leecar endp
;***************************************


;***********************************MENU
   menu proc near
        mov ah,9                ;Servicio 9 para imprimir una cadena
        lea dx,ms              ;Seleccionamos la cadena ms
        int 21h   ;la imprimimos
        lea dx,lin1          ;seleccionamos la cadena lin1
        int 21h   ;la imprimimos
        lea dx,lin2          ;y asi para las demas lineas
        int 21h
        lea dx,lin3
        int 21h
        lea dx,lin4
        int 21h
        lea dx,lin5
        int 21h
        lea dx,lin6
        int 21h
        lea dx,lin7
        int 21h
        lea dx,lin8
        int 21h
        lea dx,lin9
        int 21h
        lea dx,lin10
        int 21h
        lea dx,lin11
        int 21h
        lea dx,lin12
        int 21h
        lea dx,lin13
        int 21h
        lea dx,lin14
        int 21h
        lea dx,lin15
        int 21h
     RET
   menu endp
;/***************************************




;/***********************************SUMA
   sumaproc proc near
        mov ax,v1              ;Pasamos nuestro primer valor a al
        mov bx,ax              ;Y lo pasamos a bl
        mov ax,v2              ;Pasamos nuestro segundo valor a al
        add bx,ax              ;Y lo sumamos con bl que contiene el primer numero
        
        push bx ;se guarda el valor de la suma

        mov ah,9
        lea dx,msg1
        int 21h   ;Imprimimos el mensaje de resultado
        
        pop bx; recuperamos el valor de la suma
        
        push dx ;no alteramos lo registros
        push ax
        push cx
        
        mov cx,0
        mov dx,0
        
        mov cx, 1000
        mov ax, bx
        div cx
        mov bx, dx
        mov dx, ax
        
        mov ah,02h
        add dx,30h ;imprime Milesimas
        int 21h
        
        mov cx, 100
        mov ax, bx
        div cx
        mov bx, dx
        mov dx, ax
        
        mov ah, 02h
        add dx, 30h ;imprime Centecimas
        int 21h
        
        ;error area
        mov cx, 10
        mov ax, bx
        div cx
        mov bh, ah
        mov dx, 0
        mov dh, al
        ;error area
        
        
        mov ah, 02h
        add dh, 30h ;imprime Decenas
        int 21h
        
        mov dh, bh
        add dh, 30h ;imprime Unidades
        int 21h
        
        pop cx
        pop ax
        pop dx ;dejamos los valores como estaban para no da?ar el programa
        
     RET
   sumaproc endp
;/***************************************




;/**********************************RESTA
   restaproc proc near
        mov ax,v1            ;Le restamos 30h para convertirlo a numero
        mov bx,ax              ;Y lo pasamos a bl
        mov ax,v2           ;Le restamos 30h para convertirlo a numero
        sub bx,ax              ;Restamos bl - al

        mov ah,9
        lea dx,msg1
        int 21h   ;Imprimimos el mensaje de resultado
        
        mov cx, 100
        mov ax, bx
        div cx
        mov bx, dx
        mov dx, ax
        
        mov ah, 02h
        add dx, 30h ;imprime Centecimas
        int 21h
        
        ;error area
        mov cx, 10
        mov ax, bx
        div cx
        mov bh, ah
        mov dx, 0
        mov dh, al
        ;error area
        
        
        mov ah, 02h
        add dh, 30h ;imprime Decenas
        int 21h
        
        mov dh, bh
        add dh, 30h ;imprime Unidades
        int 21h
     RET
   restaproc endp
;/***************************************




;/*************************MULTIPLICACI?N
   multiproc proc near
        mov ax,v1             
        mov bx,ax              ;Y lo pasamos a bl
        mov ax,v2             
        mul bx                 ;Multiplicamos AX con BX
        
        push ax    ;guardamos el resultado de la operacion

        mov ah,9
        lea dx,msg1
        int 21h   ;Imprimimos el mensaje de resultado
        
        
        
        pop ax   ;sacamos el resultado de la multiplicacion
        
        push dx ;no alteramos lo registros
        push ax
        push cx
        
        mov dx,0
        
        mov cx, 10000
        div cx
        mov bx, dx
        mov dx, ax
        
        mov ah,02h
        add dx,30h ;imprime Diez-Milesimas
        int 21h
        
        mov cx, 1000
        mov ax, bx
        div cx
        mov bx, dx
        mov dx, ax
        
        mov ah,02h
        add dx,30h ;imprime Milesimas
        int 21h
        
        mov cx, 100
        mov ax, bx
        div cx
        mov bx, dx
        mov dx, ax
        
        mov ah, 02h
        add dx, 30h ;imprime Centecimas
        int 21h
        
        ;error area
        mov cx, 10
        mov ax, bx
        div cx
        mov bh, ah
        mov dx, 0
        mov dh, al
        ;error area
        
        
        mov ah, 02h
        add dh, 30h ;imprime Decenas
        int 21h
        
        mov dh, bh
        add dh, 30h ;imprime Unidades
        int 21h
        
        pop cx
        pop ax
        pop dx ;dejamos los valores como estaban para no da?ar el programa

       
     RET
   multiproc endp
;/***************************************


;/*******************************DIVISI?N
   diviproc proc near
        mov ax,v1              ;Pasamos nuestro primer valor a al

        mov bx,ax              ;Y lo pasamos a bl
        mov ax,v2              ;Pasamos nuestro segundo valor a al

        xchg ax,bx            ;Intercambiamos los valores de AX con BX y viceversa
        cwd               ;Cambiamos AX de word a dobleword para que tenga capacidad el programa de dividir
        div bx      ;Dividimos.. Siempre divide AX/BX el resultado lo almacena en AX, el residuo queda en DX
        mov bx,ax              ;Pasamos el resultado a bx
        mov b,dl                ;Pasamos el residuo a b

        mov ah,9
        lea dx,msg1
        int 21h   ;Imprimimos el mensaje de resultado
             
        mov cx, 100
        mov ax, bx
        div cx
        mov bx, dx
        mov dx, ax
        
        mov ah, 02h
        add dx, 30h ;imprime Centecimas
        int 21h
        
        ;error area
        mov cx, 10
        mov ax, bx
        div cx
        mov bh, ah
        mov dx, 0
        mov dh, al
        ;error area
        
        
        mov ah, 02h
        add dh, 30h ;imprime Decenas
        int 21h
        
        mov dh, bh
        add dh, 30h ;imprime Unidades
        int 21h

        cmp b,0   ;Comparamos la variable que contiene el residuo con 0
        jg residuo            ;Si es mayor de 0 quiere decir que hay residuo y saltamos a la etiqueta residuo
        jmp dsal                ;Si es igual a 0 el residuo no hay residuo y saltamos a la etiqueta dsal

residuo:
        mov ah,9                ;Servicio 9 para imprimir cadenas
        lea dx,resi          ;Seleccionamos la cadena contenida en resi
        int 21h   ;Imprimimos

        mov ah,2                ;Servicio 2 para imprimir un caracter contenido en dl
        mov dl,b                ;Pasamos a dl el valor del residuo
        add dl,30h            ;Sumamos 30h a dl para convertirlo a caracter
        int 21h   ;Imprimimos el resultado

dsal:
     RET
   diviproc endp
;/***************************************



end main

