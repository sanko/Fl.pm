use strict;
use warnings;
use Test::More 0.98;
use lib '../blib/', '../blib/lib', '../lib';
$|++;
use_ok $_ for qw(
    FLTK
);

# Execute
can_ok 'Fl', 'wait';
can_ok 'Fl', 'run';
can_ok 'Fl', 'check';
can_ok 'Fl', 'ready';

#
done_testing;
