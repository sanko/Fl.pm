package FLTK;
use 5.008001;
use strict;
use warnings;
our $VERSION = '0.99.00';
use XSLoader;
use vars qw[@EXPORT_OK @EXPORT %EXPORT_TAGS];
use Exporter qw[import];
#
our $NOXS ||= $0 eq __FILE__;    # for testing
XSLoader::load 'FLTK', $VERSION

    #if !$FLTK::NOXS
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

#sub dl_load_flags {0} # Prevent DynaLoader from complaining and croaking
1;
__END__

=encoding utf-8

=head1 NAME

FLTK - Blah, blah, blah...

=head1 SYNOPSIS

    use FLTK qw[:label];
    my $window = FLTK::Window->new(100, 100, 300, 180);
    my $box = FLTK::Box->new(20, 40, 260, 100, 'Hello, World');
    #$box->labelfont(BOLD + ITALIC); # TODO
    $box->labelsize(36);
    #$box->labelfont(SHADOW_LABEL); # TODO
    $window->end();
    $window->show();
    exit FLTK::run();

=head1 DESCRIPTION

FLTK is ...

=head1 LICENSE

Copyright (C) Sanko Robinson.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Sanko Robinson E<lt>sanko@cpan.orgE<gt>

=cut

