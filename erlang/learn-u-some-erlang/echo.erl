%%%-------------------------------------------------------------------
%%% @author doliu
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. Jul 2014 16:32
%%%-------------------------------------------------------------------
-module(echo).
-author("doliu").

%% API
-export([go/0, loop/0]).
-export([top_recover/2]).
-export([try_catch/1]).

go() ->
	Pid2 = spawn(echo, loop, []),
    Pid2 ! {self(), hello},
    receive
	    {Pid2, Msg} ->
		    io:format("P1 ~w~n", [Msg])
    end,
	Pid2 ! stop.

loop() ->
    receive
	    {From, Msg} ->
		    From ! {self(), Msg},
		    loop();
	    stop ->
		    true
    end.

top_recover(Free, Allocated) ->
    receive
	    {Pid, alloc} ->
		    top_recover_alloc(Free, Allocated, Pid);
	    {Pid, {release, Resource}} ->
		    unlink(Pid),
		    Allocated_1 = delete({Resource, Pid}, Allocated),
		    top_recover([Resource|Free], Allocated_1);
	    {'EXIT', Pid, Reason} ->
		    Resource = lookup(Pid, Allocated),
		    Allocated_1 = delete({Resource, Pid}, Allocated),
		    top_recover([Resource|Free], Allocated_1)
    end.

top_recover_alloc([], Allocated, Pid) ->
    Pid ! no,
    top_recover([], Allocated);
top_recover_alloc([Resource|Free], Allocated, Pid) ->
    Pid ! {yes, Resource},
	link(Pid),
	top_recover(Free, [{Resource, Pid}|Allocated]).

lookup(Pid, [{Resource, Pid}|Allocated]) ->
	Resource;
lookup(Pid, [_|Allocated]) ->
	lookup(Pid, Allocated).

delete(H, [H|T]) ->
	T;
delete(X, [H|T]) ->
	[H|delete(X, T)].

try_catch(1) -> hello;
try_catch(2) -> throw({myError, abc});
try_catch(3) -> tuple_to_list(a);
try_catch(4) -> exit({myExit, 222}).