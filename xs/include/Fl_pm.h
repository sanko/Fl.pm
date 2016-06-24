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

template<typename T>
class WidgetSubclass : public T {

private:
    int algorithm;
public:
    const char * _class;
public:
    WidgetSubclass( const char * cls, int x, int y, int w, int h, const char * lbl ) : T( x, y, w, h, lbl ) {
        // Just about everything
        dTHX;
        this->_class = cls;
    };
    WidgetSubclass( const char * cls, Fl_Boxtype type, int x, int y, int w, int h, const char * lbl ) : T( type, x, y, w, h, lbl ) {
        // Fl_Box
        dTHX;
        this->_class = cls;
    };
    WidgetSubclass( const char * cls, int w, int h, const char * lbl ) : T( w, h, lbl ) {
        // Fl_Window
        dTHX;
        this->_class = cls;
    };

    ~WidgetSubclass( ) {
        dTHX;
        //warn( "%s->destroy( )", object2package( this ) );
        this->T::~T( );
    }

    void draw( bool only ) {
        dTHX;
        this->T::draw();
        //warn( "%s->draw( TRUE )", object2package( this ) );
    };
    int handle( bool only, int event ) {
        return 0;
    };
private:

    void draw() {
        dTHX;
        dSP;

        //printf("package = %s\n", SvPV_nolen(get_sv("package", 0)));
        //this->T::draw();


        SV  * err_tmp;
        SV  * widget;
        CTX * ctx;
        int   count;

        Newx( ctx, 1, CTX );
        ctx->cp_ctx    = this;
        ctx->cp_cls    = this->_class;

        //warn( "%s->draw( ) | %s | %s", object2package( ctx ), this->_class, object2package( this ) );

        {
            SV * RETVALSV;
            RETVALSV = sv_newmortal();
            sv_setref_pv( RETVALSV, object2package( ctx ), ( void* )ctx );
            widget = RETVALSV;
        }

        ENTER;
        SAVETMPS;

        PUSHMARK( SP );
        XPUSHs( widget );
        PUTBACK;

        count = call_method( "draw", G_EVAL | G_SCALAR /*| G_KEEPERR*/ );

        SPAGAIN;
        /*
              err_tmp = ERRSV;

                     warn( "okay?" );
                     if (SvTRUE(err_tmp)) {
                         POPi;
                         croak("%s error: %s", object2package(ctx), SvPV_nolen(err_tmp));
                         this->T::draw();
                     }
                     warn( "okay!" );

                     PUTBACK;
                     FREETMPS;
                     LEAVE;
                 */

    };

    int handle( int e ) {
        dTHX;
        dSP;

        SV  * err_tmp;
        SV  * widget;
        CTX * ctx;
        int   count = 0;

        Newx( ctx, 1, CTX );
        ctx->cp_ctx    = this;
        ctx->cp_cls    = this->_class;

        {
            widget = newSV( 0 );
            sv_setref_pv( widget, object2package( ctx ), ( void* )ctx );
        }

        int result = 0;

        ENTER;
        SAVETMPS;

        PUSHMARK( SP );

        XPUSHs( widget );
        mXPUSHi( e );

        PUTBACK;

        count = call_method( "handle", G_SCALAR );

        SPAGAIN;

        if ( SvTRUE( ERRSV ) || count != 1 )
            /* if threads not loaded or an error occurs return 0 */
            result = 0;
        else
            result = POPi;

        PUTBACK;
        FREETMPS;
        LEAVE;

        return result ? result : this->T::handle( e );
    };

};

const char * object2package ( WidgetSubclass<Fl_Widget> * w );

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

        //warn ("%s->trigger()", object2package(w));

        SV * widget;
        CTX * ctx;
        Newx( ctx, 1, CTX );
        ctx->cp_ctx    = w;
        {
            SV * RETVALSV;
            RETVALSV = sv_newmortal();
            sv_setref_pv( RETVALSV, object2package( w ), ( void* )ctx );
            widget = RETVALSV;
        }

        dSP;
        ENTER;
        SAVETMPS;
        PUSHMARK( SP );

        if ( SvOK( widget ) )
            XPUSHs( widget );

        PUTBACK;

        call_sv( callback, G_DISCARD ); // TODO: Should this be eval?

        SPAGAIN;
        PUTBACK;

        FREETMPS;
        LEAVE;

        return;
    };
};


#endif // #ifndef fltk_pm_h
