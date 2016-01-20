(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

fun all_except_option(s: string, xs: string list) =
  let
    fun helper(s: string, xs: string list, acc: string list) =
        case xs of
            [] => NONE
          | x::xs' => if same_string(x, s)
                      then SOME(acc @ xs')
                      else helper(s, xs', acc @ [x])  
  in
      helper(s, xs, [])
  end


fun get_substitutions1(xs: string list list, s: string) =
    case xs of
        [] => []
      | x::xs' => 
           case all_except_option(s, x) of
                NONE => get_substitutions1(xs', s)
              | SOME(res) => res @ get_substitutions1(xs', s) 


fun get_substitutions2(xs: string list list, s: string) =
    let
        fun helper(xs: string list list, s: string, acc: string list) =
            case xs of
                [] => acc
              | x::xs' => 
                   case all_except_option(s, x) of
                        NONE => helper(xs', s, acc)
                      | SOME(res) => helper(xs', s, acc @ res) 

    in
        helper(xs, s, [])
    end

type full_name = {first: string, middle: string, last: string}

fun similar_names(xs: string list list, name: full_name) = 
    let
        val {first: string, middle: string, last: string} = name
        fun helper(xs: string list, name: full_name) =
            case xs of
                []     => []
              | x::xs' => {first = x, middle = middle, last = last}::helper(xs', name)
    in
        name :: helper(get_substitutions2(xs, first), name)
    end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

fun card_color(c: card) =
    case c of
        (Spades, _) => Black
      | (Clubs, _)  => Black
      | _           => Red

fun card_value(c: card) =
    case c of
        (_, Num(n)) => n
      | (_, Ace)    => 11
      | _           => 10

fun remove_card(cs: card list, c: card, e: exn) =
  let
    fun helper(cs: card list, c: card, e: exn, acc: card list) =
        case cs of
            []     => raise e
          | x::cs' => if x = c
                      then acc @ cs'
                      else helper(cs', c, e, acc @ [x])  
  in
      helper(cs, c, e, [])
  end

fun all_same_color card_list =
    case card_list of
        []       => true
      | x::y::xs => card_color(x) = card_color(y) andalso all_same_color(y::xs)
      | x::xs    => true

fun sum_cards(cs: card list) = 
  let
    fun helper(cs: card list, acc: int) =
        case cs of
            []     => acc
          | c::cs' => helper(cs', card_value(c) + acc)
  in
      helper(cs, 0)
  end

fun score(cs: card list, goal: int) =
    let
        val sum = sum_cards(cs)
        val preliminary_score = if sum > goal
                                then (sum - goal) * 3
                                else goal - sum
    in
        if all_same_color(cs)
        then preliminary_score div 2
        else preliminary_score
    end




fun officiate(cs: card list, ms: move list, goal: int) = 
    let
        fun helper(cs: card list, ms: move list, goal: int, held_cards: card list) =
            case ms of
                []     => score(held_cards, goal)
              | m::ms' => 
                    case m of
                        Discard(c) => helper(cs, ms', goal, remove_card(held_cards, c, IllegalMove))
                      | Draw => 
                            case cs of
                                []     => score(held_cards, goal)
                              | c::cs' => if (sum_cards(held_cards) + card_value(c)) > goal
                                          then score(c::held_cards, goal)
                                          else helper(cs', ms', goal, c::held_cards)
    in
        helper(cs, ms, goal, [])
    end