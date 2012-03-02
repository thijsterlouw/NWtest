-module(nw_sup).

-behaviour(supervisor).

%% External exports
-export([start_link/0, upgrade/0]).

%% supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
%-define(CHILD(I, Type, StartOpts), {I, {I, start_link, StartOpts}, permanent, 5000, Type, [I]}).

%%--------------------------------------------------------------------
%% API
%%--------------------------------------------------------------------

%% @spec start_link() -> ServerRet
%% @doc API for starting the supervisor.
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% @spec upgrade() -> ok
%% @doc Add processes if necessary.
upgrade() ->
    {ok, {_, Specs}} = init([]),

    Old = sets:from_list(
            [Name || {Name, _, _, _} <- supervisor:which_children(?MODULE)]),
    New = sets:from_list([Name || {Name, _, _, _, _, _} <- Specs]),
    Kill = sets:subtract(Old, New),

    sets:fold(fun (Id, ok) ->
                      supervisor:terminate_child(?MODULE, Id),
                      supervisor:delete_child(?MODULE, Id),
                      ok
              end, ok, Kill),

    [supervisor:start_child(?MODULE, Spec) || Spec <- Specs],
    ok.

%%--------------------------------------------------------------------
%% Supervisor callbacks
%%--------------------------------------------------------------------

%% @spec init([]) -> SupervisorTree
%% @doc supervisor callback.
init([]) ->
    Web = web_specs(nw_web, 8080),
    Processes = [Web],
    Strategy = {one_for_one, 10, 10},
    %io:format("Init Web: ~p~n", [Web]),
    {ok, {Strategy, lists:flatten(Processes)}}.


%%--------------------------------------------------------------------
%% Internal fnunctions
%%--------------------------------------------------------------------

web_specs(Mod, Port) ->
    WebConfig = [
                    {ip, {127,0,0,1}},
                    {port, Port}
                ], 
    {Mod, {Mod, start, [WebConfig]}, permanent, 5000, worker, dynamic}.
