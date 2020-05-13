use strict;
use warnings;
use Test::More qw( no_plan );

use InfluxDB::Client::Simple;
my $m = 'test';
my %tags = (a_tag => 1, c_tag => 2, b_tag => 3);
my %fields = ( a_val => 1, c_val => "toto", b_val => 1.3);

is(InfluxDB::Client::Simple::_line_protocol($m, \%tags, \%fields), 'test,a_tag=1,b_tag=3,c_tag=2 a_val=1i,b_val=1.3,c_val="toto"');

$tags{ignored} = undef;
is(InfluxDB::Client::Simple::_line_protocol($m, \%tags, \%fields), 'test,a_tag=1,b_tag=3,c_tag=2 a_val=1i,b_val=1.3,c_val="toto"');

$fields{notignored} = undef;
is(InfluxDB::Client::Simple::_line_protocol($m, \%tags, \%fields), 'test,a_tag=1,b_tag=3,c_tag=2 a_val=1i,b_val=1.3,c_val="toto",notignored=""');

is(InfluxDB::Client::Simple::_line_protocol($m, { %tags, b_tag=>0 }, \%fields), 'test,a_tag=1,b_tag=0,c_tag=2 a_val=1i,b_val=1.3,c_val="toto",notignored=""');
done_testing()
