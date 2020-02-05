use strict;
use warnings;
use Fl;
$|++;
my ($helpFlag, $optionString);

=head1

Callback example FLTK's C<examples/howto-parse-args.cxx> which demonstrates the following:

=item * callback function passed to C<Fl::args()> to parse individual argument

=item * If there is a match, C<$i> must be incremented by 2 or 1 as appropriate.

=item * If there is no match, C<Fl::args()> will then call C<Fl::arg()> as fallback to try to match the "standard" FLTK parameters.

=item * Returns 2 if $argv->[$i] matches with required parameter in $argv->[$i],

=item * returns 1 if $argv->[$i] matches on its own,

=item * returns 0 if $argv->[i] does not match.

=cut

sub arg {
    my ($argc, $argv, $i) = @_;
    if (('-h' eq $argv->[$i - 1]) || ('--help' eq $argv->[$i - 1])) {
        $helpFlag = 1;
        $_[2] += 1;
        return 1;
    }
    if ('-o' eq $argv->[$i - 1] || '--option' eq $argv->[$i - 1]) {
        if ($i <= scalar(@$argv) && defined $argv->[$i]) {
            $optionString = $argv->[$i];
            $_[2] += 2;
            return 2;
        }
        warn;
    }
    return 0;
}
my $i = 0;
if (Fl::args(scalar(@ARGV), \@ARGV, $i, \&arg) < scalar(@ARGV)) {

    # note the concatenated strings to give a single format string!
    die sprintf <<'END', $ARGV[$i], $ARGV[0]; }
error: unknown option: %s
usage: %s [options]
    -h | --help     : print extended help message
    -o | --option   : example option with parameter
    plus standard fltk options
END
if ($helpFlag) {
    die sprintf <<'END', $ARGV[0], ''    # TODO: , Fl::help;
usage: %s [options]
    -h | --help     : print extended help message
    -o | --option   : example option with parameter
    plus standard fltk options:
%s
END
}
my $mainWin = Fl::Window->new(300, 200);
my $textBox = Fl::Box->new(0, 0, 300, 200);
$textBox->label(
            $optionString ? $optionString : 're-run with [-o|--option] text');
$mainWin->show(

    #scalar(@ARGV), @ARGV
);
exit Fl::run();
my $pos = 0;
