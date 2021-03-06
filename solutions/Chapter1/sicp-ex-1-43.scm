#lang sicp

(define (repeated f n)
  (if (= n 0)
      (lambda (x) x)
      (lambda (x) (f ((repeated f (- n 1)) x)))))

(define (square x) (* x x))

((repeated square 2) 5)
; (5^2)^2=625
