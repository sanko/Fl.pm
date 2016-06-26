
=cut

use Alien::FLTK;
use ExtUtils::CBuilder;
my $AF  = Alien::FLTK->new();
my $CC  = ExtUtils::CBuilder->new();
my $SRC = 'hello_world.cxx';
open(my $FH, '>', $SRC) || die '...';
syswrite($FH, <<'') || die '...'; close $FH;
#include <stdio.h>
#include <FL/Fl.H>
#include <FL/Fl_Window.H>
#include <FL/Fl_Box.H>
//
// Demo of Drag+Drop (DND) from red sender to green receiver
//
// SENDER CLASS
class Sender : public Fl_Box {
public:
    // Sender Ctor
    Sender(int x,int y,int w,int h) : Fl_Box(x,y,w,h) {
        box(FL_FLAT_BOX); color(9); label("Drag from here");
    }
    // Sender event handler
    int handle(int event) {
        int ret = Fl_Box::handle(event);
        fprintf(stderr, "Event A: %d\n", event);
        switch ( event ) {
            case FL_PUSH:               // do 'copy/dnd' when someone clicks on box
                Fl::copy("message",7,0);
                Fl::dnd();
                ret = 1;
                break;
        }
        return(ret);
    }
};
// RECEIVER CLASS
class Receiver : public Fl_Box {
public:
    // Receiver Ctor
    Receiver(int x,int y,int w,int h) : Fl_Box(x,y,w,h) {
        box(FL_FLAT_BOX); color(10); label("to here");
    }
    // Receiver event handler
    int handle(int event) {
        fprintf(stderr, "Event B: %d\n", event);
        int ret = Fl_Box::handle(event);
        switch ( event ) {
            case FL_DND_ENTER:          // return(1) for these events to 'accept' dnd
            case FL_DND_DRAG:
            case FL_DND_RELEASE:
                ret = 1;
                break;
            case FL_PASTE:              // handle actual drop (paste) operation
                label(Fl::event_text());
                fprintf(stderr, "PASTE: %s\n", Fl::event_text());
                ret = 1;
                break;
        }
        return(ret);
    }
};
int main(int argc, char **argv) {
    // Create sender window and widget
    Fl_Window win_a(0,0,200,100,"Sender");
    Sender a(0,0,100,100);
    win_a.end();
    win_a.show();
    // Create receiver window and widget
    Fl_Window win_b(400,0,200,100,"Receiver");
    Receiver b(100,0,100,100);
    win_b.end();
    win_b.show();
    return(Fl::run());
}

my $OBJ = $CC->compile('C++'                => 1,
                       source               => $SRC,
                       include_dirs         => [$AF->include_dirs()],
                       extra_compiler_flags => $AF->cxxflags()
);
my $EXE =
     $CC->link_executable(
      objects            => $OBJ,
      extra_linker_flags => '-L' . $AF->library_path . ' ' . $AF->ldflags()
     );
 print system('./' . $EXE) ? 'Aww...' : 'Yay!';
 END { unlink grep defined, $SRC, $OBJ, $EXE; }




#__END__

=pod

=cut

use strict;
use warnings;
use Fl qw[:color :default :event];
$|++;

#use Fl qw[:all]; # I'm lazy
# Demo of Drag+Drop (DND) from red sender to green receiver
{

    package Sender;
    use SUPER;
    use Fl qw[:color :default :event :box];
    extends 'Fl::Box';

    sub new {
        my $s = super;
        $s->box(FL_FLAT_BOX);
        $s->color(9);
        $s->label("Drag\nfrom\nhere...");
        return $s;
    }

    # Sender event handler
    sub handle {
        my ($s, $event) = @_;
        printf STDERR "Event a: %d\n", $event;
        if ($event == FL_PUSH) {

            # do 'copy/dnd' when someone clicks on box
            Fl::copy("message", 0);
            Fl::dnd();
            return 1;
        }
    }
}
{

    package Receiver;
    use SUPER;
    use Fl qw[:color :default :event :box];
    extends 'Fl::Box';

    sub new {
        my $s = super;
        $s->box(FL_FLAT_BOX);
        $s->color(10);
        $s->label("...to\nhere");
        return $s;
    }

    # Receiver event handler
    sub handle {
        my ($s, $event) = @_;
        printf STDERR "Event b: %d\n", $event;
        return 1
            if $event == FL_DND_ENTER
            || $event == FL_DND_DRAG
            || $event == FL_DND_LEAVE
            || $event == FL_DND_RELEASE;
        if ($event == FL_PASTE) {
            printf("dropped:'%s'\n", Fl::event_text());
            return 1;
        }
        return super;
    }
};

# Create sender window and widget
my $win_a = Fl::Window->new(0, 0, 200, 100, "Sender");
my $_a = Sender->new(0, 0, 100, 100);
$win_a->end();
$win_a->show();

#Create receiver window and widget
my $win_b = Fl::Window->new(400, 0, 200, 100, "Receiver");
my $_b = Receiver->new(100, 0, 100, 100);
$win_b->end();
$win_b->show();
exit Fl::run()
__END__
use strict;
use warnings;
use Data::Dump;
#
{

    package Fl::DoubleClickButton;
    use Fl qw[:color :default :event];
    #
    extends 'Fl::LightButton';
    use SUPER;
    use Data::Dump;

    sub handle {
        my ($s, $event) = @_;
        CORE::state $click = 0;
        if ($event != FL_RELEASE) {
            return 1 if FL_PUSH;
            return 0;
        }
        return $s->value(!!!$s->value) if (time == $click);
        warn "Event: $event";
        $click = time;
        return 0;
    }

    1;
}
$|++;
use Fl qw[:event :label :box :font];
my $window = Fl::Window->new(100, 100, 300, 180);
my $box = Fl::DoubleClickButton->new(20, 40, 260, 100, 'Hello, World');
$box->labelfont(FL_BOLD + FL_ITALIC);
$box->labelsize(36);
$box->labeltype(FL_SHADOW_LABEL);
$window->end();
$window->show();
exit run();
__END__
#
use Readonly;
#
{
    my $ref = [200];
    ddx $ref;
    Readonly::Scalar my $scalar => [5, ['string'], \$ref];
    ddx $ref;
    my $scalar_clone = Readonly::Clone $scalar;
    $ref->[0]++;
    $scalar_clone->[1][1] = 'blah';
    ddx $scalar;
    ddx $scalar_clone;
}
