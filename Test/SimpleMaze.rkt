#lang racket

;CREA UNA MATRIZ DE NXN, SI RECIBE UN 1 COMO CHOICE
;LA HARÁ BINARIA SI RECIBE 0 LA HARÁ LLENA DE 0
(define (make-maze n choice)
  (let outter ((i n) (result '()))
    (if (= i 0)
        result
        (outter (- i 1) 
                (cons 
                 (let inner ((j n) (row '()))
                   (if (= j 0)
                       row
                       (cond
                         [(eq? choice 1)(inner (- j 1) (cons (if (= i j) (randomObs n i j) (randomObs n i j)) row))]
                         [(eq? choice 0)(inner (- j 1) (cons (if (= i j) 0 0) row))]
                         )
                       ))
                 result)))))

;FUNCIONA PARA CREAR "OBSTACULOS"
;OJO, NO SE PONEN CUANDO X O Y SEAN 1
;O IGUALES A N, DEBIDO A QUE ASÍ NO DEBEMOS
;VALIDAR SI ESTAMOS FUERA DE RANGO DE LA MATRIX
(define (randomObs N x y)
  (cond
    [(eq? y 1) 0]
    [(eq? y  N) 0]
    [(eq? x 1) 0]
    [(eq? x  N) 0]
    [else
     (define temp (random 3))
       (if (= temp 2)
           1
           temp)
       ]
    )
 )

;OBTENEMOS UN ELEMENTO DE LA LISTA (USAMOS LIST-REF DE UN LIST-REF)
(define get (λ( lst x y ) (
    list-ref (list-ref lst y) x)
))

;;SETAMOS UN ELEMENTO EN LA MATRIX. DEVOLVEMOS UNA MATRIX 
(define set (λ( lst x y symbl)(
    list-set lst y (list-set (list-ref lst y) x symbl)
)))


;IMPRIMOS EL LABERINTO
(define print (λ(x)(
    if (not (empty? x) )
       (begin
        (writeln (car x))
        (print (cdr x))
        )
        (writeln 'Done)
)))

;NO SE HA USADO TODAVIA
(define make-final-matrix (λ(x i c)(
                                    
    if (not (= i c) )
       (begin
         (append (list (car x)) (make-final-matrix (cdr x) (add1 i) c))
        )
       '()
       )
     )
)



;LABERINTO DE 8X8
(define maze (make-maze 8 1))

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
;OBTIENE EL CAMINO
(define (find-path maze x y)
  (cond
    [(= (get maze x y) 2) maze]
    [( or (= (get maze (add1 x) y) 1) (= (get maze (add1 x) y) 2))
            (find-path (set maze x y 4) (add1 x) y)]
    [( or (= (get maze (sub1 x) y) 1) (= (get maze (sub1 x) y) 2))
            (find-path (set maze x y 4) (sub1 x) y)]
    [( or (= (get maze x (add1 y)) 1) (= (get maze x (add1 y)) 2))
            (find-path (set maze x y 4) x (add1 y))]
    [( or (= (get maze x (sub1 y)) 1) (= (get maze x (sub1 y)) 2))
            (find-path (set maze x y 4) x (sub1 y))]
    [else -1]
    )
  )

;ACA SE VE LA SOLUCION
(define x1 (find-path  maze-test 1 1 ))