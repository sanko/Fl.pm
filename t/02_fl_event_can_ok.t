use strict;
use warnings;
use Test::More 0.98;
use lib '../blib/', '../blib/lib', '../lib';
use Fl qw[:event];

#
can_ok 'Fl', 'wait';
can_ok 'Fl', 'run';
can_ok 'Fl', 'check';
can_ok 'Fl', 'ready';

# Check :event import tag
can_ok 'main', 'wait';
can_ok 'main', 'run';
can_ok 'main', 'check';
can_ok 'main', 'ready';

#
done_testing;
