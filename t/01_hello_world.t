use strict;
use Test::More 0.98;

#use Devel::Leak;
use lib '../blib/', '../blib/lib', '../lib';
$|++;
use_ok $_ for qw(
    Fltk
);
use Data::Dump qw[pp];
diag pp \%Fltk::;
my $window = new_ok 'Fltk::Window' => [100, 200, 340, 180], 'window';
my $box = new_ok 'Fltk::Box' => [20, 40, 300, 100, 'Hello, World!'], 'box';
$box->cheat();

#box->box(FL_UP_BOX);
#box->labelfont(FL_BOLD+FL_ITALIC);
#box->labelsize(36);
$box->labelsize(36);

#box->labeltype(FL_SHADOW_LABEL);
#$box->DESTROY();
undef $box;

#$box = '';
warn $box;
$window->end();
$window->show();
diag pp $window;

#isa_ok FLTK::Airplane->new(), 'FLTK::Airplane';
done_testing;
