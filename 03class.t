#!/usr/bin/env perl

Test::Tomo->runtests;

# 以下テストクラス
package Test::Tomo;
use parent qw(Test::Class);
use Test::More;

sub startup : Test(startup) {
  diag "start upですよ";
  diag "1回しか呼ばれないはず";
}

sub setup : Test(setup) {
  diag "set upですよ";
}

# okなどのテストメソッドが一つの場合はTest
sub push : Test {
  diag "push できた？";
  ok( 1, "ok" );
}

# okなどのテストメソッドが複数の場合はTests もしくは
# Test(3) <= メソッドの数
sub pop : Tests {
  diag "pop できた？";
  ok( 1, "ok" );
  ok( 1, "ok" );
  ok( 1, "ok" );
}

sub shift : Tests {
  diag "shift できた？";
  ok( 1, "ok" );
  ok( 1, "ok" );
}

sub teardown : Test(teardown) {
  diag "後処理";
}

sub shutdown : Test(shutdown) {
  diag "shutdownですよ";
  diag "1回しか呼ばれないはず";
}
