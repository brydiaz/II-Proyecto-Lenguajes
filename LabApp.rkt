#lang racket

;Funcion para crear una matriz de tamaño nxn
(define (make-matrix n)
  (let outter ((i n) (result '()))
    (if (= i 0)
        result
        (outter (- i 1) 
                (cons 
                 (let inner ((j n) (row '()))
                   (if (= j 0)
                       row
                       (inner (- j 1) (cons (if (= i j) (random 2) (random 2)) row))))
                 result)))))
;INPUT
(define (get-number choice)
  (cond
    [(eq? choice 0)(display "Ingrese el tamaño del tablero: ")]
    [(eq? choice 1)(display "Ingrese el punto de partida en X: ")]
    [(eq? choice 2)(display "Ingrese el punto de partida en Y: ")])
   (string->number(read-line (current-input-port) 'any)))


;OBTENEMOS EL TAMAÑO DEL TABLERO
(define table-size (get-number 0))

;EN TABLE QUEDA EL TABLERO
(define table (make-matrix table-size))

;CAMBIAR ELEMENTO EN UNA LISTA (recibe la lista, el index donde se desea cambiar, y el valor) 
(define (list-with lst idx val)
  (if (null? lst)
    lst
    (cons
      (if (zero? idx)
        val
        (car lst))
      (list-with (cdr lst) (- idx 1) val))))

;DEVUELVE EL ELMENTO N DE UNA LISTA
(define (nth list n)
  (let iter ((n n) (result list))
    (if (= n 0)
        (car result)
        (iter (- n 1)
              (cdr result)))))


;OBTIENE UNA COLUMNA DE LA MATRIZ
(define (matrix-col M n)
  (let iter ((i (length M)) (result '()))
    (if (= i 0)
        result
        (iter (- i 1)
              (cons (nth (nth M (- i 1)) n) result)))))
              
;Funcion que edita un elemento de la matriz           
(define (set-element-matrix matrix i j value)
  (cond
    [(empty? matrix) '()]
    [(= i 0)      (cons (list-with (car matrix) j value)
                        (cdr matrix))]
    [else         (cons (car matrix)
                        (set-element-matrix (cdr matrix) (- i 1) j value))]))

;CREA UN PUNTO ALEATORIO EN EL TABLERO
(define (random-make-point table distintion)
  (set-element-matrix table (random table-size) (random table-size) distintion))

;PEDIR PUNTO DE PARTIDA

(define (user-make-point table distintion)
  (set-element-matrix table (get-number 1) (get-number 2) distintion))

;FINAL-TABLE GUARDA EL LABERINTO GENERADO
(define table-with-come (user-make-point table 2))
(define final-table (random-make-point table-with-come 3))


(define (nthMatrix matrix x y)
  (define tempList (nth matrix x))
  (nth tempList y))