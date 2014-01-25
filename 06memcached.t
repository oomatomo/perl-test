#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::Memcached;
use Cache::Memcached::Fast;

my $memd = Test::Memcached->new();

# Memcachedの起動
$memd->start;

# 起動したmemcahedのポートを取得する
my $port = $memd->option('tcp_port');

my $client = Cache::Memcached::Fast->new( { servers => ["127.0.0.1:$port"] } );

subtest 'add memcached' => sub {
  $client->add( 'test', 'test' );
  is( $client->get('test'), 'test', 'add is ok' );
};

subtest 'delete memcached' => sub {
  $client->add( 'test2', 'test2' );
  is( $client->get('test2'), 'test2', 'get is ok' );
  $client->delete('test2');
  is( $client->get('test2'), undef, 'delete is ok' );
};

done_testing();
