#lang sicp

(define (ln-2-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (ln-2-summands (inc n)))))

(define ln-2-stream
  (partial-sums (ln-2-summands 1)))

(define (square x) (* x x))

(define (euler-transform s)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1))    
        (s2 (stream-ref s 2)))
    (cons-stream (- s2 (/ (square (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-cdr s)))))

(define (make-tableau transform s)
  (cons-stream s
               (make-tableau transform
                             (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-car
              (make-tableau transform s)))


(display-stream-n ln-2-stream 10)
; 1.0 0.5 0.8333333333333333 0.5833333333333333 0.7833333333333332 0.6166666666666666 0.7595238095238095 0.6345238095238095 0.7456349206349207 0.6456349206349207 
(display-stream-n (euler-transform ln-2-stream) 10)
; 0.7 0.6904761904761905 0.6944444444444444 0.6924242424242424 0.6935897435897436 0.6928571428571428 0.6933473389355742 0.6930033416875522 0.6932539682539683 0.6930657506744464
(display-stream-n (accelerated-sequence euler-transform ln-2-stream) 10)
; 1.0 0.7 0.6932773109243697 0.6931488693329254 0.6931471960735491 0.6931471806635636 0.6931471805604039 0.6931471805599445 0.6931471805599427 0.6931471805599454
(log 2)
; 0.6931471805599453
