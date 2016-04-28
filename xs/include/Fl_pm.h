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
const char * object2package (Fl_Widget * w);

#endif // #ifndef fltk_pm_h
