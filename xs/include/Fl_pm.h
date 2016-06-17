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
struct CTX {
    int           algorithm;
    Fl_Widget   * cp_ctx;
    const char  * cp_cls;
};
const char * object2package ( CTX * w );

class Callback {
public: /* TODO: Make these private */
    SV * callback;
    SV * args;

public:
    ~Callback() { };
    Callback( SV * cb, SV * as ) {
        dTHX;
        callback = newSVsv( cb );//sv_mortalcopy(cb);
        args     = as;//newSVsv(as);//sv_mortalcopy(as);
    };

    void trigger( Fl_Widget * w ) {
        dTHX;
        SV * widget;
        CTX * ctx;
        Newx( ctx, 1, CTX );
        ctx->cp_ctx    = w;
        {
            SV * RETVALSV;
            RETVALSV = sv_newmortal();
            sv_setref_pv( RETVALSV, object2package( ctx->cp_ctx ), ( void* )ctx );
            widget = RETVALSV;
        }

        dSP;
        ENTER;
        SAVETMPS;
        PUSHMARK( SP );

        if ( SvOK( widget ) )
            XPUSHs( widget );

        PUTBACK;

        call_sv( callback, G_DISCARD | G_EVAL );

        SPAGAIN;

        PUTBACK;
        FREETMPS;
        LEAVE;

        return;
    };
};

template<typename T>
class WidgetSubclass : public T {

private:
    int algorithm;
    const char * _class = NULL;
public:
    WidgetSubclass( const char * cls, int x, int y, int w, int h, const char * lbl ) : T( x, y, w, h, lbl ) {
        // Just about everything
        dTHX;
        _class = cls;
     };
    WidgetSubclass( const char * cls, Fl_Boxtype type, int x, int y, int w, int h, const char * lbl ) : T( type, x, y, w, h, lbl ) {
        // Fl_Box
        dTHX;
        _class = cls;
     };
    WidgetSubclass( const char * cls, int w, int h, const char * lbl ) : T( w, h, lbl ) {
        // Fl_Window
        dTHX;
        _class = cls;
     };

    ~WidgetSubclass( ) {
        dTHX;
        warn("destroy!");
        this->T::~T( );
    }

private:
    void draw(bool only) {
        this->T::draw();
    };
    void draw() {
        dTHX;
        //printf("package = %s\n", SvPV_nolen(get_sv("package", 0)));
        warn( "draw()\n" );
        this->T::draw();

        SV * widget;
        CTX * ctx;
        Newx( ctx, 1, CTX );
        ctx->cp_ctx    = this;
        ctx->cp_cls    = _class;

        {
            SV * RETVALSV;
            RETVALSV = sv_newmortal();
            sv_setref_pv( RETVALSV, object2package( ctx ), ( void* )ctx );
            widget = RETVALSV;
        }

        dSP;

        ENTER;
        SAVETMPS;
        PUSHMARK( SP );

        XPUSHs( widget );

        PUTBACK;

        call_method( "draw", G_DISCARD | G_EVAL );

        SPAGAIN;

        PUTBACK;
        FREETMPS;
        LEAVE;
    };
};

#endif // #ifndef fltk_pm_h
