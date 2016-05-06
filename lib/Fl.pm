package Fl;
use 5.008001;
use strict;
use warnings;
our $VERSION = '0.99.3';
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

Fl contains several widgets and other classes including:

=over

=item L<Fl::Box>

=item L<Fl::Button>

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
