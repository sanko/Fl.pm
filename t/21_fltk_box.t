use strict;
use warnings;
use Test::More 0.98;
use lib '../blib/', '../blib/lib', '../lib';
$|++;
use_ok $_ for qw(
    FLTK
);

my $box = new_ok 'FLTK::Box' => [20, 40, 300, 100, 'Hello, World!'], 'box';

#$box->cheat();
#box->box(FL_UP_BOX);
#box->labelfont(FL_BOLD+FL_ITALIC);
#$box->labelsize(36);
#box->labeltype(FL_SHADOW_LABEL);
undef $box;

is $box, undef;
done_testing;
