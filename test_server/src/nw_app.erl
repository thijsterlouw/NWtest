-module(nw_app).

-behaviour(application).

%% API
-export([start/0, stop/0]).

%% Application callbacks
-export([start/2, stop/1]).

%%--------------------------------------------------------------------
%% API
%%--------------------------------------------------------------------

%%--------------------------------------------------------------------
%% @doc Starts the application
%% @end
%%--------------------------------------------------------------------
start() ->
    application:start(new_world_web).

%%--------------------------------------------------------------------
%% @doc Stops the application
%% @end
%%--------------------------------------------------------------------
stop() ->
    application:stop(new_world_web).


%% ===================================================================
%% Application callbacks
%% ===================================================================

%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for widget_provider.
start(_Type, _StartArgs) ->
    nw_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for widget_provider.
stop(_State) ->
    ok.
