#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::mysqld;
use Test::Fixture::DBI qw/:all/;
use FindBin;

my $mysqld = Test::mysqld->new(
    my_cnf => {
      'skip-networking' => '', # no TCP socket
    }
  ) or plan skip_all => $Test::mysqld::errstr;

my $dbh = DBI->connect( $mysqld->dsn, 'root', '', {
            AutoCommit => 0,
            PrintError => 1,
            RaiseError => 1,
            mysql_enable_utf8 => 1,
        } );

$dbh->do( "DROP DATABASE `test`" );
$dbh->do( "CREATE DATABASE `test`" );
$dbh->do( "USE `test`");

construct_database(
    dbh      => $dbh,
    database => File::Spec->catfile( $FindBin::Bin, qw/schema.yaml/ ),
);

construct_fixture(
    dbh      => $dbh,
    fixture => File::Spec->catfile( $FindBin::Bin, qw/fixture.yaml/ ),
);

my $sth = $dbh->prepare("SELECT partner_id, name FROM partner;");
$sth->execute();
while (my @row = $sth->fetchrow_array) {
  diag "id:$row[0] name:$row[1]\n";
}

$sth->finish;
$dbh->disconnect();

ok( 1, 'first test');

done_testing();
