use strict;
use Test::More 0.98;

use_ok $_ for qw(
    FLTK
);
can_ok 'FLTK', 'run';
can_ok 'FLTK::Window', 'new';
#
done_testing;
