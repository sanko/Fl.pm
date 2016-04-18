#define FLTK_DEBUG 0

#define PERL_NO_GET_CONTEXT 1
#define NO_XSLOCKS // XSUB.h will otherwise override various things we need
#define NEED_sv_2pv_flags

#define NO_INIT '\0'

#define __INLINE_CPP_STANDARD_HEADERS 1
#define __INLINE_CPP_NAMESPACE_STD 1

extern "C" {
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
}

#include <FL/Fl.H>

// Execution
int run() {
    return Fl::run();
}
double wait( double time = NO_INIT ) {
    return time == NO_INIT ? Fl::wait() : Fl::wait( time );
}
int check() {
    return Fl::check();
}
int ready() {
    return Fl::ready();
}

class Object {
public:
    Object() { }
    ~Object() { }
protected:
    void DESTROY() { }
};

class Widget : public Object {
public:
    Widget() { }
    ~Widget() { }
protected:
    void DESTROY() { }
};

#include <FL/Fl_Window.H>

class fltk_Window : public Widget {
private:
    Fl_Window * _window;
    // CPP2XS
    int items;
public:
    fltk_Window( int x, int y, int w, int h, char * title = NO_INIT ) {
        if ( title[0] == NO_INIT ) {
        _window = new Fl_Window( x, y, w, h );
    }
        else {
            _window = new Fl_Window( x, y, w, h, title );
        }
    }
    ~fltk_Window() {
        delete _window;
    }
protected:
    void DESTROY() {
        //delete _window;
    }

public:
    void end()             {
        _window->end();
    }
    void show()            {
        _window->show();
    }
};

#include <FL/Fl_Box.H>

class Box : public Widget {
private:
    Fl_Box * _box;
    // CPP2XS
    int items;
public:
    Box( int x, int y, int w, int h, const char * label = NO_INIT ) {
        if ( label[0] == NO_INIT ) {
            _box = new Fl_Box( x, y, w, h );
        }
        else {
        _box = new Fl_Box( x, y, w, h, label );
    }
    }
    ~Box() {
        delete _box;
    }
protected:
    void DESTROY() {
        //delete _box;
    }

public:
    void box( Fl_Boxtype type ) {
        _box->box( type );
    }
    void labelfont( int font ) {
        _box->labelfont( font );
    }
    void labelsize( int size ) {
        _box->labelsize( size );
    }
    void labeltype( Fl_Labeltype type ) {
        _box->labeltype( type );
    }
    void cheat() {
        _box->box( FL_UP_BOX );
        _box->labelfont( FL_BOLD + FL_ITALIC );
        _box->labelsize( 36 );
        _box->labeltype( FL_SHADOW_LABEL );
    }
};

MODULE = FLTK        PACKAGE = FLTK::Object

PROTOTYPES: DISABLE

Object *
Object::new()

void
Object::DESTROY()


MODULE = FLTK        PACKAGE = FLTK::Widget

PROTOTYPES: DISABLE

Widget *
Widget::new()

void
Widget::DESTROY()


MODULE = FLTK        PACKAGE = FLTK::Window         PREFIX = fltk_

PROTOTYPES: DISABLE

fltk_Window *
fltk_Window::new(x, y, w, h, ...)
	int	x
	int	y
	int	w
	int	h
    PREINIT:
	char *	title;
    CODE:
switch(items-1) {
case 5:
	title = (char *)SvPV_nolen(ST(5));
	RETVAL = new fltk_Window(x,y,w,h,title);
	break; /* case 5 */
default:
	RETVAL = new fltk_Window(x,y,w,h);
} /* switch(items) */
    OUTPUT:
RETVAL

void
fltk_Window::DESTROY()

void
fltk_Window::end()
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->end();
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
fltk_Window::show()
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->show();
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */


MODULE = FLTK        PACKAGE = FLTK::Box

PROTOTYPES: DISABLE

Box *
Box::new(x, y, w, h, ...)
	int	x
	int	y
	int	w
	int	h
    PREINIT:
	char *	label;
    CODE:
switch(items-1) {
case 5:
	label = (char *)SvPV_nolen(ST(5));
	RETVAL = new Box(x,y,w,h,label);
	break; /* case 5 */
default:
	RETVAL = new Box(x,y,w,h);
} /* switch(items) */
    OUTPUT:
RETVAL

void
Box::DESTROY()

void
Box::labelfont(font)
	int	font
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->labelfont(font);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Box::labelsize(size)
	int	size
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->labelsize(size);
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Box::cheat()
    PREINIT:
	I32 *	__temp_markstack_ptr;
    PPCODE:
	__temp_markstack_ptr = PL_markstack_ptr++;
	THIS->cheat();
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */


MODULE = FLTK        PACKAGE = FLTK

PROTOTYPES: DISABLE

int
run()


double
wait(...)
    PREINIT:
	double	time;
    CODE:
switch(items) {
case 1:
	time = (double)SvNV(ST(0));
	RETVAL = wait(time);
	break; /* case 1 */
default:
	RETVAL = wait();
} /* switch(items) */
    OUTPUT:
RETVAL

int
check()

int
ready()

BOOT:
{
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

