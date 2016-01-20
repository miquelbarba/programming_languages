fun only_capitals(xs: string list) =
    List.filter (fn s => Char.isUpper(String.sub(s, 0))) xs


fun longest_string1(xs: string list) = 
    List.foldl (fn (s, s1) => if String.size(s) > String.size(s1) then s else s1) "" xs


fun longest_string2(xs: string list) = 
    List.foldl (fn (s, s1) => if String.size(s) < String.size(s1) then s1 else s) "" xs
 

fun longest_string_helper f xs =
    List.foldl (fn (s, s1) => if f(String.size(s), String.size(s1)) then s else s1) "" xs


fun longest_string3 xs = longest_string_helper (fn (x, y) => x > y) xs


fun longest_string4 xs = longest_string_helper (fn (x, y) => x > y) (List.rev xs)


fun longest_capitalized xs = (longest_string1 o only_capitals) xs


fun rev_string s = String.implode((List.rev o String.explode) s)


(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
         | Variable of string
         | UnitP
         | ConstP of int
         | TupleP of pattern list
         | ConstructorP of string * pattern

datatype valu = Const of int
          | Unit
          | Tuple of valu list
          | Constructor of string * valu

fun g f1 f2 p =
    let 
    val r = g f1 f2 
    in
    case p of
        Wildcard          => f1 ()
      | Variable x        => f2 x
      | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
      | ConstructorP(_,p) => r p
      | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
         | UnitT
         | IntT
         | TupleT of typ list
         | Datatype of string

(**** you can put all your code here ****)



fun first_answer f xs = 
    case xs of
        []     => raise NoAnswer
      | x::xs' => case f x of
                      NONE    => first_answer f xs'
                   |  SOME(v) => v


fun all_answers f xs = 
    let
        fun helper f xs acc =
            case xs of
                []     => SOME(acc)
              | x::xs' => case f x of
                             NONE    => NONE
                           | SOME(x) => helper f xs' (acc @ x)
    in
        helper f xs []
    end


fun count_wildcards p = 
  g (fn _ => 1) (fn _ => 0) p

fun count_wild_and_variable_lengths p = 
  g (fn _ => 1) (fn x => String.size(x)) p

fun count_some_var (s, p) =
  g (fn _ => 0) (fn x => if x = s then 1 else 0) p 


fun check_pat p = 
  let
      fun repeats xs acc =
          case xs of
              []      => acc
            | x::xs'  => repeats xs' (acc orelse (List.exists (fn z => z = x) xs'))

      fun all_variables p = 
          case p of
              Variable x         => [x]
            | TupleP ps          => List.foldl (fn (p, acc) => acc @ (all_variables p)) [] ps
            | ConstructorP(_,p') => all_variables p'
            | _                  => []
  in
      not (repeats (all_variables p) false)
  end


fun match(v, p) = 
    case p of
        Variable s => SOME([(s, v)])
      | UnitP      => if v = Unit then SOME [] else NONE 
      | ConstP x   => (case v of
                          Const y  => if x = y then SOME [] else NONE
                      | _          => NONE)
      | TupleP ps  => 
          (case v of
              Tuple vs => if length(vs) = length(ps) 
                          then all_answers (fn (x,y) => match(x,y)) (ListPair.zip(vs,ps))
                          else NONE
            | _        => NONE)
      | ConstructorP(s1, p1) =>
          (case v of
              Constructor(s2, v2) => if s1 = s2 then match(v2, p1) else NONE
            | _                   => NONE)
      | Wildcard   => SOME []  


fun first_match v ps = 
  SOME(first_answer (fn p => match(v, p)) ps) handle NoAnswer => NONE
