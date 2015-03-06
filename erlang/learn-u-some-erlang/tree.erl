-module(tree).
-export([empty/0, insert/3, lookup/2]).

empty() ->
	{node, nil}.

insert(Key, Value, {node, nil}) ->
	{node, {Key, Value, {node, nil}, {node, nil}}};
insert(Key, Value, {node, {CurrentKey, CurrentValue, Left, Right}}) when Key < CurrentKey ->
	{node, {CurrentKey, CurrentValue, insert(Key, Value, Left), Right}};
insert(Key, Value, {node, {CurrentKey, CurrentValue, Left, Right}}) when Key > CurrentKey ->
	{node, {CurrentKey, CurrentValue, Left, insert(Key, Value, Right)}};
insert(Key, Value, {node, {Key, _, Left, Right}}) ->
	{node, {Key, Value, Left, Right}}.

lookup(_, {node, nil}) ->
	{node, nil};
lookup(Key, {node, {Key, Value, _, _}}) ->
	{ok, Value};
lookup(Key, {node, {CurrentKey, _, Left, _}}) when Key < CurrentKey ->
	lookup(Key, Left);
lookup(Key, {node, {_, _, _, Right}}) ->
	lookup(Key, Right).