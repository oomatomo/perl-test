#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::Mock::Guard qw(mock_guard);

subtest '通常のオブジェクトのテスト' => sub {
  is( Sample->new()->get, 'no', 'get message ok' );
};

subtest 'ここの中だけMockを利用する' => sub {
  my $mock = mock_guard(
    'Sample',
    +{get => sub {
        return 'ok';
      },
    }
  );
  is( Sample->new()->get, 'ok', 'get message ok' );
};

done_testing();

package Sample;
sub new { bless {} => shift }
sub get {"no"}
