#lang sicp

(define (same-parity x . y)
  (define (iter y)
    (cond ((null? y) nil)
          (else (let ((z (cdr y))
                      (u (car y)))
                  (if (= 0 (remainder (- x u) 2))
                      (cons u (iter z))
                      (iter z))))))
  (iter (cons x y)))

(same-parity 1 2 3 4 5 6 7)
; (1 3 5 7)
(same-parity 2 3 4 5 6 7)
; (2 4 6)
