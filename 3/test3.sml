use "homework3.sml";

only_capitals(["A"]) = ["A"];
only_capitals(["b"]) = [];
only_capitals([]) = [];
only_capitals(["A", "b"]) = ["A"];
only_capitals(["a", "b", "All", "Old", "a", "Every"]) = ["All", "Old", "Every"];


longest_string1([]) = "";
longest_string1(["a"]) = "a";
longest_string1(["a", "b"]) = "a";
longest_string1(["aaa", "b", "cc", "ccc"]) = "aaa";
longest_string1(["a", "aa"]) = "aa";
longest_string1(["a", "aAa", "b"]) = "aAa";
longest_string1 ["this","list","has","no","capital","letters"] = "capital";
longest_string1 ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","NorthCarolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","southCarolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"] = "massachusetts";


longest_string2([]) = "";
longest_string2(["a"]) = "a";
longest_string2(["a", "b"]) = "b";
longest_string2(["aaa", "b", "cc", "ccc"]) = "ccc";
longest_string2(["a", "aa"]) = "aa";
longest_string2(["a", "aAa", "b"]) = "aAa";
longest_string2 ["this","list","has","no","capital","letters"] = "letters";
longest_string2 ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","NorthCarolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","southCarolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"] = "West Virginia";


longest_string3([]) = "";
longest_string3(["a"]) = "a";
longest_string3(["a", "b"]) = "a";
longest_string3(["aaa", "b", "cc", "ccc"]) = "aaa";
longest_string3(["a", "aa"]) = "aa";
longest_string3(["a", "aAa", "b"]) = "aAa";
longest_string3 ["this","list","has","no","capital","letters"] = "capital";
longest_string3 ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","NorthCarolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","southCarolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"] = "massachusetts";


longest_string4 ["this","list","has","no","capital","letters"] = "letters";
longest_string4 ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","NorthCarolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","southCarolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"] = "West Virginia";
longest_string4([]) = "";
longest_string4(["a"]) = "a";
longest_string4(["a", "b"]) = "b";
longest_string4(["aaa", "b", "cc", "ccc"]) = "ccc";
longest_string4(["a", "aa"]) = "aa";
longest_string4(["a", "aAa", "b"]) = "aAa";


longest_capitalized([]) = "";
longest_capitalized(["a"]) = "";
longest_capitalized(["a", "b"]) = "";
longest_capitalized(["aaa", "b", "cc", "ccc"]) = "";
longest_capitalized(["a", "aa"]) = "";
longest_capitalized(["a", "aAa", "b"]) = "";
longest_capitalized(["A"]) = "A";
longest_capitalized(["A", "B"]) = "A";
longest_capitalized(["Aaa", "B", "cc", "Ccc"]) = "Aaa";
longest_capitalized(["a", "Aa"]) = "Aa";
longest_capitalized(["a", "aAa", "B"]) = "B";


rev_string("hola") = "aloh";
rev_string("") = "";
rev_string("AbcbA") = "AbcbA";


first_answer (fn x => SOME(x)) [1, 2, 3] = 1;
first_answer (fn x => if x mod 2 = 0 then SOME(x) else NONE) [1, 2, 3] = 2;
(first_answer (fn x => if x mod 2 = 0 then SOME(x) else NONE) [1, 3, 5] handle NoAnswer => 99999) = 99999;


all_answers (fn x => SOME([x])) [] = SOME([]);
all_answers (fn x => SOME([String.size(x)])) ["a"] = SOME([1]);
all_answers (fn x => SOME([String.size(x)])) ["a", "aa", "bbb"] = SOME([1, 2, 3]);
all_answers (fn x => SOME([1 * x, 2 * x, 3 * x])) [1, 2, 3] = SOME([1, 2, 3, 2, 4, 6, 3, 6, 9]);


count_wildcards (TupleP [Wildcard, ConstP 3, Wildcard, UnitP, Wildcard]) = 3;
count_wildcards (ConstP 3) = 0;
count_wildcards (Variable "a") = 0;
count_wildcards (TupleP [Variable "abc", Variable "de"]) = 0;
count_wildcards (TupleP [Variable "ab", Wildcard, ConstP 3, Variable "de"]) = 1;


count_wild_and_variable_lengths (TupleP [Wildcard, ConstP 3, Wildcard, UnitP, Wildcard]) = 3;
count_wild_and_variable_lengths (ConstP 3) = 0;
count_wild_and_variable_lengths (Variable "a") = 1;
count_wild_and_variable_lengths (TupleP [Variable "abc", Variable "de"]) = 5;
count_wild_and_variable_lengths (TupleP [Variable "ab", Wildcard, ConstP 3, Variable "de"]) = 5;


count_some_var ("a", (TupleP [Wildcard, ConstP 3, Wildcard, UnitP, Wildcard])) = 0;
count_some_var ("3", (ConstP 3)) = 0;
count_some_var ("a", (Variable "a")) = 1;
count_some_var ("aa", (Variable "a")) = 0;
count_some_var ("abc", (TupleP [Variable "abc", Variable "abc"])) = 2;
count_some_var ("de", (TupleP [Variable "ab", Wildcard, ConstP 3, Variable "de"])) = 1;
count_some_var ("abc", (TupleP [Variable "abc", (TupleP [Variable "abc", Variable "abc"])])) = 3;


check_pat (TupleP [Wildcard, ConstP 3, Wildcard, UnitP, Wildcard]) = true;
check_pat (ConstP 3) = true;
check_pat (Variable "a") = true;
check_pat (TupleP [Variable "abc", Variable "abc"]) = false;
check_pat (TupleP [Variable "ab", Wildcard, ConstP 3, Variable "de"]) = true;


match( Const 7, Wildcard ) = SOME [];
match( Unit, Wildcard ) = SOME [];
match( Tuple[Const 7], Wildcard ) = SOME [];
match( Constructor("ABC", Const 7), Wildcard ) = SOME [];

match( Const 7, Variable "A" ) = SOME [("A", Const 7)];
match( Unit, Variable "sName" ) = SOME [("sName", Unit)];

match( Unit, UnitP ) = SOME [];
match( Const 7, UnitP ) = NONE;

match( Const 7, ConstP 7 ) = SOME [];
match( Const 7, ConstP 8 ) = NONE;

match( Constructor("ABC", Const 1), ConstructorP( "ABC", Wildcard ) ) = SOME[];
match( Constructor("AB", Const 4), ConstructorP( "ABC", Wildcard ) ) = NONE;
match( Constructor("ABC", Const 5), ConstructorP( "ABC", UnitP ) ) = NONE;
match( Constructor("ABC", Const 8), ConstructorP( "ABC", Variable "bbba" ) ) = SOME[("bbba", Const 8)];

match( Tuple [Const 1], TupleP [ConstP 1] ) = SOME [];

match( Tuple [Const 2], TupleP [ConstP 2, ConstP 2] ) = NONE;

match( Tuple[Const 1, Const 2, Unit, Const 9], 
       TupleP[ConstP 1, Variable "ba", Wildcard, ConstP 9] ) = SOME [("ba",Const 2)];

match( Tuple[Const 5, Const 6, Unit, Const 1], 
       TupleP[Variable "a", Variable "ba", Variable "bba", Variable "bbba"] ) = 
            SOME [("a",Const 5),("ba",Const 6),("bba",Unit),("bbba",Const 1)];


first_match (Const 7) [ConstP 1, UnitP, ConstP 7, Variable "aa"] = SOME [];
first_match (Const 7) [ConstP 1, UnitP, Variable "aa", ConstP 7] = SOME [("aa", Const 7)];
first_match (Const 7) [ConstP 1, UnitP, TupleP [UnitP, UnitP]] = NONE;
           

OS.Process.exit(OS.Process.success);