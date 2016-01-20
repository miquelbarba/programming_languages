#lang racket
(require rackunit "hw4.rkt")

(equal? (sequence 0 5 1) (list 0 1 2 3 4 5))
(equal? (sequence 1 11 3) (list 1 4 7 10))
(equal? (sequence 0 4 5) (list 0))
(equal? (sequence 3 2 1) (list))
(equal? (sequence 1 1 1) (list 1))


(equal? (string-append-map (list "a" "b" "c") "hi") (list "ahi" "bhi" "chi"))
(equal? (string-append-map (list) "hi") (list))


(equal? (list-nth-mod (list "a" "b" "c") 0) "a")
(equal? (list-nth-mod (list "a" "b" "c") 1) "b")
(equal? (list-nth-mod (list "a" "b" "c") 2) "c")
(equal? (list-nth-mod (list "a" "b" "c") 3) "a")
(equal? (list-nth-mod (list "a" "b" "c") 4) "b")
;(equal? (list-nth-mod (list "a" "b" "c") -4) (error "list-nth-mod: negative number"))
;(equal? (list-nth-mod (list) 4) (error "list-nth-mod: empty list"))


(equal? (stream-for-n-steps funny-number-stream 6) (list 1 2 3 4 -5 6))
(equal? (stream-for-n-steps funny-number-stream 15) (list 1 2 3 4 -5 6 7 8 9 -10 11 12 13 14 -15))
(equal? (stream-for-n-steps funny-number-stream 1) (list 1))
(equal? (stream-for-n-steps funny-number-stream 0) (list))


(equal? (stream-for-n-steps dan-then-dog 1) (list "dan.jpg"))
(equal? (stream-for-n-steps dan-then-dog 4) (list "dan.jpg" "dog.jpg" "dan.jpg" "dog.jpg"))


(equal? (stream-for-n-steps (stream-add-zero dan-then-dog) 4) '((0 . "dan.jpg") (0 . "dog.jpg") (0 . "dan.jpg") (0 . "dog.jpg")))
(equal? (stream-for-n-steps (stream-add-zero dan-then-dog) 1) '((0 . "dan.jpg")))


(equal? (stream-for-n-steps (cycle-lists (list 1) (list "a")) 3) '((1 . "a") (1 . "a") (1 . "a"))) 
(equal? (stream-for-n-steps (cycle-lists (list 1 2 3) (list "a" "b")) 6) 
              '((1 . "a") (2 . "b") (3 . "a") (1 . "b") (2 . "a") (3 . "b")))


(equal? (vector-assoc 4 (list->vector '((1 . "a") (2 . "b") (3 . "c")))) #f)
(equal? (vector-assoc 1 (list->vector '((1 . "a") (2 . "b") (3 . "c")))) (cons 1 "a"))
(equal? (vector-assoc 2 (list->vector '((1 . "a") (2 . "b") (3 . "c")))) (cons 2 "b"))
(equal? (vector-assoc 3 (list->vector '((1 . "a") (2 . "b") (3 . "c")))) (cons 3 "c"))
(equal? (vector-assoc 3 (list->vector '((1 . "a") 3 (3 . "c")))) (cons 3 "c"))


(equal? ((cached-assoc '((1 . "a") (2 . "b") (3 . "c")) 3) 3) (cons 3 "c"))
(equal? ((cached-assoc '((1 . "a") (2 . "b") (3 . "c")) 1) 2) (cons 2 "b"))
(equal? ((cached-assoc '((1 . "a") (2 . "b") (3 . "c")) 1) 4) #f)
