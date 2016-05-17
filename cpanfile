requires 'perl', '5.008001';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

on 'configure' => sub {
    requires 'Alien::FLTK', '1.3.3';
    requires 'Template::Liquid';
};
