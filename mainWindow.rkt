#lang racket

(require racket/gui)


;Dibujar la ventana donde se mete todo
(define main-window (new frame%
                         [label "Juego del laberinto"]
                         [width 700]
                         [height 700]
                         [style '(fullscreen-button)]
                         [alignment '(left top)]
                         ))

;Obtiene el tamaño de la matriz
(define get-matrix-size (new text-field%
                            [parent main-window]
                            [label "Ingrese el número de filas/columnas (entre 9 y 15)"]
                            [min-width 10]
                            [min-height 10]
                            [vert-margin 40]
                            [horiz-margin 40]
                            [stretchable-width #f]
                            [stretchable-height #f]
                            ))

;botón para inicar a jugar
(define start-playing (new button%
                           [parent main-window]
                           [label "Iniciar juego"]
                           [vert-margin 10]
                           [horiz-margin 100]
                           [min-width 600]
                           [min-height 10]
                           ;[callback (lambda (button event)
                            ;           Muestra el juego
                             ;          )]
                           ))



;botón para encontrar y mostrar el camino más corto
(define find-shortest-path(new button%
                           [parent main-window]
                           [label "Buscar ruta más corta"]
                           [vert-margin 10]
                           [horiz-margin 150]
                           [min-width 500]
                           [min-height 10]
                           ;[callback (lambda (button event)
                            ;           Ingresar aqui el llamado a la función para mostrar y encontrar el camino más corto
                             ;          )]
                           ))


(send main-window show #t)


