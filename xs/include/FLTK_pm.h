#ifndef fltk_pm_h
#define fltk_pm_h

/*

=pod

=for license Artistic License 2.0 | Copyright (C) 2009,2010 by Sanko Robinson

=for author Sanko Robinson <sanko@cpan.org> - http://sankorobinson.com/

=for abstract Global include

=for git $Id$

=cut

*/

#define FLTK_DEBUG 0

#define PERL_NO_GET_CONTEXT 1
#define NO_XSLOCKS // XSUB.h will otherwise override various things we need
//#define NEED_sv_2pv_flags
#define NEED_newSVpvn_flags
#define NO_INIT '\0'



#ifdef __cplusplus
extern "C" {
#endif

#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>

#ifdef __cplusplus
} /* extern "C" */
#endif

#include "ppport.h"

//#include <fltk/../config.h>         // created and installed by Alien::FLTK2

//#include "RectangleSubclass.h"
//#include <fltk/Widget.h>

#define DISABLE_DEPRECATED          // Depreciated widgets, and other junk
#define DISABLE_ASSOCIATIONFUNCTOR  // Requires subclass
#define DISABLE_ASSOCIATIONTYPE     // Requires subclass
#define DISABLE_TEXTBUFFER          // Floating on a sea of bugs

#if !WIN32                          // Disable GL on Win32. I have some thing
#undef HAVE_GL                      // to figure out first
#endif // !WIN32                    // http://www.mail-archive.com/fltk@easysw.com/msg08519.html

#if !HAVE_GL
#define DISABLE_GL       1
#define DISABLE_GLWINDOW 1
#endif

#ifdef DISABLE_DEPRECATED
#define DISABLE_ADJUSTER
#endif // #ifdef DISABLE_DEPRECATED

#ifndef MAX_PATH
#define MAX_PATH 1024
#endif //#ifndef MAX_PATH

//bool _fltk_theme( );

#ifdef WIN32
#include <windows.h>
HINSTANCE dllInstance( );
#endif // #ifdef WIN32

//void register_constant( const char *, SV * );
//void register_constant( const char *, const char *, SV * );

/*
=begin apidoc

=for apidoc Hx|||_cb_w|WIDGET|(void*)CODE|

This is the callback for all widgets. It expects an C<fltk::Widget> object and
the C<CODE> should be an HV* containing data that looks a little like this...
This will eventually replace the AV* based callback system in L<C<_cb_w>>.

  {
    coderef => CV *, # coderef to call
    class   => SV *, # string to (re-)bless WIDGET
    args    => SV *  # optional arguments sent after blessed WIDGET
  }

=cut
*/
//void _cb_w ( fltk::Widget * WIDGET, void * CODE );

/*
=for apidoc H|||_cb_t|(void *) CODE|

This is the generic callback for just about everything. It expects a single
C<(void*) CODE> parameter which should be an AV* holding data that looks a
little like this...

  [
    SV * coderef,
    SV * args  # optional arguments sent along to coderef
  ]

=cut
*/
//void _cb_t ( void * CODE ); // Callbacks for timers, etc.

/*
=for apidoc H|||_cb_u|int position|(void *) CODE|

This is the callback for FLTK::TextDisplay->highlight_data(...). It expects an
C<int> parameter which represents a buffer position and a C<(void*) CODE>
parameter which should be an AV* holding data that looks a little like this...

  [
    SV * coderef,
    SV * args  # optional arguments sent along to coderef
  ]

=cut
*/
//void _cb_u ( int position, void * CODE ); // Callback for TextDisplay->highlight_data( ... )

/*
=for apidoc H|||_cb_f|int fd|(void *) CODE|

This is the callback for FLTK::add_fh(...). It expects an C<int> parameter
which represents a filehandle's fileno and a C<(void*) CODE> parameter which
should be an AV* holding data that looks a little like this...

  [
    SV * coderef,
    SV * args  # optional arguments sent along to coderef
  ]

=cut
*/
//void _cb_f ( int fd, void * CODE ); // Callback for add_fh( ... )

/*
=for apidoc H|||isa|const char * package|const char * parent|

This pushes C<parent> onto C<package>'s C<@ISA> list for inheritance.

=cut
*/
//void isa ( const char * package, const char * parent );

/*
=for apidoc H|||export_tag|const char * what|const char * _tag|

Adds a function to a specific export tag.

=cut
*/
//void export_tag ( const char * what, const char * _tag );

/*
=for TODO This whole magic variable stuff screams "Refactor and rethink me!"

=for apidoc H||I32|magic_ptr_get_int|IV iv|SV * sv|

Gets the value of int-based magical variables.

=for apidoc H||I32|magic_ptr_set_int|IV iv|SV * sv|

Sets the value of int-based magical variables.

=cut
*/
I32 magic_ptr_get_int( pTHX_ IV iv, SV * sv );

I32 magic_ptr_set_int( pTHX_ IV iv, SV * sv );
/*
=for apidoc H||I32|magic_ptr_get_float|IV iv|SV * sv|

Gets the value of float-based magical variables.

=for apidoc H||I32|magic_ptr_set_float|IV iv|SV * sv|

Sets the value of float-based magical variables.

=cut
*/
I32 magic_ptr_get_float ( pTHX_ IV iv, SV * sv );

I32 magic_ptr_set_float ( pTHX_ IV iv, SV * sv );
/*
=for apidoc H||I32|magic_ptr_get_bool|IV iv|SV * sv|

Gets the value of int-based magical variables.

=for apidoc H||I32|magic_ptr_set_bool|IV iv|SV * sv|

Sets the value of int-based magical variables.

=cut
*/
I32 magic_ptr_get_bool ( pTHX_ IV iv, SV * sv );

I32 magic_ptr_set_bool ( pTHX_ IV iv, SV * sv );
/*
=for apidoc H||I32|magic_ptr_get_char_ptr|IV iv|SV * sv|

Gets the value of string-like magical variables.

=for apidoc H||I32|magic_ptr_set_char_ptr|IV iv|SV * sv|

Sets the value of string-like magical variables.

=cut
*/
I32 magic_ptr_get_char_ptr ( pTHX_ IV iv, SV * sv );

I32 magic_ptr_set_char_ptr ( pTHX_ IV iv, SV * sv );
/*
=for apidoc H|||magic_ptr_init|const char * var|void ** ptr|

Creates truly magical variables. (This is effectively a C-level equivalent of
a tied variable).

=cut
*/

void magic_ptr_init( const char * var, int * ptr );

void magic_ptr_init( const char * var, float * ptr );

void magic_ptr_init( const char * var, bool * ptr );

void magic_ptr_init( const char * var, const char ** ptr );

#endif // #ifndef fltk_pm_h
