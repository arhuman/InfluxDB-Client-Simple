use strict;
use warnings;
use Test::Warnings ':all';
use Test::More qw( no_plan );

our $class;

BEGIN { $class = 'InfluxDB::Client::Simple'; use_ok $class }

can_ok $class, 'new';

my $client;

eval { $client = $class->new };
ok(!$@, " $class can create default instance\n$@");

like (warnings {$ client = $class->new}, qr//, " $class produce no warnings");
isa_ok $client, $class;
