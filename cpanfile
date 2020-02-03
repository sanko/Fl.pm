requires 'perl', '5.008001';

on 'test' => sub {
    requires 'Test2::V0', '0.98';
    requires 'Test::NeedsDisplay';
	requires 'File::Temp';
	requires 'File::Find';
};

on 'configure' => sub {
    requires 'Alien::FLTK', '1.3.5';
    requires 'Template::Liquid', '1.0.12';
    requires 'Test::NeedsDisplay'; # BINGO's smoker ignores required mods in 'test' metadata
};
