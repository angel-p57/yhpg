#!/bin/sh

cat "$@" | sed -e 's/^..\([0-9]*\).. *test( */test( \1, /;s/; *$//' | cat ../common/tmpl.rb -
