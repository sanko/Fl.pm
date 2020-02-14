use Test2::V0 ':DEFAULT', '!call',
    call => {-as => 'test_call'},
    '!check',
    call => {-as => 'test_check'},
    '!event', event => {-as => 'test_event'};
use Test2::Tools::Subtest qw/subtest_streamed/;
use lib '../../lib', '../lib', 'lib';
use Fl qw[:all];
eval 'use Test::Valgrind';
plan skip_all => 'Test::Valgrind is required to test your distribution with valgrind' if $@;
leaky();
