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
                       (inner (- j 1) (cons (if (= i j) 0 0) row))))
                 result)))))
;INPUT
(define (get-number) 
   (display "Ingrese el tamaño del tablero: ")
   (string->number(read-line (current-input-port) 'any)))


;OBTENEMOS EL TAMAÑO DEL TABLERO
(define table-size (get-number))

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