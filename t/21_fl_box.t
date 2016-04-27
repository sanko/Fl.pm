use strict;
use warnings;
use Test::More 0.98;
use lib '../blib/', '../blib/lib', '../lib';
use Fl qw[:box :label :font];
my $box1 = new_ok
    'Fl::Box' => [20, 40, 300, 100, 'Hello, World!'],
    'box w/ label';
my $box2 = new_ok 'Fl::Box' => [20, 40, 300, 100], 'box2 w/o label';
my $box = new_ok
    'Fl::Box' => [FL_UP_BOX, 20, 40, 300, 100, 'Hello, World!'],
    'box w/ label and box type';
#
can_ok $box, 'labelsize';
can_ok $box, 'labeltype';
can_ok $box, 'labelfont';
#
$box->labelfont(FL_BOLD + FL_ITALIC);
$box->labelsize(36);
$box->labeltype(FL_SHADOW_LABEL);
#
undef $box;
is $box, undef, 'box is now undef';
done_testing;
