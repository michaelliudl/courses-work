-module(chap2).
-export([area/1, area_with_case/1, either_or_both/2, yesno/0, yesno_anonymous_fun/0]).
-export([circumference/1, pair_of_pairs/4, current_pos/0]).
-export([test_record/0, insert_to_db/3]).
-record(customer, {name = "John Doe", address, phone}).
-define(PI, 3.14).
-define(pair(X, Y), {X, Y}).
-define(foo, false).
-undef(foo).
-define(foo, true).
-ifdef(DEBUG).
-export([debug_test/0]).
-define(show(X), io:format("The value of X is: ~w.~n", [X])).
-else.
-define(show(X), ok).
-endif.

%% DB is list of tuple of Key-Value pairs
%% insert_to_db replaces Key-Value pair if Key is found
%% otherwise insert at the end
insert_to_db(Key, Value, [{Key, _}|Rest]) ->
	[{Key, Value}|Rest];
insert_to_db(Key, Value, [Element|Rest]) ->
	[Element|insert_to_db(Key, Value, Rest)];
insert_to_db(Key, Value, []) ->
	[{Key, Value}].

debug_test() ->
	?show(100),
	debug.

current_pos() ->
	[{module, ?MODULE}, {file, ?FILE}, {line, ?LINE}].

circumference(Radius) ->
	Radius * 2 * ?PI.

pair_of_pairs(A, B, C, D) -> ?pair(?pair(A, B), ?pair(C, D)).

test_record() ->
	R_1 = #customer{address = "China Town"},
	R_2 = #customer{phone = "55512345"},
	R_3 = #customer{name = "Sandy Claw", address = "Christmas Town", phone = "5551234567"},
	io:format("customer 1, ~p ~p ~p.~n", [R_1#customer.name, R_1#customer.address, R_1#customer.phone]),
	io:format("customer 2, ~p ~p ~p.~n", [R_2#customer.name, R_2#customer.address, R_2#customer.phone]),
	io:format("customer 3, ~p ~p ~p.~n", [R_3#customer.name, R_3#customer.address, R_3#customer.phone]),
	print_record(R_1),
	print_record(R_2),
	print_record(R_3),
	R_copy_1 = R_3#customer{name = "Jack skellington", address = "Hallow'en", phone = "5555555555"},
	print_record(R_copy_1).

print_record(#customer{name = Name, address = Address, phone = Phone}) when Phone =/= undefined ->
	io:format("customer ~p ~p ~p.~n", [Name, Address, Phone]);
print_record(#customer{}) ->
	io:format("customer without phone number.~n").

area({circle, Radius}) ->
	Radius * Radius * math:pi();
area({square, Side}) ->
	Side * Side;
area({rectangle, Width, Height}) ->
	Width * Height.

area_with_case(Shape) ->
	case Shape of
		{circle, Radius} ->
			Radius * Radius * math:pi();
		{square, Side} ->
			Side * Side;
		{rectangle, Width, Height} ->
			Width * Height
	end.

either_or_both(true, B) when is_boolean(B) ->
	true;
either_or_both(A, true) when is_boolean(A) ->
	true;
either_or_both(false, false) ->
	false;
either_or_both(A, B) ->
	io:format("Arguments are not booleans: [~p] and [~p].~n", [A, B]).

yesno() ->
	yesno(fun either_or_both/2).

yesno(F) ->
	case F(true, false) of
		true -> io:format("yes~n");
		false -> io:format("no~n")
	end.

yesno_anonymous_fun() ->
	yesno(fun (A, B) -> A and B end).