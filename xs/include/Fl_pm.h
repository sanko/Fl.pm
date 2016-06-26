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
            T::draw();
            //warn( "%s->draw( TRUE )", object2package( this ) );
        };
        int handle( bool only, int event ) {
            return T::handle( event );
        };
    private:
        void draw( ) {
            dTHX;
            call_perl_method( "draw", NULL, G_DISCARD );
        };
        int handle( int e ) {
            dTHX;
            return call_perl_method( "handle", newSViv( e ) );
        };

        int call_perl_method( const char * method, SV * args, int context = G_SCALAR ) {
            dTHX;
            dSP;
            SV  * widget;
            CTX * ctx;
            int   count = 0;
            Newx( ctx, 1, CTX );
            ctx->cp_ctx    = this;
            ctx->cp_cls    = this->_class;
            {
                widget = newSV( 1 );
                sv_setref_pv( widget, object2package( ctx ), ( void* )ctx );
            }
            int result = 0;
            ENTER;
            SAVETMPS;
            PUSHMARK( SP );
            XPUSHs( widget );
            if ( args != NULL && SvOK( args ) )
                mXPUSHs( args );
            PUTBACK;
            count = call_method( method, context );
            SPAGAIN;
            if ( count == 1 && context != G_DISCARD )
                /* if threads not loaded or an error occurs return 0 */
                result = POPi;
            PUTBACK;
            FREETMPS;
            LEAVE;
            return result;
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
