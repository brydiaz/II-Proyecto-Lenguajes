
;Definicion de tamaño de celdas
(define BOARD-WIDTH  (* CELL-SIZE (vector-length (vector-ref INIT-BOARD 0))))
(define BOARD-HEIGHT (* CELL-SIZE (vector-length INIT-BOARD)))



;colorear las celdas según estado
(define MTC  (rectangle CELL-SIZE CELL-SIZE "solid" "black")) ; empty cell
(define DTC  (overlay (circle 3  "solid" "white") MTC))       ; dot in cell
(define WALL (rectangle CELL-SIZE CELL-SIZE "solid" "blue"))  ; wall


;Definir estado actual y restricciones (No completado)
(define-struct pos (x y))
(define MAP-LIST
  (local [(define i 0)
          (define j 0)
          (define lst empty)
          (define pos INIT-BOARD)]
    (begin 
      (let loopi()
        (when (< i 8)
          (begin
            (set! pos (vector-ref INIT-BOARD i))
            (let loopj()
              (when (< j 13)
                (begin
                  (if (not-wall? (vector-ref pos j))
                      (set! lst (append lst (list (make-pos j i)) ))
                      void)
                  (set! j (add1 j))
                  (loopj))))
            (set! i (add1 i))
            (set! j 0)
            (loopi))))
      lst)))



(define (show c r)
  (cond
    ((= r 0) scn)
    (else (let loop_r ((j 0)) (cond
                                ((= j r) scn)
                                (else (let loop_c ((i 0)) (cond
                                                            ((= i c) (loop_r (add1 j)))
                                                            (else (begin

                                                                    (if (= (list-ref index_list (+ i (* j rows))) current) (begin
                                                                                                                             (if (>= (- i 1) 0)        (set! neighbours_visited_list (list-set neighbours_visited_list 3 (list-ref visited_list (+ (- i 1) (* j rows))))) (set! neighbours_visited_list (list-set neighbours_visited_list 3 -1)))
                                                                                                                             (if (<= (+ i 1) (- c 1))  (set! neighbours_visited_list (list-set neighbours_visited_list 1 (list-ref visited_list (+ (+ i 1) (* j rows))))) (set! neighbours_visited_list (list-set neighbours_visited_list 1 -1)))
                                                                                                                             (if (>= (- j 1) 0)        (set! neighbours_visited_list (list-set neighbours_visited_list 0 (list-ref visited_list (+ i (* (- j 1) rows))))) (set! neighbours_visited_list (list-set neighbours_visited_list 0 -1)))
                                                                                                                             (if (<= (+ j 1) (- r 1))  (set! neighbours_visited_list (list-set neighbours_visited_list 2 (list-ref visited_list (+ i (* (+ j 1) rows))))) (set! neighbours_visited_list (list-set neighbours_visited_list 2 -1)))
                                                                                                                             ) void)

                                                                    (place-images

                                                                   
                                                                     (list
                                                                    
                                                                      (rectangle scl 2 "solid" (color 255 255 255 (if (= (list-ref (list-ref wall_list (+ i (* j rows))) 0) 1) 255 0))) ; TOP
                                                                      (rectangle scl 2 "solid" (color 255 255 255 (if (= (list-ref (list-ref wall_list (+ i (* j rows))) 2) 1) 255 0))) ; BOTTOM
                                                                      (rectangle 2 scl "solid" (color 255 255 255 (if (= (list-ref (list-ref wall_list (+ i (* j rows))) 3) 1) 255 0))) ; LEFT
                                                                      (rectangle 2 scl "solid" (color 255 255 255 (if (= (list-ref (list-ref wall_list (+ i (* j rows))) 1) 1) 255 0))) ; RIGHT
                                                                      (rectangle scl scl "solid" (if (= (list-ref index_list (+ i (* j rows))) current) (color 200 0 200 255) (color 180 0 150 (if (= (list-ref visited_list (+ i (* j rows))) 1) 255 0))))

                                                                      )


                                                                     (list
                                                                    
                                                                      (make-posn (+ (/ scl 2) (* i scl))  (* j scl))               ; TOP
                                                                      (make-posn (+ (/ scl 2) (* i scl))  (+ scl (* j scl)))       ; BOTTOM
                                                                      (make-posn (* i scl)                (+ (/ scl 2) (* j scl))) ; LEFT
                                                                      (make-posn (+ scl (* i scl))        (+ (/ scl 2) (* j scl))) ; RIGHT
                                                                      (make-posn (+ (/ scl 2) (* i scl))  (+ (/ scl 2) (* j scl)))

                                                                      ) (loop_c (add1 i)))))
                                                            )))
                                ))
          )))
