package Fltk;
use 5.008001;
use strict;
use warnings;
use XSLoader;
use Exporter 5.57 'import';
our $VERSION     = '0.99.00';
our %EXPORT_TAGS = ('all' => []);
our @EXPORT_OK   = (@{$EXPORT_TAGS{'all'}});
XSLoader::load('FLTK', $VERSION);

sub dl_load_flags {0} # Prevent DynaLoader from complaining and croaking

1;
__END__

=encoding utf-8

=head1 NAME

Fltk - Blah, blah, blah...

=head1 SYNOPSIS

    use Fltk qw[:label];
    my $window = Fltk::Window->new(100, 100, 300, 180);
    my $box = Fltk::Box->new(20, 40, 260, 100, 'Hello, World');
    #$box->labelfont(BOLD + ITALIC); # TODO
    $box->labelsize(36);
    #$box->labelfont(SHADOW_LABEL); # TODO
    $window->end();
    $window->show();
    exit Fltk::run();

=head1 DESCRIPTION

Fltk is ...

=head1 LICENSE

Copyright (C) Sanko Robinson.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Sanko Robinson E<lt>sanko@cpan.orgE<gt>

=cut

