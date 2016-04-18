package MBTFLTKBindings;
use strict;
use warnings;
use Exporter 5.57 'import';
our @EXPORT = qw/Build Build_PL/;
use CPAN::Meta;
use ExtUtils::Config 0.003;
use ExtUtils::Helpers 0.020
    qw/make_executable split_like_shell man1_pagename man3_pagename detildefy/;
use ExtUtils::Install qw/pm_to_blib install/;
use ExtUtils::InstallPaths 0.002;
use File::Basename qw/basename dirname/;
use File::Find ();
use File::Path qw/mkpath/;
use File::Spec::Functions qw/catfile catdir rel2abs abs2rel splitdir curdir/;
use Getopt::Long qw/GetOptionsFromArray/;
use JSON::PP 2 qw/encode_json decode_json/;

sub write_file {
    my ($filename, $mode, $content) = @_;
    open my $fh, ">:$mode", $filename or die "Could not open $filename: $!\n";
    print $fh $content;
}

sub read_file {
    my ($filename, $mode) = @_;
    open my $fh, "<:$mode", $filename or die "Could not open $filename: $!\n";
    return do { local $/; <$fh> };
}

sub get_meta {
    my ($metafile) = grep { -e $_ } qw/META.json META.yml/
        or die "No META information provided\n";
    return CPAN::Meta->load_file($metafile);
}

sub manify {
    my ($input_file, $output_file, $section, $opts) = @_;
    return if -e $output_file && -M $input_file <= -M $output_file;
    my $dirname = dirname($output_file);
    mkpath($dirname, $opts->{verbose}) if not -d $dirname;
    require Pod::Man;
    Pod::Man->new(section => $section)
        ->parse_from_file($input_file, $output_file);
    print "Manifying $output_file\n"
        if $opts->{verbose} && $opts->{verbose} > 0;
    return;
}

sub process_xs {
    my ($source, $options) = @_;
    die "Can't build xs files under --pureperl-only\n"
        if $options->{'pureperl-only'};
    my (undef, @parts) = splitdir(dirname($source));
    push @parts, my $file_base = basename($source, '.xs');
    my $archdir = catdir(qw/blib arch auto/, @parts);
    my $tempdir = 'temp';
    my $c_file  = catfile($tempdir, "$file_base.cxx");
    require ExtUtils::ParseXS;
    mkpath($tempdir, $options->{verbose}, oct '755');
    local @ExtUtils::ParseXS::BootCode = ();
    ExtUtils::ParseXS->process_file(filename   => $source,
                                    output     => $c_file,
                                    'C++'      => 1,
                                    hiertype => 1,
                                    #typemap => 'type.map',
                                    prototypes =>1,
                                    linenumbers =>1
    );
    my $version = $options->{meta}->version;
    require ExtUtils::CBuilder;
    my $builder
        = ExtUtils::CBuilder->new(config => $options->{config}->values_set);
    require Alien::FLTK;
    my $AF = Alien::FLTK->new();
    my $ob_file = $builder->compile(
         source  => $c_file,
         defines => {VERSION => qq/"$version"/, XS_VERSION => qq/"$version"/},
         'C++'   => 1,
         include_dirs => [curdir, dirname($source), $AF->include_dirs()],
         extra_compiler_flags => $AF->cxxflags()
    );
    mkpath($archdir, $options->{verbose}, oct '755') unless -d $archdir;
    require DynaLoader;
    my $mod2fname
        = defined &DynaLoader::mod2fname ?
        \&DynaLoader::mod2fname
        : sub { return $_[0][-1] };
    mkpath($archdir, $options->{verbose}, oct '755') unless -d $archdir;
    my $lib_file = catfile($archdir,
              $mod2fname->(\@parts) . '.' . $options->{config}->get('dlext'));
    return
        $builder->link(objects            => $ob_file,
                       lib_file           => $lib_file,
                       extra_linker_flags => '-L'
                           . $AF->library_path . ' '
                           . $AF->ldflags(qw[gl images])
                           . ' -lstdc++',
                       module_name => join '::',
                       @parts
        );
}

sub find {
    my ($pattern, $dir) = @_;
    my @ret;
    File::Find::find(sub { push @ret, $File::Find::name if /$pattern/ && -f },
                     $dir)
        if -d $dir;
    return @ret;
}
my %actions = (
    build => sub {
        my %opt = @_;
        system $^X, $_ and die "$_ returned $?\n" for find(qr/\.PL$/, 'lib');
        my %modules
            = map { $_ => catfile('blib', $_) } find(qr/\.p(?:m|od)$/, 'lib');
        my %scripts = map { $_ => catfile('blib', $_) } find(qr//, 'script');
        my %shared = map {
            $_ => catfile(qw/blib lib auto share dist/,
                          $opt{meta}->name, abs2rel($_, 'share'))
        } find(qr//, 'share');
        pm_to_blib({%modules, %scripts, %shared}, catdir(qw/blib lib auto/));
        make_executable($_) for values %scripts;
        mkpath(catdir(qw/blib arch/), $opt{verbose});
        process_xs($_, \%opt) for find(qr/.xs$/, 'xs');

        if (   $opt{install_paths}->install_destination('libdoc')
            && $opt{install_paths}->is_default_installable('libdoc'))
        {   manify($_,
                   catfile('blib', 'bindoc', man1_pagename($_)),
                   $opt{config}->get('man1ext'), \%opt)
                for keys %scripts;
            manify($_,
                   catfile('blib', 'libdoc', man3_pagename($_)),
                   $opt{config}->get('man3ext'), \%opt)
                for keys %modules;
        }
    },
    test => sub {
        my %opt = @_;
        die "Must run `./Build build` first\n" if not -d 'blib';
        require TAP::Harness;
        my $tester = TAP::Harness->new(
            {verbosity => $opt{verbose},
             lib       => [
                 map {
                     rel2abs(catdir(qw/blib/, $_))
                 } qw/arch lib/
             ],
             color => -t STDOUT
            }
        );
        $tester->runtests(sort +find(qr/\.t$/, 't'))->has_errors and exit 1;
    },
    install => sub {
        my %opt = @_;
        die "Must run `./Build build` first\n" if not -d 'blib';
        install($opt{install_paths}->install_map,
                @opt{qw/verbose dry_run uninst/});
    },
);

sub Build {
    my $action = @ARGV && $ARGV[0] =~ /\A\w+\z/ ? shift @ARGV : 'build';
    die "No such action '$action'\n" if not $actions{$action};
    unshift @ARGV, @{decode_json(read_file('_build_params', 'utf8'))};
    GetOptions(\my %opt,
               qw/install_base=s install_path=s% installdirs=s destdir=s prefix=s config=s% uninst:1 verbose:1 dry_run:1 pureperl-only:1 create_packlist=i/
    );
    $_ = detildefy($_)
        for grep {defined} @opt{qw/install_base destdir prefix/},
        values %{$opt{install_path}};
    @opt{'config', 'meta'}
        = (ExtUtils::Config->new($opt{config}), get_meta());
    $actions{$action}->(
          %opt,
          install_paths =>
              ExtUtils::InstallPaths->new(%opt, dist_name => $opt{meta}->name)
    );
}

sub Build_PL {
    my $meta = get_meta();
    printf "Creating new 'Build' script for '%s' version '%s'\n",
        $meta->name, $meta->version;
    my $dir = $meta->name eq 'MBTFLTKBindings' ? '' : "use lib 'inc';";
    write_file('Build', 'raw',
               "#!perl\n$dir\nuse MBTFLTKBindings;\n\$|++;\nBuild();\n");
    make_executable('Build');
    my @env
        = defined $ENV{PERL_MB_OPT} ?
        split_like_shell($ENV{PERL_MB_OPT})
        : ();
    write_file('_build_params', 'utf8', encode_json([@env, @ARGV]));
    $meta->save(@$_) for ['MYMETA.json'], ['MYMETA.yml' => {version => 1.4}];
}
1;

=head1 SEE ALSO

L<Module::Build::Tiny>

=head1 ORIGINAL AUTHORS

=over 4

=item *

Leon Timmermans <leont@cpan.org>

=item *

David Golden <dagolden@cpan.org>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Leon Timmermans, David Golden.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
