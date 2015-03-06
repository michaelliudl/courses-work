%%%-------------------------------------------------------------------
%%% @author doliu
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. Aug 2014 17:37
%%%-------------------------------------------------------------------
-module(pingpong).
-author("doliu").

%% API
-export([start_ping_pong/0]).

% ping pong
ping(0, Pong_PID) ->
	Pong_PID ! finished,
	io:format("Ping finished~n", []);
ping(N, Pong_PID) ->
	Pong_PID ! {ping, self()},
	receive
		pong ->
			io:format("Ping receives pong~n", [])
	end,
	ping(N - 1, Pong_PID).

pong() ->
	receive
		finished ->
			io:format("Pong finished~n", []);
		{ping, Ping_PID} ->
			io:format("Pong receives ping~n", []),
			Ping_PID ! pong,
			pong()
	end.

start_ping_pong() ->
	Pong_PID = spawn(pingpong, pong, []),
	spawn(pingpong, ping, [10, Pong_PID]).