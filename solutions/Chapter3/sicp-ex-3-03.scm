#lang sicp

(define (make-account balance pwd)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (pwd-error amount)
    (display "Incorrect password\n"))
  (define (dispatch input m)
    (cond ((not (eq? pwd input)) pwd-error)
          ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request -- MAKE-ACCOUNT"
                       m))))
  dispatch)

(define acc (make-account 100 'secret-password))
((acc 'secret-password 'withdraw) 40)
; 60
((acc 'some-other-password 'deposit) 50)
; Incorrect password
