-module(tut).
-export([double/1, fac/1, mult/2, convert/2, convert_length/1, list_length/1, format_temps/1, list_max/1, list_reverse/1]).
-export([format_temps_list/1, test_if/2, convert_length_case/1, month_length/2, test_bifs/0]).
-export([convert_list_to_c_fun/1]).
-export([area/1]).
-export([format_temps_tut/1]).

area({square, Side}) ->
    Side * Side;
area({rectangle, X, Y}) ->
    X * Y;
area({circle, Radius}) ->
    math:pi() * Radius * Radius;
area({triangle, A, B, C}) ->
    P = (A+B+C)/2,
    math:sqrt(P*(P-A)*(P-B)*(P-C)). %% Heron's formulus

convert_to_c({Name, {f, Temp}}) ->
    {Name, {c, trunc((Temp - 32) * 5 / 9)}};
convert_to_c({Name, {c, Temp}}) ->
    {Name, {c, Temp}}.

convert_list_to_c_fun(List) ->
    New_list = lists:map(fun convert_to_c/1, List),
    lists:sort(fun({_, {c, Temp1}}, {_, {c, Temp2}}) -> Temp1 < Temp2 end,
        New_list).

test_bifs() ->
    % can be used as guard
    % user defined functions can't be used as guard
    io:format("trunc(5.6) = ~w~n", [trunc(5.6)]),
    io:format("round(5.6) = ~w~n", [round(5.6)]),
    io:format("length([a,b,c,d]) = ~w~n", [length([a,b,c,d])]),
    io:format("float(5) = ~w~n", [float(5)]),
    io:format("is_atom(hello) = ~w~n", [is_atom(hello)]),
    io:format("is_atom(\"hello\") = ~w~n", [is_atom("hello")]),
    io:format("is_tuple({paris, {c, 30}}) = ~w~n", [is_tuple({paris, {c, 30}})]),
    io:format("is_tuple([paris, {c, 30}]) = ~w~n", [is_tuple([paris, {c, 30}])]),
    % not to be used as guard
    io:format("atom_to_list(hello) = ~w~n", [atom_to_list(hello)]),
    io:format("list_to_atom(\"hello\") = ~w~n", [list_to_atom("hello")]),
    io:format("integer_to_list(22) = ~w~n", [integer_to_list(22)]).


month_length(Year, Month) ->
    %% All years divisible by 400 are leap
    %% Years divisible by 100 are not leap (except the 400 rule above)
    %% Years divisible by 4 are leap (except the 100 rule above)
    Leap = if
        trunc(Year / 400) * 400 == Year ->
            leap;
        trunc(Year / 100) * 100 == Year ->
            not_leap;
        trunc(Year / 4) * 4 == Year ->
            leap;
        true ->
            not_leap
    end,
    Leap1 = if
        Year rem 400 == 0 -> leap;
        Year rem 100 == 0 -> not_leap;
        Year rem 4 == 0 -> leap;
        true -> not_leap
    end,
    case Month of
        sep -> 30;
        apr -> 30;
        jun -> 30;
        nov -> 30;
        feb when Leap == leap -> 29;
        feb -> 28;
        jan -> 31;
        mar -> 31;
        may -> 31;
        jul -> 31;
        aug -> 31;
        oct -> 31;
        dec -> 31
    end.

convert_length_case(Length) ->
    case Length of
        {centimeter, X} ->
            {inch, X / 2.54};
        {inch, Y} ->
            {centimeter, Y * 2.54}
    end.

test_if(A, B) ->
    if
        A == 5 ->
            io:format("A == 5~n", []),
            a_equals_5;
        B == 6 ->
            io:format("B == 6~n", []),
            b_equals_6;
        A == 2, B == 3 ->
            io:format("A == 2, B == 3~n", []),
            a_equals_2_and_b_equals_3;
        A == 1; B == 7 ->
            io:format("A == 1, B == 7~n", []),
            a_equals_1_or_b_equals_7;
        true ->
            everything_else
    end.

%% Temps = [{moscow, {c, -1}}, {cape_town, {f, 70}}, {stockholm, {c, -4}}, {paris, {f, 28}}, {london, {f, 36}}].
%% tut:format_temps_list(Temps).
format_temps_list(List_of_cities) ->
    Converted_list = convert_list_to_c(List_of_cities),
    print_temp_list(Converted_list),
    {Max_City, Min_City} = find_max_and_min(Converted_list),
    print_max_and_min(Max_City, Min_City).

find_max_and_min([City | Rest]) ->
    find_max_and_min(Rest, City, City).

find_max_and_min([{Name, {c, Temp}} | Rest],
        {Max_Name, {c, Max_Temp}},
        {Min_Name, {c, Min_Temp}}) ->
    if
        Temp > Max_Temp ->
            Max_City = {Name, {c, Temp}};
        true ->
            Max_City = {Max_Name, {c, Max_Temp}}
    end,
    if
        Temp < Min_Temp ->
            Min_City = {Name, {c, Temp}};
        true ->
            Min_City = {Min_Name, {c, Min_Temp}}
    end,
    find_max_and_min(Rest, Max_City, Min_City);
find_max_and_min([], Max_City, Min_City) ->
    {Max_City, Min_City}.

print_max_and_min({Max_Name, {c, Max_Temp}}, {Min_Name, {c, Min_Temp}}) ->
    io:format("Max temperature was ~w c in ~w~n", [Max_Temp, Max_Name]),
    io:format("Min temperature was ~w c in ~w~n", [Min_Temp, Min_Name]).

print_temp_list([{Name, {c, Temp}} | Rest]) ->
    io:format("~-15w ~w c~n", [Name, Temp]),
    print_temp_list(Rest);
print_temp_list([]) ->
    ok.

convert_list_to_c([]) ->
    [];
convert_list_to_c([{Name, {f, F}} | Rest]) ->
    Converted_city = {Name, {c, (F - 32) * 5 / 9}},
    [Converted_city | convert_list_to_c(Rest)];
convert_list_to_c([City | Rest]) ->
    [City | convert_list_to_c(Rest)].

%% List = [1,2,3,4,5,7,4,3,2,1].
%% tut:list_reverse(List).
list_reverse(List) ->
    list_reverse(List, []).

list_reverse([Head | Tail], Reversed_list) ->
    list_reverse(Tail, [Head | Reversed_list]);
list_reverse([], Reversed_list) ->
    Reversed_list.

%% List = [1,2,3,4,5,7,4,3,2,1].
%% tut:list_max(List).
list_max([]) ->
    "empty_list";
list_max([Head | Tail]) ->
    list_max(Tail, Head).

list_max([], Res) ->
    Res;
list_max([Head | Tail], Result_so_far) when Head > Result_so_far ->
    list_max(Tail, Head);
list_max([Head | Tail], Result_so_far) ->
    list_max(Tail, Result_so_far).

%% Temps = [{moscow, {c, -1}}, {cape_town, {f, 70}}, {stockholm, {c, -4}}, {paris, {f, 28}}, {london, {f, 36}}].
%% tut:format_temps(Temps).
format_temps([]) ->
    ok;
format_temps([City | Rest]) ->
    print_temp(convert_to_celcius(City)),
    format_temps(Rest).

convert_to_celcius({Name, {c, Temp}}) ->
    {Name, {c, Temp}};
convert_to_celcius({Name, {f, Temp}}) ->
    {Name, {c, (Temp - 32) * 5 / 9}}.

print_temp({Name, {c, Temp}}) ->
    io:format("~-15w ~w c~n", [Name, Temp]).


double(X) ->
    2 * X.

fac(1) ->
    1;
fac(X) ->
    X * fac(X - 1).

mult(X, Y) ->
    X * Y.

convert(M, inch) ->
    M / 2.54;
convert(N, centimeter) ->
    N * 2.54.

convert_length({centimeter, X}) ->
    {inch, X / 2.54};
convert_length({inch, X}) ->
    {centimeter, X * 2.54}.

list_length([]) ->
    0;
list_length([First | Rest]) ->
    1 + list_length(Rest).

format_temps_tut(List_of_cities) ->
	Converted_list = convert_list_to_c_tut(List_of_cities),
	print_temp_tut(Converted_list),
	{Max_city, Min_city} = find_max_and_min_tut(Converted_list),
	print_max_and_min_tut(Max_city, Min_city).

convert_list_to_c_tut([]) -> [];
convert_list_to_c_tut([{Name, {f, Temp}} | Rest]) ->
	Converted_city = {Name, {c, (Temp - 32) * 5 / 9}},
	[Converted_city | convert_list_to_c(Rest)];
convert_list_to_c_tut([City | Rest]) ->
	[City | convert_list_to_c(Rest)].

print_temp_tut([]) -> ok;
print_temp_tut([{Name, {c, Temp}} | Rest]) ->
	io:format("~-15w ~w c~n", [Name, Temp]),
	print_temp(Rest).

find_max_and_min_tut([City | Rest]) ->
	find_max_and_min_tut(Rest, City, City).

find_max_and_min_tut([], Max, Min) ->
	{Max, Min};
find_max_and_min_tut([{Name, {c, Temp}} | Rest],
	{Max_name, {c, Max_temp}},
	{Min_name, {c, Min_temp}}) ->
	if
		Temp > Max_temp ->
			Max_city = {Name, {c, Temp}};
		true ->
			Max_city = {Max_name, {c, Max_temp}}
	end,
	if
		Temp < Min_temp ->
			Min_city = {Name, {c, Temp}};
		true ->
			Min_city = {Min_name, {c, Min_temp}}
	end,
	find_max_and_min(Rest, Max_city, Min_city).

print_max_and_min_tut({Max_name, {c, Max_temp}}, {Min_name, {c, Min_temp}}) ->
	io:format("Max temperature was ~w c in ~w~n", [Max_name, Max_temp]),
	io:format("Min temperature was ~w c in ~w~n", [Min_name, Min_temp]).
