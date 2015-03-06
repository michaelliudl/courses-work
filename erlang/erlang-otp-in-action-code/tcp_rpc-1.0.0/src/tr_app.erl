%%%-------------------------------------------------------------------
%%% @author doliu
%%% @copyright (C) 2013, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 23. Dec 2013 23:12
%%%-------------------------------------------------------------------
-module(tr_app).
-author("doliu").
-behaviour(application).

%% API
-export([start/2, stop/1]).

start(_Type, _StartArgs) ->
    case tr_sup:start_link() of
	    {ok, Pid} -> {ok, Pid};
	    Other -> {error, Other}
    end.

stop(_State) -> ok.