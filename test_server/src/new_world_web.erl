-module(new_world_web).
-export([start/0]).

start() ->
    elibs_application:start(new_world_web).

