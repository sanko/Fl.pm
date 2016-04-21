#include "include/FLTK_pm.h"

#include <FL/Fl.H>

MODULE = FLTK        PACKAGE = FLTK

PROTOTYPES: DISABLE

int
ok( )
    CODE:
        RETVAL = 1;
    OUTPUT:
        RETVAL
