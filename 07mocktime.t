#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

# Datetimeなどテストで利用する時は
# 必ずTest::MockTimeからuseすること
use Test::MockTime;
use DateTime;

# localtimeを書き換える
Test::MockTime::set_fixed_time( '2013-12-01', '%Y-%m-%d' );

my $now = DateTime->now();
is( $now->year,  2013, 'year ok' );
is( $now->month, 12,   'month ok' );
is( $now->day,   1,    'days ok' );

Test::MockTime::restore_time();

done_testing();
