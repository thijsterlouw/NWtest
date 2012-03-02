.PHONY: deps test
SHELL := /bin/bash	#to make sure we can use BASH shell (for piqi_src)
REBAR := rebar
DEPS := deps
export ERL_LIBS=${PWD}/${DEPS}/

all: deps compile

compile:
	@${REBAR} compile
	@${REBAR} xref | grep -v "is unused export (Xref)"

getdeps:
	${REBAR} get-deps

deps:
	${REBAR} get-deps

clean:
	${REBAR} clean
	rm -f test/ebin/*
	rm -f doc/*.html doc/*.css doc/*.png doc/edoc-info

distclean: clean 
	${REBAR} delete-deps

test: compile 
	${REBAR} skip_deps=true eunit

docs:
	${REBAR} skip_deps=true doc

# While developing with vi, :!make dialyzer | grep '%:t' can be used to run dialyzer in the current file
dialyzer: clean compile
	@dialyzer -Wno_return -Wno_opaque -c ebin 
	
typer: compile
	typer --show-exported -I deps/*/include -I include -pa deps/mochiweb/ebin -r src/
