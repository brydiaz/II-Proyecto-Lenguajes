
#lang racket

;Nota, abajo, arriba, derecha, izquierda

;IMPRIMOS EL LABERINTO
(define print (λ(x)(
    if (not (empty? x) )
       (begin
        (writeln (car x))
        (print (cdr x))
        )
        (writeln 'Done)
)))


;OBTENEMOS UN ELEMENTO DE LA LISTA (USAMOS LIST-REF DE UN LIST-REF)
(define get (λ( lst x y ) (
    list-ref (list-ref lst x) y)
))

;;SETAMOS UN ELEMENTO EN LA MATRIX. DEVOLVEMOS UNA MATRIX 
(define set (λ( lst x y symbl)(
    list-set lst x (list-set (list-ref lst x) y symbl)
)))


;PARA PRUEBAS
(define maze-test '(
  (0 0 0 0 0 0 0 0)
  (0 1 1 1 1 1 1 0)
  (0 1 0 1 0 0 1 0)
  (0 1 1 1 0 0 0 0)
  (0 1 1 1 1 2 1 0)
  (0 1 0 0 1 1 0 0)
  (0 1 1 1 1 0 0 0)
  (0 0 0 0 0 0 0 0)))


;Funcion que determina si una posicion tiene un vecino 2
;a su derecha, izquierda, arriba o abajo y retorna #t en
;contrario retorna #f
(define (neighbor-is-two? maze x y)
  (cond
    [(= (get maze (add1 x) y) 2) 1]
    [(= (get maze (sub1 x) y) 2) 2]
    [(= (get maze x (add1 y)) 2) 3]
    [(= (get maze x (sub1 y)) 2) 4]
    [else -1]
  )
)

;Funcion que determina si una posicion tiene un vecino 4
;a su derecha, izquierda, arriba o abajo y retorna #t en
;contrario retorna #f
(define (neighbor-is-four? maze x y)
  (cond
    [(= (get maze (add1 x) y) 4) 1]
    [(= (get maze (sub1 x) y) 4) 2]
    [(= (get maze x (add1 y)) 4) 3]
    [(= (get maze x (sub1 y)) 4) 4]
    [else -1]
  )
)

;Funcion que determina si una posicion tiene un vecino 1
;a su derecha, izquierda, arriba o abajo y retorna #t en
;contrario retorna #f
(define (neighbor-is-one? maze x y)
  (cond
    [(= (get maze (add1 x) y) 1) 1]
    [(= (get maze (sub1 x) y) 1) 2]
    [(= (get maze x (add1 y)) 1) 3]
    [(= (get maze x (sub1 y)) 1) 4]
    [else -1]
  )
)

;Funcion que ayuda a cambiar el (x y)
;dependiendo del movimiento(derecha,izquierda,arriba,abajo)
;type=1 es una x, type=2 es una y
(define (x-y-update input type move-address)
  (cond
    [(and(= type 1) (= move-address 1))(add1 input)]
    [(and(= type 1) (= move-address 2))(sub1 input)]
    [(and(= type 1) (= move-address 3))input]
    [(and(= type 1) (= move-address 4))input]
    
    [(and(= type 2) (= move-address 1))input]
    [(and(= type 2) (= move-address 2))input]
    [(and(= type 2) (= move-address 3))(add1 input)]
    [(and(= type 2) (= move-address 4))(sub1 input)]
   )
)


(define (find-path maze x y)
  (find-path-aux maze x y (list x y) 0 '() '() ))

(define (find-path-aux maze x y start stepCounter currentPath bestPath)
  (print maze)
  ;(print x)
  ;(print y)
  ;(print start)
  ;(print stepCounter)
  ;(print currentPath)
  ;(print bestPath)
  (cond
    ;[(= (get maze x y) 2) maze]
    ;(x y) en start y no existe movimiento disponible, retorna maze
    [(and (and (= x (car start)) (= y (car(cdr start)))) (=(neighbor-is-one? maze x y)-1))maze]

    
    ;Si actual es 4 ,tiene vecino 2 y es mejor camino
    [(and (and (= (get maze x y) 4) (> (neighbor-is-two? maze x y) 0)) (< stepCounter (length bestPath)))
        (find-path-aux maze
                   ;Se retrocede en el camino actual
                   (caar currentPath) (car(cdr(car currentPath)))
                   start ( - stepCounter 1) (cons (cdr currentPath) '()) currentPath
        )]
    ;Si actual es 4 ,tiene vecino 2 y no es mejor camino
    [(and (= (get maze x y) 4) (> (neighbor-is-two? maze x y) 0))
        (find-path-aux maze
                   ;Se retrocede en el camino actual
                   (caar currentPath) (car(cdr(car currentPath)))
                   start ( - stepCounter 1) (cons (cdr currentPath) '()) bestPath
        )]
    
    ;Si actual es 1, tiene vecino 2 y es mejor camino
    [(and (and (= (get maze x y) 1) (> (neighbor-is-two? maze x y) 0)) (< stepCounter (length bestPath)))
        (find-path-aux (set maze x y 4)
                   ;Se retrocede en el camino actual
                   (caar currentPath) (car(cdr(car currentPath)))
                   start ( - stepCounter 1) (cons (cdr currentPath) '()) currentPath
        )]

    ;Si actual es 1, tiene vecino 2 y aun no habia camino
    [(and(and (= (get maze x y) 1) (> (neighbor-is-two? maze x y) 0)) (= (length bestPath)0))
        (find-path-aux (set maze x y 4)
                   ;Se retrocede en el camino actual
                   (caar currentPath) (car(cdr(car currentPath)))
                   start ( - stepCounter 1) (cdr currentPath) currentPath
        )]

    #|
    ;Si actual es 4, tiene vecino 4 y vecino-vecino tiene 1
    [(and (and (= (get maze x y) 4) (> (neighbor-is-four? maze x y) 0))
          (> (neighbor-is-one? maze (x-y-update input type move-address) y) 0))
        (find-path maze
                   
                   (caar currentPath) (car(cdr(car currentPath)))
                   start ( - stepCounter 1) (cons (cdr currentPath) '()) currentPath
        )]
    |#
    

    ;Si actual es 4 y tiene vecino 1
    [(and (= (get maze x y) 4) (> (neighbor-is-one? maze x y) 0))
        (find-path-aux maze
                   (x-y-update x 1 (neighbor-is-one? maze x y))
                   (x-y-update y 2 (neighbor-is-one? maze x y))
                   start ( + stepCounter 1) (cons (list x y) currentPath) bestPath
        )]

    ;Si actual es 4, tiene vecino 4
    [(and (= (get maze x y) 4) (> (neighbor-is-four? maze x y) 0))
        (find-path-aux maze
                   ;Se retrocede en el camino actual
                   (caar currentPath) (car(cdr(car currentPath)))
                   start ( - stepCounter 1) (cdr currentPath) bestPath
        )]
    
    
    ;Si actual es 1 y tiene vecino 1
    [(and (= (get maze x y) 1) (> (neighbor-is-one? maze x y) 0))
        (find-path-aux (set maze x y 4)
                   (x-y-update x 1 (neighbor-is-one? maze x y))
                   (x-y-update y 2 (neighbor-is-one? maze x y))
                   start ( + stepCounter 1) (cons (list x y) currentPath) bestPath)]
    #|
    ;Si actual es 1 y tiene vecino 4
    [(and (= (get maze x y) 1) (> (neighbor-is-one? maze x y) 0))
        (find-path (set maze x y 4)
                   (x-y-update x 1 (neighbor-is-one? maze x y))
                   (x-y-update y 2 (neighbor-is-one? maze x y))
                   start ( + stepCounter 1) (cons '(x y) currentPath) bestPath
        )]
    |#
    [else -1]
    #|(find-path-aux maze
                   ;Se retrocede en el camino actual
                   (caar currentPath) (car(cdr(car currentPath)))
                   start ( - stepCounter 1) (cdr currentPath) bestPath
        )|#
  )
)

(define x1 (find-path  maze-test 1 1))

;(define M3 '())
; M3
;(cons '(1 2) M3)

;Cambio de (x y)
;(x-y-update x 1 (neighbor-is-two? maze x y))
;(x-y-update y 2 (neighbor-is-two? maze x y))
