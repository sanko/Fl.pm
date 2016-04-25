use strict;
use warnings;
use Test::More 0.98;
use lib '../blib/', '../blib/lib', '../lib';
$|++;
use_ok $_ for qw(
    Fl
);

#
my $window = new_ok 'Fl::Window' => [100, 200, 340, 180], 'window w/o title';
my $window2 = new_ok
    'Fl::Window' => [100, 200, 340, 180, 'title!'],
    'window w/ title';
#
can_ok $window, 'end';
can_ok $window, 'show';

#
done_testing;
