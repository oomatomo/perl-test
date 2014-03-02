package Test::DB;

use strict;
use warnings;
use DBI;

sub prepare {
  my ( $self, $mysqld ) = @_;

  my $dbh = DBI->connect( $mysqld->dsn);

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
  $dbh->do( "INSERT INTO `partner` ( `name` ) VALUES ('test');");
  $dbh->do( "INSERT INTO `partner` ( `name` ) VALUES ('test');");
  return;
}

1;
