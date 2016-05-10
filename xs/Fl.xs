#include "include/Fl_pm.h"

HV * Fl_stash,  // For inserting stuff directly into Fl's namespace
   * Fl_export; // For inserting stuff directly into Fl's exports

class Callback {
    public: /* TODO: Make these private */
        SV * callback;
        SV * args;

    public:
        ~Callback() { };
        Callback(SV * cb, SV * as, SV * w) {
            dTHX;
            callback = newSVsv(cb);//sv_mortalcopy(cb);
            args     = newSVsv(as);//sv_mortalcopy(as);
        };
        void trigger(Fl_Widget * w) {
            dTHX;

            int i;

            if (!SvOK(callback))
                return;

            SV * widget;
            widget = sv_newmortal();
            sv_setref_pv( widget, object2package(w), (void*) w );

            dSP;

            ENTER;
            SAVETMPS;
            PUSHMARK(SP);

            if (SvOK(widget))
               XPUSHs(widget);
            if (args != (SV*)NULL)
                XPUSHs(args);

            PUTBACK;

            i = call_sv(callback, G_SCALAR);

            SPAGAIN;

            if (i != 1)
                croak("Callback failed");

            PUTBACK;
            FREETMPS;
            LEAVE;

            return;
        };
};

void register_constant( const char * name, SV * value ) {
    dTHX;
    newCONSTSUB( Fl_stash, name, value );
}

void register_constant( const char * package, const char * name, SV * value ) {
    dTHX;
    HV * _stash  = gv_stashpv( package, TRUE );
    newCONSTSUB( _stash, name, value );
}

void export_function (const char * what, const char * _tag ) {
    dTHX;
    //warn("Exporting %s to %s", what, _tag);
    SV ** tag = hv_fetch( Fl_export, _tag, strlen(_tag), TRUE );
    if (tag && SvOK(* tag) && SvROK(* tag ) && (SvTYPE(SvRV(*tag))) == SVt_PVAV)
        av_push((AV*)SvRV(*tag), newSVpv(what, 0));
    else {
        SV * av;
        av = (SV*) newAV( );
        av_push((AV*)av, newSVpv(what, 0));
        tag = hv_store( Fl_export, _tag, strlen(_tag), newRV_noinc(av), 0 );
    }
}

void export_constant( const char * name, const char * _tag, SV * value ) {
    register_constant(name, value);
    export_function(name, _tag);
}

void set_isa(const char * klass, const char * parent) {
    dTHX;
    HV * parent_stash = gv_stashpv( parent, GV_ADD | GV_ADDMULTI );
    av_push( get_av( form( "%s::ISA", klass ), TRUE ),
             newSVpv( parent, 0 ) );
    // TODO: make this spider up the list and make deeper connections?
}

void _cb_w ( Fl_Widget * widget, void * CODE ) {
    ((Callback * ) CODE)->trigger(widget);
    return;
}

MODULE = Fl        PACKAGE = Fl                 PREFIX = Fl::

PROTOTYPES: DISABLE

BOOT:
    /* Setup! */
    Fl_stash  = gv_stashpv( "Fl", TRUE );
    Fl_export = get_hv( "Fl::EXPORT_TAGS", TRUE );

INCLUDE: ../lib/Fl/Event.pod

INCLUDE: ../lib/Fl/Enumerations.pod

#include <FL/Fl_Widget.H>

MODULE = Fl::Widget        PACKAGE = Fl::Widget         PREFIX = Fl_

PROTOTYPES: DISABLE

=pod

No Fl::Widget->new(...) constructor

=cut

void
Fl_Widget::DESTROY()
    CODE:
        int refcount = SvREFCNT(SvRV(ST(0)));
        if (refcount == 1) {
            delete THIS;
        }
        else {
            SvREFCNT_dec(ST(0));
        }

void
Fl_Widget::set_active()

void
Fl_Widget::set_changed()

void
Fl_Widget::set_output()

void
Fl_Widget::set_visible()

void
Fl_Widget::set_visible_focus()

void
Fl_Widget::redraw_label()

void
Fl_Widget::redraw()

unsigned int
Fl_Widget::active()

unsigned int
Fl_Widget::output()

int
Fl_Widget::active_r()

int
Fl_Widget::visible_r()

int
Fl_Widget::x()

int
Fl_Widget::y()

int
Fl_Widget::w()

int
Fl_Widget::h()

int
Fl_Widget::use_accents_menu()

int
Fl_Widget::test_shortcut()

int
Fl_Widget::take_focus()

void
Fl_Widget::labelfont(Fl_Font font)

void
Fl_Widget::labelsize(int size)

void
Fl_Widget::labeltype(Fl_Labeltype type)

void
Fl_Widget::box(Fl_Boxtype box)

void
Fl_Widget::callback( SV * callback, SV * args = (SV*)NULL )
        C_ARGS: _cb_w, (void *) new Callback( callback, args, ST(0) )

void
Fl_Widget::when(IN_OUTLIST Fl_When i = NO_INIT)
    CODE:
        if (items == 2)
            THIS->when(i);
        if (GIMME_V != G_VOID)
            i = THIS->when(); // Don't bother if called in void context

void
Fl_Widget::type(IN_OUTLIST uchar i = NO_INIT)
    CODE:
        if (items == 2)
            THIS->type(i);
        if (GIMME_V != G_VOID)
            i = THIS->type(); // Don't bother if called in void context




INCLUDE: ../lib/Fl/Group.pod

INCLUDE: ../lib/Fl/Window.pod

INCLUDE: ../lib/Fl/Box.pod

INCLUDE: ../lib/Fl/Button.pod

        INCLUDE: ../lib/Fl/LightButton.pod

        INCLUDE: ../lib/Fl/CheckButton.pod

        INCLUDE: ../lib/Fl/RadioLightButton.pod

        INCLUDE: ../lib/Fl/RoundButton.pod

            INCLUDE: ../lib/Fl/RadioRoundButton.pod

        INCLUDE: ../lib/Fl/RadioButton.pod

        INCLUDE: ../lib/Fl/RepeatButton.pod

        INCLUDE: ../lib/Fl/ReturnButton.pod

        INCLUDE: ../lib/Fl/ToggleButton.pod

INCLUDE: ../lib/Fl/Input.pod

    INCLUDE: ../lib/Fl/FloatInput.pod

    INCLUDE: ../lib/Fl/SecretInput.pod

INCLUDE: ../lib/Fl/Chart.pod

INCLUDE: ../lib/Fl/Color.pod

MODULE = Fl        PACKAGE = Fl

BOOT:
    set_isa("Fl::Group", "Fl::Widget");

    //register_constant( "DAMAGE_PUSHED", newSViv(fltk::DAMAGE_PUSHED));
    //export_function( "DAMAGE_PUSHED", "damage" );
