#!/usr/bin/env perl
use Test::More;
use Test::mysqld;

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
$dbh->do( "
  CREATE TABLE `partner` (
    `partner_id` INT NOT NULL AUTO_INCREMENT ,
    `name` VARCHAR(45) NOT NULL DEFAULT '',
    PRIMARY KEY (`partner_id`) )
  ENGINE = InnoDB;
" );
$dbh->do( "INSERT INTO `partner` ( `name` ) VALUES ('test1');");
$dbh->do( "INSERT INTO `partner` ( `name` ) VALUES ('test2');");

my $sth = $dbh->prepare("SELECT partner_id, name FROM partner;");
$sth->execute();
while (my @row = $sth->fetchrow_array) {
  diag "id:$row[0] name:$row[1]\n";
}

$sth->finish;
$dbh->disconnect();

ok( 1, 'first test');

done_testing();
