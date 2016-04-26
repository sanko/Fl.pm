use strict;
use warnings;
use Test::More 0.98;
use lib '../blib/', '../blib/lib', '../lib';
use Fl;
my $box = new_ok 'Fl::Box' => [20, 40, 300, 100, 'Hello, World!'], 'box w/ label';
my $box2 = new_ok 'Fl::Box' => [20, 40, 300, 100], 'box2 w/o label';

can_ok $box, 'labelsize';
#$box->cheat();
#box->box(FL_UP_BOX);
#box->labelfont(FL_BOLD+FL_ITALIC);
#$box->labelsize(36);
#box->labeltype(FL_SHADOW_LABEL);
undef $box;

is $box, undef, 'box is now undef';
done_testing;
