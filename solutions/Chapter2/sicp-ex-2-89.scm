#lang sicp

(define (adjoin-term order coeff term-list)
  (define (iter tl)
    (if (= (length tl) (inc order))
        (cons coeff (cdr tl))
        (cons (car tl) (iter (cdr tl)))))
  (if (< order 0)
      (error "cannot adjoin" (list order coeff))
      (iter term-list)))

(define (make-term order coeff) (list order coeff))
(define (the-empty-termlist) '())
(define (first-term term-list) (make-term (- (length term-list) 1) (car term-list))
(define (rest-terms term-list) (cdr term-list))
(define (empty-termlist? term-list) (null? term-list))

(define (coeff term-list order)
  (define (iter tl)
    (if (= (length tl) (inc order))
        (car tl))
        (iter (cdr tl)))
  (if (< order 0)
      (error "cannot find the term with order:" (list order))
      (iter term-list)))
