#lang sicp

(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set) 
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (tree->list tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

(define (union-set tree1 tree2)
  (define (union-list list1 list2)
    (cond ((null? list1) list2)
          ((null? list2) list1)
          (else
           (let ((x1 (car list1))
                 (x2 (car list2)))
             (cond ((= x1 x2) (cons x1 (union-list (cdr list1) (cdr list2))))
                   ((< x1 x2) (cons x1 (union-list (cdr list1) list2)))
                   (else (cons x2 (union-list (cdr list2) list1))))))))
  (let ((list1 (tree->list tree1))
        (list2 (tree->list tree2)))
    (list->tree (union-list list1 list2))))

(define (intersection-set tree1 tree2)
  (define (intersection-list list1 list2)
    (cond ((or (null? list1) (null? list2)) '())
          (else
           (let ((x1 (car list1))
                 (x2 (car list2)))
             (cond ((= x1 x2) (cons x1 (intersection-list (cdr list1) (cdr list2))))
                   ((< x1 x2) (intersection-list (cdr list1) list2))
                   (else (intersection-list (cdr list2) list1)))))))
  (let ((list1 (tree->list tree1))
        (list2 (tree->list tree2)))
    (list->tree (intersection-list list1 list2))))


(define tree1 (list->tree (list 1 3 5 7 9 11 15)))
(define tree2 (list->tree (list 2 4 6 7 10 12 15)))
(define tree3 (union-set tree1 tree2))
tree3
; (6 (3 (1 () (2 () ())) (4 () (5 () ()))) (10 (7 () (9 () ())) (12 (11 () ()) (15 () ()))))
(tree->list tree3)
; (1 2 3 4 5 6 7 9 10 11 12 15)
(define tree4 (intersection-set tree1 tree2))
tree4
; (7 () (15 () ()))
(tree->list tree4)
; (7 15)