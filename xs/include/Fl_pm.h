#ifndef fltk_pm_h
#define fltk_pm_h

#define FLTK_DEBUG 0

#define PERL_NO_GET_CONTEXT 1

#include <EXTERN.h>
#include <perl.h>
#define NO_XSLOCKS // XSUB.h will otherwise override various things we need
#include <XSUB.h>
#define NEED_sv_2pv_flags
#include "ppport.h"

#define NO_XSLOCKS // XSUB.h will otherwise override various things we need
//#define NEED_sv_2pv_flags
#define NEED_newSVpvn_flags
#define NO_INIT '\0'

#ifdef WIN32
#include <windows.h>
HINSTANCE dllInstance( );
#endif // #ifdef WIN32

#include <FL/Fl_Widget.H>
const char * object2package ( Fl_Widget * w );

// Widget wrapper!
typedef struct {
    int           algorithm;
    Fl_Widget   * cp_ctx;
} CTX;

typedef CTX* Fl__Widget;
typedef CTX* Fl__Box;
typedef CTX* Fl__Group;
typedef CTX* Fl__Input;
typedef CTX* Fl__Window;
typedef CTX* Fl__Button;
typedef CTX* Fl__Chart;
typedef CTX* Fl__CheckButton;
typedef CTX* Fl__ReturnButton;
typedef CTX* Fl__RepeatButton;
typedef CTX* Fl__RadioButton;
typedef CTX* Fl__IntInput;
typedef CTX* Fl__FloatInput;
typedef CTX* Fl__LightButton;
typedef CTX* Fl__MultilineInput;
typedef CTX* Fl__RadioLightButton;
typedef CTX* Fl__RadioRoundButton;
typedef CTX* Fl__RoundButton;
typedef CTX* Fl__SecretInput;
typedef CTX* Fl__ToggleButton;
typedef CTX* Fl__Valuator;
typedef CTX* Fl__Adjuster;
typedef CTX* Fl__Counter;
typedef CTX* Fl__SimpleCounter;
typedef CTX* Fl__Dial;
typedef CTX* Fl__FillDial;
typedef CTX* Fl__LineDial;
typedef CTX* Fl__Roller;
typedef CTX* Fl__ValueOutput;
typedef CTX* Fl__ValueInput;
typedef CTX* Fl__Slider;
typedef CTX* Fl__FillSlider;
typedef CTX* Fl__HorFillSlider;
typedef CTX* Fl__NiceSlider;
typedef CTX* Fl__HorNiceSlider;
typedef CTX* Fl__HorSlider;
typedef CTX* Fl__Scrollbar;
typedef CTX* Fl__ValueSlider;



#endif // #ifndef fltk_pm_h
