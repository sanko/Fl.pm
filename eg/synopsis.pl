use strict;
use warnings;
use Fl qw[:execute];
my $window = Fl::Window->new(100, 100, 300, 180);
my $box = Fl::Box->new(20, 40, 260, 100, 'Hello, World');

#$box->labelfont(BOLD + ITALIC); # TODO
$box->labelsize(36);

#$box->labelfont(SHADOW_LABEL); # TODO
$window->end();
$window->show();
exit run();
