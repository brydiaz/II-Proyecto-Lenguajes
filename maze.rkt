#lang racket

(require rackunit
         math/matrix
         racket/unit
         racket/match
         racket/list
         data/heap
         2htdp/image
         racket/runtime-path
         graph)

;DEFINE LA ESTRUCTURA DEL GRAFO
(define-signature graph^
  (node? edge? node-edges edge-src edge-cost edge-dest))

;CREA UNA MATRIZ DE NXN CON NUMEROS ALEATORIOS ENTRE 1 2 3
(define (make-map N)
  (build-matrix N N (λ (x y) (random 3))))
;NODO DEL MAPA
(struct map-node (M x y) #:transparent)
;ARISTA DEL MAPA
(struct map-edge (src dx dy dest))
;TODO LO QUE ESTÉ DENTRO DE ESTO ES EL MAPA
(define-unit map@
  ;IMPORTA LA ESTRUCTURA DEL GRAFO
  (import) (export graph^)
  ;EL NODO AHORA ES UN NODO DEL MAPA
  (define node? map-node?)
  ;LA ARISTA ES UNA ARISTA DEL MAPA
  (define edge? map-edge?)
  
  (define edge-src map-edge-src)
  (define edge-dest map-edge-dest)
  ;DEFINE EL COSTO DE CADA ARISTA
  (define (edge-cost e)
    (match-define (map-edge _ _ _ (map-node M x y)) e)
    (match (matrix-ref M x y)
      [0  1]
      [1  5]
      [2 10]))
  ;DEFINE LAS ARISTAS DE LOS NODOS
  (define (node-edges n)
  (match-define (map-node M x y) n)
  (append*
   (for*/list ([dx (in-list '(1 0 -1))]
               [dy (in-list '(1 0 -1))]
               #:when
               (and (not (and (zero? dx) (zero? dy)))
                    (or (zero? dx) (zero? dy))))
     (cond
       [(and (<= 0 (+ dx x) (sub1 (matrix-num-cols M)))
             (<= 0 (+ dy y) (sub1 (matrix-num-rows M))))
        (define dest (map-node M (+ dx x) (+ dy y)))
        (list (map-edge n dx dy dest))]
       [else
        empty]))))
  )

;EMPIEZA EL ALGORITMO A*
(define (A* graph@ initial node-cost)
  ;RECIBE UN GRAFO SU INICIO Y EL COSTO DEL NODO DEL FINAL
  (define-values/invoke-unit graph@ (import) (export graph^))
  (define count 0)
  ; CREA DOS HASH PARA GUARDAR EL MEJOR CAMINO, Y OTRO CON EL COSTO
  (define node->best-path (make-hash))
  (define node->best-path-cost (make-hash))
 ;LO INICIA EN VACIO Y OTRO EN 0
  (hash-set! node->best-path      initial empty)
  (hash-set! node->best-path-cost initial 0)

  (define (node-total-estimate-cost n)
    (+ (node-cost n) (hash-ref node->best-path-cost n)))
  (define (node-cmp x y)
    (<= (node-total-estimate-cost x)
      (node-total-estimate-cost y)))
  (define open-set (make-heap node-cmp))
  (heap-add! open-set initial)

   (begin0
    (let/ec esc
      (for ([x (in-heap/consume! open-set)])
        (set! count (add1 count))
        (define h-x (node-cost x))
        (define path-x (hash-ref node->best-path x))
 
        (when (zero? h-x)
          (esc (reverse path-x)))
        (define g-x (hash-ref node->best-path-cost x))
        (for ([x->y (in-list (node-edges x))])
          (define y (edge-dest x->y))
          (define new-g-y (+ g-x (edge-cost x->y)))
          (define old-g-y
            (hash-ref node->best-path-cost y +inf.0))
          (when (< new-g-y old-g-y)
            (hash-set! node->best-path-cost y new-g-y)
            (hash-set! node->best-path y (cons x->y path-x))
            (heap-add! open-set y)))) #f)
    (printf "visited ~a nodes\n" count)))

(define ((make-node-cost GX GY) n)
  (match-define (map-node M x y) n)
  (+ (abs (- x GX))
     (abs (- y GY))))


(define N 10)
(define random-M
  (make-map N))
(define random-path
  (time
   (A* map@
       (map-node random-M 0 0)
       (make-node-cost (sub1 N) (sub1 N)))))

(define map-scale 15)
(define (type-color ty)
  (match ty
    [0 "yellow"]
    [1 "green"]
    [2 "red"]))
(define (cell-square ty)
  (square map-scale "solid" (type-color ty)))
(define (row-image M row)
  (apply beside
         (for/list ([col (in-range (matrix-num-cols M))])
           (cell-square (matrix-ref M row col)))))
(define (map-image M)
  (apply above
         (for/list ([row (in-range (matrix-num-rows M))])
           (row-image M row))))

(define (edge-image-on e i)
  (match-define (map-edge (map-node _ sx sy) _ _ (map-node _ dx dy)) e)
  (add-line i
            (* (+ sy 0.5) map-scale) (* (+ sx 0.5) map-scale)
            (* (+ dy 0.5) map-scale) (* (+ dx 0.5) map-scale)
            "black"))

(define (path-image M path)
  (foldr edge-image-on (map-image M) path))


(define-runtime-path map-image.png "2013-04-15-astar-map.png")
(save-image (map-image random-M) map-image.png)
 
(define-runtime-path path-image.png "2013-04-15-astar-path.png")
(save-image (path-image random-M random-path) path-image.png)
