
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



;Intento de mostrar el A
(define (A-star inicio meta pos)
  (local [(define (get-path rsf)
            (if (false? rsf)
                false
                (reverse (map (λ (p) (wle-pos p)) rsf))))
       
        
          (define (pos-member? pos lop)
            (cond [(empty? lop) false]
                  [else
                   (if(meta? pos (first lop))
                      true
                      (pos-member? pos (rest lop)))]))

          (define (neighbour p pos)
            (local [(define x (pos-x p))
                    (define y (pos-y p))
                    ;; determine if n is in the board pos
                    (define (in? n) 
                      (local [(define (in-board? n pos)
                                (cond [(empty? pos) false]
                                      [else
                                       (if (meta? n (first pos))
                                           true
                                           (in-board? n (rest pos)))]))]
                        (in-board? n pos)))]
              (filter in? 
                      (list 
                       (make-pos (add1 x) y)
                       (make-pos (sub1 x) y)
                       (make-pos x (add1 y))
                       (make-pos x (sub1 y))))))
          
          (define (remove-first-n lst n)
            (cond [(or (zero? n) (empty? lst)) lst]
                  [else
                   (remove-first-n (rest lst) (sub1 n))]))
    












;Posible código complementario para renderizar las imágenes (falta implementarlo bien)
(define (place-cell-image cell-img x y board-image)
  (place-image cell-img
               (+ (* x CELL-SIZE) (/ CELL-SIZE 2))
               (+ (* y CELL-SIZE) (/ CELL-SIZE 2))
               board-image))
