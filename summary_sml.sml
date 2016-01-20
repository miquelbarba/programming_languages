(* 
   int * int : pair #1 #2
   list : hd xs | tl xs | null xs | x::xs | list1 @ list2
*)

fun sum_pair_list (xs : (int * int) list) =
    if null xs
    then 0
    else #1 (hd(xs)) + #2 (hd(xs)) + sum_pair_list(tl(xs))

fun firsts (xs : (int * int) list) =
    if null xs
    then []
    else (#1 (hd xs))::(firsts(tl xs))

fun seconds (xs : (int * int) list) =
    if null xs
    then []
    else (#2 (hd xs))::(seconds(tl xs))

fun append (xs : int list, ys : int list) = (* part of the course logo :) *)
    if null xs
    then ys
    else hd(xs) :: append(tl(xs), ys)

(*
  let in end
  NONE
  SOME(x)
*)

fun max2 (xs : int list) =
    if null xs
    then NONE
    else let (* fine to assume argument nonempty because it is local *)
        fun max_nonempty (xs : int list) =
        if null (tl xs) (* xs better not be [] *)
        then hd xs
        else let val tl_ans = max_nonempty(tl xs)
             in
             if hd xs > tl_ans
             then hd xs
             else tl_ans
             end
    in
        SOME (max_nonempty xs)
    end


(*
  records
  #name my_niece
*)
val my_niece = {name = "Amelia", id = 41123 - 12}
val brain_part = {id = true, ego = false, superego = false}


(* datatype
*)
datatype mytype = TwoInts of int * int 
                | Str of string 
                | Pizza

val a = Str "hi"
val b = Str
val d = TwoInts(1+2,3+4)

(*
 case e of
    Constant _ =>
    x::xs' => 
*)

datatype exp = Constant of int 
             | Negate of exp 
             | Add of exp * exp
             | Multiply of exp * exp

fun eval e =
    case e of
        Constant i => i
      | Negate e2  => ~ (eval e2)
      | Add(e1,e2) => (eval e1) + (eval e2)
      | Multiply(e1,e2) => (eval e1) * (eval e2)

fun inc_or_zero intoption =
    case intoption of
        NONE => 0
      | SOME i => i+1

fun sum_list xs =
    case xs of
        [] => 0
      | x::xs' => x + sum_list xs'

(* type is 'a list * 'a list -> 'a list *)
fun append (xs,ys) =
    case xs of
        [] => ys
      | x::xs' => x :: append(xs',ys)

(* pattern matching *)
fun full_name1 (r : {first:string,middle:string,last:string}) =
    case r of 
        {first=x,middle=y,last=z} => x ^ " " ^ y ^ " " ^z

fun full_name3 {first=x,middle=y,last=z} =
    x ^ " " ^ y ^ " " ^z

(* do this *)
fun zip3 list_triple =
    case list_triple of 
    ([],[],[]) => []
      | (hd1::tl1,hd2::tl2,hd3::tl3) => (hd1,hd2,hd3)::zip3(tl1,tl2,tl3)
      | _ => raise ListLengthMismatch

(* and the inverse *)
fun unzip3 lst =
    case lst of
    [] => ([],[],[])
      | (a,b,c)::tl => let val (l1,l2,l3) = unzip3 tl
               in
               (a::l1,b::l2,c::l3)
               end

(* function patterns *)
fun eval (Constant i) = i
  | eval (Negate e2) = ~ (eval e2)
  | eval (Add(e1,e2)) = (eval e1) + (eval e2)
  | eval (Multiply(e1,e2)) = (eval e1) * (eval e2)


(* exceptions *)
exception MyOtherException of int * int
fun mydiv (x,y) =
    if y=0
    then raise MyUndesirableCondition
    else x div y 
val x = maxlist ([3,4,5],MyUndesirableCondition) (* 5 *)
    handle MyUndesirableCondition => 42


(* tail recursion *)
fun sum2 xs =
    let fun f (xs,acc) =
            case xs of
                [] => acc
              | i::xs' => f(xs',i+acc)
    in
        f(xs,0)
    end

(* functions as parameters *)
fun n_times (f,n,x) = (* ('a -> 'a) * int * 'a -> 'a *)
    if n=0
    then x
    else f (n_times(f,n-1,x))

(* anonymous functions *)
fun triple_n_times4 (n,x) = n_times((fn y => 3*y), n, x)

(* map *)
fun map (f,xs) =
    case xs of
    [] => []
      | x::xs' => (f x)::(map(f,xs'))
val x1 = map ((fn x => x+1), [4,8,12,16])

(* filter *)
fun filter (f,xs) =
    case xs of
    [] => []
      | x::xs' => if f x
          then x::(filter (f,xs'))
          else filter (f,xs')
fun all_even_snd xs = 
    filter((fn (_,v) => is_even v), xs)

(* fold / reduce *)
fun fold (f,acc,xs) =
    case xs of 
    [] => acc
      | x::xs' => fold (f,f(acc,x),xs')
fun f1 xs = fold ((fn (x,y) => x+y), 0, xs)

(* currying: no poner comas en parametros, se crea una fun que se aplica 1er param, q devuelve fun q se aplica seguno param  *)
fun sum xs = fold (fn (x,y) => x+y) 0 xs

val sum = fold (fn (x,y) => x+y) 0
sum xs

fun curry f x y = f (x,y)
fun uncurry f (x,y) = f x y

(* mutable references *)
val x = ref 42 
val _ = x := 43


(* mutual recursion *)
fun match xs =
    let fun s_need_one xs =
        case xs of
        [] => true
          | 1::xs' => s_need_two xs'
          | _ => false
    and s_need_two xs =
        case xs of
        [] => false
          | 2::xs' => s_need_one xs'
          | _ => false
    in
    s_need_one xs
    end

(* TAD *)
signature RATIONAL_C =
sig
type rational (* type still abstract *)
exception BadFrac
val Whole : int -> rational 
   (* client knows only that Whole is a function *)
val make_frac : int * int -> rational
val add : rational * rational -> rational
val toString : rational -> string
end 

structure Rational3 :> RATIONAL_C (* or C *)= 
struct 
   type rational = int * int
   exception BadFrac
         
   fun make_frac (x,y) = 
       if y = 0
       then raise BadFrac
       else if y < 0
       then (~x,~y)
       else (x,y)

   fun Whole i = (i,1)

   fun add ((a,b),(c,d)) = (a*d + c*b, b*d)

   fun toString (x,y) =
       if x=0
       then "0"
       else
       let fun gcd (x,y) =
           if x=y
           then x
           else if x < y
           then gcd(x,y-x)
           else gcd(y,x)
           val d = gcd (abs x,y)
           val num = x div d
           val denom = y div d
       in
           Int.toString num ^ (if denom=1 
                   then "" 
                   else "/" ^ (Int.toString denom))
       end
end





;; Thunks - skip expensive computation if not needed

e               expression
(lambda () e)   a funtion that when called evaluates e
(e)             evaluate a thunk


;; Delay and force

(define (my-delay th)    ;; delay a thunk
  (mcons #f th))         ;; #f means is unevaluated thunk

(define (my-force p)        
  (if (mcar p)                       ;; if already evaluated
      (mcdr p)                       ;; return the expression
      (begin (set-mcar! p #t)        ;; else set mcar #t 
             (set-mcdr! p ((mcdr p)))     ;; evaluate the thunk
             (mcdr p))))                  ;; return the evalutation



(let ([p (my-delay (lambda () (+ 3 4)))])   ;; delays the computation of the thunk
  (lambda () (my-force p)))                 ;; returns a lamda that forces the computation. 
                                            ;; the first time called, evaluates the my-force that evaluates the expression


;; Streams                                             

'(next-answer . next-thunk)

1: (car (s))
2: (car ((cdr (s))))    ;; note the cdr is evalutated, the thunk is evalutated

(powers-of-two)  ;; call a thunk

(define (number-until stream tester)
  (letrec ([f (lambda (stream ans)            ;; aux function
              (let ([pr (stream)])
                (if (tester (car pr))
                  ans
                  (f (cdr pr) (+ ans 1)))))])    ;; NO ((cdr pr)) NO queremos evaluar el thunkº
    (f stream 1)))

(number-until powers-of-two (lambda (x) (= x 32)))   ;; NO (powers-of-two) NO evaluar


(define ones (lambda () (cons 1 ones)))     ;; a stream always returns a lambda
(car (ones))                                ;; that when evaluated returns a pair: value.thunks
(car ((cdr (ones))))

(define nats
  (letrec ([f (lambda (x) (cons x (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))


;; Memoization

;; a function with no side effects and not read mutable
;; -> cache of results


(define fib
  (letrec([memo null]           ;; list of pairs (arg . result)
          [f (lambda (x)
            (let ([ans (assoc x memo)])
              (if ans
                (cdr ans)
                (let ([new-ans (if (or (= x 1) (= x 2))
                                    1
                                    (+ (f (- x 1)) (f (- x 2))))])
                  (begin 
                    (set! memo (cons (cons x new-ans) memo))
                    new-ans)))))])
    f))


;; Macros
;; describes how to transfrom some new syntax into the source language
;; one way to implement syntactic sugar
;; macro expansion -> process of rewriting the syntax before the program is return

(my-if e1 then e2 else e3) -> (if e1 e2 e3)


;; Structs  
; not syntactic sugar, not a list (pair? x) (list? e)
; new primitive datatype

(struct name (field1 field2 field3) #:transparent)
(foo e1 e2 e3)  -> returns foo with the fields
(foo? e)        -> is a foo?
(foo-field1 e)  -> eval e and if the result is a foo? returns field1


#:transparent -> prints values in repl
#:mutable -> set-name-field1! mutation


;; Static checking

;; anything done to reject a program before run it
;; type system: give each variable, expression a type
                include misuse of primitives, avoid dynimic checking, enforce abstraction
                prevent certain behaivor in runtime

;; Soundness and completeness
;; a type system is sound for X if it never accepts a program that, when run with some input does X (no false negatives)
;; a type system is complete if it never reject a program that will not do X (no false positives)

;; type system usually is sound
;; ML is sound (no false positives) 

;; why incompleteness
;; any static checker cannot 1) always terminate 2) be sound 3) be complete  UNDECIDABLE

;; unsoundness?
;;   fix update language definition
;;   insert dynamic checks
;;   bad: allow the error
;;   worse: allow it, but let the programer do anything (C, C++)

;; Weak typing
;; c/c++ exits programs that pass static checking, but when run can do anything
;; ease laguange implementation
;; performance: dynamic checks take time; 
;; lower level

;; racket is not weakly typed, checks most things dynamically

;; static vs dynamic
1. Dynamic is more convenient -> flexible
   Static is more convenient -> forces data params, with right time 

2. Static prevents useful programs -> programs can't do nothing wrong   
   Static lets you tag as needed

3. static catches bugs earlier -> simply bugs
   static catches only easy bugs

4. static typing is faster. Don't need dynamic checks, store data to check
                            And the programmer doesn't have to check

5. Code reuse easier with dynamic. without restrictive type system
   with static -> generics and subtyping. Checking types

6. Dynamic better for prototyping
   Static better for prototyping -> better to document with type system

7. Dynamic better for evolution. No callers are broken, backwards compatibylity
   
  Static -> gives me a list with the things that doesn't works



;; Subtyping from the beginning
example: records with mutable fields

Idea: nothing wrong, color isn't used in distToOrigin
distToOrigin(p: {x:real, y:real})
distToOrigin({x=3.0, y=4.0, color="green"})

if an expression has type (f1:t1, ... , fn:tn)
the it can also have a type with some fields removed

DEFINITION:
subtyping t1 <: t2 if t1 is a subtype of t2
if e has type t1 and t1 <: t2
then e (also) has type t2

principle of substituatability: if t1 <: t2, then any value
of type t1 must be usabel in every way t2 is
NO accessinb record fields that not exists

4 rules:
  1. Width subtyping: a supertype can have a subset of the fields with the same types
  2. Permutation subtyping. Order doesn't matter
  3. Transitivity: if t1 <: t2 and t2 <:t3 then t1 <: t3
  4. Reflexivity: every type is a subtype of itself

Depth subtyping
circle: {center: {x:real, y:real}, r: real}
sphere: {center: {x:real, y:real, z:real}, r: real}

if we add 5 rule: depth subtyping
  if ta <: tb then {f1:t1, ... f:ta,  , fn:tn} <:
                   {f1:t1, ... f:tb,  , fn:tn} 

BREAKS SOUNDNESS

setToOrigin(c: circle) = c.center = {0, 0}
setToOrigin(sphere) !!!! NO z field
                    sphere.center.z

in records with records/objects with getters and setters,
depth subtyping is unsoundness

if fields are immutable, DEPTH subtyping is SOUND


;; Function subtyping

Function return:
if ta <: tb then t -> ta <: t -> tb
a function ca return more than it needs to
Return types are covariant

Function paramaters:
 UNSOUND 

 if tb <: ta then ta -> t <: tb -> t
 a function can assume less than it needs to about arguments
 argument types are contravariant


;; Generics vs subtyping

Generics great for types for functions that combine other functions
great for anything but need to be the same type

subtyping is not good: downcast

Subtyping. good: code that needs a foo but fine to have more than a foo
           (subtyping)

;; Bounded polymorphism
generics and Subtyping

List<Point> inCircle(List<Point>, Point, double)

would like to use with List<ColorPoint>

List<T> inCircle(List<T>, Point, double) where T <: Point
<T extends Pt> List<T> inCircle...

