#lang racket

(require rackunit "hw5.rkt")
(require rackunit/text-ui)

(define f1 (fun "f1" "num" (add (int 12) (var "num"))))

(define f2 (fun "f2" "n"
                (ifgreater (var "n") (int 0)
                           (add (var "n") (call (var "f2") (add (var "n") (int -1))))
                           (int 0))))

(define hw5-tests
  (test-suite
    "Tests for Homework 5"
    
    (test-equal? "mupllist->racketlist 1"
                 (list (int 1) (int 2) (int 3))
                 (mupllist->racketlist (apair (int 1) (apair (int 2) (apair (int 3) (aunit))))))
  
    (test-equal? "mupllist->racketlist 2"
                 (list)
                 (mupllist->racketlist (aunit)))
    
    (test-equal? "racketlist->mupllist #1"
                 (apair (int 2) (apair (var "x") (apair (int 43) (aunit))))
                 (racketlist->mupllist (list (int 2) (var "x") (int 43))))
    
    (test-equal? "racketlist->mupllist #2"
                 (aunit)
                 (racketlist->mupllist (list)))
    
    (test-equal? "ifgreater"
                 (int 42)
                 (eval-exp (ifgreater (add (int 2) (int 2)) (add (int 2) (int 1)) (int 42) (int 0))))
       
    (test-equal? "int"
                 (int 3)
                 (eval-exp (int 3)))
  
    (test-equal? "add"
                 (int 34)
                 (eval-exp (add (int 20) (add (int 10) (int 4)))))
              
    (test-equal? "isaunit"
                 (int 1)
                 (eval-exp (isaunit (aunit))))
    

    (test-equal? "mlet"
                 (int 9)
                 (eval-exp (mlet "v" (int 9) (var "v"))))

    (test-equal? "mlet2"
                 (int 10)
                 (eval-exp (mlet "v" (int 9) (add (var "v") (int 1)))))
    
    (test-equal? "local scoping"
                 (int 2)
                 (eval-exp (mlet "v" (int 9) 
                                 (mlet "v" (int 2) (var "v"))))) 
  
    (test-equal? "local scoping fun"
                 (int 43)
                 (eval-exp (mlet "v" 
                                 (call (fun "v" "x" (add (var "x") (int 1))) (int 42)) 
                                 (var "v"))))      
    (test-equal? "call"
                 (int 13)
                 (eval-exp (call (fun "incr" "x" (add (var "x") (int 1))) (int 12))))     
    
    (test-equal? "call #2"
                 (int 15)
                 (eval-exp (call f1 (int 3))))    
    
    (test-equal? "Recursive function"
                 (int 6)
                 (eval-exp (call f2 (int 3))))      
    
    (test-equal? "ifaunit test #1"
                 (int 42)
                 (eval-exp (ifaunit (aunit) (int 42) (int 43))))  
    
    (test-equal? "ifaunit test #2"
                 (int 3)
                 (eval-exp (ifaunit (int 3) (int 2) (int 3))))      
    
   (test-equal? "mlet* #1"
                (int 11)
                (eval-exp (mlet* (list (cons "var" (int 11))) (var "var"))))    
   
   (test-equal? "mlet* #2" 
                (int 6)
                (eval-exp (mlet* (list (cons "var" (int 2)) (cons "y" (int 1))) (add (var "var") (add (var "y") (int 3))))))   
  
   (test-equal? "mupl-map"
                (apair (int 15) (apair (int 25) (aunit)))
                (eval-exp (call (call mupl-map f1) (apair (int 3) (apair (int 13) (aunit))))))   
   
   (test-equal? "mupl-mapAddN"
                (list (int 10) (int 11) (int 16))
                (mupllist->racketlist
                 (eval-exp (call (call mupl-mapAddN (int 7))
                                 (racketlist->mupllist 
                                  (list (int 3) (int 4) (int 9)))))))
  )    
)

(run-tests hw5-tests) 
