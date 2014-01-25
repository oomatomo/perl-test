#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

subtest 'first test' => sub {
  ok( 1, 'first test');
};

subtest 'second test' => sub {
  subtest 'second test2' => sub {
    ok( 1, 'second test2');
  };
};

done_testing();
