#include "include/FLTK_pm.h"

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
