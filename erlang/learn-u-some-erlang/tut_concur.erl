-module(tut_concur).
-export([start_say/0, say_something/2]).
-export([start_enjoy/0]).

start_enjoy() ->
	[spawn(fun() -> say_enjoy(self(), Str) end) || Str <- ['Enjoy', 'Rosetta', 'Code'],
    wait(2),
    ok.

say_enjoy(Pid, Str) ->
    io:fwrite("~s~n", Str),
    Pid ! done.

wait(N) ->
    receive
        done -> case N of
            0 -> 0;
            _N -> wait(N - 1)
        end
    end.

% say
say_something(What, 0) ->
	done;
say_something(What, Times) ->
	io:format("~p~n", [What]),
	say_something(What, Times - 1).

start_say() ->
	spawn(tut_concur, say_something, [hello, 3]),
	spawn(tut_concur, say_something, [goodbye, 5]).
