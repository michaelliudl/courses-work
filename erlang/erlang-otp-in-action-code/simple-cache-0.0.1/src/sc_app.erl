%%%-------------------------------------------------------------------
%%% @author doliu
%%% @copyright (C) 2013, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 24. Dec 2013 22:06
%%%-------------------------------------------------------------------
-module(sc_app).
-author("doliu").
-behaviour(application).

%% API
-export([start/2, stop/1]).

start(_Type, _StartArgs) ->
	sc_store:init(),
	case sc_sup:start_link() of
		{ok, Pid} -> {ok, Pid};
		Other -> {error, Other}
	end.

stop(_State) ->
	ok.
