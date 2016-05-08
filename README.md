[![Build Status](https://travis-ci.org/sanko/Fl.pm.svg?branch=master)](https://travis-ci.org/sanko/Fl.pm)
# NAME

Fl - Bindings for the Stable 1.3.x Branch of the Fast Light Toolkit

# SYNOPSIS

    use Fl qw[:event :label :box :font];
    my $window = Fl::Window->new(100, 100, 300, 180);
    my $box = Fl::Box->new(FL_UP_BOX, 20, 40, 260, 100, 'Hello, World');
    $box->labelfont(FL_BOLD + FL_ITALIC);
    $box->labelsize(36);
    $box->labeltype(FL_SHADOW_LABEL);
    $window->end();
    $window->show();
    exit run();

# DESCRIPTION

The Fl distribution includes bindings to the stable 1.3.x branch of the Fast
Light Toolkit; a cross-platform GUI toolkit compatible with Microsoft Windows,
MacOS X, and Linux/Unix platforms with X11. It was designed to be small, quick
and comes with a very simple yet complete API.

# Exports

The top level Fl namespace exports several functions sorted by type. This list
will grow as the dist develops.

## `:event`

    use Fl qw[:event];

This would import functions related to application execution directly into
your namespace. Please see Fl::Event for a list of these functions and
more.

## `:enum`

    use Fl qw[:enum]; # All Fl::Enumeration values
    use Fl qw[:font]; # Only import enum values related to fonttype

The `:enum` and related tags allow you to import values listed in
Fl::Enumerations.

## `:color`

    use Fl qw[:color]

Static variables and utility functions related to colors may be found in
Fl::Color.

## `:keyboard`

    use Fl qw[:keyboard];

Event and state values for keyboard buttons.

## `:mouse`

    use Fl qw[:mouse];

Event and state values for mouse buttons.

# Classes

Fl contains several widgets and other classes including:

- [Fl::Box](https://metacpan.org/pod/Fl::Box)
- [Fl::Button](https://metacpan.org/pod/Fl::Button)
- [Fl::CheckButton](https://metacpan.org/pod/Fl::CheckButton) - a button with a checkbox
- [Fl::LightButton](https://metacpan.org/pod/Fl::LightButton) - a button with a light to indicate 'on' vs 'off'
- [Fl::Chart](https://metacpan.org/pod/Fl::Chart)
- [Fl::Group](https://metacpan.org/pod/Fl::Group)
- [Fl::Window](https://metacpan.org/pod/Fl::Window)

This is the current list and will expand as the distribution develops.

# LICENSE

Copyright (C) Sanko Robinson.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Sanko Robinson &lt;sanko@cpan.org>
