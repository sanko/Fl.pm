use Test2::V0 ':DEFAULT', '!call',
    call => {-as => 'test_call'},
    '!check',
    call => {-as => 'test_check'},
    '!event', event => {-as => 'test_event'};
use Test2::Tools::Subtest qw/subtest_streamed/;
use File::Find qw[find];
use File::Temp;
use lib '../../lib', '../lib', 'lib';
use Fl qw[:all];
$|++;
#
my @classes;
find(sub { push @classes, $File::Find::name if m[.+\.pod$] },
     grep { -d $_ } 'lib', '../lib');    #
@classes = '../lib/Fl.pod';

sub test {
    my ($name, $code) = @_;
    subtest_streamed $name => sub { $code->(); }
}
for my $class (sort @classes) {
    my $package = $class;
    $package =~ s[.+lib[\\/]][]g;
    $package =~ s[[\\/]+][::]g;
    $package =~ s[\.+.+][];
    subtest_streamed $package => sub {
        eval <<"T"; bail_out("$class did not compile: $@") if $@;
use lib '../lib';
sub xs { 1 }
sub class { 1}
sub isa { 1 }
sub export_constant {1 }
sub include { 1 }
sub widget_type { 1 }
require '$class';
T
        use Data::Dump;

        #ddx _get_tests($class);
        #  for _get_tests($class);
        t::Utility::clear_stash($class);
    }
}
#
done_testing();

sub _get_tests {
    my $class = shift;
    no strict 'refs';
    sort grep { $class->can($_) } grep {/^_test_.+/} keys %{$class . '::'};
}
#
package t::Utility;
my %state;
use Test2::V0;
my %stash;    # Don't leak

sub stash {
    my ($package, $filename, $line) = caller;
    my ($key, $data) = @_;
    $stash{$package}{$key} = $data if defined $data;
    $stash{$package}{$key};
}
sub clear_stash { delete $stash{+shift} }
