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
