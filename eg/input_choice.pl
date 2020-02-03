use strict;
use warnings;
use Fl;
use experimental 'signatures';

sub buttcb ($btn, $in) {
    CORE::state $flag = 1;
    $flag ^= 1;
    $flag ? $in->activate() : $in->deactivate();
}
my $win = Fl::Window->new(300, 200);
my $in  = Fl::InputChoice->new(40, 40, 100, 28, "Test");
$in->add("one");
$in->add("two");
$in->add("three");
$in->value(0);
my $onoff = Fl::Button->new(40, 150, 200, 28, "Activate/Deactivate");
$onoff->callback(\&buttcb, $in);
$win->end();
$win->resizable($win);
$win->show();
exit Fl::run();
