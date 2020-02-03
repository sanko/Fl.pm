use strict;
use warnings;
use Fl qw[:event :label :box :font];
$|++;
my $window = Fl::Window->new(100, 100, 300, 180);
my $box    = Fl::Box->new(FL_UP_BOX, 20, 40, 260, 100, 'Hello, World');
$box->labelfont(FL_BOLD + FL_ITALIC);
$box->labelsize(36);
$box->labeltype(FL_SHADOW_LABEL);
$window->end();
$window->show();
open(my $fh, ">", "output.txt") or die "Can't open > output.txt: $!";
use Data::Dump;
ddx $fh;
warn fileno $fh;
ddx Fl::add_fd(
    $fh, 3,
    sub {
        warn 'HERE!';
        use Data::Dump;
        ddx \@_;
        warn fileno $fh;
    }
);
ddx $fh;
warn fileno $fh;
exit run();
