val d1 = (2013, 10, 2)
val d2 = (2011, 11, 10)
val d3 = (1900, 1, 12)
val d4 = (1999, 10, 12)

val t1_1 = is_older(d1, d2)
val t1_2 = not(is_older(d2, d1))
val t1_3 = is_older(d1, d3)
val t1_4 = not(is_older(d3, d2))
val t1_5 = not(is_older(d1, d1))



val t2_1 = number_in_month([], 10) = 0
val t2_2 = number_in_month([d1], 11) = 0
val t2_3 = number_in_month([d1], 10) = 1
val t2_4 = number_in_month([d1, d2, d1, d3], 10) = 2
val t2_5 = number_in_month([d2, d2, d2, d3], 11) = 3



val t3_1 = number_in_months([], []) = 0
val t3_2 = number_in_months([d1], []) = 0
val t3_3 = number_in_months([], [1]) = 0
val t3_4 = number_in_months([d1], [1]) = 0
val t3_5 = number_in_months([d1], [10]) = 1
val t3_6 = number_in_months([d1, d2], [10]) = 1
val t3_7 = number_in_months([d1, d2], [10, 2]) = 1
val t3_8 = number_in_months([d1, d2, d3], [10, 11]) = 2
val t3_9 = number_in_months([d1, d2, d3], [1, 10, 11]) = 3



val t4_1 = dates_in_month([], 1) = []
val t4_2 = dates_in_month([d1], 1) = []
val t4_3 = dates_in_month([d1, d2], 10) = [d1]
val t4_4 = dates_in_month([d1, d2], 11) = [d2]
val t4_5 = dates_in_month([d1, d2, d3, d4], 10) = [d1, d4]



val t5_1 = dates_in_months([], []) = []
val t5_2 = dates_in_months([d1], []) = []
val t5_3 = dates_in_months([], [1]) = []
val t5_4 = dates_in_months([d1], [1]) = []
val t5_5 = dates_in_months([d1], [10]) = [d1]
val t5_6 = dates_in_months([d1, d2, d3], [1, 10, 11]) = [d3, d1, d2]
val t5_7 = dates_in_months([d1, d1, d2, d1, d3, d3, d1, d4], [1, 10]) = [d3, d3, d1, d1, d1, d1, d4]



val t6_1 = get_nth(["a"], 1) = "a"
val t6_2 = get_nth(["a", "b", "c"], 3) = "c"
val t6_3 = get_nth(["a", "b", "c"], 2) = "b"
val t6_4 = get_nth(["a", "b", "c"], 1) = "a"



val t7_1 = date_to_string(d1) = "October 2, 2013"
val t7_2 = date_to_string(d2) = "November 10, 2011"  
val t7_3 = date_to_string(d3) = "January 12, 1900"
val t7_4 = date_to_string(d4) = "October 12, 1999"



val t8_1 = number_before_reaching_sum(1, [1, 2, 3, 4]) = 0
val t8_2 = number_before_reaching_sum(2, [1, 2, 3, 4]) = 1
val t8_3 = number_before_reaching_sum(3, [1, 2, 3, 4]) = 1
val t8_4 = number_before_reaching_sum(4, [1, 2, 3, 4]) = 2
val t8_5 = number_before_reaching_sum(5, [1, 2, 3, 4]) = 2
val t8_6 = number_before_reaching_sum(6, [1, 2, 3, 4]) = 2
val t8_7 = number_before_reaching_sum(7, [1, 2, 3, 4]) = 3
val t8_8 = number_before_reaching_sum(8, [1, 2, 3, 4]) = 3
val t8_9 = number_before_reaching_sum(9, [1, 2, 3, 4]) = 3
val t8_10 = number_before_reaching_sum(10, [1, 2, 3, 4]) = 3
val t8_11 = number_before_reaching_sum(1, [1]) = 0



val t9_1 = what_month(1) = 1
val t9_2 = what_month(31) = 1
val t9_3 = what_month(32) = 2
val t9_4 = what_month(59) = 2
val t9_5 = what_month(60) = 3
val t9_6 = what_month(90) = 3
val t9_7 = what_month(91) = 4
val t9_8 = what_month(120) = 4
val t9_9 = what_month(121) = 5
val t9_10 = what_month(151) = 5
val t9_11 = what_month(152) = 6
val t9_12 = what_month(181) = 6
val t9_13 = what_month(182) = 7
val t9_14 = what_month(212) = 7
val t9_15 = what_month(213) = 8
val t9_16 = what_month(243) = 8
val t9_17 = what_month(244) = 9
val t9_18 = what_month(273) = 9
val t9_19 = what_month(274) = 10
val t9_20 = what_month(304) = 10
val t9_21 = what_month(305) = 11
val t9_22 = what_month(334) = 11
val t9_23 = what_month(335) = 12
val t9_24 = what_month(365) = 12



val t10_1 = month_range(2, 1) = []
val t10_2 = month_range(1, 365) = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12] 



val t11_1 = oldest([]) = NONE
val t11_2 = valOf(oldest([d1])) = d1
val t11_3 = valOf(oldest([d1, d2, d3, d4])) = d1
val t11_4 = valOf(oldest([d2, d3, d4])) = d2
val t11_5 = valOf(oldest([d2, d3, d1])) = d1
val t11_6 = valOf(oldest([d3, d4])) = d4
val t11_7 = valOf(oldest([d3])) = d3



val t12_1_1 = number_in_months_challenge([], []) = 0
val t12_1_2 = number_in_months_challenge([d1], []) = 0
val t12_1_3 = number_in_months_challenge([], [1]) = 0
val t12_1_4 = number_in_months_challenge([d1], [1, 1]) = 0
val t12_1_5 = number_in_months_challenge([d1], [10, 10, 10]) = 1
val t12_1_6 = number_in_months_challenge([d1, d2], [10]) = 1
val t12_1_7 = number_in_months_challenge([d1, d2], [10, 2, 2, 2]) = 1
val t12_1_8 = number_in_months_challenge([d1, d2, d3], [10, 11, 10, 11, 10, 11, 10]) = 2
val t12_1_9 = number_in_months_challenge([d1, d2, d3], [1, 10, 11]) = 3

val t12_2_1 = dates_in_months_challenge([], []) = []
val t12_2_2 = dates_in_months_challenge([d1], []) = []
val t12_2_3 = dates_in_months_challenge([], [1]) = []
val t12_2_4 = dates_in_months_challenge([d1], [1, 1, 1]) = []
val t12_2_5 = dates_in_months_challenge([d1], [10, 10]) = [d1]
val t12_2_6 = dates_in_months_challenge([d1, d2, d3], [1, 1, 10, 11, 10, 1]) = [d3, d1, d2]
val t12_2_7 = dates_in_months_challenge([d1, d1, d2, d1, d3, d3, d1, d4], [1, 10, 10, 1, 10]) = [d3, d3, d1, d1, d1, d1, d4]
