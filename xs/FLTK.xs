#include "include/FLTK_pm.h"

#include <FL/Fl.H>

// Execution
int run() { return Fl::run(); }
double wait( double time = NO_INIT ) {
    return time == NO_INIT ? Fl::wait() : Fl::wait( time );
}
int check() {
    return Fl::check();
}
int ready() {
    return Fl::ready();
}

#include <FL/Fl_Window.H>

MODULE = FLTK        PACKAGE = FLTK::Window         PREFIX = Fl_

PROTOTYPES: DISABLE

Fl_Window *
Fl_Window::new(int x, int y, int w, int h, char *title = "")

void
Fl_Window::DESTROY()

void
Fl_Window::end()

void
Fl_Window::show()

MODULE = FLTK        PACKAGE = FLTK::Box            PREFIX = Fl_

PROTOTYPES: DISABLE

#include <FL/Fl_Box.H>

Fl_Box *
Fl_Box::new(int x, int y, int w, int h, char * label = "" )

void
Fl_Box::DESTROY()

void
Fl_Box::labelfont(int font)

void
Fl_Box::labelsize(int size)

MODULE = FLTK        PACKAGE = FLTK                 PREFIX = Fl::

PROTOTYPES: DISABLE

int
run()

double
wait(double time = NO_INIT)

int
check()

int
ready()

BOOT:
/*{
#ifndef get_av
    AV *isa = perl_get_av("FLTK::Widget::ISA", 1);
#else
    AV *isa = get_av("FLTK::Widget::ISA", 1);
#endif
    av_push(isa, newSVpv("FLTK::Object", 0));
}
{
#ifndef get_av
    AV *isa = perl_get_av("FLTK::Window::ISA", 1);
#else
    AV *isa = get_av("FLTK::Window::ISA", 1);
#endif
    av_push(isa, newSVpv("FLTK::Widget", 0));
}
{
#ifndef get_av
    AV *isa = perl_get_av("FLTK::Box::ISA", 1);
#else
    AV *isa = get_av("FLTK::Box::ISA", 1);
#endif
    av_push(isa, newSVpv("FLTK::Widget", 0));
}
*/
