#include "include/Fl_pm.h"

#include <FL/Fl_Box.H>
#include <FL/Fl_Button.H>
#include <FL/Fl_Chart.H>
#include <FL/Fl_Check_Button.H>
#include <FL/Fl_Group.H>
#include <FL/Fl_Light_Button.H>
#include <FL/Fl_Radio_Button.H>
#include <FL/Fl_Radio_Light_Button.H>
#include <FL/Fl_Radio_Round_Button.H>
#include <FL/Fl_Repeat_Button.H>
#include <FL/Fl_Return_Button.H>
#include <FL/Fl_Round_Button.H>
#include <FL/Fl_Toggle_Button.H>
#include <FL/Fl_Widget.H>
#include <FL/Fl_Window.H>
#include <FL/Fl_Input.H>
#include <FL/Fl_Secret_Input.H>

const char * object2package (Fl_Widget * w) {
     /*Remember to add _most_ specific classes first*/
     const char * package = "Fl::Widget";
          if ( dynamic_cast<Fl_Box                  *>(w) ) { package = "Fl::Box";    }
     else if ( dynamic_cast<Fl_Check_Button         *>(w) ) { package = "Fl::CheckButton"; }
     else if ( dynamic_cast<Fl_Radio_Round_Button   *>(w) ) { package = "Fl::RadioRoundButton"; }
     else if ( dynamic_cast<Fl_Round_Button         *>(w) ) { package = "Fl::RoundButton"; }
     else if ( dynamic_cast<Fl_Radio_Light_Button   *>(w) ) { package = "Fl::RadioLightButton"; }
     else if ( dynamic_cast<Fl_Light_Button         *>(w) ) { package = "Fl::LightButton"; }
     else if ( dynamic_cast<Fl_Return_Button        *>(w) ) { package = "Fl::ReturnButton"; }
     else if ( dynamic_cast<Fl_Repeat_Button        *>(w) ) { package = "Fl::RepeatButton"; }
     else if ( dynamic_cast<Fl_Radio_Button         *>(w) ) { package = "Fl::RadioButton"; }
     else if ( dynamic_cast<Fl_Toggle_Button        *>(w) ) { package = "Fl::ToggleButton"; }
     else if ( dynamic_cast<Fl_Button               *>(w) ) { package = "Fl::Button"; }
     else if ( dynamic_cast<Fl_Window               *>(w) ) { package = "Fl::Window"; }
     else if ( dynamic_cast<Fl_Group                *>(w) ) { package = "Fl::Group";  }
     else if ( dynamic_cast<Fl_Chart                *>(w) ) { package = "Fl::Chart";  }

     else if ( dynamic_cast<Fl_Secret_Input         *>(w) ) { package = "Fl::SecretInput";  }
     else if ( dynamic_cast<Fl_Input                *>(w) ) { package = "Fl::Input";  }
     return package;
}
