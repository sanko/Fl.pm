#include "include/Fl_pm.h"

#include <FL/Fl_Widget.H>
#include <FL/Fl_Group.H>
#include <FL/Fl_Box.H>
#include <FL/Fl_Window.H>

const char * object2package (Fl_Widget * w) {
    /*Remember to add _most_ specific classes first*/
    const char * package = "Fl::Widget";
         if ( dynamic_cast<Fl_Box    *>(w) ) { package = "Fl::Box";    }
    else if ( dynamic_cast<Fl_Window *>(w) ) { package = "Fl::Window"; }
    else if ( dynamic_cast<Fl_Group  *>(w) ) { package = "Fl::Group";  }
    return package;
}
