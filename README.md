
# NAME

Fltk - Blah, blah, blah...

# SYNOPSIS

    use Fltk qw[:label];
    my $window = Fltk::Window->new(100, 100, 300, 180);
    my $box = Fltk::Box->new(20, 40, 260, 100, 'Hello, World');
    #$box->labelfont(BOLD + ITALIC); # TODO
    $box->labelsize(36);
    #$box->labelfont(SHADOW_LABEL); # TODO
    $window->end();
    $window->show();
    exit Fltk::run();

# DESCRIPTION

Fltk is ...

# LICENSE

Copyright (C) Sanko Robinson.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Sanko Robinson &lt;sanko@cpan.org>
