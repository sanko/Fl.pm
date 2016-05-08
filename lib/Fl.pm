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
    qw[box button chart color font keyboard label mouse version when]
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

=head1 Exports

The top level Fl namespace exports several functions sorted by type. This list
will grow as the dist develops.

=head2 C<:event>

    use Fl qw[:event];

This would import functions related to application execution directly into
your namespace. Please see Fl::Event for a list of these functions and
more.

=head2 C<:enum>

    use Fl qw[:enum]; # All Fl::Enumeration values
    use Fl qw[:font]; # Only import enum values related to fonttype

The C<:enum> and related tags allow you to import values listed in
Fl::Enumerations.

=head2 C<:color>

    use Fl qw[:color]

Static variables and utility functions related to colors may be found in
Fl::Color.

=head2 C<:keyboard>

    use Fl qw[:keyboard];

Event and state values for keyboard buttons.

=head2 C<:mouse>

    use Fl qw[:mouse];

Event and state values for mouse buttons.

=head1 Classes

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

=head1 LICENSE

Copyright (C) Sanko Robinson.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Sanko Robinson E<lt>sanko@cpan.orgE<gt>

=cut
