%%%-------------------------------------------------------------------
%%% @author doliu
%%% @copyright (C) 2013, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 24. Dec 2013 11:06
%%%-------------------------------------------------------------------
-module(tr_sup).
-author("doliu").
-behaviour(supervisor).
%% API
-export([start_link/0]).

%% supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
	supervisor:start_link({local, ?SERVER}, ?MODULE, []).

init([]) ->
    Server = {tr_server, {tr_server, start_link, []},
              permanent, 2000, worker, [tr_server]},
	Children = [Server],
	RestartStrategy = {one_for_one, 0, 1},
	{ok, {RestartStrategy, Children}}.