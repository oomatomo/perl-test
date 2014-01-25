#!/usr/bin/env perl
use strict;
use warnings;
use DBI;
use FindBin;
use File::Spec;
use Test::More;
use Test::Fixture::DBI::Util;
use DBIx::Inspector;
use Data::Visitor::Callback;
use YAML::Syck qw(DumpFile);

my $dbh = DBI->connect( "dbi:mysql:test:localhost:3306", "", "" );
my $schemafile = File::Spec->catfile( $FindBin::Bin, qw/schema.yaml/ );
Test::Fixture::DBI::Util::make_database_yaml( $dbh, $schemafile );

# AUTO_INCREMENTを無効化する
#my $ra_data = Test::Fixture::DBI::Util::make_database_yaml($dbh, $filename);
#my $v = Data::Visitor::Callback->new(
#  hash => sub {
#    return $_ unless $_->{data};
#    $_->{data} =~ s{AUTO_INCREMENT=\d+}{AUTO_INCREMENT=0};
#    return $_;
#  }
#);
#$v->visit($ra_data);
#DumpFile( $filename, $ra_data );

# Create Fixture
my $fixturefile = File::Spec->catfile( $FindBin::Bin, qw/fixture.yaml/ );
my $inspector = DBIx::Inspector->new( dbh => $dbh );
my @data;
my %skip_tables;
foreach my $table_info ( $inspector->tables ) {
  my $table = $table_info->name;
  next if $skip_tables{$table};

  my @col_name = map { $_->name } $table_info->columns;
  my %cols;
  @cols{@col_name} = (1) x @col_name;
  # timestampの処理
  #foreach my $col (qw(created_at created_on updated_at updated_on)) {
  #  delete $cols{$col} if exists $cols{$col};
  #}
  my $sql = "SELECT " . join( ',', keys %cols ) . " FROM $table;";
  my $ra_data
      = Test::Fixture::DBI::Util::make_fixture_yaml( $dbh, $table, [ keys %cols ], $sql );
  push @data, @$ra_data;
}
DumpFile( $fixturefile, \@data );
1;
