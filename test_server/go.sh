#!/bin/sh
# NOTE: mustache templates need \ because they are not awesome.
exec erl -pa ebin -pa deps/*/ebin -config conf/new_world_web -setcookie spapi -s elibs_reloader -s new_world_web -name 'new_world_web'
