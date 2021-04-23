#lang racket
(require graph)

;OBTENEMOS UN ELEMENTO DE LA LISTA (USAMOS LIST-REF DE UN LIST-REF)
(define get (λ( lst y x ) (
    list-ref (list-ref lst y) x)
))

;;SETAMOS UN ELEMENTO EN LA MATRIX. DEVOLVEMOS UNA MATRIX 
(define set (λ( lst y x symbl)(
    list-set lst y (list-set (list-ref lst y) x symbl)
)))

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
;AÑADE ELEMENTO A LA LISTA
(define (list-with lst idx val)
  (if (null? lst)
    lst
    (cons
      (if (zero? idx)
        val
        (car lst))
      (list-with (cdr lst) (- idx 1) val))))

;EDITA UN ELEMENTO DE LA LISTA           
(define (set-element-matrix matrix i j value)
  (cond
    [(empty? matrix) '()]
    [(= i 0)      (cons (list-with (car matrix) j value)
                        (cdr matrix))]
    [else         (cons (car matrix)
                        (set-element-matrix (cdr matrix) (- i 1) j value))]))
;GENERA RANDOM MAYOR A 0 Y MENOR A 7
(define (random-xy)
  (define x (random 7))
  (cond
    [(= x 0)(add1 x)  ]
    [else x ]
    ))


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
     (define temp (random 4))
       (if(= temp 0) 
           (list (sub1 x) (sub1 y))
           (if(= temp 1)
              (list (sub1 x) (sub1 y))
              temp
           ))
           
       ]
    )
 )


;MATRIZ DE PRUEBA
(define maze-test '(
  (0   0     0       0     0     0     0   0)
  (0 (1 1)   0     (1 3) (1 4) (1 5) (1 6) 0)
  (0 (2 1) (2 2)   (2 3)   0     0   (2 6) 0)
  (0 (3 1) (3 2)   (3 3)   0     0   (3 6) 0)
  (0 (4 1) (4 2)   (4 3)   0     0   (4 6) 0)
  (0   0     0       0     0     0     6   0)
  (0   0     0       0     0     0     0   0)
  (0   0     0       0     0     0     0   0)))

;PUNTO DE LLEGADA
(define posx (random-xy))
(define posy (random-xy))
(define maze(set (make-maze 8 1) posx posy 6))
;(define maze maze-test)

;GRAFO VACIO
(define graph-solve (weighted-graph/undirected '()))

;AÑADE EL ELEMENTO DE UNA LISTA A UN GRAFO SI ESTE NO ES 0
(define (add-list-to-graph list-to-add graph-to-insert)
  (cond
    [(empty? list-to-add) '()]
    [else
     (cond
       [(eq? (car list-to-add) 0)]
       [(eq? (car list-to-add) 2)]
       [(eq? (car list-to-add) 3)]
       [(eq? (car list-to-add) (add-vertex! graph-to-insert (list posx posy)))]
       [else (add-vertex! graph-to-insert (car list-to-add))]
       )(add-list-to-graph (cdr list-to-add) graph-to-insert)]))

;MANDA TODAS LAS FILAS A ADD-LIST-TO-GRAPH
(define (change-matrix-to-graph matrix-to-change graph-to-insert)
  (cond
    [(empty? matrix-to-change) '()]
    [else (add-list-to-graph (car matrix-to-change) graph-to-insert)
          (change-matrix-to-graph (cdr matrix-to-change) graph-to-insert)]))

;MANDA TODOS LOS ELEMENTOS DEL GRAFO A VER SI ESTAN RELACIONADOS
;DE ESTA FORMA
;(X, Y) si es un vertice => si (x-1,y) (x+,y) (x,y-1) (x,y+1) alguno es vertice
;entonces relaciona (X, Y) con el correspondiente correcto
(define (related-graph graph-to-join i j)
  (cond
    [(= i 8)"DONE"]
    [else
     (related-graph-aux graph-to-join i j)
     (related-graph graph-to-join (add1 i) j)      
     ]

    )
  )

(define (related-graph-aux graph-to-join i j)
  (cond
    [(= j 8) 0]
    [else
     (cond [(has-vertex? graph-to-join (list i j)) 
           (cond 
            [(has-vertex? graph-to-join (list (sub1 i) j))
             (add-edge! graph-to-join (list i j) (list (sub1 i) j) 1)])      
            (cond
              [(has-vertex? graph-to-join (list i (sub1 j)))
             (add-edge! graph-to-join (list i j) (list i (sub1 j)) 1)])
            (cond
            [(has-vertex? graph-to-join (list  i (add1 j)))
             (add-edge! graph-to-join (list i j) (list  i (add1 j)) 1)])
            (cond
            [(has-vertex? graph-to-join (list (add1 i) j))
             (add-edge! graph-to-join (list i j) (list (add1 i) j) 1)])
           ]
          )
     (related-graph-aux graph-to-join i (add1 j))
     ]))


;LLAMA A LA FUNCION QUE CONVIERTE UNA MATRIZ, A UN GRAFO
(change-matrix-to-graph maze graph-solve)
;LLAMA A LA FUNCION QUE RELACIONA LOS NODOS DEL GRAFO
(related-graph graph-solve 0 0)
;ENCUENTRA LA RUTA MÁS CORTA Y GUARDA EN LAS VARIABLES
;(define-values (quantity road) (dijkstra graph-test '(2 3)))
;DUELVE UNA LISTA CON LA SOLUCION SI EXISTE
(define (get-in-list-solve-path hash-to-change initial-key)
  (cond
    [(eq? initial-key #f) '()]
    [else
     (append (list initial-key) (get-in-list-solve-path hash-to-change (hash-ref hash-to-change initial-key)))
     ]))

;SETEA EN UNA MATRIZ LOS VALORES DE UNA LISTA

(define (back-to-matrix maze list-with-solves i)
  (cond
    [(= i (length list-with-solves)) maze]
    [else
     (define x (list-ref list-with-solves i))
     (back-to-matrix (set maze (list-ref x 0) (list-ref x 1) 4) list-with-solves (add1 i)) 
     ]
    ))

 
;(define solve (get-in-list-solve-path road '(1 1)))
;INPUT
(define (get-number) ; Acá definimos la funcion input
   (display "Ingrese un numero: ") ;Print
   (string->number(read-line (current-input-port) 'any)));Esto lo leo como un input de un strig

;; Prints the maze
(define print (λ(x)(
    if (not (empty? x) )
       (begin
        (writeln (car x))
        (print (cdr x))
        )
        (writeln 'Done)
)))


(define (main)
  (print maze);ACA SE MUESTRA EL LABERINTO
  (define-values (quantity road) (dijkstra graph-solve (list posx posy)))
  (display "DIGITE PUNTO PARTIDA\n")
  (define x (get-number))
  (define y (get-number))
  (cond
    [(has-vertex? graph-solve (list x y))
     (define solve (get-in-list-solve-path road (list x y)))
       (if (=  1 (length solve))
           (display "NO HAY SOLUCION")
           (back-to-matrix maze solve 0);ACÁ SE MUESTRA LA SOLUCION
       )
     ]
    [else (display "PUNTO INVALIDO")]
    )
)
  
  
(main)