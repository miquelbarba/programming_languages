
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

(define (sequence low high stride)
  (if (<= low high) 
      (cons low (sequence (+ low stride) high stride)) 
      null))

(define (string-append-map xs suffix)
  (map (lambda (x) (string-append x suffix)) xs))

(define (list-nth-mod xs n)
  (if (< n 0)
      (error "list-nth-mod: negative number")
      (if (null? xs)
          (error "list-nth-mod: empty list")
          (car (list-tail xs (remainder n (length xs)))))))

(define (stream-for-n-steps s n)
  (letrec ([f (lambda (s n)
                (let ([pr (s)])
                  (if (> n 0)
                      (cons (car pr) (f (cdr pr) (- n 1)))
                      null)))])
    (f s n)))
  
(define funny-number-stream
  (letrec ([f (lambda (x) 
                (cons (if (= (remainder x 5) 0) (- x) x)
                      (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

(define dan-then-dog
  (letrec ([f (lambda (x) 
                (cons (if (= (remainder x 2) 0) "dog.jpg" "dan.jpg")
                      (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

(define (stream-add-zero s)
  (letrec ([f (lambda (s)
                (let ([pr (s)])
                  (cons 
                   (cons 0 (car pr)) 
                   (lambda () (f (cdr pr))))))])
    (lambda () (f s))))

(define (cycle-lists xs ys)
  (letrec ([f (lambda (x) 
                (cons 
                 (cons (list-nth-mod xs x) (list-nth-mod ys x))
                      (lambda () (f (+ x 1)))))])
    (lambda () (f 0))))
    
(define (vector-assoc v vec)
  (letrec ([f (lambda (v vec pos) 
                (if (< pos (vector-length vec))
                    (let ([elem (vector-ref vec pos)])
                      (if (pair? elem)
                          (if (equal? (car elem) v)
                              elem
                              (f v vec (+ pos 1)))
                          (f v vec (+ pos 1))))
                    #f))])
    (f v vec 0)))

(define (cached-assoc xs n)
  (letrec ([memo (make-vector n #f)]
           [next-pos 0]
           [f (lambda (v)
                (let ([ans (vector-assoc v memo)])
                  (if ans
                      (cdr ans)
                      (let ([new-ans (assoc v xs)])
                        (begin
                          (vector-set! memo next-pos (cons (cons v new-ans) memo))
                          (set! next-pos (remainder (+ 1 next-pos) n))
                          new-ans)))))])
    f))
                 
                