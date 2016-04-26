#include "include/Fl_pm.h"

HV * Fl_stash,  // For inserting stuff directly into Fl's namespace
   * Fl_export; // For inserting stuff directly into Fl's exports

void register_constant( char * name, SV * value ) {
    dTHX;
    newCONSTSUB( Fl_stash, name, value );
}

void register_constant( char * package, const char * name, SV * value ) {
    dTHX;
    HV * _stash  = gv_stashpv( package, TRUE );
    newCONSTSUB( _stash, name, value );
}

void export_tag (const char * what, const char * _tag ) {
    dTHX;
    //warn("Exporting %s to %s", what, _tag);
    SV ** tag = hv_fetch( Fl_export, _tag, strlen(_tag), TRUE );
    if (tag && SvOK(* tag) && SvROK(* tag ) && (SvTYPE(SvRV(*tag))) == SVt_PVAV)
        av_push((AV*)SvRV(*tag), newSVpv(what, 0));
    else {
        SV * av;
        av = (SV*) newAV( );
        av_push((AV*)av, newSVpv(what, 0));
        tag = hv_store( Fl_export, _tag, strlen(_tag), newRV_noinc(av), 0 );
    }
}

void set_isa(const char * klass, const char * parent) {
    dTHX;
    HV * parent_stash = gv_stashpv( parent, GV_ADD | GV_ADDMULTI );
    av_push( get_av( form( "%s::ISA", klass ), TRUE ),
             newSVpv( parent, 0 ) );
    // TODO: make this spider up the list and make deeper connections?
}

#include <FL/Fl.H>

// Execution
double wait( double time = NO_INIT ) {
    return time == NO_INIT ? Fl::wait() : Fl::wait( time );
}

MODULE = Fl        PACKAGE = Fl                 PREFIX = Fl::

PROTOTYPES: DISABLE

double
wait(double time = NO_INIT)

int
execute()
    INTERFACE:
        Fl::run    Fl::check
        Fl::ready

BOOT:
    Fl_stash  = gv_stashpv( "Fl", TRUE );
    Fl_export = get_hv( "Fl::EXPORT_TAGS", TRUE );

    export_tag("wait", "execute");
    export_tag("check", "execute");
    export_tag("ready", "execute");
    export_tag("run", "execute");

#include <FL/Fl_Widget.H>

MODULE = Fl::Widget        PACKAGE = Fl::Widget         PREFIX = Fl_

PROTOTYPES: DISABLE

=pod

No Fl::Widget->new(...) constructor

=cut

void
Fl_Widget::DESTROY()

void
Fl_Widget::set_active()

void
Fl_Widget::set_changed()

void
Fl_Widget::set_output()

void
Fl_Widget::set_visible()

void
Fl_Widget::set_visible_focus()

void
Fl_Widget::redraw_label()

void
Fl_Widget::redraw()

unsigned int
Fl_Widget::active()

unsigned int
Fl_Widget::output()

int
Fl_Widget::active_r()

int
Fl_Widget::visible_r()

int
Fl_Widget::x()

int
Fl_Widget::y()

int
Fl_Widget::w()

int
Fl_Widget::h()

int
Fl_Widget::use_accents_menu()

int
Fl_Widget::test_shortcut()

int
Fl_Widget::take_focus()

#include <FL/Fl_Window.H>

MODULE = Fl::Window        PACKAGE = Fl::Window         PREFIX = Fl_

PROTOTYPES: DISABLE

Fl_Window *
Fl_Window::new(int x, int y, int w, int h, const char * title = "")

void
Fl_Window::DESTROY()

void
Fl_Window::show()

void
Fl_Window::end()

#include <FL/Fl_Box.H>

MODULE = Fl::Box        PACKAGE = Fl::Box            PREFIX = Fl_

PROTOTYPES: DISABLE

Fl_Box *
Fl_Box::new(int x, int y, int w, int h, const char * label = "" )

void
Fl_Box::DESTROY()

void
Fl_Box::labelfont(int font)

void
Fl_Box::labelsize(int size)


MODULE = Fl        PACKAGE = Fl

BOOT:
    set_isa("Fl::Box", "Fl::Widget");
