#include "include/FLTK_pm.h"

#include <FL/Fl_Box.H>

MODULE = FLTK        PACKAGE = FLTK::Box            PREFIX = Fl_

PROTOTYPES: DISABLE

Fl_Box *
Fl_Box::new(int x, int y, int w, int h, char * label = "" )

void
Fl_Box::DESTROY()

void
Fl_Box::labelfont(int font)

void
Fl_Box::labelsize(int size)
