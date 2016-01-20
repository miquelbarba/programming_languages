use "homework2.sml";

valOf(all_except_option("a", ["a", "b", "c"])) = ["b", "c"];
all_except_option("a", []) = NONE;
valOf(all_except_option("a", ["a"])) = [];


get_substitutions1 ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],"Fred") = ["Fredrick","Freddie","F"];
get_substitutions1 ([[]],"Fred") = [];
get_substitutions1 ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],"Stranger") = [];
get_substitutions1 ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],"Fredrick") = ["Fred"];
get_substitutions1 ([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],"Jeff") = ["Jeffrey","Geoff","Jeffrey"];
get_substitutions1 ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],"Fred") = ["Fredrick","Freddie","F"];

get_substitutions1([[]], "a") = [];
get_substitutions1([["a"]], "a") = [];
get_substitutions1([["a", "b", "c"], ["b", "c", "a"]], "a") = ["b", "c", "b", "c"];
get_substitutions1([["b", "a"]], "a") = ["b"];
get_substitutions1([["b", "a"], ["a", "b", "b"]], "a") = ["b", "b", "b"];
get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") = ["Fredrick","Freddie","F"];
get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff") = ["Jeffrey","Geoff","Jeffrey"];

get_substitutions2([[]], "a") = [];
get_substitutions2([["a"]], "a") = [];
get_substitutions2([["b", "a"]], "a") = ["b"];
get_substitutions2([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") = ["Fredrick","Freddie","F"];
get_substitutions2([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff") = ["Jeffrey","Geoff","Jeffrey"];

similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
  {first="Fred", middle="W", last="Smith"}) = 
        [{first="Fred", last="Smith", middle="W"},
        {first="Fredrick", last="Smith", middle="W"},
        {first="Freddie", last="Smith", middle="W"},
        {first="F", last="Smith", middle="W"}];
similar_names([["a", "z"]], {first="a", middle="b", last="c"}) = [{first="a", middle="b", last="c"}, {first="z", middle="b", last="c"}];
similar_names([["a"]], {first="b", middle="b", last="c"}) = [{first="b", middle="b", last="c"}];
similar_names([], {first="b", middle="b", last="c"}) = [{first="b", middle="b", last="c"}];


card_color(Spades, Jack) = Black;
card_color(Spades, Num(1)) = Black;
card_color(Spades, Queen) = Black;
card_color(Clubs, Queen) = Black;
card_color(Diamonds, King) = Red;
card_color(Hearts, Ace) = Red;


card_value(Spades, Ace) = 11;
card_value(Clubs, Num(2)) = 2;
card_value(Clubs, Num(11)) = 11;
card_value(Diamonds, King) = 10;


val cards = [(Spades, Queen), (Spades, Num(8)), (Clubs, King), (Diamonds, Ace)];
(remove_card([], (Diamonds, King), IllegalMove) handle IllegalMove => []) = [];
(remove_card(cards, (Diamonds, King), IllegalMove) handle IllegalMove => []) = [];
remove_card(cards, (Spades, Queen), IllegalMove) = [(Spades, Num(8)), (Clubs, King), (Diamonds, Ace)];
remove_card(cards, (Diamonds, Ace), IllegalMove) = [(Spades, Queen), (Spades, Num(8)), (Clubs, King)];
remove_card(cards, (Spades, Num(8)), IllegalMove) = [(Spades, Queen), (Clubs, King), (Diamonds, Ace)];


all_same_color([]) = true;
all_same_color(cards) = false;
all_same_color([(Spades, Queen), (Spades, Num(8)), (Clubs, King)]) = true;
all_same_color([(Clubs, Jack), (Hearts, King)]) = false;
all_same_color([(Clubs, Jack)]) = true;

sum_cards([]) = 0;
sum_cards(cards) = 39;
sum_cards([(Spades, Queen)]) = 10;

score([], 21) = 10;
score(cards, 25) = 3 * 14;
score([(Spades, Queen)], 17) = 3;



officiate([(Clubs, Ace), (Spades, Ace), (Clubs, Ace), (Spades, Ace)], [Draw, Draw, Draw, Draw, Draw], 24) = 13;
officiate([(Clubs, Ace), (Spades, Ace), (Clubs, Ace), (Spades, Ace)], [Draw, Draw, Draw, Draw], 59) = 7;
officiate([(Clubs, Ace), (Diamonds, Ace), (Clubs, Ace), (Hearts, Ace)], [Draw], 11) = 0;

get_substitutions1([["a", "b", "c"], ["b", "c", "a"]], "a") ;
get_substitutions1([["a", "b", "c"], ["b", "c", "a"]], "a") = ["b", "c", "b", "c"];

all_except_option("a", ["a", "b", "c"]) = SOME(["b", "c"]);
all_except_option("a", ["b", "c", "a"]) = SOME(["b", "c"]);


OS.Process.exit(OS.Process.success);