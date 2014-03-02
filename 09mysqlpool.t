#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::mysqld;
use Test::Fixture::DBI qw/:all/;
use FindBin;

my $dbh = DBI->connect( $ENV{ PERL_TEST_MYSQLPOOL_DSN} );
diag $ENV{ PERL_TEST_MYSQLPOOL_DSN};

my $sth = $dbh->prepare("SELECT partner_id, name FROM partner;");
$sth->execute();
while (my @row = $sth->fetchrow_array) {
  is( $row[1], 'test', 'name is ok');
}

$sth->finish;
$dbh->disconnect();


done_testing();
