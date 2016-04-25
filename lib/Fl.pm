package Fl;
use 5.008001;
use strict;
use warnings;
our $VERSION = '0.99.00';
use XSLoader;
use vars qw[@EXPORT_OK @EXPORT %EXPORT_TAGS];
use Exporter qw[import];
#
our $NOXS ||= $0 eq __FILE__;    # for testing
XSLoader::load 'Fl', $VERSION
    if !$Fl::NOXS
    ;                            # Fills %EXPORT_TAGS on BOOT
#
@EXPORT_OK = sort map { @$_ = sort @$_; @$_ } values %EXPORT_TAGS;
$EXPORT_TAGS{'all'} = \@EXPORT_OK;    # When you want to import everything
@{$EXPORT_TAGS{'style'}}              # Merge these under a single tag
    = sort map { defined $EXPORT_TAGS{$_} ? @{$EXPORT_TAGS{$_}} : () }
    qw[box font label]
    if 1 < scalar keys %EXPORT_TAGS;
@EXPORT    # Export these tags (if prepended w/ ':') or functions by default
    = sort map { m[^:(.+)] ? @{$EXPORT_TAGS{$1}} : $_ } qw[:style :default]
    if 0 && keys %EXPORT_TAGS > 1;

1;
__END__

=encoding utf-8

=head1 NAME

Fl - Bindings for the Stable 1.3.x Branch of the Fast Light Toolkit

=head1 SYNOPSIS

    use Fl qw[:label];
    my $window = Fl::Window->new(100, 100, 300, 180);
    my $box = Fl::Box->new(20, 40, 260, 100, 'Hello, World');
    #$box->labelfont(BOLD + ITALIC); # TODO
    $box->labelsize(36);
    #$box->labelfont(SHADOW_LABEL); # TODO
    $window->end();
    $window->show();
    exit Fl::run();

=head1 DESCRIPTION

The Fl distribution includes bindings to the stable 1.3.x branch of the Fast
Light Toolkit or FLTK. FLTK is a cross-platform GUI toolkit compatible with
Microsoft Windows, MacOS X, and Linux/Unix platforms with X11. FLTK was
designed to be small and comes with a very simple API.

=head1 LICENSE

Copyright (C) Sanko Robinson.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Sanko Robinson E<lt>sanko@cpan.orgE<gt>

=cut

