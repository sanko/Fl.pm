use strict;
use warnings;
use Test::More 0.98;
use lib '../blib/', '../blib/lib', '../lib';
use Fl qw[:enum];

# :font
can_ok 'main', 'FL_BOLD';

# :version
can_ok 'main', 'FL_VERSION';

# :box
can_ok 'main', 'FL_NO_BOX';
can_ok 'main', 'FL_NO_LABEL';

# :chart
can_ok 'main', 'FL_BAR_CHART';

# :color
can_ok 'main', 'FL_BLACK';
can_ok 'main', 'fl_show_colormap';
#
done_testing;
