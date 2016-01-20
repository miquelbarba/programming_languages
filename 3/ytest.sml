use "homework3.sml";


if match(Unit, UnitP) = SOME [] then "PASS" else "FAIL";

if match(Unit, ConstP 1) = NONE then "PASS" else "FAIL";

if match(Const 1, UnitP) = NONE then "PASS" else "FAIL";

if match(Const 1, Wildcard) = SOME [] then "PASS" else "FAIL";

if match(Const 1, Variable "xyz") = SOME [("xyz",Const 1)] then "PASS" else "FAIL";

if match(Unit, Variable "xyz") = SOME [("xyz",Unit)] then "PASS" else "FAIL";

if match(Tuple [], Variable "xyz") = SOME [("xyz", Tuple[])] then "PASS" else "FAIL";

if match(Constructor ("abc", Const 1), Variable "xyz") = SOME [("xyz", Constructor("abc", Const 1))] then "PASS" else "FAIL";

if match(Constructor ("abc", Const 1), ConstructorP("xyz", ConstP 2)) = NONE then "PASS" else "FAIL";

if match(Constructor ("abc", Const 1), ConstructorP("abc", ConstP 2)) = NONE then "PASS" else "FAIL";

if match(Constructor ("abc", Const 1), ConstructorP("abc", ConstP 1)) = SOME [] then "PASS" else "FAIL";

if match(Constructor ("abc", Const 1), ConstructorP("abc", Variable "xyz")) = SOME [("xyz", Const 1)] then "PASS" else "FAIL";

if match(Constructor ("a", Constructor("b", Unit)), ConstructorP("a", ConstructorP("b", UnitP))) = SOME [] then "PASS" else "FAIL";

if match(Tuple [Const 1, Unit, Const 2], TupleP [ConstP 1, UnitP, Wildcard]) = SOME [] then "PASS" else "FAIL";

if match(Tuple [Const 1, Unit, Const 2], TupleP [Variable "a", Variable "b", ConstP 2]) = SOME [("a", Const 1),("b", Unit)] then "PASS" else "FAIL";

if match(Tuple [Const 1, Tuple [Unit, Const 3], Const 2], TupleP [Variable "a", Variable "b", ConstP 2]) = SOME [("a", Const 1),("b", Tuple[Unit, Const 3])] then "PASS" else "FAIL";

if match(Tuple [Const 1, Tuple [Unit, Const 3], Const 2], TupleP [Variable "a", TupleP [Variable "b", Wildcard], ConstP 2]) = SOME [("a",Const 1),("b",Unit)] then "PASS" else "FAIL";


OS.Process.exit(OS.Process.success);