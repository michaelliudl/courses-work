%%%-------------------------------------------------------------------
%%% @author doliu
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. Aug 2014 17:38
%%%-------------------------------------------------------------------
-module(pingpong_registered).
-author("doliu").

%% API
-export([start_ping_pong_registered/0]).

% ping pong with register
ping_registered(0) ->
	pong_registered ! finished,
	io:format("Ping with register finished~n", []);
ping_registered(N) ->
	pong_registered ! ping_with_register,
	receive
		pong_with_register ->
			io:format("Ping with register receives pong_with_register, time ~w~n", [N])
	end,
	ping_registered(N - 1).

pong_registered() ->
	receive
		finished ->
			io:format("Pong with register finished~n", []);
		ping_with_register ->
			io:format("Pong with register receives ping_with_register~n", []),
			ping_registered ! pong_with_register,
			pong_registered()
	after
		5000 ->
			io:format("Pong timed out.~n", [])
	end.

start_ping_pong_registered() ->
	register(pong_registered, spawn(pingpong_registered, pong_registered, [])),
	register(ping_registered, spawn(pingpong_registered, ping_registered, [5])),
	ping_pong_started_and_registered.