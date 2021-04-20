
#lang racket

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
  (0 1 0 1 1 1 1 0)
  (0 1 0 1 0 0 1 0)
  (0 1 0 1 0 0 1 0)
  (0 1 1 1 0 2 1 0)
  (0 1 0 0 0 1 0 0)
  (0 1 1 1 1 1 0 0)
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
(define (neighbor-is-1? maze x y)
  (cond
    [(= (get maze (add1 x) y) 1) 1]
    [(= (get maze (sub1 x) y) 1) 2]
    [(= (get maze x (add1 y)) 1) 3]
    [(= (get maze x (sub1 y)) 1) 4]
    [else -1]
  )
)

;Funcion que recibe ayuda a cambiar el (x y)
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
    

;(define x1 (find-path  maze-test 1 1 '(1 1)))