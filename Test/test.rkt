#lang racket

;CREA UNA MATRIZ
(define (make-matrix n choice)
  (let outter ((i n) (result '()))
    (if (= i 0)
        result
        (outter (- i 1) 
                (cons 
                 (let inner ((j n) (row '()))
                   (if (= j 0)
                       row
                       (cond
                         [(eq? choice 1)(inner (- j 1) (cons (if (= i j) (random 2) (random 2)) row))]
                         [(eq? choice 0)(inner (- j 1) (cons (if (= i j) 0 0) row))]
                         )
                       ))
                 result)))))
;DEVUELVE EL ELMENTO N DE UNA LISTA
(define (nth list n)
  (let iter ((n n) (result list))
    (if (= n 0)
        (car result)
        (iter (- n 1)
              (cdr result)))))
;DEVUELVE EL ELEMENTO EN X, Y
(define (nthMatrix matrix x y)
  (define tempList (nth matrix x))
  (nth tempList y))

;CAMBIAR ELEMENTO EN UNA LISTA (recibe la lista, el index donde se desea cambiar, y el valor) 
(define (list-with lst idx val)
  (if (null? lst)
    lst
    (cons
      (if (zero? idx)
        val
        (car lst))
      (list-with (cdr lst) (- idx 1) val))))

;Funcion que edita un elemento de la matriz           
(define (set-element-matrix matrix i j value)
  (cond
    [(empty? matrix) '()]
    [(= i 0)      (cons (list-with (car matrix) j value)
                        (cdr matrix))]
    [else         (cons (car matrix)
                        (set-element-matrix (cdr matrix) (- i 1) j value))]))








;MAZE SIZE
(define N 4)

;A utility function to check if x, y is valid
; index for N * N Maze

(define (isSafe maze x y)
   (cond
    [(and (>= x 0) (< x N) (>= y 0) (< y N) (= (nthMatrix maze x y)1)) #t]
    [else #f]
   )
  )


(define (solveMaze maze)
  (define sol (make-matrix N 0))
  (cond
    [(eq? (solveMazeUtil maze 0 0 sol) #f) (display "No hay solucion")]
    [else (display sol)]
   ))
    
(define (solveMazeUtil maze x y sol)
  (display sol)
  (display "\n")
  (cond
    
    [(and (= x (sub1 N)) (= y (sub1 N)) (= (nthMatrix maze x y)1)) #t]
    [(isSafe maze x y) 
     (cond
          [(= (nthMatrix sol x y) 1) #f]
     )
     sol (set-element-matrix sol x y 1)
     (cond
          [(solveMazeUtil maze (add1 x) y sol)#t]
          [(solveMazeUtil maze x  (add1 y) sol)#t]
          [(solveMazeUtil maze (sub1 x)  y sol)#t]
          [(solveMazeUtil maze x  (sub1 y) sol)#t]
          [else (sol (set-element-matrix sol x y 0)) #f]
          )
     ]
))

(define (Go)
  (define maze '((1 0 0 0) (1 1 0 1) (0 1 0 0) (1 1 1 1)))
  (solveMaze maze))



(define maze '(
        ("#" "#" "#" "#" "#" "#" "#" "#" "#" "#")
        ("#" " " "#" " " " " " " " " " " " " "#")
        ("#" " " "#" " " "#" "#" "#" "#" " " "#")
        ("#" " " "#" " " "#" " " " " "#" " " "#")
        ("#" " " "#" " " "#" "#" " " " " " " "#")
        ("#" " " "#" " " " " " " "#" "#" " " "#")
        ("#" " " "#" " " "#" " " "#" "F" " " "#")
        ("#" " " "#" " " "#" " " "#" "#" "#" "#")
        ("#" " " " " " " "#" " " " " " " " " "#")
        ("#" "#" "#" "#" "#" "#" "#" "#" "#" "#")
    )
)

;; Prints the maze
(define print (λ(x)(
    if (not (empty? x) )
       (begin
        (writeln (car x))
        (print (cdr x))
        )
        (writeln 'Done)
)))


;; Get the element on the position (x,y) of the matrix
(define get (λ( lst x y ) (
    list-ref (list-ref lst y) x)
))
;; Sets element on the position (x,y) of the matrix
(define set (λ( lst x y symbl)(
    list-set lst y (list-set (list-ref lst y) x symbl)
)))


(define dfs
  (λ (lab x y)
    (if (string=? (get lab x y) "F")
        (print lab)
        (begin0
          (cond [(or (string=? (get lab (+ x 1) y) " ")
                     (string=? (get lab (+ x 1) y) "F"))
                 (dfs (set lab x y ".") (+ x 1) y)])
          (cond [(or (string=? (get lab (- x 1) y) " ")
                     (string=? (get lab (- x 1) y) "F"))
                 (dfs (set lab x y ".") (- x 1) y)])
          (cond [(or (string=? (get lab x (+ y 1)) " ")
                     (string=? (get lab x (+ y 1)) "F"))
                 (dfs (set lab x y ".") x (+ y 1))])
          (cond [(or (string=? (get lab x (- y 1)) " ")
                     (string=? (get lab x (- y 1)) "F"))
                 (dfs (set lab x y ".") x (- y 1))])))))



(define (randomObs N)
  (define n (random N))
  (cond
    [(eq? n 0) (add1 n)]
    [(eq? n 0) (add1 n)]
    )
         )
