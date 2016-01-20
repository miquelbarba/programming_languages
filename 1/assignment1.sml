fun is_older(date1: int * int * int, date2: int * int * int) =
    (#1 date1 > #1 date2) orelse 
    ((#1 date1 = #1 date2) andalso (#2 date1 > #2 date2)) orelse
    ((#1 date1 = #1 date2) andalso (#2 date1 = #2 date2) andalso (#3 date1 > #3 date2))


fun number_in_month(date_list: (int * int * int) list, month: int) = 
    if null date_list
    then 0
    else 
        if #2(hd date_list) = month
        then 1 + number_in_month(tl date_list, month)
        else number_in_month(tl date_list, month)


fun number_in_months(date_list: (int * int * int) list, month_list: int list) = 
    if null month_list orelse null date_list
    then 0
    else number_in_month(date_list, hd month_list) + number_in_months(date_list, tl month_list)


fun dates_in_month(date_list: (int * int * int) list, month: int) =
    if null date_list
    then []
    else 
        if #2(hd date_list) = month
        then hd(date_list)::dates_in_month(tl date_list, month)
        else dates_in_month(tl date_list, month)


fun dates_in_months(date_list: (int * int * int) list, month_list: int list) =
    if null date_list orelse null month_list
    then []
    else dates_in_month(date_list, hd month_list) @ dates_in_months(date_list, tl month_list)


fun get_nth(xs: string list, n: int) =
    let
        fun get_nth_internal(xs: string list, n: int, i: int) =
            if i = n
            then hd xs
            else get_nth_internal(tl xs, n, i + 1)
    in
        get_nth_internal(xs, n, 1)
    end


fun date_to_string(date: int * int * int) =
    let
        val months = ["January", "February", "March", "April", "May", "June", "July",  
                      "August", "September", "October", "November", "December"];
    in
        get_nth(months, #2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
    end


fun number_before_reaching_sum(sum: int, xs: int list) =
    let
        fun number_before_reaching_sum_internal(sum: int, xs: int list, current_sum: int, i: int) =
            if current_sum + hd(xs) < sum
            then number_before_reaching_sum_internal(sum, tl xs, current_sum + hd xs, i + 1)
            else i
    in
        number_before_reaching_sum_internal(sum, xs, 0, 0)
    end


fun what_month(day: int) =
    let
        val days_by_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
        number_before_reaching_sum(day, days_by_month) + 1
    end


fun month_range(day1: int, day2: int) =
    let
        fun month_range_internal(max: int, current: int) =
            if current > max            
            then []
            else what_month(current)::month_range_internal(max, current + 1)
    in
        month_range_internal(day2, day1)
    end


fun oldest(date_list: (int * int * int) list) =
    let  
        fun oldest_internal(date: (int * int * int), date_list: (int * int * int) list) =
            null(date_list) orelse (is_older(date, hd date_list) andalso oldest_internal(date, tl date_list))
    in
        if null date_list
        then NONE
        else 
            if oldest_internal(hd date_list, tl date_list )
            then SOME (hd date_list)
            else oldest(tl date_list)
    end


fun remove_repeated(xs: int list) =
    let
        fun remove_repeated_internal(xs: int list, item: int) =
            if null xs
            then []
            else
              if hd(xs) = item
              then remove_repeated_internal(tl xs, item)
              else hd(xs)::remove_repeated_internal(tl xs, item)
    in
        if null xs
        then []
        else
            hd(xs) :: remove_repeated(remove_repeated_internal(tl xs, hd xs))
    end


fun number_in_months_challenge(date_list: (int * int * int) list, month_list: int list) = 
    let
        val uniq_month_list = remove_repeated(month_list)
    in
        if null uniq_month_list orelse null date_list
        then 0
        else number_in_month(date_list, hd uniq_month_list) + number_in_months_challenge(date_list, tl uniq_month_list)
    end    


fun dates_in_months_challenge(date_list: (int * int * int) list, month_list: int list) =
    let
        val uniq_month_list = remove_repeated(month_list)
    in
        if null date_list orelse null uniq_month_list
        then []
        else dates_in_month(date_list, hd uniq_month_list) @ dates_in_months(date_list, tl uniq_month_list)
    end