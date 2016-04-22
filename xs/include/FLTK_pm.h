#ifndef fltk_pm_h
#define fltk_pm_h

#define FLTK_DEBUG 0

#define PERL_NO_GET_CONTEXT 1
#define NO_XSLOCKS // XSUB.h will otherwise override various things we need
//#define NEED_sv_2pv_flags
#define NEED_newSVpvn_flags
#define NO_INIT '\0'

extern "C" {
#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>


#ifdef __cplusplus
extern "C"
#endif
void non_mangled_function()
{
	// I do nothing
}


    void find_me() {
        int i = 3;
        i--;
    }





} /* extern "C" */

#include "ppport.h"

#ifdef WIN32
#include <windows.h>
HINSTANCE dllInstance( );
#endif // #ifdef WIN32

#endif // #ifndef fltk_pm_h
