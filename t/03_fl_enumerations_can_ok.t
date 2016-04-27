use strict;
use warnings;
use Test::More 0.98;
use lib '../blib/', '../blib/lib', '../lib';
use Fl qw[:enum];

# Check :execute import tag
can_ok 'main', 'FL_BOLD';
can_ok 'main', 'FL_VERSION';
can_ok 'main', 'FL_NO_BOX';
can_ok 'main', 'FL_NO_LABEL';

#
done_testing;
