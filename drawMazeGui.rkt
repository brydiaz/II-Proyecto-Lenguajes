
#lang racket/gui

;Este archivo muestra en una ventana de gui
;un laberinto(matriz) con imagenes

;Se importan los paquetes necesarios
(require graph)
(require 2htdp/image)

;Se definen las imagenes como bitmap para dibujarlas en el canvas
(define path (make-object bitmap% "img/path.png"))
(define path2 (make-object bitmap% "img/path2.png"))
(define obs1 (make-object bitmap% "img/obs1.png"))
(define obs2 (make-object bitmap% "img/obs2.png"))
(define sol (make-object bitmap% "img/sol.png"))
(define hit (make-object bitmap% "img/hit.png"))

;MATRIZ DE PRUEBA
(define maze-test '(
  (0   0     0       0     0     0     0   0)
  (0 (1 1)   0     (1 3) (1 4) (1 5) (1 6) 0)
  (0 (2 1) (2 2)   (2 3)   4     0   (2 6) 0)
  (0 (3 1) (3 2)   (3 3)   0     0   (3 6) 0)
  (0 (4 1) (4 2)   (4 3)   0     0   (4 6) 0)
  (0   0     3       2     0     0     6   0)
  (0   0     0       0     0     0     0   0)
  (0   0     0       0     0     0     0   0)))

;Se crea la ventana principal
(define my-window(new frame%
               [label "Resuelve laberinto"]
               [width 300]
               [height 300]
               [style '(fullscreen-button)]
               [alignment '(left center)]))

;Funcion que determina que se debe dibujar con
;base en la matriz
(define (select-image maze-list x)
  (cond
    ;El camino tiene cordenadas (x y) es decir largo 2
    [(list?(list-ref maze-list x))path2]
    [(= (list-ref maze-list x) 6) hit]
    [(= (list-ref maze-list x) 3) obs1]
    [(= (list-ref maze-list x) 2) obs2]
    [(= (list-ref maze-list x) 4) sol]
    [else path]))

;Funcion que recibe un canvas para dibujar las imagenes
(define (draw-maze canvas dc)
  (draw-maze-aux canvas dc maze-test 0 0 10 10))
 
;Funcion que carga en canvas una serie de imagenes dada un laberinto(matriz)
;(x y) son de la matriz
;x-canvas y-canvas son las cordenadas para ubicar el dibujo de la imagen
(define (draw-maze-aux canvas dc maze x y x-canvas y-canvas)
;(print y)
  (cond
    ;Si solo falta una imagen del laberinto, se dibuja y termina
    [(and(= x 7) (= y 7)) (send dc draw-bitmap (select-image (car maze) y) x-canvas y-canvas)]
    ;Si ya se dibujo una fila del laberinto, se cambia de fila
    [(= y 8) (draw-maze-aux canvas dc (cdr maze)(+ x 1) 0 10 (+ y-canvas 30))]
    [else
      ;Se dibuja una imagen y se llama de nuevo la funcion
      (send dc draw-bitmap (select-image (car maze) y) x-canvas y-canvas)
      (draw-maze-aux canvas dc maze x (+ y 1) (+ x-canvas 30) y-canvas )])) 

;Se define un canvas para dibujar las imagenes bitmap
(define my-canvas (new canvas% (parent my-window)
                  (min-width (image-width path))
                  (min-height (image-height path))
                  (paint-callback draw-maze)))


;Se inicia la ventana
(send my-window show #t)


;---------------------------------------------------------------
;---------------------------------------------------------------
;FUNCIONES DE TEST Y MODIFICAR CLASE CANVAS

#|
;Se puede modificar la clase canvas
(define my-canvas%
  (class canvas%
    ;Se cambia en metodo on-paint
    (override  on-paint)
    (define on-paint
      (lambda()(send (send this get-dc)
                     draw-bitmap image1 10 10)))        
    (super-instantiate())))
|#

;Funcion de test que pone una imagen en
;coordenadas x y
;(define (draw-maze canvas dc x y)
  ;(send dc draw-bitmap path 10 70))

;(send my-window refresh)	 	 	 
;(send my-canavas draw-bitmap path 10 70)
;(send my-canvas get-dc)
;(send (send my-canvas get-dc) draw-bitmap path 10 70)

