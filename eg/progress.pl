use strict;
use warnings;
use Fl;
use Time::HiRes qw[usleep];

sub butt_cb {
    my ($butt, $w) = @_;
    $butt->deactivate();    # prevent button from being pressed again
    Fl::check();            # give fltk some cpu to gray out button
                            # Make the progress bar
    $w->begin();            # add progress bar to it..
    my $progress = Fl::Progress->new(10, 50, 200, 30);
    $progress->minimum(0);           # set progress range to be 0.0 ~ 1.0
    $progress->maximum(1);
    $progress->color(0x88888800);    # background color
    $progress->selection_color(0x4444ff00);    # progress bar color
    $progress->labelcolor(Fl::FL_WHITE);       # percent text color
    $w->end();                                 # end adding to window

    for (my $t = 1; $t <= 500; $t++) {
        $progress->value($t / 500.0)
            ;    # update progress bar with 0.0 ~ 1.0 value
        $progress->label(sprintf("%d%%", int(($t / 500.0) * 100.0)))
            ;            # update progress bar's label
        Fl::check();     # give fltk some cpu to update the screen
        usleep(1000);    # 'your stuff' that's compute intensive
    }
    $progress = undef;    # deallocate progress bar
    $butt->activate();    # reactivate button
    $w->redraw();         # tell window to redraw now that progress removed
}

# Main
my $win = Fl::Window->new(220, 90);
my $butt = Fl::Button->new(10, 10, 100, 25, "Press");
$butt->callback(\&butt_cb, $win);
$win->resizable($win);
$win->show();
exit Fl::run();
