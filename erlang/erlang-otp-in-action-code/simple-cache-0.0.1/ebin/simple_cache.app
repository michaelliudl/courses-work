%%%-------------------------------------------------------------------
%%% @author doliu
%%% @copyright (C) 2013, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 24. Dec 2013 22:16
%%%-------------------------------------------------------------------
{application, simple_cache, [
	{description, "A simple cache system"},
	{vsn, "0.0.1"},
	{modules, [
		sc_app,
		sc_sup
	]},
	{registered, [sc_sup]},
	{applications, [
		kernel,
		stdlib
	]},
	{mod, {sc_app, []}},
	{env, []}
]}.