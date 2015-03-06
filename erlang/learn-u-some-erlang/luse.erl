-module(luse). %% luse = learn_you_some_erlang
-export([duplicate/2, tail_duplicate/2, reverse/1, tail_reverse/1, sublist/2, tail_sublist/2, zip/2, tail_zip/2]).
-export([quicksort/1, lc_quicksort/1]).

lc_quicksort([]) -> [];
lc_quicksort([Pivot|Rest]) ->
	lc_quicksort([Smaller || Smaller <- Rest, Smaller =< Pivot])
	++ [Pivot] ++
	lc_quicksort([Larger || Larger <- Rest, Larger > Pivot]).

quicksort([]) -> [];
quicksort([Pivot|Rest]) ->
	{Smaller, Larger} = partition(Pivot, Rest, [], []),
	quicksort(Smaller) ++ [Pivot] ++ quicksort(Larger).

partition(_, [], Smaller, Larger) -> {Smaller, Larger};
partition(Pivot, [H|T], Smaller, Larger) ->
	if H =< Pivot -> partition(Pivot, T, [H|Smaller], Larger);
	   H >  Pivot -> partition(Pivot, T, Smaller, [H|Larger])
	end.

duplicate(0, _) ->
	[];
duplicate(N, Term) when N>0 ->
	[Term|duplicate(N-1, Term)].

tail_duplicate(N, Term) when N>0 ->
	tail_duplicate(N, Term, []).
tail_duplicate(0, _, List) ->
	List;
tail_duplicate(N, Term, List) ->
	tail_duplicate(N-1, Term, [Term|List]).

reverse([]) ->
	[];
reverse([H|T]) ->
	reverse(T) ++ [H].

tail_reverse(List) ->
	tail_reverse(List, []).
tail_reverse([], List) ->
	List;
tail_reverse([H|T], List) ->
	tail_reverse(T, [H|List]).

sublist([], _) ->
	[];
sublist(_, 0) ->
	[];
sublist([H|T], N) ->
	[H|sublist(T, N-1)].

tail_sublist(List, N) ->
	tail_reverse(tail_sublist(List, N, [])).
tail_sublist([], _, List) ->
	List;
tail_sublist(_, 0, List) ->
	List;
tail_sublist([H|T], N, List) when N>0 ->
	tail_sublist(T, N-1, [H|List]).

zip([], _) ->
	[];
zip(_, []) ->
	[];
zip([H1|T1], [H2|T2]) ->
	[{H1, H2}|zip(T1, T2)].

tail_zip(List1, List2) ->
	tail_zip(List1, List2, []).
tail_zip([], _, Acc) ->
	Acc;
tail_zip(_, [], Acc) ->
	Acc;
tail_zip([H1|T1], [H2|T2], Acc) ->
	tail_zip(T1, T2, Acc ++ [{H1, H2}]).
