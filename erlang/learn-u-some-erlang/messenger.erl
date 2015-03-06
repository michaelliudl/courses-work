%%%-------------------------------------------------------------------
%%% @author doliu
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. Aug 2014 17:41
%%%-------------------------------------------------------------------

%%% Message passing utility
%%% User interface:
%%% logon(Name)
%%%     One user at a time can log in from each Erlang node in the system message: and choose a suitable Name.
%%%     If the Name is already logged in at another node or if someone else is already logged in at atnother node
%%%     or if someone else is already logged in at the same node, login will be rejected with a suitable error messsage.
%%% logoff()
%%%     Logs off anybody at a node
%%% message(ToName, Message)
%%%     Sends Message to ToName. Error messages if the user of this function is not logged on
%%%     or if ToName is not logged on at any node.
%%%
%%% One node in the network of Erlang nodes runs a server which maintains data about the logged on users.
%%% The server is registered as "messenger". Each node where there is a user logged on runs a client process
%%% registered as "mess_client".
%%%
%%% Protocol between the client processes and the server
%%% -------------------------------------------------------
%%% To server: {ClientPid, logon, UserName}
%%% Reply {messenger, stop, user_exists_at_other_node} stops the client
%%% Reply {messenger, logged_on} logon was successful
%%%
%%% To server: {ClientPid, logoff}
%%% Reply: {messenger, logged_off}
%%% Reply: no reply
%%%
%%% To server: {ClientPid, message_to, ToName, Message} send a message
%%% Reply: {messenger, stop, you_are_not_logged_on} stops the client
%%% Reply: {messenger, receiver_not_found} no user with this name logged on
%%% Reply: {messenger, sent} Message has been sent (but no guarantee)
%%%
%%% To client: {message_from, Name, Message}
%%%
%%% Protocol between the "commands" and the client
%%% -------------------------------------------------------
%%%
%%% Started: messenger:client(Server_Node, Name}
%%% To client: logoff
%%% To client: {message_to, ToName, Message}
%%%
%%% Configuration: change the server_node() function to return the name of the node where the messenger server runs

-module(messenger).
-author("doliu").

%% API
-export([start_server/0, server/1, logon/1, logoff/0, message/2, client/2]).

server_node() ->
	messenger@mike.

%%% This is the server process for the "messenger"
%%% The user list has the format [{ClientPid1, Name1}, {ClientPid2, Name2}, ...]
server(UserList) ->
	receive
		{From, logon, Name} ->
			NewUserList = server_logon(From, Name, UserList),
			server(NewUserList);
		{From, logoff} ->
			NewUserList = server_logoff(From, UserList),
			server(NewUserList);
		{From, message_to, To, Message} ->
			server_transfer(From, To, Message, UserList),
			io:format("List is now: ~p.~n", [UserList]),
			server(UserList)
	end.

start_server() ->
	register(messenger, spawn(messenger, server, [[]])).

%%% Server adds a new user to the user list
server_logon(From, Name,UserList) ->
	%% check if logged on anywhere else
	case lists:keymember(Name, 2, UserList) of
		true ->
			From ! {messenger, stop, user_exists_at_other_node},
			UserList;
		false ->
			From ! {messenger, logged_on},
			[{From, Name} | UserList]
	end.

%%% Server deletes a user from the user list
server_logoff(From, UserList) ->
	lists:keydelete(From, 1, UserList).

%%% Server transfers a message between user
server_transfer(From, To, Message, UserList) ->
	%% check that the user is logged on and who he is
	case lists:keysearch(From, 1, UserList) of
		false ->
			From ! {messenger, stop, you_are_not_logged_on};
		{value, {From, Name}} ->
			server_transfer(From, Name, To, Message, UserList)
	end.

%%% If the user exists, send the message
server_transfer(From, Name, To, Message, UserList) ->
	%% Find the receiver and send the message
	case lists:keysearch(To, 2, UserList) of
		false ->
			From ! {messenger, receiver_not_found};
		{value, {ToPid, To}} ->
			ToPid ! {message_from, Name, Message},
			From ! {messenger, sent}
	end.

%%% User commands
logon(Name) ->
	case whereis(mess_client) of
		undefined ->
			register(mess_client, spawn(messenger, client, [server_node(), Name]));
		_ -> already_logged_on
	end.

logoff() ->
	mess_client ! logoff.

message(ToName, Message) ->
	case whereis(mess_client) of % Test if the client is running
		undefined ->
			not_logged_on;
		_ -> mess_client ! {message_to, ToName, Message},
			ok
	end.

%%% The client process which runs on each server node
client(ServerNode, Name) ->
	{messenger, ServerNode} ! {self(), logon, Name},
	await_result(),
	client(ServerNode).

client(ServerNode) ->
	receive
		logoff ->
			{messenger, ServerNode} ! {self(), logoff},
			exit(normal);
		{message_to, ToName, Message} ->
			{messenger, ServerNode} ! {self(), message_to, ToName, Message},
			await_result();
		{message_from, FromName, Message} ->
			io:format("Message from ~p: ~p~n", [FromName, Message])
	end,
	client(ServerNode).

%%% wait for a response from the server
await_result() ->
	receive
		{messenger, stop, Why} -> % stop the client
			io:format("~p~n", [Why]),
			exit(normal);
		{messenger, What} -> % normal response
			io:format("~p~n", [What])
	end.
