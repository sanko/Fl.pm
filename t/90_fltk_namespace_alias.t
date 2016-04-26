use strict;
use Test::More 0.98;
#
use_ok 'FLTK',         qw[:all];
can_ok 'FLTK',         'run';
can_ok 'main',         'run';
can_ok 'FLTK::Window', 'new';
#
done_testing;
