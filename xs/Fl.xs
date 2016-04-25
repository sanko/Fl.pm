#include "include/Fl_pm.h"

SV * cvrv;

int call ( const char * code, const char * args ) {
    dTHX;
    int retval;
    dSP;
    ENTER;
        SAVETMPS;
            PUSHMARK( sp );
    XPUSHs( sv_2mortal( newSVpv( args, strlen( args ) ) ) );
            PUTBACK;
    retval = call_pv( code, G_SCALAR | G_EVAL );
        FREETMPS;
    LEAVE;
    return retval;
}
int call ( SV * code, const char * args ) {
    dTHX;
    int retval;
    dSP;
    ENTER;
        SAVETMPS;
            PUSHMARK( sp );
    XPUSHs( sv_2mortal( newSVpv( args, strlen( args ) ) ) );
            PUTBACK;
    retval = call_sv( code, G_SCALAR );
        FREETMPS;
    LEAVE;
    return retval;
}

void set_isa(char * klass, char * parent) {
    dTHX;
#ifndef get_av
    AV *isa = perl_get_av(klass, 1);
#else
    AV *isa = get_av(klass, 1);
#endif
    dSP;
    av_push(isa, newSVpv(parent, 0));
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

#include <FL/Fl_Widget.H>

MODULE = Fl::Widget        PACKAGE = Fl::Widget         PREFIX = Fl_

PROTOTYPES: DISABLE

void
Fl_Widget::activate()

unsigned int
Fl_Widget::active()

int
Fl_Widget::active_r()

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
