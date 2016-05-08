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

# Common Widgets and Attributes

Many widgets come with Fl but we'll cover just the basics here.

## Buttons

Fl provides many types of buttons:

<center>[http://www.fltk.org/doc-1.3/buttons.png]</center>

<div>
    <center><img src="http://www.fltk.org/doc-1.3/buttons.png" /></center>
</div>

- [Fl::Button](https://metacpan.org/pod/Fl::Button) - A standard push button
- [Fl::CheckButton](https://metacpan.org/pod/Fl::CheckButton) - A button with a check box
- [Fl::LightButton](https://metacpan.org/pod/Fl::LightButton) - A push buton with a light
- [Fl::RepeatButton](https://metacpan.org/pod/Fl::RepeatButton) - A push button that continues to trigger its callback when held
- [Fl::ReturnButton](https://metacpan.org/pod/Fl::ReturnButton) - A push button that is activated by the Enter key
- [Fl::RoundButton](https://metacpan.org/pod/Fl::RoundButton) - A button with a radio circle (See also [Fl::RadioRoundButton](https://metacpan.org/pod/Fl::RadioRoundButton))

The constructor for all of these buttons takes the bounding box of the button
and an optional label string:

    my $fl_btn = Fl::Button->new($x, $y, $width, $height, "label");
    my $fl_lbtn = Fl::LightButton->new($x, $y, $width, $height);
    my $fl_rbtn = Fl::RoundButton->new($x, $y, $width, $height, "label");

Each button has an associated `type()` which allows it to behave as a push
button, toggle button, or radio button.

    $fl_btn->type(FL_NORMAL_BUTTON);
    $fl_lbtn->type(FL_TOGGLE_BUTTON);
    $fl_rbtn->type(FL_RADIO_BUTTON);

For toggle and radio buttons, the `value()` method returns the current button
state (0 = off, 1 = on). The `set()` and `clear()` methods can be used on
toggle buttons to turn it on or off. Radio buttons can be turned on with the
`setonly()` method; this will also turn off other radio buttons in the same
group.

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

Fl contains several other widgets and other classes including:

- [Fl::Box](https://metacpan.org/pod/Fl::Box)
- [Fl::Button](https://metacpan.org/pod/Fl::Button)
- [Fl::CheckButton](https://metacpan.org/pod/Fl::CheckButton) - a button with a checkbox
- [Fl::LightButton](https://metacpan.org/pod/Fl::LightButton) - a button with a light to indicate 'on' vs 'off'
- [Fl::ReturnButton](https://metacpan.org/pod/Fl::ReturnButton)
- [Fl::RepeatButton](https://metacpan.org/pod/Fl::RepeatButton)
- [Fl::RoundButton](https://metacpan.org/pod/Fl::RoundButton)
- [Fl::RadioButton](https://metacpan.org/pod/Fl::RadioButton)
- [Fl::RadioRoundButton](https://metacpan.org/pod/Fl::RadioRoundButton)
- [Fl::RadioLightButton](https://metacpan.org/pod/Fl::RadioLightButton)
- [Fl::ToggleButton](https://metacpan.org/pod/Fl::ToggleButton)
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
