[![Build Status](https://travis-ci.org/sanko/Fltk.pm.svg?branch=master)](https://travis-ci.org/sanko/Fltk.pm)
# NAME

Fl - Bindings for the Stable 1.3.x Branch of the Fast Light Toolkit

# SYNOPSIS

    use Fl qw[:label];
    my $window = Fl::Window->new(100, 100, 300, 180);
    my $box = Fl::Box->new(20, 40, 260, 100, 'Hello, World');
    #$box->labelfont(BOLD + ITALIC); # TODO
    $box->labelsize(36);
    #$box->labelfont(SHADOW_LABEL); # TODO
    $window->end();
    $window->show();
    exit Fl::run();

# DESCRIPTION

The Fl distribution includes bindings to the stable 1.3.x branch of the Fast
Light Toolkit or FLTK. FLTK is a cross-platform GUI toolkit compatible with
Microsoft Windows, MacOS X, and Linux/Unix platforms with X11. FLTK was
designed to be small and comes with a very simple API.

# LICENSE

Copyright (C) Sanko Robinson.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Sanko Robinson &lt;sanko@cpan.org>
