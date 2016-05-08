package Fl;
use 5.008001;
use strict;
use warnings;
our $VERSION = '0.99.5';
use XSLoader;
use vars qw[@EXPORT_OK @EXPORT %EXPORT_TAGS];
use Exporter qw[import];
#
our $NOXS ||= $0 eq __FILE__;    # for testing
XSLoader::load 'Fl', $VERSION
    if !$Fl::NOXS;               # Fills %EXPORT_TAGS on BOOT
#
@EXPORT_OK = sort map { @$_ = sort @$_; @$_ } values %EXPORT_TAGS;
$EXPORT_TAGS{'all'} = \@EXPORT_OK;    # When you want to import everything
@{$EXPORT_TAGS{'style'}}              # Merge these under a single tag
    = sort map { defined $EXPORT_TAGS{$_} ? @{$EXPORT_TAGS{$_}} : () }
    qw[box font label]
    if 1 < scalar keys %EXPORT_TAGS;
@{$EXPORT_TAGS{'enum'}}               # Merge these under a single tag
    = sort map { defined $EXPORT_TAGS{$_} ? @{$EXPORT_TAGS{$_}} : () }
    qw[align box button chart color font keyboard label mouse version when]
    if 1 < scalar keys %EXPORT_TAGS;
@EXPORT    # Export these tags (if prepended w/ ':') or functions by default
    = sort map { m[^:(.+)] ? @{$EXPORT_TAGS{$1}} : $_ } qw[:style :default]
    if 0 && keys %EXPORT_TAGS > 1;
1;
__END__

=pod

=encoding utf-8

=head1 NAME

Fl - Bindings for the Stable 1.3.x Branch of the Fast Light Toolkit

=head1 SYNOPSIS

    use Fl qw[:event :label :box :font];
    my $window = Fl::Window->new(100, 100, 300, 180);
    my $box = Fl::Box->new(FL_UP_BOX, 20, 40, 260, 100, 'Hello, World');
    $box->labelfont(FL_BOLD + FL_ITALIC);
    $box->labelsize(36);
    $box->labeltype(FL_SHADOW_LABEL);
    $window->end();
    $window->show();
    exit run();

=head1 DESCRIPTION

The Fl distribution includes bindings to the stable 1.3.x branch of the Fast
Light Toolkit; a cross-platform GUI toolkit compatible with Microsoft Windows,
MacOS X, and Linux/Unix platforms with X11. It was designed to be small, quick
and comes with a very simple yet complete API.

=head1 Common Widgets and Attributes

Many widgets come with Fl but we'll cover just the basics here.

=head2 Buttons

Fl provides many types of buttons:

=for markdown <center>[http://www.fltk.org/doc-1.3/buttons.png]</center>

=for html <center><img src="http://www.fltk.org/doc-1.3/buttons.png" /></center>

=over

=item L<Fl::Button> - A standard push button

=item L<Fl::CheckButton> - A button with a check box

=item L<Fl::LightButton> - A push buton with a light

=item L<Fl::RepeatButton> - A push button that continues to trigger its callback when held

=item L<Fl::ReturnButton> - A push button that is activated by the Enter key

=item L<Fl::RoundButton> - A button with a radio circle (See also L<Fl::RadioRoundButton>)

=back

The constructor for all of these buttons takes the bounding box of the button
and an optional label string:

    my $fl_btn = Fl::Button->new($x, $y, $width, $height, "label");
    my $fl_lbtn = Fl::LightButton->new($x, $y, $width, $height);
    my $fl_rbtn = Fl::RoundButton->new($x, $y, $width, $height, "label");

Each button has an associated C<type()> which allows it to behave as a push
button, toggle button, or radio button.

    $fl_btn->type(FL_NORMAL_BUTTON);
    $fl_lbtn->type(FL_TOGGLE_BUTTON);
    $fl_rbtn->type(FL_RADIO_BUTTON);

For toggle and radio buttons, the C<value()> method returns the current button
state (0 = off, 1 = on). The C<set()> and C<clear()> methods can be used on
toggle buttons to turn it on or off. Radio buttons can be turned on with the
C<setonly()> method; this will also turn off other radio buttons in the same
group.

=head1 Box Types

=for markdown <center>[http://www.fltk.org/doc-1.3/boxtypes.png]</center>

=for html <center><img src="http://www.fltk.org/doc-1.3/boxtypes.png" /></center>

Widgets are drawn on screen according to their box types. The full list of
these may be found in L<Fl::Enumerations/":box"> and may be imported into your
namespace with the C<:box> tag.

FL_NO_BOX means nothing is drawn at all, so whatever is already on the screen
remains. The FL_..._FRAME types only draw their edges, leaving the interior
unchanged.

=head1 Labels and Label Types

The C<label()>, C<align()>, C<labelfont()>, C<lablesize()>, C<labeltype()>,
C<image()>, and C<deimage()> methods control labeling of widgets.

=head2 C<label()>

The C<label()> method sets the string that is displayed for hte label. Symbols
can be included withthe label string by escaping them with the C<@> symbol.
C<@@> displays a single at symbol.

=for markdown <center>[http://www.fltk.org/doc-1.3/symbols.png]</center>

=for html <center><img src="http://www.fltk.org/doc-1.3/symbols.png" /></center>

The C<@> sign may also be followed by the following optional "formatting"
characters, in this order:

=over

=item '#' forces square scaling, rather than distortion to the widget's shape.

=item +[1-9] or -[1-9] tweaks the scaling a little bigger or smaller.

=item '$' flips the symbol horizontally, '%' flips it vertically.

=item [0-9] - rotates by a multiple of 45 degrees. '5' and '6' do no rotation
while the others point in the direction of that key on a numeric keypad. '0',
followed by four more digits rotates the symbol by that amount in degrees.

=back

Thus, to show a very large arrow pointing downward you would use the label
string "@+92->".

=head2 C<align()>

The C<align()> method positions the label. The following constants are
imported with the C<:align> tag and may be OR'd together as needed:

=over

=item FL_ALIGN_CENTER - center the label in the widget.

=item FL_ALIGN_TOP - align the label at the top of the widget.

=item FL_ALIGN_BOTTOM - align the label at the bottom of the widget.

=item FL_ALIGN_LEFT - align the label to the left of the widget.

=item FL_ALIGN_RIGHT - align the label to the right of the widget.

=item FL_ALIGN_LEFT_TOP - The label appears to the left of the widget, aligned
at the top. Outside labels only.

=item FL_ALIGN_RIGHT_TOP - The label appears to the right of the widget,
aligned at the top. Outside labels only.

=item FL_ALIGN_LEFT_BOTTOM - The label appears to the left of the widget,
aligned at the bottom. Outside labels only.

=item FL_ALIGN_RIGHT_BOTTOM - The label appears to the right of the widget,
aligned at the bottom. Outside labels only.

=item FL_ALIGN_INSIDE - align the label inside the widget.

=item FL_ALIGN_CLIP - clip the label to the widget's bounding box.

=item FL_ALIGN_WRAP - wrap the label text as needed.

=item FL_ALIGN_TEXT_OVER_IMAGE - show the label text over the image.

=item FL_ALIGN_IMAGE_OVER_TEXT - show the label image over the text (default).

=item FL_ALIGN_IMAGE_NEXT_TO_TEXT - The image will appear to the left of the text.

=item FL_ALIGN_TEXT_NEXT_TO_IMAGE - The image will appear to the right of the text.

=item FL_ALIGN_IMAGE_BACKDROP - The image will be used as a background for the widget.

=back

Please see the L<:align|Fl::Enumerations/":align"> tag for more.

=head2 C<labeltype()>

The C<labeltype()> method sets the type of the label. The following standard
label types are included:

=over

=item FL_NORMAL_LABEL - draws the text.

=item FL_NO_LABEL - does nothing.

=item FL_SHADOW_LABEL - draws a drop shadow under the text.

=item FL_ENGRAVED_LABEL - draws edges as though the text is engraved.

=item FL_EMBOSSED_LABEL - draws edges as thought the text is raised.

=item FL_ICON_LABEL - draws the icon associated with the text.

=back

These are imported with the C<:label> tag. Please see
L<Fl::Enumerations|Fl::Enumerations/":label"> for more.

=head1 Callbacks

Callbacks are functions that are called when the value of a widget is changed.
A callback function is sent the widget's pointer and the data you provided.

    sub xyz_callback {
        my ($widget, $data) = @_;
        ...
    }

The C<callback(...)> method sets the callback function for a widget. You can
optionally pass data needed for the callback:

    my $xyz_data = 'Fire Kingdom';
    $button->callback(&xyz_callback, $xyz_data);

You can also pass an anonymous sub to the C<callback(...)> method:

    $button->callback(sub { warn 'Click!' });

Normally, callbacks are performed only when the value of the widget changes.
You can change this using the C<when()|Fl::Widget/when(...)> method:

    $button->when(FL_WHEN_NEVER);
    $button->when(FL_WHEN_CHANGED);
    $button->when(FL_WHEN_RELEASE);
    $button->when(FL_WHEN_RELEASE_ALWAYS);
    $button->when(FL_WHEN_ENTER_KEY);
    $button->when(FL_WHEN_ENTER_KEY_ALWAYS);
    $button->when(FL_WHEN_CHANGED | FL_WHEN_NOT_CHANGED);

These values may be imported with the C<:when> tag. Please see
L<Fl::Enumerations|Fl::Enumerations/":when"> for more.

A word of caution: care has been taken not to tip over when you delete a
widget inside it's own callback but it's still not the best idea so...

    $button->callback(
        sub {
            $button = undef; # Might be okay. Might implode.
        }
    );

Eventually, I'll provide an explicit C<delete_widget()> method that will mark
the widget for deletion when it's safe to do so.

=head1 Shortcuts

Shortcuts are key sequences that activate widgets such as buttons or menu
items. The C<shortcut(...)> method sets the shortcut for a widget:

    $button->shortcut(FL_Enter);
    $button->shortcut(FL_SHIFT + 'b');
    $button->shortcut(FL_CTRL + 'b');
    $button->shortcut(FL_ALT + 'b');
    $button->shortcut(FL_CTRL + FL_ALT + 'b');
    $button->shortcut(0); // no shortcut

The shortcut value is the key event value - the ASCII value or one of the
special keys described in L<Fl::Enumerations|Fl::Enumerations/":keyboard">
combined with any modifiers like Shift, Alt, and Control.

These values may be imported with the C<:keyboard> tag. Please see
L<Fl::Enumerations|Fl::Enumerations/":keyboard"> for an expansive list.

=head1 Other Classes

Fl contains several other widgets and other classes including:

=over

=item L<Fl::Box>

=item L<Fl::Button>

=item L<Fl::CheckButton> - a button with a checkbox

=item L<Fl::LightButton> - a button with a light to indicate 'on' vs 'off'

=item L<Fl::ReturnButton>

=item L<Fl::RepeatButton>

=item L<Fl::RoundButton>

=item L<Fl::RadioButton>

=item L<Fl::RadioRoundButton>

=item L<Fl::RadioLightButton>

=item L<Fl::ToggleButton>

=item L<Fl::Chart>

=item L<Fl::Group>

=item L<Fl::Window>

=back

This is the current list and will expand as the distribution develops.

=for todo http://www.fltk.org/doc-1.3/common.html

=head1 LICENSE

Copyright (C) Sanko Robinson.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Sanko Robinson E<lt>sanko@cpan.orgE<gt>

=cut


