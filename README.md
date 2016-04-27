[![Build Status](https://travis-ci.org/sanko/Fl.pm.svg?branch=master)](https://travis-ci.org/sanko/Fl.pm)
# NAME

Fl - Bindings for the Stable 1.3.x Branch of the Fast Light Toolkit

# SYNOPSIS

    use Fl qw[:execute :label :box :font];
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

# Functions & Exports

The top level Fl namespace exports several functions sorted by type. This list
will grow as the dist develops.

## `:execute`

    use Fl qw[:execute];

This would import functions related to application execution directly into
your namespace. These functions include:

- `run()`

    As long as any windows are displayed, this calles Fl::wait() repeatedly.

    When all windows are closed, it returns zero.

- `check()`

    This is the same as calling `Fl::wait(0)`.

    Calling this during (for example) a long calculation process will keep the
    screen up to date and the interface responsive without forking or threading.

    This returns non-zero if any windws are displayed. Otherwise, zero is
    returned.

- `wait()`

    Waits until 'something happens' and then returns.

    Call this repeatedly to 'run' your program. You can also check what happened
    each time after this returns which is quite useful for managing program state.

    What this really does is call all idle callbacks, all elapsed timeouts, call
    Fl::flush() to get the screen to update, and then wait some time (zero if the
    are idle callbacks, the sortest of all pending timeouts, or infinity) for any
    events from the user or any Fl::ad\_fd() callbacks. It then handles the events
    and calls the callbacks and then returns.

    The return value of Fl::wait() is non-zero if there are any visible windows.

    `Fl::wait($time)` waits a maxium of `$time` seconds. It may return much
    sooner if something happens.

    The return value is positive if an event or fd happens before the time
    elapsed. It is zero if nothing happens (on Windows this will only return zero
    if $time is zero). It is negative if an error occurs (this will happen on X11
    if a signal happens).

- `ready()`

    This is similar to `Fl::check()` except this does not call `Fl::flush()` or
    any callbacks, which is useful if your program is in a state where such
    callbacks are illegal.

    This returns true if `Fl::check()` would do anything (it will continue to
    return true until you call `Fl::check()` or `Fl::wait()`).

## `:enum`

    use Fl qw[:enum]; # All Fl::Enumeration values
    use Fl qw[:font]; # Only import enum values related to fonttype

The `:enum` and related tags allow you to import values listed in
Fl::Enumerations.

# Classes

Fl contains several widgets and other classes including:

- [Fl::Box](https://metacpan.org/pod/Fl::Box)
- [Fl::Group](https://metacpan.org/pod/Fl::Group)
- [Fl::Window](https://metacpan.org/pod/Fl::Window)

This is the current list and will expand as the distribution develops.

# LICENSE

Copyright (C) Sanko Robinson.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Sanko Robinson &lt;sanko@cpan.org>
